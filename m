Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB7F7482E6
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 13:27:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH0eZ-0001LP-1A; Wed, 05 Jul 2023 07:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH0eX-0001Fp-5N
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:26:33 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH0eU-0007Lb-UU
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:26:32 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9923833737eso584646166b.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 04:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688556389; x=1691148389;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MyuaJykDfDc91If9jqWs8HPZsxuZz34VTznoTL7e8Lk=;
 b=sA49nNhuJzMGXGT1exA9iOaqxXavR1detzIBd+pJv01vczzD+LgBk0TiWnasudkii2
 ipbfYibv50owNBUWt2aSM0m8fnYVTCR3F0b23ZaU1/6xJuW53OBJqkcwtK8ky+0NokVI
 mGQY3XF2u80u6D9rmZdhm+ZUO1O7qhTM39fyUiv0L52aKcMBayKAcbO0+hIZZLnCw8at
 RXjesXkHaSJST1yLfIw4f5wN+Eg+knB1CHvqwrIKH2+OtUDLHu2wtOnnLocIt014pto+
 tnBB2rSuyInH5AqwsMx/DzZF/j2mbEjnfDYg9lICGUox8JDsOb3/qbxm4gL9/63YUwlL
 JcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688556389; x=1691148389;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MyuaJykDfDc91If9jqWs8HPZsxuZz34VTznoTL7e8Lk=;
 b=YczlzKvMhcxhPLHYVJHdbfh0EUpHFwwO/TMv5qw2BzBzEGHLx/yawbVpad1uYx2UwB
 7OLOOem/Bg4aXgbmNQwP4WlGaQmF2At9jYIMD8O5cdjKRep6j2TSITe58kxbM3UYLosT
 R9KIJu4KfXj1Kdxw0RYTEG7sJ+jP5S/27EC6bUcuyfsvL4whNO7mVtsOW3tX6sWuArYT
 c4vRwpXcgan61KTRn1TOzD3tOXaeNEdNOnGkuVJGWsgyPaS2Mcm+rQzMrLsV5UKoln5Q
 E1V1J69aYxqysfbX/sIjBrN5twoKrNL/HCMGY9/kWmEENUUIX08ku9nas17CDcFJV6lE
 w9Kg==
X-Gm-Message-State: ABy/qLbWL5llsQYH+QORAFS9g6KIQqnNDfolZrK5/7qEjiwdJc6fy2Lb
 XwPN0c6ZdnqXyqP12VltjdRCoQ==
X-Google-Smtp-Source: APBJJlEGMQnh+ISYuZjrowEPilWp6bHlYMpdzbRmAFz4WXB6llCDurHdKYdAwy5HuMfC4cTBhR98Hw==
X-Received: by 2002:a17:906:24d:b0:973:e349:43c9 with SMTP id
 13-20020a170906024d00b00973e34943c9mr12202444ejl.77.1688556389328; 
 Wed, 05 Jul 2023 04:26:29 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.96])
 by smtp.gmail.com with ESMTPSA id
 lc1-20020a170906f90100b00988e953a586sm14540186ejb.61.2023.07.05.04.26.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 04:26:29 -0700 (PDT)
Message-ID: <cf7ed8a2-8fce-7ec9-c124-dd07871de362@linaro.org>
Date: Wed, 5 Jul 2023 13:26:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] pnv/xive: Print CPU target in all TIMA traces
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20230705110039.231148-1-fbarrat@linux.ibm.com>
 <060f5a94-30ab-b708-5086-09332531fd81@linaro.org>
 <dfbaa810-d1b8-1873-2994-14e7be16ce46@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <dfbaa810-d1b8-1873-2994-14e7be16ce46@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 5/7/23 13:18, Cédric Le Goater wrote:
> On 7/5/23 13:12, Philippe Mathieu-Daudé wrote:
>> On 5/7/23 13:00, Frederic Barrat wrote:
>>> Add the CPU target in the trace when reading/writing the TIMA
>>> space. It was already done for other TIMA ops (notify, accept, ...),
>>> only missing for those 2. Useful for debug and even more now that we
>>> experiment with SMT.
>>>
>>> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
>>> ---
>>>   hw/intc/trace-events | 4 ++--
>>>   hw/intc/xive.c       | 4 ++--
>>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/intc/trace-events b/hw/intc/trace-events
>>> index 5c6094c457..36ff71f947 100644
>>> --- a/hw/intc/trace-events
>>> +++ b/hw/intc/trace-events
>>> @@ -265,8 +265,8 @@ xive_source_esb_read(uint64_t addr, uint32_t 
>>> srcno, uint64_t value) "@0x%"PRIx64
>>>   xive_source_esb_write(uint64_t addr, uint32_t srcno, uint64_t 
>>> value) "@0x%"PRIx64" IRQ 0x%x val=0x%"PRIx64
>>>   xive_router_end_notify(uint8_t end_blk, uint32_t end_idx, uint32_t 
>>> end_data) "END 0x%02x/0x%04x -> enqueue 0x%08x"
>>>   xive_router_end_escalate(uint8_t end_blk, uint32_t end_idx, uint8_t 
>>> esc_blk, uint32_t esc_idx, uint32_t end_data) "END 0x%02x/0x%04x -> 
>>> escalate END 0x%02x/0x%04x data 0x%08x"
>>> -xive_tctx_tm_write(uint64_t offset, unsigned int size, uint64_t 
>>> value) "@0x%"PRIx64" sz=%d val=0x%" PRIx64
>>> -xive_tctx_tm_read(uint64_t offset, unsigned int size, uint64_t 
>>> value) "@0x%"PRIx64" sz=%d val=0x%" PRIx64
>>> +xive_tctx_tm_write(uint32_t index, uint64_t offset, unsigned int 
>>> size, uint64_t value) "target=%d @0x%"PRIx64" sz=%d val=0x%" PRIx64
>>> +xive_tctx_tm_read(uint32_t index, uint64_t offset, unsigned int 
>>> size, uint64_t value) "target=%d @0x%"PRIx64" sz=%d val=0x%" PRIx64
>>
>> "target" is kinda confusing, what about:
>>
>> xive_tctx_tm_read(uint32_t cpu_index, ...) "cpu=%d @0x%"PRIx64" ...
> 
> An interrupt 'source' is served by a 'target', a target could be a CPU,
> a vCPU id, a group of vCPU, a process id.
> 
> 'target' is part of the XIVE nomenclature, in HW specs, in drivers, FW,
> Linux, KVM, and models in QEMU. It is fine.

Ah OK. Then xive_tctx_tm_read(uint32_t target, ...).


