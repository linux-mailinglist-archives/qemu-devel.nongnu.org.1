Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FE397826D
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Sep 2024 16:20:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp79B-0007Vk-SE; Fri, 13 Sep 2024 10:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sp79A-0007VG-HS
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 10:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sp798-0001Vg-8g
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 10:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726237176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VHGZN4+fgVYpJ1GdpWEYSsn5eOF7KquT8scEcHJRUn0=;
 b=gzr7Jm4fYdF3aJBP+AdLoCs4wVmZch9VS89DYGcHFbI3lPsBEPkEtcf37X/hg6akDBi0F7
 UfRX+95Y95QJkYJR03sRW90H94pXRdt+7RU9tSt3nHy2tuJJY0tUSqDGKGTyz4A6FWMRj/
 CqsRyHVTfOKXd+US6TCcU3gbi0SX0pw=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-Lzp-YH96Mz2CIYe2bQElQQ-1; Fri, 13 Sep 2024 10:19:35 -0400
X-MC-Unique: Lzp-YH96Mz2CIYe2bQElQQ-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-e02fff66a83so3611072276.0
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 07:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726237174; x=1726841974;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VHGZN4+fgVYpJ1GdpWEYSsn5eOF7KquT8scEcHJRUn0=;
 b=P+WZLY21UiqYIqRNk53mHpaA2wl7I1HmK+kX32Q7yuGqkau+4YKdUcdbdWrIkSx3U/
 1dncLh8PY7IQ7ACgqcLcSDv3Me6um/Mjp8Zbn5/GNjbO8wMcknh1Nj0w5fx300VfpW7J
 5Toy+F7NK9DHTRH7rqbvz4CF97idKyCkE33fQyOsB5QdOcLuNXhWdcBy/wXqjjwnX7g5
 2+2wV44knu9RWlQldY03biebaMSS8z8J+Yn+MlJ72RX/G/TjftVNndtMOrPKCgGjWvhV
 CulBZs81pb0n4tQzatDo4kn79bn/uvH5uzLCsuPgQHeoXUuGgOuWAn3gCmykNkpmP/z2
 UB3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzpoQm6dykOPK2sbaMeMp/A1j1xIQB/wDz38b2YP9ogfviZla4fAP5jKLGPdJnZ/6KNjxIwSiavo0m@nongnu.org
X-Gm-Message-State: AOJu0YyRM0qdbiibF4LCEianRbp/KQ8Hk85j9Av2XMng9wlma3UvdBU5
 i6xvE2Xh1wpRELSCmH/8jHuYZYVYMRtsgbJjgIf3y8YWfRlF1kv/+Yy3882kp3/QMjg/XgBFVSE
 WI+baEWFAeVdHj8OwcsDoTvaF7joEzajc/Ge7oBXXcvbI4fQzXbfcZ5RNRpsV
X-Received: by 2002:a25:9d07:0:b0:e1d:a163:1386 with SMTP id
 3f1490d57ef6-e1da16316bamr3475610276.0.1726237174097; 
 Fri, 13 Sep 2024 07:19:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLAHUYDm+Ch2zY0SY7FK/dmHRvuYoWFWp/XPBPSoKuCTYnR3aSkP1WB7zXhmV/o0nDudw/HQ==
X-Received: by 2002:a25:9d07:0:b0:e1d:a163:1386 with SMTP id
 3f1490d57ef6-e1da16316bamr3475578276.0.1726237173376; 
 Fri, 13 Sep 2024 07:19:33 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c53477477asm66937736d6.124.2024.09.13.07.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 07:19:32 -0700 (PDT)
Date: Fri, 13 Sep 2024 10:19:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: mail@maciej.szmigiero.name, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 12/17] migration/multifd: Device state transfer
 support - send side
Message-ID: <ZuRJ8i4T_vUzrawY@x1n>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <fdcfd68dfcf3b20278a4495eb639905b2a8e8ff3.1724701542.git.maciej.szmigiero@oracle.com>
 <87h6b4nosy.fsf@suse.de> <ZuCickYhs3nf2ERC@x1n>
 <87zfoc1zms.fsf@suse.de> <ZuOGAb3988ExsrHi@x1n>
 <87o74r1yfw.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o74r1yfw.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.147,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Sep 13, 2024 at 10:21:39AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Sep 12, 2024 at 03:43:39PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> Hi Peter, sorry if I'm not very enthusiastic by this, I'm sure you
> >> understand the rework is a little frustrating.
> >
> > That's OK.
> >
> > [For some reason my email sync program decided to give up working for
> >  hours.  I got more time looking at a tsc bug, which is good, but then I
> >  miss a lot of emails..]
> >
> >> 
> >> > On Wed, Aug 28, 2024 at 09:41:17PM -0300, Fabiano Rosas wrote:
> >> >> > +size_t multifd_device_state_payload_size(void)
> >> >> > +{
> >> >> > +    return sizeof(MultiFDDeviceState_t);
> >> >> > +}
> >> >> 
> >> >> This will not be necessary because the payload size is the same as the
> >> >> data type. We only need it for the special case where the MultiFDPages_t
> >> >> is smaller than the total ram payload size.
> >> >
> >> > Today I was thinking maybe we should really clean this up, as the current
> >> > multifd_send_data_alloc() is indeed too tricky (blame me.. who requested
> >> > that more or less).  Knowing that VFIO can use dynamic buffers with ->idstr
> >> > and ->buf (I was thinking it could be buf[1M].. but I was wrong...) made
> >> > that feeling stronger.
> >> 
> >> If we're going to commit bad code and then rewrite it a week later, we
> >> could have just let the original series from Maciej merge without any of
> >> this.
> >
> > Why it's "bad code"?
> >
> > It runs pretty well, I don't think it's bad code.  You wrote it, and I
> > don't think it's bad at all.
> 
> Code that forces us to do arithmetic in order to properly allocate
> memory and comes with a big comment explaining how we're dodging
> compiler warnings is bad code in my book.
> 
> >
> > But now we're rethinking after reading Maciej's new series.
> >Personally I don't think it's a major problem.
> >
> > Note that we're not changing the design back: what was initially proposed
> > was the client submitting an array of multifd objects.  I still don't think
> > that's right.
> >
> > What the change goes so far is we make the union a struct, however that's
> > still N+2 objects not 2*N, where 2 came from RAM+VFIO.  I think the
> > important bits are still there (from your previous refactor series).
> >
> 
> You fail to appreciate that before the RFC series, multifd already
> allocated N for the pages.

It depends on how you see it, IMHO.  I think it allocates N not for the
"pages" but for the "threads", because the threads can be busy with those
buffers, no matter if it's "page" or "device data".

> The device state adds another client, so that
> would be another N anyway. The problem the RFC tried to solve was that
> multifd channels owned that 2N, so the array was added to move the
> memory into the client's ownership. IOW, it wasn't even the RFC series
> that made it 2N, that was the multifd design all along. Now in hindsight
> I don't think we should have went with the memory saving discussion.

I think I could have made that feeling that I only wanted to save memory,
if so, I'm sorry.  But do you still remember I mentioned "we can make it a
struct, too" before your series landed?  Then you think it's ok to keep
using union, and I'm ok too! At least at that time.  I don't think that's a
huge deal.  I don't think each route we go must be perfect, but we try the
best to make it as good.

I don't think any discussion must not happen.  I agree memory consumption
is not the 1st thing to worry, but I don't see why it can't be discussed.

Note that I never said we can't save those memory either - I plan to have
follow up patches (for this, after Maciej's series land.. that's why I even
didn't yet mention) to allow modules report device state buffer size.  I
just didn't say, yet, and don't plan to worry before vfio series lands.
When with that, we'll save 1M*N when no vfio device attached (but we'll
need to handle hotplug).  So I think we don't need to lose any finally.

However I think we need to get straight with the base design on how vfio
should use multifd, because it's important bit and I don't want to rework
important bits after a huge feature, if we know a better directions.

I don't even think what I proposed patch 1-3 here is a must to me, I should
be clear again here just in case we have similar discussions
afterwards.. that I'm ok with below be done after Maciej's:

  - Avoid memory allocations per-packet (done in patch 2-3)
  - Avoid unnecessary data copy (done in patch 2-3)
  - Avoid allocate device buffers when no device will use (not proposed)

But I'm not ok building everything on top of the idea of not using multifd
buffers in the current way, because that can involve a lot of changes:
that's where buffer passes from up to down or backwards, and the interface
needs change a lot too.  We already have that in master so it's not a
problem now.

> 
> >> I already suggested it a couple of times, we shouldn't be doing
> >> core refactorings underneath contributors' patches, this is too
> >> fragile. Just let people contribute their code and we can change it
> >> later.
> >
> > I sincerely don't think a lot needs changing... only patch 1.  Basically
> > patch 1 on top of your previous rework series will be at least what I want,
> > but I'm open to comments from you guys.
> 
> Don't get me wrong, I'm very much in favor of what you're doing
> here. However, I don't think it's ok to be backtracking on our design
> while other people have series in flight that depend on it. You
> certainly know the feeling of trying to merge a feature and having
> maintainers ask you to rewrite a bunch code just to be able to start
> working. That's not ideal.

I as a patch writer always like to do that when it's essential.  Normally
the case is I don't have enough reviewer resources to help me get a better
design, or discuss about it.

When vfio is the new user of multifd vfio needs to do the heavy lifting to
draft the api.

> 
> I tried to quickly insert the RFC series before the device state series
> progressed too much, but it's 3 months later and we're still discussing
> it, maybe we don't need to do it this way.

Can I get that of your feeling from when you were working on mapped-ram?
That series does take long enough, I agree.  Not so bad yet with the VFIO
series - it's good to have you around because you provide great reviews.
I'm also trying the best to not let a series dangle for more than a year.
I don't think 3 months is long with this feature: this is the 1st multifd
extrenal user (and file mapping is also in another angle), it can take some
time.

Sorry if it's so, but sorry again I don't think I get convinced: I think we
need to go this way to build blocks one by one, and we need to make sure
lower blocks are hopefully solid enough to take the upper ones.  Again I'm
ok with small things that go against it, but not major designs.  We
shouldn't go rewrite major designs if we seem to know a better one.

> 
> And ok, let's consider the current situation a special case. But I would
> like to avoid in the future this kind of uncertainty. 
> 
> >
> > Note that patch 2-3 will be on top of Maciej's changes and they're totally
> > not relevant to what we merged so far.  Hence, nothing relevant there to
> > what you worked.  And this is the diff of patch 1:
> >
> >  migration/multifd.h              | 16 +++++++++++-----
> >  migration/multifd-device-state.c |  8 ++++++--
> >  migration/multifd-nocomp.c       | 13 ++++++-------
> >  migration/multifd.c              | 25 ++++++-------------------
> >  4 files changed, 29 insertions(+), 33 deletions(-)
> >
> > It's only 33 lines removed (many of which are comments..), it's not a huge
> > lot.  I don't know why you feel so bad at this...
> >
> > It's probably because we maintain migration together, or we can keep our
> > own way of work.  I don't think we did anything wrong yet so far.
> >
> > We can definitely talk about this in next 1:1.
> >
> >> 
> >> This is also why I've been trying hard to separate core multifd
> >> functionality from migration code that uses multifd to transmit their
> >> data.
> >> 
> >> My original RFC plus the suggestion to extend multifd_ops for device
> >> state would have (almost) made it so that no client code would be left
> >> in multifd. We could have been turning this thing upside down and it
> >> wouldn't affect anyone in terms of code conflicts.
> >
> > Do you mean you preferred the 2*N approach?
> >
> 
> 2*N, where N is usually not larger than 32 and the payload size is
> 1k. Yes, I'd trade that off no problem.

I think it's a problem.

Vdpa when involved with exactly the same pattern of how vfio uses it (as
they're really alike underneath) then vdpa will need its own array of
buffers, or it'll need to take the same vfio lock which doesn't make sense
to me.

N+2, or, N+M (M is the user) is the minimum buffers we need.  N because
multifd can be worst case 100% busy on all threads occupying the buffers.
M because M users can be worst case 100% pre-filling.  It's either about
memory consumption, or about logical sensibility.

> 
> >> 
> >> The ship has already sailed, so your patches below are fine, I have just
> >> some small comments.
> >
> > I'm not sure what you meant about "ship sailed", but we should merge code
> > whenever we think is the most correct.
> 
> As you put above, I agree that the important bits of the original series
> have been preserved, but other secondary goals were lost, such as the
> more abstract separation between multifd & client code and that is the
> ship that has sailed.
> 
> That series was not: "introduce this array for no reason", we also lost
> the ability to abstract the payload from the multifd threads when we
> dropped the .alloc_fn callback for instance. The last patch you posted

I don't remember the details there, but my memory was that it was too
flexible while we seem to reach the consensus that we only process either
RAM or device, nothing else.

> here now adds multifd_device_state_prepare, somewhat ignoring that the
> ram code also has the same pattern and it could be made to use the same
> API.

I need some further elaborations to understand.

multifd_device_state_prepare currently does a few things: taking ownership
of the temp device state object, fill in idstr / instance_id, taking the
lock (so far is needed because we only have one device state object).  None
of them seems to be needed for RAM yet.

Feel free to send a rfc patch if that helps.

> 
> I did accept your premise that ram+compression is one thing while
> device_state is another, so I'm not asking it to be changed, just
> pointing out that the RFC series also addressed those issues. I might
> not have made that clear back then.
> 
> > I hope you meant after below all things look the best, or please shoot.
> > That's exactly what I'm requesting for as comments.
> 
> What you have here is certainly an improvement from the current
> state. I'm just ranting about the path we took here.

-- 
Peter Xu


