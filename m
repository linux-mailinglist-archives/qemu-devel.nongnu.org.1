Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C729A838DE9
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 12:51:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSFJ0-0007AE-GB; Tue, 23 Jan 2024 06:51:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSFIy-00078A-Uu
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 06:51:00 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSFIx-0004LF-0c
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 06:51:00 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40eacb4bfa0so21901925e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 03:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706010657; x=1706615457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OSEOxyBqJBLSvvvMHEAjv3yLyA28u8IONApUfy+8YUQ=;
 b=EwyM3gTylkI1J/fVmVPq6Gfzknoep1+8jG493lxHL3+gq10MNw+z7DOvjwOpoBLBhA
 VhUYN/j89QM2WpiX2qwKoFrCv6j0bCJqQWKbAzSMyDAoX4bf0ZCkuOTvC58j3iindSpy
 pGJfKyoc0EmwJm7LK7gqpyJBtszsGXcrzejXD0TNw7qUMo2XXGHRkXZx41S4+mfzdsjg
 9dSbrWt1geS3AqSRhYDl/9OVZo0BCjoxxzLuRA6Q3iF/BimYZsFsTHYNq69+Qsps4ahQ
 wFBE5gFVZT0p65nPBo+NPN+VB709bA4EoKUNiGIlXNNZM9AtMmK1SVPT3vvPLpnus2y3
 Y9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706010657; x=1706615457;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OSEOxyBqJBLSvvvMHEAjv3yLyA28u8IONApUfy+8YUQ=;
 b=LXUDUkotDD9uxywfbxGs5DoB9GaLkdUFEP1HQ49w+jWQbfD1k4ZW2Gb77rxTMQou66
 DkTlwiIrdnQsqFp/pnuvLun987erpZOrGBnhYv/fCOb3DijP4vAM6dNw1Uta00jO2lBn
 gJ7VccVKipmm7h9PVqLNT2CYTggfUpyDXX6nqFa9WqzgvLVYFPaYHYNpvGCF8UuyGls7
 6WIwY3+KS4JV2mYA1zggnSNP0mZvLjRq9ywyFYPxEheN5oFIBksAU4uvxiK9e6eA6omW
 Gooh1CoTWjDgIYEzyLlgj7V+gr7KrCWNziz0+9alD6BJTM74egW7t4B7+J966daZ3YER
 tmSA==
X-Gm-Message-State: AOJu0YxBBgoVetTfgYnzbhRAeF4BpNSMYTeFVNk6jniRnjVUasRGwVQW
 CfsV69CCgoUNjXWUlUHU6GgsO+047mRD+l8vwWKE+vMnumLcW0fZQYD4j2cwOhQ=
X-Google-Smtp-Source: AGHT+IES9aNSKgkPD7ykXP2090lQ05RmwZoGsi1XT85DX1zZjubCCURwLVLx1DSnHfPZjLOJMO/upg==
X-Received: by 2002:a05:600c:6a0b:b0:40e:3b1c:d3a2 with SMTP id
 jj11-20020a05600c6a0b00b0040e3b1cd3a2mr50760wmb.126.1706010657256; 
 Tue, 23 Jan 2024 03:50:57 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.78])
 by smtp.gmail.com with ESMTPSA id
 u21-20020a05600c139500b0040e4a7a7ca3sm42305464wmf.43.2024.01.23.03.50.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 03:50:56 -0800 (PST)
Message-ID: <a69519cf-27f6-479e-9ec6-ff7e11454c90@linaro.org>
Date: Tue, 23 Jan 2024 12:50:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 26/34] Wrap target macros in functions
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-27-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240119144024.14289-27-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Hi Anton,

On 19/1/24 15:40, Anton Johansson wrote:
> Adds wrapper functions around common target specific macros required by
> accel/tcg.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   include/hw/core/cpu.h |  9 +++++++
>   cpu-target.c          | 62 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 71 insertions(+)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 57d100c203..a2d65c1d7a 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -26,6 +26,7 @@
>   #include "exec/vaddr.h"
>   #include "exec/memattrs.h"
>   #include "exec/tlb-common.h"
> +#include "exec/memop.h"
>   #include "qapi/qapi-types-run-state.h"
>   #include "qemu/bitmap.h"
>   #include "qemu/rcu_queue.h"
> @@ -1164,6 +1165,14 @@ void cpu_exec_unrealizefn(CPUState *cpu);
>    * what you are doing!
>    */
>   bool target_words_bigendian(void);
> +bool target_supports_mttcg(void);
> +bool target_has_precise_smc(void);
> +int target_long_bits(void);
> +int target_phys_addr_space_bits(void);
> +uint8_t target_insn_start_words(void);
> +uint8_t target_default_memory_order(void);
> +uint8_t target_tlb_dyn_max_bits(void);
> +MemOp target_endian_memory_order(void);

None of these helpers take argument. I don't understand
how they can be called in heterogeneous context.

>   const char *target_name(void);
>   
> diff --git a/cpu-target.c b/cpu-target.c
> index 1a8e730bed..6b67af7a51 100644
> --- a/cpu-target.c
> +++ b/cpu-target.c
> @@ -39,10 +39,13 @@
>   #include "exec/tb-flush.h"
>   #include "exec/translate-all.h"
>   #include "exec/log.h"
> +#include "exec/cpu-defs.h"
>   #include "hw/core/accel-cpu.h"
>   #include "trace/trace-root.h"
>   #include "qemu/accel.h"
>   #include "qemu/plugin.h"
> +#include "tcg/tcg-mo.h"
> +#include "tcg/insn-start-words.h"
>   
>   uintptr_t qemu_host_page_size;
>   intptr_t qemu_host_page_mask;
> @@ -416,6 +419,65 @@ bool target_words_bigendian(void)
>       return TARGET_BIG_ENDIAN;
>   }
>   
> +bool target_supports_mttcg(void)
> +{
> +#ifdef TARGET_SUPPORTS_MTTCG
> +# ifndef TCG_GUEST_DEFAULT_MO
> +#  error "TARGET_SUPPORTS_MTTCG without TCG_GUEST_DEFAULT_MO"
> +# endif
> +    return true;
> +#else
> +    return false;
> +#endif
> +}
> +
> +bool target_has_precise_smc(void)
> +{
> +#ifdef TARGET_HAS_PRECISE_SMC
> +    return true;
> +#else
> +    return false;
> +#endif
> +}
> +
> +int target_long_bits(void)
> +{
> +    return TARGET_LONG_BITS;
> +}
> +
> +int target_phys_addr_space_bits(void)
> +{
> +    return TARGET_PHYS_ADDR_SPACE_BITS;
> +}
> +
> +uint8_t target_insn_start_words(void)
> +{
> +    return TARGET_INSN_START_WORDS;
> +}
> +
> +uint8_t target_default_memory_order(void)
> +{
> +#ifdef TCG_GUEST_DEFAULT_MO
> +    return TCG_GUEST_DEFAULT_MO;
> +#else
> +    return TCG_MO_ALL;
> +#endif
> +}
> +
> +MemOp target_endian_memory_order(void)
> +{
> +    return MO_TE;
> +}
> +
> +uint8_t target_tlb_dyn_max_bits(void)
> +{
> +#if defined(CONFIG_SOFTMMU) && defined(CONFIG_TCG)
> +    return CPU_TLB_DYN_MAX_BITS;
> +#else
> +    return 0;
> +#endif
> +}
> +
>   const char *target_name(void)
>   {
>       return TARGET_NAME;


