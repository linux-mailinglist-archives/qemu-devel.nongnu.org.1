Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B6274DEE3
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 22:12:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIxEO-0000ZF-1V; Mon, 10 Jul 2023 16:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIxEM-0000Ys-4g
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 16:11:34 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIxEK-0004Sl-GG
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 16:11:33 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31297125334so3617772f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 13:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689019891; x=1691611891;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+2m2jiox3gWYUlk6XTcjW871O6JDtxnc4eAof0AMb14=;
 b=iRLecVMQshzNIJr8mVhQqBsxANI0fhOEeW07PbwuBlaES7jxRF5K7cJKu3KzaFIlE+
 8U1cHhGeQvZBPTB3U5qbISOgAK5BJ5kmVRdx3hjVfr90ppdWqgeG1pf2tQ9wec4RlJO9
 gjfQVTREiuGuHCRvIZLj4G5qyztx5uya35wmazdTLYKG12b6Vegp5RT+GfCQLhyrAMu2
 gYFVa2+3c47RQekg4nLfpWgjYs/O6eKzcpfGR0hrdpxM1Xs3iKZxsBnNssIQ1qCfsYgU
 Mio95TUySEmihmP7yVduWSAav30dIDnNm3tI3/0XmB7BaBdzwoRF93jy9gZmcmWH0Zbo
 9X+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689019891; x=1691611891;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+2m2jiox3gWYUlk6XTcjW871O6JDtxnc4eAof0AMb14=;
 b=djqkc24i+Q03SW7VODb+uY0SwpqB49ghBHbG6yFSl4HKYAL93iXsv9v/rMAfmlfmmb
 DuLPcm7oZ84v3KEwhzYaEki84Q/NK8JD/l0XtfG48JkyNrxKCr0ba4RDjvsO0qK1cM6Z
 dYEVlv09pUIffDw340ub83CDLb+jaDbd5vUag5k5VR2zVOcoNdaD8y1EMwA9qpv3+wXx
 K3jL4FfPqKK3MXZ3XCIvzFpXHogD+Hd2UCKi7wGRArUz9YrXwXy+il22vRPOQSyeK/3E
 k8qsFwU/POuRzo5DEd/jNC6bKavN9kxaYWEcu88Gpz0YEDdj/OnTuZdc/ZigTkfP5YoH
 2/uA==
X-Gm-Message-State: ABy/qLZ1KXa4jJUCqzorcmvhkR9/XsKnPqFjICqsV+7uj4TfhfcPhMCQ
 Pcd4utKEELXKXUeUKkfl501uXsan1QblENlep3mGwQ==
X-Google-Smtp-Source: APBJJlFamaDBN7f1Jp3tT/piIgpxG/3+8Z+ljxPH47M9yTBgLBAKhzqYQS4e4s221es7jgM3dNCxzA==
X-Received: by 2002:adf:de83:0:b0:314:3108:500a with SMTP id
 w3-20020adfde83000000b003143108500amr16911677wrl.0.1689019890815; 
 Mon, 10 Jul 2023 13:11:30 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 o6-20020a05600c378600b003fbb9339b29sm11215608wmr.42.2023.07.10.13.11.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 13:11:30 -0700 (PDT)
Message-ID: <d7fc3f2d-d3ff-a59e-7683-80eccbace371@linaro.org>
Date: Mon, 10 Jul 2023 22:11:26 +0200
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
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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


> @@ -1162,6 +1192,10 @@ typedef struct CPUArchState {
>       QEMUTimer *timer; /* Internal timer */
>       Clock *count_clock; /* CP0_Count clock */
>       target_ulong exception_base; /* ExceptionBase input to the core */
> +
> +    /* Loongson IOCSR memory */
> +    AddressSpace address_space_iocsr;
> +    MemoryRegion system_iocsr;
>   } CPUMIPSState;

Guarding to avoid on user emulation:

../target/mips/cpu.h:1198:22: error: field ‘as’ has incomplete type
  1198 |         AddressSpace as;
       |                      ^~
../target/mips/cpu.h:1199:22: error: field ‘mr’ has incomplete type
  1199 |         MemoryRegion mr;
       |                      ^~


