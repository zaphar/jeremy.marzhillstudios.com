(use 'com.marzhillstudios.molehill.template)
(use 'com.marzhillstudios.molehill.config)
(use 'net.cgrand.enlive-html)
(use '[com.marzhillstudios.molehill.file :only [is-hill-file? hill-file-slug]])
(use '[clojure.contrib.duck-streams :only [file-str]])

(def my-page-resource (file-str "_tmpl/page.html"))
(def my-feed-resource (file-str "_tmpl/feed.rss"))

;TODO(jwall): strip the site-root from the paths on these resources
(def my-css-resources (cons (file-str (:site-root *site-config*) "/static/styles/shThemeDefault.css")
  (cons (file-str (:site-root *site-config*) "/static/styles/shCore.css")
    (filter #(= (take-last 3 (.toString %1)) '(\c \s \s))
      (file-seq (file-str (:site-root *site-config*) "/static/css"))))))
(def my-js-brushes
  (filter #(= (take-last 2 (.toString %1)) '(\j \s))
    (file-seq (file-str (:site-root *site-config*) "/static/brushes"))))
(def my-js-syntax-core-resources  (vector (file-str (:site-root *site-config*)
  "/static/scripts/shCore.js")))
(def my-js-resources (concat my-js-syntax-core-resources my-js-brushes))

(defn create-tag-link
  [tag]
  (cond
    (isa? (type tag) clojure.lang.IPersistentVector)
      (format "<a class='%s' href='%s'>%s</a>"
              (str "tagsize" (nth tag 2))
              (str "/" (nth tag 1) "/")
              (nth tag 1))
    :else
      (format "<a class='%s' href='%s'>%s</a>"
              (str "tagsize" 1)
              (str "/" tag "/")
              tag)))

(defn create-tag-links
  [tags]
  (for [tag tags]
    (create-tag-link tag)))

(defn- do-tags
  [tags]
    (html-snippet (apply str (mapcat #(str % " ") (create-tag-links tags)))))

(defn do-tags-append
  [tags]
    (append (do-tags tags)))

(defn- do-tags-content
  [tags]
    (content (do-tags tags)))

(defn create-post-link
  [post]
  (format "<a href='%s'>%s</a>"
          (str "/"  "/")
          (nth post 1))
          post)

(defn mk-link
  [txt href]
  (html-snippet (format "<a href='%s'>%s</a>" href txt)))

(defn do-posts
  [posts]
    (clone-for [post (take 5 posts)]
          [:h1] (content (mk-link (:title post)
                                  (str "/entries/" (hill-file-slug post) "/")))
          [:div.datetime :span.post-time] (content (:date (:date post)))
          [:div.post-body] (html-content ((:parsed-content post)))
          [:div.tags] (do-tags-append (:tags post))))

(defn do-feed-items
  [posts]
    (clone-for [post posts]
          [:title] (content (:title post))
          [:link] (content (str "/entries/" (hill-file-slug post) "/"))
          [:category] (do-tags-append (:tags post))
          [:description] (html-content ((:parsed-content post)))
          [:pubDate] (html-content (:date (:date post)))))

(defn strip-site-root
  [config res]
  (apply str (drop (count (:site-root config)) res)))

(defn do-links
  [resources res-type res-media res-rel]
  (clone-for [res resources]
             (set-attr :href (strip-site-root *site-config* (.toString res))
                       :type res-type :media res-media :rel res-rel)))

(defn do-scripts
  [resources res-type]
  (clone-for [res resources]
             (set-attr :src (strip-site-root *site-config* (.toString res)) :type res-type)))

(deftemplate my-entry-page my-page-resource [state]
             [:head :title] (content (str (:site-name state) "-"
                                          (:title (first (:entries state)))))
             [:head :script] (do-scripts my-js-resources "text/javascript") 
             [:head [:link (attr= :type "text/css")]]
                (do-links my-css-resources "text/css" "screen" "stylesheet") 
             [:div#topbar :h1#title] (content (mk-link (str (:site-name state)) "/"))
             [:div#content :div.post] (do-posts (:entries state))
             ; TODO(jwall): add link to molehill site.
             [:div#powered-by] (content "Powered By molehill"))

(deftemplate my-index-page my-page-resource [state]
             [:head :title] (content (str (:site-name state)))
             [:head :script] (do-scripts my-js-resources "text/javascript") 
             [:head [:link (attr= :type "text/css")]]
                (do-links my-css-resources "text/css" "screen" "stylesheet") 
             [:div#topbar :h1#title] (content (mk-link (str (:site-name state))
                                                       "/"))
             [:div#content :div.post] (do-posts (:entries state))
             ; TODO(jwall): add link to molehill site.
             [:div#powered-by] (content "Powered By molehill"))

(deftemplate my-feed-page my-feed-resource [state]
             [:channel :title] (content (str (:site-name state)))
             ; TODO(jwall): should this be in the config?
             [:channel :description] (content (str ""))
             [:channel :copyright] (content (str ""))
             [:channel :language] (content (str "en-us"))
             [:channel :lastBuildDate] (content (str ""))
             [:channel :webMaster] (content (str ""))
             [:channel :generator] (content (str "molehill-0.0.1"))
             [:item] (do-feed-items (:entries state))
             ; TODO(jwall): add link to molehill site.
             [:div#powered-by] (content "Powered By molehill"))

(deftemplate my-tag-landing-page my-page-resource [state]
             [:head :title] (content (str (:site-name state)))
             [:head :script] (do-scripts my-js-resources "text/javascript") 
             [:head [:link (attr= :type "text/css")]]
                (do-links my-css-resources "text/css" "screen" "stylesheet") 
             [:div#topbar :h1#title] (content (mk-link (str (:site-name state))
                                                       "/"))
             [:div#content :div.post] (do-posts (:entries state))
             ; TODO(jwall): add link to molehill site.
             [:div#powered-by] (content "Powered By molehill"))

(deftemplate my-tag-page my-page-resource [state]
             [:head :title] (content (str (:site-name state)))
             [:head :script] (do-scripts my-js-resources "text/javascript") 
             [:head [:link (attr= :type "text/css")]]
                (do-links my-css-resources "text/css" "screen" "stylesheet") 
             [:div#topbar :h1#title] (content (mk-link (str (:site-name state))
                                                       "/"))
             [:div#content :div.post] (do-tags-content (:entries state))
             ; TODO(jwall): add link to molehill site.
             [:div#powered-by] (content "Powered By molehill"))

(hill-page :index-tmpl index-state
               (apply str (my-index-page index-state)))

(hill-page :feed-tmpl index-state
               (apply str (my-feed-page index-state)))

(hill-page :tag-tmpl index-state
               (apply str (my-tag-page index-state)))

(hill-page :tag-landing-tmpl index-state
               (apply str (my-tag-landing-page index-state)))

(hill-page :entry-tmpl index-state
               (apply str (my-entry-page index-state)))

