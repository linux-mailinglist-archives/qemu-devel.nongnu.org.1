Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E918773B0EB
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 08:52:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCadq-0003O8-3I; Fri, 23 Jun 2023 02:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCadh-0003DE-3M
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 02:51:27 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCadf-0007Jo-EZ
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 02:51:24 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-98bcc5338d8so25876566b.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 23:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687503081; x=1690095081;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JZVlQgSGa1azEw+UQcAuKqyuTUvhMOvEc8rWlFCfpXc=;
 b=ybugZ7U6/A/WM4r13Uqp/f26q3HE0gSGW0aISajh4Qg+Eg2VJ+vkf63zxfLWMDtEUe
 Yqy7qlYu9aFa0wGU970UwljYyReUBVUJ5uYornB2ZKU2EaERTE32EnNAfHDJk+fHYKF6
 twJODxLnK+lslN0Nvj65pqB5uYU8uXdMJoFKhRv959ULRykUtlO79lYNqrxxpkGW2KaS
 sAp7Hcw32o0uyYC6kQulpGZKnmAI+FPoXX3+1EHE0zJb/ngrCkR0VIPMt0qx6RrG8Vsc
 ktOV0pLSjRKDihWhRbQ3d4LbhnXnIg+C5Yc3jpZJnboROWaOEwcaOGT0nthzCH2uToNO
 5iTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687503081; x=1690095081;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JZVlQgSGa1azEw+UQcAuKqyuTUvhMOvEc8rWlFCfpXc=;
 b=dp94I/+mf/Hcmrl7ySJbs/KbOwzchchKazWDs80a9Gf2a6hAAjKLLa22yvBQsnD3xW
 gsW1XG+mGEIZyzJZSCZ83lrfQsXwlLyVcmBI+pabOG+RQ5bm++WnOg5HIwrtpF/Q/6Bg
 7b66qD30l/tylkUXV9Fm6cfco/P2Bb6p2gw9Omy3hDmPe23dbFdRRt8wHQq3fvcnlWWc
 UMxcNEZ7xrwys/PjjcndGXcsS9SbrcrcZWK2rNRrz2qAMKqsrDbO2Jm6VIcxTbTe29GZ
 O307XB1bO67zkTYdzawL+29s99dgn6tHk2nJhmVGs+M3sHzAgMTC1LcWwGfrjfRDOQ82
 mADQ==
X-Gm-Message-State: AC+VfDzURG3nW7SBJ5yEhVHtr+/+pcRc1KTU8+Nhecrn6y9eaYUBovIP
 zfP7zvi0bfF+b79jrDf9/uoinA==
X-Google-Smtp-Source: ACHHUZ6N0j+1QtP0W5dn6qAnvWFn7t7FBZPZTXW7An7CEc5Vz07UKg/QJp6lHcmtSe58k8bLMYZBLQ==
X-Received: by 2002:a17:907:6da6:b0:988:9763:951c with SMTP id
 sb38-20020a1709076da600b009889763951cmr13096617ejc.59.1687503081591; 
 Thu, 22 Jun 2023 23:51:21 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.168.147])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090614cc00b0098951bb4dc3sm4586176ejc.184.2023.06.22.23.51.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 23:51:21 -0700 (PDT)
Message-ID: <dace2217-77a3-09c4-4541-e19b0bee9fc7@linaro.org>
Date: Fri, 23 Jun 2023 08:51:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 08/17] tcg: Fix temporary variable in tcg_gen_gvec_andcs
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20230622161646.32005-1-max.chou@sifive.com>
 <20230622161646.32005-9-max.chou@sifive.com>
 <684ca7f1-c4f4-70f8-b92d-34b0d3336646@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <684ca7f1-c4f4-70f8-b92d-34b0d3336646@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/22/23 19:30, Daniel Henrique Barboza wrote:
> 
> 
> On 6/22/23 13:16, Max Chou wrote:
>> The 5th parameter of tcg_gen_gvec_2s should be replaces by the temporary
> 
> s/replaces/replaced
> 
> 
>> tmp variable in the tcg_gen_gvec_andcs function.
>>
>> Signed-off-by: Max Chou <max.chou@sifive.com>
>> ---
> 
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Queued to tcg-next with the typo fixed.


r~

> 
>>   tcg/tcg-op-gvec.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
>> index 95a588d6d2..a062239804 100644
>> --- a/tcg/tcg-op-gvec.c
>> +++ b/tcg/tcg-op-gvec.c
>> @@ -2774,7 +2774,7 @@ void tcg_gen_gvec_andcs(unsigned vece, uint32_t dofs, uint32_t aofs,
>>       TCGv_i64 tmp = tcg_temp_ebb_new_i64();
>>       tcg_gen_dup_i64(vece, tmp, c);
>> -    tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, c, &g);
>> +    tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, tmp, &g);
>>       tcg_temp_free_i64(tmp);
>>   }


