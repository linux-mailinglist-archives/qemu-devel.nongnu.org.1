Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAB37F4C49
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 17:23:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5pz6-000429-Ax; Wed, 22 Nov 2023 11:21:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r5pz4-00041z-Ev
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 11:21:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r5pz2-0003o0-HK
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 11:21:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700670106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+gW8xYF1GJlv/ngmU44ULSNyf63cpj+OmoLp/ALKxLk=;
 b=VL3h0riPVzLSzcB2IWN6Fyswtz+wQQk2AUKh8gPBGjWKsMXo1JMyz5fsjpU76n8MydK7KS
 r9V0wxvuwjfQOrKo5aim1xrVnjPsEyLPZGktutJgZudxPdKErn3c/kSsI6mTejt/D8XuZN
 TjYlX717TvUiT3jyGmORmZWVAvkIJc4=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-UKqsfQ5lM8SdA15rbm7DpA-1; Wed, 22 Nov 2023 11:21:45 -0500
X-MC-Unique: UKqsfQ5lM8SdA15rbm7DpA-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6d647a3f04bso640796a34.1
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 08:21:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700670104; x=1701274904;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+gW8xYF1GJlv/ngmU44ULSNyf63cpj+OmoLp/ALKxLk=;
 b=qPOTRCAedNiWT4aWoVXx8OP/wSHxBHxi27baOqhjYczMCn0wgR6HnU/+1KbeAsEKqS
 ZkJhT4GkCyvFkHWKRPEl+pbBKNtmp6D/BZA1mPagPjeMgfyaxmttl26U8Zj0sDKvkGWV
 DXsQQ7rbs7CV3hr8NPBEq3RF2xE4r7ZL1eCPK4aju0tBIeBkvU/S3NfrvcD0u9XReK8j
 CdaqTeaHe6LcEmPFp1CHbG+4ETrmLkEt9kgbZBmCYvQcCLD/QsLP5lr82UGf8L2tFLzv
 X3dCVQAQHgShg6KR7/57JxwKPvfjOw+8hfiRtfJLu4XKWa9vjZWZp+6c8SOOvimvMjeJ
 wsFw==
X-Gm-Message-State: AOJu0Ywhv0Mav5cKkB3B4RVKUFRMlNmuOHPVrCIFyueFEnxvyPwFFRG3
 nhdYlDA1QVAhABouyNphK+sLjSkyVF0SfLmBD2VBy6PJYtlUWuKV1tS8fMNkiWzpv+XJVWnD43Q
 1qCckmQ2GCZoP/Pg=
X-Received: by 2002:a9d:470a:0:b0:6d6:49ef:ef6f with SMTP id
 a10-20020a9d470a000000b006d649efef6fmr3187682otf.0.1700670104412; 
 Wed, 22 Nov 2023 08:21:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQk7DZU728kp8uJh7M6HSNyLOk8hMWkLondKS5i0+PEHcszce5ni7FgviYbs0pMM6v35jpRg==
X-Received: by 2002:a9d:470a:0:b0:6d6:49ef:ef6f with SMTP id
 a10-20020a9d470a000000b006d649efef6fmr3187661otf.0.1700670104105; 
 Wed, 22 Nov 2023 08:21:44 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 k27-20020a05620a0b9b00b0077d5cf2108esm1253019qkh.73.2023.11.22.08.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 08:21:43 -0800 (PST)
Date: Wed, 22 Nov 2023 11:21:42 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V5 02/12] cpus: stop vm in suspended state
Message-ID: <ZV4qlqxp8QVagcjG@x1n>
References: <1699900440-207345-1-git-send-email-steven.sistare@oracle.com>
 <1699900440-207345-3-git-send-email-steven.sistare@oracle.com>
 <ZVu6ohk8_8xzyL-x@x1n>
 <e32d4434-c877-4f98-ac76-da8fa292395c@oracle.com>
 <ZVvTUuNYzGgFcg4m@x1n> <ZV3L_ihDoQOAsT44@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZV3L_ihDoQOAsT44@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Nov 22, 2023 at 09:38:06AM +0000, Daniel P. Berrangé wrote:
> On Mon, Nov 20, 2023 at 04:44:50PM -0500, Peter Xu wrote:
> > On Mon, Nov 20, 2023 at 03:55:54PM -0500, Steven Sistare wrote:
> > > If we drop force, then all calls to vm_stop will completely stop the
> > > suspended state, eg an hmp "stop" command. This causes two problems.
> > > First, that is a change in user-visible behavior for something that
> > > currently works,
> > 
> > IMHO it depends on what should be the correct behavior.  IOW, when VM is in
> > SUSPENDED state and then the user sends "stop" QMP command, what should we
> > expect?
> 
> I would say that from a mgmtm app POV "stop" is initiating a state
> transition, from RUN_STATE_RUNNING to RUN_STATE_PAUSED and "cont"
> is doing the reverse from PAUSED to RUNNING.
> 
> It is a little more complicated than that as there are some other
> states like INMIGRATE that are conceptually equiv to RUNNING,
> and states where the transition simply doesn't make sense.

In the qemu impl, INMIGRATE is, imho, more equiv of PAUSED - do_vm_stop()
mostly ignores every state except RUNNING (putting bdrv operations aside).
IOW, anything besides "running" is treated as "not running".

But then Paolo fixed that in 1e9981465f ("qmp: handle stop/cont in
INMIGRATE state"), wiring that to autostart.

Now we seem to find that "suspended" should actually fall within (where
"vm" is running, but "vcpu" is not), and it seems we should treat "vm" and
"vcpu" differently.

> 
> So my question is if we're in "SUSPENDED" and someone issues "stop",
> what state do we go into, and perhaps more importantly what state
> do we go to in a subsequent "cont".

I think we must stop the "vm", not only the "vcpu".  I discussed this bit
in the other thread more or less: it's because qemu_system_wakeup_request()
can be called in many places, e.g. acpi_pm_tmr_timer().

It means even after the VM is "stop"ped by the admin QMP (where qmp_stop()
ignores SUSPENDED, keep the "vm" running), it can silently got waken up
without admin even noticing it.  I'm not sure what Libvirt will behave if
it suddenly receives a QAPI_EVENT_WAKEUP randomly after a "stop".

> 
> If you say SUSPENDED ---(stop)---> PAUSED ---(cont)---> SUSPENDED
> then we create a problem, because the decision for the transition
> out of PAUSED needs memory of the previous state.

Right, that's why I think we at least need one more boolean to remember the
suspended state, then when we switch from any STOP states into any RUN
states, we know where to go.  Here STOP states I meant anything except
RUNNING and SUSPENDED, while RUN -> RUNNING or SUSPENDED.

> 
> > My understanding is we should expect to fully stop the VM, including the
> > ticks, for example.  Keeping the ticks running even after QMP "stop"
> > doesn't sound right, isn't it?
> 
> The "stop" QMP command is documented as
> 
>     "Stop all guest VCPU execution"
> 
> the devil is in the detail though, and we've not documented any detail.
> 
> Whether or not timers keep running across stop/cont I think can be
> argued to be an impl detail, as long as the headline goal "vcpus
> don't execute" is satisfied.

"stop" was since qemu v0.14, so I guess we can't blame the missing of
details or any form of inaccuracy..  Obviously we do more than "stop vCPU
executions" in the current implementation.

But after we reach a consensus on how we should fix the current suspended
problem, we may want to update the documentation to start containing more
information.

> 
> > > vs the migration code where we are fixing brokenness.
> > 
> > This is not a migration-only bug if above holds, IMO.
> > 
> > > Second, it does not quite work, because the state becomes
> > > RUN_STATE_PAUSED, so the suspended state is forgotten, and the hmp "cont"
> > > will try to set the running state.  I could fix that by introducing a new
> > > state RUN_STATE_SUSPENDED_STOPPED, but again it is a user-visible change
> > > in existing behavior.  (I even implemented that while developing, then I
> > > realized it was not needed to fix the migration bugs.)
> > 
> > Good point.
> 
> We have added new guest states periodically. It is a user visible
> change, but you could argue that it is implementing a new feature
> ie the ability to "stop" a "suspended" guest, and so is justified.
> 
> S3 is so little used in virt, so I'm not surprised we're finding
> long standing edge cases that have never been thought about before.
> 
> > Now with above comments, what's your thoughts on whether we should change
> > the user behavior?  My answer is still a yes.
> > 
> > Maybe SUSPENDED should not be a RunState at all? SUSPENDED is guest visible
> > behavior, while something like QMP "stop" is not guest visible.  Maybe we
> > should remember it separately?
> 
> Yes, every time I look at this area I come away thinking that
> the RunState enum is a mess, overloading too many different
> concepts onto the same single field.
> 
> Specifically "SUSPENDED" vs "RUNNING" is a reflection of guest
> state (ie whether or not the VM is in S3), but pretty much all
> the others are a reflection of QEMU host state. I kind of feel
> that SUSPENDED (S3) probably shouldn't have been a RunState at
> all. I'd probably put guest-panicked into a separate thing too.
> 
> But we're stuck with what we have.

IMO compatibility is only necessary if at least the existing code is
running well.  But now I see it a major flaw in suspended state and I can't
see how it can go right if with current code base..  My concern is instead
that after suspended will be used more (e.g., assuming CPR will rely on it)
we can have more chance to confuse/oops a mgmt app like Libvirt, like I
described above.

In summary, I think a current solution to me is only to fix at least
suspended state for good, by:

  - adding vm_suspended boolean to remember machine RUNNING / SUSPENDED
    state.  When "cont" we need to switch to either RUNNING / SUSPENDED
    depending on the boolean.

  - keeping SUSPENDED state as RunState (for compatibility, otherwise we'll
    need another interface to fetch that boolean anyway), even though not
    query-able during any !RUNNING && !SUSPENDED state.. hopefully not a
    big deal

  - enrich ducumentation of qmp_stop/qmp_cont to describe what they really do

  - (with suspended working all right...) fix migration of SUSPENDED state

I don't expect a lot of code changes is needed, maybe even less than the
current series (because we don't need special knob to differenciate
migration or non-migration callers of do_vm_stop()). IMHO this series is
already doing some of that but just decided to ignore outside-migration
states for suspeneded.

We may want to add some test cases though to verify the suspended state
transitions (maybe easier to put into migration-test with the new ACPI
guest code), but optional.

Thanks,

-- 
Peter Xu


