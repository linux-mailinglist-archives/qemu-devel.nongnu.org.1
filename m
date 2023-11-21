Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4365F7F3974
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 23:49:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5ZX4-0000aI-BY; Tue, 21 Nov 2023 17:47:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r5ZX2-0000Zs-TT
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 17:47:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r5ZWx-00006S-Tq
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 17:47:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700606862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1jDLGPzKff3q/BjrgCcUBz8UJrqLWKz4mhtRrWeREa8=;
 b=aN6VjVQuEdKQkGqSA7wbiu06gC+evr1t8sZZXvrWk77Urshh8JBWbCn3u1UEfmwj8QGc27
 rGZ0NuatymEKgWOEToo6XAx9zIIMJrNwjEmndekKlWE4vDw8booshWAJmoTMY231sY5CkX
 5tAm4frhq6O5T5TFpApv4aRoyryKWTk=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-bKWL3HZ_OVO5wsAlPeHwGw-1; Tue, 21 Nov 2023 17:47:40 -0500
X-MC-Unique: bKWL3HZ_OVO5wsAlPeHwGw-1
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-7a9473ccf96so125138139f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 14:47:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700606860; x=1701211660;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1jDLGPzKff3q/BjrgCcUBz8UJrqLWKz4mhtRrWeREa8=;
 b=q6X14Ma7Y12wsz3X04/WxPej6iKVQOtzskfMIuJjAzDHYQUsnHjSNPKvsIlo6LxLWu
 kuH4J5DB0f/WE5CN5KOJFnVlGBsKQHXNDak3hTglXmXXUQI3lQBUVoh95pfobUdF5lv1
 VFkMsQGlLytqO6iQ0LbmnlV1pc0f1nOtyEStR435vLPKXm5P5GfUS7CqNsV3DD4iRSBR
 aLWy9OWsuMo+NnEgueTKvYwPuN/pN5XGeh+kjei38kIaENYR3yckcWoZkSultmAD62IJ
 HkYcQiMiKUrnGvOxWHxS8J1zWLDBpokyLkShGNFzayb8yFal6Y0YtxCb2J8CwXgX2aeO
 7Sjw==
X-Gm-Message-State: AOJu0YyDiI55TFR4Vrmpgv9n/NmJM1iJzVc6FlWvT8yRlnHC0r1nPbAh
 nvrDZwdnpU/d9CjapOybjoB3BxhAgovrQ5XrgCtcI3nqSTQ2qspZ95JSt6llM2MaBD42ME8VogX
 829Q08/IWveqc0+U=
X-Received: by 2002:a05:6602:3587:b0:79f:a8c2:290d with SMTP id
 bi7-20020a056602358700b0079fa8c2290dmr1035281iob.0.1700606859856; 
 Tue, 21 Nov 2023 14:47:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAiPdp4l0Ls8z5Q8yiLMvvfkZj/c/EnO/CK9dvOxfVMlF4bCikMlIPqY/Hs6yA2LKyEymJZw==
X-Received: by 2002:a05:6602:3587:b0:79f:a8c2:290d with SMTP id
 bi7-20020a056602358700b0079fa8c2290dmr1035262iob.0.1700606859517; 
 Tue, 21 Nov 2023 14:47:39 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 v12-20020a5ed70c000000b0079fe8ec6736sm2970839iom.55.2023.11.21.14.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 14:47:39 -0800 (PST)
Date: Tue, 21 Nov 2023 17:47:36 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V5 02/12] cpus: stop vm in suspended state
Message-ID: <ZV0ziPkcuEyTruIC@x1n>
References: <1699900440-207345-1-git-send-email-steven.sistare@oracle.com>
 <1699900440-207345-3-git-send-email-steven.sistare@oracle.com>
 <ZVu6ohk8_8xzyL-x@x1n>
 <e32d4434-c877-4f98-ac76-da8fa292395c@oracle.com>
 <ZVvTUuNYzGgFcg4m@x1n>
 <54f3f649-5b77-4b6c-92c9-495656031984@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54f3f649-5b77-4b6c-92c9-495656031984@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Tue, Nov 21, 2023 at 04:21:18PM -0500, Steven Sistare wrote:
> On 11/20/2023 4:44 PM, Peter Xu wrote:
> > On Mon, Nov 20, 2023 at 03:55:54PM -0500, Steven Sistare wrote:
> >> If we drop force, then all calls to vm_stop will completely stop the
> >> suspended state, eg an hmp "stop" command. This causes two problems.
> >> First, that is a change in user-visible behavior for something that
> >> currently works,
> > 
> > IMHO it depends on what should be the correct behavior.  IOW, when VM is in
> > SUSPENDED state and then the user sends "stop" QMP command, what should we
> > expect?
> > 
> > My understanding is we should expect to fully stop the VM, including the
> > ticks, for example.  Keeping the ticks running even after QMP "stop"
> > doesn't sound right, isn't it?
> 
> I agree, but others may not, and this decision would require approval from 
> maintainers in other areas, including upper layers such as libvirt that are
> aware of the suspended state.  It is a user-visible change, and may require 
> a new libvirt release.

$ ./scripts/get_maintainer.pl -f system/cpus.c
Richard Henderson <richard.henderson@linaro.org> (maintainer:Overall TCG CPUs)
Paolo Bonzini <pbonzini@redhat.com> (reviewer:Overall TCG CPUs)
qemu-devel@nongnu.org (open list:All patches CC here)

I'm also copying Richard, while Dan/Paolo is already in the loop, so we
should have the "quorum" already.  Let's see whether we can already get
some comments from the maintainers..

> 
> >> vs the migration code where we are fixing brokenness.
> > 
> > This is not a migration-only bug if above holds, IMO.
> > 
> >> Second, it does not quite work, because the state becomes
> >> RUN_STATE_PAUSED, so the suspended state is forgotten, and the hmp "cont"
> >> will try to set the running state.  I could fix that by introducing a new
> >> state RUN_STATE_SUSPENDED_STOPPED, but again it is a user-visible change
> >> in existing behavior.  (I even implemented that while developing, then I
> >> realized it was not needed to fix the migration bugs.)
> > 
> > Good point.
> > 
> > Now with above comments, what's your thoughts on whether we should change
> > the user behavior?  My answer is still a yes.
> > 
> > Maybe SUSPENDED should not be a RunState at all? SUSPENDED is guest visible
> > behavior, while something like QMP "stop" is not guest visible.  Maybe we
> > should remember it separately?
> >
> > It means qemu_system_suspend() could remember that in a separate field (as
> > part of guest state), then when wakeup we should conditionally go back
> > with/without vcpus running depending on the new "suspended" state.
>
> Regardless of how we remember it, the status command must still expose
> the suspended state to the user.  The user must be able to see that a
> guest is suspended, and decide when to issue a wakeup command.

Hmm, right, we may want to keep having the SUSPENDED state in RunState,
even another separate "vm_suspended" boolean might still be required.

> 
> If we change the stop command to completely stop a suspended vm, then we must
> allow the user to query whether a vm is suspended-running or suspended-stopped,
> because the command they must issue to resume is different: wakeup for the
> former, and cont for the latter.

If it's stopped, the user must need a "cont" anyway.  And then if after
"cont" the user still sees it's suspended, then would "system_wakeup" work
here if necessary, after that "cont"?

Let's consider the current QEMU with below sequence of operations:

  1) vm running
  2) guest triggers ACPI suspend -> vm suspended
  3) admin triggers "stop" cmd -> vm suspended (ignored..)
  4) admin triggers "cont" cmd -> vm suspended (ignored.. too)

AFAICT both 2) and 3) are unwanted behavior, and after noticing 3) I feel
stronger that this is not a migration issue alone.

It also means after step 1)-3) if we got a wakeup elsewhere, the VM can
actually be running!  That's definitely unexpected after admin sends "stop"
already.  Isn't that another real bug?

I'm slightly confused on why you said above that libvirt will need a new
release. Could you elaborate?  Especially on what scenario we need to
maintain compatibility that still makes sense.

> 
> This change is visible to libvirt.  Adding it will delay this entire patch
> series, and is not necessary for fixing the migration bug.  There is no
> downside to drawing the line here for this series, and possibly changing stop
> semantics in the future.

This series will need to wait for rc releases anyway until 8.2 all out:

  https://wiki.qemu.org/Planning/8.2

I think we still have time to even catch the earliest train right after 8.2
released, if we can reach a consensus soon in whatever form.

Having a partial solution merged for migration is probably doable, but that
will make the code even more complicated and harder to maintain.  So before
doing so, I'd at least like to understand better on what use case you were
describing that will start to fall apart.

Thanks,

-- 
Peter Xu


