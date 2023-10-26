Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F0D7D7CC8
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 08:17:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvtgR-0006lc-GT; Thu, 26 Oct 2023 02:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qvtgA-0006fW-Kj; Thu, 26 Oct 2023 02:17:16 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qvtg8-00055t-CW; Thu, 26 Oct 2023 02:17:13 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 949EC2D66E;
 Thu, 26 Oct 2023 09:17:44 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4499F31417;
 Thu, 26 Oct 2023 09:17:10 +0300 (MSK)
Message-ID: <004b5574-b27d-4364-895c-36e2da278936@tls.msk.ru>
Date: Thu, 26 Oct 2023 09:17:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hw/ide: reset: cancel async DMA operation before
 resetting state
Content-Language: en-US
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, srowe@mose.org.uk, mike.maslenkin@gmail.com,
 qemu-block@nongnu.org, t.lamprecht@proxmox.com, a.lauterer@proxmox.com,
 philmd@linaro.org, kwolf@redhat.com
References: <20230906130922.142845-1-f.ebner@proxmox.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230906130922.142845-1-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

06.09.2023 16:09, Fiona Ebner wrote:
> If there is a pending DMA operation during ide_bus_reset(), the fact
> that the IDEState is already reset before the operation is canceled
> can be problematic. In particular, ide_dma_cb() might be called and
> then use the reset IDEState which contains the signature after the
> reset. When used to construct the IO operation this leads to
> ide_get_sector() returning 0 and nsector being 1. This is particularly
> bad, because a write command will thus destroy the first sector which
> often contains a partition table or similar.
> 
> Traces showing the unsolicited write happening with IDEState
> 0x5595af6949d0 being used after reset:
> 
>> ahci_port_write ahci(0x5595af6923f0)[0]: port write [reg:PxSCTL] @ 0x2c: 0x00000300
>> ahci_reset_port ahci(0x5595af6923f0)[0]: reset port
>> ide_reset IDEstate 0x5595af6949d0
>> ide_reset IDEstate 0x5595af694da8
>> ide_bus_reset_aio aio_cancel
>> dma_aio_cancel dbs=0x7f64600089a0
>> dma_blk_cb dbs=0x7f64600089a0 ret=0
>> dma_complete dbs=0x7f64600089a0 ret=0 cb=0x5595acd40b30
>> ahci_populate_sglist ahci(0x5595af6923f0)[0]
>> ahci_dma_prepare_buf ahci(0x5595af6923f0)[0]: prepare buf limit=512 prepared=512
>> ide_dma_cb IDEState 0x5595af6949d0; sector_num=0 n=1 cmd=DMA WRITE
>> dma_blk_io dbs=0x7f6420802010 bs=0x5595ae2c6c30 offset=0 to_dev=1
>> dma_blk_cb dbs=0x7f6420802010 ret=0
> 
>> (gdb) p *qiov
>> $11 = {iov = 0x7f647c76d840, niov = 1, {{nalloc = 1, local_iov = {iov_base = 0x0,
>>        iov_len = 512}}, {__pad = "\001\000\000\000\000\000\000\000\000\000\000",
>>        size = 512}}}
>> (gdb) bt
>> #0  blk_aio_pwritev (blk=0x5595ae2c6c30, offset=0, qiov=0x7f6420802070, flags=0,
>>      cb=0x5595ace6f0b0 <dma_blk_cb>, opaque=0x7f6420802010)
>>      at ../block/block-backend.c:1682
>> #1  0x00005595ace6f185 in dma_blk_cb (opaque=0x7f6420802010, ret=<optimized out>)
>>      at ../softmmu/dma-helpers.c:179
>> #2  0x00005595ace6f778 in dma_blk_io (ctx=0x5595ae0609f0,
>>      sg=sg@entry=0x5595af694d00, offset=offset@entry=0, align=align@entry=512,
>>      io_func=io_func@entry=0x5595ace6ee30 <dma_blk_write_io_func>,
>>      io_func_opaque=io_func_opaque@entry=0x5595ae2c6c30,
>>      cb=0x5595acd40b30 <ide_dma_cb>, opaque=0x5595af6949d0,
>>      dir=DMA_DIRECTION_TO_DEVICE) at ../softmmu/dma-helpers.c:244
>> #3  0x00005595ace6f90a in dma_blk_write (blk=0x5595ae2c6c30,
>>      sg=sg@entry=0x5595af694d00, offset=offset@entry=0, align=align@entry=512,
>>      cb=cb@entry=0x5595acd40b30 <ide_dma_cb>, opaque=opaque@entry=0x5595af6949d0)
>>      at ../softmmu/dma-helpers.c:280
>> #4  0x00005595acd40e18 in ide_dma_cb (opaque=0x5595af6949d0, ret=<optimized out>)
>>      at ../hw/ide/core.c:953
>> #5  0x00005595ace6f319 in dma_complete (ret=0, dbs=0x7f64600089a0)
>>      at ../softmmu/dma-helpers.c:107
>> #6  dma_blk_cb (opaque=0x7f64600089a0, ret=0) at ../softmmu/dma-helpers.c:127
>> #7  0x00005595ad12227d in blk_aio_complete (acb=0x7f6460005b10)
>>      at ../block/block-backend.c:1527
>> #8  blk_aio_complete (acb=0x7f6460005b10) at ../block/block-backend.c:1524
>> #9  blk_aio_write_entry (opaque=0x7f6460005b10) at ../block/block-backend.c:1594
>> #10 0x00005595ad258cfb in coroutine_trampoline (i0=<optimized out>,
>>      i1=<optimized out>) at ../util/coroutine-ucontext.c:177
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Ping?  Has this bugfix been lost somehow?

/mjt

