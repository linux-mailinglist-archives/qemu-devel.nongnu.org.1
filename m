Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D057802A9
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 02:17:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWnAL-000555-Lr; Thu, 17 Aug 2023 20:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWnAI-0004oX-ID
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 20:16:35 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWnAE-0005NH-D9
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 20:16:34 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bc0d39b52cso2986595ad.2
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 17:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692317788; x=1692922588;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e6dbbSgGBKx7+7oVIjzsmtlHk+19KqG7j0YK7zBFGbI=;
 b=i9GJd91Kc++yRu0TURQ1SBsW9GggQ4X2olWIRu0s29PsIcdEazRyNXLPWjZ/5t/yId
 VR6u1RtE7RySOjm2/bz9i3WHj/YZuGiTm/QqGGhMqrIxOM/Rqf6BgxF9ErnYv5KLSLdt
 WRXWNGdUJvmrKos/gXKuAtvL+f7ELnbyto3vuZXjbGhszKq/Nps5slGBgN4CgTMhsaYF
 poYip1aTb5rbnMxRTqQ+JsWCNYFghHrF88BIhWUrYy86cv6EhlZ9fZQbpyc6Z0pnccHv
 u+cnIYB8Jh0nBs03p9KfnqWAcenZjMoFjl0C47jd1GutkadoyCchEv0x6kXdQKBaGJlM
 jhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692317788; x=1692922588;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e6dbbSgGBKx7+7oVIjzsmtlHk+19KqG7j0YK7zBFGbI=;
 b=gdWEbN0kMfzm9DKGFm9HU4baDu608n1svyisHH7JajW+wKJ2Kp8CugzB3nFkInhpD8
 vU5ROwbA+S0tJQO9Ro3H8/Smxw72vaYnBdUmXqvxkBVy6SAOykAO2JwtTf0AIKsOc6c3
 z06+O5TfPFxFmvsgK1KbdADnGZ/t/AmQ1CY8JhzMAzUCespC5cmTaO1YXHtfni/e42aS
 6NAtU/MBvgo4co0/ZajJHyP44jro/PVQ6jNyqHBuGK14ukmmPLSNACDO0i69czxw5yVN
 smcurlReZtw76VuoL3BSg/aQFx5LcleetlWF/dV5L87lAV8UYfkrgwynv+bbQ0TDXvBx
 ONgQ==
X-Gm-Message-State: AOJu0YxoTi8+dfoc/Y3gGE6v+F8gwOqVvuqsJgO31MIpmy7u/mYLBZj1
 xPLQQ0rCFev8L0SlS0fwxZf+8Q==
X-Google-Smtp-Source: AGHT+IEDD0mDxmfuqaZQhca5f6pAMnIIZovZEZRsRKW+4ttNsfwtVb583XmWxwQ8VqgTn23a8PhyeQ==
X-Received: by 2002:a17:902:ff0a:b0:1bc:81f2:ddf0 with SMTP id
 f10-20020a170902ff0a00b001bc81f2ddf0mr801693plj.67.1692317787581; 
 Thu, 17 Aug 2023 17:16:27 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:3858:36b1:43e1:e747?
 ([2602:47:d483:7301:3858:36b1:43e1:e747])
 by smtp.gmail.com with ESMTPSA id
 w6-20020a170902d3c600b001bdb0483e65sm336704plb.265.2023.08.17.17.16.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Aug 2023 17:16:27 -0700 (PDT)
Message-ID: <2efe3431-44a3-919f-5989-080d5b189348@linaro.org>
Date: Thu, 17 Aug 2023 17:16:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/6] linux-user: Adjust brk for load_bias
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: iii@linux.ibm.com, deller@gmx.de, qemu-stable@nongnu.org
References: <20230816181437.572997-1-richard.henderson@linaro.org>
 <20230816181437.572997-4-richard.henderson@linaro.org>
 <9d0b2bca-f5c1-b23b-484b-259e0d67a1cb@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <9d0b2bca-f5c1-b23b-484b-259e0d67a1cb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.01,
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

On 8/17/23 01:53, Philippe Mathieu-Daudé wrote:
> On 16/8/23 20:14, Richard Henderson wrote:
>> PIE executables are usually linked at offset 0 and are
>> relocated somewhere during load.  The hiaddr needs to
>> be adjusted to keep the brk next to the executable.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: 1f356e8c013 ("linux-user: Adjust initial brk when interpreter is close to 
>> executable")
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   linux-user/elfload.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index ccfbf82836..ab11f141c3 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -3278,7 +3278,7 @@ static void load_elf_image(const char *image_name, const 
>> ImageSource *src,
>>       info->start_data = -1;
>>       info->end_data = 0;
>>       /* Usual start for brk is after all sections of the main executable. */
>> -    info->brk = TARGET_PAGE_ALIGN(hiaddr);
>> +    info->brk = TARGET_PAGE_ALIGN(hiaddr + load_bias);
> 
> Did you got some odd behavior or figured that by
> code review?
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Odd behaviour, easily seen by [heap] being weird or missing.


r~


