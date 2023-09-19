Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BDF7A5F7E
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 12:27:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiXwI-0000d1-4R; Tue, 19 Sep 2023 06:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qiXwA-0000OL-1l
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:26:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qiXw7-0000zX-DE
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695119190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=76pJHubmg3ub9LtQO3tuY9Z2WsU5xRB+EplDbOjTgNA=;
 b=dPrTqhLE3BTTATGPwPPZGG5BhLw8JEr7vCUK3hgwmpyhlEbHrRHLbetp45l/mm0yjNhNYU
 RlkoA6aZ4nh9TEsbAGl+qwea6hGllawX3cNsDoZJ/+xgL0cHOPI+lE+vXUtvLjZfcGTqPM
 ElDutO1YKyP1BbIQssJBVriJhCJBGnw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-p-xFxS1JM4KkVg_sE_3tYw-1; Tue, 19 Sep 2023 06:26:24 -0400
X-MC-Unique: p-xFxS1JM4KkVg_sE_3tYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43A2C85A5A8;
 Tue, 19 Sep 2023 10:26:24 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A151D28FB;
 Tue, 19 Sep 2023 10:26:23 +0000 (UTC)
Date: Tue, 19 Sep 2023 12:26:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PULL 00/28] Block layer patches
Message-ID: <ZQl3Tp7uWPyn/gYa@redhat.com>
References: <20230915144344.238596-1-kwolf@redhat.com>
 <CAJSP0QUPOVq5v+7W8E-ruV-Wbg1HYZn2kFWaDzULxSO-3SdEZg@mail.gmail.com>
 <CAJSP0QUYa2+RHeFwztjBrkNs28vqnUVV3rPkNo0+Jx=5ZBfANg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QUYa2+RHeFwztjBrkNs28vqnUVV3rPkNo0+Jx=5ZBfANg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 18.09.2023 um 20:56 hat Stefan Hajnoczi geschrieben:
> Hi Kevin,
> I believe that my own commit "block-coroutine-wrapper: use
> qemu_get_current_aio_context()" breaks this test. The failure is
> non-deterministic (happens about 1 out of 4 runs).
> 
> It seems the job hangs and the test times out in vm.run_job('job1', wait=5.0).
> 
> I haven't debugged it yet but wanted to share this information to save
> some time. Tomorrow I'll investigate further.

Yes, it's relatively easily reproducible if I run the test in a loop,
and I can't seem to reproduce it without the last patch. Should I
unstage the full series again, or do you think that the last patch is
really optional this time?

However, I'm unsure how the stack traces I'm seeing are related to your
patch. Maybe it just made an existing bug more likely to be triggered?

What I'm seeing is that the reader lock is held by an iothread that is
waiting for its AioContext lock to make progress:

Thread 3 (Thread 0x7f811e9346c0 (LWP 26390) "qemu-system-x86"):
#0  0x00007f81250aaf80 in __lll_lock_wait () at /lib64/libc.so.6
#1  0x00007f81250b149a in pthread_mutex_lock@@GLIBC_2.2.5 () at /lib64/libc.so.6
#2  0x000055b7b170967e in qemu_mutex_lock_impl (mutex=0x55b7b34e3080, file=0x55b7b199e1f7 "../util/async.c", line=728) at ../util/qemu-thread-posix.c:94
#3  0x000055b7b1709953 in qemu_rec_mutex_lock_impl (mutex=0x55b7b34e3080, file=0x55b7b199e1f7 "../util/async.c", line=728) at ../util/qemu-thread-posix.c:149
#4  0x000055b7b1728318 in aio_context_acquire (ctx=0x55b7b34e3020) at ../util/async.c:728
#5  0x000055b7b1727c49 in co_schedule_bh_cb (opaque=0x55b7b34e3020) at ../util/async.c:565
#6  0x000055b7b1726f1c in aio_bh_call (bh=0x55b7b34e2e70) at ../util/async.c:169
#7  0x000055b7b17270ee in aio_bh_poll (ctx=0x55b7b34e3020) at ../util/async.c:216
#8  0x000055b7b170351d in aio_poll (ctx=0x55b7b34e3020, blocking=true) at ../util/aio-posix.c:722
#9  0x000055b7b1518604 in iothread_run (opaque=0x55b7b2904460) at ../iothread.c:63
#10 0x000055b7b170a955 in qemu_thread_start (args=0x55b7b34e36b0) at ../util/qemu-thread-posix.c:541
#11 0x00007f81250ae15d in start_thread () at /lib64/libc.so.6
#12 0x00007f812512fc00 in clone3 () at /lib64/libc.so.6

On the other hand, the main thread wants to acquire the writer lock,
but it holds the AioContext lock of the iothread (it takes it in
job_prepare_locked()):

Thread 1 (Thread 0x7f811f4b7b00 (LWP 26388) "qemu-system-x86"):
#0  0x00007f8125122356 in ppoll () at /lib64/libc.so.6
#1  0x000055b7b172eae0 in qemu_poll_ns (fds=0x55b7b34ec910, nfds=1, timeout=-1) at ../util/qemu-timer.c:339
#2  0x000055b7b1704ebd in fdmon_poll_wait (ctx=0x55b7b3269210, ready_list=0x7ffc90b05680, timeout=-1) at ../util/fdmon-poll.c:79
#3  0x000055b7b1703284 in aio_poll (ctx=0x55b7b3269210, blocking=true) at ../util/aio-posix.c:670
#4  0x000055b7b1567c3b in bdrv_graph_wrlock (bs=0x0) at ../block/graph-lock.c:145
#5  0x000055b7b1554c1c in blk_remove_bs (blk=0x55b7b4425800) at ../block/block-backend.c:916
#6  0x000055b7b1554779 in blk_delete (blk=0x55b7b4425800) at ../block/block-backend.c:497
#7  0x000055b7b1554133 in blk_unref (blk=0x55b7b4425800) at ../block/block-backend.c:557
#8  0x000055b7b157a149 in mirror_exit_common (job=0x55b7b4419000) at ../block/mirror.c:696
#9  0x000055b7b1577015 in mirror_prepare (job=0x55b7b4419000) at ../block/mirror.c:807
#10 0x000055b7b153a1a7 in job_prepare_locked (job=0x55b7b4419000) at ../job.c:988
#11 0x000055b7b153a0d9 in job_txn_apply_locked (job=0x55b7b4419000, fn=0x55b7b153a110 <job_prepare_locked>) at ../job.c:191
#12 0x000055b7b1538b6d in job_do_finalize_locked (job=0x55b7b4419000) at ../job.c:1011
#13 0x000055b7b153a886 in job_completed_txn_success_locked (job=0x55b7b4419000) at ../job.c:1068
#14 0x000055b7b1539372 in job_completed_locked (job=0x55b7b4419000) at ../job.c:1082
#15 0x000055b7b153a71b in job_exit (opaque=0x55b7b4419000) at ../job.c:1103
#16 0x000055b7b1726f1c in aio_bh_call (bh=0x7f8110005470) at ../util/async.c:169
#17 0x000055b7b17270ee in aio_bh_poll (ctx=0x55b7b3269210) at ../util/async.c:216
#18 0x000055b7b1702c05 in aio_dispatch (ctx=0x55b7b3269210) at ../util/aio-posix.c:423
#19 0x000055b7b1728a14 in aio_ctx_dispatch (source=0x55b7b3269210, callback=0x0, user_data=0x0) at ../util/async.c:358
#20 0x00007f8126c31c7f in g_main_dispatch (context=0x55b7b3269720) at ../glib/gmain.c:3454
#21 g_main_context_dispatch (context=0x55b7b3269720) at ../glib/gmain.c:4172
#22 0x000055b7b1729c98 in glib_pollfds_poll () at ../util/main-loop.c:290
#23 0x000055b7b1729572 in os_host_main_loop_wait (timeout=27462700) at ../util/main-loop.c:313
#24 0x000055b7b1729452 in main_loop_wait (nonblocking=0) at ../util/main-loop.c:592
#25 0x000055b7b119a1eb in qemu_main_loop () at ../softmmu/runstate.c:772
#26 0x000055b7b14c102d in qemu_default_main () at ../softmmu/main.c:37
#27 0x000055b7b14c1068 in main (argc=44, argv=0x7ffc90b05d58) at ../softmmu/main.c:48

At first I thought we just need to look into the AioContext locking in
job completion and drop it in the right places.

But in fact, first of all, blk_remove_bs() needs to make up its mind if
it wants the caller to hold the AioContext or not and document that.
Because it calls both bdrv_drained_begin() (which requires holding the
AioContext lock) and bdrv_graph_wrlock(NULL) (which forbids it).

If we could fully get rid of the AioContext lock (as we originally
stated as a goal), that would automatically solve this kind of
deadlocks.

Kevin


