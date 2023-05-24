Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AEB70F2BB
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:27:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1km5-0005qt-RZ; Wed, 24 May 2023 05:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1km2-0005qQ-SD
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:27:14 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1km1-0004ln-7Y
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:27:14 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f60410106cso5710855e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 02:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684920431; x=1687512431;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LcxOBE1Of/LINoB/3WMca0kcmjJgKHI17bKreNSId7A=;
 b=XxAf7uEg0IELIQgB+v+icufE7HUlbpropO6IFxZtYSTXbYEOdLeuTmzwhJ91U78Spl
 7gs2JziPenF02IB7YVPp2qII3dUbDLKomi9+9u69Ao1DOWxCoRvVK29l+jQvIFJqxx62
 a6lsjfMIiI73d78Ua3IIqpBIhVZXJqT2JOH1PPPqoWLrqS3KOhX9icRpAxZKfMlfqDWS
 UWsswekXXtn0EPUadbgNcboLFGy84nyTmI/G9N6kSwXnn8MPqEqvJqBj9EamfJdE8hT4
 ChZiMINaNhc6lE7PS+Sw9bR2WtzcRt/Gm/GuOHeU7CapStcPdOWQ0Q2ryAU8DP8+b1NH
 281Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684920431; x=1687512431;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LcxOBE1Of/LINoB/3WMca0kcmjJgKHI17bKreNSId7A=;
 b=KyK4igdv0j6pdKDVAsz7pSEzo8dRUNQ8wzmAYL8cRdexq5nJhizSgziWdGobH9Yf+8
 168z0lIl47hS2w12fZYQmUzkG/iKXPOP3WAEKcLkLDem61VbbwncGjFgvIqaXwSgE8j+
 iYlVIhab659WXF4V8wMcu1rBsVsMEaCIWmaPzj3YWk02kxSFCBlHK4OmctscrIOjbErO
 mZKBAGciIAoypjIFU22iBfufiE7ehQTnmT1lDn1N0n6g3UEaRwaX02tiziIbfXIlzQST
 UOTRPed+KPucPmU89Lrc+Hnx/EffoqhdpPYNlUzQXMEktd1lZXA0d6mT1i2gESNyO1DX
 S/uw==
X-Gm-Message-State: AC+VfDz9vp7V5M5fk+hvUakU+Sz1MJzmKOSkJWjiUp1mC1t1BWMuqVWz
 sLVhhJnj2qDdz172F4ygvJFb6pbBPT2ecUHmaxnlYg==
X-Google-Smtp-Source: ACHHUZ7j5kgHis3RDdOrLHYwQNdKhvcxvxJ5PGljGeVy/4hdjAMV4c02wNJ1611FYa2iLVRuH38Lgw==
X-Received: by 2002:adf:f28a:0:b0:309:42f3:4c3a with SMTP id
 k10-20020adff28a000000b0030942f34c3amr13222386wro.32.1684920431481; 
 Wed, 24 May 2023 02:27:11 -0700 (PDT)
Received: from [192.168.69.115] (fac34-h02-176-184-31-246.dsl.sta.abo.bbox.fr.
 [176.184.31.246]) by smtp.gmail.com with ESMTPSA id
 w4-20020adfee44000000b0030785b864f1sm13786590wro.65.2023.05.24.02.27.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 02:27:10 -0700 (PDT)
Message-ID: <0b2294bb-5b5c-d004-b3e6-735f3f370958@linaro.org>
Date: Wed, 24 May 2023 11:27:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 08/11] hw/virtio/virtio-iommu: Use target-agnostic
 qemu_target_page_mask()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230523163600.83391-1-philmd@linaro.org>
 <20230523163600.83391-9-philmd@linaro.org>
 <cfad3770-d883-3011-bee4-c3749891f886@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <cfad3770-d883-3011-bee4-c3749891f886@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 24/5/23 01:28, Richard Henderson wrote:
> On 5/23/23 09:35, Philippe Mathieu-Daudé wrote:
>> In order to have virtio-iommu.c become target-agnostic,
>> we need to avoid using TARGET_PAGE_MASK. Get it with the
>> qemu_target_page_mask() helper.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/virtio/virtio-iommu.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)


>> @@ -1164,7 +1165,7 @@ static void 
>> virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>>        * in vfio realize
>>        */
>>       s->config.bypass = s->boot_bypass;
>> -    s->config.page_size_mask = TARGET_PAGE_MASK;
>> +    s->config.page_size_mask = qemu_target_page_mask();
> 
> This could be
> 
>    = -(uint64_t)qemu_target_page_size()
> 
> without adding the new function.

Alex recommended on IRC to add a helper "by all means" :)

> But either way,
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks!


