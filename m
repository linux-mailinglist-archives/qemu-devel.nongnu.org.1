Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2946777FDB6
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 20:21:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWhaq-0007yV-9p; Thu, 17 Aug 2023 14:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qWhaW-0007x1-9q
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 14:19:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qWhaT-0006BD-Kp
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 14:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692296351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WYhf66rmTsU3eyxmz+pARUzKcUYoy9ZIOyREFKGqbls=;
 b=KeVC3qSb2oeyGX1jj/I7azz2V/TuYLG3ZDNKGc68tUYTwi7Q5ZVJw/VURGkBNXwDlHXqbC
 AIhEKbEmlgu5PeSypmtahg2FtMGVTvSg/Wl3e+Ip8n3g5dIby/meBCICbM60fUG+ma05jm
 ZYo0ktocwWux8y8Xi+COhAd5PprCLLI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-U20IUcPDNNeL40LWLQkg0Q-1; Thu, 17 Aug 2023 14:19:08 -0400
X-MC-Unique: U20IUcPDNNeL40LWLQkg0Q-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-645778904dfso55966d6.1
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 11:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692296348; x=1692901148;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WYhf66rmTsU3eyxmz+pARUzKcUYoy9ZIOyREFKGqbls=;
 b=cn6CsXSAYdFD213S8JrnASJulUu6HPAhanA92Qp7Rmr/kIDQq9gPOR8x63Nc291Wj/
 KFbyiFFCD/iLax5C1aYQpUc89LTy4BRI1KKpafA9PQWq+RRZ3UZ8D9w9XHhUGG1ZH1y9
 0cYbJpuu8kvLRIsoW39pqQRbg8wnSZRwfudkl1pnGg//XIDauPnscnuGZf6NFHwH/DJ3
 wTp5C2Ni/rwcKVEAOymf9ObVS904VrYiOzYFSKWmRFcb1fG1y3kxXXhqZc8FssNJk7ra
 pXSMETPAkfQk+nhY8ozitaRhnDlubi8/bxVhtv35MtfSZ6X129/8nz5I8offFyKpT7a9
 quNw==
X-Gm-Message-State: AOJu0Yxf0ay2gQHSOFSuuAOFhI56pSSddkUGWSMUBQuKd3j7IEDkGsNq
 n0wnVLf+lc4wFD2uPnO2H+yRWQbXiIhXhdOxZ0VFNjEdJBncH7TRAd6OPD5PVbiToIrUvjR8Z94
 eKDgNfA5MEhAD87g=
X-Received: by 2002:a05:6214:5016:b0:63c:f852:aa30 with SMTP id
 jo22-20020a056214501600b0063cf852aa30mr497872qvb.0.1692296347826; 
 Thu, 17 Aug 2023 11:19:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEDsL3mj8SJ71MnCJ0/SB4JT7p6Y6vKtSJzlywXMJtMszaDzPdeQMR+6R97KV3ROvmCzprDA==
X-Received: by 2002:a05:6214:5016:b0:63c:f852:aa30 with SMTP id
 jo22-20020a056214501600b0063cf852aa30mr497854qvb.0.1692296347476; 
 Thu, 17 Aug 2023 11:19:07 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 b20-20020a0cf054000000b0064a1fc557fbsm47652qvl.139.2023.08.17.11.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 11:19:07 -0700 (PDT)
Date: Thu, 17 Aug 2023 14:19:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH V1 2/3] migration: fix suspended runstate
Message-ID: <ZN5kmZdvc1Q1446r@x1n>
References: <ZJIeR7svXvtHdgs4@x1n>
 <6adfae20-60fe-ae08-1685-160b2a1efab5@oracle.com>
 <ZJNdcyrv0TzFUKMy@x1n>
 <340b5f58-0924-6f8e-6f82-0462a5cc22cc@oracle.com>
 <ZJnYlApmsQLXBK/3@x1n>
 <918d1568-fa1f-9ebe-59f9-3e5e73200faf@oracle.com>
 <ZMF/ly/FyavT9AMJ@x1n>
 <9383f79e-561a-aeab-5df9-0501e8d0a831@oracle.com>
 <ZNqClofhPByQP13H@x1n>
 <22f21854-9565-65af-7794-ee2007e7f1aa@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22f21854-9565-65af-7794-ee2007e7f1aa@oracle.com>
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

On Wed, Aug 16, 2023 at 01:48:13PM -0400, Steven Sistare wrote:
> On 8/14/2023 3:37 PM, Peter Xu wrote:
> > On Mon, Aug 14, 2023 at 02:53:56PM -0400, Steven Sistare wrote:
> >>> Can we just call vm_state_notify() earlier?
> >>
> >> We cannot.  The guest is not running yet, and will not be until later.
> >> We cannot call notifiers that perform actions that complete, or react to, 
> >> the guest entering a running state.
> > 
> > I tried to look at a few examples of the notifees and most of them I read
> > do not react to "vcpu running" but "vm running" (in which case I think
> > "suspended" mode falls into "vm running" case); most of them won't care on
> > the RunState parameter passed in, but only the bool "running".
> > 
> > In reality, when running=true, it must be RUNNING so far.
> > 
> > In that case does it mean we should notify right after the switchover,
> > since after migration the vm is indeed running only if the vcpus are not
> > during suspend?
> 
> I cannot parse your question, but maybe this answers it.
> If the outgoing VM is running and not suspended, then the incoming side
> tests for autostart==true and calls vm_start, which calls the notifiers,
> right after the switchover.

I meant IMHO SUSPENDED should be seen as "vm running" case to me, just like
RUNNING.  Then, we should invoke vm_prepare_start(), just need some touch
ups.

> 
> > One example (of possible issue) is vfio_vmstate_change(), where iiuc if we
> > try to suspend a VM it should keep to be VFIO_DEVICE_STATE_RUNNING for that
> > device; this kind of prove to me that SUSPEND is actually one of
> > running=true states.
> > 
> > If we postpone all notifiers here even after we switched over to dest qemu
> > to the next upcoming suspend wakeup, I think it means these devices will
> > not be in VFIO_DEVICE_STATE_RUNNING after switchover but perhaps
> > VFIO_DEVICE_STATE_STOP.
> 
> or VFIO_DEVICE_STATE_RESUMING, which is set in vfio_load_setup.
> AFAIK it is OK to remain in that state until wakeup is called later.

So let me provide another clue of why I think we should call
vm_prepare_start()..

Firstly, I think RESUME event should always be there right after we
switched over, no matter suspeneded or not.  I just noticed that your test
case would work because you put "wakeup" to be before RESUME.  I'm not sure
whether that's correct.  I'd bet people could rely on that RESUME to
identify the switchover.

More importantly, I'm wondering whether RTC should still be running during
the suspended mode?  Sorry again if my knowledge over there is just
limited, so correct me otherwise - but my understanding is during suspend
mode (s1 or s3, frankly I can't tell which one this belongs..), rtc should
still be running along with the system clock.  It means we _should_ at
least call cpu_enable_ticks() to enable rtc:

/*
 * enable cpu_get_ticks()
 * Caller must hold BQL which serves as mutex for vm_clock_seqlock.
 */
void cpu_enable_ticks(void)

I think that'll enable cpu_get_tsc() and make it start to work right.

> 
> > Ideally I think we should here call vm_state_notify() with running=true and
> > state=SUSPEND, but since I do see some hooks are not well prepared for
> > SUSPEND over running=true, I'd think we should on the safe side call
> > vm_state_notify(running=true, state=RUNNING) even for SUSPEND at switch
> > over phase.  With that IIUC it'll naturally work (e.g. when wakeup again
> > later we just need to call no notifiers).
> 
> Notifiers are just one piece, all the code in vm_prepare_start must be called.
> Is it correct to call all of that long before we actually resume the CPUs in
> wakeup?  I don't know, but what is the point?

The point is not only for cleaness (again, I really, really don't like that
new global.. sorry), but also now I think we should make the vm running.

> The wakeup code still needs
> modification to conditionally resume the vcpus.  The scheme would be roughly:
> 
>     loadvm_postcopy_handle_run_bh()
>         runstat = global_state_get_runstate();
>         if (runstate == RUN_STATE_RUNNING) {
>             vm_start()
>         } else if (runstate == RUN_STATE_SUSPENDED)
>             vm_prepare_start();   // the start of vm_start()
>         }
> 
>     qemu_system_wakeup_request()
>         if (some condition)
>             resume_all_vcpus();   // the remainder of vm_start()
>         else
>             runstate_set(RUN_STATE_RUNNING)

No it doesn't.  wakeup_reason is set there, main loop does the resuming.
See:

    if (qemu_wakeup_requested()) {
        pause_all_vcpus();
        qemu_system_wakeup();
        notifier_list_notify(&wakeup_notifiers, &wakeup_reason);
        wakeup_reason = QEMU_WAKEUP_REASON_NONE;
        resume_all_vcpus();
        qapi_event_send_wakeup();
    }

> 
> How is that better than my patches
>     [PATCH V3 01/10] vl: start on wakeup request
>     [PATCH V3 02/10] migration: preserve suspended runstate
> 
>     loadvm_postcopy_handle_run_bh()
>         runstate = global_state_get_runstate();
>         if (runstate == RUN_STATE_RUNNING)
>             vm_start()
>         else
>             runstate_set(runstate);    // eg RUN_STATE_SUSPENDED
> 
>     qemu_system_wakeup_request()
>         if (!vm_started)
>             vm_start();
>         else
>             runstate_set(RUN_STATE_RUNNING);
> 
> Recall this thread started with your comment "It then can avoid touching the 
> system wakeup code which seems cleaner".  We still need to touch the wakeup
> code.

Let me provide some code and reply to your new patchset inlines.

Thanks.

-- 
Peter Xu


