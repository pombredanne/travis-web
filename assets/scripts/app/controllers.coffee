require 'helpers'
require 'travis/ticker'

Travis.Controller    = Em.Controller.extend()
Travis.TopController = Em.Controller.extend
  needs: ['currentUser']
  userBinding: 'controllers.currentUser'

Travis.ApplicationController = Em.Controller.extend
  templateName: 'layouts/home'

  connectLayout: (name) ->
    name = "layouts/#{name}"
    if @get('templateName') != name
      @set('templateName', name)

Travis.MainController = Em.Controller.extend()
Travis.StatsLayoutController = Em.Controller.extend()
Travis.ProfileLayoutController = Em.Controller.extend()
Travis.AuthLayoutController = Em.Controller.extend()

Travis.AccountProfileController = Em.Controller.extend
  needs: ['currentUser']
  userBinding: 'controllers.currentUser'

Travis.BuildNotFoundController = Em.Controller.extend
  needs: ['repo', 'currentUser']
  ownedAndActive: (->
    if permissions = @get('controllers.currentUser.permissions')
      if repo = @get('controllers.repo.repo')
        repo.get('active') && permissions.contains(parseInt(repo.get('id')))
  ).property('controllers.repo.repo', 'controllers.currentUser.permissions')

require 'controllers/accounts'
require 'controllers/build'
require 'controllers/builds'
require 'controllers/flash'
require 'controllers/home'
require 'controllers/job'
require 'controllers/profile'
require 'controllers/repos'
require 'controllers/repo'
require 'controllers/running_jobs'
require 'controllers/sidebar'
require 'controllers/stats'
require 'controllers/current_user'
require 'controllers/account_index'

