Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FFA77FDC9
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 20:24:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWhev-0000Yc-HN; Thu, 17 Aug 2023 14:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qWhet-0000YN-4P
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 14:23:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qWheq-0007U7-NG
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 14:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692296623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EEmjgpn5uJ8hL07KQZbTI0svyiLXZi/O5PkY7enOG9U=;
 b=QWEVuO94LZGI10E8omLMkqNUkybyS779uxySnRVzM0EhngIKIGOIOxi75mRLI4LKcsVWcC
 szz+LOYztSfW+yqVa2s4hNtwrYn2PzHC9R9yDLUh1Giaqi7wL9UeeChhUTOE/gh5EFHAAk
 VWILK64wduc+325viGMuDSQRfWVkDY0=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-JGG3MTCDNEy2qYgnNztGZA-1; Thu, 17 Aug 2023 14:23:42 -0400
X-MC-Unique: JGG3MTCDNEy2qYgnNztGZA-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3a797c82fb2so17722b6e.0
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 11:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692296621; x=1692901421;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EEmjgpn5uJ8hL07KQZbTI0svyiLXZi/O5PkY7enOG9U=;
 b=F4b0rBAHGjNK7xhBUoL3bcy2fgiIwbqSqcEneb0Epkj0c9EM6ithPhMfhEX+isyFj9
 iaeVr6OERIKJ0iu7rWrP4oOkAOxRIHocnF+hOgZgISN39DWSmKqJ1CWa/qPH4XYAxRht
 lanPCstWPLvKWVaoQyjo6KBamuVjPxSuTptxkWYsKqPYtAouft5oVRgFdAX1IdY27SmZ
 dgomQWPvXqfrNYS8nvErH6VitqCv8Y+GnD5bi5N1+VRBvEyBOLC03Xfxy5NuemoDZYw0
 bl6IJ8L+e/OQPqw5/FfJgbUFXanj3EhCvkr6r2Q9rA7G5pvuxppGAGMZFinXd73yQkP/
 hbrQ==
X-Gm-Message-State: AOJu0Yyi5qy/JgCMsyVsfsBPZluqQyyUf+1rx81p/ECL56a3elI34ILI
 k3K9mcKAg/IgtGQqM6FhHF9qEdazc/YurE3zMEWY+xdqICcCC73UNSRRBfeQnatJKLW/S93tTAt
 A7sA8tBxOvpbiMxM=
X-Received: by 2002:a05:6808:158e:b0:39e:ab5c:91db with SMTP id
 t14-20020a056808158e00b0039eab5c91dbmr427336oiw.2.1692296621467; 
 Thu, 17 Aug 2023 11:23:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEksVq1EYLVtkayty7oisHphHRlfhovrh1mPTun6TpQaeOqMzh/GS/D+lvs0pedvxTXbSLarg==
X-Received: by 2002:a05:6808:158e:b0:39e:ab5c:91db with SMTP id
 t14-20020a056808158e00b0039eab5c91dbmr427322oiw.2.1692296621214; 
 Thu, 17 Aug 2023 11:23:41 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 z11-20020a0cf24b000000b0063600a119fcsm58862qvl.37.2023.08.17.11.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 11:23:40 -0700 (PDT)
Date: Thu, 17 Aug 2023 14:23:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH V3 00/10] fix migration of suspended runstate
Message-ID: <ZN5lrPF9bY4acpvM@x1n>
References: <1692039276-148610-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1692039276-148610-1-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Aug 14, 2023 at 11:54:26AM -0700, Steve Sistare wrote:
> Migration of a guest in the suspended runstate is broken.  The incoming
> migration code automatically tries to wake the guest, which is wrong;
> the guest should end migration in the same runstate it started.  Further,
> for a restored snapshot, the automatic wakeup fails.  The runstate is
> RUNNING, but the guest is not.  See the commit messages for the details.

Hi Steve,

I drafted two small patches to show what I meant, on top of this series.
Before applying these two, one needs to revert patch 1 in this series.

After applied, it should also pass all three new suspend tests.  We can
continue the discussion here based on the patches.

Thanks,

=======
From 2e495b08be4c56d5d8a47ba1657bae6e316c6254 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 17 Aug 2023 12:32:00 -0400
Subject: [PATCH 1/2] cpus: Allow vm_prepare_start() to take vm state as input

It was by default always setting the state as RUNNING, but logically
SUSPENDED (acpi s1) should also fall into "vm running" case, where it's
only the vcpus that are stopped running (while everything else is).

Adding such a state parameter to be prepared when we want to prepare start
when not allowing vcpus to start yet (RUN_STATE_SUSPENDED).

Note: I found that not all vm state notifiers are ready for SUSPENDED when
having running=true set.  Here let's always pass in RUNNING irrelevant of
the state passed into vm_prepare_start(), and leave that for later to
figure out.  So far there should have (hopefully) no impact functional
wise.

For this specific patch, no functional change at all should be intended,
because all callers are still passing over RUNNING.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/sysemu/runstate.h |  3 ++-
 gdbstub/softmmu.c         |  2 +-
 softmmu/cpus.c            | 12 +++++++++---
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 7beb29c2e2..7d889ab7c7 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -39,8 +39,9 @@ void vm_start(void);
  * vm_prepare_start: Prepare for starting/resuming the VM
  *
  * @step_pending: whether any of the CPUs is about to be single-stepped by gdb
+ * @state: the vm state to setup
  */
-int vm_prepare_start(bool step_pending);
+int vm_prepare_start(bool step_pending, RunState state);
 int vm_stop(RunState state);
 int vm_stop_force_state(RunState state);
 int vm_shutdown(void);
diff --git a/gdbstub/softmmu.c b/gdbstub/softmmu.c
index f509b7285d..a43e8328c0 100644
--- a/gdbstub/softmmu.c
+++ b/gdbstub/softmmu.c
@@ -565,7 +565,7 @@ int gdb_continue_partial(char *newstates)
             }
         }
 
-        if (vm_prepare_start(step_requested)) {
+        if (vm_prepare_start(step_requested, RUN_STATE_RUNNING)) {
             return 0;
         }
 
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index fed20ffb5d..000fac79b7 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -681,7 +681,7 @@ int vm_stop(RunState state)
  * Returns -1 if the vCPUs are not to be restarted (e.g. if they are already
  * running or in case of an error condition), 0 otherwise.
  */
-int vm_prepare_start(bool step_pending)
+int vm_prepare_start(bool step_pending, RunState state)
 {
     RunState requested;
 
@@ -713,14 +713,20 @@ int vm_prepare_start(bool step_pending)
     qapi_event_send_resume();
 
     cpu_enable_ticks();
-    runstate_set(RUN_STATE_RUNNING);
+    runstate_set(state);
+    /*
+     * FIXME: ignore "state" being passed in for now, notify always with
+     * RUNNING. Because some of the vm state change handlers may not expect
+     * other states (e.g. SUSPENDED) passed in with running=true.  This can
+     * be modified after proper investigation over all vm state notifiers.
+     */
     vm_state_notify(1, RUN_STATE_RUNNING);
     return 0;
 }
 
 void vm_start(void)
 {
-    if (!vm_prepare_start(false)) {
+    if (!vm_prepare_start(false, RUN_STATE_RUNNING)) {
         resume_all_vcpus();
     }
 }
-- 
2.41.0

=======

From 4a0936eafd03952d58ab380271559c4a2049b96e Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 17 Aug 2023 12:44:29 -0400
Subject: [PATCH 2/2] fixup

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c        | 9 +++++----
 tests/qtest/migration-test.c | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index e6b8024b03..b004475af6 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -497,7 +497,7 @@ static void process_incoming_migration_bh(void *opaque)
         migration_incoming_disable_colo();
         vm_start();
     } else {
-        runstate_set(global_state_get_runstate());
+        vm_prepare_start(false, global_state_get_runstate());
     }
     /*
      * This must happen after any state changes since as soon as an external
@@ -1143,15 +1143,16 @@ void migrate_set_state(int *state, int old_state, int new_state)
 
 void migrate_set_runstate(void)
 {
-    if (!global_state_received() ||
-        global_state_get_runstate() == RUN_STATE_RUNNING) {
+    RunState state = global_state_get_runstate();
+
+    if (!global_state_received() || state == RUN_STATE_RUNNING) {
         if (autostart) {
             vm_start();
         } else {
             runstate_set(RUN_STATE_PAUSED);
         }
     } else {
-        runstate_set(global_state_get_runstate());
+        vm_prepare_start(false, state);
     }
 }
 
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 3c9e487754..5cc8b914df 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1614,15 +1614,16 @@ static void test_precopy_common(MigrateCommon *args)
             qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
         }
 
+        /* Always get RESUME first after switchover */
+        if (!dst_state.resume_seen) {
+            qtest_qmp_eventwait(to, "RESUME");
+        }
+
         if (args->start.suspend_me) {
             /* wakeup succeeds only if guest is suspended */
             qtest_qmp_assert_success(to, "{'execute': 'system_wakeup'}");
         }
 
-        if (!dst_state.resume_seen) {
-            qtest_qmp_eventwait(to, "RESUME");
-        }
-
         wait_for_serial("dest_serial");
     }
 
-- 
2.41.0


-- 
Peter Xu


