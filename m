Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC61A73EB05
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 21:13:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrcd-0004fH-JL; Mon, 26 Jun 2023 15:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qDrcH-0004YI-OT
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 15:11:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qDrcF-0002NK-87
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 15:11:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687806670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CJDr5PpgpJy/wBy/FYWogcEsG3khBqMxYb+2VFW9/TY=;
 b=QGm0gNptkiHzAmirjRn7hlOrRmebtHt+mIYTR2oS1BZDSlpEtc3yRnmWneGZjMNVcRzf5O
 4CtbwNdig74AIf2L7MvnlvAGnJAOeMTESs9p/npF5B4M43MvORj4sQsQzKsq6zxTAhnDKE
 0FBhhuDxPfiANFYY+r92zSz93p4CFtg=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-MV76pQfsNq-kWVbxl6JbCQ-1; Mon, 26 Jun 2023 15:11:07 -0400
X-MC-Unique: MV76pQfsNq-kWVbxl6JbCQ-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-560c19a43e2so432235eaf.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 12:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687806667; x=1690398667;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CJDr5PpgpJy/wBy/FYWogcEsG3khBqMxYb+2VFW9/TY=;
 b=VCGxlLHIHdCMSHz2fnmkxd7RjVsEJKwY/bIfEPBpwx7HlndA+I882H5ALj4LudHVQ5
 uOffUFm+2mnRxatKezfpU7k3m3z1DcSD+qiJqChxYIGM7Otg5UPxHYPwmVCjn989D4tw
 CPSfoFwss7oPWwhRj0F0wTKZbeOhqVgupWHWBrFJvDLcPbVcLGNo9qJXkac2xWTrPhb1
 iZPslyLS2/vULJO3XIjpuRHuWcxRmU4qwuS/ipZqb0XoP1uyjbhs32Vh0DhRBHFNzuUN
 aXFQJyLck31RnTq7EbBOQ3X+xa3Qbhnkt+7qEtK3bBZjKee2KAb5VhKN/QzoQrFM5beT
 4aMQ==
X-Gm-Message-State: AC+VfDztk9wgHjBkMI+XjXYFJzyyI66nQneRmqtubEX6iXOqXdyslZVI
 W8NJXV6jHA6Dp0zfNWFdbloLv6Jr9z08apGJQxRqPpW2Eq1Q0N55GFKT6XL5Fidnq4Fze41vXXM
 p6rNMbj0ukpb0oVE=
X-Received: by 2002:a05:6359:6395:b0:132:dfd9:b688 with SMTP id
 sg21-20020a056359639500b00132dfd9b688mr3994244rwb.2.1687806667050; 
 Mon, 26 Jun 2023 12:11:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ItsZd8MG6FT/y2sxyWwaUth/XT7bYttppBiKVtgzdjxmm0xhZO7CmYWfFMsSsIxPq18VC5w==
X-Received: by 2002:a05:6359:6395:b0:132:dfd9:b688 with SMTP id
 sg21-20020a056359639500b00132dfd9b688mr3994225rwb.2.1687806666645; 
 Mon, 26 Jun 2023 12:11:06 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 t25-20020a05622a181900b003f6be76a5c1sm3423090qtc.6.2023.06.26.12.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 12:11:06 -0700 (PDT)
Date: Mon, 26 Jun 2023 15:11:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH V1 2/3] migration: fix suspended runstate
Message-ID: <ZJniyUhF9rTMUGU3@x1n>
References: <1686860800-34667-1-git-send-email-steven.sistare@oracle.com>
 <1686860800-34667-3-git-send-email-steven.sistare@oracle.com>
 <ZJIeR7svXvtHdgs4@x1n>
 <6adfae20-60fe-ae08-1685-160b2a1efab5@oracle.com>
 <ZJNdcyrv0TzFUKMy@x1n>
 <340b5f58-0924-6f8e-6f82-0462a5cc22cc@oracle.com>
 <ZJnYlApmsQLXBK/3@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZJnYlApmsQLXBK/3@x1n>
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

On Mon, Jun 26, 2023 at 02:27:32PM -0400, Peter Xu wrote:
> On Fri, Jun 23, 2023 at 02:25:05PM -0400, Steven Sistare wrote:
> > On 6/21/2023 4:28 PM, Peter Xu wrote:
> > > On Wed, Jun 21, 2023 at 03:15:42PM -0400, Steven Sistare wrote:
> > >> On 6/20/2023 5:46 PM, Peter Xu wrote:
> > >>> On Thu, Jun 15, 2023 at 01:26:39PM -0700, Steve Sistare wrote:
> > >>>> Migration of a guest in the suspended state is broken.  The incoming
> > >>>> migration code automatically tries to wake the guest, which IMO is
> > >>>> wrong -- the guest should end migration in the same state it started.
> > >>>> Further, the wakeup is done by calling qemu_system_wakeup_request(), which
> > >>>> bypasses vm_start().  The guest appears to be in the running state, but
> > >>>> it is not.
> > >>>>
> > >>>> To fix, leave the guest in the suspended state, but call
> > >>>> qemu_system_start_on_wakeup_request() so the guest is properly resumed
> > >>>> later, when the client sends a system_wakeup command.
> > >>>>
> > >>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > >>>> ---
> > >>>>  migration/migration.c | 11 ++++-------
> > >>>>  softmmu/runstate.c    |  1 +
> > >>>>  2 files changed, 5 insertions(+), 7 deletions(-)
> > >>>>
> > >>>> diff --git a/migration/migration.c b/migration/migration.c
> > >>>> index 17b4b47..851fe6d 100644
> > >>>> --- a/migration/migration.c
> > >>>> +++ b/migration/migration.c
> > >>>> @@ -496,6 +496,10 @@ static void process_incoming_migration_bh(void *opaque)
> > >>>>          vm_start();
> > >>>>      } else {
> > >>>>          runstate_set(global_state_get_runstate());
> > >>>> +        if (runstate_check(RUN_STATE_SUSPENDED)) {
> > >>>> +            /* Force vm_start to be called later. */
> > >>>> +            qemu_system_start_on_wakeup_request();
> > >>>> +        }
> > >>>
> > >>> Is this really needed, along with patch 1?
> > >>>
> > >>> I have a very limited knowledge on suspension, so I'm prone to making
> > >>> mistakes..
> > >>>
> > >>> But from what I read this, qemu_system_wakeup_request() (existing one, not
> > >>> after patch 1 applied) will setup wakeup_reason and kick the main thread
> > >>> using qemu_notify_event().  Then IIUC the e.g. vcpu wakeups will be done in
> > >>> the main thread later on after qemu_wakeup_requested() returns true.
> > >>
> > >> Correct, here:
> > >>
> > >>     if (qemu_wakeup_requested()) {
> > >>         pause_all_vcpus();
> > >>         qemu_system_wakeup();
> > >>         notifier_list_notify(&wakeup_notifiers, &wakeup_reason);
> > >>         wakeup_reason = QEMU_WAKEUP_REASON_NONE;
> > >>         resume_all_vcpus();
> > >>         qapi_event_send_wakeup();
> > >>     }
> > >>
> > >> However, that is not sufficient, because vm_start() was never called on the incoming
> > >> side.  vm_start calls the vm state notifiers for RUN_STATE_RUNNING, among other things.
> > >>
> > >>
> > >> Without my fixes, it "works" because the outgoing migration automatically wakes a suspended
> > >> guest, which sets the state to running, which is saved in global state:
> > >>
> > >>     void migration_completion(MigrationState *s)
> > >>         qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
> > >>         global_state_store()
> > >>
> > >> Then the incoming migration calls vm_start here:
> > >>
> > >>     migration/migration.c
> > >>         if (!global_state_received() ||
> > >>             global_state_get_runstate() == RUN_STATE_RUNNING) {
> > >>             if (autostart) {
> > >>                 vm_start();
> > >>
> > >> vm_start must be called for correctness.
> > > 
> > > I see.  Though I had a feeling that this is still not the right way to do,
> > > at least not as clean.
> > > 
> > > One question is, would above work for postcopy when VM is suspended during
> > > the switchover?
> > 
> > Good catch, that is broken.
> > I added qemu_system_start_on_wakeup_request to loadvm_postcopy_handle_run_bh
> > and now it works.
> > 
> >     if (global_state_get_runstate() == RUN_STATE_RUNNING) {
> >         if (autostart) {
> >             vm_start();
> >         } else {
> >             runstate_set(RUN_STATE_PAUSED);
> >         }
> >     } else {
> >         runstate_set(global_state_get_runstate());
> >         if (runstate_check(RUN_STATE_SUSPENDED)) {
> >             qemu_system_start_on_wakeup_request();
> >         }
> >     }
> > 
> > > I think I see your point that vm_start() (mostly vm_prepare_start())
> > > contains a bunch of operations that maybe we must have before starting the
> > > VM, but then.. should we just make that vm_start() unconditional when
> > > loading VM completes?  I just don't see anything won't need it (besides
> > > -S), even COLO.
> > > 
> > > So I'm wondering about something like this:
> > > 
> > > ===8<===
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -481,19 +481,28 @@ static void process_incoming_migration_bh(void *opaque)
> > >  
> > >      dirty_bitmap_mig_before_vm_start();
> > >  
> > > -    if (!global_state_received() ||
> > > -        global_state_get_runstate() == RUN_STATE_RUNNING) {
> > > -        if (autostart) {
> > > -            vm_start();
> > > -        } else {
> > > -            runstate_set(RUN_STATE_PAUSED);
> > > -        }
> > > -    } else if (migration_incoming_colo_enabled()) {
> > > +    if (migration_incoming_colo_enabled()) {
> > >          migration_incoming_disable_colo();
> > > +        /* COLO should always have autostart=1 or we can enforce it here */
> > > +    }
> > > +
> > > +    if (autostart) {
> > > +        RunState run_state = global_state_get_runstate();
> > >          vm_start();
> > 
> > This will resume the guest for a brief time, against the user's wishes.  Not OK IMO.
> 
> Ah okay..
> 
> Can we do whatever we need in vm_prepare_start(), then? I assume these
> chunks are needed:
> 
>     /*
>      * WHPX accelerator needs to know whether we are going to step
>      * any CPUs, before starting the first one.
>      */
>     if (cpus_accel->synchronize_pre_resume) {
>         cpus_accel->synchronize_pre_resume(step_pending);
>     }
> 
>     /* We are sending this now, but the CPUs will be resumed shortly later */
>     qapi_event_send_resume();
> 
>     cpu_enable_ticks();
> 
> While these may not be needed, but instead only needed if RUN_STATE_RUNNING
> below (runstate_set() will be needed regardless):
> 
>     runstate_set(RUN_STATE_RUNNING);
>     vm_state_notify(1, RUN_STATE_RUNNING);
> 
> So here's another of my attempt (this time also taking
> !global_state_received() into account)...
> 
>     RunState run_state;
> 
>     if (migration_incoming_colo_enabled()) {
>         migration_incoming_disable_colo();
>     }
> 
>     if (!global_state_received()) {
>         run_state = RUN_STATE_RUNNING;
>     } else {
>         run_state = global_state_get_runstate();
>     }
> 
>     if (autostart) {
>         /* Part of vm_prepare_start(), may isolate into a helper? */
>         if (cpus_accel->synchronize_pre_resume) {
>             cpus_accel->synchronize_pre_resume(step_pending);
>         }
>         qapi_event_send_resume();
>         cpu_enable_ticks();
>         /* Setup the runstate on src */
>         runstate_set(run_state);
>         if (run_state == RUN_STATE_RUNNING) {
>             vm_state_notify(1, RUN_STATE_RUNNING);

And here I at least forgot:

              resume_all_vcpus();

The pesudo code just to illustrate the whole idea.  Definitely not tested
in any form, so sorry if it won't even compile..

>         }
>     } else {
>         runstate_set(RUN_STATE_PAUSED);
>     }
> 
> The whole idea is still do whatever needed here besides resuming the vcpus,
> rather than leaving the whole vm_start() into system wakeup.  It then can
> avoid touching the system wakeup code which seems cleaner.
> 
> > > IIUC this can drop qemu_system_start_on_wakeup_request() along with the
> > > other global var.  Would something like it work for us?
> > 
> > Afraid not.  start_on_wake is the only correct solution I can think of.
> 
> Please check again above, I just hope we can avoid yet another global to
> QEMU if possible.
> 
> Thanks,
> 
> -- 
> Peter Xu

-- 
Peter Xu


