Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E429F82C6E6
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 22:55:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOPU2-0001CV-Pp; Fri, 12 Jan 2024 16:54:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOPTe-0001AJ-Tb
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 16:54:11 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOPTd-00072q-3Z
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 16:54:10 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6d9cb95ddd1so3304626b3a.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 13:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705096447; x=1705701247; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N2zEPU8k8AZ7BpX2EVGgq+440JjAeufV3MLBUjA9Aqc=;
 b=WFwM/BtwRIp5uyQGatnR3/wYyAt0YNmBN/7hVcyDsrG6X2MstG9Vbtg+KoUcxyOgEj
 RgZorFujlMxkbyP2FEFyWt7THoiYWoN3WJVCS7zJZtyHzMFUGP+ne70EnIU0tzV8lMGt
 gDj/d8nP3k0qp0mw743++m5ara40uToxoTLPvuBrbrtosaHf9/ROztlUM8FqZoOjY2GD
 bXh3Jlz5km1W/26fvXju8D0S+8aF1GhCrU7bLk3/cjwclXlfw4Yg2ujEmgkwsx2fJ18S
 VuVBJhb+VJpKwboJGRZGfXOEmFq7uZviaMvFl9Ic5oRyZvkfvbJgWGRFiC9AZIgOcRYI
 IX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705096447; x=1705701247;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N2zEPU8k8AZ7BpX2EVGgq+440JjAeufV3MLBUjA9Aqc=;
 b=VCBJ1jNrV9TGXuGZlKkCKfA3boTT/CxCZ5Lv4WGwfIvj0DKnlq9kDkYhgeJDHS0cLo
 5GH34yVQYkulN/gUVkvayQYOn4KXow+CByzhkFlmQxlB3u4iIFxqBpwJMFN5Cp8/IoQM
 4qAwpBPRYWl8cKVUf2aVE6iYqc5m4lWdLLBQnCGfkXEOkbr5Ok659UtRZplrAENhrLl4
 y5mYoULSRm160oW5AjW1swyy0uop2UVq7+akDlZHXPeI1cV6bDcjAO3jWhQXuOUyzhHe
 sJNtZDcX8txZIgymBud1ZLMEi777yWfdsCalWLW6kUXpJHdOlJcXnOeIiufv12pNDX0Q
 I2lA==
X-Gm-Message-State: AOJu0Yywe0cJj17ECDyiFcKOHxM3L3XqgsMd9OC4PF4HjEx0eIm9CwFO
 BGTLuXYP/ajhInMtRhEWBFITNJRIMT3EKw==
X-Google-Smtp-Source: AGHT+IHMaVHH2Yngj+/4RYhnherACjOYOtb9i6UhMIRwl+OfGmufdu8LyS2BNrd3nC67toGmBsX20Q==
X-Received: by 2002:a17:903:22c3:b0:1d5:4b18:49aa with SMTP id
 y3-20020a17090322c300b001d54b1849aamr1786878plg.91.1705096447295; 
 Fri, 12 Jan 2024 13:54:07 -0800 (PST)
Received: from ?IPV6:2001:8004:2728:2ad6:e985:c1c8:a4fc:508?
 ([2001:8004:2728:2ad6:e985:c1c8:a4fc:508])
 by smtp.gmail.com with ESMTPSA id
 jv3-20020a170903058300b001bb750189desm3621844plb.255.2024.01.12.13.54.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jan 2024 13:54:06 -0800 (PST)
Message-ID: <551dac95-3346-41eb-aa8c-d22b19f8c4fd@linaro.org>
Date: Sat, 13 Jan 2024 08:54:01 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] target/hppa: Fix PDC address translation on PA2.0
 with PSW.W=0
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Bruno Haible <bruno@clisp.org>
References: <20240112102927.35406-1-deller@kernel.org>
 <20240112102927.35406-5-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240112102927.35406-5-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 1/12/24 21:29, deller@kernel.org wrote:
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
> Figures H-10 and H-11 in the parisc2.0 spec [1] show that the 32-bit
> region will be mapped somewhere into a higher and bigger 64-bit PDC
> space.  The start and end of this 64-bit space is defined by the
> physical address bits. But the figures don't specifiy where exactly the
> mapping will start inside that region. Tests on a real HP C3700
> regarding the address of the power button indicate, that the lower
> 32-bits will stay the same though.
> [1] https://parisc.wiki.kernel.org/images-parisc/7/73/Parisc2.0.pdf
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Tested-by: Bruno Haible <bruno@clisp.org>
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

Please adjust the code comment that immediately precedes this, not just within the commit 
message.


r~

