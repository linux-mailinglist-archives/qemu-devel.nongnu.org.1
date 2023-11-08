Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE1F7E5F89
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 21:58:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0pcj-0007Cn-4D; Wed, 08 Nov 2023 15:58:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0pch-0007CC-4L
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 15:58:03 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0pcf-00069Q-IU
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 15:58:02 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1cc2575dfc7so736025ad.1
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 12:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699477080; x=1700081880; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5Fc/YCJJtF736gSI69JJzXqhwId4pfdAwfgkUona22o=;
 b=WbGWU+WGiiABZJwTAhmCZ8QFLapnCyjEBSZ02KHg295i1CBmIZhMYc27XaqHAAENHk
 XqLxXo93ZJKIYy+TgR2ZqQBTRxxIMTo/oP3CRzzmouqwg5buC0HPG7M2gKhC/bc9/6Sq
 PtVZNPNkdGnx/oY/Pd0T2y8HBTHknAr8RiVWU8FAZpgrHvHbuZ9Jl5AacIuT2X6gkWnL
 PSNseljZXFWrQOFX4FdYnDG1In/fhDcuE/C0Z3aYrH3igFlglJYskF6Wbber3Afc5C3T
 Tjpdzz38flpI2UoKt4B/CW855h4UbjR9bkBcGaqEProoi25lQdZSSFC16zoFXLqmRA5K
 T1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699477080; x=1700081880;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5Fc/YCJJtF736gSI69JJzXqhwId4pfdAwfgkUona22o=;
 b=YR1G2BwPZzVCRYHUnTetaxFyv1g1HmTFb2ddrnRkuqXIsskn6l5FlVyuVsmMVz94Ku
 /7f/+kPVCvFKjvErhVPB4t0ConEf2Hzj76dzeUbuRXox4Lw4YisqgsqOJtJwHXdlM1AM
 JQK03lU1cTPeIB5e5a6TVVySXfcgqF23tQbw01DDown9Q/DJvOTXLolguRj+5/3QuwYs
 qkJ228acRpvsp2FejogVRkxVOBsv+vcv7/k4hDZRiCMIOGGmkqMAinL6EJDaXB7U6YwS
 ZFqDogsCPcP9ivFakGxUIa4Hkes4EJBOWFux6FSu+Sz5i3yxPd/SVHaZeTrU+ishlwcY
 +iqA==
X-Gm-Message-State: AOJu0YyUMnmwlrNCDulS236lmHYZfqaV6OITdH6AL1/7XNbV7H2m6HkZ
 KeYDbt9iNEcMIGaI9cZLfd+ryA==
X-Google-Smtp-Source: AGHT+IGFFdbyK+kFg4OAmcX0Wv1V/3Qmo5uYXGhIV4i5ioNHylFAZnpgWgpNhhn368GITJQMvtMcxg==
X-Received: by 2002:a17:903:230d:b0:1cc:4ffb:26f4 with SMTP id
 d13-20020a170903230d00b001cc4ffb26f4mr3904877plh.1.1699477080041; 
 Wed, 08 Nov 2023 12:58:00 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 jb17-20020a170903259100b001c755810f89sm2130449plb.181.2023.11.08.12.57.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 12:57:59 -0800 (PST)
Message-ID: <88ca96c2-36d0-4183-b17a-c472b167d74a@linaro.org>
Date: Wed, 8 Nov 2023 12:57:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/35] tcg/sparc64: Hoist read of tcg_cond_to_rcond
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-21-richard.henderson@linaro.org>
 <d5e502b0-2175-4c66-87f6-1e581b4612fb@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <d5e502b0-2175-4c66-87f6-1e581b4612fb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/6/23 13:02, Philippe Mathieu-Daudé wrote:
> On 28/10/23 21:45, Richard Henderson wrote:
>> Use a non-zero value here (an illegal encoding) as a better
>> condition than is_unsigned_cond for when MOVR/BPR is usable.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/sparc64/tcg-target.c.inc | 25 ++++++++++++++-----------
>>   1 file changed, 14 insertions(+), 11 deletions(-)
>>
>> diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
>> index ac86b92b75..e16b25e309 100644
>> --- a/tcg/sparc64/tcg-target.c.inc
>> +++ b/tcg/sparc64/tcg-target.c.inc
>> @@ -620,7 +620,7 @@ static const uint8_t tcg_cond_to_bcond[] = {
>>       [TCG_COND_GTU] = COND_GU,
>>   };
>> -static const uint8_t tcg_cond_to_rcond[] = {
>> +static const uint8_t tcg_cond_to_rcond[16] = {
> 
> 
>> -static void tcg_out_movr(TCGContext *s, TCGCond cond, TCGReg ret, TCGReg c1,
>> +static void tcg_out_movr(TCGContext *s, int rcond, TCGReg ret, TCGReg c1,
> 
> Isn't rcond unsigned?

Yes, though it is in [0-7], so it doesn't matter.


r~

