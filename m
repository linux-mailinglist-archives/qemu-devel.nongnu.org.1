Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 587F277156D
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 15:47:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSe5I-0006Tr-Ih; Sun, 06 Aug 2023 09:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSe5A-0006St-K7
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 09:46:11 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSe55-0008UM-KR
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 09:46:08 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bc6bfc4b58so1006855ad.1
 for <qemu-devel@nongnu.org>; Sun, 06 Aug 2023 06:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691329562; x=1691934362;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jG9MN+kvJhMjk2RkHMGPPqClPPllMq7dO5Ph5Iq/eFk=;
 b=JO8AXgur8FYbGt2GOTVgDc2dSk+tIFji/o9RZLyFRBCOaHAnM/M1ZKvoqgSzsdZRmb
 PW/K5jOIlFburB/fJs9WeFoN02D0QLPPlYWmKJz39r/ie5HH5oL1+xajQCyktsRqersU
 q3kSFi3BAcpXZgueBmXmlx6cp9uTM9V2f4aFuMucLAeLmTDCquRgPUG1nOtcBnOiVIiN
 iofrx2bV5bNps4pJgiu7RJzpMrduHypGDDcLxAQxW/YDKfsqX7CATCCZYa1T76mUakzB
 Ddvw9Os5y+iFuuNUv20DKCzWuIGLYzMvhZKGp/w+bJRulKDmaDLee1i3WVttAAC5Xls/
 OeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691329562; x=1691934362;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jG9MN+kvJhMjk2RkHMGPPqClPPllMq7dO5Ph5Iq/eFk=;
 b=IjW33rXfK8/RfOvweF5FZZxHC0cKlir80WqyUAuiK40nnK0c3XzLZeuN6/YfNiNFHp
 B3GOFMN6fOLmW8465NVd3ilJJzvazVhKlAY6cYtGmoY9PXDHdVmkwRtWHr5b1+VdUzwc
 Ggx13T1vDwJP0isiYlLdAb/0mb+UokfDFy6qbKm8eKr057ylLMzJT8Z6QGeT4D/C1x0w
 QPWHNh1DGmHrva5Dl6Puun1x0HE6h3gxmyJ/WIvG0cZBaLrhkU4+nI4mZTThQiUGrwWz
 n/L67bidJe/YMKBON7qQ8OaZejjewb52u0Bo5kiX3lNxFH+R1k+KjrTlWXFKX6xUwlQO
 +k0A==
X-Gm-Message-State: AOJu0YzbH8oNfG1gtT3fGJ7j5QsPcRF5rU2nCaUoiKhFqL2SVI6IFT2P
 dTs6fW8fGi9od0iyjKdd83mrnQ==
X-Google-Smtp-Source: AGHT+IEexhGyuePy0vlpxsIl7wcs5aQ+zc77oZzRpko8z/CaNRga6yJfBbucmcGPmANvpNBTCIHfyA==
X-Received: by 2002:a17:902:7048:b0:1bc:4f04:17f9 with SMTP id
 h8-20020a170902704800b001bc4f0417f9mr5083380plt.9.1691329561918; 
 Sun, 06 Aug 2023 06:46:01 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:e72:57bd:c5e4:990c?
 ([2602:47:d490:6901:e72:57bd:c5e4:990c])
 by smtp.gmail.com with ESMTPSA id
 g4-20020a1709026b4400b001bb24cb9a61sm4914175plt.265.2023.08.06.06.46.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Aug 2023 06:46:01 -0700 (PDT)
Message-ID: <eb48a764-39ba-9b33-834c-7101b22751af@linaro.org>
Date: Sun, 6 Aug 2023 06:45:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/7] tcg/ppc: Disable USE_REG_TB for Power v3.1
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: jniethe5@gmail.com, qemu-ppc@nongnu.org, bgray@linux.ibm.com
References: <20230804213355.294443-1-richard.henderson@linaro.org>
 <20230804213355.294443-7-richard.henderson@linaro.org>
 <CULFZWQ05ZC9.8XZ7OPX9KW0Y@wheely>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CULFZWQ05ZC9.8XZ7OPX9KW0Y@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.139,
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

On 8/6/23 04:58, Nicholas Piggin wrote:
> Patch 7 is not reqired for this?

No, USE_REG_TB has never been *required*.

The fallback path through tcg_out_movi will generate the 5 insn sequence for a full 64-bit 
constant load.  Mitigating that here is that patch 1 will emit PADDI for most of those 
constants.


r~

> 
> Thanks,
> Nick
> 
> On Sat Aug 5, 2023 at 7:33 AM AEST, Richard Henderson wrote:
>> With Power v3.1, we have pc-relative addressing and so
>> do not require a register holding the current TB.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/ppc/tcg-target.c.inc | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
>> index e8eced7cf3..5b243b2353 100644
>> --- a/tcg/ppc/tcg-target.c.inc
>> +++ b/tcg/ppc/tcg-target.c.inc
>> @@ -83,7 +83,7 @@
>>   #define TCG_VEC_TMP2    TCG_REG_V1
>>   
>>   #define TCG_REG_TB     TCG_REG_R31
>> -#define USE_REG_TB     (TCG_TARGET_REG_BITS == 64)
>> +#define USE_REG_TB     (TCG_TARGET_REG_BITS == 64 && !have_isa_3_10)
>>   
>>   /* Shorthand for size of a pointer.  Avoid promotion to unsigned.  */
>>   #define SZP  ((int)sizeof(void *))
> 


