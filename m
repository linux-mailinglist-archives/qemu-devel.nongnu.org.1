Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EABDE7C7C7A
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 06:13:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr9Y9-0003uS-Gi; Fri, 13 Oct 2023 00:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr9Y7-0003u4-Gl
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 00:13:19 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr9Y6-0006fQ-0O
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 00:13:19 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-68fb85afef4so1451601b3a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 21:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697170396; x=1697775196; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iBgcdkJDa6FQKQ0P3N3ZuasCg2pJDw+6j8+3dPUSs5g=;
 b=lGIG9bFpqMhBSoUamv8GxiqyTF10Awxb+1Ms6TwDWTJaeF5VwW9ptbWTLTTos73HTN
 oKq2kHGmX6fA7e9kecZlj9MNDvarQKRUDRLu0td6F33XBuDwTY5KCPW2wlBsBtbUW+QB
 +IEovWfnaHN8ydkZYGvbpodhCfrU5M++TUUFqQg7yIIkY7cM1hCd4k6SDazhBam0T5S7
 0iVkL+bQAczMu5P9eXhRx6N5mOH73aYZy8JVXYtOHbTXohUCyJru/rWTt0/BE2OpSiee
 1RlEcVso5O4ROaUev2H4PSWNZtSpwOcfDS2MsDZqAwNSEV0YGNAVJO6PXqZD9VkubUo6
 rSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697170396; x=1697775196;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iBgcdkJDa6FQKQ0P3N3ZuasCg2pJDw+6j8+3dPUSs5g=;
 b=qj4hAeVmJfZ99HEpdMroZMKqYNT2ktmkpLd/rrBpFD3NBXwQhNKMmyZkVxgw3ORMo3
 SqrPlycFBik5STAqk0chz3kMJKVxyj3Vp5v6rReGlshG0ugkEBUHy1I2HLqEien1HBRE
 +06XyB9SOQsCj5qorOvRIeOvc3yn4SgZHjmQBgIhnkL8v/Wa6+Z/+XvS0ocvlWmJqwYD
 D8o2IaJwR/LFohoUT/7sJQfiDupkJgh3MEA/JtBooKMndrBUcfPC0poCwsxT1Hg2yPbw
 f/MeiH1IXGNUYugUUXDHYWs/6mHTe5co6nYUaG+gjepEUUgnNa8P5P9YzGRMUL1A1nTi
 NyEQ==
X-Gm-Message-State: AOJu0YwowxSs9Ww5JChZ+TVlo8zIOiqjopi6x1WUQ9ZBYC7gEUpk2bA8
 YJq9yguEjqP5b1dcSgNFUyL+iQ==
X-Google-Smtp-Source: AGHT+IEEOtJx3Tfkdu2ASdLHFq0+LJEEinS9BrIhLkZgqHfmcksBmThGfF1A24h1RksHoCm2RMWmRg==
X-Received: by 2002:a05:6a00:2489:b0:690:1720:aa92 with SMTP id
 c9-20020a056a00248900b006901720aa92mr26743906pfv.10.1697170396320; 
 Thu, 12 Oct 2023 21:13:16 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 q18-20020aa78432000000b00690ca4356f1sm269497pfn.198.2023.10.12.21.13.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 21:13:15 -0700 (PDT)
Message-ID: <e6a5386e-e33d-464d-b84d-b58ca16429f0@linaro.org>
Date: Thu, 12 Oct 2023 21:13:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/18] target/riscv: Inline target specific
 TYPE_RISCV_CPU_BASE definition
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231010092901.99189-1-philmd@linaro.org>
 <20231010092901.99189-11-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231010092901.99189-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
> TYPE_RISCV_CPU_BASE depends on the TARGET_RISCV32/TARGET_RISCV64
> definitions which are target specific. Such target specific
> definition taints "cpu-qom.h".
> 
> Since "cpu-qom.h" must be target agnostic, remove its target
> specific definition uses by inlining TYPE_RISCV_CPU_BASE in the
> two machines using it.
> 
> "target/riscv/cpu-qom.h" is now fully target agnostic.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/riscv/cpu-qom.h | 8 +-------
>   hw/riscv/spike.c       | 8 +++++++-
>   hw/riscv/virt.c        | 8 +++++++-
>   3 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 8cb67b84a4..f607687384 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -1,5 +1,5 @@
>   /*
> - * QEMU RISC-V CPU QOM header
> + * QEMU RISC-V CPU QOM header (target agnostic)
>    *
>    * Copyright (c) 2023 Ventana Micro Systems Inc.
>    *
> @@ -43,12 +43,6 @@
>   #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
>   #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
>   
> -#if defined(TARGET_RISCV32)
> -# define TYPE_RISCV_CPU_BASE            TYPE_RISCV_CPU_BASE32
> -#elif defined(TARGET_RISCV64)
> -# define TYPE_RISCV_CPU_BASE            TYPE_RISCV_CPU_BASE64
> -#endif

Move to cpu.h (or elsewhere) instead of replicating in two hw/ files?


r~

