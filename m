Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAAD7245A4
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:19:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6XWk-0004uA-Ao; Tue, 06 Jun 2023 10:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6XWf-0004sC-Kx
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:19:11 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6XWd-0006xj-9S
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:19:08 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f6d38a140bso44831695e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686061145; x=1688653145;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2oIAS4dy9HaYrGAQfLKgDWTuC8ulr1q1ZAVQhDmy+hk=;
 b=VAsjeLWCzjqXzE/JpLw9QNjs7lTFnjwE0GGPjo4j71zQNeWe147BqQ6X5eqb1huB33
 ZFWSvcorD8p3ixs5+vJTro/TMSHelAX6znPNISGk4XQ1npEp6R5hHDuukGuE9t8D4+O7
 lzRWaUN7dgqhhMtbl0O6ekBh1hS4vrIiI8BXAKvZLRjxgo5aAL9gvCkk1OizLlymkAEj
 FycBXv+ZPegg4RkGCqfkCcKkynkJlWWgYfK5i8YHr1ISLZ2yRjiVpR5WwHwAWR7LkuKF
 f439rlR4YAAmeC7CD38piH+kxm8ogzQcKtCniolbZ/pdlDFQiih/r4Z36Zoq2RgLjAkK
 aSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686061145; x=1688653145;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2oIAS4dy9HaYrGAQfLKgDWTuC8ulr1q1ZAVQhDmy+hk=;
 b=BRVAdUF9RUPuTJLGc5RIvfjuzi9/IVPnY70lLbxYJfy91U0cYSXETplWDpqTk8pJJr
 MnP6fgB/ve7fxrr8aT8jZAdga0bwPFdK8wIGaHJNaYkp2d72edlXgA0+dAKg+KsmmlVs
 pg3EB1NOXXeYI/KDM59FkSuWr9fJ70iwFyH6No0qzILTwC0VmjvynkRL0PBCw0q0Pew9
 Lme+rKp+kc5UgJDU6Plu8JiYNO77X1hXWWuwHalfjfuUJF4/AbqGp2QxlOVyBWmXqYL6
 iSyViNcvN4ZhCcBj2gSqhTI4e7YRrjAXB0m+qIOubr+15iCiDMc7LuPbne3tXOOEmy6T
 4/2A==
X-Gm-Message-State: AC+VfDyKXOv04lHflyJCdkE8+1f2HGLui+Rl1YwD57zMM95lUr9Owwne
 pw/JSqL5IgQGdq0+Y22m6RljvQ==
X-Google-Smtp-Source: ACHHUZ7vJy/TXs/MHVHpt10ddW7wCPOPizTPfm9+1GTg5QTtz6w+JFeMadB9n68zi4BgppIT/Ai/MQ==
X-Received: by 2002:a05:600c:3797:b0:3f7:9b05:928e with SMTP id
 o23-20020a05600c379700b003f79b05928emr1917428wmr.0.1686061145478; 
 Tue, 06 Jun 2023 07:19:05 -0700 (PDT)
Received: from [192.168.69.115] (vbo91-h01-176-184-50-104.dsl.sta.abo.bbox.fr.
 [176.184.50.104]) by smtp.gmail.com with ESMTPSA id
 6-20020a05600c024600b003f7ed9dae70sm93214wmj.0.2023.06.06.07.19.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 07:19:05 -0700 (PDT)
Message-ID: <b0a05492-21ca-a6c6-37aa-2a990c8fc5d7@linaro.org>
Date: Tue, 6 Jun 2023 16:19:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [RFC v1 4/4] qemu: adjust queried bar size to power-of-2
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>, ankita@nvidia.com
Cc: jgg@nvidia.com, qemu-devel@nongnu.org
References: <20230605235005.20649-1-ankita@nvidia.com>
 <20230605235005.20649-5-ankita@nvidia.com>
 <20230606065441.170333b5.alex.williamson@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230606065441.170333b5.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 6/6/23 14:54, Alex Williamson wrote:
> On Mon, 5 Jun 2023 16:50:05 -0700
> <ankita@nvidia.com> wrote:
> 
>> From: Ankit Agrawal <ankita@nvidia.com>
>>
>> The GPU device memory is reported to the VM as a BAR. The device memory
>> may not be aligned to the power-of-2, but the QEMU expects the PCI BAR to
>> be. Align the reported device memory size to the next power-of-2 before
>> QEMU does an mmap.
>>
>> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
>> ---
>>   hw/vfio/common.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 4d01ea3515..bb49200458 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -2061,7 +2061,7 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
>>   
>>       region->vbasedev = vbasedev;
>>       region->flags = info->flags;
>> -    region->size = info->size;
>> +    region->size = info->size ? pow2ceil(info->size) : info->size;
>>       region->fd_offset = info->offset;
>>       region->nr = index;
>>   
> 
> Nak, this means our kernel emulation of the BAR is broken, a BAR that
> is not naturally aligned is not a PCI BAR.

Right. So the common code could check this value is correct, like:

   assert(is_power_of_2(->size));

Or less violet using error_report :)

