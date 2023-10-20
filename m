Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F310D7D10DE
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 15:54:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtpvb-00010L-7h; Fri, 20 Oct 2023 09:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qtpvY-0000yX-Iu; Fri, 20 Oct 2023 09:52:36 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qtpvW-0003ZD-37; Fri, 20 Oct 2023 09:52:36 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 788724369E;
 Fri, 20 Oct 2023 15:52:23 +0200 (CEST)
Message-ID: <e13b488e-bf13-44f2-acca-e724d14f43fd@proxmox.com>
Date: Fri, 20 Oct 2023 15:52:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: deadlock when using iothread during backup_clean()
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers
 <qemu-devel@nongnu.org>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <bcbd48da-e4cc-f9c9-000c-6a9f98ca156f@proxmox.com>
 <dd12f39d-a364-b186-2ad7-04343ea85e3f@redhat.com>
 <44ff810b-8ec6-0f11-420a-6efa2c7c2475@proxmox.com>
 <2ca4eb06-75c3-7bd8-972b-b37af47743dc@yandex-team.ru>
 <71e3112d-3d3f-fd55-4099-6765d4f22205@proxmox.com>
 <76f9678d-ed92-418e-8d1e-c6dc55f83279@proxmox.com>
 <ZS56FzuqZSApXBbc@redhat.com>
 <c2a6c1b6-0438-488f-bba3-1014ffdadbce@proxmox.com>
 <ZS6YFtYKyFLbfrrP@redhat.com>
 <3e1c941b-2b76-4f85-88cb-4a2a968eb3e6@proxmox.com>
 <ZTEdk5gKXlIrKNm8@redhat.com>
 <b8007a25-10e1-483c-81c4-9d7dc3c67ed9@proxmox.com>
In-Reply-To: <b8007a25-10e1-483c-81c4-9d7dc3c67ed9@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Am 19.10.23 um 15:53 schrieb Fiona Ebner:
> Am 19.10.23 um 14:14 schrieb Kevin Wolf:
>> Am 18.10.2023 um 11:42 hat Fiona Ebner geschrieben:
>>> Am 17.10.23 um 16:20 schrieb Kevin Wolf:
>>>> Am 17.10.2023 um 15:37 hat Fiona Ebner geschrieben:
>>>>> Am 17.10.23 um 14:12 schrieb Kevin Wolf:
>>>>>> Am 17.10.2023 um 12:18 hat Fiona Ebner geschrieben:
>>>>>>> I ran into similar issues now with mirror, (both deadlocks and stuck
>>>>>>> guest IO at other times), and interestingly, also during job start.
>>>>>>>
>>>>>>> Also had a backtrace similar to [0] once, so I took a closer look.
>>>>>>> Probably was obvious to others already, but for the record:
>>>>>>>
>>>>>>> 1. the graph is locked by the main thread
>>>>>>> 2. the iothread holds the AioContext lock
>>>>>>> 3. the main thread waits on the AioContext lock
>>>>>>> 4. the iothread waits for coroutine spawned by blk_is_available()
>>>>>>
>>>>>> Where does this blk_is_available() in the iothread come from? Having it
>>>>>> wait without dropping the AioContext lock sounds like something that
>>>>>> we'd want to avoid. Ideally, devices using iothreads shouldn't use
>>>>>> synchronous requests at all, but I think scsi-disk might have some of
>>>>>> them.
>>>>>>
>>>>>
>>>>> It's part of the request handling in virtio-scsi:
>>>>>
>>>>>> #0  0x00007ff7f5f55136 in __ppoll (fds=0x7ff7e40030c0, nfds=8, timeout=<optimized out>, sigmask=0x0) at ../sysdeps/unix/sysv/linux/ppoll.c:42
>>>>>> #1  0x00005587132615ab in qemu_poll_ns (fds=0x7ff7e40030c0, nfds=8, timeout=-1) at ../util/qemu-timer.c:339
>>>>>> #2  0x000055871323e8b1 in fdmon_poll_wait (ctx=0x55871598d5e0, ready_list=0x7ff7f288ebe0, timeout=-1) at ../util/fdmon-poll.c:79
>>>>>> #3  0x000055871323e1ed in aio_poll (ctx=0x55871598d5e0, blocking=true) at ../util/aio-posix.c:670
>>>>>> #4  0x0000558713089efa in bdrv_poll_co (s=0x7ff7f288ec90) at /home/febner/repos/qemu/block/block-gen.h:43
>>>>>> #5  0x000055871308c362 in blk_is_available (blk=0x55871599e2f0) at block/block-gen.c:1426
>>>>>> #6  0x0000558712f6843b in virtio_scsi_ctx_check (s=0x558716c049c0, d=0x55871581cd30) at ../hw/scsi/virtio-scsi.c:290
>>>>
>>>> Oh... So essentially for an assertion.
>>>>
>>>> I wonder if the blk_is_available() check introduced in 2a2d69f490c is
>>>> even necessary any more, because BlockBackend has its own AioContext
>>>> now. And if blk_bs(blk) != NULL isn't what we actually want to check if
>>>> the check is necessary, because calling bdrv_is_inserted() doesn't seem
>>>> to have been intended. blk_bs() wouldn't have to poll.
>>>>
>>>
>>> Could virtio_scsi_hotunplug() be an issue with removing or modifying
>>> the check? There's a call there which sets the blk's AioContext to
>>> qemu_get_aio_context(). Or are we sure that the assert in
>>> virtio_scsi_ctx_check() can't be reached after that?
>>
>> I think that would be the kind of bug that the assertion tries to
>> catch, because then we would be sending requests to blk from a thread
>> that doesn't match its AioContext (which will be allowed soon, but not
>> quite yet).
>>
>> Before resetting the AioContext, virtio_scsi_hotunplug() calls
>> qdev_simple_device_unplug_cb(), which unrealizes the SCSI device. This
>> calls scsi_qdev_unrealize() -> scsi_device_purge_requests(), which in
>> turn drains blk and cancels all pending requests. So there should be
>> nothing left that could call into virtio_scsi_ctx_check() any more.
>>
>> The other argument is that after unrealize, virtio_scsi_device_get()
>> would return NULL anyway, so even if a request were still pending, it
>> would just fail instead of accessing the unplugged device.
>>
> 
> Okay, sounds like a way to get around that deadlock issue then :)
> 

Unfortunately, scsi_dma_command() also has a blk_is_available() call and
I ran into a similar deadlock with that once.

> (...)
> 
>>>>
>>>> What does the stuck I/O look like? Is it stuck in the backend, i.e. the
>>>> device started requests that never complete? Or stuck from the guest
>>>> perspective, i.e. the device never checks for new requests?
>>>>
>>>
>>> AFAICT, from the guest perspective.
>>>
>>>> I don't really have an idea immediately, we'd have to find out where the
>>>> stuck I/O stops being processed.
>>>>
>>>
>>> I've described it in an earlier mail in this thread:
>>> https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg01900.html
>>>
>>> Quoting from there:
>>>
>>>> After the IO was stuck in the guest, I used bdrv_next_all_states() to
>>>> iterate over the states and there's only the bdrv_raw and the
>>>> bdrv_host_device. For both, tracked_requests was empty.
>>
>> And bs->in_flight and blk->in_flight are 0, too?
>>
> 
> Yes. And queued_requests in the BlockBackend is also empty.
> 
>> Is anything quiesced?
> 
> No. quiesce_counter is 0 for both BlockDriverState instances as well as
> for the BlockBackend. quiesced_parent is false for both parents (i.e.
> child_root for the bdrv_raw and child_of_bds for the bdrv_file (this
> time I used VirtIO SCSI, in the quote it was VirtIO block)).
> 
>>>> What is also very interesting is that the IO isn't always dead
>>>> immediately. It can be that the fio command still runs with lower speed
>>>> for a while (sometimes even up to about a minute, but most often about
>>>> 10-15 seconds or so). During that time, I still can see calls to
>>>> virtio_scsi_handle_cmd() and blk_aio_write_entry(). Then they suddenly stop.
>>>
>>> Noting again that (at least for backup) it happens with both virtio-blk
>>> and virtio-scsi and with both aio=io_uring and aio=threads. I also tried
>>> different host kernels 5.15, 6.2 and 6.5 and guest kernels 5.10 and 6.1.
>>
>> You say "at least for backup". Did you see the bug for other job types,
>> too?
>>
> 
> Yes, sorry. I meant to say that I only tested it for the backup
> canceling with all those configurations. I did run into the stuck guest
> IO issue in three different scenarios: canceling backup, canceling
> mirror and starting mirror:
> 
>>>>>> Am 17.10.2023 um 12:18 hat Fiona Ebner geschrieben:
>>>>>>> I ran into similar issues now with mirror, (both deadlocks and stuck
>>>>>>> guest IO at other times), and interestingly, also during job start.
> 
> But for mirror, I only used VirtIO SCSI and aio=io_uring and didn't test
> other configurations.
> 

I should also mention that I used drive-mirror and drive-backup. I can
also trigger the issue with blockdev-mirror when canceling, but didn't
run into it when starting with blockdev-mirror yet.

And I found that with drive-mirror, the issue during starting seems to
manifest with the bdrv_open() call. Adding a return before it, the guest
IO didn't get stuck in my testing, but adding a return after it, it can
get stuck. I'll try to see if I can further narrow it down next week,
but maybe that's already a useful hint?

> diff --git a/blockdev.c b/blockdev.c
> index a01c62596b..156915d15d 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3126,6 +3126,8 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
>      }
>      aio_context_release(aio_context);
>  
> +    // return; // GOOD
> +
>      /* Mirroring takes care of copy-on-write using the source's backing
>       * file.
>       */
> @@ -3133,6 +3135,8 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
>      target_bs = bdrv_open(arg->target, NULL, options, flags, errp);
>      aio_context_release(qemu_get_aio_context());
>  
> +    // return; // BAD
> +
>      if (!target_bs) {
>          return;
>      }


Best Regards,
Fiona



