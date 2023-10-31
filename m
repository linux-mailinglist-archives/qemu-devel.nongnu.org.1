Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BBC7DCEC7
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:09:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpQ7-0007ng-C3; Tue, 31 Oct 2023 10:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxpQ3-0007mF-70
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:08:37 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxpPz-0003Hq-Jd
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:08:33 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6bf03b98b9bso4915149b3a.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698761310; x=1699366110; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DRjBWf6bHMPR3RkpPgDb61jJ3A0hzo0if24G0b5t9UI=;
 b=GvqIOVjMDVH2AIGt9Rk6HqBTmRg7ANtx6/olk+ktR6XoszyaDEjcyEq8zQHBe6RFAm
 MKzyU6pnJnHmZfdjTBERmGNSBto7xRJS5BDOfnMk/layjxLsyMgWGVbntQwGyvcz3ync
 17jEIPE5niFmhxmPyKWbNBQhJUrAvKb4XVe4b3Y5kXtnhg1SYqrKmCN50zWh1RIGRiql
 BjE3/0lhGjYiyZ5JBEwQwxTUuVkHUrQOmflbTn/lGt/PnjA7xr1bwz67T3v4vm9OHUFG
 HqjJnDCT3G5SFSmrL5z//idlE4rgG2Tnf5f8AhKzXS6QQQedMolB0YGyIb7XtTC8sJOL
 v/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698761310; x=1699366110;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DRjBWf6bHMPR3RkpPgDb61jJ3A0hzo0if24G0b5t9UI=;
 b=ClEn66YDE65leggr/mW6yX406HCWnZKVllULrvjpx6fFg+34PMeb4iRT44Aozn0IVv
 upmf2Kkjqsgr7es8jQL1hF92OIDAP/f5YrQ0NQ4OGN3lTFxoEB46oCadNGFjjPjPIPjp
 GC8XvGGZdpHbussaTUGkRUTWqbFBMUa3prczUtX2hFwyLeqR65bTR1lXjFKgxmr6UvvK
 S4GLtCyGKpknmhZwD3O4v9mvG/bgnPej6atuzm2EDEHFKNziB9l1YP4QMiMCFDAeyvjY
 l6XdzA6GkmmNbnjWeiz0H6J+lerZ0nJmBICD96dbucogE0nJFP02/IEZEPt1srRIY/72
 eeew==
X-Gm-Message-State: AOJu0Ywi2yDycCurwnFIEppVMtDa+Cau1jzTrXoTpYcVyoHKEnsIXiI4
 KCbkc4Ui8XObXlMHnz3hspG9eg==
X-Google-Smtp-Source: AGHT+IGqx1xcyUF8USIgs5eULlguwBcu3Uoz8bYdUHARYr13j271uzkZJEmjIfkR/kdLllvjmYvpmw==
X-Received: by 2002:a05:6a20:e106:b0:128:ffb7:dcfe with SMTP id
 kr6-20020a056a20e10600b00128ffb7dcfemr3711831pzb.1.1698761309908; 
 Tue, 31 Oct 2023 07:08:29 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 k20-20020aa788d4000000b0068fbaea118esm1293772pff.45.2023.10.31.07.08.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 07:08:29 -0700 (PDT)
Message-ID: <c0479a28-1e95-480a-abaf-faf8ee12743e@linaro.org>
Date: Tue, 31 Oct 2023 07:08:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Fix SVE STR increment
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-stable@nongnu.org
References: <20231030190354.94671-1-richard.henderson@linaro.org>
 <CAFEAcA_kG-yE9sYDx+QBxCoAMySjc57oXx+UtSo=p=nCqAwKfQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_kG-yE9sYDx+QBxCoAMySjc57oXx+UtSo=p=nCqAwKfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 10/31/23 03:52, Peter Maydell wrote:
> On Mon, 30 Oct 2023 at 19:04, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> The previous change missed updating one of the increments.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: e6dd5e782be ("target/arm: Use tcg_gen_qemu_{ld, st}_i128 in gen_sve_{ld, st}r")
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/tcg/translate-sve.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
>> index 7b39962f20..fc4220114d 100644
>> --- a/target/arm/tcg/translate-sve.c
>> +++ b/target/arm/tcg/translate-sve.c
>> @@ -4294,7 +4294,7 @@ void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
>>           t0 = tcg_temp_new_i64();
>>           t1 = tcg_temp_new_i64();
>>           t16 = tcg_temp_new_i128();
>> -        for (i = 0; i < len_align; i += 8) {
>> +        for (i = 0; i < len_align; i += 16) {
>>               tcg_gen_ld_i64(t0, base, vofs + i);
>>               tcg_gen_ld_i64(t1, base, vofs + i + 8);
>>               tcg_gen_concat_i64_i128(t16, t0, t1);
>> --
> 
> This fixes the test case I have for vector lengths of 64 bytes
> and below, but vector lengths above that (eg 128 bytes) still
> misbehave in a different way (only every other set of 8 bytes
> gets stored). Presumably that's a different bug somewhere else?

Oh yes -- enable-debug yields

qemu-aarch64: ../src/tcg/tcg-op-ldst.c:712: tcg_gen_qemu_st_i128_chk: Assertion `(memop & 
MO_SIZE) == MO_128' failed.


r~


