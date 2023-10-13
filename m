Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6749A7C7CC9
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 06:35:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr9sY-0002Kc-Dg; Fri, 13 Oct 2023 00:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr9sS-0002Jg-Au
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 00:34:20 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr9sP-0001Ns-SS
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 00:34:20 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c87a85332bso14885795ad.2
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 21:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697171656; x=1697776456; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TIN57pIxKpGhq722tCT4tcYHUOkd4fwyvgeFWOYtRq0=;
 b=uo4J8MSrx9ufmOpgPexQ2edAyKbTLJ40tHAaggwJ6oezcIewq7/hJwCkArFQMXfYjO
 Zw5iDLbkTSWQk8zWFtfOHpA6r9SIyOHkJAfib9UUQzswr3lXNM1E7UyD/fWD2XQsZsLa
 cjyiKVom3N+JeEx6SCbqr7VVucoI/ORbi3Px5wpYBGmNn2OdJgOlkOFoGY/npRnzqIJR
 hgKbO3XyaKdFegjzreQ3Vc9CTOPH3W5hezf03/tzaj1pvD9u/k8dxFaH0dka2ozR7bEY
 rEAD8FQNdIfmy7nYC23wNZmONkPt6/6Y5qB+spCuu7+tUwYLp5riiy/JN4vblBdwMgu0
 3COw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697171656; x=1697776456;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TIN57pIxKpGhq722tCT4tcYHUOkd4fwyvgeFWOYtRq0=;
 b=DQvtjeUYJTN2tTD02bs8h4PH+NR76uB8wevMqAQMLw8EXj5hiwt7E8QgdN/fGu7Fpn
 Caby6DaF86N98x+ankL9x7sDnHC1M8EzfivHAUrp349gBKxbZsBVls8gINBU4ZSC1bI5
 uWtzObEk+JAgw0qMBGYXMrbrYWxCuyQ39JV1gJrJBl3skY3PWyysmkRF/G/SCYynaw/4
 qFgm7HuAHCji1gdzom7v73rt8WW3lXSnY/zN1eoFml6F4nPLej8S0aJWTQ+30WWvg+K/
 etIeGvokT5Zb4o8H/2CchR6QSzhFtB+l37aMauHuWtAnHLl8lwt3C5afnvzgBAtzXtD4
 /i4w==
X-Gm-Message-State: AOJu0YwqHwZCUZt/VVcJWa0a/HdbK1LQyIIDJXbBj1IgriVgsBTEdbDz
 a1hYLrlwONWIQw6A46akFoTZiyev5tvUN/sahgY=
X-Google-Smtp-Source: AGHT+IGNayshnCFkMRukseOOepI4Zw9PZuFA1NQoWT3u+ui0znEofGyjGB5esSGdKIP0qL3hclqDiQ==
X-Received: by 2002:a17:902:f54f:b0:1b8:66f6:87a3 with SMTP id
 h15-20020a170902f54f00b001b866f687a3mr32128428plf.52.1697171656249; 
 Thu, 12 Oct 2023 21:34:16 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 o11-20020a170902778b00b001c5f7e06256sm2812583pll.152.2023.10.12.21.34.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 21:34:15 -0700 (PDT)
Message-ID: <8d30ccda-5b81-42fd-b36c-79bbaceffa2a@linaro.org>
Date: Thu, 12 Oct 2023 21:34:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/18] target/mips: Make MIPS_CPU common to new MIPS32_CPU
 / MIPS64_CPU types
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231010092901.99189-1-philmd@linaro.org>
 <20231010092901.99189-18-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231010092901.99189-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/10/23 02:28, Philippe Mathieu-Daudé wrote:
> "target/foo/cpu-qom.h" can not use any target specific definitions.
> 
> Currently "target/mips/cpu-qom.h" defines TYPE_MIPS_CPU depending
> on the mips(32)/mips64 build type. This doesn't scale in a
> heterogeneous context where we need to access both types concurrently.
> 
> In order to do that, introduce the new MIPS32_CPU / MIPS64_CPU types,
> both inheriting a common TYPE_MIPS_CPU base type.
> 
> Keep the current CPU types registered in mips_register_cpudef_type()
> as 32 or 64-bit, but instead of depending on the binary built being
> targeting 32/64-bit, check whether the CPU is 64-bit by looking at
> the CPU_MIPS64 bit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/cpu-qom.h | 13 ++++++-------
>   target/mips/cpu.h     |  3 +++
>   target/mips/cpu.c     | 11 ++++++++++-
>   3 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/target/mips/cpu-qom.h b/target/mips/cpu-qom.h
> index 9c98ca1956..1a71509b5e 100644
> --- a/target/mips/cpu-qom.h
> +++ b/target/mips/cpu-qom.h
> @@ -1,5 +1,5 @@
>   /*
> - * QEMU MIPS CPU
> + * QEMU MIPS CPU QOM header (target agnostic)
>    *
>    * Copyright (c) 2012 SUSE LINUX Products GmbH
>    *
> @@ -23,13 +23,12 @@
>   #include "hw/core/cpu.h"
>   #include "qom/object.h"
>   
> -#ifdef TARGET_MIPS64
> -#define TYPE_MIPS_CPU "mips64-cpu"
> -#else
> -#define TYPE_MIPS_CPU "mips-cpu"
> -#endif
> +#define TYPE_MIPS_CPU   "mips-cpu"
> +#define TYPE_MIPS32_CPU "mips32-cpu"
> +#define TYPE_MIPS64_CPU "mips64-cpu"
>   
> -OBJECT_DECLARE_CPU_TYPE(MIPSCPU, MIPSCPUClass, MIPS_CPU)
> +OBJECT_DECLARE_CPU_TYPE(MIPS32CPU, MIPSCPUClass, MIPS32_CPU)
> +OBJECT_DECLARE_CPU_TYPE(MIPS64CPU, MIPSCPUClass, MIPS64_CPU)
>   
>   #define MIPS_CPU_TYPE_SUFFIX "-" TYPE_MIPS_CPU
>   #define MIPS_CPU_TYPE_NAME(model) model MIPS_CPU_TYPE_SUFFIX
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 6b026e6bcf..3b6d0a7a8a 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -10,6 +10,9 @@
>   #include "hw/clock.h"
>   #include "mips-defs.h"
>   
> +/* Abstract QOM MIPS CPU, not exposed to other targets */
> +OBJECT_DECLARE_CPU_TYPE(MIPSCPU, MIPSCPUClass, MIPS_CPU)

Why is this one moved back to cpu.h?
You exposed TYPE_X86_CPU in i386/cpu-qom.h...


r~

