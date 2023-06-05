Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B364C722418
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 13:02:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q67y5-0005aY-8F; Mon, 05 Jun 2023 07:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q67xi-0005Xg-1u
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 07:01:23 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q67xb-0001a0-H6
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 07:01:21 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f732d37d7bso14130495e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 04:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685962874; x=1688554874;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9iyTJv6hv5TVgHzcIxSZtEyIDrtGWZ6PsvH+kn0mbTI=;
 b=MoQwLqUSeF8pXuBCK+gE+YArWpiJ9o0h0PBE/4+88H74BIDzfEqHKZ7fFBCiByJq8w
 z+pkuO1QQl9t2cJJJKW3FL9xWYydF+uhzXVsFHIw6WNcqiXGgXESS9hvYuKNXOPGMCXN
 k/5UvJQBc1gKhtWqF/AxM1K3htQleAkCxfwhSmmZa/lpu1okN1WIiax0/M8obFIM4i0V
 BRWlYcd8ScqCt/xDmUxgjDWTucK3cco22kKNZZfSDADqv/ZsoU188FXyvu36NboyDx/c
 PCW9YTR0MUnvKHpWfEIEtQ5UdtVtaY6/WKDk3z4cudAtkI1x8go5BDSxqZ9QIzVhaa3x
 h3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685962874; x=1688554874;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9iyTJv6hv5TVgHzcIxSZtEyIDrtGWZ6PsvH+kn0mbTI=;
 b=TL2elcJ6oIobm8EgFoPirTAWh8kWMrNCcFeTVddQbZBV14WIUCyWSpC6t3AG7Kjaqg
 pJDMPmlaP6s13BGWvlzjhQTEIHFosvdWkTyHEDj4Vuk9DAMM3SQdhWsJ+1s6nJaSMw62
 lBsqHr1Kzt8eOp9iQkXLKTENpxm33LeNJO2R4P4/pkvluDiZy6eEzI81NPSI0r6ooSQV
 BQHL6Yky+zYAuTCNqZlefqsHhPtNeKYa3iTOLtTwICPL3cz12ntYwIk0HeHsQeh5vCuh
 2uZYq2VFQLWvODiH7PV6zPq50et0boND8axBMxahjZjhkqFK3xEztiPbPipa681i6esw
 +WQA==
X-Gm-Message-State: AC+VfDxuRsLbbnHrElyS1t5Zng2GGT/SiMsYy+k1lc0GtOUlD+BcA0v6
 Ibr44nyJWRY2VQqLbOQ3NNRpbQ==
X-Google-Smtp-Source: ACHHUZ6Ysx5wvn0LxR1FHPKQZ7bm8+N4N0qwb0qb6iLO9jX47MRiE1+7rvnmC3mUG76vs1RcOmmE1w==
X-Received: by 2002:a7b:ce98:0:b0:3f6:2ee:6993 with SMTP id
 q24-20020a7bce98000000b003f602ee6993mr6473263wmj.4.1685962873732; 
 Mon, 05 Jun 2023 04:01:13 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 o10-20020a1c750a000000b003f60482024fsm10478823wmc.30.2023.06.05.04.01.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 04:01:13 -0700 (PDT)
Message-ID: <59e63ef3-830c-fab2-3186-8eea84bd7122@linaro.org>
Date: Mon, 5 Jun 2023 13:01:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 02/35] target/arm: Move aesmc and aesimc tables to
 crypto/aes.c
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
References: <20230603023426.1064431-1-richard.henderson@linaro.org>
 <20230603023426.1064431-3-richard.henderson@linaro.org>
 <bc89ede2-747f-c56e-5cca-e09289fb72f2@linaro.org>
In-Reply-To: <bc89ede2-747f-c56e-5cca-e09289fb72f2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 5/6/23 12:45, Philippe Mathieu-Daudé wrote:
> On 3/6/23 04:33, Richard Henderson wrote:
>> We do not currently have a table in crypto/ for
>> just MixColumns.  Move both tables for consistency.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/crypto/aes.h           |   6 ++
>>   crypto/aes.c                   | 142 ++++++++++++++++++++++++++++++++
>>   target/arm/tcg/crypto_helper.c | 143 ++-------------------------------
>>   3 files changed, 153 insertions(+), 138 deletions(-)
> 
> 
>>       union CRYPTO_STATE st = { .l = { rm[0], rm[1] } };
>> +    const uint32_t *mc = decrypt ? AES_imc_rot : AES_mc_rot;
>>       int i;
>>       for (i = 0; i < 16; i += 4) {
>>           CR_ST_WORD(st, i >> 2) =
>> -            mc[decrypt][CR_ST_BYTE(st, i)] ^
>> -            rol32(mc[decrypt][CR_ST_BYTE(st, i + 1)], 8) ^
>> -            rol32(mc[decrypt][CR_ST_BYTE(st, i + 2)], 16) ^
>> -            rol32(mc[decrypt][CR_ST_BYTE(st, i + 3)], 24);
>> +            mc[CR_ST_BYTE(st, i)] ^
>> +            rol32(mc[CR_ST_BYTE(st, i + 1)], 8) ^
>> +            rol32(mc[CR_ST_BYTE(st, i + 2)], 16) ^
>> +            rol32(mc[CR_ST_BYTE(st, i + 3)], 24);
> 
> Matter of style, (since you are changing these lines), I find starting
> the lines with the ^ operator clearer to review:
> 
>              mc[CR_ST_BYTE(st, i)]
>              ^ rol32(mc[CR_ST_BYTE(st, i + 1)], 8)
>              ^ rol32(mc[CR_ST_BYTE(st, i + 2)], 16)
>              ^ rol32(mc[CR_ST_BYTE(st, i + 3)], 24);

Aesthetically nicer:

                        mc[CR_ST_BYTE(st, i)]
                ^ rol32(mc[CR_ST_BYTE(st, i + 1)], 8)
                ^ rol32(mc[CR_ST_BYTE(st, i + 2)], 16)
                ^ rol32(mc[CR_ST_BYTE(st, i + 3)], 24);

:)

> Anyhow,
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>>       }
>>       rd[0] = st.l[0];
> 


