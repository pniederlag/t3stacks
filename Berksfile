source "https://api.berkshelf.com"

#metadata
cookbook 'apt'
cookbook 'nginx'
cookbook 'openssl'
cookbook 'runit', '~>1.5'
cookbook 'mysql', '~>3.0'
cookbook 'php', github: 'TYPO3-Cookbooks/php'
cookbook "t3-chef-vault", github: "TYPO3-cookbooks/t3-chef-vault"
cookbook 'redmine', github: 'TYPO3-Cookbooks/redmine', branch: 'petern'
cookbook 'ssl_certificates', github: 'TYPO3-Cookbooks/ssl_certificates'
cookbook 'gerrit', github: 'TYPO3-Cookbooks/gerrit', branch: 'refactoring'
cookbook 'site-forgetypo3org', github: 'TYPO3-Cookbooks/site-forgetypo3org', branch: 'develop'
cookbook 'site-docstypo3org', github: 'TYPO3-Cookbooks/site-docstypo3org', branch: 'develop'
cookbook 'site-mqtypo3org', github: 'TYPO3-Cookbooks/site-mqtypo3org', branch: 'master'

group :private do
    cookbook 't3-gerrit', git: 'ssh://review.typo3.org/Teams/Server/Chef.git', branch: 'feature/t3-gerrit-replication', rel: 'site-cookbooks/t3-gerrit', group: 'private'
    cookbook 'site-reviewtypo3org', github: 'TYPO3-Cookbooks/site-reviewtypo3org', branch: 'develop'
end
