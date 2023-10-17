Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A23E7CC569
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 16:00:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qskcM-0000rU-8c; Tue, 17 Oct 2023 10:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qskby-0000cX-GL
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:59:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qskbv-0007jX-B3
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697551190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jnMEQB7WN/VOilb9kS4Te/u43CaOTomd2J1r+KdcGiM=;
 b=P6K0KBwFSTBclVBOmKlo2eZzLiMNSU02Mv2IsQBSUePxSh+rsTBfgzLisVVSqHdO7naYlA
 2TQ72jZHUUZfolQyW3VfyeHX1nrh3Pac3eBy8+KQRzWKpWCO4oQdzBoIIsiu3q9PmVzv8V
 uexRzadZMg9vFStLmneli2oWRXnoev0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-_6ocPgB3MZWJvLMNOL5Zag-1; Tue, 17 Oct 2023 09:59:49 -0400
X-MC-Unique: _6ocPgB3MZWJvLMNOL5Zag-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5114B862F52;
 Tue, 17 Oct 2023 13:59:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 128302166B26;
 Tue, 17 Oct 2023 13:59:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 09F5321E6A1F; Tue, 17 Oct 2023 15:59:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org,  libvir-list@redhat.com,  Leonardo Bras
 <leobras@redhat.com>,  Peter Xu <peterx@redhat.com>,  Fam Zheng
 <fam@euphon.net>,  Stefan Hajnoczi <stefanha@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  qemu-block@nongnu.org,  Fabiano Rosas
 <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,  Hanna Czenczek
 <hreitz@redhat.com>
Subject: Re: [PATCH v5 4/7] migration: Deprecate block migration
References: <20231017115238.18309-1-quintela@redhat.com>
 <20231017115238.18309-5-quintela@redhat.com>
Date: Tue, 17 Oct 2023 15:59:47 +0200
In-Reply-To: <20231017115238.18309-5-quintela@redhat.com> (Juan Quintela's
 message of "Tue, 17 Oct 2023 13:52:35 +0200")
Message-ID: <87jzrl5oz0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Juan Quintela <quintela@redhat.com> writes:

> It is obsolete.  It is better to use driver-mirror with NBD instead.
>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Eric Blake <eblake@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Hanna Czenczek <hreitz@redhat.com>
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  docs/about/deprecated.rst | 10 ++++++++++
>  qapi/migration.json       | 29 ++++++++++++++++++++++++-----
>  migration/block.c         |  3 +++
>  migration/options.c       |  9 ++++++++-
>  4 files changed, 45 insertions(+), 6 deletions(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 0149f040b6..5eaf096040 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -479,3 +479,13 @@ As an intermediate step the ``blk`` functionality can be achieved by
>  setting the ``block`` migration capability to ``true``.
>  But this capability is also deprecated.
>  
> +block migration (since 8.2)
> +'''''''''''''''''''''''''''
> +
> +Block migration is too inflexible.  It needs to migrate all block
> +devices or none.
> +
> +Please see "QMP invocation for live storage migration with
> +``blockdev-mirror`` + NBD" in docs/interop/live-block-operations.rst
> +for a detailed explanation.
> +
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 59a07b50f0..c7633b22c0 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -269,11 +269,15 @@
>  #     average memory load of the virtual CPU indirectly.  Note that
>  #     zero means guest doesn't dirty memory.  (Since 8.1)
>  #
> +# Features:
> +#
> +# @deprecated: Member @disk is deprecated because block migration is.
> +#
>  # Since: 0.14
>  ##
>  { 'struct': 'MigrationInfo',
>    'data': {'*status': 'MigrationStatus', '*ram': 'MigrationStats',
> -           '*disk': 'MigrationStats',
> +           '*disk': { 'type': 'MigrationStats', 'features': [ 'deprecated' ] },
>             '*vfio': 'VfioStats',
>             '*xbzrle-cache': 'XBZRLECacheStats',
>             '*total-time': 'int',
> @@ -525,6 +529,9 @@
>  #
>  # Features:
>  #
> +# @deprecated: Member @block is deprecated.  Use blockdev-mirror with
> +#     NBD instead.
> +#
>  # @unstable: Members @x-colo and @x-ignore-shared are experimental.
>  #
>  # Since: 1.2
> @@ -534,7 +541,8 @@
>             'compress', 'events', 'postcopy-ram',
>             { 'name': 'x-colo', 'features': [ 'unstable' ] },
>             'release-ram',
> -           'block', 'return-path', 'pause-before-switchover', 'multifd',
> +           { 'name': 'block', 'features': [ 'deprecated' ] },
> +           'return-path', 'pause-before-switchover', 'multifd',
>             'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
>             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>             'validate-uuid', 'background-snapshot',
> @@ -835,6 +843,9 @@
>  #
>  # Features:
>  #
> +# @deprecated: Member @block-incremental is deprecated. Use

Two spaces between sentences for consistency, please.

> +#     blockdev-mirror with NBD instead.
> +#
>  # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
>  #     are experimental.
>  #
> @@ -850,7 +861,7 @@
>             'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
>             'avail-switchover-bandwidth', 'downtime-limit',
>             { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
> -           'block-incremental',
> +           { 'name': 'block-incremental', 'features': [ 'deprecated' ] },
>             'multifd-channels',
>             'xbzrle-cache-size', 'max-postcopy-bandwidth',
>             'max-cpu-throttle', 'multifd-compression',
> @@ -1011,6 +1022,9 @@
>  #
>  # Features:
>  #
> +# @deprecated: Member @block-incremental is deprecated. Use

Likewise.

> +#     blockdev-mirror with NBD instead.
> +#
>  # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
>  #     are experimental.
>  #
> @@ -1040,7 +1054,8 @@
>              '*downtime-limit': 'uint64',
>              '*x-checkpoint-delay': { 'type': 'uint32',
>                                       'features': [ 'unstable' ] },
> -            '*block-incremental': 'bool',
> +            '*block-incremental': { 'type': 'bool',
> +                                    'features': [ 'deprecated' ] },
>              '*multifd-channels': 'uint8',
>              '*xbzrle-cache-size': 'size',
>              '*max-postcopy-bandwidth': 'size',
> @@ -1225,6 +1240,9 @@
>  #
>  # Features:
>  #
> +# @deprecated: Member @block-incremental is deprecated. Use

Likewise.

> +#     blockdev-mirror with NBD instead.
> +#
>  # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
>  #     are experimental.
>  #
> @@ -1251,7 +1269,8 @@
>              '*downtime-limit': 'uint64',
>              '*x-checkpoint-delay': { 'type': 'uint32',
>                                       'features': [ 'unstable' ] },
> -            '*block-incremental': 'bool',
> +            '*block-incremental': { 'type': 'bool',
> +                                    'features': [ 'deprecated' ] },
>              '*multifd-channels': 'uint8',
>              '*xbzrle-cache-size': 'size',
>              '*max-postcopy-bandwidth': 'size',
> diff --git a/migration/block.c b/migration/block.c
> index b60698d6e2..7682f4fbd2 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -731,6 +731,9 @@ static int block_save_setup(QEMUFile *f, void *opaque)
>      trace_migration_block_save("setup", block_mig_state.submitted,
>                                 block_mig_state.transferred);
>  
> +    warn_report("block migration is deprecated.  Use blockdev-mirror with"
> +                "NBD instead.");

       warn_report("block migration is deprecated;"
                   " use blockdev-mirror with NBD instead.");


> +
>      ret = init_blk_migration(f);
>      if (ret < 0) {
>          return ret;
> diff --git a/migration/options.c b/migration/options.c
> index 42fb818956..0d0a3f8edb 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -12,6 +12,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "exec/target_page.h"
>  #include "qapi/clone-visitor.h"
>  #include "qapi/error.h"
> @@ -473,10 +474,14 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>      if (new_caps[MIGRATION_CAPABILITY_BLOCK]) {
>          error_setg(errp, "QEMU compiled without old-style (blk/-b, inc/-i) "
>                     "block migration");
> -        error_append_hint(errp, "Use drive_mirror+NBD instead.\n");
> +        error_append_hint(errp, "Use blockdev-mirror with NBD instead.\n");
>          return false;
>      }
>  #endif
> +    if (new_caps[MIGRATION_CAPABILITY_BLOCK]) {
> +        warn_report("Block migration is deprecated. "
> +                    "Use blockdev-mirror with NBD instead.");

Likewise.

> +    }
>  
>  #ifndef CONFIG_REPLICATION
>      if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
> @@ -1386,6 +1391,8 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>      }
>  
>      if (params->has_block_incremental) {
> +        warn_report("Block migration is deprecated. "
> +                    "Use blockdev-mirror with NBD instead.");

Likewise.

>          s->parameters.block_incremental = params->block_incremental;
>      }
>      if (params->has_multifd_channels) {

Other than that
Reviewed-by: Markus Armbruster <armbru@redhat.com>


