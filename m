Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDBF832182
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 23:22:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQal3-00041Y-IL; Thu, 18 Jan 2024 17:21:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rQal0-00041P-Jx
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 17:21:06 -0500
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rQaky-0004Et-Ty
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 17:21:06 -0500
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-598a5448ef5so91196eaf.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 14:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705616463; x=1706221263; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cdPaNbJgiTyPx/RYiPc09yquje4GZKgkMyFLEOE50YA=;
 b=cKm0VdDAh8gV9qi6fAT2EiXm7alAZeqT9enfec8Fdyy1vXE/TuxCNsCJvu1dGjJhp+
 OmjF5sTYd3OhYEoH/6sDuBf8gWpaFzcM1phhp77Ucq0KFRf2Vk9WSxywYEV7OhoyjgrA
 d9rvKlevtzm0n+PfPI8VdhK75rXb6IAHeigrpno8KEaUI6s0FJdaGjMRFUOa+t5OWoAF
 lALiNOhiVlSrMjd7c4Y804SIS/5VA7ogU0VKJsymEMf1EEaV+XpxVPjnB8CVi6Pp0ZPk
 JQY2J4wBzKNjJNbglh2AoFtFOdWb7qY9peRg5NRIVeOV1hSieoHItTsu/cfoNtRbDTjj
 F8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705616463; x=1706221263;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cdPaNbJgiTyPx/RYiPc09yquje4GZKgkMyFLEOE50YA=;
 b=qyykfjIMptSozuEx+vibt8uCS4xH9hASI/ksnAV5hyqfpUgvq9Z5+5GX+AgMx83O+j
 sB5bK17Kd+qBplJIM/rFujnV6tLFgoHLHx91w5MrKJKVfh5W8TWmhwACW7NkQRO5mHEy
 DoNXbOybLDQ9MqSzNE9ZwRbxa4T7EQrIx7+ZoUkg43XytZLD2tutph49VLdrC8TixyvP
 15VMAFxnh+ST8gOGoApBfg4uU64UxJzotTQ5S//cVKqAQNp2BcwK8OJEqYhq9eXifkHn
 VdWdpYcxzxyZAD90VFxmyin+fMWxLwvFOKSNLxyPi88qt8kYv/eRRl59wM3KfJnhrtIZ
 tB8Q==
X-Gm-Message-State: AOJu0YyCfufeNpLlHkXHMTgAdGatjWqlpiaPSfrB1ZG9q0M3MyLF4HV4
 JhzI7r1KkJ77E4UK7IXelBDTIV1X3afAlMeGin2hmOT0xfXeAxSSTtfkC0Xmt/c=
X-Google-Smtp-Source: AGHT+IHQ47hXFXIfz+VHnWrbNp63ybYdvLiAtGgXBDPw2w5WaZdnSTQYRZq9pNzZKua+UYqi+l9Qdw==
X-Received: by 2002:a05:6358:d3a4:b0:176:2bb2:129f with SMTP id
 mp36-20020a056358d3a400b001762bb2129fmr405477rwb.3.1705616463042; 
 Thu, 18 Jan 2024 14:21:03 -0800 (PST)
Received: from ?IPV6:2001:8004:2728:321b:4bd7:3071:22d6:a756?
 ([2001:8004:2728:321b:4bd7:3071:22d6:a756])
 by smtp.gmail.com with ESMTPSA id
 ei29-20020a056a0080dd00b006d9ae6fe867sm3810154pfb.110.2024.01.18.14.21.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jan 2024 14:21:02 -0800 (PST)
Message-ID: <d36f28a4-d6b1-4337-a852-99a3915e243f@linaro.org>
Date: Fri, 19 Jan 2024 09:20:56 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/20] arm: Rework target/ headers to build various hw/
 files once
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240118200643.29037-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240118200643.29037-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
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

On 1/19/24 07:06, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> In order to fix a bug noticed [*] by Cédric and Fabiano in my
> "Remove one use of qemu_get_cpu() in A7/A15 MPCore priv" series,
> I ended reusing commits from other branches and it grew quite
> a lot. This is the first "cleanup" part, unrelated on MPCorePriv.
> 
> Please review,
> 
> Phil.
> 
> Philippe Mathieu-Daudé (18):
>    hw/arm/exynos4210: Include missing 'exec/tswap.h' header
>    hw/arm/xilinx_zynq: Include missing 'exec/tswap.h' header
>    hw/arm/smmuv3: Include missing 'hw/registerfields.h' header
>    hw/arm/xlnx-versal: Include missing 'cpu.h' header
>    target/arm/cpu-features: Include missing 'hw/registerfields.h' header
>    target/arm/cpregs: Include missing 'hw/registerfields.h' header
>    target/arm/cpregs: Include missing 'kvm-consts.h' header
>    target/arm: Expose arm_cpu_mp_affinity() in 'multiprocessing.h' header
>    target/arm: Declare ARM_CPU_TYPE_NAME/SUFFIX in 'cpu-qom.h'
>    hw/cpu/a9mpcore: Build it only once
>    hw/misc/xlnx-versal-crl: Include generic 'cpu-qom.h' instead of
>      'cpu.h'
>    hw/misc/xlnx-versal-crl: Build it only once
>    target/arm: Expose M-profile register bank index definitions
>    hw/arm/armv7m: Make 'hw/intc/armv7m_nvic.h' a target agnostic header
>    target/arm: Move ARM_CPU_IRQ/FIQ definitions to 'cpu-qom.h' header
>    target/arm: Move e2h_access() helper around
>    target/arm: Move GTimer definitions to new 'gtimer.h' header
>    hw/arm: Build various units only once

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


