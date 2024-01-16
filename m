Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0FA82F881
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 21:46:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPqJJ-00018G-DT; Tue, 16 Jan 2024 15:45:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPqJD-00016f-3t
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 15:45:20 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPqJA-0005TW-Ms
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 15:45:18 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5cf450eba00so3385295a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 12:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705437914; x=1706042714; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FErWQ+Oye109Xl0oH0FL/2XSBcWcxV4zW+oUudPTMQk=;
 b=WCbVAS/rEwDtA5q/uFge0FOKZwNnEac7ccllya213oCmf3fQZppFqzMwfMfb2qtH2U
 zIv0W7LSUMg7y/MSUwDenByn32ZPxK/+4yFFaMiF3tr/DQDe3wNitobbZYQDZ8BpsOwn
 ca8aYmPrmZvNVIVtKoTleefLOYMKKgGzZsdCczyKq3Ovtfi5OL70LKLF8l7eagOnPnkG
 hEhJz1q5Ua3iQjk/H/W+mnYkzpAwabTBf3443J4tyOJIDYqCeGDZ+em0SEs5Mk3xvqzn
 o0SE0In/35WEm/SymicLs3is+Buu9Tc4fmDyhmr/lv1sBobdnUl06/sw8IRbFbNMa4nU
 49Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705437914; x=1706042714;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FErWQ+Oye109Xl0oH0FL/2XSBcWcxV4zW+oUudPTMQk=;
 b=ror4BKQb0EVniOW3/nMg0BvryUtgYSYjgeD4yO4gFwOTm4r8a07PJPVeQRK1QZiMlk
 BQCw+aC482yh9bhA3gBpt8TUxFmwfS6FqK7tDO3T0ZKguFxGQinCzf/A/j1bA9KSFHY5
 dlKjrVckM3Hs3KCBR4ii+wY640ADqbO6P3+FSQ43RNguOIdDR+buSiwLyUQJV19SIh4D
 fBUmwbTeeGWnWgkcqJ9KAFZMF8LpAtlY0veXFB+XOF51y6cyvQAuwYuxV2xOkzD9TRjX
 umQtpJI4W+C3DAxLg5XG3IjCad/ZfKafFINSGnT2vSKbTPYBJZflGeGA/V1EUB8i+hMv
 9YPA==
X-Gm-Message-State: AOJu0Yx/xxJZu5b3o6apRuqel7jUP05GFdZpo3QVJN5iK9GZr20dqFZK
 jBiqOtOHNvOiIUvyTQ75wmwdcRE7J3xXHg==
X-Google-Smtp-Source: AGHT+IFJhHOJHfJBcscJKlGJYMnafHE7vexFblql3fXjMg/cx5PqtBAcFNQa5vol0h0ZizB7fpvLAw==
X-Received: by 2002:a05:6a20:9f8b:b0:19a:f27b:a7f7 with SMTP id
 mm11-20020a056a209f8b00b0019af27ba7f7mr4550150pzb.119.1705437914456; 
 Tue, 16 Jan 2024 12:45:14 -0800 (PST)
Received: from [192.168.68.110] ([152.234.123.64])
 by smtp.gmail.com with ESMTPSA id
 x63-20020a626342000000b006da0f15b31csm6344pfb.97.2024.01.16.12.45.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 12:45:14 -0800 (PST)
Message-ID: <2a1cca79-6b5b-4d64-8d7c-d1c9243a9ee6@ventanamicro.com>
Date: Tue, 16 Jan 2024 17:45:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] target/riscv/vector_helper.c: use vlenb in
 HELPER(vsetvl)
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com
References: <20240115222528.257342-1-dbarboza@ventanamicro.com>
 <20240115222528.257342-9-dbarboza@ventanamicro.com>
 <3920915d-3ee8-4dbb-9d39-820b7abf273d@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <3920915d-3ee8-4dbb-9d39-820b7abf273d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 1/15/24 19:57, Richard Henderson wrote:
> On 1/16/24 09:25, Daniel Henrique Barboza wrote:
>> Use the new 'vlenb' CPU config to validate fractional LMUL. The original
>> comparison is done with 'vlen' and 'sew', both in bits. Adjust the shift
>> to use vlenb.
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/vector_helper.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
>> index cb944229b0..9e3ae4b5d3 100644
>> --- a/target/riscv/vector_helper.c
>> +++ b/target/riscv/vector_helper.c
>> @@ -45,9 +45,13 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>>                                               xlen - 1 - R_VTYPE_RESERVED_SHIFT);
>>       if (lmul & 4) {
>> -        /* Fractional LMUL - check LMUL * VLEN >= SEW */
>> +        /*
>> +         * Fractional LMUL: check VLEN * LMUL >= SEW,
>> +         * or VLEN * (8 - lmul) >= SEW. Using VLENB we
>> +         * need 3 less shifts rights.
> 
> The last sentence is structured oddly.  Perhaps
> 
>    Using VLENB, we decrease the right shift by 3
> 
> or perhaps just show the expansion:
> 
> /*
>   * Fractional LMUL, check
>   *
>   *    VLEN * LMUL >= SEW
>   *    VLEN >> (8 - lmul) >= sew
>   *    (vlenb << 3) >> (8 - lmul) >= sew
>   *    vlenb >> (8 - 3 - lmul) >= sew
>   */

Just changed the comment to show the expansion. Thanks,


Daniel

> 
> Anyway,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> r~
> 
> 
>> +         */
>>           if (lmul == 4 ||
>> -            cpu->cfg.vlen >> (8 - lmul) < sew) {
>> +            cpu->cfg.vlenb >> (8 - 3 - lmul) < sew) {
>>               vill = true;
>>           }
>>       }
> 

