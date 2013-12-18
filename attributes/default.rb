default[:monit][:source]                   = 'package'
default[:monit][:installer][:base]         = 'https://str.cloudn-service.com/files.udcp.info/monit/'
default[:monit][:installer][:filename_deb] = 'monit_5.5-6_amd64.deb'
default[:monit][:installer][:filename_rpm] = 'monit-5.5-1.el6.rf.x86_64.rpm'

default[:monit][:poll_period]           = '60'
default[:monit][:poll_delay]            = '20'
default[:monit][:idfile]                = '/var/lib/monit/id'
default[:monit][:statefile]             = '/var/lib/monit/state'
default[:monit][:eventqueue_basedir]    = '/var/lib/monit/events'
default[:monit][:eventqueue_slots]      = '100'
default[:monit][:mail_format][:from]    = 'hoge@example.com'
default[:monit][:mail_format][:subject] = '[monit] $EVENT from $HOST'
default[:monit][:mail_format][:message] =<<EOF
$EVENT Service $SERVICE
Service:        $SERVICE
Date:           $DATE
Action:         $ACTION
Host:           $HOST
Description:    $DESCRIPTION
EOF

default[:monit][:mailserver][:host]  = 'example.com'
default[:monit][:http][:port]        = '2812'
default[:monit][:allow]              = ["admin:swordfish"]
