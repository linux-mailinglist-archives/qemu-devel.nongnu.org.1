Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A01170FE90
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 21:33:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1uDa-0004IE-EJ; Wed, 24 May 2023 15:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q1uDY-0004Hm-Md
 for qemu-devel@nongnu.org; Wed, 24 May 2023 15:32:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q1uDW-00042o-A4
 for qemu-devel@nongnu.org; Wed, 24 May 2023 15:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684956733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+aEmrLW3cbTWgy/ebZ8XfOhsE0sH3MTJ+P4iwmeDEoA=;
 b=Jwgwk+0yu0hBN21xu4dEyRA4SN1CNTQDcq5Uh11n5eZhymOoPoBAm6aN1nqAZnS6iYSZs0
 TNbKDhOWagRDFA8E1rPAnMRAQ9KcrGKIxUFRpxoFgakwpFlXUUUa9seoAY1tW8vU68EAZg
 mNVj8RzGlrDJQbg8NacgtdAUXsJkeHA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-rbyy_wlsP5OMgXzRdnPnRw-1; Wed, 24 May 2023 15:32:11 -0400
X-MC-Unique: rbyy_wlsP5OMgXzRdnPnRw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-75b147a2548so29295485a.1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 12:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684956731; x=1687548731;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+aEmrLW3cbTWgy/ebZ8XfOhsE0sH3MTJ+P4iwmeDEoA=;
 b=enZdExJ7TWtuQR4JNdCXPn+LK2tL6y/namtrLAk4ZwRk4EZDl2mqEb15vBjP8g1i4t
 UqvL6C2KxbCr6myRmdJPDmnRw+xlmNMI+ytVlCFZ1U96WSHASRo1xglzPtm+IpJcTUur
 h3RAGihLSS4/PkpPTW0Ly5dAyvfSnJPmBNMgsv8ayxlqoubcQSmSdPiHwGO98KNqhIrR
 5dJ6VSiGf1pDb3irLUiY4ULhVy8fZ0dt1lSGRkkLoGqdxJktJ7y2jMQ6Wg4vmXtgqtvP
 Otht/RCW+bC1Ca8spZszD71n/2ldQMjHcRl+PDJCPwoFJdhUpcGhkSI7RYId97eEoZnJ
 BrRQ==
X-Gm-Message-State: AC+VfDxIZe0US31ireWP7WzoyhT7VDI30am9vShvr8JdX+GNlnb3TBcN
 7jDIUkqF+hKlH0UijCNw5sOWVDZpDUyiAWnqENBLcUN9oyF8eeDQd3fLegtfS3bQloKR6YUs4Up
 ErZ8hN3rfTr99kds=
X-Received: by 2002:a05:620a:2b0a:b0:75b:23a1:69ec with SMTP id
 do10-20020a05620a2b0a00b0075b23a169ecmr9211118qkb.3.1684956730950; 
 Wed, 24 May 2023 12:32:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7rmMSg2hwX+oarrpKuAcSHMp7vIkhG7feXx/tt5idAPoo8dGQVyjh4Ab88RPvw82P3/fw6sA==
X-Received: by 2002:a05:620a:2b0a:b0:75b:23a1:69ec with SMTP id
 do10-20020a05620a2b0a00b0075b23a169ecmr9211082qkb.3.1684956730580; 
 Wed, 24 May 2023 12:32:10 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 i10-20020a37c20a000000b0075902dffce7sm3493110qkm.100.2023.05.24.12.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 12:32:10 -0700 (PDT)
Date: Wed, 24 May 2023 15:32:08 -0400
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
Subject: Re: [PATCH v3 2/7] migration: Implement switchover ack logic
Message-ID: <ZG5mOKlGtQEyywyQ@x1n>
References: <20230521151808.24804-1-avihaih@nvidia.com>
 <20230521151808.24804-3-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230521151808.24804-3-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, May 21, 2023 at 06:18:03PM +0300, Avihai Horon wrote:
> Implement switchover ack logic. This prevents the source from stopping
> the VM and completing the migration until an ACK is received from the
> destination that it's OK to do so.
> 
> To achieve this, a new SaveVMHandlers handler switchover_ack_needed()
> and a new return path message MIG_RP_MSG_SWITCHOVER_ACK are added.
> 
> The switchover_ack_needed() handler is called during migration setup
> both in the source and the destination to check if switchover ack is
> used by the migrated device.
> 
> When switchover is approved by all migrated devices in the destination
> that support this capability, the MIG_RP_MSG_INITIAL_DATA_LOADED_ACK

s/MIG_RP_MSG_INITIAL_DATA_LOADED_ACK/MIG_RP_MSG_SWITCHOVER_ACK/

> return path message is sent to the source to notify it that it's OK to
> do switchover.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>  include/migration/register.h |  3 ++
>  migration/migration.h        | 16 +++++++++++
>  migration/savevm.h           |  2 ++
>  migration/migration.c        | 42 +++++++++++++++++++++++++--
>  migration/savevm.c           | 56 ++++++++++++++++++++++++++++++++++++
>  migration/trace-events       |  4 +++
>  6 files changed, 121 insertions(+), 2 deletions(-)
> 
> diff --git a/include/migration/register.h b/include/migration/register.h
> index a8dfd8fefd..cda36d377b 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -71,6 +71,9 @@ typedef struct SaveVMHandlers {
>      int (*load_cleanup)(void *opaque);
>      /* Called when postcopy migration wants to resume from failure */
>      int (*resume_prepare)(MigrationState *s, void *opaque);
> +
> +    /* Checks if switchover ack should be used. Called both in src and dest */
> +    bool (*switchover_ack_needed)(void *opaque);

Sorry if I'm going to suggest something that overwrites what I
suggested.. :( Luckily, not so much.

When I read the new series I just noticed maybe it's still better to only
use this on dst, and always do the ACK.

The problem is based on your patch 1 description, the RP ACK message will
be sent if the switchover-ack cap is set, but actually it's conditionally
in the current impl just to handle num==0 case, so either the impl needs
change or the desc needs change.

It turns out it'll be even cleaner to always send it.  If so..

>  } SaveVMHandlers;
>  
>  int register_savevm_live(const char *idstr,
> diff --git a/migration/migration.h b/migration/migration.h
> index 48a46123a0..e209860cce 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -209,6 +209,13 @@ struct MigrationIncomingState {
>       * contains valid information.
>       */
>      QemuMutex page_request_mutex;
> +
> +    /*
> +     * Number of devices that have yet to approve switchover. When this reaches
> +     * zero an ACK that it's OK to do switchover is sent to the source. No lock
> +     * is needed as this field is updated serially.
> +     */
> +    unsigned int switchover_ack_pending_num;
>  };
>  
>  MigrationIncomingState *migration_incoming_get_current(void);
> @@ -437,6 +444,14 @@ struct MigrationState {
>  
>      /* QEMU_VM_VMDESCRIPTION content filled for all non-iterable devices. */
>      JSONWriter *vmdesc;
> +
> +    /* Number of devices that use switchover ack capability */
> +    unsigned int switchover_ack_user_num;

... we save this field, then...

> +    /*
> +     * Indicates whether an ACK from the destination that it's OK to do
> +     * switchover has been received.
> +     */
> +    bool switchover_acked;
>  };
>  
>  void migrate_set_state(int *state, int old_state, int new_state);
> @@ -477,6 +492,7 @@ int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
>  void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
>                                   char *block_name);
>  void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
> +int migrate_send_rp_switchover_ack(MigrationIncomingState *mis);
>  
>  void dirty_bitmap_mig_before_vm_start(void);
>  void dirty_bitmap_mig_cancel_outgoing(void);
> diff --git a/migration/savevm.h b/migration/savevm.h
> index fb636735f0..5c3e1a026b 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -32,6 +32,7 @@
>  bool qemu_savevm_state_blocked(Error **errp);
>  void qemu_savevm_non_migratable_list(strList **reasons);
>  void qemu_savevm_state_setup(QEMUFile *f);
> +void qemu_savevm_state_switchover_ack_needed(MigrationState *ms);
>  bool qemu_savevm_state_guest_unplug_pending(void);
>  int qemu_savevm_state_resume_prepare(MigrationState *s);
>  void qemu_savevm_state_header(QEMUFile *f);
> @@ -65,6 +66,7 @@ int qemu_loadvm_state(QEMUFile *f);
>  void qemu_loadvm_state_cleanup(void);
>  int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
>  int qemu_load_device_state(QEMUFile *f);
> +int qemu_loadvm_approve_switchover(void);
>  int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
>          bool in_postcopy, bool inactivate_disks);
>  
> diff --git a/migration/migration.c b/migration/migration.c
> index 5de7f734b9..87423ec30c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -78,6 +78,7 @@ enum mig_rp_message_type {
>      MIG_RP_MSG_REQ_PAGES,    /* data (start: be64, len: be32) */
>      MIG_RP_MSG_RECV_BITMAP,  /* send recved_bitmap back to source */
>      MIG_RP_MSG_RESUME_ACK,   /* tell source that we are ready to resume */
> +    MIG_RP_MSG_SWITCHOVER_ACK, /* Tell source it's OK to do switchover */
>  
>      MIG_RP_MSG_MAX
>  };
> @@ -760,6 +761,11 @@ bool migration_has_all_channels(void)
>      return true;
>  }
>  
> +int migrate_send_rp_switchover_ack(MigrationIncomingState *mis)
> +{
> +    return migrate_send_rp_message(mis, MIG_RP_MSG_SWITCHOVER_ACK, 0, NULL);
> +}
> +
>  /*
>   * Send a 'SHUT' message on the return channel with the given value
>   * to indicate that we've finished with the RP.  Non-0 value indicates
> @@ -1405,6 +1411,8 @@ void migrate_init(MigrationState *s)
>      s->vm_was_running = false;
>      s->iteration_initial_bytes = 0;
>      s->threshold_size = 0;
> +    s->switchover_ack_user_num = 0;
> +    s->switchover_acked = false;
>  }
>  
>  int migrate_add_blocker_internal(Error *reason, Error **errp)
> @@ -1721,6 +1729,7 @@ static struct rp_cmd_args {
>      [MIG_RP_MSG_REQ_PAGES_ID]   = { .len = -1, .name = "REQ_PAGES_ID" },
>      [MIG_RP_MSG_RECV_BITMAP]    = { .len = -1, .name = "RECV_BITMAP" },
>      [MIG_RP_MSG_RESUME_ACK]     = { .len =  4, .name = "RESUME_ACK" },
> +    [MIG_RP_MSG_SWITCHOVER_ACK] = { .len =  0, .name = "SWITCHOVER_ACK" },
>      [MIG_RP_MSG_MAX]            = { .len = -1, .name = "MAX" },
>  };
>  
> @@ -1959,6 +1968,11 @@ retry:
>              }
>              break;
>  
> +        case MIG_RP_MSG_SWITCHOVER_ACK:
> +            ms->switchover_acked = true;
> +            trace_source_return_path_thread_switchover_acked();
> +            break;
> +
>          default:
>              break;
>          }
> @@ -2700,6 +2714,25 @@ static void migration_update_counters(MigrationState *s,
>                                bandwidth, s->threshold_size);
>  }
>  
> +static bool migration_can_switchover(MigrationState *s)
> +{
> +    if (!migrate_switchover_ack()) {
> +        return true;
> +    }
> +
> +    /* Switchover ack was enabled but no device uses it */
> +    if (!s->switchover_ack_user_num) {
> +        return true;
> +    }

... we drop this, then...

> +
> +    /* No reason to wait for switchover ACK if VM is stopped */
> +    if (!runstate_is_running()) {
> +        return true;
> +    }
> +
> +    return s->switchover_acked;
> +}
> +
>  /* Migration thread iteration status */
>  typedef enum {
>      MIG_ITERATE_RESUME,         /* Resume current iteration */
> @@ -2715,6 +2748,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>  {
>      uint64_t must_precopy, can_postcopy;
>      bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
> +    bool can_switchover = migration_can_switchover(s);
>  
>      qemu_savevm_state_pending_estimate(&must_precopy, &can_postcopy);
>      uint64_t pending_size = must_precopy + can_postcopy;
> @@ -2727,14 +2761,14 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>          trace_migrate_pending_exact(pending_size, must_precopy, can_postcopy);
>      }
>  
> -    if (!pending_size || pending_size < s->threshold_size) {
> +    if ((!pending_size || pending_size < s->threshold_size) && can_switchover) {
>          trace_migration_thread_low_pending(pending_size);
>          migration_completion(s);
>          return MIG_ITERATE_BREAK;
>      }
>  
>      /* Still a significant amount to transfer */
> -    if (!in_postcopy && must_precopy <= s->threshold_size &&
> +    if (!in_postcopy && must_precopy <= s->threshold_size && can_switchover &&
>          qatomic_read(&s->start_postcopy)) {
>          if (postcopy_start(s)) {
>              error_report("%s: postcopy failed to start", __func__);
> @@ -2959,6 +2993,10 @@ static void *migration_thread(void *opaque)
>  
>      qemu_savevm_state_setup(s->to_dst_file);
>  
> +    if (migrate_switchover_ack()) {
> +        qemu_savevm_state_switchover_ack_needed(s);
> +    }

... we also drop this, then...

> +
>      qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>                                 MIGRATION_STATUS_ACTIVE);
>  
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 03795ce8dc..9482b1ff27 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1233,6 +1233,23 @@ bool qemu_savevm_state_guest_unplug_pending(void)
>      return false;
>  }
>  
> +void qemu_savevm_state_switchover_ack_needed(MigrationState *ms)
> +{
> +    SaveStateEntry *se;
> +
> +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +        if (!se->ops || !se->ops->switchover_ack_needed) {
> +            continue;
> +        }
> +
> +        if (se->ops->switchover_ack_needed(se->opaque)) {
> +            ms->switchover_ack_user_num++;
> +        }
> +    }
> +
> +    trace_savevm_state_switchover_ack_needed(ms->switchover_ack_user_num);
> +}

... we also drop this, then...

> +
>  void qemu_savevm_state_setup(QEMUFile *f)
>  {
>      MigrationState *ms = migrate_get_current();
> @@ -2586,6 +2603,23 @@ static int qemu_loadvm_state_header(QEMUFile *f)
>      return 0;
>  }
>  
> +static void qemu_loadvm_state_switchover_ack_needed(MigrationIncomingState *mis)
> +{
> +    SaveStateEntry *se;
> +
> +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +        if (!se->ops || !se->ops->switchover_ack_needed) {
> +            continue;
> +        }
> +
> +        if (se->ops->switchover_ack_needed(se->opaque)) {
> +            mis->switchover_ack_pending_num++;
> +        }
> +    }
> +
> +    trace_loadvm_state_switchover_ack_needed(mis->switchover_ack_pending_num);
> +}
> +
>  static int qemu_loadvm_state_setup(QEMUFile *f)
>  {
>      SaveStateEntry *se;
> @@ -2789,6 +2823,10 @@ int qemu_loadvm_state(QEMUFile *f)
>          return -EINVAL;
>      }
>  
> +    if (migrate_switchover_ack()) {
> +        qemu_loadvm_state_switchover_ack_needed(mis);

... here, we send ACK msg if num==0.

So we (1) make the wire protocol clearer (ACK must be there if cap set),
then (2) drop a bunch of code too.  Actually we also make the code clearer
too on src.

What do you think?

Other than that this looks very good to me.

> +    }
> +
>      cpu_synchronize_all_pre_loadvm();
>  
>      ret = qemu_loadvm_state_main(f, mis);
> @@ -2862,6 +2900,24 @@ int qemu_load_device_state(QEMUFile *f)
>      return 0;
>  }
>  
> +int qemu_loadvm_approve_switchover(void)
> +{
> +    MigrationIncomingState *mis = migration_incoming_get_current();
> +
> +    if (!mis->switchover_ack_pending_num) {
> +        return -EINVAL;
> +    }
> +
> +    mis->switchover_ack_pending_num--;
> +    trace_loadvm_approve_switchover(mis->switchover_ack_pending_num);
> +
> +    if (mis->switchover_ack_pending_num) {
> +        return 0;
> +    }
> +
> +    return migrate_send_rp_switchover_ack(mis);
> +}
> +
>  bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
>                    bool has_devices, strList *devices, Error **errp)
>  {
> diff --git a/migration/trace-events b/migration/trace-events
> index cdaef7a1ea..c52b429b28 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -7,6 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
>  qemu_loadvm_state_post_main(int ret) "%d"
>  qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
>  qemu_savevm_send_packaged(void) ""
> +loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
>  loadvm_state_setup(void) ""
>  loadvm_state_cleanup(void) ""
>  loadvm_handle_cmd_packaged(unsigned int length) "%u"
> @@ -23,6 +24,7 @@ loadvm_postcopy_ram_handle_discard_end(void) ""
>  loadvm_postcopy_ram_handle_discard_header(const char *ramid, uint16_t len) "%s: %ud"
>  loadvm_process_command(const char *s, uint16_t len) "com=%s len=%d"
>  loadvm_process_command_ping(uint32_t val) "0x%x"
> +loadvm_approve_switchover(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
>  postcopy_ram_listen_thread_exit(void) ""
>  postcopy_ram_listen_thread_start(void) ""
>  qemu_savevm_send_postcopy_advise(void) ""
> @@ -39,6 +41,7 @@ savevm_send_postcopy_resume(void) ""
>  savevm_send_colo_enable(void) ""
>  savevm_send_recv_bitmap(char *name) "%s"
>  savevm_state_setup(void) ""
> +savevm_state_switchover_ack_needed(unsigned int switchover_ack_user_num) "Switchover ack user num=%u"
>  savevm_state_resume_prepare(void) ""
>  savevm_state_header(void) ""
>  savevm_state_iterate(void) ""
> @@ -180,6 +183,7 @@ source_return_path_thread_loop_top(void) ""
>  source_return_path_thread_pong(uint32_t val) "0x%x"
>  source_return_path_thread_shut(uint32_t val) "0x%x"
>  source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
> +source_return_path_thread_switchover_acked(void) ""
>  migration_thread_low_pending(uint64_t pending) "%" PRIu64
>  migrate_transferred(uint64_t tranferred, uint64_t time_spent, uint64_t bandwidth, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " max_size %" PRId64
>  process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
> -- 
> 2.26.3
> 

-- 
Peter Xu


