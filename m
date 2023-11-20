Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEEB7F1C16
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 19:15:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r58mb-0001SZ-Vm; Mon, 20 Nov 2023 13:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r58mZ-0001SB-Ue
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 13:14:03 -0500
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r58mX-0006jL-V1
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 13:14:03 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 063701F8A3;
 Mon, 20 Nov 2023 18:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700504040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7nfE1ia3tYWgdIHm9aLuhiDooeDM0EDvnl9QpBBVgD8=;
 b=V+IthfpUXoeXZpPAGLpPjDH4tMyb2HimtHvST2Fwly0KRqL+oKDGWik1J7MASIpQxV8Dmh
 rYoXGGaFzDfQbpoT6zkbysPvms77XRNFHPoag1EVybKd9Xx8S8WUBt1vQfdtmpU6tZ987C
 JBM0NqKMELIDOH9JBzAR3eCsHbNYiIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700504040;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7nfE1ia3tYWgdIHm9aLuhiDooeDM0EDvnl9QpBBVgD8=;
 b=5Eowd+ibrmtPQLkc0cz++JsiYkmL4qjHe2xKkqWsYgy+o7fBWYzzkCmtcE3YvDqgkjJ+bs
 Iqpwh7oSmNorYJAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9460A134AD;
 Mon, 20 Nov 2023 18:13:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LvcfGOehW2ULKAAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 20 Nov 2023 18:13:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V5 06/12] migration: preserve suspended for snapshot
In-Reply-To: <1699900440-207345-7-git-send-email-steven.sistare@oracle.com>
References: <1699900440-207345-1-git-send-email-steven.sistare@oracle.com>
 <1699900440-207345-7-git-send-email-steven.sistare@oracle.com>
Date: Mon, 20 Nov 2023 15:13:57 -0300
Message-ID: <87a5r85m3e.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[99.99%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[9];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Restoring a snapshot can break a suspended guest.  Snapshots suffer from
> the same suspended-state issues that affect live migration, plus they must
> handle an additional problematic scenario, which is that a running vm must
> remain running if it loads a suspended snapshot.
>
> To save, call vm_stop_force_state to completely stop a vm in the suspended
> state, and restore the suspended state using runstate_restore.  This
> produces a correct vmstate file and leaves the vm in the state it had prior
> to the save.
>
> To load, if the snapshot is not suspended, then vm_stop_force_state +
> runstate_restore correctly handles all states, and leaves the vm in the
> state it had prior to the load.  However, if the snapshot is suspended,
> restoration is trickier.  First restore the state to suspended so the
> current state matches the saved state.  Then, if the pre-load state is
> running, wakeup to resume running.
>
> Prior to these changes, the vm_stop to RUN_STATE_SAVE_VM and
> RUN_STATE_RESTORE_VM did not change runstate if the current state was
> paused, suspended, or prelaunch, but now vm_stop_force_state forces these
> transitions, so allow them.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  include/migration/snapshot.h   |  7 +++++++
>  migration/migration-hmp-cmds.c | 12 ++++++++----
>  migration/savevm.c             | 33 +++++++++++++++++++++------------
>  system/runstate.c              | 10 ++++++++++
>  system/vl.c                    |  2 ++
>  5 files changed, 48 insertions(+), 16 deletions(-)
>
> diff --git a/include/migration/snapshot.h b/include/migration/snapshot.h
> index e72083b..9e4dcaa 100644
> --- a/include/migration/snapshot.h
> +++ b/include/migration/snapshot.h
> @@ -16,6 +16,7 @@
>  #define QEMU_MIGRATION_SNAPSHOT_H
>  
>  #include "qapi/qapi-builtin-types.h"
> +#include "qapi/qapi-types-run-state.h"
>  
>  /**
>   * save_snapshot: Save an internal snapshot.
> @@ -61,4 +62,10 @@ bool delete_snapshot(const char *name,
>                      bool has_devices, strList *devices,
>                      Error **errp);
>  
> +/**
> + * load_snapshot_resume: Restore runstate after loading snapshot.
> + * @state: state to restore
> + */
> +void load_snapshot_resume(RunState state);
> +
>  #endif
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 86ae832..c31cdc7 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -399,15 +399,19 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>  
>  void hmp_loadvm(Monitor *mon, const QDict *qdict)
>  {
> -    int saved_vm_running  = runstate_is_running();
> +    RunState saved_state = runstate_get();
> +
>      const char *name = qdict_get_str(qdict, "name");
>      Error *err = NULL;
>  
> -    vm_stop(RUN_STATE_RESTORE_VM);
> +    vm_stop_force_state(RUN_STATE_RESTORE_VM);
>  
> -    if (load_snapshot(name, NULL, false, NULL, &err) && saved_vm_running) {
> -        vm_start();
> +    if (load_snapshot(name, NULL, false, NULL, &err)) {
> +        load_snapshot_resume(saved_state);
> +    } else {
> +        vm_resume(saved_state);

Here we're starting the VM if load_snapshot() fails. Is that
intentional?

>      }
> +
>      hmp_handle_error(mon, err);
>  }
>  
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 78ac2bd..b4b49bb 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -3040,7 +3040,7 @@ bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
>      QEMUSnapshotInfo sn1, *sn = &sn1;
>      int ret = -1, ret2;
>      QEMUFile *f;
> -    int saved_vm_running;
> +    RunState saved_state = runstate_get();
>      uint64_t vm_state_size;
>      g_autoptr(GDateTime) now = g_date_time_new_now_local();
>      AioContext *aio_context;
> @@ -3088,10 +3088,8 @@ bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
>      }
>      aio_context = bdrv_get_aio_context(bs);
>  
> -    saved_vm_running = runstate_is_running();
> -
>      global_state_store();
> -    vm_stop(RUN_STATE_SAVE_VM);
> +    vm_stop_force_state(RUN_STATE_SAVE_VM);
>  
>      bdrv_drain_all_begin();
>  
> @@ -3157,9 +3155,7 @@ bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
>  
>      bdrv_drain_all_end();
>  
> -    if (saved_vm_running) {
> -        vm_start();
> -    }
> +    vm_resume(saved_state);
>      return ret == 0;
>  }
>  
> @@ -3333,6 +3329,20 @@ err_drain:
>      return false;
>  }
>  
> +void load_snapshot_resume(RunState state)
> +{
> +    if (global_state_received() &&
> +        global_state_get_runstate() == RUN_STATE_SUSPENDED) {
> +
> +        vm_resume(RUN_STATE_SUSPENDED);
> +        if (state == RUN_STATE_RUNNING) {
> +            qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
> +        }
> +    } else {
> +        vm_resume(state);
> +    }
> +}
> +
>  bool delete_snapshot(const char *name, bool has_devices,
>                       strList *devices, Error **errp)
>  {
> @@ -3397,16 +3407,15 @@ static void snapshot_load_job_bh(void *opaque)
>  {
>      Job *job = opaque;
>      SnapshotJob *s = container_of(job, SnapshotJob, common);
> -    int orig_vm_running;
> +    RunState orig_state = runstate_get();
>  
>      job_progress_set_remaining(&s->common, 1);
>  
> -    orig_vm_running = runstate_is_running();
> -    vm_stop(RUN_STATE_RESTORE_VM);
> +    vm_stop_force_state(RUN_STATE_RESTORE_VM);
>  
>      s->ret = load_snapshot(s->tag, s->vmstate, true, s->devices, s->errp);
> -    if (s->ret && orig_vm_running) {
> -        vm_start();
> +    if (s->ret) {
> +        load_snapshot_resume(orig_state);

Same here, we used to not start the VM if load_snapshot() failed.

>      }
>  
>      job_progress_update(&s->common, 1);
> diff --git a/system/runstate.c b/system/runstate.c
> index ea9d6c2..f1d4bc7 100644
> --- a/system/runstate.c
> +++ b/system/runstate.c
> @@ -77,6 +77,8 @@ typedef struct {
>  
>  static const RunStateTransition runstate_transitions_def[] = {
>      { RUN_STATE_PRELAUNCH, RUN_STATE_INMIGRATE },
> +    { RUN_STATE_PRELAUNCH, RUN_STATE_PAUSED },
> +    { RUN_STATE_PRELAUNCH, RUN_STATE_SUSPENDED },
>  
>      { RUN_STATE_DEBUG, RUN_STATE_RUNNING },
>      { RUN_STATE_DEBUG, RUN_STATE_FINISH_MIGRATE },
> @@ -108,6 +110,8 @@ static const RunStateTransition runstate_transitions_def[] = {
>      { RUN_STATE_PAUSED, RUN_STATE_POSTMIGRATE },
>      { RUN_STATE_PAUSED, RUN_STATE_PRELAUNCH },
>      { RUN_STATE_PAUSED, RUN_STATE_COLO},
> +    { RUN_STATE_PAUSED, RUN_STATE_SAVE_VM},
> +    { RUN_STATE_PAUSED, RUN_STATE_RESTORE_VM},
>  
>      { RUN_STATE_POSTMIGRATE, RUN_STATE_RUNNING },
>      { RUN_STATE_POSTMIGRATE, RUN_STATE_FINISH_MIGRATE },
> @@ -131,6 +135,8 @@ static const RunStateTransition runstate_transitions_def[] = {
>  
>      { RUN_STATE_RESTORE_VM, RUN_STATE_RUNNING },
>      { RUN_STATE_RESTORE_VM, RUN_STATE_PRELAUNCH },
> +    { RUN_STATE_RESTORE_VM, RUN_STATE_PAUSED },
> +    { RUN_STATE_RESTORE_VM, RUN_STATE_SUSPENDED },
>  
>      { RUN_STATE_COLO, RUN_STATE_RUNNING },
>      { RUN_STATE_COLO, RUN_STATE_PRELAUNCH },
> @@ -149,6 +155,8 @@ static const RunStateTransition runstate_transitions_def[] = {
>      { RUN_STATE_RUNNING, RUN_STATE_COLO},
>  
>      { RUN_STATE_SAVE_VM, RUN_STATE_RUNNING },
> +    { RUN_STATE_SAVE_VM, RUN_STATE_PAUSED },
> +    { RUN_STATE_SAVE_VM, RUN_STATE_SUSPENDED },
>  
>      { RUN_STATE_SHUTDOWN, RUN_STATE_PAUSED },
>      { RUN_STATE_SHUTDOWN, RUN_STATE_FINISH_MIGRATE },
> @@ -161,6 +169,8 @@ static const RunStateTransition runstate_transitions_def[] = {
>      { RUN_STATE_SUSPENDED, RUN_STATE_FINISH_MIGRATE },
>      { RUN_STATE_SUSPENDED, RUN_STATE_PRELAUNCH },
>      { RUN_STATE_SUSPENDED, RUN_STATE_COLO},
> +    { RUN_STATE_SUSPENDED, RUN_STATE_SAVE_VM },
> +    { RUN_STATE_SUSPENDED, RUN_STATE_RESTORE_VM },
>  
>      { RUN_STATE_WATCHDOG, RUN_STATE_RUNNING },
>      { RUN_STATE_WATCHDOG, RUN_STATE_FINISH_MIGRATE },
> diff --git a/system/vl.c b/system/vl.c
> index bd7fad7..082a45a 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2702,7 +2702,9 @@ void qmp_x_exit_preconfig(Error **errp)
>      qemu_machine_creation_done();
>  
>      if (loadvm) {
> +        RunState state = autostart ? RUN_STATE_RUNNING : runstate_get();
>          load_snapshot(loadvm, NULL, false, NULL, &error_fatal);
> +        load_snapshot_resume(state);

Here it's using error_fatal, so it won't start the VM.

>      }
>      if (replay_mode != REPLAY_MODE_NONE) {
>          replay_vmstate_init();

