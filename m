Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B21373E8A8
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 20:28:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDqwF-00064F-As; Mon, 26 Jun 2023 14:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qDqwD-000643-79
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 14:27:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qDqwB-0007Ws-9A
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 14:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687804057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vxDl6opOfHeJN+Yv5mbnG+HSUoJdxXTil9bsHR1x/lg=;
 b=KCeU2SRMhIfC/grc3QkfCcYPOL6vLz30K1gGfFA6cuWZW55nhznPEn93YJYyMTfZt8R9oA
 oWlRmoyytPcgtAsnlCsjhvYmwA1vG2z+mmVdIctLJMKfCYXT5OZUhJZ7PETBZMu+FbKY3d
 /FnqfwvLjXXZFOJ18gLsnit3MlA30FY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-y_L73_F3NdyInSQ-bRXLaw-1; Mon, 26 Jun 2023 14:27:35 -0400
X-MC-Unique: y_L73_F3NdyInSQ-bRXLaw-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-401df9d2dc4so1658681cf.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 11:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687804054; x=1690396054;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vxDl6opOfHeJN+Yv5mbnG+HSUoJdxXTil9bsHR1x/lg=;
 b=XpSWYgFSQwRk53660Nrk9of04Fz6TwxWiMgPI7aTsmhJi+R0iDYrVp8AVn246C9n46
 K4IrT8qteVKnA/Z4VJ5MsMe2dfLh+qpgvqgKy6HN8xNQIawtL1Hm4eD4IyqJemo6SKOT
 O4xeKhe2BfJBaDMRCmSIxXQG3hs6i8XhX6oKFI7TK+tJ+JczKzLJeAYt1lk8Jhw/Q3PY
 Ji9Jr9hak7mO8XYJCi88rzkdZ6cmd8olf607ZgKxZcmy8CCLo+hqe6dvc76YT/nAvlqZ
 GgKR9VjxdKZL8ctGl1HZh2Z6UEn+KaffWRx5NPY+dDD6ftVqEvPld36TYXZbjH+zoaZT
 1P0A==
X-Gm-Message-State: AC+VfDw8bsQrGz/RF1xKnS0zV4XFwDrO+pMmlYpMvSU5d64VXMbZQqRw
 NF1R8T6Osb2MS50YtmprLKZy8KVGQc8NqVw5wtbNhiEK/6uBxzytMwkQu9msXIy4kzgnumvI40e
 5cWlTHbBvNdNiwxA=
X-Received: by 2002:a05:622a:130e:b0:400:9ac5:e16e with SMTP id
 v14-20020a05622a130e00b004009ac5e16emr8746199qtk.5.1687804054036; 
 Mon, 26 Jun 2023 11:27:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5vd4YtGoJn1Z7GX/DUEOBtdoFmZlDKrpwq/PeZDLiTbCFEo531ixNm/TpBL5OKtXDlKrxjNQ==
X-Received: by 2002:a05:622a:130e:b0:400:9ac5:e16e with SMTP id
 v14-20020a05622a130e00b004009ac5e16emr8746188qtk.5.1687804053674; 
 Mon, 26 Jun 2023 11:27:33 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 i12-20020ac8764c000000b00400a9edf297sm1305574qtr.26.2023.06.26.11.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 11:27:33 -0700 (PDT)
Date: Mon, 26 Jun 2023 14:27:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH V1 2/3] migration: fix suspended runstate
Message-ID: <ZJnYlApmsQLXBK/3@x1n>
References: <1686860800-34667-1-git-send-email-steven.sistare@oracle.com>
 <1686860800-34667-3-git-send-email-steven.sistare@oracle.com>
 <ZJIeR7svXvtHdgs4@x1n>
 <6adfae20-60fe-ae08-1685-160b2a1efab5@oracle.com>
 <ZJNdcyrv0TzFUKMy@x1n>
 <340b5f58-0924-6f8e-6f82-0462a5cc22cc@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <340b5f58-0924-6f8e-6f82-0462a5cc22cc@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Fri, Jun 23, 2023 at 02:25:05PM -0400, Steven Sistare wrote:
> On 6/21/2023 4:28 PM, Peter Xu wrote:
> > On Wed, Jun 21, 2023 at 03:15:42PM -0400, Steven Sistare wrote:
> >> On 6/20/2023 5:46 PM, Peter Xu wrote:
> >>> On Thu, Jun 15, 2023 at 01:26:39PM -0700, Steve Sistare wrote:
> >>>> Migration of a guest in the suspended state is broken.  The incoming
> >>>> migration code automatically tries to wake the guest, which IMO is
> >>>> wrong -- the guest should end migration in the same state it started.
> >>>> Further, the wakeup is done by calling qemu_system_wakeup_request(), which
> >>>> bypasses vm_start().  The guest appears to be in the running state, but
> >>>> it is not.
> >>>>
> >>>> To fix, leave the guest in the suspended state, but call
> >>>> qemu_system_start_on_wakeup_request() so the guest is properly resumed
> >>>> later, when the client sends a system_wakeup command.
> >>>>
> >>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >>>> ---
> >>>>  migration/migration.c | 11 ++++-------
> >>>>  softmmu/runstate.c    |  1 +
> >>>>  2 files changed, 5 insertions(+), 7 deletions(-)
> >>>>
> >>>> diff --git a/migration/migration.c b/migration/migration.c
> >>>> index 17b4b47..851fe6d 100644
> >>>> --- a/migration/migration.c
> >>>> +++ b/migration/migration.c
> >>>> @@ -496,6 +496,10 @@ static void process_incoming_migration_bh(void *opaque)
> >>>>          vm_start();
> >>>>      } else {
> >>>>          runstate_set(global_state_get_runstate());
> >>>> +        if (runstate_check(RUN_STATE_SUSPENDED)) {
> >>>> +            /* Force vm_start to be called later. */
> >>>> +            qemu_system_start_on_wakeup_request();
> >>>> +        }
> >>>
> >>> Is this really needed, along with patch 1?
> >>>
> >>> I have a very limited knowledge on suspension, so I'm prone to making
> >>> mistakes..
> >>>
> >>> But from what I read this, qemu_system_wakeup_request() (existing one, not
> >>> after patch 1 applied) will setup wakeup_reason and kick the main thread
> >>> using qemu_notify_event().  Then IIUC the e.g. vcpu wakeups will be done in
> >>> the main thread later on after qemu_wakeup_requested() returns true.
> >>
> >> Correct, here:
> >>
> >>     if (qemu_wakeup_requested()) {
> >>         pause_all_vcpus();
> >>         qemu_system_wakeup();
> >>         notifier_list_notify(&wakeup_notifiers, &wakeup_reason);
> >>         wakeup_reason = QEMU_WAKEUP_REASON_NONE;
> >>         resume_all_vcpus();
> >>         qapi_event_send_wakeup();
> >>     }
> >>
> >> However, that is not sufficient, because vm_start() was never called on the incoming
> >> side.  vm_start calls the vm state notifiers for RUN_STATE_RUNNING, among other things.
> >>
> >>
> >> Without my fixes, it "works" because the outgoing migration automatically wakes a suspended
> >> guest, which sets the state to running, which is saved in global state:
> >>
> >>     void migration_completion(MigrationState *s)
> >>         qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
> >>         global_state_store()
> >>
> >> Then the incoming migration calls vm_start here:
> >>
> >>     migration/migration.c
> >>         if (!global_state_received() ||
> >>             global_state_get_runstate() == RUN_STATE_RUNNING) {
> >>             if (autostart) {
> >>                 vm_start();
> >>
> >> vm_start must be called for correctness.
> > 
> > I see.  Though I had a feeling that this is still not the right way to do,
> > at least not as clean.
> > 
> > One question is, would above work for postcopy when VM is suspended during
> > the switchover?
> 
> Good catch, that is broken.
> I added qemu_system_start_on_wakeup_request to loadvm_postcopy_handle_run_bh
> and now it works.
> 
>     if (global_state_get_runstate() == RUN_STATE_RUNNING) {
>         if (autostart) {
>             vm_start();
>         } else {
>             runstate_set(RUN_STATE_PAUSED);
>         }
>     } else {
>         runstate_set(global_state_get_runstate());
>         if (runstate_check(RUN_STATE_SUSPENDED)) {
>             qemu_system_start_on_wakeup_request();
>         }
>     }
> 
> > I think I see your point that vm_start() (mostly vm_prepare_start())
> > contains a bunch of operations that maybe we must have before starting the
> > VM, but then.. should we just make that vm_start() unconditional when
> > loading VM completes?  I just don't see anything won't need it (besides
> > -S), even COLO.
> > 
> > So I'm wondering about something like this:
> > 
> > ===8<===
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -481,19 +481,28 @@ static void process_incoming_migration_bh(void *opaque)
> >  
> >      dirty_bitmap_mig_before_vm_start();
> >  
> > -    if (!global_state_received() ||
> > -        global_state_get_runstate() == RUN_STATE_RUNNING) {
> > -        if (autostart) {
> > -            vm_start();
> > -        } else {
> > -            runstate_set(RUN_STATE_PAUSED);
> > -        }
> > -    } else if (migration_incoming_colo_enabled()) {
> > +    if (migration_incoming_colo_enabled()) {
> >          migration_incoming_disable_colo();
> > +        /* COLO should always have autostart=1 or we can enforce it here */
> > +    }
> > +
> > +    if (autostart) {
> > +        RunState run_state = global_state_get_runstate();
> >          vm_start();
> 
> This will resume the guest for a brief time, against the user's wishes.  Not OK IMO.

Ah okay..

Can we do whatever we need in vm_prepare_start(), then? I assume these
chunks are needed:

    /*
     * WHPX accelerator needs to know whether we are going to step
     * any CPUs, before starting the first one.
     */
    if (cpus_accel->synchronize_pre_resume) {
        cpus_accel->synchronize_pre_resume(step_pending);
    }

    /* We are sending this now, but the CPUs will be resumed shortly later */
    qapi_event_send_resume();

    cpu_enable_ticks();

While these may not be needed, but instead only needed if RUN_STATE_RUNNING
below (runstate_set() will be needed regardless):

    runstate_set(RUN_STATE_RUNNING);
    vm_state_notify(1, RUN_STATE_RUNNING);

So here's another of my attempt (this time also taking
!global_state_received() into account)...

    RunState run_state;

    if (migration_incoming_colo_enabled()) {
        migration_incoming_disable_colo();
    }

    if (!global_state_received()) {
        run_state = RUN_STATE_RUNNING;
    } else {
        run_state = global_state_get_runstate();
    }

    if (autostart) {
        /* Part of vm_prepare_start(), may isolate into a helper? */
        if (cpus_accel->synchronize_pre_resume) {
            cpus_accel->synchronize_pre_resume(step_pending);
        }
        qapi_event_send_resume();
        cpu_enable_ticks();
        /* Setup the runstate on src */
        runstate_set(run_state);
        if (run_state == RUN_STATE_RUNNING) {
            vm_state_notify(1, RUN_STATE_RUNNING);
        }
    } else {
        runstate_set(RUN_STATE_PAUSED);
    }

The whole idea is still do whatever needed here besides resuming the vcpus,
rather than leaving the whole vm_start() into system wakeup.  It then can
avoid touching the system wakeup code which seems cleaner.

> > IIUC this can drop qemu_system_start_on_wakeup_request() along with the
> > other global var.  Would something like it work for us?
> 
> Afraid not.  start_on_wake is the only correct solution I can think of.

Please check again above, I just hope we can avoid yet another global to
QEMU if possible.

Thanks,

-- 
Peter Xu


