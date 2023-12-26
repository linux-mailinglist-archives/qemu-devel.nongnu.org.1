Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4C881E70F
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 12:19:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI5RI-0003Pn-9F; Tue, 26 Dec 2023 06:17:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rI5RE-0003PC-IP
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 06:17:32 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rI5RC-0008Ma-Ck
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 06:17:31 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40d4a7f0d17so33301245e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 03:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703589447; x=1704194247; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AWcLIU+t89Tu7OdXX76I4MYCQ86kFuCgTTPUe1ixuSk=;
 b=wcvmhr/MX4dBhVVY02g5fi7ivyOzmDoQN/HIENsZfEWrXvUqXorftqXDNt5Gr5/4e/
 LuQt2NFfBA8cUrCGFYM+BF3bFA2pg1C1jBN3oTlc9MgO26cZHDpt8YUaTK52X04OpbIq
 t2lpqm00UG0XueV0HSsy5KKH8Lfej7QdJo9Z8XNBO73LdRlATz1byklE+ZcKB9Uy28NB
 TPxGM6KptJO/EUdoqM8nsNgGBkLV5LgKfW70hV0IuyMDpidBJba7B35IhWmkaqQoV/zG
 TjeXgKf3q/sUNANq8mofpaxCsdVG7FmT/io6WyJyDdJbgShAMM0cMZZCZhU5P7bduh2B
 0Ddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703589447; x=1704194247;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AWcLIU+t89Tu7OdXX76I4MYCQ86kFuCgTTPUe1ixuSk=;
 b=JpGGT67poivjXc/6NqQi3k/3aPj4dcpqlC8t0qiZHCwFSYoPp9nvIo7T6nkMrlOmvC
 vDbfTV8P4rTN3Q82MupPQa/QyiE06N1skFIxMbg2Gp14cGaGsqXaR/ayY328mG0aB7bf
 dN5ndHjFxJSjVIa8bJ6astuNNRNo5IT+wgO6rYQV9AGcD2/WG8rmwL6ZSaYZIUD7XOvj
 I9T+94gZS81YqBAfg7AYf5D0V+5Y7jPzC9IW9DfkdzO6YCEW5C65ERDsLUWI0DJqWOVs
 8HDZJ8a6QK7vMUNu3zrGPEs+5JSHS/YZ9A65tzHSAoX78evzkNz/ws2l+9dF4apUU4m/
 0eow==
X-Gm-Message-State: AOJu0YznsLqxc+Q5R/xNelEyO59OaJyTs76ZEaMYre9Al4uLnPpDsA6n
 waBBbLYCIYBHJg/n8hMwqkmRwbVJvbmvxjuEsgzzXo9bsG0=
X-Google-Smtp-Source: AGHT+IGOP58ZhJ2vHhyk8HHFvlg9R4JbumcsOm+95vPNThGYjegNXCAGbDZa7oAQ+9rP49jsQzpR3g==
X-Received: by 2002:a05:600c:2253:b0:40c:5777:da1a with SMTP id
 a19-20020a05600c225300b0040c5777da1amr4269997wmm.113.1703589447062; 
 Tue, 26 Dec 2023 03:17:27 -0800 (PST)
Received: from [192.168.96.175] (137.red-95-127-43.staticip.rima-tde.net.
 [95.127.43.137]) by smtp.gmail.com with ESMTPSA id
 b14-20020a05600c4e0e00b0040d5a5c26a9sm1868669wmq.43.2023.12.26.03.17.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Dec 2023 03:17:26 -0800 (PST)
Message-ID: <f8a9df6e-fa49-4d4a-ba01-b0c419e8bd9e@linaro.org>
Date: Tue, 26 Dec 2023 12:17:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33] hw/cpu/arm: Remove one use of qemu_get_cpu() in
 A7/A15 MPCore priv
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Anton Johansson <anjo@rev.ng>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Rob Herring <robh@kernel.org>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20231212162935.42910-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

ping for review?

On 12/12/23 17:29, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> When a MPCore cluster is used, the Cortex-A cores belong the the
> cluster container, not to the board/soc layer. This series move
> the creation of vCPUs to the MPCore private container.
> 
> Doing so we consolidate the QOM model, moving common code in a
> central place (abstract MPCore parent).
> 
> This eventually allow removing one qemu_get_cpu() use, which we
> want to remove in heterogeneous machines (machines using MPCore
> are candidate for heterogeneous emulation).
> 
> Maybe these hw/cpu/arm/ files belong to hw/arm/...
> 
> Regards,
> 
> Phil.
> 
> Philippe Mathieu-Daudé (33):
>    hw/arm/boot: Propagate vCPU to arm_load_dtb()
>    hw/arm/fsl-imx6: Add a local 'gic' variable
>    hw/arm/fsl-imx6ul: Add a local 'gic' variable
>    hw/arm/fsl-imx7: Add a local 'gic' variable
>    hw/cpu: Remove dead Kconfig
>    hw/cpu/arm: Rename 'busdev' -> 'gicsbd' in a15mp_priv_realize()
>    hw/cpu/arm: Alias 'num-cpu' property on TYPE_REALVIEW_MPCORE
>    hw/cpu/arm: Declare CPU QOM types using DEFINE_TYPES() macro
>    hw/cpu/arm: Merge {a9mpcore.h, a15mpcore.h} as cortex_mpcore.h
>    hw/cpu/arm: Introduce abstract CORTEX_MPCORE_PRIV QOM type
>    hw/cpu/arm: Have A9MPCORE/A15MPCORE inheritate common
>      CORTEX_MPCORE_PRIV
>    hw/cpu/arm: Create MPCore container in QOM parent
>    hw/cpu/arm: Handle 'num_cores' property once in MPCore parent
>    hw/cpu/arm: Handle 'has_el2/3' properties once in MPCore parent
>    hw/cpu/arm: Handle 'gic-irq' property once in MPCore parent
>    hw/cpu/arm: Handle GIC once in MPCore parent
>    hw/cpu/arm: Document more properties of CORTEX_MPCORE_PRIV QOM type
>    hw/cpu/arm: Replace A15MPPrivState by CortexMPPrivState
>    hw/cpu/arm: Introduce TYPE_A7MPCORE_PRIV for Cortex-A7 MPCore
>    hw/cpu/arm: Consolidate check on max GIC spi supported
>    hw/cpu/arm: Create CPUs once in MPCore parent
>    hw/arm/aspeed_ast2600: Let the A7MPcore create/wire the CPU cores
>    hw/arm/exynos4210: Let the A9MPcore create/wire the CPU cores
>    hw/arm/fsl-imx6: Let the A9MPcore create/wire the CPU cores
>    hw/arm/fsl-imx6ul: Let the A7MPcore create/wire the CPU cores
>    hw/arm/fsl-imx7: Let the A7MPcore create/wire the CPU cores
>    hw/arm/highbank: Let the A9/A15MPcore create/wire the CPU cores
>    hw/arm/vexpress: Let the A9/A15MPcore create/wire the CPU cores
>    hw/arm/xilinx_zynq: Let the A9MPcore create/wire the CPU cores
>    hw/arm/npcm7xx: Let the A9MPcore create/wire the CPU cores
>    hw/cpu/a9mpcore: Remove legacy code
>    hw/cpu/arm: Remove 'num-cpu' property alias
>    hw/cpu/arm: Remove use of qemu_get_cpu() in A7/A15 realize()


