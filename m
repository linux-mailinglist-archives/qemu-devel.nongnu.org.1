Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C33437D4F4D
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 13:58:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvG2D-00018f-BI; Tue, 24 Oct 2023 07:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvG2B-00017r-5k
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 07:57:19 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvG29-0000EP-DS
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 07:57:18 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-53df747cfe5so6850699a12.2
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 04:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698148635; x=1698753435; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SsXMHlGAtAxeW4+tGI+dpMVlYBNx+wrWl91kBjrqtYw=;
 b=lW6VGexNr7bsu27TZc7C02hhjg0AqeIZjvtUdyvCJfwfu3uBpal7wJr6qnvsuchzFF
 vlI+7QOR0kwjYHElVaa/wC7peautDyi5N87DrGl4bbUWLR2/ydY6OBJ70yNtV044zaye
 ws7zhqvZMyg/vSJbQdl+CFMuQEuM418z8PUyPn5oo+aSFwttR1+1V3RVyX0uZ4tm45/X
 9kQ1qStj24Kx+AKOKzVSEJE1i7zPxy8K2AvyVcEl39XbEH3jBlwHIvjCN8sctWQNrWf0
 4zuRUoisyNSt1LOhpNEUItZ616oayylxKIE5c64iupnfzw990U0CfWaLNmJF8DUz3o5t
 mx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698148635; x=1698753435;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SsXMHlGAtAxeW4+tGI+dpMVlYBNx+wrWl91kBjrqtYw=;
 b=AiFYxPXeA/juzumMZQTcKmOrSmdu8x/nhVYJcVUU8u4DssjhJ8jSiUuqN8JpLEMtTU
 FSmgb4iUypowHNM5GdJa3kIXujK7AMR0gGsA26F42OfVTbg+wIkPDFRPvrnbahZt/oe9
 RG9t/spt+s0cPVrxp4pDGgdVB10DjkiWCf724CPiBKf+sSLXKzcjrPa8jhCm73vwqdnd
 IhwwG/0F97jU5YaQYI0jmfD34PQ5aLCsE18MQzVQFi0cA1PvpiqDrzl6BoD3fNmtvnxM
 nJIaeTCX6AtT9AK1ykiTsllkZ04R7MNGlM3kHPyVYc5XZEZDgFTHf4ZXBO+iK+TR/JSV
 wyMQ==
X-Gm-Message-State: AOJu0Yw2tbW0rBxM0/0j7tREz9AUb+OuqRZtstBnNmQBAxKEuBcEAHIW
 5Spjc+b0h0JDa4eF0Y66Uuf1fw==
X-Google-Smtp-Source: AGHT+IHmW2oeIkLBa9FNzzlLRda/Erm+OMgoF96sNZisEpMScVTCJ0oVBaoD6YggQuUQsFGRAap4PA==
X-Received: by 2002:a05:6402:42cb:b0:53f:9d8a:414c with SMTP id
 i11-20020a05640242cb00b0053f9d8a414cmr10350555edc.37.1698148634759; 
 Tue, 24 Oct 2023 04:57:14 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 h12-20020aa7de0c000000b0053e43492ef1sm7676078edv.65.2023.10.24.04.57.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 04:57:14 -0700 (PDT)
Message-ID: <ab6655b0-a6cf-4c19-56d2-e1cb0e6ac72b@linaro.org>
Date: Tue, 24 Oct 2023 13:57:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] hw/ide: reset: cancel async DMA operation before
 resetting state
Content-Language: en-US
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, srowe@mose.org.uk, mike.maslenkin@gmail.com,
 qemu-block@nongnu.org, t.lamprecht@proxmox.com, a.lauterer@proxmox.com,
 kwolf@redhat.com
References: <20230906130922.142845-1-f.ebner@proxmox.com>
 <2ec675fb-0bd9-4f3d-b205-2a7fe5101427@proxmox.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <2ec675fb-0bd9-4f3d-b205-2a7fe5101427@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 24/10/23 12:54, Fiona Ebner wrote:
> Ping

John seems busy, I'll take these 2 patches. Thanks Fiona!

> Am 06.09.23 um 15:09 schrieb Fiona Ebner:
>> If there is a pending DMA operation during ide_bus_reset(), the fact
>> that the IDEState is already reset before the operation is canceled
>> can be problematic. In particular, ide_dma_cb() might be called and
>> then use the reset IDEState which contains the signature after the
>> reset. When used to construct the IO operation this leads to
>> ide_get_sector() returning 0 and nsector being 1. This is particularly
>> bad, because a write command will thus destroy the first sector which
>> often contains a partition table or similar.
>>
>> Traces showing the unsolicited write happening with IDEState
>> 0x5595af6949d0 being used after reset:
>>
>>> ahci_port_write ahci(0x5595af6923f0)[0]: port write [reg:PxSCTL] @ 0x2c: 0x00000300
>>> ahci_reset_port ahci(0x5595af6923f0)[0]: reset port
>>> ide_reset IDEstate 0x5595af6949d0
>>> ide_reset IDEstate 0x5595af694da8
>>> ide_bus_reset_aio aio_cancel
>>> dma_aio_cancel dbs=0x7f64600089a0
>>> dma_blk_cb dbs=0x7f64600089a0 ret=0
>>> dma_complete dbs=0x7f64600089a0 ret=0 cb=0x5595acd40b30
>>> ahci_populate_sglist ahci(0x5595af6923f0)[0]
>>> ahci_dma_prepare_buf ahci(0x5595af6923f0)[0]: prepare buf limit=512 prepared=512
>>> ide_dma_cb IDEState 0x5595af6949d0; sector_num=0 n=1 cmd=DMA WRITE
>>> dma_blk_io dbs=0x7f6420802010 bs=0x5595ae2c6c30 offset=0 to_dev=1
>>> dma_blk_cb dbs=0x7f6420802010 ret=0
>>
>>> (gdb) p *qiov
>>> $11 = {iov = 0x7f647c76d840, niov = 1, {{nalloc = 1, local_iov = {iov_base = 0x0,
>>>        iov_len = 512}}, {__pad = "\001\000\000\000\000\000\000\000\000\000\000",
>>>        size = 512}}}
>>> (gdb) bt
>>> #0  blk_aio_pwritev (blk=0x5595ae2c6c30, offset=0, qiov=0x7f6420802070, flags=0,
>>>      cb=0x5595ace6f0b0 <dma_blk_cb>, opaque=0x7f6420802010)
>>>      at ../block/block-backend.c:1682
>>> #1  0x00005595ace6f185 in dma_blk_cb (opaque=0x7f6420802010, ret=<optimized out>)
>>>      at ../softmmu/dma-helpers.c:179
>>> #2  0x00005595ace6f778 in dma_blk_io (ctx=0x5595ae0609f0,
>>>      sg=sg@entry=0x5595af694d00, offset=offset@entry=0, align=align@entry=512,
>>>      io_func=io_func@entry=0x5595ace6ee30 <dma_blk_write_io_func>,
>>>      io_func_opaque=io_func_opaque@entry=0x5595ae2c6c30,
>>>      cb=0x5595acd40b30 <ide_dma_cb>, opaque=0x5595af6949d0,
>>>      dir=DMA_DIRECTION_TO_DEVICE) at ../softmmu/dma-helpers.c:244
>>> #3  0x00005595ace6f90a in dma_blk_write (blk=0x5595ae2c6c30,
>>>      sg=sg@entry=0x5595af694d00, offset=offset@entry=0, align=align@entry=512,
>>>      cb=cb@entry=0x5595acd40b30 <ide_dma_cb>, opaque=opaque@entry=0x5595af6949d0)
>>>      at ../softmmu/dma-helpers.c:280
>>> #4  0x00005595acd40e18 in ide_dma_cb (opaque=0x5595af6949d0, ret=<optimized out>)
>>>      at ../hw/ide/core.c:953
>>> #5  0x00005595ace6f319 in dma_complete (ret=0, dbs=0x7f64600089a0)
>>>      at ../softmmu/dma-helpers.c:107
>>> #6  dma_blk_cb (opaque=0x7f64600089a0, ret=0) at ../softmmu/dma-helpers.c:127
>>> #7  0x00005595ad12227d in blk_aio_complete (acb=0x7f6460005b10)
>>>      at ../block/block-backend.c:1527
>>> #8  blk_aio_complete (acb=0x7f6460005b10) at ../block/block-backend.c:1524
>>> #9  blk_aio_write_entry (opaque=0x7f6460005b10) at ../block/block-backend.c:1594
>>> #10 0x00005595ad258cfb in coroutine_trampoline (i0=<optimized out>,
>>>      i1=<optimized out>) at ../util/coroutine-ucontext.c:177
>>
>> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


