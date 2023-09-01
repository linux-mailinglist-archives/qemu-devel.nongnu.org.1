Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 782EA790199
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 19:49:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc8Fr-00058w-Ou; Fri, 01 Sep 2023 13:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qc8Fq-00057u-LK
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 13:48:22 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qc8Fo-0008MM-DP
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 13:48:22 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bdc19b782aso16897225ad.0
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 10:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693590499; x=1694195299; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Eq8NjWF3uZKW64FGjENQUSYn35oUfSzyi62nlYHQNoA=;
 b=VUqRSRkVZgJEsdXr8/evJA0Fq4TVUi3J9/mrCRSqoRFwy6NJCMpHIQ38Kh8cq0IhX0
 FmzfSX0DmNyHyN4dHmyr8wMxq+04qtvOBP5XrVcMjoS7fUmZNqa1fvNKG56QhEiR3eCD
 ChamO8zYvDUUW5U/Gy5ojsHwNNaAm/440JikpRpHyLlifjTm/YRQjyCm43/MqEzcN64i
 Z7qtAsrLVY+twN1z8H2qYxcFo3ZPlBMPfPf27FizUJ6iTs0bfa9buwkxWE4+j1qHzWxy
 hxtShYnuRwEjkYxukmRk3ULiUdIZsMV3TrfdLYE3AdXl2F//S6SRkLW4Ooc0NXDGw2ZM
 Aw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693590499; x=1694195299;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Eq8NjWF3uZKW64FGjENQUSYn35oUfSzyi62nlYHQNoA=;
 b=C1bA93E5NBNvv0+vexDULTlVXQpdy+v5AaP3A7zxI1v/pQFRuVkOGxIC6BAe88RSNv
 mSDLGVpAEWLUeTHkCQVWPE9N0XLEOIbcAIjnq521zSAoTY14RhfHaUssKO9JYVgo1hkl
 HH0Ek90RIS/rMTXWBvqTKUBd3RUK5pXzMO/JF6QsBhRLpuquzWe2ShdJNBop5hNhoH+7
 GsW96WSad8Q198C7EpSoJZFjkyD/InE5l3IGkhmnbhZwvXQen2cvW6xArKQgef022lJ3
 p1LkF3rInHpXAmaVSavD2FHRhSIS9U09abbdbOoPMhIVh/870bGI9uG+naZOS9XCJxg6
 7ocA==
X-Gm-Message-State: AOJu0YwpX6hKpRGlh1y4Klq5hJ5wPxbIPHrmvTwY5q+enWFx+ID4bYV9
 VaikFAlZF9Q7PlJFWFnjzg86/A==
X-Google-Smtp-Source: AGHT+IFQmVioLXnZnYKyrbFNm1zgNC+2Z1OCS8lOmL7hopYmhZMDxzyIl7Dsp65sK9HbHxliElfjbA==
X-Received: by 2002:a17:902:bd83:b0:1bc:7001:6e62 with SMTP id
 q3-20020a170902bd8300b001bc70016e62mr2992197pls.35.1693590498824; 
 Fri, 01 Sep 2023 10:48:18 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 x6-20020a170902b40600b001bf10059251sm3245577plr.239.2023.09.01.10.48.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Sep 2023 10:48:18 -0700 (PDT)
Message-ID: <39e63387-dad7-ffd0-12c3-082f81c09997@linaro.org>
Date: Fri, 1 Sep 2023 10:48:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 03/14] tcg/loongarch64: Lower cmp_vec to vseq/vsle/vslt
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, git@xen0n.name
References: <20230901093258.942357-1-c@jia.je>
 <20230901093258.942357-4-c@jia.je>
 <1f963ece-d5b6-50c7-5e40-bc04867494f7@linaro.org>
 <3ddba7dd-db34-c017-8dfa-fa805145e2f2@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <3ddba7dd-db34-c017-8dfa-fa805145e2f2@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
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

On 9/1/23 10:28, Jiajie Chen wrote:
> 
> On 2023/9/2 01:24, Richard Henderson wrote:
>> On 9/1/23 02:30, Jiajie Chen wrote:
>>> Signed-off-by: Jiajie Chen <c@jia.je>
>>> ---
>>>   tcg/loongarch64/tcg-target-con-set.h |  1 +
>>>   tcg/loongarch64/tcg-target.c.inc     | 60 ++++++++++++++++++++++++++++
>>>   2 files changed, 61 insertions(+)
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>>
>>>
>>> diff --git a/tcg/loongarch64/tcg-target-con-set.h b/tcg/loongarch64/tcg-target-con-set.h
>>> index 37b3f80bf9..d04916db25 100644
>>> --- a/tcg/loongarch64/tcg-target-con-set.h
>>> +++ b/tcg/loongarch64/tcg-target-con-set.h
>>> @@ -31,4 +31,5 @@ C_O1_I2(r, 0, rZ)
>>>   C_O1_I2(r, rZ, ri)
>>>   C_O1_I2(r, rZ, rJ)
>>>   C_O1_I2(r, rZ, rZ)
>>> +C_O1_I2(w, w, wJ)
>>
>> Notes for improvement: 'J' is a signed 32-bit immediate.
> 
> 
> I was wondering about the behavior of 'J' on i128 types: in tcg_target_const_match(), the 
> argument type is int, so will the higher bits be truncated?

The argument is int64_t val.

The only constants that we allow for vectors are dupi, so all higher parts are the same as 
the lower part.

> Besides, tcg_target_const_match() does not know the vector element width.

No, it hadn't been required so far -- there are very few vector instructions that allow 
immediates.


r~

