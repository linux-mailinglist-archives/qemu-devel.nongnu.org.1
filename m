Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDB279EDF9
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 18:10:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgSQR-0006Na-Cn; Wed, 13 Sep 2023 12:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qgSQQ-0006NR-BA
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 12:09:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qgSQN-00088F-RZ
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 12:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694621346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cetxQDTidKJHru7tjJu9MZ0usRly48PNxr6k2M+SPgs=;
 b=Lwp1rnK03dGkSdIDn8GbY1zW4H7i6NK60DHyjdln99a8OJ68wPT70yUbAoduWEBiFQUxaT
 unKfQdkyBtZ8T5Viv54Ryiv0h856co1oxmOPQUDoXAuqGE6lJlTO7aajogSco+ru/VLfP/
 lc43DTnSzCwqc8U7biPX+/GWG7whUD4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-K0ZbnWImOLGRcnfIpnNfQA-1; Wed, 13 Sep 2023 12:09:03 -0400
X-MC-Unique: K0ZbnWImOLGRcnfIpnNfQA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEAC181B196;
 Wed, 13 Sep 2023 16:09:02 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 799BA2026D4B;
 Wed, 13 Sep 2023 16:08:56 +0000 (UTC)
Date: Wed, 13 Sep 2023 11:08:54 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Klaus Jensen <its@irrelevant.dk>, 
 kwolf@redhat.com, Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 David Hildenbrand <david@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v3 2/5] test-bdrv-drain: avoid race with BH in IOThread
 drain test
Message-ID: <wxfg62pyjq2dhh7jfhpng7tgnkaz3o5zkdie426m7tbgopjkhm@gijotjxjzjhf>
References: <20230912231037.826804-1-stefanha@redhat.com>
 <20230912231037.826804-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912231037.826804-3-stefanha@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Sep 12, 2023 at 07:10:34PM -0400, Stefan Hajnoczi wrote:
> This patch fixes a race condition in test-bdrv-drain that is difficult
> to reproduce. test-bdrv-drain sometimes fails without an error message
> on the block pull request sent by Kevin Wolf on Sep 4, 2023. I was able
> to reproduce it locally and found that "block-backend: process I/O in
> the current AioContext" (in this patch series) is the first commit where
> it reproduces.
> 
> I do not know why "block-backend: process I/O in the current AioContext"
> exposes this bug. It might be related to the fact that the test's preadv
> request runs in the main thread instead of IOThread a after my commit.

In reading the commit message before the impacted code, my first
thought was that you had a typo of an extra word (that is, something
to fix by s/a //), but reading further, a better fix would be calling
attention to the fact that you are referencing a specific named
thread, as in s/IOThread a/IOThread A/...

> That might simply change the timing of the test.
> 
> Now on to the race condition in test-bdrv-drain. The main thread
> schedules a BH in IOThread a and then drains the BDS:

...and another spot with the same parse issue...

> 
>   aio_bh_schedule_oneshot(ctx_a, test_iothread_main_thread_bh, &data);
> 
>   /* The request is running on the IOThread a. Draining its block device

...but here you were quoting from the existing code base, which is
where I finally realized it was more than just your commit message.

>    * will make sure that it has completed as far as the BDS is concerned,
>    * but the drain in this thread can continue immediately after
>    * bdrv_dec_in_flight() and aio_ret might be assigned only slightly
>    * later. */
>   do_drain_begin(drain_type, bs);
> 
> If the BH completes before do_drain_begin() then there is nothing to
> worry about.
> 
> If the BH invokes bdrv_flush() before do_drain_begin(), then
> do_drain_begin() waits for it to complete.
> 
> The problematic case is when do_drain_begin() runs before the BH enters
> bdrv_flush(). Then do_drain_begin() misses the BH and the drain
> mechanism has failed in quiescing I/O.
> 
> Fix this by incrementing the in_flight counter so that do_drain_begin()
> waits for test_iothread_main_thread_bh().
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/unit/test-bdrv-drain.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
> index ccc453c29e..67a79aa3f0 100644
> --- a/tests/unit/test-bdrv-drain.c
> +++ b/tests/unit/test-bdrv-drain.c
> @@ -512,6 +512,7 @@ static void test_iothread_main_thread_bh(void *opaque)
>       * executed during drain, otherwise this would deadlock. */
>      aio_context_acquire(bdrv_get_aio_context(data->bs));
>      bdrv_flush(data->bs);
> +    bdrv_dec_in_flight(data->bs); /* incremented by test_iothread_common() */
>      aio_context_release(bdrv_get_aio_context(data->bs));
>  }
>  
> @@ -583,6 +584,13 @@ static void test_iothread_common(enum drain_type drain_type, int drain_thread)
>              aio_context_acquire(ctx_a);
>          }
>  
> +        /*
> +         * Increment in_flight so that do_drain_begin() waits for
> +         * test_iothread_main_thread_bh(). This prevents the race between
> +         * test_iothread_main_thread_bh() in IOThread a and do_drain_begin() in
> +         * this thread. test_iothread_main_thread_bh() decrements in_flight.
> +         */
> +        bdrv_inc_in_flight(bs);
>          aio_bh_schedule_oneshot(ctx_a, test_iothread_main_thread_bh, &data);
>  
>          /* The request is running on the IOThread a. Draining its block device

and indeed, your commit message is consistent with the current code's
naming convention.  If you have reason to respin, a pre-req patch to
change the case before adding more references might be nice, but I
won't insist.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


