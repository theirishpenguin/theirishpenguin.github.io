before do
    cache_control :public, :max_age => 31557600
end

get '/' do
    send_file(File.join(settings.public_folder, 'index.html'), :disposition => nil)
end


# Match a non-html URL:
#    yyyy/mm/dd date capture
#    blog post title capture
#    an optional trailing slash (not captured)
#    ensure it does not end with html
#
get %r{/(\d\d\d\d\/\d\d\/\d\d)\/(.*)(?<!\.html)} do |date, title|

   #TODO: Improve me to redirect to page
   if request.host == 'blogmat-theirishpenguin.rhcloud.com'
      redirect 'http://www.theirishpenguin.com/', 302
   else
       title.chomp! '/' # Remove trailing slash if present

       html_url = "#{date}/#{title}.html"

       # Only redirect if blog post exists on disk
       # (to avoid infinite redirect)
       if File.exist?("./public/#{html_url}")
           redirect html_url, 301
       else
           redirect '404.html', 302
       end
   end
end


get '/*' do
    send_file(File.join(settings.public_folder, params[:splat]), :disposition => nil)
end
