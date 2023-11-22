Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBE87F41D1
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 10:39:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5jgh-0007XK-2o; Wed, 22 Nov 2023 04:38:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r5jgf-0007Uu-Ha
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 04:38:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r5jgd-0008HA-K1
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 04:38:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700645901;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=NGM9CuM888T8dA+V6cm/8QPLyBCGMMWDnYzsT21puYE=;
 b=WyR9ubZ2WLv7u127c2GCUkp0O7OCJM1OyiskIuHHofNZZfNc5Ue34PlLSmeZS3eGZYZay8
 wOPCgXSqDRzNcqA8FSXeIjK9eYwszV6FPxWeJewuQyZD6BQeqboqx01OrFOponY/K1vE5r
 H17eyKnnKEiv3lcONMPuT14bqW4n97g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-e5947Y1mPiGGLTtMWE5WUw-1; Wed, 22 Nov 2023 04:38:17 -0500
X-MC-Unique: e5947Y1mPiGGLTtMWE5WUw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F5B4811E82;
 Wed, 22 Nov 2023 09:38:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.104])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC378492BFA;
 Wed, 22 Nov 2023 09:38:12 +0000 (UTC)
Date: Wed, 22 Nov 2023 09:38:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V5 02/12] cpus: stop vm in suspended state
Message-ID: <ZV3L_ihDoQOAsT44@redhat.com>
References: <1699900440-207345-1-git-send-email-steven.sistare@oracle.com>
 <1699900440-207345-3-git-send-email-steven.sistare@oracle.com>
 <ZVu6ohk8_8xzyL-x@x1n>
 <e32d4434-c877-4f98-ac76-da8fa292395c@oracle.com>
 <ZVvTUuNYzGgFcg4m@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZVvTUuNYzGgFcg4m@x1n>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Nov 20, 2023 at 04:44:50PM -0500, Peter Xu wrote:
> On Mon, Nov 20, 2023 at 03:55:54PM -0500, Steven Sistare wrote:
> > If we drop force, then all calls to vm_stop will completely stop the
> > suspended state, eg an hmp "stop" command. This causes two problems.
> > First, that is a change in user-visible behavior for something that
> > currently works,
> 
> IMHO it depends on what should be the correct behavior.  IOW, when VM is in
> SUSPENDED state and then the user sends "stop" QMP command, what should we
> expect?

I would say that from a mgmtm app POV "stop" is initiating a state
transition, from RUN_STATE_RUNNING to RUN_STATE_PAUSED and "cont"
is doing the reverse from PAUSED to RUNNING.

It is a little more complicated than that as there are some other
states like INMIGRATE that are conceptually equiv to RUNNING,
and states where the transition simply doesn't make sense.


So my question is if we're in "SUSPENDED" and someone issues "stop",
what state do we go into, and perhaps more importantly what state
do we go to in a subsequent "cont".

If you say SUSPENDED ---(stop)---> PAUSED ---(cont)---> SUSPENDED
then we create a problem, because the decision for the transition
out of PAUSED needs memory of the previous state.

> My understanding is we should expect to fully stop the VM, including the
> ticks, for example.  Keeping the ticks running even after QMP "stop"
> doesn't sound right, isn't it?

The "stop" QMP command is documented as

    "Stop all guest VCPU execution"

the devil is in the detail though, and we've not documented any detail.

Whether or not timers keep running across stop/cont I think can be
argued to be an impl detail, as long as the headline goal "vcpus
don't execute" is satisfied.

> > vs the migration code where we are fixing brokenness.
> 
> This is not a migration-only bug if above holds, IMO.
> 
> > Second, it does not quite work, because the state becomes
> > RUN_STATE_PAUSED, so the suspended state is forgotten, and the hmp "cont"
> > will try to set the running state.  I could fix that by introducing a new
> > state RUN_STATE_SUSPENDED_STOPPED, but again it is a user-visible change
> > in existing behavior.  (I even implemented that while developing, then I
> > realized it was not needed to fix the migration bugs.)
> 
> Good point.

We have added new guest states periodically. It is a user visible
change, but you could argue that it is implementing a new feature
ie the ability to "stop" a "suspended" guest, and so is justified.

S3 is so little used in virt, so I'm not surprised we're finding
long standing edge cases that have never been thought about before.

> Now with above comments, what's your thoughts on whether we should change
> the user behavior?  My answer is still a yes.
> 
> Maybe SUSPENDED should not be a RunState at all? SUSPENDED is guest visible
> behavior, while something like QMP "stop" is not guest visible.  Maybe we
> should remember it separately?

Yes, every time I look at this area I come away thinking that
the RunState enum is a mess, overloading too many different
concepts onto the same single field.

Specifically "SUSPENDED" vs "RUNNING" is a reflection of guest
state (ie whether or not the VM is in S3), but pretty much all
the others are a reflection of QEMU host state. I kind of feel
that SUSPENDED (S3) probably shouldn't have been a RunState at
all. I'd probably put guest-panicked into a separate thing too.

But we're stuck with what we have.

> It means qemu_system_suspend() could remember that in a separate field (as
> part of guest state), then when wakeup we should conditionally go back
> with/without vcpus running depending on the new "suspended" state.



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


