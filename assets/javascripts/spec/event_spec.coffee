describe 'events', ->
  # describe 'an event adding a repository', ->
  #   beforeEach ->
  #     app ''
  #     waitFor jobsRendered

  #   it 'adds a repository to the list', ->
  #     app ''
  #     waitFor reposRendered
  #
  #     Em.run ->
  #       Travis.app.receive 'build:created',
  #         repository:
  #           id: 10
  #           slug: 'travis-ci/travis-support'
  #           last_build_id: 10
  #           last_build_number: 10
  #           last_build_started_at: '2012-07-02T00:02:00Z'
  #         build:
  #           id: 10
  #           repository_id: 10

  #     listsRepo
  #       row: 4
  #       item: { slug: 'travis-ci/travis-support',  build: { number: 4, url: '#!/travis-ci/travis-support/builds/10', duration: '1 min', finishedAt: '-' } }

  # describe 'an event adding a build', ->
  #   beforeEach ->
  #     app '#!/travis-ci/travis-core/builds'
  #     waitFor buildsRendered

  #   it 'adds a build to the builds list', ->
  #     Em.run ->
  #       Travis.app.receive 'build:finished',
  #         build:
  #           id: 10
  #           repository_id: 1
  #           commit_id: 10
  #           number: '3'
  #           duration: 55
  #           started_at: '2012-07-02T00:02:00Z'
  #           finished_at: '2012-07-02T00:02:55Z'
  #           event_type: 'push'
  #           result: 1
  #         commit:
  #           id: 10
  #           sha: '1234567'
  #           branch: 'master'
  #           message: 'commit message 3'

  #     listsBuild
  #       row: 3
  #       item: { id: 10, slug: 'travis-ci/travis-core', number: '3', sha: '1234567', branch: 'master', message: 'commit message 3', finishedAt: 'less than a minute ago', duration: '55 sec', color: 'red' }

  # describe 'an event adding a job', ->
  #   beforeEach ->
  #     app ''
  #     waitFor jobsRendered
  #     waitFor queuesRendered

  #   it 'adds a job to the jobs matrix', ->
  #     Em.run ->
  #       Travis.app.receive 'job:created',
  #         job:
  #           id: 10
  #           repository_id: 1
  #           build_id: 1
  #           commit_id: 1
  #           log_id: 1
  #           number: '1.4'
  #           duration: 55
  #           started_at: '2012-07-02T00:02:00Z'
  #           finished_at: '2012-07-02T00:02:55Z'
  #           config: { rvm: 'jruby' }

  #     listsJob
  #       table: '#jobs'
  #       row: 3
  #       item: { id: 10, number: '1.4', repo: 'travis-ci/travis-core', finishedAt: 'less than a minute ago', duration: '55 sec', rvm: 'jruby' }

  #   it 'adds a job to the jobs queue', ->
  #     Em.run ->
  #       Travis.app.receive 'job:created',
  #         job:
  #           id: 10
  #           repository_id: 1
  #           number: '1.4'
  #           queue: 'common'

  #     listsQueuedJob
  #       name: 'common'
  #       row: 3
  #       item: { number: '1.4', repo: 'travis-ci/travis-core' }

  describe 'an event adding a worker', ->
    beforeEach ->
      app ''
      waitFor workersRendered

    it 'adds a worker to the workers list', ->
      Em.run ->
        Travis.app.receive 'worker:added',
          worker:
            id: 10

      listsWorker
        group: 'workers.travis-ci.org'
        row: 3
        item: { 'ruby-3' }
