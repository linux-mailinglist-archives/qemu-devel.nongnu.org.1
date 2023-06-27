Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D9173F02D
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 03:13:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDxFd-0008RM-Dv; Mon, 26 Jun 2023 21:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyuhui5@huawei.com>)
 id 1qDxFa-0008RB-Eu
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 21:12:10 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyuhui5@huawei.com>)
 id 1qDxFV-0005l2-3K
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 21:12:10 -0400
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qqmnm0wNqzlWLD;
 Tue, 27 Jun 2023 09:09:16 +0800 (CST)
Received: from [10.174.187.43] (10.174.187.43) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 09:11:58 +0800
Message-ID: <ae697c8c-5d57-071c-240a-6f1e8307bdbd@huawei.com>
Date: Tue, 27 Jun 2023 09:11:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] migrate/multifd: fix coredump when the multifd thread
 cleanup
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, <peterx@redhat.com>,
 <qemu-devel@nongnu.org>
CC: <xuyinghua3@huawei.com>, <liheng.liheng@huawei.com>,
 <renxuming@huawei.com>, <pengyi.pengyi@huawei.com>, <yubihong@huawei.com>,
 <zhengchuan@huawei.com>, <huhao33@huawei.com>, <zhangjianguo18@huawei.com>,
 <caozhongwang1@huawei.com>
References: <20230621081826.3203053-1-zhangjianguo18@huawei.com>
 <87wmzwsxmz.fsf@suse.de> <53a69e3b-f9f7-b2c1-9487-f9992ffec2a3@huawei.com>
In-Reply-To: <53a69e3b-f9f7-b2c1-9487-f9992ffec2a3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.187.43]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=chenyuhui5@huawei.com; helo=szxga01-in.huawei.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-to:  "chenyuhui (A)" <chenyuhui5@huawei.com>
From:  "chenyuhui (A)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 2023/6/26 21:16, chenyuhui (A) wrote:
> 
> On 2023/6/21 22:22, Fabiano Rosas wrote:
>> Jianguo Zhang via <qemu-devel@nongnu.org> writes:
>>
>>> From: Yuhui Chen <chenyuhui5@huawei.com>
>>>
>>> There is a coredump while trying to destroy mutex when
>>> p->running is false but p->mutex is not unlock.
>>> Make sure all mutexes has been released before destroy them.
>>>
>>> Signed-off-by: Yuhui Chen <chenyuhui5@huawei.com>
>>> ---
>>>  migration/multifd.c | 6 ++----
>>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/migration/multifd.c b/migration/multifd.c
>>> index b7ad7002e0..7dcdb2d3a0 100644
>>> --- a/migration/multifd.c
>>> +++ b/migration/multifd.c
>>> @@ -523,9 +523,7 @@ void multifd_save_cleanup(void)
>>>      for (i = 0; i < migrate_multifd_channels(); i++) {
>>>          MultiFDSendParams *p = &multifd_send_state->params[i];
>>>  
>>> -        if (p->running) {
>>
>> The need for this flag is dubious IMO. Commit 10351fbad1
>> ("migration/multifd: Join all multifd threads in order to avoid leaks")
>> already moved the other join outside of it. If we figure out another way
>> to deal with the sem_sync lockup we could probably remove this
>> altogether.
> 
> 
> I've seen this commit 10351fbad1, and it's seems to have the same
> problem in function multifd_save_cleanup.
> 
> So that may my patch only need to modify multifd_save_cleanup.
> 
> ______
> 
> 
> On 2023/6/21 21:24, Peter Xu wrote:
>> On Wed, Jun 21, 2023 at 04:18:26PM +0800, Jianguo Zhang via wrote:
>>> From: Yuhui Chen<chenyuhui5@huawei.com>
>>>
>>> There is a coredump while trying to destroy mutex when
>>> p->running is false but p->mutex is not unlock.
>>> Make sure all mutexes has been released before destroy them.
>>
>> It'll be nice to add a backtrace of the coredump here, and also copy
>> maintainer (Juan Quintela, copied now).
>>
> 
> The attachment is coredump, and my code is base on
> https://github.com/qemu/qemu.git tag v6.2.0.
> 


(gdb) bt
#0  0x0000ffffabe3b2b8 in  () at /usr/lib64/libc.so.6
#1  0x0000ffffabdf6d7c in raise () at /usr/lib64/libc.so.6
#2  0x0000ffffabde4d2c in abort () at /usr/lib64/libc.so.6
#3  0x0000aaaac67fcc10 in error_exit (err=<optimized out>, msg=msg@entry=0xaaaac6dc52b8 <__func__.33> "qemu_mutex_destroy") at ../util/qemu-thread-posix.c:38
#4  0x0000aaaac67fce38 in qemu_mutex_destroy (mutex=mutex@entry=0xaaaafa1a4250) at ../util/qemu-thread-posix.c:71
#5  0x0000aaaac6055688 in multifd_save_cleanup () at ../migration/multifd.c:555
#6  0x0000aaaac6050198 in migrate_fd_cleanup (s=s@entry=0xaaaaf7518800) at ../migration/migration.c:1808
#7  0x0000aaaac6050384 in migrate_fd_cleanup_bh (opaque=0xaaaaf7518800) at ../migration/migration.c:1850
#8  0x0000aaaac680d790 in aio_bh_call (bh=0xffffa0004c40) at ../util/async.c:141
#9  aio_bh_poll (ctx=ctx@entry=0xaaaaf73285a0) at ../util/async.c:169
#10 0x0000aaaac67f9e18 in aio_dispatch (ctx=0xaaaaf73285a0) at ../util/aio-posix.c:381
#11 0x0000aaaac680d414 in aio_ctx_dispatch (source=<optimized out>, callback=<optimized out>, user_data=<optimized out>) at ../util/async.c:311
#12 0x0000ffffac44cf88 in g_main_context_dispatch () at /usr/lib64/libglib-2.0.so.0
#13 0x0000aaaac6819214 in glib_pollfds_poll () at ../util/main-loop.c:232
#14 os_host_main_loop_wait (timeout=735000000) at ../util/main-loop.c:255
#15 main_loop_wait (nonblocking=nonblocking@entry=0) at ../util/main-loop.c:531
#16 0x0000aaaac65005cc in qemu_main_loop () at ../softmmu/runstate.c:726
#17 0x0000aaaac5fe2030 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at ../softmmu/main.c:50
(gdb) q


> How reproducible:
> 1、And sleep time to produce p->running is false but p->mutex is
>  not unlock.
> 
> From: Yuhui Chen <chenyuhui5@huawei.com>
> Date: Mon, 26 Jun 2023 14:24:35 +0800
> Subject: [DEBUG][PATCH] And sleep time to produce p->running is false but p->mutex is
>  not unlock.
> 
> ---
>  migration/multifd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 7c9deb1921..09a7b0748a 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -538,6 +538,7 @@ void multifd_save_cleanup(void)
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
> 
> +        sleep(2);
>          if (p->running) {
>              qemu_thread_join(&p->thread);
>          }
> @@ -719,6 +720,7 @@ out:
> 
>      qemu_mutex_lock(&p->mutex);
>      p->running = false;
> +    sleep(20);
>      qemu_mutex_unlock(&p->mutex);
> 
>      rcu_unregister_thread();

