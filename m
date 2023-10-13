Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDDF7C7C42
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 05:42:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr93H-0003P1-WB; Thu, 12 Oct 2023 23:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr93F-0003Oo-Q3
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 23:41:25 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr93D-00028w-J7
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 23:41:24 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c9fa869a63so1650935ad.0
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 20:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697168481; x=1697773281; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XEC9r9hOqVtz/3KynDAAwckhRS/NH6hsrFoJ0l0IwjM=;
 b=uNEDjTC+Kvxgm2Ak0wVODMq4+jzrjPjf5yzpQAfagWX8q4oerFO3cUlC128NA+irxj
 wb5xUYlQi5imtFbMcBHMpJOB6FMFbxFCqqqGIUGzKKC3xJ7J+JvSiX+fF35JdOezu8ME
 mHO8QnDaJgKiDLQAXe1AmP50cmh94Uyv0KsRIQlLLHl0uW4Drh0Mgz2xZqVkRah1SVIE
 mAsCz4EL7Vlxbt4fqvWYaDuxGnm2Gfvdk1z49bpD0667kie58Sr7Kn6J12k/18Dhvuwf
 ogVkgQksCeoopvTJQLuniqsI4BjJPPps4vyno/Hs+2Yvj8ZvZcaaKqtEh66M01hQyv1x
 ftxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697168481; x=1697773281;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XEC9r9hOqVtz/3KynDAAwckhRS/NH6hsrFoJ0l0IwjM=;
 b=gpkbZ0YYYtptKsXFir3Gacq+Vn7p3QE2QyRzP2IwB160XpMEyPupwFfy+eJwCL5IT4
 4zP9DeMmrcYKiuUFOXiiUT3MlH+fwvo5bt99O8ZKx2CnNPCUPPUr2r8vR3ikUBDKMz/N
 zmTDAUrkA/R4JAkStT2GQkqNjBJd0TLujf3KvOG2aZSQSzdIAzxZj1czFYWaYjmcnPdU
 lbIgMFjOk8ScUf+Qnvoi7JHXg0kfK4gWgVpGxDw8GnVHhg+6ceFikl8a7Db88pwp5EEr
 o3kP5Y9E2R7EV8+j6n31zLIAAzNziCrXlafWKUyOlea3hDqmBPpChzXDy3PSwIKBnALI
 q7og==
X-Gm-Message-State: AOJu0YwwyVmy14Veqqxl8sa4c7mMxW6jPBH+YGa26hL3HULztBxagkFO
 v5+ZED0PUYm9+9EJySoCU8JMmw==
X-Google-Smtp-Source: AGHT+IHH7wDQchpx39SIexP7rliH8pfHmA/S4wy/T5+FADr8WlhC8vaEntcKIioiUy0A4dWrNv5MyA==
X-Received: by 2002:a17:902:d2cb:b0:1c9:ff46:162d with SMTP id
 n11-20020a170902d2cb00b001c9ff46162dmr440682plc.22.1697168481369; 
 Thu, 12 Oct 2023 20:41:21 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a170902d49100b001c7453fae33sm2733526plg.280.2023.10.12.20.41.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 20:41:20 -0700 (PDT)
Message-ID: <4b966855-277a-40d1-894d-85bf874d0181@linaro.org>
Date: Thu, 12 Oct 2023 20:41:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] tcg/arm: Use tcg_use_softmmu
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231003174356.1602279-1-richard.henderson@linaro.org>
 <20231003174356.1602279-4-richard.henderson@linaro.org>
 <ef866c49-63aa-c062-481f-e77a26e4caa7@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ef866c49-63aa-c062-481f-e77a26e4caa7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/5/23 09:53, Philippe Mathieu-Daudé wrote:
> On 3/10/23 19:43, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/arm/tcg-target.c.inc | 203 +++++++++++++++++++--------------------
>>   1 file changed, 97 insertions(+), 106 deletions(-)
> 
> 
>> @@ -356,14 +354,8 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
>>    * r0-r3 will be overwritten when reading the tlb entry (softmmu only);
>>    * r14 will be overwritten by the BLNE branching to the slow path.
>>    */
>> -#ifdef CONFIG_SOFTMMU
>>   #define ALL_QLDST_REGS \
>> -    (ALL_GENERAL_REGS & ~((1 << TCG_REG_R0) | (1 << TCG_REG_R1) | \
>> -                          (1 << TCG_REG_R2) | (1 << TCG_REG_R3) | \
>> -                          (1 << TCG_REG_R14)))
>> -#else
>> -#define ALL_QLDST_REGS   (ALL_GENERAL_REGS & ~(1 << TCG_REG_R14))
>> -#endif
>> +    (ALL_GENERAL_REGS & ~((tcg_use_softmmu ? 0xf : 0) | (1 << TCG_REG_R14)))
> 
> Maybe add a comment?
> 
> (ALL_GENERAL_REGS & ~((tcg_use_softmmu ? 0xf /* R0 to R3 */ : 0) | (1 << TCG_REG_R14)))
> 
> Otherwise,
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

I'd have thought the existing comment sufficient.


r~

