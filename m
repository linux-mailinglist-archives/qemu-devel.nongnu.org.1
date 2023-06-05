Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DFD7232E8
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 00:06:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6IL4-00032M-If; Mon, 05 Jun 2023 18:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q6IL2-00030J-7O
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 18:06:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q6IL0-0004gw-0j
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 18:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686002765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EOTo8ObmW8+t8tUERnfnep33sRdUjYgqRsSpUH3L9EY=;
 b=SeC5/SM4OUuF/hV0RYNgstyol+lXvSL5K3gnbhi79ULJZRrQ/8VJwz2znAXcpwUrf+guMr
 1/KKljou33tTvT/csNp8dQh9KBCT0hqp4tiCdRev/csyZndE84kgXaHMTPU/NTINgv2I5R
 /OsyN595/pwPtUbhOS+EC2hKgnz8QIs=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-kectFCnPOQmxSFmq_GFDWg-1; Mon, 05 Jun 2023 18:06:03 -0400
X-MC-Unique: kectFCnPOQmxSFmq_GFDWg-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-777b6a2582dso114469039f.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 15:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686002763; x=1688594763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EOTo8ObmW8+t8tUERnfnep33sRdUjYgqRsSpUH3L9EY=;
 b=APGi7i+P4+Eqj6zWnAFfEHYjs7khYRoTfVqNXvV3u9Upr1Z2Ki6nqKA1kPgDMCYgC1
 Bd40JTN7mhA8n/0u1dBs7em3F5WW2WQh+nyB1WW3BGiQVvA9t4yBmVyuU0wwHv2FacIW
 PMnYAfImX1nccN91tGi5lNQMrUa5bNgniTM1G9zsdcGnqXqe73aqJS5/o1Z4MxN7Fv+3
 i4wuxhxDxOQos75NOR7Pi3GoFhbuNSi73cai7lImnyxsyICFHXk/D/lbOmzPigH9qNmB
 vFv0lrlcN8u9Rv+vqBmmVcmTsxqgwhyNH/soTTznkLEH20GYZP9Nt36LJya+caVsEErN
 yRkw==
X-Gm-Message-State: AC+VfDzgrKStKr9R7bJmPYei9ZAvVryhcCGxg3ipupu2V/m9w+Wx9dWK
 anIim2LtPXcdCC/vtGXv9hdMABM57ofNo2gNdacQzhIIu434W87PiXWQD2qBQPwApAgvw+oivgf
 4D/Laef7rt+lCC+M=
X-Received: by 2002:a5e:8307:0:b0:777:b531:eb57 with SMTP id
 x7-20020a5e8307000000b00777b531eb57mr422527iom.1.1686002762754; 
 Mon, 05 Jun 2023 15:06:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5MeHPRIPQISVqXPBFbTADoXxA1GuMsp7bvBO5MwgfxuHPLvhKsxtLHdddUTArTAO6y3AlNJw==
X-Received: by 2002:a5e:8307:0:b0:777:b531:eb57 with SMTP id
 x7-20020a5e8307000000b00777b531eb57mr422501iom.1.1686002762430; 
 Mon, 05 Jun 2023 15:06:02 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 t2-20020a5d8842000000b0076373f90e46sm2892116ios.33.2023.06.05.15.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 15:06:01 -0700 (PDT)
Date: Mon, 5 Jun 2023 16:06:00 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: <qemu-devel@nongnu.org>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v5 2/9] migration: Implement switchover ack logic
Message-ID: <20230605160600.7df0993e.alex.williamson@redhat.com>
In-Reply-To: <20230530144821.1557-3-avihaih@nvidia.com>
References: <20230530144821.1557-1-avihaih@nvidia.com>
 <20230530144821.1557-3-avihaih@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
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

On Tue, 30 May 2023 17:48:14 +0300
Avihai Horon <avihaih@nvidia.com> wrote:

> Implement switchover ack logic. This prevents the source from stopping
> the VM and completing the migration until an ACK is received from the
> destination that it's OK to do so.
> 
> To achieve this, a new SaveVMHandlers handler switchover_ack_needed()
> and a new return path message MIG_RP_MSG_SWITCHOVER_ACK are added.
> 
> The switchover_ack_needed() handler is called during migration setup in
> the destination to check if switchover ack is used by the migrated
> device.
> 
> When switchover is approved by all migrated devices in the destination
> that support this capability, the MIG_RP_MSG_SWITCHOVER_ACK return path
> message is sent to the source to notify it that it's OK to do
> switchover.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>  include/migration/register.h |  2 ++
>  migration/migration.h        | 14 ++++++++++
>  migration/savevm.h           |  1 +
>  migration/migration.c        | 32 +++++++++++++++++++--
>  migration/savevm.c           | 54 ++++++++++++++++++++++++++++++++++++
>  migration/trace-events       |  3 ++
>  6 files changed, 104 insertions(+), 2 deletions(-)
> 
> diff --git a/include/migration/register.h b/include/migration/register.h
> index a8dfd8fefd..90914f32f5 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -71,6 +71,8 @@ typedef struct SaveVMHandlers {
>      int (*load_cleanup)(void *opaque);
>      /* Called when postcopy migration wants to resume from failure */
>      int (*resume_prepare)(MigrationState *s, void *opaque);
> +    /* Checks if switchover ack should be used. Called only in dest */
> +    bool (*switchover_ack_needed)(void *opaque);
>  } SaveVMHandlers;
>  
>  int register_savevm_live(const char *idstr,
> diff --git a/migration/migration.h b/migration/migration.h
> index 48a46123a0..1e92ba7b1d 100644
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
> @@ -437,6 +444,12 @@ struct MigrationState {
>  
>      /* QEMU_VM_VMDESCRIPTION content filled for all non-iterable devices. */
>      JSONWriter *vmdesc;
> +
> +    /*
> +     * Indicates whether an ACK from the destination that it's OK to do
> +     * switchover has been received.
> +     */
> +    bool switchover_acked;
>  };
>  
>  void migrate_set_state(int *state, int old_state, int new_state);
> @@ -477,6 +490,7 @@ int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
>  void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
>                                   char *block_name);
>  void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
> +int migrate_send_rp_switchover_ack(MigrationIncomingState *mis);
>  
>  void dirty_bitmap_mig_before_vm_start(void);
>  void dirty_bitmap_mig_cancel_outgoing(void);
> diff --git a/migration/savevm.h b/migration/savevm.h
> index fb636735f0..e894bbc143 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -65,6 +65,7 @@ int qemu_loadvm_state(QEMUFile *f);
>  void qemu_loadvm_state_cleanup(void);
>  int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
>  int qemu_load_device_state(QEMUFile *f);
> +int qemu_loadvm_approve_switchover(void);
>  int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
>          bool in_postcopy, bool inactivate_disks);
>  
> diff --git a/migration/migration.c b/migration/migration.c
> index 5de7f734b9..c73261118c 100644
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
> @@ -1405,6 +1411,7 @@ void migrate_init(MigrationState *s)
>      s->vm_was_running = false;
>      s->iteration_initial_bytes = 0;
>      s->threshold_size = 0;
> +    s->switchover_acked = false;
>  }
>  
>  int migrate_add_blocker_internal(Error *reason, Error **errp)
> @@ -1721,6 +1728,7 @@ static struct rp_cmd_args {
>      [MIG_RP_MSG_REQ_PAGES_ID]   = { .len = -1, .name = "REQ_PAGES_ID" },
>      [MIG_RP_MSG_RECV_BITMAP]    = { .len = -1, .name = "RECV_BITMAP" },
>      [MIG_RP_MSG_RESUME_ACK]     = { .len =  4, .name = "RESUME_ACK" },
> +    [MIG_RP_MSG_SWITCHOVER_ACK] = { .len =  0, .name = "SWITCHOVER_ACK" },
>      [MIG_RP_MSG_MAX]            = { .len = -1, .name = "MAX" },
>  };
>  
> @@ -1959,6 +1967,11 @@ retry:
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
> @@ -2700,6 +2713,20 @@ static void migration_update_counters(MigrationState *s,
>                                bandwidth, s->threshold_size);
>  }
>  
> +static bool migration_can_switchover(MigrationState *s)
> +{
> +    if (!migrate_switchover_ack()) {
> +        return true;
> +    }
> +
> +    /* No reason to wait for switchover ACK if VM is stopped */
> +    if (!runstate_is_running()) {
> +        return true;
> +    }

Is it possible for QEMU to force the migration to continue regardless
of receiving an ack from the target and is this the check that would
allow that?

It seems that we don't know the downtime allowed for the VM in any of
this, nor do we know how much time the target device will require to
generate an ack, but we could certainly have conditions where the
priority is moving the VM from the source host regardless of the
resulting downtime.

Also does the return path requirement preclude offline migration or
does the above again take care of that if we pause the VM for an
offline migration (ex. save to and restore from file)?  Thanks,

Alex

> +
> +    return s->switchover_acked;
> +}
> +
>  /* Migration thread iteration status */
>  typedef enum {
>      MIG_ITERATE_RESUME,         /* Resume current iteration */
> @@ -2715,6 +2742,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>  {
>      uint64_t must_precopy, can_postcopy;
>      bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
> +    bool can_switchover = migration_can_switchover(s);
>  
>      qemu_savevm_state_pending_estimate(&must_precopy, &can_postcopy);
>      uint64_t pending_size = must_precopy + can_postcopy;
> @@ -2727,14 +2755,14 @@ static MigIterateState migration_iteration_run(MigrationState *s)
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
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 03795ce8dc..285b814726 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2360,6 +2360,21 @@ static int loadvm_process_command(QEMUFile *f)
>              error_report("CMD_OPEN_RETURN_PATH failed");
>              return -1;
>          }
> +
> +        /*
> +         * Switchover ack is enabled but no device uses it, so send an ACK to
> +         * source that it's OK to switchover. Do it here, after return path has
> +         * been created.
> +         */
> +        if (migrate_switchover_ack() && !mis->switchover_ack_pending_num) {
> +            int ret = migrate_send_rp_switchover_ack(mis);
> +            if (ret) {
> +                error_report(
> +                    "Could not send switchover ack RP MSG, err %d (%s)", ret,
> +                    strerror(-ret));
> +                return ret;
> +            }
> +        }
>          break;
>  
>      case MIG_CMD_PING:
> @@ -2586,6 +2601,23 @@ static int qemu_loadvm_state_header(QEMUFile *f)
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
> @@ -2789,6 +2821,10 @@ int qemu_loadvm_state(QEMUFile *f)
>          return -EINVAL;
>      }
>  
> +    if (migrate_switchover_ack()) {
> +        qemu_loadvm_state_switchover_ack_needed(mis);
> +    }
> +
>      cpu_synchronize_all_pre_loadvm();
>  
>      ret = qemu_loadvm_state_main(f, mis);
> @@ -2862,6 +2898,24 @@ int qemu_load_device_state(QEMUFile *f)
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
> index cdaef7a1ea..5259c1044b 100644
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
> @@ -180,6 +182,7 @@ source_return_path_thread_loop_top(void) ""
>  source_return_path_thread_pong(uint32_t val) "0x%x"
>  source_return_path_thread_shut(uint32_t val) "0x%x"
>  source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
> +source_return_path_thread_switchover_acked(void) ""
>  migration_thread_low_pending(uint64_t pending) "%" PRIu64
>  migrate_transferred(uint64_t tranferred, uint64_t time_spent, uint64_t bandwidth, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " max_size %" PRId64
>  process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"


