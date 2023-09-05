Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB2A7929B8
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 18:57:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdZKw-00034H-M2; Tue, 05 Sep 2023 12:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdZKt-00033X-IS
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 12:55:31 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdZKp-0004ac-JB
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 12:55:31 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-99c136ee106so420840166b.1
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 09:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693932925; x=1694537725; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3AlzI1/zUkgHjINPB/60Bhf/bsRfn38JsFwy+xis2jA=;
 b=hE7HWfDc0p3N0Bpq01wmeLvFAobgntV39leHjafhjwmmCRz5t6wz7P4lKNJoHpS/te
 zeiLkaQeJ8N1yhdHsj4B4dF1qF/B6vb9E3XEKt4Bm1Y/3lL/Lmu3vj2cQw1+xzI3K9Ce
 31lmrfoZ8N9c3bUsFM4U45PP4f19qLHQPAPH5c3jVctH+Y67LEizVK4KAIbZC8idLz00
 wXyP10lkhi+u1/vEHIdQxlcCcgrHyjtaWaaelqqjHeIUk3Hqz0Xpk9ZN/jxciXf+3TdW
 c3GwRz186Gy0ANEG1LWNJr2fKU3nYbkLMfSmp46Jz7yNfXCtZlVAlmKuYdDjrRj1Z58B
 7Hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693932925; x=1694537725;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3AlzI1/zUkgHjINPB/60Bhf/bsRfn38JsFwy+xis2jA=;
 b=J+HB2AXQZrbmyr/WS33nWloe8xHGXZ2mzeMHEcTmBv2/R+PZFzSC16N4+GIG1wCWuG
 x+wBC34laKsMncHyHZKntnKwUVoFRelSre6066N3EKJPGuZB1OcXjzJXHofKbowrBYh4
 hsZyeqVpETskO7XNCPisXmxspvBrVlnpA5NK9THDt43k/4/pVooUFJmoni5a8MtcOw3B
 zJbstzRVsLRCoUryvwBXD3gS03LLRBV7Si0a35abIGK0frHeVWnvPbb+dzRCD/RWVBFF
 SO6me/mXMbR0NMBToUI2rmXB29Lq4W35fp7P8QSt0fgbeFlbf6rYfsOBjZt4eOa0miIV
 zeQA==
X-Gm-Message-State: AOJu0Yxjuh+CiB6dhVBKxaxWO6z5c48d1wJV5F55EjtCtaX0EMrKcuLx
 mspi6CfTy3G/36enJ2ms6rghKA==
X-Google-Smtp-Source: AGHT+IGJjFvazhbzDO72qsjE+5oyOKiJjYH9aNw64nxL/uDLtKPe8WhesihAPOy2FRDrol1fvQtvSQ==
X-Received: by 2002:a17:907:7893:b0:99b:d580:546c with SMTP id
 ku19-20020a170907789300b0099bd580546cmr369290ejc.23.1693932925378; 
 Tue, 05 Sep 2023 09:55:25 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-79.dsl.sta.abo.bbox.fr.
 [176.184.47.79]) by smtp.gmail.com with ESMTPSA id
 f3-20020a170906824300b009786c8249d6sm7898364ejx.175.2023.09.05.09.55.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 09:55:24 -0700 (PDT)
Message-ID: <d3e6506a-b553-d292-9428-25e784be0d4f@linaro.org>
Date: Tue, 5 Sep 2023 18:55:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] hw/cxl: Add utility functions decoder interleave ways
 and target count.
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Jonathan Cameron via <qemu-devel@nongnu.org>
Cc: Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
 linuxarm@huawei.com
References: <20230904164704.18739-1-Jonathan.Cameron@huawei.com>
 <20230904164704.18739-2-Jonathan.Cameron@huawei.com>
 <89d5477c-ece0-b738-c64f-056242619d92@linaro.org>
 <20230905155639.00000b3a@huawei.com> <20230905160607.0000366f@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230905160607.0000366f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 5/9/23 17:06, Jonathan Cameron wrote:
> On Tue, 5 Sep 2023 15:56:39 +0100
> Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> 
>> On Mon, 4 Sep 2023 20:26:59 +0200
>> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>>> On 4/9/23 18:47, Jonathan Cameron wrote:
>>>> As an encoded version of these key configuration parameters is
>>>> a register, provide functions to extract it again so as to avoid
>>>> the need for duplicating the storage.
>>>>
>>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> ---
>>>>    include/hw/cxl/cxl_component.h | 14 ++++++++++++++
>>>>    hw/cxl/cxl-component-utils.c   | 17 +++++++++++++++++
>>>>    2 files changed, 31 insertions(+)
>>>>
>>>> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
>>>> index 42c7e581a7..f0ad9cf7de 100644
>>>> --- a/include/hw/cxl/cxl_component.h
>>>> +++ b/include/hw/cxl/cxl_component.h
>>>> @@ -238,7 +238,21 @@ static inline int cxl_decoder_count_enc(int count)
>>>>        return 0;
>>>>    }
>>>>    
>>>> +static inline int cxl_decoder_count_dec(int enc_cnt)
>>>> +{
>>>> +    switch (enc_cnt) {
>>>> +    case 0: return 1;
>>>> +    case 1: return 2;
>>>> +    case 2: return 4;
>>>> +    case 3: return 6;
>>>> +    case 4: return 8;
>>>> +    case 5: return 10;
>>>> +    }
>>>> +    return 0;
>>>> +}
>>>
>>> Why inline?
>>>    
>>
>> Bad habit.
> Nope. I'm being slow.  This is in a header so if I don't
> mark it inline I get a bunch of defined but not used warnings.
> 
> Obviously I could move the implementation of this and the matching
> encoding routines out of the header. I haven't done so for now.

Inlined function in hw/ are hardly justifiable. They make the headers
and debugging sessions harder to read in my experience. Compilers are
becoming clever and clever, and we have LTO, so I rather privilege
code maintainability. My 2 cents :)

>>> Alternatively:
>>>
>>>     unsigned cxl_decoder_count_dec(unsigned enc_cnt)
>>>     {
>>>         return enc_cnt <= 5 ? 2 * enc_cnt : 0;
>>
>> It gets a little more fiddly than the code I'm proposing implies.
>> For Switches and Host Bridges larger values are defined
>> (we just don't emulate them yet and may never do so) and those
>> don't have a sensible mapping.
>>
>> I guess there is no harm in adding the full decode however
>> which will make it more obvious why it was a switch statement.

Right, no problem.

Preferably having this tiny function not inlined:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


