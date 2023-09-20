Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4667A770B
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 11:18:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qitKj-0005Lk-9u; Wed, 20 Sep 2023 05:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qitKg-0005L7-JR
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 05:17:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qitKc-0000Xk-Lb
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 05:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695201432;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=3xkJ3oGx1UfruCDLAG3bOq5pxJXrG7PFXaHWjLScmxw=;
 b=GktrJhM0Hf8zqZPY5pxGp7239lR3PkRDeqFL7jwFUTbup9ePjUW9KSRc+Q2dqOCYyBZ7Ea
 7YDp3F3yaTxtLoHTEyCgk7kcweatkIfW8Hop5bhBSGJ+15oJFwgbyOt1ZWrs9ErkVyuu8k
 91xOdnOnFpUyhStQj6dxHGLPRA4JaAM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-9I50Tc43PLOMg1jQ6anMmw-1; Wed, 20 Sep 2023 05:17:09 -0400
X-MC-Unique: 9I50Tc43PLOMg1jQ6anMmw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A360F803470;
 Wed, 20 Sep 2023 09:17:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 40F462156702;
 Wed, 20 Sep 2023 09:17:06 +0000 (UTC)
Date: Wed, 20 Sep 2023 10:17:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: stable-8.1.1: which bug do we keep?
Message-ID: <ZQq4kMVHNtxeVH6o@redhat.com>
References: <84f08f14-7911-4cdc-04e6-548287349d00@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <84f08f14-7911-4cdc-04e6-548287349d00@tls.msk.ru>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Sep 20, 2023 at 07:46:36AM +0300, Michael Tokarev wrote:
> Hi!
> 
> I'm in somewhat doubt what to do with 8.1.1 release.
> 
> There are 2 compelling issues, fixing one discovers the other.
> 
> https://gitlab.com/qemu-project/qemu/-/issues/1864
> "x86 VM with TCG and SMP fails to start on 8.1.0"
> is fixed by 0d58c660689f "softmmu: Use async_run_on_cpu in tcg_commit"
> 
> But this brings up
> 
> https://gitlab.com/qemu-project/qemu/-/issues/1866
> "mips/mip64 virtio broken on master (and 8.1.0 with tcg fix)"
> (which is actually more than mips, as I've shown down the line,
> https://gitlab.com/qemu-project/qemu/-/issues/1866#note_1558221926 )
> 
> Also, one commit alone,
> 86e4f93d827 "softmmu: Assert data in bounds in iotlb_to_section",
> when not followed with "async_run_on_cpu in tcg_commit", causes
> assertion failures, eg
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg989846.html
> I don't know if "async_run_on_cpu in tcg_commit" was supposed to
> fix this assertion or not, or maybe some additional fix is needed, -
> but I haven't see this is triggered with 0d58c660689f applied.
> 
> There were at least two attempts by Richard to fix issues after
> 0d58c660689f, one "accel/tcg: Always require can_do_io", which fixes
> both reproducers for #1866 but at a high cost, and another,
> "softmmu: Introduce cpu_address_space_sync", which addresses the
> mips regression but does not fix my reproducer with ovmf
> and none of the 2 landed on master so far.

In the cover letter for the 2nd proposed series Richard says

[quote]
I've done a tiny bit of performance testing between the two
solutions and it seems to be a wash.  So now it's simply a
matter of cleanliness.
[/quote]

Since the 2nd series is shown to still be broken in some cases
and 1st is thought to solve them all, IMHO it feels like we
should just press ahead with applying the the 1st series to
git master, and then stable.

If we still want a cleaner solution, it can be reverted/replaced
later once someone figures out an option that addresses all the
problems. We shouldn't leave such a big regression in TCG unfixed
for so long while we figure out a cleaner option.

> Right now I have a "which bug to keep?" situation for 8.1.1, and
> I'd love to have at least *some* comments about all this.  I've got
> no replies to my earlier emails in this area.
> 
> To mee, it *feels* like 0d58c660689f should be there.
> Note: the scheduled deadline for staging-8.1.1 is gone yesterday.
> But this stuff seems to be important enough to delay 8.1.1 further.

On the one hand breaking x86 is a big deal because it is a mainstream
architecture, on the other hand people have real x86 hardware, so
using TCG emulation for x86 is less compelling. I agree we need to
fully address this in 8.1.1.

I guess the other unmentioned option is to revert whatever TCG changes
went into 8.1 that caused the regression in the first place. I've no
idea if that is at all practical though.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


