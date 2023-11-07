Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A6C7E3436
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:31:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CnY-0003tC-6J; Mon, 06 Nov 2023 22:30:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CnU-0003rP-PN
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:30:36 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CnQ-0005pd-WB
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:30:34 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5bdc185c449so22085a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699327831; x=1699932631; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o5OTK/lIZ+dby0LDXWe1fJLhC11Q9mdBBrC0HkmFsaI=;
 b=Optvy3hkpYvV7HJ291ZV0oUHkhWbhEF49oTLfp1Q7ZQhQ0aIPNsI++IrvRGcqIDfGi
 dASIJEfaThVFIaFhg90EjSlf7px7ePRfJNvqtTFYYuKUY1HgHTKFITN3MQ8yuRNookDR
 VTtD2xvIxSzIA6uYwgxzLFJusw/G/MRIzvHewnnJ8qheeuj88Kj1gTd64dmLF1/yFWZp
 TGPCURLcrWLipcnz89Kmkp2nU+xKzzmOrPCWqQibC94sqPNkKzMF3LdyGAXQIvBC28k/
 t08ZcXMdV1uQ9xcMCLTSS/um+7aJ0dr7JIp5iQC/BF6dIm7ivVBZawFy5P2BCqayKlyX
 iLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699327831; x=1699932631;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o5OTK/lIZ+dby0LDXWe1fJLhC11Q9mdBBrC0HkmFsaI=;
 b=qAK652tJfHPVK3fGFRcx6Pbl9otvNv+ruNcwsNikNgD+jq75TLu9E12SCJTxGbHq5I
 kp0hcNADDtYaqjPnSF1VicEswj1/OOw+FRAUWfEmJxErVdZ2kFlulySKXi1kemN6Sm2I
 kY+ZN097wD9Z2ehOyUdyoNSfrcsbVabd9CCx7Wy3Z1lBNxfvPtpsO/Cbm+PExOMi+ZL2
 b1ladiGMZeeykG0TWJD1IoIUcnV8otyBFy0bLl1Fzgd+eGyqBfh8jpAEUYb3H1L+U9Z2
 yHl7zZRAN9/rSnCS6vVVHtkQcabzGxbESHJ+WTeEwYOEuZk/jxE+9BhZMMRwMyaw7SFN
 8LGA==
X-Gm-Message-State: AOJu0YxSR33hHMV6RXDtg8tNaZEIwnFiAdPC3sDlbSmASrJuS9kTeKRJ
 nuGppi7/OrtiTzJTebXzGoqYVQ==
X-Google-Smtp-Source: AGHT+IHJrAcfSDKGvrc8sYlGTZyTsykwKW2bZ81B1quN2B38ap86s4xmYfNGOW3e9UuhYAHpE8xtkA==
X-Received: by 2002:a05:6a21:9994:b0:15e:dc75:66a7 with SMTP id
 ve20-20020a056a21999400b0015edc7566a7mr30799597pzb.24.1699327831582; 
 Mon, 06 Nov 2023 19:30:31 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a17090ace9200b0027df62a9e68sm6091378pju.13.2023.11.06.19.30.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 19:30:31 -0800 (PST)
Message-ID: <ea4f85b8-873f-43c1-8d35-c0b21164f184@linaro.org>
Date: Mon, 6 Nov 2023 19:30:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/22] target/arm: hide all versions of DBGD[RS]AR from
 gdbstub
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
 <20231106185112.2755262-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231106185112.2755262-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 11/6/23 10:50, Alex Bennée wrote:
> This avoids two duplicates being presented to gdbstub. As the
> registers are RAZ anyway it is unlikely their value would be of use to
> someone using gdbstub anyway.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20231103195956.1998255-5-alex.bennee@linaro.org>
> ---
>   target/arm/debug_helper.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
> index 79a3659c0c..dc783adba5 100644
> --- a/target/arm/debug_helper.c
> +++ b/target/arm/debug_helper.c
> @@ -937,14 +937,14 @@ static const ARMCPRegInfo debug_cp_reginfo[] = {
>        */
>       { .name = "DBGDRAR", .cp = 14, .crn = 1, .crm = 0, .opc1 = 0, .opc2 = 0,
>         .access = PL0_R, .accessfn = access_tdra,
> -      .type = ARM_CP_CONST, .resetvalue = 0 },
> +      .type = ARM_CP_CONST | ARM_CP_NO_GDB, .resetvalue = 0 },
>       { .name = "MDRAR_EL1", .state = ARM_CP_STATE_AA64,
>         .opc0 = 2, .opc1 = 0, .crn = 1, .crm = 0, .opc2 = 0,
>         .access = PL1_R, .accessfn = access_tdra,
>         .type = ARM_CP_CONST, .resetvalue = 0 },
>       { .name = "DBGDSAR", .cp = 14, .crn = 2, .crm = 0, .opc1 = 0, .opc2 = 0,
>         .access = PL0_R, .accessfn = access_tdra,
> -      .type = ARM_CP_CONST, .resetvalue = 0 },
> +      .type = ARM_CP_CONST | ARM_CP_NO_GDB, .resetvalue = 0 },
>       /* Monitor debug system control register; the 32-bit alias is DBGDSCRext. */
>       { .name = "MDSCR_EL1", .state = ARM_CP_STATE_BOTH,
>         .cp = 14, .opc0 = 2, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 2,
> @@ -1065,9 +1065,9 @@ static const ARMCPRegInfo debug_cp_reginfo[] = {
>   static const ARMCPRegInfo debug_lpae_cp_reginfo[] = {
>       /* 64 bit access versions of the (dummy) debug registers */
>       { .name = "DBGDRAR", .cp = 14, .crm = 1, .opc1 = 0,
> -      .access = PL0_R, .type = ARM_CP_CONST | ARM_CP_64BIT, .resetvalue = 0 },
> +      .access = PL0_R, .type = ARM_CP_CONST | ARM_CP_64BIT | ARM_CP_NO_GDB, .resetvalue = 0 },
>       { .name = "DBGDSAR", .cp = 14, .crm = 2, .opc1 = 0,
> -      .access = PL0_R, .type = ARM_CP_CONST | ARM_CP_64BIT, .resetvalue = 0 },
> +      .access = PL0_R, .type = ARM_CP_CONST | ARM_CP_64BIT | ARM_CP_NO_GDB, .resetvalue = 0 },
>   };
>   
>   static void dbgwvr_write(CPUARMState *env, const ARMCPRegInfo *ri,


