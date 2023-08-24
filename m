Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9F87873A1
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 17:08:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZBvh-0003cn-66; Thu, 24 Aug 2023 11:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZBvd-0003cI-43
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:07:21 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZBva-0007Ln-4m
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:07:20 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31c63cd4ec2so2465083f8f.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 08:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692889636; x=1693494436;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0upWUabalrf8kGT5aaiBA6D8cgFj+TtSNNomXp84nuE=;
 b=gmitDuM43GM2UI+mkpyGU1MxMiofasOBG5FFQZc/IuYMo63I6RVA+vU3LyBM7POfax
 fzU+TIZeo0n7V7c3J9pxn/jZMOT07eNKoV9RgDPHSAh91OV4V7+kRHtYCdA76HMoxUEZ
 1PKpk9lPu+Y5Ecu5FyckhM6zYFB4wcSE71Ij9OZzlMpiGT3WVY8sXNt+wROlJprfeDjG
 HhkxSsGpYyE3cYDvQC2DmBmS8sp6sSXJFVx2qm7Z9P55T5fcAnC6jdYZFxru9BQu9gLu
 gut4ep66vbuPzogCEf2GX6XHaZl+P2Xhjo4eCzYkKPgK9a3tbZnCnqn/aEDakrGssMdW
 otbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692889636; x=1693494436;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0upWUabalrf8kGT5aaiBA6D8cgFj+TtSNNomXp84nuE=;
 b=mGYSYhcsMVEtMsOaIb2gDqs1hMlhmeeU+2z+NGLAxcZd3/n39EjcFsQDJ8QTc+29SW
 FJ4T3HGdEa1ko2cODEvYm620r0wi/ZkAf2ZyLRuVxe62jXzXC5EFH6rXXzH44YQ7jttw
 OgVLglsXI3KBr2iM0/6U7VEDIVoOygXItZ71XkH6n1PQZ8+SYLbbebXp7QQNsClPDC1W
 iUfZFitIFoYlwD0lAvAeLIrhgjPbwSj4GwqONiLbDx6GEKoBkceUPyu5fm+prbk3gHdb
 BSdosi6rijfwD31wBA6uBgWJf1sBwUJiGYo9vjfUDjGWk6C0ZIrDq9Uwb/b//d26myPa
 BO+w==
X-Gm-Message-State: AOJu0YydU633BzlzyXTQjtES4hNsgoBCen/aJtV4UjHq0k2n+4rblQ7w
 FAj/cz2dTKpFIz+69uHjFL2REw==
X-Google-Smtp-Source: AGHT+IHnE9CQ4uaw+dGsZ29xrEX0L8FBWZVPpRcjVvOL5L63Ecljpz1Sr2KX4eeHKBHXyPKWCAauzw==
X-Received: by 2002:a05:6000:10b:b0:317:727f:3bc7 with SMTP id
 o11-20020a056000010b00b00317727f3bc7mr12540717wrx.17.1692889635709; 
 Thu, 24 Aug 2023 08:07:15 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.238.90])
 by smtp.gmail.com with ESMTPSA id
 h11-20020a5d548b000000b00317e77106dbsm22619267wrv.48.2023.08.24.08.07.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 08:07:15 -0700 (PDT)
Message-ID: <d3b5831a-b02f-396c-d156-4df3e67e4b58@linaro.org>
Date: Thu, 24 Aug 2023 17:07:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] hw/ide: reset: cancel async DMA operation before
 reseting state
Content-Language: en-US
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 srowe@mose.org.uk, mike.maslenkin@gmail.com, qemu-block@nongnu.org,
 t.lamprecht@proxmox.com, a.lauterer@proxmox.com
References: <20230824133831.617833-1-f.ebner@proxmox.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230824133831.617833-1-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.919,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24/8/23 15:38, Fiona Ebner wrote:
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
> ---
>   hw/ide/core.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


