Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B56577A6B99
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 21:36:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qigUz-0006TB-Lm; Tue, 19 Sep 2023 15:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qigUw-0006SS-UC; Tue, 19 Sep 2023 15:35:02 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qigUr-0003Mn-Ul; Tue, 19 Sep 2023 15:35:02 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-573675e6b43so3917294eaf.0; 
 Tue, 19 Sep 2023 12:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695152096; x=1695756896; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j1Zhx3O79c8m682FIgxvYsX59BngevwLIRWg5LMvWrE=;
 b=Q7gijagNlhFcwyMQ9EHzjRKC/KE/RW03UHz7asSqjOfcBpVZnl6EtCH4E2axnmgov0
 NZtNtBf32WTkx5qpvHmEYyZ1bTiQqzsRXVSuQRDcCSpWAAr6jDtx8y2uPdmiyr5cr2PH
 +YiSefLbh176fxEqmeiyg/2RnRVhotaN5+KXfLRUJetWXNWsDTGKuoHfwwAfoDD0ONY0
 wTVuaXLvjbeTpZifU1epPZEJEGOipD4JTYZ/rX/uypGOjw+6NcdBqmwQQVR6UcagWOYf
 81J7c+Pijj1xZEWPH6QiFxe/9GPTERoMoAC1BrItka/5eZPot3eMGxdTgJR2nDivqD7J
 d+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695152096; x=1695756896;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j1Zhx3O79c8m682FIgxvYsX59BngevwLIRWg5LMvWrE=;
 b=G94dOhQQoKlsYDokoSWFelQy2HNQvIwBdLdqYwlrvRDMeQzSBjDjDVBrKRVePvFxKw
 hzUYqnGWaZkWeHwIsoBYxY7oIVwawV+UOrz/KwqpWxuzTbcl1hhnv3K4bkNNAILw5iJI
 wla0K/j9w7WL0ltWXBKH7pxawc5KvGy6P+MIOyFkGewd008Y8T/7j8gGw8rIBmvnhPfT
 0v/Gg7vmgY3FDH/EPhoj3ySdxeS5Gij0ErhDGKV2EEztQnwfK96DJWwKl1VutraM+puC
 8we4dIYJiSU0AW+1VPrlu3ONMtAa82+i3TAkafEKwkMN8rQB0wUtAjqbGJyFk+5Mqu7f
 JQ2g==
X-Gm-Message-State: AOJu0YyFIdEVYvxjxYmSKiPGznOdUooiAx3rEP0mJjP2nY6QH4S3dU4N
 X3SbXIKChUW55aRsq7oiJ7kbF5rOvq9qDI3T4e8=
X-Google-Smtp-Source: AGHT+IFmzcJtV6r0c35e1oo9qHCh7luGZwjgr3AhLTPZeyqEk8qCqiEK+sxlxo9LTiTHXesnrq//wRE6wlvJIx7fEn0=
X-Received: by 2002:a4a:3c17:0:b0:571:28d5:2c72 with SMTP id
 d23-20020a4a3c17000000b0057128d52c72mr525227ooa.7.1695152096139; Tue, 19 Sep
 2023 12:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230915144344.238596-1-kwolf@redhat.com>
 <CAJSP0QUPOVq5v+7W8E-ruV-Wbg1HYZn2kFWaDzULxSO-3SdEZg@mail.gmail.com>
 <CAJSP0QUYa2+RHeFwztjBrkNs28vqnUVV3rPkNo0+Jx=5ZBfANg@mail.gmail.com>
 <ZQl3Tp7uWPyn/gYa@redhat.com>
In-Reply-To: <ZQl3Tp7uWPyn/gYa@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 19 Sep 2023 15:34:44 -0400
Message-ID: <CAJSP0QW4wBzBaf2dJpFVw8A_5EtOZh12eLjLfHkPPn4C0V1s=w@mail.gmail.com>
Subject: Re: [PULL 00/28] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 19 Sept 2023 at 06:26, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 18.09.2023 um 20:56 hat Stefan Hajnoczi geschrieben:
> > Hi Kevin,
> > I believe that my own commit "block-coroutine-wrapper: use
> > qemu_get_current_aio_context()" breaks this test. The failure is
> > non-deterministic (happens about 1 out of 4 runs).
> >
> > It seems the job hangs and the test times out in vm.run_job('job1', wait=5.0).
> >
> > I haven't debugged it yet but wanted to share this information to save
> > some time. Tomorrow I'll investigate further.
>
> Yes, it's relatively easily reproducible if I run the test in a loop,
> and I can't seem to reproduce it without the last patch. Should I
> unstage the full series again, or do you think that the last patch is
> really optional this time?
>
> However, I'm unsure how the stack traces I'm seeing are related to your
> patch. Maybe it just made an existing bug more likely to be triggered?
>
> What I'm seeing is that the reader lock is held by an iothread that is
> waiting for its AioContext lock to make progress:
>
> Thread 3 (Thread 0x7f811e9346c0 (LWP 26390) "qemu-system-x86"):
> #0  0x00007f81250aaf80 in __lll_lock_wait () at /lib64/libc.so.6
> #1  0x00007f81250b149a in pthread_mutex_lock@@GLIBC_2.2.5 () at /lib64/libc.so.6
> #2  0x000055b7b170967e in qemu_mutex_lock_impl (mutex=0x55b7b34e3080, file=0x55b7b199e1f7 "../util/async.c", line=728) at ../util/qemu-thread-posix.c:94
> #3  0x000055b7b1709953 in qemu_rec_mutex_lock_impl (mutex=0x55b7b34e3080, file=0x55b7b199e1f7 "../util/async.c", line=728) at ../util/qemu-thread-posix.c:149
> #4  0x000055b7b1728318 in aio_context_acquire (ctx=0x55b7b34e3020) at ../util/async.c:728
> #5  0x000055b7b1727c49 in co_schedule_bh_cb (opaque=0x55b7b34e3020) at ../util/async.c:565
> #6  0x000055b7b1726f1c in aio_bh_call (bh=0x55b7b34e2e70) at ../util/async.c:169
> #7  0x000055b7b17270ee in aio_bh_poll (ctx=0x55b7b34e3020) at ../util/async.c:216
> #8  0x000055b7b170351d in aio_poll (ctx=0x55b7b34e3020, blocking=true) at ../util/aio-posix.c:722
> #9  0x000055b7b1518604 in iothread_run (opaque=0x55b7b2904460) at ../iothread.c:63
> #10 0x000055b7b170a955 in qemu_thread_start (args=0x55b7b34e36b0) at ../util/qemu-thread-posix.c:541
> #11 0x00007f81250ae15d in start_thread () at /lib64/libc.so.6
> #12 0x00007f812512fc00 in clone3 () at /lib64/libc.so.6
>
> On the other hand, the main thread wants to acquire the writer lock,
> but it holds the AioContext lock of the iothread (it takes it in
> job_prepare_locked()):
>
> Thread 1 (Thread 0x7f811f4b7b00 (LWP 26388) "qemu-system-x86"):
> #0  0x00007f8125122356 in ppoll () at /lib64/libc.so.6
> #1  0x000055b7b172eae0 in qemu_poll_ns (fds=0x55b7b34ec910, nfds=1, timeout=-1) at ../util/qemu-timer.c:339
> #2  0x000055b7b1704ebd in fdmon_poll_wait (ctx=0x55b7b3269210, ready_list=0x7ffc90b05680, timeout=-1) at ../util/fdmon-poll.c:79
> #3  0x000055b7b1703284 in aio_poll (ctx=0x55b7b3269210, blocking=true) at ../util/aio-posix.c:670
> #4  0x000055b7b1567c3b in bdrv_graph_wrlock (bs=0x0) at ../block/graph-lock.c:145
> #5  0x000055b7b1554c1c in blk_remove_bs (blk=0x55b7b4425800) at ../block/block-backend.c:916
> #6  0x000055b7b1554779 in blk_delete (blk=0x55b7b4425800) at ../block/block-backend.c:497
> #7  0x000055b7b1554133 in blk_unref (blk=0x55b7b4425800) at ../block/block-backend.c:557
> #8  0x000055b7b157a149 in mirror_exit_common (job=0x55b7b4419000) at ../block/mirror.c:696
> #9  0x000055b7b1577015 in mirror_prepare (job=0x55b7b4419000) at ../block/mirror.c:807
> #10 0x000055b7b153a1a7 in job_prepare_locked (job=0x55b7b4419000) at ../job.c:988
> #11 0x000055b7b153a0d9 in job_txn_apply_locked (job=0x55b7b4419000, fn=0x55b7b153a110 <job_prepare_locked>) at ../job.c:191
> #12 0x000055b7b1538b6d in job_do_finalize_locked (job=0x55b7b4419000) at ../job.c:1011
> #13 0x000055b7b153a886 in job_completed_txn_success_locked (job=0x55b7b4419000) at ../job.c:1068
> #14 0x000055b7b1539372 in job_completed_locked (job=0x55b7b4419000) at ../job.c:1082
> #15 0x000055b7b153a71b in job_exit (opaque=0x55b7b4419000) at ../job.c:1103
> #16 0x000055b7b1726f1c in aio_bh_call (bh=0x7f8110005470) at ../util/async.c:169
> #17 0x000055b7b17270ee in aio_bh_poll (ctx=0x55b7b3269210) at ../util/async.c:216
> #18 0x000055b7b1702c05 in aio_dispatch (ctx=0x55b7b3269210) at ../util/aio-posix.c:423
> #19 0x000055b7b1728a14 in aio_ctx_dispatch (source=0x55b7b3269210, callback=0x0, user_data=0x0) at ../util/async.c:358
> #20 0x00007f8126c31c7f in g_main_dispatch (context=0x55b7b3269720) at ../glib/gmain.c:3454
> #21 g_main_context_dispatch (context=0x55b7b3269720) at ../glib/gmain.c:4172
> #22 0x000055b7b1729c98 in glib_pollfds_poll () at ../util/main-loop.c:290
> #23 0x000055b7b1729572 in os_host_main_loop_wait (timeout=27462700) at ../util/main-loop.c:313
> #24 0x000055b7b1729452 in main_loop_wait (nonblocking=0) at ../util/main-loop.c:592
> #25 0x000055b7b119a1eb in qemu_main_loop () at ../softmmu/runstate.c:772
> #26 0x000055b7b14c102d in qemu_default_main () at ../softmmu/main.c:37
> #27 0x000055b7b14c1068 in main (argc=44, argv=0x7ffc90b05d58) at ../softmmu/main.c:48
>
> At first I thought we just need to look into the AioContext locking in
> job completion and drop it in the right places.
>
> But in fact, first of all, blk_remove_bs() needs to make up its mind if
> it wants the caller to hold the AioContext or not and document that.
> Because it calls both bdrv_drained_begin() (which requires holding the
> AioContext lock) and bdrv_graph_wrlock(NULL) (which forbids it).

I was surprised to see bdrv_graph_wrlock(NULL) called. The AioContext
lock is held across aio_poll() and that's why the hang occurs.

I'll make blk_remove_bs() consistent with respect to the AioContext
lock so this test failure can be fixed.

> If we could fully get rid of the AioContext lock (as we originally
> stated as a goal), that would automatically solve this kind of
> deadlocks.

Although it's not an indication that it's already safe to remove the
AioContext lock, I commented out the lock/unlock in
aio_context_acquire/release() and found that "make check" passes. Only
graph-changes-while-io fails when I run "qemu-iotests -qcow2".

I think the main thing keeping the AioContext lock around is
AIO_WAIT_WHILE(). The caller must hold the lock and that forces many
APIs to extend this requirement to their caller.

Perhaps more AIO_WAIT_WHILE() instances can now be converted to
AIO_WAIT_WHILE_UNLOCKED().

Stefan

