Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE37175734E
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 07:45:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLdVj-0008Pu-S6; Tue, 18 Jul 2023 01:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1qLdVh-0008Pl-F8
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 01:44:34 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1qLdVf-0008LJ-62
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 01:44:33 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1b89114266dso42587415ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 22:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689659068; x=1692251068;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n0BQPgGm1XIfmC6WD/oW6qUfHz8HQ/vb04ug55Kn+ns=;
 b=Gm1Zx7Oz/0ByD1fGreXbSPNCxuEqYQbe12gHD4Rag3VHtlAxd3aFIqrajCtA825VB4
 iaDc0UYdH0++ucL0fDlRfTu359RajgxUCVccZei7ihj5jmFMpMM1XvPBNKmlq6StUPFf
 I8hl5hrAafB7BA+fjeYlmQtITCHz04TQOnzawavXxhWBPCf54i2xXzqKccBvPYq0IU70
 j2Z+kHaw+USfL7Kim9GJKfe9LKOHROUuo7XZ49HkDcWCNQV1RnG8U+M3VG8oYdNKPRgz
 1dt/2dxjgQpnYQaZ+S7144uFXb7yEz0C+wh+0fYubZS4wSCw+7EIxlz59LFr8PnUwxyH
 si0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689659068; x=1692251068;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n0BQPgGm1XIfmC6WD/oW6qUfHz8HQ/vb04ug55Kn+ns=;
 b=hb7ARIccXR9idMcNaVx6i2fTx24GwCv0wZZIy0fQTrdASTIVUWFiTxuxgq4A47BK49
 oKBTA7fxOLi4p174dS/YolojjTub001NiJI0uDmkJjN7ufR7oIfReHi/iOE/jLczPren
 D//nd7yuHjRFldSL7BqgxSnNeZrZRjydBscweLIFuNG8zltPKIAmfkssMN8ja+3BX9Eo
 VEcJAgtYzbQySb3cf6LttxOF1/JkK8hIlEN0Ke6qgsHEYt+Prj9m1XM9GAkouNgc76pO
 moRrCMB9UiD5t28bmEnQEhb1/NdGhBWaDZWs3XVgRe938994ulpSYbDWKAOtQ5NKWha7
 RugA==
X-Gm-Message-State: ABy/qLZ8wr4KpZ95FZOll6kthfdktfqsmI1zvImiWdDEQhmrp/teqMSF
 D66G5UBQdoUcxEG6scbz8G0=
X-Google-Smtp-Source: APBJJlFg0Qyd80sgobDlkN0InonwJco7Dv1EFyDksJrai58vKx60WN1/JxMSo5daTLz51z+eMLmLIA==
X-Received: by 2002:a17:902:e743:b0:1b8:ac67:c2b with SMTP id
 p3-20020a170902e74300b001b8ac670c2bmr16109695plf.21.1689659067800; 
 Mon, 17 Jul 2023 22:44:27 -0700 (PDT)
Received: from localhost ([192.55.54.50]) by smtp.gmail.com with ESMTPSA id
 iy3-20020a170903130300b001b246dcffb7sm818648plb.300.2023.07.17.22.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 22:44:27 -0700 (PDT)
Date: Mon, 17 Jul 2023 22:44:25 -0700
From: Isaku Yamahata <isaku.yamahata@gmail.com>
To: Wei Wang <wei.w.wang@intel.com>
Cc: quintela@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org,
 isaku.yamahata@gmail.com
Subject: Re: [PATCH v1] migration: refactor migration_completion
Message-ID: <20230718054425.GA1807130@ls.amr.corp.intel.com>
References: <20230714124823.25142-1-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230714124823.25142-1-wei.w.wang@intel.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=isaku.yamahata@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, Jul 14, 2023 at 08:48:23PM +0800,
Wei Wang <wei.w.wang@intel.com> wrote:

> Current migration_completion function is a bit long. Refactor the long
> implementation into different subfunctions:
> - migration_completion_precopy: completion code related to precopy
> - migration_completion_postcopy: completion code related to postcopy
> - close_return_path_on_source: rp thread related cleanup on migration
> completion. It is named to match with open_return_path_on_source.
> 
> This improves readability and is easier for future updates (e.g. add new
> subfunctions when completion code related to new features are needed). No
> functional changes intended.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  migration/migration.c | 181 +++++++++++++++++++++++++-----------------
>  1 file changed, 106 insertions(+), 75 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 91bba630a8..83f1c74f99 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2058,6 +2058,21 @@ static int await_return_path_close_on_source(MigrationState *ms)
>      return ms->rp_state.error;
>  }
>  
> +static int close_return_path_on_source(MigrationState *ms)
> +{
> +    int ret;
> +
> +    if (!ms->rp_state.rp_thread_created) {
> +        return 0;
> +    }
> +
> +    trace_migration_return_path_end_before();
> +    ret = await_return_path_close_on_source(ms);
> +    trace_migration_return_path_end_after(ret);
> +
> +    return ret;
> +}
> +

There is only one caller, migration_completion().  We can consolidate
two functions, await_return_path_close_on_source() and
close_return_path_on_source(), into single function.


>  static inline void
>  migration_wait_main_channel(MigrationState *ms)
>  {
> @@ -2288,66 +2303,107 @@ static int migration_maybe_pause(MigrationState *s,
>      return s->state == new_state ? 0 : -EINVAL;
>  }
>  
> -/**
> - * migration_completion: Used by migration_thread when there's not much left.
> - *   The caller 'breaks' the loop when this returns.
> - *
> - * @s: Current migration state
> - */
> -static void migration_completion(MigrationState *s)
> +static int migration_completion_precopy(MigrationState *s,
> +                                        int *current_active_state)
>  {
>      int ret;
> -    int current_active_state = s->state;
>  
> -    if (s->state == MIGRATION_STATUS_ACTIVE) {
> -        qemu_mutex_lock_iothread();
> -        s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> -        qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
> +    qemu_mutex_lock_iothread();
> +    s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
>  
> -        s->vm_old_state = runstate_get();
> -        global_state_store();
> +    s->vm_old_state = runstate_get();
> +    global_state_store();
>  
> -        ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
> -        trace_migration_completion_vm_stop(ret);
> -        if (ret >= 0) {
> -            ret = migration_maybe_pause(s, &current_active_state,
> -                                        MIGRATION_STATUS_DEVICE);
> -        }
> -        if (ret >= 0) {
> -            /*
> -             * Inactivate disks except in COLO, and track that we
> -             * have done so in order to remember to reactivate
> -             * them if migration fails or is cancelled.
> -             */
> -            s->block_inactive = !migrate_colo();
> -            migration_rate_set(RATE_LIMIT_DISABLED);
> -            ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false,
> -                                                     s->block_inactive);
> -        }
> +    ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
> +    trace_migration_completion_vm_stop(ret);
> +    if (ret < 0) {
> +        goto out_unlock;
> +    }
>  
> -        qemu_mutex_unlock_iothread();
> +    ret = migration_maybe_pause(s, current_active_state,
> +                                MIGRATION_STATUS_DEVICE);
> +    if (ret < 0) {
> +        goto out_unlock;
> +    }
>  
> -        if (ret < 0) {
> -            goto fail;
> -        }
> -    } else if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
> -        trace_migration_completion_postcopy_end();
> +    /*
> +     * Inactivate disks except in COLO, and track that we have done so in order
> +     * to remember to reactivate them if migration fails or is cancelled.
> +     */
> +    s->block_inactive = !migrate_colo();
> +    migration_rate_set(RATE_LIMIT_DISABLED);
> +    ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false,
> +                                             s->block_inactive);
> +out_unlock:
> +    qemu_mutex_unlock_iothread();
> +    return ret;
> +}
>  
> -        qemu_mutex_lock_iothread();
> -        qemu_savevm_state_complete_postcopy(s->to_dst_file);
> -        qemu_mutex_unlock_iothread();
> +static int migration_completion_postcopy(MigrationState *s)
> +{
> +    trace_migration_completion_postcopy_end();
> +
> +    qemu_mutex_lock_iothread();
> +    qemu_savevm_state_complete_postcopy(s->to_dst_file);
> +    qemu_mutex_unlock_iothread();
> +
> +    /*
> +     * Shutdown the postcopy fast path thread.  This is only needed when dest
> +     * QEMU binary is old (7.1/7.2).  QEMU 8.0+ doesn't need this.
> +     */
> +    if (migrate_postcopy_preempt() && s->preempt_pre_7_2) {
> +        postcopy_preempt_shutdown_file(s);
> +    }
> +
> +    trace_migration_completion_postcopy_end_after_complete();
> +
> +    return 0;

Always return 0?  Make it void.


> +}
>  
> +static void migration_completion_failed(MigrationState *s,
> +                                        int current_active_state)
> +{
> +    if (s->block_inactive && (s->state == MIGRATION_STATUS_ACTIVE ||
> +                              s->state == MIGRATION_STATUS_DEVICE)) {
>          /*
> -         * Shutdown the postcopy fast path thread.  This is only needed
> -         * when dest QEMU binary is old (7.1/7.2).  QEMU 8.0+ doesn't need
> -         * this.
> +         * If not doing postcopy, vm_start() will be called: let's
> +         * regain control on images.
>           */
> -        if (migrate_postcopy_preempt() && s->preempt_pre_7_2) {
> -            postcopy_preempt_shutdown_file(s);
> +        Error *local_err = NULL;
> +
> +        qemu_mutex_lock_iothread();
> +        bdrv_activate_all(&local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +        } else {
> +            s->block_inactive = false;
>          }
> +        qemu_mutex_unlock_iothread();
> +    }
>  
> -        trace_migration_completion_postcopy_end_after_complete();
> -    } else {
> +    migrate_set_state(&s->state, current_active_state,
> +                      MIGRATION_STATUS_FAILED);
> +}
> +
> +/**
> + * migration_completion: Used by migration_thread when there's not much left.
> + *   The caller 'breaks' the loop when this returns.
> + *
> + * @s: Current migration state
> + */
> +static void migration_completion(MigrationState *s)
> +{
> +    int ret = -1;
> +    int current_active_state = s->state;
> +
> +    if (s->state == MIGRATION_STATUS_ACTIVE) {
> +        ret = migration_completion_precopy(s, &current_active_state);
> +    } else if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
> +        ret = migration_completion_postcopy(s);

Here we can set ret = 0.


> +    }
> +
> +    if (ret < 0) {
>          goto fail;
>      }
>  
> @@ -2357,14 +2413,8 @@ static void migration_completion(MigrationState *s)
>       * it will wait for the destination to send it's status in
>       * a SHUT command).
>       */
> -    if (s->rp_state.rp_thread_created) {
> -        int rp_error;
> -        trace_migration_return_path_end_before();
> -        rp_error = await_return_path_close_on_source(s);
> -        trace_migration_return_path_end_after(rp_error);
> -        if (rp_error) {
> -            goto fail;
> -        }
> +    if (close_return_path_on_source(s) < 0) {
> +        goto fail;
>      }
>  
>      if (qemu_file_get_error(s->to_dst_file)) {
> @@ -2384,26 +2434,7 @@ static void migration_completion(MigrationState *s)
>      return;
>  
>  fail:
> -    if (s->block_inactive && (s->state == MIGRATION_STATUS_ACTIVE ||
> -                              s->state == MIGRATION_STATUS_DEVICE)) {
> -        /*
> -         * If not doing postcopy, vm_start() will be called: let's
> -         * regain control on images.
> -         */
> -        Error *local_err = NULL;
> -
> -        qemu_mutex_lock_iothread();
> -        bdrv_activate_all(&local_err);
> -        if (local_err) {
> -            error_report_err(local_err);
> -        } else {
> -            s->block_inactive = false;
> -        }
> -        qemu_mutex_unlock_iothread();
> -    }
> -
> -    migrate_set_state(&s->state, current_active_state,
> -                      MIGRATION_STATUS_FAILED);
> +    migration_completion_failed(s, current_active_state);
>  }
>  
>  /**
> -- 
> 2.27.0
> 
> 

-- 
Isaku Yamahata <isaku.yamahata@gmail.com>

