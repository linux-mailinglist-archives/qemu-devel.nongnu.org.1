Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B54F761FA4
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 18:54:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOLHm-0002BE-JF; Tue, 25 Jul 2023 12:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qOLHl-0002Ad-76
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 12:53:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qOLHj-0001l4-Ch
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 12:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690303994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aAPhFRekQ9NdAPQiUS5fR6+fM7WI71TjVc4QWzlG25A=;
 b=GKw+6yb6td284zI2uRN4kHRvwuiI/1nQf6AblZQ/085qFbeO1ooM4c2vJEcGwP7f41EhNt
 xx9mdRamqO2GfZmbYdkZFY+FpO0G/PlElmYhpBaeT6qD/L2KKXa3vfmE9WaF0vOnWDm/hp
 faHDR/Hxuui8qM+EDBDH2ptfoOzKB4k=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-McUSl4mlMhqx0v-qbKAUVQ-1; Tue, 25 Jul 2023 12:53:12 -0400
X-MC-Unique: McUSl4mlMhqx0v-qbKAUVQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-765ad67e690so125520485a.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 09:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690303992; x=1690908792;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aAPhFRekQ9NdAPQiUS5fR6+fM7WI71TjVc4QWzlG25A=;
 b=QUR0c5J2oerKuzXNa3BcZn5t9G+rW8zrD905MrViw1hXmLjuw3RW1w6nkkll4KBlrW
 31yJER29xMIdKYankXQNpo6htwMOojUFI6/FSaXU9MrhmrIJFKUbYh52a79ydD5krQEp
 nWNOMnOwkaldbWUGYvqtheNj63pmSet6VcwyoY9GtviRcICBAHOxZA4AnQAlGDyRPQ8t
 +56LZP768f5purNlBIpO9AAu3ezA33id1Nszec6rBVYQZFkZJtNDdWgmKYtasH7NW6We
 lX4rhuUJ+6WDPPZ7f+5kVIr1R2p6NO8mrncCSjX3JgbH4ylxby07eSa9O/x+ug4VgLbD
 //UQ==
X-Gm-Message-State: ABy/qLbMCLUBCUK2BNpEyqWXsOJ72wWGlg7TXVkrBzaxL5WUuQXEnhOS
 kaj9sc/uPepd1mhJgqQnIvRyKrhkw/CMxjRyEqXGoOzLoHuAnI+f0EzWcGfaBoDlQT/4h1Q6LGi
 1a3O3+6hJYzMiE+U=
X-Received: by 2002:a05:620a:3956:b0:767:346c:4b37 with SMTP id
 qs22-20020a05620a395600b00767346c4b37mr15668058qkn.7.1690303992350; 
 Tue, 25 Jul 2023 09:53:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGwNHRyD6G3Isrx8ORNJ/Cj1TYEvalQS54fcGtBh46mXDr+fX3SrihK3AvzKyFjGsjC5I5Kbg==
X-Received: by 2002:a05:620a:3956:b0:767:346c:4b37 with SMTP id
 qs22-20020a05620a395600b00767346c4b37mr15668042qkn.7.1690303992044; 
 Tue, 25 Jul 2023 09:53:12 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 w7-20020ae9e507000000b00767c61ee342sm3773936qkf.48.2023.07.25.09.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 09:53:11 -0700 (PDT)
Date: Tue, 25 Jul 2023 12:53:01 -0400
From: Peter Xu <peterx@redhat.com>
To: "chenyuhui (A)" <chenyuhui5@huawei.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 xuyinghua3@huawei.com, liheng.liheng@huawei.com,
 renxuming@huawei.com, pengyi.pengyi@huawei.com, yubihong@huawei.com,
 zhengchuan@huawei.com, huhao33@huawei.com, caozhongwang1@huawei.com,
 caiqingmu@huawei.com, Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH] migrate/multifd: fix coredump when the multifd thread
 cleanup
Message-ID: <ZL/97XT8wRq1hsVN@x1n>
References: <20230621081826.3203053-1-zhangjianguo18@huawei.com>
 <87wmzwsxmz.fsf@suse.de>
 <53a69e3b-f9f7-b2c1-9487-f9992ffec2a3@huawei.com>
 <ae697c8c-5d57-071c-240a-6f1e8307bdbd@huawei.com>
 <dd678c96-6065-0c53-9543-312a647298e2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd678c96-6065-0c53-9543-312a647298e2@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Jul 25, 2023 at 04:43:28PM +0800, chenyuhui (A) wrote:
> @Peter Xu @Fabiano Rosas
> Kindly ping on this.

Ah I see what's missing - please copy maintainer (Juan) for any migration
patches, especially multifd ones..  I'm doing that for this one, but I'd
suggest you repost with a whole patch and information put into commit msg.

Thanks.

> 
> On 2023/6/27 9:11, chenyuhui (A) wrote:
> > 
> > On 2023/6/26 21:16, chenyuhui (A) wrote:
> >>
> >> On 2023/6/21 22:22, Fabiano Rosas wrote:
> >>> Jianguo Zhang via <qemu-devel@nongnu.org> writes:
> >>>
> >>>> From: Yuhui Chen <chenyuhui5@huawei.com>
> >>>>
> >>>> There is a coredump while trying to destroy mutex when
> >>>> p->running is false but p->mutex is not unlock.
> >>>> Make sure all mutexes has been released before destroy them.
> >>>>
> >>>> Signed-off-by: Yuhui Chen <chenyuhui5@huawei.com>
> >>>> ---
> >>>>  migration/multifd.c | 6 ++----
> >>>>  1 file changed, 2 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/migration/multifd.c b/migration/multifd.c
> >>>> index b7ad7002e0..7dcdb2d3a0 100644
> >>>> --- a/migration/multifd.c
> >>>> +++ b/migration/multifd.c
> >>>> @@ -523,9 +523,7 @@ void multifd_save_cleanup(void)
> >>>>      for (i = 0; i < migrate_multifd_channels(); i++) {
> >>>>          MultiFDSendParams *p = &multifd_send_state->params[i];
> >>>>  
> >>>> -        if (p->running) {
> >>>
> >>> The need for this flag is dubious IMO. Commit 10351fbad1
> >>> ("migration/multifd: Join all multifd threads in order to avoid leaks")
> >>> already moved the other join outside of it. If we figure out another way
> >>> to deal with the sem_sync lockup we could probably remove this
> >>> altogether.
> >>
> >>
> >> I've seen this commit 10351fbad1, and it's seems to have the same
> >> problem in function multifd_save_cleanup.
> >>
> >> So that may my patch only need to modify multifd_save_cleanup.
> >>
> >> __________________________________________________________________
> >>
> >>
> >> On 2023/6/21 21:24, Peter Xu wrote:
> >>> On Wed, Jun 21, 2023 at 04:18:26PM +0800, Jianguo Zhang via wrote:
> >>>> From: Yuhui Chen<chenyuhui5@huawei.com>
> >>>>
> >>>> There is a coredump while trying to destroy mutex when
> >>>> p->running is false but p->mutex is not unlock.
> >>>> Make sure all mutexes has been released before destroy them.
> >>>
> >>> It'll be nice to add a backtrace of the coredump here, and also copy
> >>> maintainer (Juan Quintela, copied now).
> >>>
> >>
> >> The following is coredump, and my code is base on
> >> https://github.com/qemu/qemu.git tag v6.2.0.
> >>
> > (gdb) bt
> > #0  0x0000ffffabe3b2b8 in  () at /usr/lib64/libc.so.6
> > #1  0x0000ffffabdf6d7c in raise () at /usr/lib64/libc.so.6
> > #2  0x0000ffffabde4d2c in abort () at /usr/lib64/libc.so.6
> > #3  0x0000aaaac67fcc10 in error_exit (err=<optimized out>, msg=msg@entry=0xaaaac6dc52b8 <__func__.33> "qemu_mutex_destroy") at ../util/qemu-thread-posix.c:38
> > #4  0x0000aaaac67fce38 in qemu_mutex_destroy (mutex=mutex@entry=0xaaaafa1a4250) at ../util/qemu-thread-posix.c:71
> > #5  0x0000aaaac6055688 in multifd_save_cleanup () at ../migration/multifd.c:555
> > #6  0x0000aaaac6050198 in migrate_fd_cleanup (s=s@entry=0xaaaaf7518800) at ../migration/migration.c:1808
> > #7  0x0000aaaac6050384 in migrate_fd_cleanup_bh (opaque=0xaaaaf7518800) at ../migration/migration.c:1850
> > #8  0x0000aaaac680d790 in aio_bh_call (bh=0xffffa0004c40) at ../util/async.c:141
> > #9  aio_bh_poll (ctx=ctx@entry=0xaaaaf73285a0) at ../util/async.c:169
> > #10 0x0000aaaac67f9e18 in aio_dispatch (ctx=0xaaaaf73285a0) at ../util/aio-posix.c:381
> > #11 0x0000aaaac680d414 in aio_ctx_dispatch (source=<optimized out>, callback=<optimized out>, user_data=<optimized out>) at ../util/async.c:311
> > #12 0x0000ffffac44cf88 in g_main_context_dispatch () at /usr/lib64/libglib-2.0.so.0
> > #13 0x0000aaaac6819214 in glib_pollfds_poll () at ../util/main-loop.c:232
> > #14 os_host_main_loop_wait (timeout=735000000) at ../util/main-loop.c:255
> > #15 main_loop_wait (nonblocking=nonblocking@entry=0) at ../util/main-loop.c:531
> > #16 0x0000aaaac65005cc in qemu_main_loop () at ../softmmu/runstate.c:726
> > #17 0x0000aaaac5fe2030 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at ../softmmu/main.c:50
> > (gdb) q
> > 
> >> How reproducible:
> >> 1、And sleep time to produce p->running is false but p->mutex is
> >>  not unlock.(apply following patch)
> >> 2、Do migration with --parallel-connections.
> >>>> From: Yuhui Chen <chenyuhui5@huawei.com>
> >> Date: Mon, 26 Jun 2023 14:24:35 +0800
> >> Subject: [DEBUG][PATCH] And sleep time to produce p->running is false but p->mutex is
> >>  not unlock.
> >>
> >> ---
> >>  migration/multifd.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/migration/multifd.c b/migration/multifd.c
> >> index 7c9deb1921..09a7b0748a 100644
> >> --- a/migration/multifd.c
> >> +++ b/migration/multifd.c
> >> @@ -538,6 +538,7 @@ void multifd_save_cleanup(void)
> >>      for (i = 0; i < migrate_multifd_channels(); i++) {
> >>          MultiFDSendParams *p = &multifd_send_state->params[i];
> >>
> >> +        sleep(2);
> >>          if (p->running) {
> >>              qemu_thread_join(&p->thread);
> >>          }
> >> @@ -719,6 +720,7 @@ out:
> >>
> >>      qemu_mutex_lock(&p->mutex);
> >>      p->running = false;
> >> +    sleep(20);
> >>      qemu_mutex_unlock(&p->mutex);
> >>
> >>      rcu_unregister_thread();
> 

-- 
Peter Xu


