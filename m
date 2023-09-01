Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD67A790124
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 19:07:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc7bE-0002yO-9G; Fri, 01 Sep 2023 13:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qc7b6-0002li-Pv
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 13:06:16 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qc7b1-0002aB-Sx
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 13:06:16 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-563f8e8a53dso1556788a12.3
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 10:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693587970; x=1694192770; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KtxwzhYrd+4Ed/IH4pKYyJKaCBHgPX0diDnGtGepIE4=;
 b=X/vhl2Jm/SQJzzFV22hqFsfVhi8jxYpGDFP3fgPTifXuF0pQ0HH6yiWqwr9cxcogDq
 6yW/vbBT0R857tENeV1zyKG/VMKJVVWINWacekMRS3cPBBwiLBevQDCVuZ4nGXzBlIzr
 ZNNoqeslMqxDJi7yNOT7UkrBPyejZ0A0E2laHoiSd673xh1sPxJ3cukejGt3uo300ti+
 QRfhyq4xL6kJU7gT7o/Oo0W8vtRQpyvdbvSi4/lksoLgXen/r/a+8PGm6LGeR0PhD6UU
 pNEwaOePPHjV1HP9TQbF4sRyreTU23OTqRVxfi3mXKuRk72bDr8VH1bzhDo7VggmtK7C
 3gIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693587970; x=1694192770;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KtxwzhYrd+4Ed/IH4pKYyJKaCBHgPX0diDnGtGepIE4=;
 b=H0lReiEo29ythJG32XwXtiQupX8HIObNt9S5gM+Xp4WGbq3ukH1rTClq+IeBkudwbL
 g7VzIZM4kYTeJM3XQj2KXh6TrNIGesE0IPfivBPiWxUxWAy+nMbvy8ym+YOe/TG6jPdF
 blBquCSyUvKjtc043JPiOvrcItldGwJlPjDQz4KhDgVwW5ClAAO/kXRFyIDOnEYrj2K3
 qGgzaQ9ujYronD1hx3etxQfj5++EwJhS/lm0sCcwKdUZW+jSg7xw09nTgdtpCHkTQBO8
 oFCg0VPdfXuIa4cfnWol+BEL5OSIKxUaLjPTKVWrpuURWfLiVkLLQzAFJu2ajn84LCS7
 ln6g==
X-Gm-Message-State: AOJu0Yw8qbTHFM5rbxudedrUCgSjIpV6KaF2uPjADVHkJddPvBKQOwqq
 vtsmxUJ/jFRHbTc/2+W4De9ZXvbLtSU1bflnzkM=
X-Google-Smtp-Source: AGHT+IEGcpahjvB39HrTCW/hsKGEBFmF5ZNEDHn0JcxyI2juYhmtwshVb99k1T7cpJLlNdE2n73KkQ==
X-Received: by 2002:a17:90a:d916:b0:26b:1364:e784 with SMTP id
 c22-20020a17090ad91600b0026b1364e784mr2929145pjv.0.1693587970184; 
 Fri, 01 Sep 2023 10:06:10 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 fw13-20020a17090b128d00b0026d4100e0e8sm3239603pjb.10.2023.09.01.10.06.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Sep 2023 10:06:09 -0700 (PDT)
Message-ID: <1a6cf366-bc54-d402-f2f9-ada981d5ca75@linaro.org>
Date: Fri, 1 Sep 2023 10:06:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 01/14] tcg/loongarch64: Import LSX instructions
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, git@xen0n.name
References: <20230901093258.942357-1-c@jia.je>
 <20230901093258.942357-2-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230901093258.942357-2-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 9/1/23 02:30, Jiajie Chen wrote:
> Add opcodes and encoder functions for LSX.
> 
> Generated from
> https://github.com/jiegec/loongarch-opcodes/tree/qemu-lsx.
> 
> Signed-off-by: Jiajie Chen<c@jia.je>
> ---
>   tcg/loongarch64/tcg-insn-defs.c.inc | 6251 ++++++++++++++++++++++++++-
>   1 file changed, 6134 insertions(+), 117 deletions(-)
> 
> diff --git a/tcg/loongarch64/tcg-insn-defs.c.inc b/tcg/loongarch64/tcg-insn-defs.c.inc
> index b5bb0c5e73..ee3b483b02 100644
> --- a/tcg/loongarch64/tcg-insn-defs.c.inc
> +++ b/tcg/loongarch64/tcg-insn-defs.c.inc
> @@ -4,7 +4,7 @@
>    *
>    * This file is auto-generated by genqemutcgdefs from
>    *https://github.com/loongson-community/loongarch-opcodes,
> - * from commit 25ca7effe9d88101c1cf96c4005423643386d81f.
> + * from commit 8027da9a8157a8b47fc48ff1def292e09c5668bd.
>    * DO NOT EDIT.
>    */
>   

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

