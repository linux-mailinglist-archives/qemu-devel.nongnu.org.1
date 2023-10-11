Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE4B7C5436
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 14:42:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqYWv-0005Ae-VR; Wed, 11 Oct 2023 08:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqYWo-00059G-CV
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 08:41:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqYWm-0002ZQ-5z
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 08:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697028082;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=v6P+i8HVPtXr3gTd8EH2AuFS7EOX/c2pLHs8se0WI0U=;
 b=MHsiJuWlhFDidyT8V3vy62r8r2uabhrI6bMfrQnIOUP4VKHtFhbWilhCYLCoYc9HFFKpBA
 5p+g+o4s4pLplCyeapyzEtJOCa7Vub8pxBb2T6RVngBcLqXvhAvorx14wsjo9XmZ4ZUb2x
 NLzMRwJcmxvoeXbEsKZudNQ7t0JDugI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-5qcGkXpvPemE6Mz9N84Xag-1; Wed, 11 Oct 2023 08:41:21 -0400
X-MC-Unique: 5qcGkXpvPemE6Mz9N84Xag-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40647c6f71dso50789415e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 05:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697028080; x=1697632880;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v6P+i8HVPtXr3gTd8EH2AuFS7EOX/c2pLHs8se0WI0U=;
 b=m7r/W65v7g07mgK1XRgg1lutXUpb0UdsVXka0KEPpB4GjxnL6PB52aXuSUofhKoZPH
 IQgo1akJy6SeUS9W9FtAj9fdouEJZxzDQ3eu/wSYWgirmm/sj0u0B/WngFWwqn6jC93K
 TQlmVbZJnhVOzaaLkC8ZV442Q2ZGuddsHhtpOm3o4s4yXhvXSIfJohJC7LAIBHtyOOBM
 v2Vzbtmc1d4IVs5L3gq6awZv6kNobpHzWXdQ5WEA3glMZ+OQN28JIMuubmyOHKYqG7cH
 HLNEbKqOlGQaxab0wAwrGyA5Bgq332NzL1oQFvyF0EonKEywssXYGXW7HFqQfMn2vAhX
 wNxg==
X-Gm-Message-State: AOJu0YxjOy6jwhXsJkGNc37u731oCmcqoAzpYT3sFemaf4P4vOv3UTjD
 vUgAmdULoaMR3QnKCGrgGCx1MMbTJJE7g0YjQZop3R19kj8xu39vF1KJWq5Vv0ZlQzfOg90VFhn
 ZKHQpqVwdef7q4L8=
X-Received: by 2002:a7b:ca4c:0:b0:3fe:1b4e:c484 with SMTP id
 m12-20020a7bca4c000000b003fe1b4ec484mr18043906wml.5.1697028079914; 
 Wed, 11 Oct 2023 05:41:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnfxchGGFhlH6u6zvPmLIjsbxXyo+TaNNJTEYE6hbpuoJke7PVyU01lwLHTIoj4+zTpnfS0Q==
X-Received: by 2002:a7b:ca4c:0:b0:3fe:1b4e:c484 with SMTP id
 m12-20020a7bca4c000000b003fe1b4ec484mr18043887wml.5.1697028079518; 
 Wed, 11 Oct 2023 05:41:19 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 p20-20020a1c7414000000b0040651505684sm16755060wmc.29.2023.10.11.05.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 05:41:18 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Wei Wang <wei.w.wang@intel.com>
Cc: peterx@redhat.com,  isaku.yamahata@gmail.com,  qemu-devel@nongnu.org
Subject: Re: [PATCH v2] migration: refactor migration_completion
In-Reply-To: <20230804093053.5037-1-wei.w.wang@intel.com> (Wei Wang's message
 of "Fri, 4 Aug 2023 17:30:53 +0800")
References: <20230804093053.5037-1-wei.w.wang@intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 11 Oct 2023 14:41:17 +0200
Message-ID: <87v8bdbac2.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

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

There was some conflict with:

commit d50f5dc075cbb891bfe4a9378600a4871264468a
Author: Fabiano Rosas <farosas@suse.de>
Date:   Mon Sep 18 14:28:20 2023 -0300

    migration: Consolidate return path closing code

(basically the traces and the rp_thread_created check were already on
the tree).

BTW, the diff is uglier than it needs to be.

You can add to your global .gitconfig:

[diff]
        algorithm = patience
        renames = true

commit e2db83d6e73df7619de75093d1477a7f3c638847
Author: Wei Wang <wei.w.wang@intel.com>
Date:   Fri Aug 4 17:30:53 2023 +0800

    migration: refactor migration_completion
    
    Current migration_completion function is a bit long. Refactor the long
    implementation into different subfunctions:
    - migration_completion_precopy: completion code related to precopy
    - migration_completion_postcopy: completion code related to postcopy
    - close_return_path_on_source: rp thread related cleanup on migration
    completion. It is named to match with open_return_path_on_source.
    
    This improves readability and is easier for future updates (e.g. add new
    subfunctions when completion code related to new features are needed). No
    functional changes intended.
    
    Signed-off-by: Wei Wang <wei.w.wang@intel.com>

diff --git a/migration/migration.c b/migration/migration.c
index 1c6c81ad49..99a06832f5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -99,7 +99,7 @@ static int migration_maybe_pause(MigrationState *s,
                                  int *current_active_state,
                                  int new_state);
 static void migrate_fd_cancel(MigrationState *s);
-static int await_return_path_close_on_source(MigrationState *s);
+static int close_return_path_on_source(MigrationState *s);
 
 static bool migration_needs_multiple_sockets(void)
 {
@@ -1191,7 +1191,7 @@ static void migrate_fd_cleanup(MigrationState *s)
      * We already cleaned up to_dst_file, so errors from the return
      * path might be due to that, ignore them.
      */
-    await_return_path_close_on_source(s);
+    close_return_path_on_source(s);
 
     assert(!migration_is_active(s));
 
@@ -2049,8 +2049,7 @@ static int open_return_path_on_source(MigrationState *ms)
     return 0;
 }
 
-/* Returns 0 if the RP was ok, otherwise there was an error on the RP */
-static int await_return_path_close_on_source(MigrationState *ms)
+static int close_return_path_on_source(MigrationState *ms)
 {
     int ret;
 
@@ -2317,6 +2316,87 @@ static int migration_maybe_pause(MigrationState *s,
     return s->state == new_state ? 0 : -EINVAL;
 }
 
+static int migration_completion_precopy(MigrationState *s,
+                                        int *current_active_state)
+{
+    int ret;
+
+    qemu_mutex_lock_iothread();
+    s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
+
+    s->vm_old_state = runstate_get();
+    global_state_store();
+
+    ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
+    trace_migration_completion_vm_stop(ret);
+    if (ret < 0) {
+        goto out_unlock;
+    }
+
+    ret = migration_maybe_pause(s, current_active_state,
+                                MIGRATION_STATUS_DEVICE);
+    if (ret < 0) {
+        goto out_unlock;
+    }
+
+    /*
+     * Inactivate disks except in COLO, and track that we have done so in order
+     * to remember to reactivate them if migration fails or is cancelled.
+     */
+    s->block_inactive = !migrate_colo();
+    migration_rate_set(RATE_LIMIT_DISABLED);
+    ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false,
+                                             s->block_inactive);
+out_unlock:
+    qemu_mutex_unlock_iothread();
+    return ret;
+}
+
+static void migration_completion_postcopy(MigrationState *s)
+{
+    trace_migration_completion_postcopy_end();
+
+    qemu_mutex_lock_iothread();
+    qemu_savevm_state_complete_postcopy(s->to_dst_file);
+    qemu_mutex_unlock_iothread();
+
+    /*
+     * Shutdown the postcopy fast path thread.  This is only needed when dest
+     * QEMU binary is old (7.1/7.2).  QEMU 8.0+ doesn't need this.
+     */
+    if (migrate_postcopy_preempt() && s->preempt_pre_7_2) {
+        postcopy_preempt_shutdown_file(s);
+    }
+
+    trace_migration_completion_postcopy_end_after_complete();
+}
+
+static void migration_completion_failed(MigrationState *s,
+                                        int current_active_state)
+{
+    if (s->block_inactive && (s->state == MIGRATION_STATUS_ACTIVE ||
+                              s->state == MIGRATION_STATUS_DEVICE)) {
+        /*
+         * If not doing postcopy, vm_start() will be called: let's
+         * regain control on images.
+         */
+        Error *local_err = NULL;
+
+        qemu_mutex_lock_iothread();
+        bdrv_activate_all(&local_err);
+        if (local_err) {
+            error_report_err(local_err);
+        } else {
+            s->block_inactive = false;
+        }
+        qemu_mutex_unlock_iothread();
+    }
+
+    migrate_set_state(&s->state, current_active_state,
+                      MIGRATION_STATUS_FAILED);
+}
+
 /**
  * migration_completion: Used by migration_thread when there's not much left.
  *   The caller 'breaks' the loop when this returns.
@@ -2325,62 +2405,22 @@ static int migration_maybe_pause(MigrationState *s,
  */
 static void migration_completion(MigrationState *s)
 {
-    int ret;
+    int ret = 0;
     int current_active_state = s->state;
 
     if (s->state == MIGRATION_STATUS_ACTIVE) {
-        qemu_mutex_lock_iothread();
-        s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
-        qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
-
-        s->vm_old_state = runstate_get();
-        global_state_store();
-
-        ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
-        trace_migration_completion_vm_stop(ret);
-        if (ret >= 0) {
-            ret = migration_maybe_pause(s, &current_active_state,
-                                        MIGRATION_STATUS_DEVICE);
-        }
-        if (ret >= 0) {
-            /*
-             * Inactivate disks except in COLO, and track that we
-             * have done so in order to remember to reactivate
-             * them if migration fails or is cancelled.
-             */
-            s->block_inactive = !migrate_colo();
-            migration_rate_set(RATE_LIMIT_DISABLED);
-            ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false,
-                                                     s->block_inactive);
-        }
-
-        qemu_mutex_unlock_iothread();
-
-        if (ret < 0) {
-            goto fail;
-        }
+        ret = migration_completion_precopy(s, &current_active_state);
     } else if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
-        trace_migration_completion_postcopy_end();
-
-        qemu_mutex_lock_iothread();
-        qemu_savevm_state_complete_postcopy(s->to_dst_file);
-        qemu_mutex_unlock_iothread();
-
-        /*
-         * Shutdown the postcopy fast path thread.  This is only needed
-         * when dest QEMU binary is old (7.1/7.2).  QEMU 8.0+ doesn't need
-         * this.
-         */
-        if (migrate_postcopy_preempt() && s->preempt_pre_7_2) {
-            postcopy_preempt_shutdown_file(s);
-        }
-
-        trace_migration_completion_postcopy_end_after_complete();
+        migration_completion_postcopy(s);
     } else {
+        ret = -1;
+    }
+
+    if (ret < 0) {
         goto fail;
     }
 
-    if (await_return_path_close_on_source(s)) {
+    if (close_return_path_on_source(s) < 0) {
         goto fail;
     }
 
@@ -2401,26 +2441,7 @@ static void migration_completion(MigrationState *s)
     return;
 
 fail:
-    if (s->block_inactive && (s->state == MIGRATION_STATUS_ACTIVE ||
-                              s->state == MIGRATION_STATUS_DEVICE)) {
-        /*
-         * If not doing postcopy, vm_start() will be called: let's
-         * regain control on images.
-         */
-        Error *local_err = NULL;
-
-        qemu_mutex_lock_iothread();
-        bdrv_activate_all(&local_err);
-        if (local_err) {
-            error_report_err(local_err);
-        } else {
-            s->block_inactive = false;
-        }
-        qemu_mutex_unlock_iothread();
-    }
-
-    migrate_set_state(&s->state, current_active_state,
-                      MIGRATION_STATUS_FAILED);
+    migration_completion_failed(s, current_active_state);
 }
 
 /**
@@ -2563,7 +2584,7 @@ static MigThrError postcopy_pause(MigrationState *s)
          * path and just wait for the thread to finish. It will be
          * re-created when we resume.
          */
-        await_return_path_close_on_source(s);
+        close_return_path_on_source(s);
 
         migrate_set_state(&s->state, s->state,
                           MIGRATION_STATUS_POSTCOPY_PAUSED);




