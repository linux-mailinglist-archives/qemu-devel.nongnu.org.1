Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DD28283A7
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 11:06:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN8zO-0000WF-Vi; Tue, 09 Jan 2024 05:05:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rN8zM-0000Vp-P0
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 05:05:40 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rN8zL-0000aj-2Y
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 05:05:40 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5cdfed46372so2035555a12.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 02:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704794737; x=1705399537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HU9TEeBHnGB2xq6H1VbNgT+CnUA/bADQypHUNVfQJBM=;
 b=G1nHhESQQCi/EQYb2iRDUYzyQKptEgKzKXcwRs3WiALRTFBB6nDPs/yBshBU09ZjMI
 Gr/l7grvHCnURUQcCK5OzErq2eb/q3u6TpvvLS1xVkmAal0TeySEIJ/qjhrOXzZS2oYz
 7yYODA2ptdVF41ZpKstd1lIcHCxVDs739Kr91kWqUcB67V1lj2owehRdwXqdOJqM/cYC
 lZc5QSJOUCu4WI7egnxI3Wj5eXtfcAxIi01pi9DaugKHTTqo9P8/cv2vmpA2YybHs9Dz
 +CuykLQYTOlbigr0GOCVXsH9zQnIdl3KPEMhoMaENVstp+xl3fzHN+hf5WGq/gdaNPE3
 2SGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704794737; x=1705399537;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HU9TEeBHnGB2xq6H1VbNgT+CnUA/bADQypHUNVfQJBM=;
 b=EBLo0unmU/+5hOKsvRxybvVQeGH5TY8l2HOShb4RoMBBEncAjUN5SCVUsrP0LfIJWQ
 rD/wmCS8uxVo+3e3tdRCxnb03Mz11CQ8wBanG+mO/cnSBapNVB69TF6pPFJ6MEVb30KR
 jGYteFk68tVKx7f5rGh+1xo9651yLk/a47Q8K7ziQ89p+D0FpsAy7Dxm9Oql5OHYCqJj
 2TjIr4Jdm/axq1ilrEyW4WocuhTqofWlKdTsfESB61zWwINtyKdQyUhA5ugVdDZh7U8x
 v7UFbJRckOyAMjIMxxFOZktxsfBxzCiZsCfTGjYI6gOxBXlU4iz40Unzg/JgpT/GFN9K
 zoXQ==
X-Gm-Message-State: AOJu0Yzz6Nm+4mzRA4q7SyW0bXrsMyyr+gOMbxFA/r4VCad7a4HkaaaB
 3df+1T9N9FLAlBFuUAQV1M7i6WNbtpUBvkxXMHebqviYuv8XOg==
X-Google-Smtp-Source: AGHT+IFp8UTwd3/14CsRK0fzU3s87XEk/+9R4cMhlD2372fFhHl24lqQzHKEvAtcuvBLtZmwpg+wPQ==
X-Received: by 2002:a05:6a20:1a88:b0:196:1a6b:4604 with SMTP id
 ci8-20020a056a201a8800b001961a6b4604mr4384266pzb.97.1704794737438; 
 Tue, 09 Jan 2024 02:05:37 -0800 (PST)
Received: from [192.168.40.227] ([172.58.27.248])
 by smtp.gmail.com with ESMTPSA id
 t3-20020a62d143000000b006d9a42f25b2sm1335766pfl.201.2024.01.09.02.05.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 02:05:36 -0800 (PST)
Message-ID: <679c70ac-b25f-45e3-a74f-64e322ce886c@linaro.org>
Date: Tue, 9 Jan 2024 21:05:31 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] target/hppa: Strip upper 32-bits of IOR on
 unaligned access error
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Bruno Haible <bruno@clisp.org>,
 "Nelson H . F . Beebe" <beebe@math.utah.edu>, Helge Deller <deller@gmx.de>
References: <20240107132237.50553-1-deller@kernel.org>
 <20240107132237.50553-7-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240107132237.50553-7-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 1/8/24 00:22, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Limit IOR to the lower 32-bits on failure.
> Keep patch short for easier backporting.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   target/hppa/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index 04de1689d7..3c384d5855 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -112,7 +112,7 @@ void hppa_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>       cs->exception_index = EXCP_UNALIGN;
>       if (env->psw & PSW_Q) {
>           /* ??? Needs tweaking for hppa64.  */
> -        env->cr[CR_IOR] = addr;
> +        env->cr[CR_IOR] = (uint32_t)addr;
>           env->cr[CR_ISR] = addr >> 32;
>       }
>   

Likewise, might need raise_exception_with_ior.

r~

