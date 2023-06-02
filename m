Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC96720033
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 13:15:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q52jv-00061Z-Ee; Fri, 02 Jun 2023 07:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q52jo-00061K-Oo
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 07:14:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q52jm-0007mk-7G
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 07:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685704469;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=NW74sOm51pWT1PbNAz0N1AThE8xJ1AybxDxtAYveYGM=;
 b=Ii/KFe+FEILvn2g2AP3ftcEssurjzzOGfInuBWiHYMl9lbsVZ1mwCMQr0XkKgO8szFpB/l
 xtMXLVQSk3+1UHMCS4pLhuQLyw0zvBo9MNPfsYte91AsoZoNjVXEEyKPAtnDU5mfIzfwd+
 spFaI2udx+c2cldU081GgxIt4UdoXlg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-5oVpeVjtOmu1FG501FlyfA-1; Fri, 02 Jun 2023 07:14:28 -0400
X-MC-Unique: 5oVpeVjtOmu1FG501FlyfA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCEF5380662F;
 Fri,  2 Jun 2023 11:14:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.158])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE23E2026D49;
 Fri,  2 Jun 2023 11:14:23 +0000 (UTC)
Date: Fri, 2 Jun 2023 12:14:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Avihai Horon <avihaih@nvidia.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH RFC 1/3] migration: switchover-hold parameter
Message-ID: <ZHnPDHnUUY/SRszl@redhat.com>
References: <20230602011626.226640-1-peterx@redhat.com>
 <20230602011626.226640-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230602011626.226640-2-peterx@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Jun 01, 2023 at 09:16:24PM -0400, Peter Xu wrote:
> Add a new migration parameter switchover-hold which can block src qemu
> migration from switching over to dest from running.
> 
> One can set this flag to true so src qemu will keep iterating the VM data,
> not switching over to dest even if it can.
> 
> It means now live migration works somehow like COLO; we keep syncing data
> from src to dst without stopping.
> 
> When the user is ready for the switchover, one can set the parameter from
> true->false.  That'll contain a implicit kick to migration thread to be
> alive and re-evaluate the switchover decision.
> 
> This can be used in two cases so far in my mind:
> 
>   (1) One can use this parameter to start pre-heating migration (but not
>       really migrating, so a migrate-cancel will cancel the preheat).  When
>       the user wants to really migrate, just clear the flag.  It'll in most
>       cases migrate immediately because most pages are already synced.
> 
>   (2) Can also be used as a clean way to do qtest, in many of the precopy
>       tests we have requirement to run after 1 iteration without completing
>       the precopy migration.  Before that we have either set bandwidth to
>       ridiculous low value, or tricks on detecting guest memory change over
>       some adhoc guest memory position.  Now we can simply set this flag
>       then we know precopy won't complete and will just keep going.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  qapi/migration.json            | 25 +++++++++++++--
>  migration/migration.h          |  7 +++++
>  migration/migration-hmp-cmds.c |  3 ++
>  migration/migration.c          | 56 ++++++++++++++++++++++++++++++++--
>  migration/options.c            | 17 +++++++++++
>  5 files changed, 102 insertions(+), 6 deletions(-)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 179af0c4d8..1d0059d125 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -779,6 +779,15 @@
>  #     Nodes are mapped to their block device name if there is one, and
>  #     to their node name otherwise.  (Since 5.2)
>  #
> +# @switchover-hold: Whether we should hold-off precopy switchover from src
> +#     to dest QEMU, even if we can finish migration in the downtime
> +#     specified.  By default off, so precopy migration will complete as
> +#     soon as possible.  One can set it to explicitly keep iterating during
> +#     precopy migration until set the flag to false again to kick off the
> +#     final switchover.  Note, this does not affect postcopy switchover,
> +#     because the user can control that using "migrate-start-postcopy"
> +#     command explicitly. (Since 8.1)
> +#
>  # Features:
>  #
>  # @unstable: Member @x-checkpoint-delay is experimental.
> @@ -800,7 +809,7 @@
>             'xbzrle-cache-size', 'max-postcopy-bandwidth',
>             'max-cpu-throttle', 'multifd-compression',
>             'multifd-zlib-level' ,'multifd-zstd-level',
> -           'block-bitmap-mapping' ] }
> +           'block-bitmap-mapping', 'switchover-hold' ] }
>  
>  ##
>  # @MigrateSetParameters:
> @@ -935,6 +944,10 @@
>  #     Nodes are mapped to their block device name if there is one, and
>  #     to their node name otherwise.  (Since 5.2)
>  #
> +# @switchover-hold: Whether we should hold-off precopy switchover from src
> +#     to dest QEMU.  For more details, please refer to MigrationParameter
> +#     entry of the same field. (Since 8.1)
> +#
>  # Features:
>  #
>  # @unstable: Member @x-checkpoint-delay is experimental.
> @@ -972,7 +985,8 @@
>              '*multifd-compression': 'MultiFDCompression',
>              '*multifd-zlib-level': 'uint8',
>              '*multifd-zstd-level': 'uint8',
> -            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }
> +            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
> +            '*switchover-hold': 'bool' } }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -1127,6 +1141,10 @@
>  #     Nodes are mapped to their block device name if there is one, and
>  #     to their node name otherwise.  (Since 5.2)
>  #
> +# @switchover-hold: Whether we should hold-off precopy switchover from src
> +#     to dest QEMU.  For more details, please refer to MigrationParameter
> +#     entry of the same field. (Since 8.1)
> +#
>  # Features:
>  #
>  # @unstable: Member @x-checkpoint-delay is experimental.
> @@ -1161,7 +1179,8 @@
>              '*multifd-compression': 'MultiFDCompression',
>              '*multifd-zlib-level': 'uint8',
>              '*multifd-zstd-level': 'uint8',
> -            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }
> +            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
> +            '*switchover-hold': 'bool' } }
>  
>  ##
>  # @query-migrate-parameters:
> diff --git a/migration/migration.h b/migration/migration.h
> index 48a46123a0..086ceec754 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -437,6 +437,13 @@ struct MigrationState {
>  
>      /* QEMU_VM_VMDESCRIPTION content filled for all non-iterable devices. */
>      JSONWriter *vmdesc;
> +    /*
> +     * Only migration thread will wait on it when switchover_hold==true.
> +     *
> +     * Only qmp set param will kick it when switching switchover_hold from
> +     * true->false.
> +     */
> +    QemuSemaphore switchover_hold_sem;
>  };
>  
>  void migrate_set_state(int *state, int old_state, int new_state);
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 9885d7c9f7..63a2c8a4a3 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -338,6 +338,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "%s: '%s'\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
>              params->tls_authz);
> +        monitor_printf(mon, "%s: %s\n",
> +            MigrationParameter_str(MIGRATION_PARAMETER_SWITCHOVER_HOLD),
> +            params->switchover_hold ? "on" : "off");
>  
>          if (params->has_block_bitmap_mapping) {
>              const BitmapMigrationNodeAliasList *bmnal;
> diff --git a/migration/migration.c b/migration/migration.c
> index 5de7f734b9..30f165527b 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2700,6 +2700,55 @@ static void migration_update_counters(MigrationState *s,
>                                bandwidth, s->threshold_size);
>  }
>  
> +static bool
> +migration_should_complete(MigrationState *s, uint64_t pending_size)
> +{
> +    /* We still have large pending data to send? */
> +    if (pending_size && (pending_size >= s->threshold_size)) {
> +        return false;
> +    }
> +
> +    /* The user doesn't want us to switchover yet */
> +    if (s->parameters.switchover_hold) {
> +        /*
> +         * Note: when reaching here it probably means we've migrated almost
> +         * everything and ready to switchover.  If user asked not to switch
> +         * wait for a short period and respond to kicks immediately.
> +         *
> +         * If we wait too long, there can be a lot of dirty data generated,
> +         * while we could have done something to sync data between src/dst.
> +         *
> +         * If we wait too short, migration thread can eat most/all cpu
> +         * resource looping over switchover_hold.
> +         *
> +         * Make it 10ms which seems to be a good intermediate value.
> +         */
> +        qemu_sem_timedwait(&s->switchover_hold_sem, 10);
> +
> +        /*
> +         * Return false here always even if user changed it, because we'd
> +         * like to re-evaluate everything (e.g. pending_size).
> +         */
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static bool
> +migration_should_start_postcopy(MigrationState *s, uint64_t must_precopy)
> +{
> +    /* If we're already in postcopy phase, don't bother */
> +    if (migration_in_postcopy()) {
> +        return false;
> +    }
> +    /* We still have lots of thing that must be migrated in precopy */
> +    if (must_precopy > s->threshold_size) {
> +        return false;
> +    }
> +    return qatomic_read(&s->start_postcopy);
> +}
> +
>  /* Migration thread iteration status */
>  typedef enum {
>      MIG_ITERATE_RESUME,         /* Resume current iteration */
> @@ -2727,15 +2776,14 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>          trace_migrate_pending_exact(pending_size, must_precopy, can_postcopy);
>      }
>  
> -    if (!pending_size || pending_size < s->threshold_size) {
> +    if (migration_should_complete(s, pending_size)) {
>          trace_migration_thread_low_pending(pending_size);
>          migration_completion(s);
>          return MIG_ITERATE_BREAK;
>      }
>  
>      /* Still a significant amount to transfer */
> -    if (!in_postcopy && must_precopy <= s->threshold_size &&
> -        qatomic_read(&s->start_postcopy)) {
> +    if (migration_should_start_postcopy(s, must_precopy)) {
>          if (postcopy_start(s)) {
>              error_report("%s: postcopy failed to start", __func__);
>          }
> @@ -3287,6 +3335,7 @@ static void migration_instance_finalize(Object *obj)
>      qemu_sem_destroy(&ms->rp_state.rp_sem);
>      qemu_sem_destroy(&ms->rp_state.rp_pong_acks);
>      qemu_sem_destroy(&ms->postcopy_qemufile_src_sem);
> +    qemu_sem_destroy(&ms->switchover_hold_sem);
>      error_free(ms->error);
>  }
>  
> @@ -3309,6 +3358,7 @@ static void migration_instance_init(Object *obj)
>      qemu_sem_init(&ms->rate_limit_sem, 0);
>      qemu_sem_init(&ms->wait_unplug_sem, 0);
>      qemu_sem_init(&ms->postcopy_qemufile_src_sem, 0);
> +    qemu_sem_init(&ms->switchover_hold_sem, 0);
>      qemu_mutex_init(&ms->qemu_file_lock);
>  }
>  
> diff --git a/migration/options.c b/migration/options.c
> index b62ab30cd5..2d6b138352 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -163,6 +163,8 @@ Property migration_properties[] = {
>      DEFINE_PROP_STRING("tls-creds", MigrationState, parameters.tls_creds),
>      DEFINE_PROP_STRING("tls-hostname", MigrationState, parameters.tls_hostname),
>      DEFINE_PROP_STRING("tls-authz", MigrationState, parameters.tls_authz),
> +    DEFINE_PROP_BOOL("switchover-hold", MigrationState,
> +                     parameters.switchover_hold, false),
>  
>      /* Migration capabilities */
>      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
> @@ -883,6 +885,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      params->announce_rounds = s->parameters.announce_rounds;
>      params->has_announce_step = true;
>      params->announce_step = s->parameters.announce_step;
> +    params->has_switchover_hold = true;
> +    params->switchover_hold = s->parameters.switchover_hold;
>  
>      if (s->parameters.has_block_bitmap_mapping) {
>          params->has_block_bitmap_mapping = true;
> @@ -923,6 +927,7 @@ void migrate_params_init(MigrationParameters *params)
>      params->has_announce_max = true;
>      params->has_announce_rounds = true;
>      params->has_announce_step = true;
> +    params->has_switchover_hold = true;
>  }
>  
>  /*
> @@ -1177,6 +1182,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>      if (params->has_announce_step) {
>          dest->announce_step = params->announce_step;
>      }
> +    if (params->has_switchover_hold) {
> +        dest->switchover_hold = params->switchover_hold;
> +    }
>  
>      if (params->has_block_bitmap_mapping) {
>          dest->has_block_bitmap_mapping = true;
> @@ -1290,6 +1298,15 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>      if (params->has_announce_step) {
>          s->parameters.announce_step = params->announce_step;
>      }
> +    if (params->has_switchover_hold) {
> +        bool old = s->parameters.switchover_hold;
> +        bool new = params->switchover_hold;
> +
> +        s->parameters.switchover_hold = params->switchover_hold;
> +        if (old && !new) {
> +            qemu_sem_post(&s->switchover_hold_sem);
> +        }
> +    }

IIUC, MigrationState is global to QEMU and gets reused on every
migration.

If we qemu_sem_post() here, and the migration fails, and the
user starts a new migration on the same QEMU, the switchover_hold_sem
needs resetting somewhere, as there's a (tiny) risk that the
qemu_sem_timedwait() won't have run before the migration fail.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


