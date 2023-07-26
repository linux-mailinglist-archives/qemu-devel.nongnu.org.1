Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B40764078
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 22:26:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOkyA-0003h6-5Q; Wed, 26 Jul 2023 16:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qOky0-0003gs-Rf
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 16:18:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qOkxz-0001vL-25
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 16:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690402718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XTVPteMo2ZvxhnYY09/pE9LMsUOwSuVQ1FfT4nB5RO0=;
 b=gt3venKF/YJV7olkWqz4i+8reIW5KzSlx+EfTO+V6+bCjSkoKIUecKmA6xZC4eODQu1cqs
 wkaXYyrfZa+B8bkMzuWe3cC/ZwtbwxnxTMotpXP5DoMxc9cMpYzK+inTFfXU8x+xRQ9WR8
 4Anw1yIQl5Wt4m0nf0b4NTsibPGHDaw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-dJk80UZ4NdGuRewCfM91OA-1; Wed, 26 Jul 2023 16:18:36 -0400
X-MC-Unique: dJk80UZ4NdGuRewCfM91OA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-63cebe9238bso509426d6.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 13:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690402715; x=1691007515;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XTVPteMo2ZvxhnYY09/pE9LMsUOwSuVQ1FfT4nB5RO0=;
 b=Ky5sJ0+X3HlrxXxVfHH2kAF8UwlrKJPX5NFajX+GuXnf92hz9LxldAlVXRlTUOm80R
 yxw3y4emphjJeuWOGYoZKgfDyWyvmxYFm+6DhNPtsuS7+94TKtLr6VKyFcZeMFfTaUFR
 lIVF5KqGsaxn7220IxKz8H2VBmjov0fYEErPO+p4vatlg/A55FSEMflOFY5KmDOJyeil
 /otGMaX2aT75I3uCzbCVlMLWn2qrH7k7MQ/Zr5Hgp0nH45rCKcRaZSB8vjdUZii7JxFi
 Jnw46b3uZ7QTAko/if54XEuiDaXklsJd6WXCp0j6mik7XVbwTjCR1a+LRGt9wtsi0kjz
 Ugqg==
X-Gm-Message-State: ABy/qLZPscnov3Gx9csm4lRCn6HQe6UduwdRK2raE7ukbdcgrmSPMCUx
 8JTo0nv7U3mA4V+/MV9MIDJvA2XBNtMX0kGeuZCM2DQRjv4cchmTy+7OqRD6D9oh7/ry/ZD0JkB
 mdjJFdPldiZqvdzLx2a2dWs8=
X-Received: by 2002:ad4:5fc9:0:b0:625:86ed:8ab4 with SMTP id
 jq9-20020ad45fc9000000b0062586ed8ab4mr3539544qvb.3.1690402715383; 
 Wed, 26 Jul 2023 13:18:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEDHtqp5YawOj78umr2EkIpPC4swhQ75cLnvE6hnSDPf+0C9+CeXY7asDIMYLCkXUZyI/t+ug==
X-Received: by 2002:ad4:5fc9:0:b0:625:86ed:8ab4 with SMTP id
 jq9-20020ad45fc9000000b0062586ed8ab4mr3539515qvb.3.1690402715035; 
 Wed, 26 Jul 2023 13:18:35 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 h15-20020a05620a13ef00b007683d78ce4csm4594961qkl.84.2023.07.26.13.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 13:18:33 -0700 (PDT)
Date: Wed, 26 Jul 2023 16:18:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH V1 2/3] migration: fix suspended runstate
Message-ID: <ZMF/ly/FyavT9AMJ@x1n>
References: <1686860800-34667-1-git-send-email-steven.sistare@oracle.com>
 <1686860800-34667-3-git-send-email-steven.sistare@oracle.com>
 <ZJIeR7svXvtHdgs4@x1n>
 <6adfae20-60fe-ae08-1685-160b2a1efab5@oracle.com>
 <ZJNdcyrv0TzFUKMy@x1n>
 <340b5f58-0924-6f8e-6f82-0462a5cc22cc@oracle.com>
 <ZJnYlApmsQLXBK/3@x1n>
 <918d1568-fa1f-9ebe-59f9-3e5e73200faf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <918d1568-fa1f-9ebe-59f9-3e5e73200faf@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 30, 2023 at 09:50:41AM -0400, Steven Sistare wrote:
> On 6/26/2023 2:27 PM, Peter Xu wrote:
> > On Fri, Jun 23, 2023 at 02:25:05PM -0400, Steven Sistare wrote:
> >> On 6/21/2023 4:28 PM, Peter Xu wrote:
> >>> On Wed, Jun 21, 2023 at 03:15:42PM -0400, Steven Sistare wrote:
> >>>> On 6/20/2023 5:46 PM, Peter Xu wrote:
> >>>>> On Thu, Jun 15, 2023 at 01:26:39PM -0700, Steve Sistare wrote:
> >>>>>> Migration of a guest in the suspended state is broken.  The incoming
> >>>>>> migration code automatically tries to wake the guest, which IMO is
> >>>>>> wrong -- the guest should end migration in the same state it started.
> >>>>>> Further, the wakeup is done by calling qemu_system_wakeup_request(), which
> >>>>>> bypasses vm_start().  The guest appears to be in the running state, but
> >>>>>> it is not.
> >>>>>>
> >>>>>> To fix, leave the guest in the suspended state, but call
> >>>>>> qemu_system_start_on_wakeup_request() so the guest is properly resumed
> >>>>>> later, when the client sends a system_wakeup command.
> >>>>>>
> >>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >>>>>> ---
> >>>>>>  migration/migration.c | 11 ++++-------
> >>>>>>  softmmu/runstate.c    |  1 +
> >>>>>>  2 files changed, 5 insertions(+), 7 deletions(-)
> >>>>>>
> >>>>>> diff --git a/migration/migration.c b/migration/migration.c
> >>>>>> index 17b4b47..851fe6d 100644
> >>>>>> --- a/migration/migration.c
> >>>>>> +++ b/migration/migration.c
> >>>>>> @@ -496,6 +496,10 @@ static void process_incoming_migration_bh(void *opaque)
> >>>>>>          vm_start();
> >>>>>>      } else {
> >>>>>>          runstate_set(global_state_get_runstate());
> >>>>>> +        if (runstate_check(RUN_STATE_SUSPENDED)) {
> >>>>>> +            /* Force vm_start to be called later. */
> >>>>>> +            qemu_system_start_on_wakeup_request();
> >>>>>> +        }
> >>>>>
> >>>>> Is this really needed, along with patch 1?
> >>>>>
> >>>>> I have a very limited knowledge on suspension, so I'm prone to making
> >>>>> mistakes..
> >>>>>
> >>>>> But from what I read this, qemu_system_wakeup_request() (existing one, not
> >>>>> after patch 1 applied) will setup wakeup_reason and kick the main thread
> >>>>> using qemu_notify_event().  Then IIUC the e.g. vcpu wakeups will be done in
> >>>>> the main thread later on after qemu_wakeup_requested() returns true.
> >>>>
> >>>> Correct, here:
> >>>>
> >>>>     if (qemu_wakeup_requested()) {
> >>>>         pause_all_vcpus();
> >>>>         qemu_system_wakeup();
> >>>>         notifier_list_notify(&wakeup_notifiers, &wakeup_reason);
> >>>>         wakeup_reason = QEMU_WAKEUP_REASON_NONE;
> >>>>         resume_all_vcpus();
> >>>>         qapi_event_send_wakeup();
> >>>>     }
> >>>>
> >>>> However, that is not sufficient, because vm_start() was never called on the incoming
> >>>> side.  vm_start calls the vm state notifiers for RUN_STATE_RUNNING, among other things.
> >>>>
> >>>>
> >>>> Without my fixes, it "works" because the outgoing migration automatically wakes a suspended
> >>>> guest, which sets the state to running, which is saved in global state:
> >>>>
> >>>>     void migration_completion(MigrationState *s)
> >>>>         qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
> >>>>         global_state_store()
> >>>>
> >>>> Then the incoming migration calls vm_start here:
> >>>>
> >>>>     migration/migration.c
> >>>>         if (!global_state_received() ||
> >>>>             global_state_get_runstate() == RUN_STATE_RUNNING) {
> >>>>             if (autostart) {
> >>>>                 vm_start();
> >>>>
> >>>> vm_start must be called for correctness.
> >>>
> >>> I see.  Though I had a feeling that this is still not the right way to do,
> >>> at least not as clean.
> >>>
> >>> One question is, would above work for postcopy when VM is suspended during
> >>> the switchover?
> >>
> >> Good catch, that is broken.
> >> I added qemu_system_start_on_wakeup_request to loadvm_postcopy_handle_run_bh
> >> and now it works.
> >>
> >>     if (global_state_get_runstate() == RUN_STATE_RUNNING) {
> >>         if (autostart) {
> >>             vm_start();
> >>         } else {
> >>             runstate_set(RUN_STATE_PAUSED);
> >>         }
> >>     } else {
> >>         runstate_set(global_state_get_runstate());
> >>         if (runstate_check(RUN_STATE_SUSPENDED)) {
> >>             qemu_system_start_on_wakeup_request();
> >>         }
> >>     }
> >>
> >>> I think I see your point that vm_start() (mostly vm_prepare_start())
> >>> contains a bunch of operations that maybe we must have before starting the
> >>> VM, but then.. should we just make that vm_start() unconditional when
> >>> loading VM completes?  I just don't see anything won't need it (besides
> >>> -S), even COLO.
> >>>
> >>> So I'm wondering about something like this:
> >>>
> >>> ===8<===
> >>> --- a/migration/migration.c
> >>> +++ b/migration/migration.c
> >>> @@ -481,19 +481,28 @@ static void process_incoming_migration_bh(void *opaque)
> >>>  
> >>>      dirty_bitmap_mig_before_vm_start();
> >>>  
> >>> -    if (!global_state_received() ||
> >>> -        global_state_get_runstate() == RUN_STATE_RUNNING) {
> >>> -        if (autostart) {
> >>> -            vm_start();
> >>> -        } else {
> >>> -            runstate_set(RUN_STATE_PAUSED);
> >>> -        }
> >>> -    } else if (migration_incoming_colo_enabled()) {
> >>> +    if (migration_incoming_colo_enabled()) {
> >>>          migration_incoming_disable_colo();
> >>> +        /* COLO should always have autostart=1 or we can enforce it here */
> >>> +    }
> >>> +
> >>> +    if (autostart) {
> >>> +        RunState run_state = global_state_get_runstate();
> >>>          vm_start();
> >>
> >> This will resume the guest for a brief time, against the user's wishes.  Not OK IMO.
> > 
> > Ah okay..
> > 
> > Can we do whatever we need in vm_prepare_start(), then? I assume these
> > chunks are needed:
> > 
> >     /*
> >      * WHPX accelerator needs to know whether we are going to step
> >      * any CPUs, before starting the first one.
> >      */
> >     if (cpus_accel->synchronize_pre_resume) {
> >         cpus_accel->synchronize_pre_resume(step_pending);
> >     }
> > 
> >     /* We are sending this now, but the CPUs will be resumed shortly later */
> >     qapi_event_send_resume();
> > 
> >     cpu_enable_ticks();
> > 
> > While these may not be needed, but instead only needed if RUN_STATE_RUNNING
> > below (runstate_set() will be needed regardless):
> > 
> >     runstate_set(RUN_STATE_RUNNING);
> >     vm_state_notify(1, RUN_STATE_RUNNING);
> > 
> > So here's another of my attempt (this time also taking
> > !global_state_received() into account)...
> > 
> >     RunState run_state;
> > 
> >     if (migration_incoming_colo_enabled()) {
> >         migration_incoming_disable_colo();
> >     }
> > 
> >     if (!global_state_received()) {
> >         run_state = RUN_STATE_RUNNING;
> >     } else {
> >         run_state = global_state_get_runstate();
> >     }
> > 
> >     if (autostart) {
> >         /* Part of vm_prepare_start(), may isolate into a helper? */
> >         if (cpus_accel->synchronize_pre_resume) {
> >             cpus_accel->synchronize_pre_resume(step_pending);
> >         }
> >         qapi_event_send_resume();
> >         cpu_enable_ticks();
> >         /* Setup the runstate on src */
> >         runstate_set(run_state);
> >         if (run_state == RUN_STATE_RUNNING) {
> >             vm_state_notify(1, RUN_STATE_RUNNING);
> >         }
> >     } else {
> >         runstate_set(RUN_STATE_PAUSED);
> >     }
> > 
> > The whole idea is still do whatever needed here besides resuming the vcpus,
> > rather than leaving the whole vm_start() into system wakeup.  It then can
> > avoid touching the system wakeup code which seems cleaner.
> 
> The problem is that some actions cannot be performed at migration finish time,
> such as vm_state_notify RUN_STATE_RUNNING.  The wakeup code called later still 
> needs to know that vm_state_notify has not been called, and call it.

Sorry, very late reply..

Can we just call vm_state_notify() earlier?

I know I'm not familiar with this code at all.. but I'm still not fully
convinced a new global is needed for this.  IMHO QEMU becomes harder to
maintain with such globals, while already tons exist.

> 
> I just posted a new series with a cleaner wakeup, but it still uses a global.

I think the new version does not apply anymore to master.  Do you have a
tree somewhere?

Thanks,

-- 
Peter Xu


