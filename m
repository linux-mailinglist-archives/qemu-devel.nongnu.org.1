Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 452EB8282CF
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 10:16:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN8Cj-0001Zp-1e; Tue, 09 Jan 2024 04:15:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rN8Cf-0001Z4-4R
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 04:15:22 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rN8CQ-000129-EP
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 04:15:19 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d4df66529bso11269445ad.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 01:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704791705; x=1705396505; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=54PAqVq38uSKLCR34SXsNk+dULxGop0vogK87KpFk28=;
 b=mBAWvoQrJxg5NqTNVU2hcfuGKXITz50JlQ9eFq4tK+iGIp0Yyc8jBaAzhS0KYGXGA3
 lz3VPaN16XhIILoJGBLrl2t2Ti0v6MyG+AH6DPl/NhUMQ4jJa/j2FEYyHdT+uu96kYvx
 TJKfjNyWv/HM/jhg4yIoaVxMoZvDJ8NfXXVZD8gtxQXmUkrU5EkUHLdjJgD5z3wJ8TZo
 hjyGR+trrmc01zaR+Kp5ad4uoKVM6xXJ8kWUzE1NYFj5YiC6z4u2JQLdEodW+uqIyVZV
 NbrfTVRE5IXvsXo7NW8NNzYZeAv26RqAroMnWDRHqhMfhGMN6XkBKHcJeMcj8PfVdyNE
 mlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704791705; x=1705396505;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=54PAqVq38uSKLCR34SXsNk+dULxGop0vogK87KpFk28=;
 b=fwCTTkAmTfImMpeb0ODNuYMlpyslfCXz6Z2IiqMd9dHl353ZHV3BdgcuNB+z1nMYRs
 59/SZXx6Mi5sOpMmN6rNZQRe98UQq6usAbL0K0HEHjogFnnB4kGgaSg/HRjh8KomeciW
 iltBx66qMsaoGkjzZ1tP18KZq66YXKOM/vvPqDrdAyPVaaKdFM3rWtxR7ZywzolYKD+X
 0qcA4cuKt0N3i2hXyXZm0CqkySxhVs4wIpf/pSP66kHl3xji9bfA/9qrlNg20G9HRDgo
 yfIoi5iyeCPx/EeIerVonvaXvdfHcDTPkGkmVRQcInbldSBHRbCpNuQ7WYtFHq5uAKXt
 WpPw==
X-Gm-Message-State: AOJu0YylQo0uV++446o1yalQnp+7RYig4GUuJOusGXAF3Rp+lMWFG8B/
 ybdYVMY05MtGh+H0/d21Kk19xB2QuFTB5A==
X-Google-Smtp-Source: AGHT+IEzpqqToldYQm62qGn/NglAm7+7f6TD89ay4zZE5hbyUHhj+LHibEWS/I2/01aheF29HCL0Fw==
X-Received: by 2002:a17:903:1109:b0:1d4:af6c:bb16 with SMTP id
 n9-20020a170903110900b001d4af6cbb16mr2561933plh.96.1704791704711; 
 Tue, 09 Jan 2024 01:15:04 -0800 (PST)
Received: from [192.168.40.227] ([172.58.27.248])
 by smtp.gmail.com with ESMTPSA id
 s1-20020a170902b18100b001d395d3df30sm1280694plr.130.2024.01.09.01.14.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 01:15:04 -0800 (PST)
Message-ID: <48cc72dd-bf52-4cd2-a5e1-d7d1a7e08dd1@linaro.org>
Date: Tue, 9 Jan 2024 20:14:29 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] target/hppa: Fix PDC address translation on PA2.0
 with PSW.W=0
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Bruno Haible <bruno@clisp.org>,
 "Nelson H . F . Beebe" <beebe@math.utah.edu>, Helge Deller <deller@gmx.de>
References: <20240107132237.50553-1-deller@kernel.org>
 <20240107132237.50553-5-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240107132237.50553-5-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
> Fix the address translation for PDC space on PA2.0 if PSW.W=0.
> Basically, for any address in the 32-bit PDC range from 0xf0000000 to
> 0xf1000000 keep the lower 32-bits and just set the upper 32-bits to
> 0xfffffff0.
> 
> This mapping fixes the emulated power button in PDC space for 32- and
> 64-bit machines and is how the physical C3700 machine seems to map
> PDC.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   target/hppa/mem_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
> index 08abd1a9f9..011b192406 100644
> --- a/target/hppa/mem_helper.c
> +++ b/target/hppa/mem_helper.c
> @@ -56,7 +56,7 @@ hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr)
>           addr = (int32_t)addr;
>       } else {
>           /* PDC address space */
> -        addr &= MAKE_64BIT_MASK(0, 24);
> +        addr = (uint32_t)addr;
>           addr |= -1ull << (TARGET_PHYS_ADDR_SPACE_BITS - 4);
>       }
>       return addr;

I believe this to be incorrect, as it contradicts Figures H-10 and H-11.


r~

