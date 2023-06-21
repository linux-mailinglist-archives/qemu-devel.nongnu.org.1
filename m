Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 979C57392D9
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 01:07:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC6tj-0000K1-FZ; Wed, 21 Jun 2023 19:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC6th-0000JD-77
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 19:05:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC6tf-0000kg-0F
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 19:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687388754;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=fDPr2rBrw8V/KASVlT5hQ2ZeKxNPLYLkc3b2DbVjAzo=;
 b=GsgqoCbkbLQY3MpVhjf/Y8f33QzGMfGX19/uC3JO39u3MLdzChW4SRPPW0N+yVis1hDkx7
 /uKSSD/TC9PFbbqimcHk7Zus5xQk0rZZkAupxvLJXs11zuiam8Wz1inmZ3//7KzSfL92N5
 uXe0Yit25HAE+K7018nCoVBfC4Xq+3Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-KETGDETqPWy7ti5RbCQQWA-1; Wed, 21 Jun 2023 19:05:52 -0400
X-MC-Unique: KETGDETqPWy7ti5RbCQQWA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-311182a5253so23237f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 16:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687388751; x=1689980751;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fDPr2rBrw8V/KASVlT5hQ2ZeKxNPLYLkc3b2DbVjAzo=;
 b=C6hH+ZHz3SnQ4TqBO3qUedaZBfQFOm01KA7x7B0s8t6SdPPZaoc2qeM3PM+XQZRqCA
 gFF0+9EALPdtGkcGpMQOHV6/JwzLNgIx9zw0r+hklJRX2yWnjUAOBv3lpk8bFqoJD+my
 KIeip8fDxEQh4aHuCN56ppxwkzlvAoso0FmbnOf96F2fhypESqbbkBCY3S8DE+DWpvwJ
 bhe7eMDwPL1ezpEw1Wqd866kNP/WPJoN1yCVwh+Syvg9MiJtgeUkecNugciq3h2XDz2R
 DcvfasVRCGnSi3N7DHhyvdV56K/7oAsA0q7A00azJWX267cxDjRQq70/eIfLfN1qJOF1
 AWvQ==
X-Gm-Message-State: AC+VfDxXoyzYFIqxEwtY9uqK8ftlKI+YPcUL26Nv7Dercsn3N89JRCA9
 e47H7yIEOvqNW/ZSlu0h//80j+VJVvMPFXnLy+a8M6h9StB6xVTYvDgqMprytozVzk7xI7gj9Ao
 yPebsSFaM2R8v5t0=
X-Received: by 2002:adf:d088:0:b0:312:974f:43a3 with SMTP id
 y8-20020adfd088000000b00312974f43a3mr328284wrh.10.1687388751287; 
 Wed, 21 Jun 2023 16:05:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6X/Jkr2LZ0YFgYJoPqZUUsSCKstxUitDNkFkWuXGrGPOxTBbsEdOR+BC+iavmI5I/NZcieKw==
X-Received: by 2002:adf:d088:0:b0:312:974f:43a3 with SMTP id
 y8-20020adfd088000000b00312974f43a3mr328261wrh.10.1687388750799; 
 Wed, 21 Jun 2023 16:05:50 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 p16-20020a5d6390000000b003113943bb66sm5445518wru.110.2023.06.21.16.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 16:05:50 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Leonardo Bras <leobras@redhat.com>,  Hailiang
 Zhang <zhanghailiang@xfusion.com>,  Fiona Ebner <f.ebner@proxmox.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,  qemu-block@nongnu.org,  Fam Zheng
 <fam@euphon.net>
Subject: Re: [PATCH v2 06/20] qemu_file: total_transferred is not used anymore
In-Reply-To: <ZInUEU0WqmUPI0tZ@x1n> (Peter Xu's message of "Wed, 14 Jun 2023
 10:52:01 -0400")
References: <20230530183941.7223-1-quintela@redhat.com>
 <20230530183941.7223-7-quintela@redhat.com> <ZInUEU0WqmUPI0tZ@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 22 Jun 2023 01:05:49 +0200
Message-ID: <87a5ws8lgy.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> wrote:
> On Tue, May 30, 2023 at 08:39:27PM +0200, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/qemu-file.c | 4 ----
>>  1 file changed, 4 deletions(-)
>> 
>> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
>> index eb0497e532..6b6deea19b 100644
>> --- a/migration/qemu-file.c
>> +++ b/migration/qemu-file.c
>> @@ -41,9 +41,6 @@ struct QEMUFile {
>>      QIOChannel *ioc;
>>      bool is_writable;
>>  
>> -    /* The sum of bytes transferred on the wire */
>> -    uint64_t total_transferred;
>> -
>>      int buf_index;
>>      int buf_size; /* 0 when writing */
>>      uint8_t buf[IO_BUF_SIZE];
>> @@ -287,7 +284,6 @@ void qemu_fflush(QEMUFile *f)
>>              qemu_file_set_error_obj(f, -EIO, local_error);
>>          } else {
>>              uint64_t size = iov_size(f->iov, f->iovcnt);
>> -            f->total_transferred += size;
>
> I think this patch is another example why I think sometimes the way patch
> is split are pretty much adding more complexity on review...

It depends of taste.

You are doing one thing in way1.
Then you find a better way to do it, lets call it way2.

Now we have two options to see how we arrived there.

a- You got any declarations/definition/initializations for way2
b- You write way2 alongside way1
c- You test that both ways give the same result, and you see that they
   give the same result.
d- you remove the way1.

Or you squash the four patches in a single patch.  But then the reviewer
lost the place where one can see why it is the same than the old one.

Sometimes is better the longer way, sometimes is better the short one.

Clearly we don't agree about what is the best way in this case.

> Here we removed a variable operation but it seems all fine if it's not used
> anywhere.  But it also means current code base (before this patch applied)
> doesn't make sense already because it contains this useless addition.  So
> IMHO it means some previous patch does it just wrong.

No.  It is how it is developed.  And being respectful with the
reviewer.  Given it enough information to do a proper review.

During the development of this series, there were lots of:

if (old_counter != new_counter)
   printf("....");

traces were in the several thousand lines long.  If I have to review
that change, I would love any help that writer can give me.  That is why
it is done this way.

> I think it means it's caused by a wrong split of patches, then each patch
> stops to make much sense as a standalone one.

It stops making sense if you want each feature to be a single patch.
Before the patch no feature.  After the patch full feature.  That brings
us to very long patches.

What is easier to review (to do the same)

a - 1 x 1000 lines patch
b - 10 x 100 lines patch

I will go with b any time.  Except if the split is arbitrary.

> I can go back and try to find whatever patch on the list that will explain
> this.  But it'll also go into git log.  Anyone reads this later will be
> confused once again.  Even harder for them to figure out what
> happened.

As said before, I completely disagree here.  And what is worse.  If it
gets wrong, with your approach git bisect will not help as much than
with my appreach.

> Do you think we could reorganize the patches so each of a single patch
> explains itself?

No.  See before.  We go for a very spaguetti code to a much less
spaguety code.

> The other thing is about priority of patches - I still have ~80 patches
> pending reviews on migration only.. Would you think it makes sense we pickg
> up important ones first and merge them with higher priority?

Ok, lets make this clear.
This whole atomic migration counters started because the zero_page
detection in multifd had the counters so wrong that meassuring speed
become impossible.

I haven't yet send the multifd zero pages.  And why was it so
complicated.  Just on top of my memory.

- how much data had we transferred.  Historically we stored that
  information on qemu-file.  But qemu-file can only be read/written from
  the migration thread.  So we went through jumps to be able to update
  that values.

  Current upstream code for compressed multifd assumes that it transfer
  as much data as non compressed one.  Why?  because we don't have an
  easy way to get that value back.  Contorsions that we were trying to
  do:

  https://lore.kernel.org/all/20220802063907.18882-5-quintela@redhat.com/

  To resume, the way that we had to do it was something like:

  - we send a bunch of pages to multifd thread
  - multifd thread send data and returns on the buffer what has written
  - migration thread when reuses a buffer adds the written stuff from
    previous time than the struct was used.

  This was not just problematic from multifd zero pages detection.
  * compression was lying about it
  * zero_copy is doing it wrong (accounting at the time that it does the
    write, not when it knows that it was written).

- rdma: this is even funnier
  * It accounted for zero and normal pages in two places
    https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg07693.html
    (still does, I have to resed that bit)
  * It accounts for imaginary transfers
    https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg07700.html
    Because it has to give the apparence of progress, i.e. that it has
    written something, but it is not true because RDMA is completely
    asynchronous.
  * RDMA and qemu-file were very, very difficult to put appart.
    Remember that RDMA don't send _anything_ through the qemu_file, it
    has its parameter only for the accounting.

- counters:
  qemu_file can only be accessed through Migration thread.
  But each time that you do an info migrate, it is done through the IO
  thread, not the migration thread.  So it was accessing a shared
  variable without any locking.  And putting locking means that we also
  need to lock it on the Migration thread.  So everything that is
  exported to the user needs to be atomic.

- Postcopy preempt
  And here we are, another thread. That uses qemu file, another qemu
  file.  Its access is not racy, because .... we don't account for the
  data sent through the preempt channel.  At all.  Because ... it is
  complicated.

- But we are not happy with this.  We have to calculate the rate limit.
  And for that, we use another counter on the qemu file.  that is
  updated on (almost) the same places that we update the transferred
  counter.  Basically the difference is that multifd don't update the
  transferred counter but update the rate_limit. But RDMA updates both.

- Not happy with this, we decided that this was too complicated and
  added yet another counter.  transferreed.  And atomic one.  You are
  going to ask why.  Well, I am guessing here.  But the problem is that
  when can do info migrate after ending a migration.  And at that time
  qemu-file is gone, so we add another counter instead of storing the
  value of qemu-file.

Should I continue, and search for the patches that changed the things,
or can we agree that this is a complex problem and can't be fixed with
yet another one line?  I spent the best part of a couple of months
trying to fix the problem with one liners, and ended without fixing the
problem after too many one liners.

Ended spending another couple of months writting changing the code
correctly, simplifying the number of counters and giving the same
functionality that was before.  But it took too many patches.

And why it ends with so many patches?
I am glad that you asked.  Because I find a bug.  And I try to fix it.
And then I see that there is another thing that I need to fix to be able
to fix this one.  And another.  And another.

> What I have in mind are:
>
>   - The regression you mentioned on qemu_fflush() when ram save (I hope I
>     understand the problem right, though...).

After the PULL request that I am about to send, we need to get another 4
patches reviewed.

>   - The slowness of migration-test.  I'm not sure whether you have anything
>     better than either Dan's approach

too complex for my taste, and don't get all the speed back.

> or the switchover-hold flags,

I proposed this, but in a different way, will try to send something
before the week ends, sorry for the delay.

> I just
>     think that seems more important to resolve for us upstream.  We can
>     merge Dan's or mine, you can also propose something else, but IMHO that
>     seems to be a higher priority?

> And whatever else I haven't noticed.  I'll continue reading but I'm sure
> you know the best on this..  so I'd really rely on you.

> What do you think?

Thanks, Juan.


