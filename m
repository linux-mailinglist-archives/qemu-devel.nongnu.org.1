Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F191B7F77D9
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 16:31:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Y8s-000516-Mj; Fri, 24 Nov 2023 10:30:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6Y8b-0004vG-4g
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 10:30:39 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6Y8Y-0005qb-GI
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 10:30:36 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40b2afd049aso14084255e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 07:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700839831; x=1701444631; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4FeMLTTF9cDZ7eRRNAJVlSJwXuVI906lL/BAvJXNtHI=;
 b=ixZTzv0cbn3cro47XdZSypoFCaT+KlNGcA1FUHBf45ywQo3QaEWIsPJK6eTL8uINln
 7atOoGEQXrDanV5HG76kLd7b8pW+/RlSL+Ig8wO0RlOy84fgYFvflbq2vW85UW/7RA9r
 ETdfWoAPRYO7MBwzbSLRdWV5jH52zthuFs+kxvzahWmDYYAFSLyOfGvf/Bd1pXIt8UWb
 RQbl8httiITJtT92iBP+JH9/gnsExjS6VUbf5TU/VcoXpmXd/YqlNAxKbzjwJsCZmt8G
 StSd6LmBC2FlrIw4UucFgkJUre67CjQq5By0gJnO3Xt8MMhoEXPyBXRqJ6Z+W4H2YrSS
 mOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700839831; x=1701444631;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4FeMLTTF9cDZ7eRRNAJVlSJwXuVI906lL/BAvJXNtHI=;
 b=eV2s21bOsRO3VAfAaURmtF030/nfE810CnI5aIPM4BQ6QkjU171c5gURN8FOAtd3cj
 A/2JlD0WURtQu3KWpF9EFdxPKPjLZrzSc8xQdQ54H7nAXTQm32tgglf3CT8vghSj1vpS
 /a6mQDFsFSwrkmbuD1UlqrCbkt4j6tGRVbBLCs+Hjxn0V7B8nouZoZYPX0tCPmXJK9M8
 lcocjXQKz/H2CBm/cKr1M+QlG+Ed6W54XEjmB8TRMJkAM5213n1lO5Yn+ZAUOWKyLI3R
 wPMpqULwhudQ7If7Bl8gFxaWB1QAEGCqZgO5ec27OZPNiIsFVNgKJXs2qZ5tLVo6W9Go
 pl9Q==
X-Gm-Message-State: AOJu0YwKAh+6g1mUoJcunEAqUsTrSz3Ulc2jdUQ15X2XEk51bUv62Tlr
 /lK64cbigDv8DodMmgvT3Q1srbKeF8/YFWtihtI=
X-Google-Smtp-Source: AGHT+IEdvKwGzQ/wXlNwk2E5C1YFSDLYQyUJLVmzBlj2vL37/sWPk9QDk4yhj0PqWgEtxUqUX2w2/A==
X-Received: by 2002:a05:600c:45cf:b0:3f6:58ad:ed85 with SMTP id
 s15-20020a05600c45cf00b003f658aded85mr2796106wmo.10.1700839830677; 
 Fri, 24 Nov 2023 07:30:30 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.17])
 by smtp.gmail.com with ESMTPSA id
 k24-20020a5d5258000000b00332d04514b9sm4513296wrc.95.2023.11.24.07.30.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Nov 2023 07:30:30 -0800 (PST)
Message-ID: <2ba80e3f-c13e-406b-a365-37841ff655b4@linaro.org>
Date: Fri, 24 Nov 2023 16:30:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sh4: Coding style: Remove tabs
Content-Language: en-US
To: xun <xun794@gmail.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-trivial@nongnu.org
References: <20231124044554.513752-1-xun794@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231124044554.513752-1-xun794@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Hi,

On 24/11/23 05:45, xun wrote:
> From: Yihuan Pan <xun794@gmail.com>
> 
> Replaces TABS with spaces to ensure have a consistent coding
> style with an indentation of 4 spaces in the SH4 subsystem.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/376
> Signed-off-by: Yihuan Pan <xun794@gmail.com>
> ---
>   linux-user/sh4/termbits.h |  204 +++---
>   target/sh4/cpu.h          |   80 +-
>   target/sh4/helper.c       |  236 +++---
>   target/sh4/op_helper.c    |   70 +-
>   target/sh4/translate.c    | 1466 ++++++++++++++++++-------------------
>   5 files changed, 1028 insertions(+), 1028 deletions(-)


> @@ -241,17 +241,17 @@ static int find_tlb_entry(CPUSH4State * env, target_ulong address,
>       asid = env->pteh & 0xff;
>   
>       for (i = 0; i < nbtlb; i++) {
> -	if (!entries[i].v)
> -	    continue;		/* Invalid entry */
> -	if (!entries[i].sh && use_asid && entries[i].asid != asid)
> -	    continue;		/* Bad ASID */
> -	start = (entries[i].vpn << 10) & ~(entries[i].size - 1);
> -	end = start + entries[i].size - 1;
> -	if (address >= start && address <= end) {	/* Match */
> -	    if (match != MMU_DTLB_MISS)
> -		return MMU_DTLB_MULTIPLE;	/* Multiple match */
> -	    match = i;
> -	}
> +        if (!entries[i].v)
> +            continue; /* Invalid entry */

Thomas, better fix the 'if { }' in this patch or a following one?

> +        if (!entries[i].sh && use_asid && entries[i].asid != asid)
> +            continue; /* Bad ASID */
> +        start = (entries[i].vpn << 10) & ~(entries[i].size - 1);
> +        end = start + entries[i].size - 1;
> +        if (address >= start && address <= end) { /* Match */
> +            if (match != MMU_DTLB_MISS)
> +                return MMU_DTLB_MULTIPLE; /* Multiple match */
> +            match = i;
> +        }
>       }
>       return match;
>   }
> @@ -265,7 +265,7 @@ static void increment_urc(CPUSH4State * env)
>       urc = ((env->mmucr) >> 10) & 0x3f;
>       urc++;
>       if ((urb > 0 && urc > urb) || urc > (UTLB_SIZE - 1))
> -	urc = 0;
> +        urc = 0;
>       env->mmucr = (env->mmucr & 0xffff03ff) | (urc << 10);
>   }


