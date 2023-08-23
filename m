Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 920767852FF
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 10:48:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYjWi-0000f9-Hd; Wed, 23 Aug 2023 04:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qYjWg-0000eb-IT; Wed, 23 Aug 2023 04:47:42 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qYjWe-0006mR-JK; Wed, 23 Aug 2023 04:47:42 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 8BA5C437C9;
 Wed, 23 Aug 2023 10:47:30 +0200 (CEST)
Message-ID: <1f581666-cfe0-cb7e-bbb5-6097e03c76e2@proxmox.com>
Date: Wed, 23 Aug 2023 10:47:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: Lost partition tables on ide-hd + ahci drive
To: Mike Maslenkin <mike.maslenkin@gmail.com>
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Thomas Lamprecht <t.lamprecht@proxmox.com>,
 Aaron Lauterer <a.lauterer@proxmox.com>, simon.rowe@nutanix.com
References: <ad7e1294-f19f-5bea-e891-f6adbe323cd5@proxmox.com>
 <CAFn=p-ahLoVd3W2GaFp5EUFq5EOudz+bUkEk5DV+Z07AjHaHtg@mail.gmail.com>
 <d07bdbc1-065e-f8ec-2a44-ab141ffedd41@proxmox.com>
 <CAL77WPAdDyKFWP_Dqsz_xr7OCzHLTkw6VbYDMGobi8kek4e_8A@mail.gmail.com>
 <85488658-80df-f6ac-8a1d-51172148a436@proxmox.com>
 <CAL77WPDJaRBgCeBtVx6tZ6yxKTG6Z2SEk_oif4RCSSnUgOuURA@mail.gmail.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <CAL77WPDJaRBgCeBtVx6tZ6yxKTG6Z2SEk_oif4RCSSnUgOuURA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.767,
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

Am 17.02.23 um 22:22 schrieb Mike Maslenkin:
> I can not tell anything about dma-reentracy issues, but yes, i would
> start to look at check_cmd() function call sequence.
> The most interesting is why Sector Count = 1. I thought about race
> with IDE reset where registers initialized with
> value SATA_SIGNATURE_DISK = 0x00000101, but this means LBA=1 as well...
> 

You got it! Since we got another report (after half a year of nothing)
and also because of Simon's mail, I gave it another shot too and was
finally able to reproduce the issue (with our patched QEMU 8.0, but
patches shouldn't affect IDE code). See below for the traces that
confirm your theory. The reason the write goes to sector 0 and not 1 is
because ide_dma_cb() uses sector_num = ide_get_sector(s); and that will
evaluate to 0 after a reset.

So the issue is indeed that ide_dma_cb can get called with an IDEState
just after that state was reset. Can we somehow wait for pending
requests before proceeding with the reset, or can we force an error
return for callbacks that are still pending during reset?

Best Regards,
Fiona

QEMU trace log (-trace dma_*,file=/root/sata.log -trace
ide_*,file=/root/sata.log -trace ahci_*,file=/root/sata.log -trace
*ncq*,file=/root/sata.log -trace handle_cmd*,file=/root/sata.log)

> ahci_port_write ahci(0x5595af6923f0)[0]: port write [reg:PxSCTL] @ 0x2c: 0x00000300
> ahci_reset_port ahci(0x5595af6923f0)[0]: reset port
> ide_reset IDEstate 0x5595af6949d0
> ide_reset IDEstate 0x5595af694da8
> ide_bus_reset_aio aio_cancel
> dma_aio_cancel dbs=0x7f64600089a0
> dma_blk_cb dbs=0x7f64600089a0 ret=0
> dma_complete dbs=0x7f64600089a0 ret=0 cb=0x5595acd40b30
> ahci_populate_sglist ahci(0x5595af6923f0)[0]
> ahci_dma_prepare_buf ahci(0x5595af6923f0)[0]: prepare buf limit=512 prepared=512
> ide_dma_cb IDEState 0x5595af6949d0; sector_num=0 n=1 cmd=DMA WRITE
> dma_blk_io dbs=0x7f6420802010 bs=0x5595ae2c6c30 offset=0 to_dev=1
> dma_blk_cb dbs=0x7f6420802010 ret=0

Info from GDB:

> (gdb) p *qiov
> 
> $11 = {iov = 0x7f647c76d840, niov = 1, {{nalloc = 1, local_iov = {iov_base = 0x0, 
>         iov_len = 512}}, {__pad = "\001\000\000\000\000\000\000\000\000\000\000", 
>       size = 512}}}
> (gdb) bt
> 
> #0  blk_aio_pwritev (blk=0x5595ae2c6c30, offset=0, qiov=0x7f6420802070, flags=0, 
>     cb=0x5595ace6f0b0 <dma_blk_cb>, opaque=0x7f6420802010)
>     at ../block/block-backend.c:1682
> #1  0x00005595ace6f185 in dma_blk_cb (opaque=0x7f6420802010, ret=<optimized out>)
>     at ../softmmu/dma-helpers.c:179
> #2  0x00005595ace6f778 in dma_blk_io (ctx=0x5595ae0609f0, 
>     sg=sg@entry=0x5595af694d00, offset=offset@entry=0, align=align@entry=512, 
>     io_func=io_func@entry=0x5595ace6ee30 <dma_blk_write_io_func>, 
>     io_func_opaque=io_func_opaque@entry=0x5595ae2c6c30, 
>     cb=0x5595acd40b30 <ide_dma_cb>, opaque=0x5595af6949d0, 
>     dir=DMA_DIRECTION_TO_DEVICE) at ../softmmu/dma-helpers.c:244
> #3  0x00005595ace6f90a in dma_blk_write (blk=0x5595ae2c6c30, 
>     sg=sg@entry=0x5595af694d00, offset=offset@entry=0, align=align@entry=512, 
>     cb=cb@entry=0x5595acd40b30 <ide_dma_cb>, opaque=opaque@entry=0x5595af6949d0)
>     at ../softmmu/dma-helpers.c:280
> #4  0x00005595acd40e18 in ide_dma_cb (opaque=0x5595af6949d0, ret=<optimized out>)
>     at ../hw/ide/core.c:953
> #5  0x00005595ace6f319 in dma_complete (ret=0, dbs=0x7f64600089a0)
>     at ../softmmu/dma-helpers.c:107
> #6  dma_blk_cb (opaque=0x7f64600089a0, ret=0) at ../softmmu/dma-helpers.c:127
> #7  0x00005595ad12227d in blk_aio_complete (acb=0x7f6460005b10)
>     at ../block/block-backend.c:1527
> #8  blk_aio_complete (acb=0x7f6460005b10) at ../block/block-backend.c:1524
> #9  blk_aio_write_entry (opaque=0x7f6460005b10) at ../block/block-backend.c:1594
> #10 0x00005595ad258cfb in coroutine_trampoline (i0=<optimized out>, 
>     i1=<optimized out>) at ../util/coroutine-ucontext.c:177
> #11 0x00007f64f2fcb8d0 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
> #12 0x00007f64d0ff3290 in ?? ()
> #13 0x0000000000000000 in ?? ()

This is of course not directly after the reset, since the break happened
a bit later:

> (gdb) p *((IDEState*)0x5595af6949d0)
> 
> $12 = {bus = 0x5595af694948, unit = 0 '\000', drive_kind = IDE_HD, 
>   drive_heads = 16, drive_sectors = 63, cylinders = 8740, heads = 16, 
>   sectors = 63, chs_trans = 2, nb_sectors = 8810496, mult_sectors = 16, 
>   identify_set = 1, 
>   identify_data = "@\000$\"\000\000\020\000\000~\000\002?\000\000\000\000\000\000\000MQ0000 5", ' ' <repeats 12 times>, "\003\000\000\002\004\000.2+5    EQUMH RADDSI K", ' ' <repeats 26 times>, "\020\200\001\000\000\v\000\000\000\002\000\002\a\000$\"\020\000?\000\300m\206\000\020\001\000p\206\000\a\000\a\000\003\000x\000x\000x\000x\000\000@\000\000\000\000\000\000\000\000\000\000\037\000\000\001\000\000\000\000\000\000\360\000\026\000!@\000t\000@!@\0004\000@?\020\000\000\000\000\000\000\000\000\001`", '\000' <repeats 13 times>..., drive_serial = 5, 
>   drive_serial_str = "QM00005", '\000' <repeats 13 times>, 
>   drive_model_str = "QEMU HARDDISK", '\000' <repeats 27 times>, wwn = 0, 
>   feature = 0 '\000', error = 0 '\000', nsector = 1, sector = 1 '\001', 
>   lcyl = 0 '\000', hcyl = 0 '\000', hob_feature = 0 '\000', 
>   hob_nsector = 0 '\000', hob_sector = 0 '\000', hob_lcyl = 0 '\000', 
>   hob_hcyl = 0 '\000', select = 160 '\240', status = 80 'P', io8 = false, 
>   reset_reverts = false, lba48 = 0 '\000', blk = 0x5595ae2c6c30, 
>   version = "2.5+\000\000\000\000", events = {eject_request = false, 
>     new_media = false}, sense_key = 0 '\000', asc = 0 '\000', tray_open = false, 
>   tray_locked = false, cdrom_changed = 0 '\000', packet_transfer_size = 0, 
>   elementary_transfer_size = 0, io_buffer_index = 0, lba = 0, cd_sector_size = 0, 
>   atapi_dma = 0, acct = {bytes = 131072, start_time_ns = 89102481675200, 
>     type = BLOCK_ACCT_WRITE}, pio_aiocb = 0x0, qiov = {iov = 0x0, niov = 0, {{
>         nalloc = 0, local_iov = {iov_base = 0x0, iov_len = 0}}, {
>         __pad = '\000' <repeats 11 times>, size = 0}}}, buffered_requests = {
>     lh_first = 0x0}, io_buffer_offset = 0, io_buffer_size = 512, sg = {
>     sg = 0x7f647c76d390, nsg = 1, nalloc = 2, size = 512, dev = 0x5595af6919c0, 
>     as = 0x5595af691c00}, req_nb_sectors = 0, 
>   end_transfer_func = 0x5595acd3cb90 <ide_dummy_transfer_stop>, 
>   data_ptr = 0x5595af69e800 "\377\377\377\377", 
>   data_end = 0x5595af69e800 "\377\377\377\377", 
>   io_buffer = 0x5595af69e800 "\377\377\377\377", io_buffer_total_len = 131076, 
>   cur_io_buffer_offset = 0, cur_io_buffer_len = 0, 
>   end_transfer_fn_idx = 0 '\000', sector_write_timer = 0x5595af69db20, 
>   irq_count = 0, ext_error = 0 '\000', mdata_size = 0, mdata_storage = 0x0, 
>   media_changed = 0, dma_cmd = IDE_DMA_WRITE, smart_enabled = 1 '\001', 
>   smart_autosave = 1 '\001', smart_errors = 0, smart_selftest_count = 0 '\000', 
>   smart_selftest_data = 0x5595af6bf000 "", ncq_queues = 32}


