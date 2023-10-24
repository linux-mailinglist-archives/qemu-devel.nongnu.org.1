Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 387FD7D4A39
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 10:34:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvCrK-0006Lm-QI; Tue, 24 Oct 2023 04:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qvCrH-0006Kt-Av
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:33:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qvCrD-0001ZP-CY
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698136426;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=NurX1iZPT/+57cpT+f1p3/z+BO2MHkvPtv77s3U6bhY=;
 b=BiVuHEQFiOXMHeHnepG3kCZ/ZkGVTzWDkyZPAcUt/EUDzHhA26W1i4CjKgEbrckzkIeJNb
 CP6W7jJ8ySjFlFhmKrw9JBcxFtUJmglNrE6loStRzutK+9OljMDwRtuXcCm5Yb2lkUlVMG
 3djo4LlFtxxHd1ZhGU/Z9FhjmdW90ME=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444--Sl_qBnDMpS08FuC_Qjuzw-1; Tue, 24 Oct 2023 04:33:44 -0400
X-MC-Unique: -Sl_qBnDMpS08FuC_Qjuzw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64A3885D1A9;
 Tue, 24 Oct 2023 08:33:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 22FF5C15BB8;
 Tue, 24 Oct 2023 08:33:41 +0000 (UTC)
Date: Tue, 24 Oct 2023 09:33:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 28/29] migration: Add direct-io parameter
Message-ID: <ZTeBXtOGmOzT79xF@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-29-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023203608.26370-29-farosas@suse.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Oct 23, 2023 at 05:36:07PM -0300, Fabiano Rosas wrote:
> Add the direct-io migration parameter that tells the migration code to
> use O_DIRECT when opening the migration stream file whenever possible.
> 
> This is currently only used for the secondary channels of fixed-ram
> migration, which can guarantee that writes are page aligned.
> 
> However the parameter could be made to affect other types of
> file-based migrations in the future.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  include/qemu/osdep.h           |  2 ++
>  migration/file.c               | 15 ++++++++++++---
>  migration/migration-hmp-cmds.c | 10 ++++++++++
>  migration/options.c            | 30 ++++++++++++++++++++++++++++++
>  migration/options.h            |  1 +
>  qapi/migration.json            | 17 ++++++++++++++---
>  util/osdep.c                   |  9 +++++++++
>  7 files changed, 78 insertions(+), 6 deletions(-)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 475a1c62ff..ea5d29ab9b 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -597,6 +597,8 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
>  bool qemu_has_ofd_lock(void);
>  #endif
>  
> +bool qemu_has_direct_io(void);
> +
>  #if defined(__HAIKU__) && defined(__i386__)
>  #define FMT_pid "%ld"
>  #elif defined(WIN64)
> diff --git a/migration/file.c b/migration/file.c
> index ad75225f43..3d3c58ecad 100644
> --- a/migration/file.c
> +++ b/migration/file.c
> @@ -11,9 +11,9 @@
>  #include "qemu/error-report.h"
>  #include "channel.h"
>  #include "file.h"
> -#include "migration.h"
>  #include "io/channel-file.h"
>  #include "io/channel-util.h"
> +#include "migration.h"
>  #include "options.h"
>  #include "trace.h"
>  
> @@ -77,9 +77,18 @@ void file_send_channel_create(QIOTaskFunc f, void *data)
>      QIOChannelFile *ioc;
>      QIOTask *task;
>      Error *errp = NULL;
> +    int flags = outgoing_args.flags;
>  
> -    ioc = qio_channel_file_new_path(outgoing_args.fname,
> -                                    outgoing_args.flags,
> +    if (migrate_direct_io() && qemu_has_direct_io()) {
> +        /*
> +         * Enable O_DIRECT for the secondary channels. These are used
> +         * for sending ram pages and writes should be guaranteed to be
> +         * aligned to at least page size.
> +         */
> +        flags |= O_DIRECT;
> +    }

IMHO we should not be silently ignoring the user's request for
direct I/O if we've been comiled for a platform which can't
support it. We should fail the setting of the direct I/O
parameter

Also this is referencing O_DIRECT without any #ifdef check.


> +
> +    ioc = qio_channel_file_new_path(outgoing_args.fname, flags,
>                                      outgoing_args.mode, &errp);
>      if (!ioc) {
>          file_migration_cancel(errp);
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index a82597f18e..eab5ac3588 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -387,6 +387,12 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "%s: %" PRIu64 " MB/s\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT),
>              params->vcpu_dirty_limit);
> +
> +        if (params->has_direct_io) {
> +            monitor_printf(mon, "%s: %s\n",
> +                           MigrationParameter_str(MIGRATION_PARAMETER_DIRECT_IO),
> +                           params->direct_io ? "on" : "off");
> +        }
>      }
>  
>      qapi_free_MigrationParameters(params);
> @@ -661,6 +667,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>          p->has_vcpu_dirty_limit = true;
>          visit_type_size(v, param, &p->vcpu_dirty_limit, &err);
>          break;
> +    case MIGRATION_PARAMETER_DIRECT_IO:
> +        p->has_direct_io = true;
> +        visit_type_bool(v, param, &p->direct_io, &err);
> +        break;
>      default:
>          assert(0);
>      }
> diff --git a/migration/options.c b/migration/options.c
> index 2193d69e71..6d0e3c26ae 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -817,6 +817,22 @@ int migrate_decompress_threads(void)
>      return s->parameters.decompress_threads;
>  }
>  
> +bool migrate_direct_io(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    /* For now O_DIRECT is only supported with fixed-ram */
> +    if (!s->capabilities[MIGRATION_CAPABILITY_FIXED_RAM]) {
> +        return false;
> +    }
> +
> +    if (s->parameters.has_direct_io) {
> +        return s->parameters.direct_io;
> +    }
> +
> +    return false;
> +}
> +
>  uint64_t migrate_downtime_limit(void)
>  {
>      MigrationState *s = migrate_get_current();
> @@ -1025,6 +1041,11 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      params->has_vcpu_dirty_limit = true;
>      params->vcpu_dirty_limit = s->parameters.vcpu_dirty_limit;
>  
> +    if (s->parameters.has_direct_io) {
> +        params->has_direct_io = true;
> +        params->direct_io = s->parameters.direct_io;
> +    }
> +
>      return params;
>  }
>  
> @@ -1059,6 +1080,7 @@ void migrate_params_init(MigrationParameters *params)
>      params->has_announce_step = true;
>      params->has_x_vcpu_dirty_limit_period = true;
>      params->has_vcpu_dirty_limit = true;
> +    params->has_direct_io = qemu_has_direct_io();
>  }
>  
>  /*
> @@ -1356,6 +1378,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>      if (params->has_vcpu_dirty_limit) {
>          dest->vcpu_dirty_limit = params->vcpu_dirty_limit;
>      }
> +
> +    if (params->has_direct_io) {
> +        dest->direct_io = params->direct_io;
> +    }
>  }
>  
>  static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
> @@ -1486,6 +1512,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>      if (params->has_vcpu_dirty_limit) {
>          s->parameters.vcpu_dirty_limit = params->vcpu_dirty_limit;
>      }
> +
> +    if (params->has_direct_io) {

#ifndef O_DIRECT
     error_setg(errp, "Direct I/O is not supported on this platform");
#endif     

Should also be doing a check for the 'fixed-ram' capability being
set at this point.

> +        s->parameters.direct_io = params->direct_io;
> +    }
>  }
>  
>  void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
> diff --git a/migration/options.h b/migration/options.h
> index 01bba5b928..280f86bed1 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -82,6 +82,7 @@ uint8_t migrate_cpu_throttle_increment(void);
>  uint8_t migrate_cpu_throttle_initial(void);
>  bool migrate_cpu_throttle_tailslow(void);
>  int migrate_decompress_threads(void);
> +bool migrate_direct_io(void);
>  uint64_t migrate_downtime_limit(void);
>  uint8_t migrate_max_cpu_throttle(void);
>  uint64_t migrate_max_bandwidth(void);
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 1317dd32ab..3eb9e2c9b5 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -840,6 +840,9 @@
>  # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
>  #     Defaults to 1.  (Since 8.1)
>  #
> +# @direct-io: Open migration files with O_DIRECT when possible. Not
> +#             all migration transports support this. (since 8.1)

"Not all migration transports support this" is too vague.

Lets say what the requirement is

    "This requires that the 'fixed-ram' capability is enabled"

> +#
>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
> @@ -864,7 +867,7 @@
>             'multifd-zlib-level', 'multifd-zstd-level',
>             'block-bitmap-mapping',
>             { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
> -           'vcpu-dirty-limit'] }
> +           'vcpu-dirty-limit', 'direct-io'] }
>  
>  ##
>  # @MigrateSetParameters:
> @@ -1016,6 +1019,9 @@
>  # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
>  #     Defaults to 1.  (Since 8.1)
>  #
> +# @direct-io: Open migration files with O_DIRECT when possible. Not
> +#             all migration transports support this. (since 8.1)
> +#
>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
> @@ -1058,7 +1064,8 @@
>              '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
>              '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
>                                              'features': [ 'unstable' ] },
> -            '*vcpu-dirty-limit': 'uint64'} }
> +            '*vcpu-dirty-limit': 'uint64',
> +            '*direct-io': 'bool' } }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -1230,6 +1237,9 @@
>  # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
>  #     Defaults to 1.  (Since 8.1)
>  #
> +# @direct-io: Open migration files with O_DIRECT when possible. Not
> +#             all migration transports support this. (since 8.1)
> +#
>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
> @@ -1269,7 +1279,8 @@
>              '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
>              '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
>                                              'features': [ 'unstable' ] },
> -            '*vcpu-dirty-limit': 'uint64'} }
> +            '*vcpu-dirty-limit': 'uint64',
> +            '*direct-io': 'bool' } }
>  
>  ##
>  # @query-migrate-parameters:
> diff --git a/util/osdep.c b/util/osdep.c
> index e996c4744a..d0227a60ab 100644
> --- a/util/osdep.c
> +++ b/util/osdep.c
> @@ -277,6 +277,15 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive)
>  }
>  #endif
>  
> +bool qemu_has_direct_io(void)
> +{
> +#ifdef O_DIRECT
> +    return true;
> +#else
> +    return false;
> +#endif
> +}
> +
>  static int qemu_open_cloexec(const char *name, int flags, mode_t mode)
>  {
>      int ret;
> -- 
> 2.35.3
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


