Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4517F83040F
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 12:00:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ3e9-00019Q-4i; Wed, 17 Jan 2024 05:59:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rQ3e6-00018t-Bc; Wed, 17 Jan 2024 05:59:46 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rQ3e4-0007MF-6f; Wed, 17 Jan 2024 05:59:46 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 48CD649163;
 Wed, 17 Jan 2024 11:59:41 +0100 (CET)
Message-ID: <1066014c-7cea-4797-b862-60cc3b663c22@proxmox.com>
Date: Wed, 17 Jan 2024 11:59:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/clipboard: avoid crash upon request when clipboard
 peer is not initialized
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, m.frank@proxmox.com,
 berrange@redhat.com, mcascell@redhat.com, qemu-stable@nongnu.org
References: <20240112135527.57212-1-f.ebner@proxmox.com>
 <CAJ+F1C+JXE9hSQ_oDNZvhpYDqPeeKayopB3x2L2YyJTxM8t+Yg@mail.gmail.com>
 <2150aa28-3eba-4e95-a301-d87377ba40a4@proxmox.com>
 <CAJ+F1CKQkXUiuQH+mNC7p00wWrznsgWJD4xjR-AzjJGPnsF8gw@mail.gmail.com>
 <ccd23263-f19f-401e-b476-a7eb1fd22571@proxmox.com>
 <CAJ+F1CJHKsRrxUcUijAVV2bv0EOtbz0BAmH1OEnmciwo7ACXLQ@mail.gmail.com>
 <0c2d35cb-cacf-4a81-9b6a-f07fdea9fc07@proxmox.com>
 <CAJ+F1CJ4F6Kv9Vx_4H+GJ0ME0Q0X4GTm2n6L1JGg-SWFgi18SA@mail.gmail.com>
 <960d7ef2-9e73-4987-98ca-529118325909@proxmox.com>
In-Reply-To: <960d7ef2-9e73-4987-98ca-529118325909@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 16.01.24 um 13:11 schrieb Fiona Ebner:
> Am 15.01.24 um 13:00 schrieb Marc-André Lureau:
>>>>>
>>>>
>>>> The trouble is when qemu_clipboard_update() is called without data &
>>>> without a request callback set. We shouldn't allow that as we have no
>>>> means to get the clipboard data then.
>>>>
>>>
>>> In the above scenario, I'm pretty sure there is data when
>>> qemu_clipboard_update() is called. Just no request callback. If we'd
>>> reject this, won't that break clients that do not set the
>>> VNC_FEATURE_CLIPBOARD_EXT feature and only use non-extended
>>> VNC_MSG_CLIENT_CUT_TEXT messages?
>>
>> If "data" is already set, then qemu_clipboard_request() returns.
>>
>> Inverting the condition I suggested above: it's allowed to be the
>> clipboard owner if either "data" is set, or a request callback is set.
>>
> 
> Oh, sorry. Yes, it seems the problematic case is where data is not set.
> But isn't that legitimate when clearing the clipboard? Or is a
> VNC_MSG_CLIENT_CUT_TEXT message not valid when len is 0 and should be
> rejected? In my testing KRDC does send such a message when the clipboard
> is cleared:
> 
>> #1  0x0000558f1e6a0dac in vnc_client_cut_text (vs=0x558f207754d0, len=0, 
>>     text=0x558f2046e008 "\003 \002\377\005") at ../ui/vnc-clipboard.c:313
>> #2  0x0000558f1e68e067 in protocol_client_msg (vs=0x558f207754d0, 
>>     data=0x558f2046e000 "\006", len=8) at ../ui/vnc.c:2454
> 
> Your suggestion would disallow this for clients that do not set the
> VNC_FEATURE_CLIPBOARD_EXT feature (and only use non-extended
> VNC_MSG_CLIENT_CUT_TEXT messages).
> 

I noticed that there is yet another code path leading to
qemu_clipboard_request() and dereferencing the NULL owner->request even
if only non-extended VNC_MSG_CLIENT_CUT_TEXT messages are used:

> Thread 1 "qemu-system-x86" hit Breakpoint 1, vnc_client_cut_text (
>     vs=0x5555593e6c00, len=0, 
>     text=0x5555575ea608 "404078,bus=ahci0.0,drive=drive-sata0,id=sata0,bootindex=100\377\001") at ../ui/vnc-clipboard.c:310
> (gdb) c
> Continuing.

And later:

> qemu_clipboard_request (info=0x555557e576e0, type=QEMU_CLIPBOARD_TYPE_TEXT) at ../ui/clipboard.c:129
> 129	    if (info->types[type].data ||
> (gdb) p *info->owner
> $65 = {name = 0x0, notifier = {notify = 0x0, node = {le_next = 0x0, le_prev = 0x0}}, request = 0x0}
> (gdb) bt
> #0  qemu_clipboard_request (info=0x555557e576e0, type=QEMU_CLIPBOARD_TYPE_TEXT) at ../ui/clipboard.c:129
> #1  0x00005555558952ce in vdagent_chr_recv_chunk (vd=0x555556f67800) at ../ui/vdagent.c:769
> #2  vdagent_chr_write (chr=<optimized out>, buf=0x7fff4ab263e4 "", len=0) at ../ui/vdagent.c:840
> #3  0x0000555555d98830 in qemu_chr_write_buffer (s=s@entry=0x555556f67800, buf=buf@entry=0x7fff4ab263c0 "\001", len=36, 
>     offset=offset@entry=0x7fffffffd030, write_all=false) at ../chardev/char.c:122
> #4  0x0000555555d98c3c in qemu_chr_write (s=0x555556f67800, buf=buf@entry=0x7fff4ab263c0 "\001", len=len@entry=36, 
>     write_all=<optimized out>, write_all@entry=false) at ../chardev/char.c:186
> #5  0x0000555555d9109f in qemu_chr_fe_write (be=be@entry=0x555556e59040, buf=buf@entry=0x7fff4ab263c0 "\001", len=len@entry=36)
>     at ../chardev/char-fe.c:42
> #6  0x0000555555900045 in flush_buf (port=0x555556e58f40, buf=0x7fff4ab263c0 "\001", len=36) at ../hw/char/virtio-console.c:63
> #7  0x0000555555bea4f3 in do_flush_queued_data (port=0x555556e58f40, vq=0x555559272558, vdev=0x55555926a4d0)
>     at ../hw/char/virtio-serial-bus.c:188
> #8  0x0000555555c201ff in virtio_queue_notify_vq (vq=0x555559272558) at ../hw/virtio/virtio.c:2268
> #9  0x0000555555e36dd5 in aio_dispatch_handler (ctx=ctx@entry=0x555556e51b10, node=0x7ffed812b9f0) at ../util/aio-posix.c:372
> #10 0x0000555555e37662 in aio_dispatch_handlers (ctx=0x555556e51b10) at ../util/aio-posix.c:414
> #11 aio_dispatch (ctx=0x555556e51b10) at ../util/aio-posix.c:424
> #12 0x0000555555e4d44e in aio_ctx_dispatch (source=<optimized out>, callback=<optimized out>, user_data=<optimized out>)
>     at ../util/async.c:358
> #13 0x00007ffff753e7a9 in g_main_context_dispatch () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
> #14 0x0000555555e4ecb8 in glib_pollfds_poll () at ../util/main-loop.c:287
> #15 os_host_main_loop_wait (timeout=58675786) at ../util/main-loop.c:310
> #16 main_loop_wait (nonblocking=nonblocking@entry=0) at ../util/main-loop.c:589
> #17 0x0000555555aa5f63 in qemu_main_loop () at ../system/runstate.c:791
> #18 0x0000555555cadc16 in qemu_default_main () at ../system/main.c:37
> #19 0x00007ffff60801ca in __libc_start_call_main (main=main@entry=0x5555558819d0 <main>, argc=argc@entry=102, 
>     argv=argv@entry=0x7fffffffd458) at ../sysdeps/nptl/libc_start_call_main.h:58
> #20 0x00007ffff6080285 in __libc_start_main_impl (main=0x5555558819d0 <main>, argc=102, argv=0x7fffffffd458, init=<optimized out>, 
>     fini=<optimized out>, rtld_fini=<optimized out>, stack_end=0x7fffffffd448) at ../csu/libc-start.c:360
> #21 0x0000555555883581 in _start ()

So such non-extended VNC_MSG_CLIENT_CUT_TEXT messages with len=0 are
already problematic. Is clearing the clipboard supposed to be done
differently?

Your suggestion would prevent this scenario too. I'll send a patch with
that shortly.

Best Regards,
Fiona


