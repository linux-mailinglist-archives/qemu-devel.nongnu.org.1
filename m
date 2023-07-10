Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8EC74DEB2
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 22:02:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIx4Y-0005lL-QB; Mon, 10 Jul 2023 16:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIx4I-0005l6-HO
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 16:01:14 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIx44-000267-Ph
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 16:00:58 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fc02a92dcfso31737935e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 13:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689019253; x=1691611253;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H3W1L54Id1o2QUcIABZJ6sT27o+AxfrR8+Y3NtZRaGU=;
 b=tKp17UFPm8/3POdhIKdfKaHbtjiBqwjQGsLYQqE0M0SRZEXhuyMrTfa4Y9P+423Bau
 CFM8o0IwsgwsFujSUM1YHbMtwcw963dXEH2Qqh7n9Q8EgySzmepJU1BcXaYmjaasiLtH
 zQLEb0RDNL9oLlt+Yq9sdaAkN/c6jCONHlISadlrZxoMX2asJo4+pxylE1FOn82S5z2X
 rTkJ+xtJlRVz2hx7qMfdXJi0/Dye39aS9PFHYZRk8yPGnQaDhSpbFssUQhK6yN3BVVdz
 OgJ/6s/19zMzsvA4x6ZycVP1aE8AyDwI/fHX/IcNX7/8NFFeAHf7hrbqQB78EUSUs0MM
 2g8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689019253; x=1691611253;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H3W1L54Id1o2QUcIABZJ6sT27o+AxfrR8+Y3NtZRaGU=;
 b=MfCqXf2TsOv6eDJbKb9+R1sqDChzgvaLp9QWK6Iv7zQBRj+TBsTJdjKQOki6saVivi
 W54ea13Ihc7EZQYvWoFMDzUiKoSnzYaRh4OiGpzjWtZACkmrUeLi4AwlDDBurSqtfM5y
 VC4I19xkbMqVEE8lhg9qW/ufu9JxQerKj64X0ix1JEQV/KcW/3CX2Pi2i3/2Z23PBqxa
 1iESaxl5lfVAlF95di4vRQRlm/iaYsgW7I319ax4EOFpxcaMcVl1LKqCL5PP7Cibf3er
 jewu97idHa5O9Ylye5111/QtJWLIi0RhCO8ni3saJHIBHbXpMcEaGlQPUrtyAk/ZwlED
 i4Xg==
X-Gm-Message-State: ABy/qLZ+xK/q05HDKxL38d/uPbhYvvXX/DUzI7iJCZ1tKsOLNslwwjSd
 xm9wrG9rPPPd++Ydz9Xb+Om5CQ==
X-Google-Smtp-Source: APBJJlGl9O6Py0zXlSkOBGchni8xIobpV9rY57ggOuOM5x7lbtp1fQNLRsHYW2aYzJQpJ+Nu4YzihA==
X-Received: by 2002:a1c:e903:0:b0:3fb:41b5:52eb with SMTP id
 q3-20020a1ce903000000b003fb41b552ebmr12160138wmc.26.1689019253491; 
 Mon, 10 Jul 2023 13:00:53 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 m17-20020a05600c281100b003fbca05faa9sm676111wmb.24.2023.07.10.13.00.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 13:00:53 -0700 (PDT)
Message-ID: <3a7dbf8b-000b-b8dd-69f7-625c8154ad63@linaro.org>
Date: Mon, 10 Jul 2023 22:00:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] target/mips: Implement Loongson CSR instructions
Content-Language: en-US
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: yangxiaojuan@loongson.cn, gaosong@loongson.cn, chenhuacai@kernel.org
References: <20230521214832.20145-1-jiaxun.yang@flygoat.com>
 <20230521214832.20145-2-jiaxun.yang@flygoat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230521214832.20145-2-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 21/5/23 23:48, Jiaxun Yang wrote:
> Loongson introduced CSR instructions since 3A4000, which looks
> similar to IOCSR and CPUCFG instructions we seen in LoongArch.
> 
> Unfortunately we don't have much document about those instructions,
> bit fields of CPUCFG instructions and IOCSR registers can be found
> at 3A4000's user manual, while instruction encodings can be found
> at arch/mips/include/asm/mach-loongson64/loongson_regs.h from
> Linux Kernel.
> 
> Our predefined CPUCFG bits are differ from actual 3A4000, since
> we can't emulate all CPUCFG features present in 3A4000 for now,
> we just enable bits for what we have in TCG.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   target/mips/cpu-defs.c.inc           |  9 ++++
>   target/mips/cpu.c                    |  8 ++++
>   target/mips/cpu.h                    | 40 ++++++++++++++++
>   target/mips/helper.h                 |  4 ++
>   target/mips/internal.h               |  2 +
>   target/mips/tcg/lcsr.decode          | 17 +++++++
>   target/mips/tcg/lcsr_translate.c     | 69 ++++++++++++++++++++++++++++
>   target/mips/tcg/meson.build          |  2 +
>   target/mips/tcg/op_helper.c          | 16 +++++++
>   target/mips/tcg/sysemu/lcsr_helper.c | 45 ++++++++++++++++++
>   target/mips/tcg/sysemu/meson.build   |  4 ++
>   target/mips/tcg/sysemu_helper.h.inc  |  8 ++++
>   target/mips/tcg/translate.c          |  3 ++
>   target/mips/tcg/translate.h          |  7 +++
>   14 files changed, 234 insertions(+)
>   create mode 100644 target/mips/tcg/lcsr.decode
>   create mode 100644 target/mips/tcg/lcsr_translate.c
>   create mode 100644 target/mips/tcg/sysemu/lcsr_helper.c


> diff --git a/target/mips/tcg/lcsr.decode b/target/mips/tcg/lcsr.decode
> new file mode 100644
> index 000000000000..960ef8b6f99b
> --- /dev/null
> +++ b/target/mips/tcg/lcsr.decode
> @@ -0,0 +1,17 @@
> +# Loongson CSR instructions
> +#
> +# Copyright (C) 2023 Jiaxun Yang <jiaxun.yang@flygoat.com>
> +#
> +# SPDX-License-Identifier: LGPL-2.1-or-later
> +#


> diff --git a/target/mips/tcg/lcsr_translate.c b/target/mips/tcg/lcsr_translate.c
> new file mode 100644
> index 000000000000..0ca6f2e7f8db
> --- /dev/null
> +++ b/target/mips/tcg/lcsr_translate.c
> @@ -0,0 +1,69 @@
> +/*
> + * Loongson CSR instructions translation routines
> + *
> + *  Copyright (c) 2023 Jiaxun Yang <jiaxun.yang@flygoat.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +


> diff --git a/target/mips/tcg/sysemu/lcsr_helper.c b/target/mips/tcg/sysemu/lcsr_helper.c
> new file mode 100644
> index 000000000000..1152695ba2c1
> --- /dev/null
> +++ b/target/mips/tcg/sysemu/lcsr_helper.c
> @@ -0,0 +1,45 @@
> +/*
> + * Loongson CSR instructions translation routines
> + *
> + *  Copyright (c) 2023 Jiaxun Yang <jiaxun.yang@flygoat.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */

You have a mix of LGPL/GPL. I suppose you want LGPL.

> diff --git a/target/mips/tcg/sysemu/meson.build b/target/mips/tcg/sysemu/meson.build
> index 4da2c577b203..098b6069159b 100644
> --- a/target/mips/tcg/sysemu/meson.build
> +++ b/target/mips/tcg/sysemu/meson.build
> @@ -4,3 +4,7 @@ mips_softmmu_ss.add(files(
>     'special_helper.c',
>     'tlb_helper.c',
>   ))
> +
> +mips_softmmu_ss.add(when: 'TARGET_MIPS64', if_true: files(

Now s/mips_softmmu_ss/mips_system_ss/.

> +  'lcsr_helper.c',
> +))


