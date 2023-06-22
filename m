Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B06673A37E
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 16:47:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCLZS-0000sl-7v; Thu, 22 Jun 2023 10:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qCLZL-0000sC-LG
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 10:45:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qCLZJ-0004D3-AJ
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 10:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687445152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zMgqU0N7sfsBtetCJIUiQuU7sFBkZYplLoeV2QyhXdw=;
 b=H3ACZXxz2Kv/g1R62sGAALFA5HkfhflS0hx9lNnonf8R9iIwcU4gThM67zhAwb+dAbhPov
 6IwrtalF6d/dyLr+x0WjotE4LuO19idVbN/tXudJ2MCIzIM51M6NmIw4eUUA+i9QK1hjH1
 uRJ092Fj+H17Tgavw1S2qZkhx7UqLLo=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-tUNyN3LBOYGIa3tm62Cggw-1; Thu, 22 Jun 2023 10:45:47 -0400
X-MC-Unique: tUNyN3LBOYGIa3tm62Cggw-1
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-46e7f9e6346so280129e0c.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 07:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687445134; x=1690037134;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zMgqU0N7sfsBtetCJIUiQuU7sFBkZYplLoeV2QyhXdw=;
 b=dms3N/Y38hgcz8V02OGk63IyxzKIjmnjy8bbNLbt+YODqUOZobXWms7w7X8SKyfzOh
 Xd5ytC0SCk0kTTFTDOarSdyf/53VKzvPwwQfxCyCPa0yvqUwor6ZiRQGSED7jM4CRcoc
 ft3l6FeS5dUqXnDqp11+hs7f2LmgVpuan4e70QbPqQqB3/CcbJigAC8O+pp06KJv1wiW
 WO8QIi2PON4TaQ/ckr459VCeKTKQ/ibrP9nJEhuPtwJkoyNfZBLvZNyHjRqeu7epPM3v
 hKj3RI4lmYKnm1dkqfQhqCMoBWLZ8M/G6umWLjTH6VQR7+SMaCIIlws7Fmve6SqMkBXx
 zUzQ==
X-Gm-Message-State: AC+VfDxuaoEEiM7O2NKAd5niiZjJ2jmalCqIvVg/K+6ivlTtalkFB7+g
 wroFXbpTSZDMjB5yNR1kQfwYVCuGCS6g6l6O0k0FuGHkgSzamsTZVlHBwjriEtFX8TFWZHctgbl
 ZUfSI+so0bV7UlMs=
X-Received: by 2002:a1f:9bc1:0:b0:471:6e5c:dddd with SMTP id
 d184-20020a1f9bc1000000b004716e5cddddmr7437613vke.0.1687445133833; 
 Thu, 22 Jun 2023 07:45:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ipiIjKj8SYTV8TgZvB/llZVXrhBDM5LEu5GgCFWLERJ7ImCljrj6kHH1IMPQ1M1Q8XuNkvg==
X-Received: by 2002:a1f:9bc1:0:b0:471:6e5c:dddd with SMTP id
 d184-20020a1f9bc1000000b004716e5cddddmr7437577vke.0.1687445133202; 
 Thu, 22 Jun 2023 07:45:33 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 f13-20020a0ccc8d000000b006286334f999sm3845109qvl.78.2023.06.22.07.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 07:45:32 -0700 (PDT)
Date: Thu, 22 Jun 2023 10:45:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Fiona Ebner <f.ebner@proxmox.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v2 06/20] qemu_file: total_transferred is not used anymore
Message-ID: <ZJReiwmy/91NUVJY@x1n>
References: <20230530183941.7223-1-quintela@redhat.com>
 <20230530183941.7223-7-quintela@redhat.com> <ZInUEU0WqmUPI0tZ@x1n>
 <87a5ws8lgy.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a5ws8lgy.fsf@secure.mitica>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Jun 22, 2023 at 01:05:49AM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > On Tue, May 30, 2023 at 08:39:27PM +0200, Juan Quintela wrote:
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> ---
> >>  migration/qemu-file.c | 4 ----
> >>  1 file changed, 4 deletions(-)
> >> 
> >> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> >> index eb0497e532..6b6deea19b 100644
> >> --- a/migration/qemu-file.c
> >> +++ b/migration/qemu-file.c
> >> @@ -41,9 +41,6 @@ struct QEMUFile {
> >>      QIOChannel *ioc;
> >>      bool is_writable;
> >>  
> >> -    /* The sum of bytes transferred on the wire */
> >> -    uint64_t total_transferred;
> >> -
> >>      int buf_index;
> >>      int buf_size; /* 0 when writing */
> >>      uint8_t buf[IO_BUF_SIZE];
> >> @@ -287,7 +284,6 @@ void qemu_fflush(QEMUFile *f)
> >>              qemu_file_set_error_obj(f, -EIO, local_error);
> >>          } else {
> >>              uint64_t size = iov_size(f->iov, f->iovcnt);
> >> -            f->total_transferred += size;
> >
> > I think this patch is another example why I think sometimes the way patch
> > is split are pretty much adding more complexity on review...
> 
> It depends of taste.
> 
> You are doing one thing in way1.
> Then you find a better way to do it, lets call it way2.
> 
> Now we have two options to see how we arrived there.
> 
> a- You got any declarations/definition/initializations for way2
> b- You write way2 alongside way1
> c- You test that both ways give the same result, and you see that they
>    give the same result.
> d- you remove the way1.
> 
> Or you squash the four patches in a single patch.  But then the reviewer
> lost the place where one can see why it is the same than the old one.

For this patch to remove total_transferred, IMHO as a reviewer it'll be
easier to me if it's put in the same patch where it got replaced.

It might be different if we're going to remove a large chunk of code, but
for this patch it's a few lines of change.

> 
> Sometimes is better the longer way, sometimes is better the short one.
> 
> Clearly we don't agree about what is the best way in this case.
> 
> > Here we removed a variable operation but it seems all fine if it's not used
> > anywhere.  But it also means current code base (before this patch applied)
> > doesn't make sense already because it contains this useless addition.  So
> > IMHO it means some previous patch does it just wrong.
> 
> No.  It is how it is developed.  And being respectful with the
> reviewer.  Given it enough information to do a proper review.

I never doubted about that.  I trust that you were trying to provide the
best for a reviewer and I appreciate that.

> 
> During the development of this series, there were lots of:
> 
> if (old_counter != new_counter)
>    printf("....");

I assume you meant when debugging?  I may not have read all the patches; I
hope we just don't do that if possible in any real git commit.

> 
> traces were in the several thousand lines long.  If I have to review
> that change, I would love any help that writer can give me.  That is why
> it is done this way.

Yeah, I think it's probably that even from reviewers' perspective the need
can be different from individuals.

> 
> > I think it means it's caused by a wrong split of patches, then each patch
> > stops to make much sense as a standalone one.
> 
> It stops making sense if you want each feature to be a single patch.
> Before the patch no feature.  After the patch full feature.  That brings
> us to very long patches.
> 
> What is easier to review (to do the same)
> 
> a - 1 x 1000 lines patch
> b - 10 x 100 lines patch
> 
> I will go with b any time.  Except if the split is arbitrary.

AFAIU, this is a different thing.  I'm never against splitting patch, but
about how to split.  I was never asking for a 1000 LOC patch, right? :)

> 
> > I can go back and try to find whatever patch on the list that will explain
> > this.  But it'll also go into git log.  Anyone reads this later will be
> > confused once again.  Even harder for them to figure out what
> > happened.
> 
> As said before, I completely disagree here.  And what is worse.  If it
> gets wrong, with your approach git bisect will not help as much than
> with my appreach.
> 
> > Do you think we could reorganize the patches so each of a single patch
> > explains itself?
> 
> No.  See before.  We go for a very spaguetti code to a much less
> spaguety code.
> 
> > The other thing is about priority of patches - I still have ~80 patches
> > pending reviews on migration only.. Would you think it makes sense we pickg
> > up important ones first and merge them with higher priority?
> 
> Ok, lets make this clear.
> This whole atomic migration counters started because the zero_page
> detection in multifd had the counters so wrong that meassuring speed
> become impossible.
> 
> I haven't yet send the multifd zero pages.  And why was it so
> complicated.  Just on top of my memory.
> 
> - how much data had we transferred.  Historically we stored that
>   information on qemu-file.  But qemu-file can only be read/written from
>   the migration thread.  So we went through jumps to be able to update
>   that values.
> 
>   Current upstream code for compressed multifd assumes that it transfer
>   as much data as non compressed one.  Why?  because we don't have an
>   easy way to get that value back.  Contorsions that we were trying to
>   do:
> 
>   https://lore.kernel.org/all/20220802063907.18882-5-quintela@redhat.com/
> 
>   To resume, the way that we had to do it was something like:
> 
>   - we send a bunch of pages to multifd thread
>   - multifd thread send data and returns on the buffer what has written
>   - migration thread when reuses a buffer adds the written stuff from
>     previous time than the struct was used.
> 
>   This was not just problematic from multifd zero pages detection.
>   * compression was lying about it
>   * zero_copy is doing it wrong (accounting at the time that it does the
>     write, not when it knows that it was written).
> 
> - rdma: this is even funnier
>   * It accounted for zero and normal pages in two places
>     https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg07693.html
>     (still does, I have to resed that bit)
>   * It accounts for imaginary transfers
>     https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg07700.html
>     Because it has to give the apparence of progress, i.e. that it has
>     written something, but it is not true because RDMA is completely
>     asynchronous.
>   * RDMA and qemu-file were very, very difficult to put appart.
>     Remember that RDMA don't send _anything_ through the qemu_file, it
>     has its parameter only for the accounting.
> 
> - counters:
>   qemu_file can only be accessed through Migration thread.
>   But each time that you do an info migrate, it is done through the IO
>   thread, not the migration thread.  So it was accessing a shared
>   variable without any locking.

Pure readers are IMHO fine as long as there's 1 single writer, and as long
as the reader can read values right even if old (not wrong value;
e.g. 32bit host read over 64 bits vars is a different thing when the var
got updated).

>   And putting locking means that we also need to lock it on the Migration
>   thread.  So everything that is exported to the user needs to be atomic.
> 
> - Postcopy preempt
>   And here we are, another thread. That uses qemu file, another qemu
>   file.  Its access is not racy, because .... we don't account for the
>   data sent through the preempt channel.  At all.  Because ... it is
>   complicated.

Yeah I must confess I didn't pay huge attention on the accounting over
there.. as I want always got the pages sent immediately, ignoring limits
(but agree we should still account those).

> 
> - But we are not happy with this.  We have to calculate the rate limit.
>   And for that, we use another counter on the qemu file.  that is
>   updated on (almost) the same places that we update the transferred
>   counter.  Basically the difference is that multifd don't update the
>   transferred counter but update the rate_limit. But RDMA updates both.
> 
> - Not happy with this, we decided that this was too complicated and
>   added yet another counter.  transferreed.  And atomic one.  You are
>   going to ask why.  Well, I am guessing here.  But the problem is that
>   when can do info migrate after ending a migration.  And at that time
>   qemu-file is gone, so we add another counter instead of storing the
>   value of qemu-file.
> 
> Should I continue, and search for the patches that changed the things,
> or can we agree that this is a complex problem and can't be fixed with
> yet another one line?

I don't think this is the same issue we're discussing.. but I understand
we may need a lot of changes to fix all the counters.

My request was much simpler, IMHO:

It's about making sure every patch is self contained, and that's all of it.
Each patch needs to justify itself, if the code change can't, the commit
message should supplement that and make sure anyone stumbles over the patch
can have a way to trace back on why it happened.  That's all I was asking.

Now when I goes back and look at this simplest patch, again I'd just squash
this back to previous as I used to comment.  If not, I think the only
missing piece / last question is, why you didn't remove the last
total_transferred in the last patch, where anyway you removed all the rest:

https://lore.kernel.org/r/20230530183941.7223-6-quintela@redhat.com

===8<===
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index be3dab85cb..eb0497e532 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -288,6 +288,7 @@ void qemu_fflush(QEMUFile *f)
         } else {
             uint64_t size = iov_size(f->iov, f->iovcnt);
             f->total_transferred += size;        <------------------- this is NOT removed
+            stat64_add(&mig_stats.qemu_file_transferred, size);
         }

         qemu_iovec_release_ram(f);
@@ -628,7 +629,7 @@ int coroutine_mixed_fn qemu_get_byte(QEMUFile *f)

 uint64_t qemu_file_transferred_noflush(QEMUFile *f)
 {
-    uint64_t ret = f->total_transferred;         <------------------- this is removed
+    uint64_t ret = stat64_get(&mig_stats.qemu_file_transferred);
     int i;

     g_assert(qemu_file_is_writable(f));
@@ -644,7 +645,7 @@ uint64_t qemu_file_transferred(QEMUFile *f)
 {
     g_assert(qemu_file_is_writable(f));
     qemu_fflush(f);
-    return f->total_transferred;                 <------------------- this is removed
+    return stat64_get(&mig_stats.qemu_file_transferred);
 }
===8<===

I think that's why I said "this patch proved something was wrong before",
and it's as simple as that..

As a reviewer, I hope we, as qemu migration submodule, follows the same bar
on review with major linux communities.  This patch is probably not gonna
be accepted in any of known sub-communities I'm familiar with.

So if you want to keep removal of total_transferred standalone, please move
the other line to previous patch from this patch.  But again, I really
don't see why it's needed at all to split a separate patch just to remove
total_transferred.

> I spent the best part of a couple of months
> trying to fix the problem with one liners, and ended without fixing the
> problem after too many one liners.
> 
> Ended spending another couple of months writting changing the code
> correctly, simplifying the number of counters and giving the same
> functionality that was before.  But it took too many patches.
> 
> And why it ends with so many patches?
> I am glad that you asked.  Because I find a bug.  And I try to fix it.
> And then I see that there is another thing that I need to fix to be able
> to fix this one.  And another.  And another.
> 
> > What I have in mind are:
> >
> >   - The regression you mentioned on qemu_fflush() when ram save (I hope I
> >     understand the problem right, though...).
> 
> After the PULL request that I am about to send, we need to get another 4
> patches reviewed.

Could you help list them out?  I can review them today and get it fixed
asap.

> 
> >   - The slowness of migration-test.  I'm not sure whether you have anything
> >     better than either Dan's approach
> 
> too complex for my taste, and don't get all the speed back.
> 
> > or the switchover-hold flags,
> 
> I proposed this, but in a different way, will try to send something
> before the week ends, sorry for the delay.

That's not a major problem yet to me, as long as others are fine with
migration-test being slow.  Glad to read and review it.

Thanks,

-- 
Peter Xu


