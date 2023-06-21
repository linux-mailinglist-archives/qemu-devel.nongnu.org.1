Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 115EB7390CA
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 22:29:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC4RY-0004g1-O5; Wed, 21 Jun 2023 16:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qC4RW-0004fo-Ph
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 16:28:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qC4RV-00042a-6X
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 16:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687379320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VUorSLL1e35/7m0jeczq5kAPpVA24b/cZiTyQR432R8=;
 b=RhfragjT94IxKtuGs0XDnAXunVIsB8HeSTjeXunccgB9r6NlSSr/upUgEhTkFs0nYm6TTn
 E/VK8erfKQWjQFvPPeAh3xar5Nbpg2xQcRINZryLHVphlSMCDlGPU2m73Gaxe0JPv3sdRz
 tJd2iq0T8+1YmGxmcgDmA2g1pU9l2Y8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-zhpxsRdkMM6ZKOCJO8DxPQ-1; Wed, 21 Jun 2023 16:28:37 -0400
X-MC-Unique: zhpxsRdkMM6ZKOCJO8DxPQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-62ffa1214edso12154306d6.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 13:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687379317; x=1689971317;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VUorSLL1e35/7m0jeczq5kAPpVA24b/cZiTyQR432R8=;
 b=bb11Nd53/ypgjdFgRhyHP6jTMfQ1nLYwSf+VF0MoSAcw23fsOe2GR/V8UXi0mRwNHx
 u1K7KRtmODkSoPL6MJYA42nAwwLwIiYMcFh1L7oiwIlam8t/SQslfkLKpUJMTOE31eN5
 WroNGEhZw6DAcQm5BYuGCLo7S+gcxfp+hFFdM0f2yhsCM9HtjTApl3TsVeoyTWyIE3E7
 BNS01n4uF5ye/Ft9I5tEhpipcHXIgFACCenVYzcrKyh5eL06GiGp4vYEUUJN7J8lNo0x
 D8Ll2+H5cAxnUfgrJrHxXIsjzXiCaqZNHhtjSxgyaVaHobBTuNMH3fDvjpr3vXU6kfqb
 JYPw==
X-Gm-Message-State: AC+VfDzhUqGbX2B80kTEt0dSZFNFzYFK+6hy23UA5aPpHTOqvf7zTzBO
 yKOu9QNSbXGTQhO1exmifnipNpNQRgbTHOgCmXMX6DrjlOthr47z/dOgrjzy0JhGCOJ/TwMhYPB
 62ZFnvzadLvFRKrg=
X-Received: by 2002:a05:6214:2262:b0:625:aa49:c182 with SMTP id
 gs2-20020a056214226200b00625aa49c182mr19618855qvb.6.1687379317227; 
 Wed, 21 Jun 2023 13:28:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6czhGWJM64gOZrPCLp1mNSfleK5TriZGpALvfEbfGGm+jXdEtbHe1DllzVdbB71koMCTyd0A==
X-Received: by 2002:a05:6214:2262:b0:625:aa49:c182 with SMTP id
 gs2-20020a056214226200b00625aa49c182mr19618843qvb.6.1687379316980; 
 Wed, 21 Jun 2023 13:28:36 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 o2-20020a0ccb02000000b0062febc332f0sm1212379qvk.130.2023.06.21.13.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 13:28:36 -0700 (PDT)
Date: Wed, 21 Jun 2023 16:28:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH V1 2/3] migration: fix suspended runstate
Message-ID: <ZJNdcyrv0TzFUKMy@x1n>
References: <1686860800-34667-1-git-send-email-steven.sistare@oracle.com>
 <1686860800-34667-3-git-send-email-steven.sistare@oracle.com>
 <ZJIeR7svXvtHdgs4@x1n>
 <6adfae20-60fe-ae08-1685-160b2a1efab5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6adfae20-60fe-ae08-1685-160b2a1efab5@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Jun 21, 2023 at 03:15:42PM -0400, Steven Sistare wrote:
> On 6/20/2023 5:46 PM, Peter Xu wrote:
> > On Thu, Jun 15, 2023 at 01:26:39PM -0700, Steve Sistare wrote:
> >> Migration of a guest in the suspended state is broken.  The incoming
> >> migration code automatically tries to wake the guest, which IMO is
> >> wrong -- the guest should end migration in the same state it started.
> >> Further, the wakeup is done by calling qemu_system_wakeup_request(), which
> >> bypasses vm_start().  The guest appears to be in the running state, but
> >> it is not.
> >>
> >> To fix, leave the guest in the suspended state, but call
> >> qemu_system_start_on_wakeup_request() so the guest is properly resumed
> >> later, when the client sends a system_wakeup command.
> >>
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >> ---
> >>  migration/migration.c | 11 ++++-------
> >>  softmmu/runstate.c    |  1 +
> >>  2 files changed, 5 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/migration/migration.c b/migration/migration.c
> >> index 17b4b47..851fe6d 100644
> >> --- a/migration/migration.c
> >> +++ b/migration/migration.c
> >> @@ -496,6 +496,10 @@ static void process_incoming_migration_bh(void *opaque)
> >>          vm_start();
> >>      } else {
> >>          runstate_set(global_state_get_runstate());
> >> +        if (runstate_check(RUN_STATE_SUSPENDED)) {
> >> +            /* Force vm_start to be called later. */
> >> +            qemu_system_start_on_wakeup_request();
> >> +        }
> > 
> > Is this really needed, along with patch 1?
> > 
> > I have a very limited knowledge on suspension, so I'm prone to making
> > mistakes..
> > 
> > But from what I read this, qemu_system_wakeup_request() (existing one, not
> > after patch 1 applied) will setup wakeup_reason and kick the main thread
> > using qemu_notify_event().  Then IIUC the e.g. vcpu wakeups will be done in
> > the main thread later on after qemu_wakeup_requested() returns true.
> 
> Correct, here:
> 
>     if (qemu_wakeup_requested()) {
>         pause_all_vcpus();
>         qemu_system_wakeup();
>         notifier_list_notify(&wakeup_notifiers, &wakeup_reason);
>         wakeup_reason = QEMU_WAKEUP_REASON_NONE;
>         resume_all_vcpus();
>         qapi_event_send_wakeup();
>     }
> 
> However, that is not sufficient, because vm_start() was never called on the incoming
> side.  vm_start calls the vm state notifiers for RUN_STATE_RUNNING, among other things.
> 
> 
> Without my fixes, it "works" because the outgoing migration automatically wakes a suspended
> guest, which sets the state to running, which is saved in global state:
> 
>     void migration_completion(MigrationState *s)
>         qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
>         global_state_store()
> 
> Then the incoming migration calls vm_start here:
> 
>     migration/migration.c
>         if (!global_state_received() ||
>             global_state_get_runstate() == RUN_STATE_RUNNING) {
>             if (autostart) {
>                 vm_start();
> 
> vm_start must be called for correctness.

I see.  Though I had a feeling that this is still not the right way to do,
at least not as clean.

One question is, would above work for postcopy when VM is suspended during
the switchover?

I think I see your point that vm_start() (mostly vm_prepare_start())
contains a bunch of operations that maybe we must have before starting the
VM, but then.. should we just make that vm_start() unconditional when
loading VM completes?  I just don't see anything won't need it (besides
-S), even COLO.

So I'm wondering about something like this:

===8<===
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -481,19 +481,28 @@ static void process_incoming_migration_bh(void *opaque)
 
     dirty_bitmap_mig_before_vm_start();
 
-    if (!global_state_received() ||
-        global_state_get_runstate() == RUN_STATE_RUNNING) {
-        if (autostart) {
-            vm_start();
-        } else {
-            runstate_set(RUN_STATE_PAUSED);
-        }
-    } else if (migration_incoming_colo_enabled()) {
+    if (migration_incoming_colo_enabled()) {
         migration_incoming_disable_colo();
+        /* COLO should always have autostart=1 or we can enforce it here */
+    }
+
+    if (autostart) {
+        RunState run_state = global_state_get_runstate();
         vm_start();
+        switch (run_state) {
+        case RUN_STATE_RUNNING:
+            break;
+        case RUN_STATE_SUSPENDED:
+            qemu_system_suspend();
+            break;
+        default:
+            runstate_set(run_state);
+            break;
+        }
     } else {
-        runstate_set(global_state_get_runstate());
+        runstate_set(RUN_STATE_PAUSED);
     }
===8<===

IIUC this can drop qemu_system_start_on_wakeup_request() along with the
other global var.  Would something like it work for us?

-- 
Peter Xu


