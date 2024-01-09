Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DFE82887B
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 15:49:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNDPK-0005j8-K7; Tue, 09 Jan 2024 09:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNDPG-0005iS-4S
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 09:48:42 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNDPC-0002Hf-6m
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 09:48:40 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6dc83674972so1956701a34.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 06:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704811716; x=1705416516; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=59haa1XrCpIvqVg9dmyrL+jXbkuY60EG0hzZUjlEwDc=;
 b=yKFnE9PsxrBwxP56XtLp5j9A9ngKqIApKajzAR1tUplTJ6rwA0EYcA2sKouqwqez58
 0Wl1hDWTkt3nrUQtpMP4lcMzeOxqUbBPXdbtWIE/pvOz2yrVUOb8MTJeY5zhnl4jtD2K
 NT3nWgFm6I84VrN1P8zp6UePYFoynCfxXzBk/fnHiAYcNxj7A11aFuluLleQgHmDBmoc
 Qv/mTeOxrmtOtxwKSATQBgbb19P0ZoiP3lZijBE0IiA0K5qEqXK9vPm7+A1MqKba2lsf
 cBszPLbrO6HiWR8gnYcqr5rKCPqi5bF2WCGbqcGCqUjo/lFsjl90gIDqE0KwfKLrU5qq
 UKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704811716; x=1705416516;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=59haa1XrCpIvqVg9dmyrL+jXbkuY60EG0hzZUjlEwDc=;
 b=a7fQiWrX+xwb/DxAZg+YP59nC+7hXAe3BT5anlUknCY4biLE4XK1Myb1TlfU2c5Jp0
 INlWWiu+jGz8mpCykZt+FS+ousWIp8lmCayQQYcMwC5IRTqwuwEy1Jqx1gF/4EI19sBG
 y77vZn6SL4NCB3CkEqh53lcrumxe3ZEbzoaCIZl4NMm+mTTM6wu4QfpjYd7xOZSud64i
 YZhQAbIobdTWBxByry+O6cfosr0ApfCmPCw3z8DdxOPDOevH0eNripsbiFpY28UYOTn7
 VSUkKoNLdO5/wO97bdxHdDIwTMz9hI1YMSorcSGE1M9aK4z6DQ4vUNVhgWWeZgbaTr6v
 FGkQ==
X-Gm-Message-State: AOJu0YxVLwmL5/Gg8GsrMpFTw9PhSD6jZ9J+sztd8LV8o7SWF13uAvfg
 6CUkYPTCjpXO+suTAxyzSzSF1fcKLqT27Pl8y3YHc6Ur9oBixQ==
X-Google-Smtp-Source: AGHT+IE0TxqzRYmzSiyKbz1iOJCxRKwj6t9BT2X7gvofr7EuRgrSb5ofMQ4wmHxoXOU2TxLtYRK0VA==
X-Received: by 2002:a05:6830:44a8:b0:6dc:41c:9bc6 with SMTP id
 r40-20020a05683044a800b006dc041c9bc6mr4906411otv.36.1704811715649; 
 Tue, 09 Jan 2024 06:48:35 -0800 (PST)
Received: from [192.168.69.100] (rsa59-h02-176-184-32-47.dsl.sta.abo.bbox.fr.
 [176.184.32.47]) by smtp.gmail.com with ESMTPSA id
 o22-20020a9d5c16000000b006dc0802ddf5sm381666otk.5.2024.01.09.06.48.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 06:48:35 -0800 (PST)
Message-ID: <ddd95c11-35d1-4acd-ba62-e03c9a66fac3@linaro.org>
Date: Tue, 9 Jan 2024 15:48:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-9.0] hw/display/qxl: Directly use
 VGACommonState::vram_size
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20231124192216.96413-1-philmd@linaro.org>
 <eeba727d-c0a5-4973-af96-460fe16efbf6@linaro.org>
In-Reply-To: <eeba727d-c0a5-4973-af96-460fe16efbf6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-ot1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

+Marc-André

On 4/1/24 17:45, Philippe Mathieu-Daudé wrote:
> +Paolo
> 
> On 24/11/23 20:22, Philippe Mathieu-Daudé wrote:
>> PCIQXLDevice::vram_size seems to be some shadow of
>> VGACommonState::vram_size. Just use the latter.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> RFC: I don't understand this field otherwise.
>> ---
>>   hw/display/qxl.h |  1 -
>>   hw/display/qxl.c | 17 ++++++++---------
>>   2 files changed, 8 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/display/qxl.h b/hw/display/qxl.h
>> index fdac14edad..47463bd485 100644
>> --- a/hw/display/qxl.h
>> +++ b/hw/display/qxl.h
>> @@ -102,7 +102,6 @@ struct PCIQXLDevice {
>>       uint16_t           max_outputs;
>>       /* vram pci bar */
>> -    uint64_t           vram_size;
>>       MemoryRegion       vram_bar;
>>       uint64_t           vram32_size;
>>       MemoryRegion       vram32_bar;
>> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
>> index 7bb00d68f5..0e1c4efc0c 100644
>> --- a/hw/display/qxl.c
>> +++ b/hw/display/qxl.c
>> @@ -2067,20 +2067,19 @@ static void qxl_init_ramsize(PCIQXLDevice *qxl)
>>       /* vram (surfaces, 64bit, bar 4+5) */
>>       if (qxl->vram_size_mb != -1) {
>> -        qxl->vram_size = (uint64_t)qxl->vram_size_mb * MiB;
>> +        qxl->vga.vram_size = (uint64_t)qxl->vram_size_mb * MiB;
>>       }
>> -    if (qxl->vram_size < qxl->vram32_size) {
>> -        qxl->vram_size = qxl->vram32_size;
>> +    if (qxl->vga.vram_size < qxl->vram32_size) {
>> +        qxl->vga.vram_size = qxl->vram32_size;
>>       }
>>       if (qxl->revision == 1) {
>>           qxl->vram32_size = 4096;
>> -        qxl->vram_size = 4096;
>> +        qxl->vga.vram_size = 4096;
>>       }
>>       qxl->vgamem_size = pow2ceil(qxl->vgamem_size);
>>       qxl->vga.vram_size = pow2ceil(qxl->vga.vram_size);
>>       qxl->vram32_size = pow2ceil(qxl->vram32_size);
>> -    qxl->vram_size = pow2ceil(qxl->vram_size);
>>   }
>>   static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
>> @@ -2135,7 +2134,7 @@ static void qxl_realize_common(PCIQXLDevice 
>> *qxl, Error **errp)
>>       qxl->guest_surfaces.cmds = g_new0(QXLPHYSICAL, 
>> qxl->ssd.num_surfaces);
>>       memory_region_init_ram(&qxl->vram_bar, OBJECT(qxl), "qxl.vram",
>> -                           qxl->vram_size, &error_fatal);
>> +                           qxl->vga.vram_size, &error_fatal);
>>       memory_region_init_alias(&qxl->vram32_bar, OBJECT(qxl), 
>> "qxl.vram32",
>>                                &qxl->vram_bar, 0, qxl->vram32_size);
>> @@ -2159,7 +2158,7 @@ static void qxl_realize_common(PCIQXLDevice 
>> *qxl, Error **errp)
>>       pci_register_bar(&qxl->pci, QXL_VRAM_RANGE_INDEX,
>>                        PCI_BASE_ADDRESS_SPACE_MEMORY, &qxl->vram32_bar);
>> -    if (qxl->vram32_size < qxl->vram_size) {
>> +    if (qxl->vram32_size < qxl->vga.vram_size) {
>>           /*
>>            * Make the 64bit vram bar show up only in case it is
>>            * configured to be larger than the 32bit vram bar.
>> @@ -2177,8 +2176,8 @@ static void qxl_realize_common(PCIQXLDevice 
>> *qxl, Error **errp)
>>       dprint(qxl, 1, "vram/32: %" PRIx64 " MB [region 1]\n",
>>              qxl->vram32_size / MiB);
>>       dprint(qxl, 1, "vram/64: %" PRIx64 " MB %s\n",
>> -           qxl->vram_size / MiB,
>> -           qxl->vram32_size < qxl->vram_size ? "[region 4]" : 
>> "[unmapped]");
>> +           qxl->vga.vram_size / MiB,
>> +           qxl->vram32_size < qxl->vga.vram_size ? "[region 4]" : 
>> "[unmapped]");
>>       qxl->ssd.qxl.base.sif = &qxl_interface.base;
>>       if (qemu_spice_add_display_interface(&qxl->ssd.qxl, 
>> qxl->vga.con) != 0) {
> 


