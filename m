Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5842706E55
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:39:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzKBE-0000cY-Cb; Wed, 17 May 2023 12:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1pzKBB-0000cN-9g
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:39:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1pzKB9-000700-3L
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684341546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4FHT0YykKnSJhILeU7syql11rfMVnqYuKMbrXwakhAk=;
 b=gG+PfNVOFO9clWOX+482lg0/P1KIyoA6PIVS+z7tbO5lsQSF8eSSYQzevg3aRf6Yl2sSOg
 /xm/cItnKTAmVKLYmrXiDEVlv7Fro8We4NVkjrkjXAFt1pWdwY+cVJYQcvtUA1ORt2j3ry
 1p2XTflmAH1Vk98m2hYerChD5mpQZKw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-naqSudrKODGq8Bu3iOLSuw-1; Wed, 17 May 2023 12:39:03 -0400
X-MC-Unique: naqSudrKODGq8Bu3iOLSuw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-74faf5008bbso4403385a.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 09:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684341543; x=1686933543;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4FHT0YykKnSJhILeU7syql11rfMVnqYuKMbrXwakhAk=;
 b=Sl3q/MzLHFPPR2YFCUh7C70VUTN3MdkiQE8Pw9om8vyc+dGaT8ORKAj+HAAFL4NX2n
 ml7afilJ5c8XbbuiLK7YZ08MTsbMdJRHzIr89TlDBpjs2TV1mHYy9Mgex6OuXXahkPgb
 pPwShcf01KAYAPVuMcrN80+WyHR4mngjJ/TgsiHAsHFdBLDGOmIAaCEMJFA9EEb7EZnD
 W2o5TRcdQIeyKiYqV66j8Ei5ef6ELYENMR5mWU44vEmSnJGCsQC//FeBtToC24sgvYzF
 2MApb/tkzthILuRy9cTiyhVCfT0g0cxONUN5JyzDaH1LwLusd4HPNQZcT8dkcLExkp8F
 5f2w==
X-Gm-Message-State: AC+VfDyekxd1gN33qixYr2y/Wk7WacJPyVIGhqymvhngLTY4FR6BH9Gh
 wpfjceFegxly+SLfPxGj2SORYRrUe4Nhvm4F2Yys4qggMQgcE7sxE74vqHOfLW35jKydZQ9nfuk
 5ZNzCy5rGe8taAhQ=
X-Received: by 2002:ac8:7dcc:0:b0:3f5:315f:5c1d with SMTP id
 c12-20020ac87dcc000000b003f5315f5c1dmr6352945qte.4.1684341542938; 
 Wed, 17 May 2023 09:39:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7SO2marbclnubH7fEwPK7CnTmuMdCA1AiN3o+T9yb8LM5ifyTCeFlETFDjM5jBjDPywwsqgA==
X-Received: by 2002:ac8:7dcc:0:b0:3f5:315f:5c1d with SMTP id
 c12-20020ac87dcc000000b003f5315f5c1dmr6352900qte.4.1684341542549; 
 Wed, 17 May 2023 09:39:02 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 l4-20020a05622a174400b003f532993912sm2272789qtk.74.2023.05.17.09.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 09:39:01 -0700 (PDT)
Date: Wed, 17 May 2023 12:39:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Maor Gottlieb <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Tarun Gupta <targupta@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v2 2/7] migration: Implement precopy initial data logic
Message-ID: <ZGUDJKKinA07CCP8@x1n>
References: <20230517155219.10691-1-avihaih@nvidia.com>
 <20230517155219.10691-3-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230517155219.10691-3-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, May 17, 2023 at 06:52:14PM +0300, Avihai Horon wrote:
> Implement precopy initial data logic. This allows migration users in the
> source to send precopy initial data and the destination to ACK when this
> data is loaded. Migration will not attempt to stop the source VM and
> complete the migration until this ACK is received.
> 
> To achieve this, a new SaveVMHandlers handler initial_data_advise() and
> a new return path mesage MIG_RP_MSG_INITIAL_DATA_LOADED_ACK are added.
> 
> The initial_data_advise() handler is called during migration setup both
> in the source and the destination to advise the migration user that
> precopy initial data is used, and its return value indicates whether
> precopy initial data is supported by it.
> 
> When precopy initial data of all the migration users is loaded in
> the destination, the MIG_RP_MSG_INITIAL_DATA_LOADED_ACK return path
> message is sent to the source to notify it.

This looks much better and easier to digest, thanks a lot.

It does answer one of my question that I wanted to ask on whether both
sides would know which device will need this feature enabled.  It seems
both sides are actually in consensus with it, which is great on reducing
the changeset.  Then it's less controversial on whether we'll need a more
generic handshake because we simply don't need the per-dev handshake for
now.

The name is probably prone to change indeed.  Firstly, it's not really
always on precopy but also for postcopy.  If vfio will supports postcopy in
the future this feature will also be needed to make sure low downtime
during switching to postcopy.  I saw that you even changed postcopy for
this [1] which is definitely good.  So "precopy" in the cap is not proper
anymore.

How about "switchover-ack"?  Then..

> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>  include/migration/register.h |  6 ++++
>  migration/migration.h        | 14 ++++++++
>  migration/savevm.h           |  2 ++
>  migration/migration.c        | 40 ++++++++++++++++++++--
>  migration/savevm.c           | 65 ++++++++++++++++++++++++++++++++++++
>  migration/trace-events       |  4 +++
>  6 files changed, 129 insertions(+), 2 deletions(-)
> 
> diff --git a/include/migration/register.h b/include/migration/register.h
> index a8dfd8fefd..3ac443a55f 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -71,6 +71,12 @@ typedef struct SaveVMHandlers {
>      int (*load_cleanup)(void *opaque);
>      /* Called when postcopy migration wants to resume from failure */
>      int (*resume_prepare)(MigrationState *s, void *opaque);
> +
> +    /*
> +     * Advises that precopy initial data was requested. Returns true if it's
> +     * supported or false otherwise. Called both in src and dest.
> +     */
> +    bool (*initial_data_advise)(void *opaque);

.. this can be "switchover_ack_needed()".  Ditto below on most of the name
of variables.

>  } SaveVMHandlers;
>  
>  int register_savevm_live(const char *idstr,
> diff --git a/migration/migration.h b/migration/migration.h
> index 7721c7658b..cc4e817939 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -202,6 +202,13 @@ struct MigrationIncomingState {
>       * contains valid information.
>       */
>      QemuMutex page_request_mutex;
> +
> +    /*
> +     * Number of migration users that are waiting for their initial data to be
> +     * loaded. When this reaches zero an ACK is sent to source. No lock is
> +     * needed as this field is updated serially.
> +     */
> +    unsigned int initial_data_pending_num;
>  };
>  
>  MigrationIncomingState *migration_incoming_get_current(void);
> @@ -430,6 +437,12 @@ struct MigrationState {
>  
>      /* QEMU_VM_VMDESCRIPTION content filled for all non-iterable devices. */
>      JSONWriter *vmdesc;
> +
> +    /*
> +     * Indicates whether an ACK that precopy initial data was loaded in
> +     * destination has been received.
> +     */
> +    bool initial_data_loaded_acked;
>  };
>  
>  void migrate_set_state(int *state, int old_state, int new_state);
> @@ -470,6 +483,7 @@ int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
>  void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
>                                   char *block_name);
>  void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
> +int migrate_send_rp_initial_data_loaded_ack(MigrationIncomingState *mis);
>  
>  void dirty_bitmap_mig_before_vm_start(void);
>  void dirty_bitmap_mig_cancel_outgoing(void);
> diff --git a/migration/savevm.h b/migration/savevm.h
> index fb636735f0..e1d8a2b3b2 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -32,6 +32,7 @@
>  bool qemu_savevm_state_blocked(Error **errp);
>  void qemu_savevm_non_migratable_list(strList **reasons);
>  void qemu_savevm_state_setup(QEMUFile *f);
> +void qemu_savevm_state_initial_data_advise(MigrationState *ms);
>  bool qemu_savevm_state_guest_unplug_pending(void);
>  int qemu_savevm_state_resume_prepare(MigrationState *s);
>  void qemu_savevm_state_header(QEMUFile *f);
> @@ -65,6 +66,7 @@ int qemu_loadvm_state(QEMUFile *f);
>  void qemu_loadvm_state_cleanup(void);
>  int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
>  int qemu_load_device_state(QEMUFile *f);
> +int qemu_loadvm_notify_initial_data_loaded(void);
>  int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
>          bool in_postcopy, bool inactivate_disks);
>  
> diff --git a/migration/migration.c b/migration/migration.c
> index 00d8ba8da0..fdb8592e64 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -78,6 +78,7 @@ enum mig_rp_message_type {
>      MIG_RP_MSG_REQ_PAGES,    /* data (start: be64, len: be32) */
>      MIG_RP_MSG_RECV_BITMAP,  /* send recved_bitmap back to source */
>      MIG_RP_MSG_RESUME_ACK,   /* tell source that we are ready to resume */
> +    MIG_RP_MSG_INITIAL_DATA_LOADED_ACK, /* Tell source initial data is loaded */
>  
>      MIG_RP_MSG_MAX
>  };
> @@ -780,6 +781,12 @@ bool migration_has_all_channels(void)
>      return true;
>  }
>  
> +int migrate_send_rp_initial_data_loaded_ack(MigrationIncomingState *mis)
> +{
> +    return migrate_send_rp_message(mis, MIG_RP_MSG_INITIAL_DATA_LOADED_ACK, 0,
> +                                   NULL);
> +}
> +
>  /*
>   * Send a 'SHUT' message on the return channel with the given value
>   * to indicate that we've finished with the RP.  Non-0 value indicates
> @@ -1425,6 +1432,7 @@ void migrate_init(MigrationState *s)
>      s->vm_was_running = false;
>      s->iteration_initial_bytes = 0;
>      s->threshold_size = 0;
> +    s->initial_data_loaded_acked = false;
>  }
>  
>  int migrate_add_blocker_internal(Error *reason, Error **errp)
> @@ -1741,6 +1749,9 @@ static struct rp_cmd_args {
>      [MIG_RP_MSG_REQ_PAGES_ID]   = { .len = -1, .name = "REQ_PAGES_ID" },
>      [MIG_RP_MSG_RECV_BITMAP]    = { .len = -1, .name = "RECV_BITMAP" },
>      [MIG_RP_MSG_RESUME_ACK]     = { .len =  4, .name = "RESUME_ACK" },
> +    [MIG_RP_MSG_INITIAL_DATA_LOADED_ACK] = { .len = 0,
> +                                             .name =
> +                                                 "INITIAL_DATA_LOADED_ACK" },

Nit: let's just put it in a single line.  If it'll be SWITCHOVER_ACK it's
even shorter. :)

>      [MIG_RP_MSG_MAX]            = { .len = -1, .name = "MAX" },
>  };
>  
> @@ -1979,6 +1990,11 @@ retry:
>              }
>              break;
>  
> +        case MIG_RP_MSG_INITIAL_DATA_LOADED_ACK:
> +            ms->initial_data_loaded_acked = true;
> +            trace_source_return_path_thread_initial_data_loaded_ack();
> +            break;
> +
>          default:
>              break;
>          }
> @@ -2727,6 +2743,20 @@ static void migration_update_counters(MigrationState *s,
>                                bandwidth, s->threshold_size);
>  }
>  
> +static bool initial_data_loaded_acked(MigrationState *s)
> +{
> +    if (!migrate_precopy_initial_data()) {
> +        return true;
> +    }
> +
> +    /* No reason to wait for precopy initial data loaded ACK if VM is stopped */
> +    if (!runstate_is_running()) {
> +        return true;
> +    }

This check may or may not be a problem, as it can become running right away
after the check.

But I think I get your point here and I think it's fine; it at least means
the vm stopped for even a while and the user doesn't strictly care super
lot about downtime.

> +
> +    return s->initial_data_loaded_acked;
> +}
> +
>  /* Migration thread iteration status */
>  typedef enum {
>      MIG_ITERATE_RESUME,         /* Resume current iteration */
> @@ -2742,6 +2772,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>  {
>      uint64_t must_precopy, can_postcopy;
>      bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
> +    bool initial_data_loaded = initial_data_loaded_acked(s);
>  
>      qemu_savevm_state_pending_estimate(&must_precopy, &can_postcopy);
>      uint64_t pending_size = must_precopy + can_postcopy;
> @@ -2754,7 +2785,8 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>          trace_migrate_pending_exact(pending_size, must_precopy, can_postcopy);
>      }
>  
> -    if (!pending_size || pending_size < s->threshold_size) {
> +    if ((!pending_size || pending_size < s->threshold_size) &&
> +        initial_data_loaded) {
>          trace_migration_thread_low_pending(pending_size);
>          migration_completion(s);
>          return MIG_ITERATE_BREAK;
> @@ -2762,7 +2794,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>  
>      /* Still a significant amount to transfer */
>      if (!in_postcopy && must_precopy <= s->threshold_size &&
> -        qatomic_read(&s->start_postcopy)) {
> +        initial_data_loaded && qatomic_read(&s->start_postcopy)) {

[1]

>          if (postcopy_start(s)) {
>              error_report("%s: postcopy failed to start", __func__);
>          }
> @@ -2986,6 +3018,10 @@ static void *migration_thread(void *opaque)
>  
>      qemu_savevm_state_setup(s->to_dst_file);
>  
> +    if (migrate_precopy_initial_data()) {
> +        qemu_savevm_state_initial_data_advise(s);
> +    }
> +
>      qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>                                 MIGRATION_STATUS_ACTIVE);
>  
> diff --git a/migration/savevm.c b/migration/savevm.c
> index e33788343a..c713ace891 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1233,6 +1233,32 @@ bool qemu_savevm_state_guest_unplug_pending(void)
>      return false;
>  }
>  
> +void qemu_savevm_state_initial_data_advise(MigrationState *ms)
> +{
> +    SaveStateEntry *se;
> +    unsigned int supported_num = 0;
> +
> +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +        if (!se->ops || !se->ops->initial_data_advise) {
> +            continue;
> +        }
> +
> +        if (se->ops->initial_data_advise(se->opaque)) {
> +            supported_num++;
> +        }
> +    }
> +
> +    if (!supported_num) {
> +        /*
> +         * There are no migration users that support precopy initial data. Set
> +         * initial data loaded acked to true so migration can be completed.
> +         */
> +        ms->initial_data_loaded_acked = true;
> +    }

This is fine but slightly hackish (e.g. someone would assume we received a
msg when this var being true, but in this case we just don't need one).

How about remember this "supported_nums" on src too and just check that in
initial_data_loaded_acked() above?

PS: we should someday have a common object for both src/dst migration which
will be suitable for variables like this, so all common vars in
MigrationState and MigrationIncomingState will go there.  Another story.

> +
> +    trace_savevm_state_initial_data_advise(supported_num);
> +}
> +
>  void qemu_savevm_state_setup(QEMUFile *f)
>  {
>      MigrationState *ms = migrate_get_current();
> @@ -2586,6 +2612,23 @@ static int qemu_loadvm_state_header(QEMUFile *f)
>      return 0;
>  }
>  
> +static void qemu_loadvm_state_initial_data_advise(MigrationIncomingState *mis)
> +{
> +    SaveStateEntry *se;
> +
> +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +        if (!se->ops || !se->ops->initial_data_advise) {
> +            continue;
> +        }
> +
> +        if (se->ops->initial_data_advise(se->opaque)) {
> +            mis->initial_data_pending_num++;
> +        }
> +    }
> +
> +    trace_loadvm_state_initial_data_advise(mis->initial_data_pending_num);
> +}
> +
>  static int qemu_loadvm_state_setup(QEMUFile *f)
>  {
>      SaveStateEntry *se;
> @@ -2789,6 +2832,10 @@ int qemu_loadvm_state(QEMUFile *f)
>          return -EINVAL;
>      }
>  
> +    if (migrate_precopy_initial_data()) {
> +        qemu_loadvm_state_initial_data_advise(mis);
> +    }
> +
>      cpu_synchronize_all_pre_loadvm();
>  
>      ret = qemu_loadvm_state_main(f, mis);
> @@ -2862,6 +2909,24 @@ int qemu_load_device_state(QEMUFile *f)
>      return 0;
>  }
>  
> +int qemu_loadvm_notify_initial_data_loaded(void)
> +{
> +    MigrationIncomingState *mis = migration_incoming_get_current();
> +
> +    if (!mis->initial_data_pending_num) {
> +        return -EINVAL;
> +    }
> +
> +    mis->initial_data_pending_num--;
> +    trace_loadvm_notify_initial_data_loaded(mis->initial_data_pending_num);
> +
> +    if (mis->initial_data_pending_num) {
> +        return 0;
> +    }
> +
> +    return migrate_send_rp_initial_data_loaded_ack(mis);
> +}
> +
>  bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
>                    bool has_devices, strList *devices, Error **errp)
>  {
> diff --git a/migration/trace-events b/migration/trace-events
> index f39818c329..807083c0a1 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -7,6 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
>  qemu_loadvm_state_post_main(int ret) "%d"
>  qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
>  qemu_savevm_send_packaged(void) ""
> +loadvm_state_initial_data_advise(unsigned int initial_data_pending_num) "Initial data pending num=%u"
>  loadvm_state_setup(void) ""
>  loadvm_state_cleanup(void) ""
>  loadvm_handle_cmd_packaged(unsigned int length) "%u"
> @@ -23,6 +24,7 @@ loadvm_postcopy_ram_handle_discard_end(void) ""
>  loadvm_postcopy_ram_handle_discard_header(const char *ramid, uint16_t len) "%s: %ud"
>  loadvm_process_command(const char *s, uint16_t len) "com=%s len=%d"
>  loadvm_process_command_ping(uint32_t val) "0x%x"
> +loadvm_notify_initial_data_loaded(unsigned int initial_data_pending_num) "Initial data pending num=%u"
>  postcopy_ram_listen_thread_exit(void) ""
>  postcopy_ram_listen_thread_start(void) ""
>  qemu_savevm_send_postcopy_advise(void) ""
> @@ -39,6 +41,7 @@ savevm_send_postcopy_resume(void) ""
>  savevm_send_colo_enable(void) ""
>  savevm_send_recv_bitmap(char *name) "%s"
>  savevm_state_setup(void) ""
> +savevm_state_initial_data_advise(unsigned int initial_data_supported_num) "Initial data supported num=%u"
>  savevm_state_resume_prepare(void) ""
>  savevm_state_header(void) ""
>  savevm_state_iterate(void) ""
> @@ -180,6 +183,7 @@ source_return_path_thread_loop_top(void) ""
>  source_return_path_thread_pong(uint32_t val) "0x%x"
>  source_return_path_thread_shut(uint32_t val) "0x%x"
>  source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
> +source_return_path_thread_initial_data_loaded_ack(void) ""
>  migration_thread_low_pending(uint64_t pending) "%" PRIu64
>  migrate_transferred(uint64_t tranferred, uint64_t time_spent, uint64_t bandwidth, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " max_size %" PRId64
>  process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
> -- 
> 2.26.3
> 

Thanks,

-- 
Peter Xu


