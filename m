Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD75F7FBC1E
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 15:03:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7ygT-0005JR-J7; Tue, 28 Nov 2023 09:03:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r7ygG-0005F1-Uy
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:03:17 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r7yfw-0004a2-4K
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:03:02 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1fa4b632198so1340866fac.1
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 06:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701180172; x=1701784972; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dec8iRgzEDFu7HMeARR9V8WSMJQftG6WNb8g4wP73b4=;
 b=ON0w0klFROy9TQ4jT8P7LdxBCc9sjUCEs2qDoP/G8ab0vqX3pT95QkRV/csv67HPlV
 UwMSRGDAYReGs6/1iav0JaU37iBAEtfjXZbx79oM3WsCr9vz02wkp1mz/uu6f6nD6MMF
 qDaSLzI7VrTF5D7ejrjLGUEqqsVMl/yp0oSLGzoon/BOcIRvQD6VPN6PkYKMWUp3hPi1
 Wt+0tjdTmxSlqFdrqe1j5QsjRkPytHBdwNyBXeQOhaFAZqQnG6qiwez6IPxIDcmhTZ+y
 oW0QR6grXV5TgxWWR4tMlhQ5euNriYV6cE6Sw9B5Iga+mSlAIeYoMT2Re/FMHEnhD9A9
 fttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701180172; x=1701784972;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dec8iRgzEDFu7HMeARR9V8WSMJQftG6WNb8g4wP73b4=;
 b=uA33u1TIxLZjO6hYGTdIUCHp/w8bcFSePjRROlu+CvoucClENGJyS3BI7uXK7j3NtF
 DaRnvfOKMK5/ugzyCV1vWQCZj/PgyGCHF3jwmdHzNKsQIYlUF2xW3PUc/vedP4j5YqA3
 clJS/Bzxa/WwgyVnnKWqLQrM8JmuWMSgtgr83mJeG/WJVSbYh2uWRcMEXIxiPPFFiai3
 VzX7q1dlfbMTF3kIiQjPjh4cOJiFTxvzAKk8w6LjueCQcClBSusi1GvNClnXXz9m35+4
 z/zR2rORXF0Fzq7t/J5tCbiI1Rx2k9+gtAjoi9s4lzo06cbwYqwWyScEC3hDjj+cNruh
 eK4A==
X-Gm-Message-State: AOJu0YzDqrpBSE49GiE+MRSW+7AyvzzJWOROpz0POGXw6T2mDPF/EKwa
 QNFMMCEmu9UfOwBOqffEfjpmqLbPXiFmbWxUXhsvDtTP
X-Google-Smtp-Source: AGHT+IGyHpa6zzVI1Dhk0/OKElxnYt3uPc/JtVQNSVfQWa4BvYN1oUz123krcf0Atey1HQVQgxfEyA==
X-Received: by 2002:a05:6870:a70b:b0:1fa:14a2:d3b2 with SMTP id
 g11-20020a056870a70b00b001fa14a2d3b2mr16120417oam.55.1701180172466; 
 Tue, 28 Nov 2023 06:02:52 -0800 (PST)
Received: from [172.20.7.39] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 ny13-20020a056871750d00b001fa1350df8esm2068309oac.2.2023.11.28.06.02.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 06:02:52 -0800 (PST)
Message-ID: <74fee177-71d9-4303-9692-b4a496047a03@linaro.org>
Date: Tue, 28 Nov 2023 08:02:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 05/11] target/arm: Move GTIMER definitions to
 'cpu-defs.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20231122183048.17150-1-philmd@linaro.org>
 <20231122183048.17150-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231122183048.17150-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/22/23 12:30, Philippe Mathieu-Daudé wrote:
> To allow GTIMER_* definitions to be used by non-ARM specific
> hardware models, move them to a new target agnostic "cpu-defs.h"
> header.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/cpu-defs.h | 19 +++++++++++++++++++
>   target/arm/cpu.h      |  8 +-------
>   hw/arm/bcm2836.c      |  1 +
>   3 files changed, 21 insertions(+), 7 deletions(-)
>   create mode 100644 target/arm/cpu-defs.h
> 
> diff --git a/target/arm/cpu-defs.h b/target/arm/cpu-defs.h
> new file mode 100644
> index 0000000000..1ad76aff14
> --- /dev/null
> +++ b/target/arm/cpu-defs.h
> @@ -0,0 +1,19 @@
> +/*
> + * ARM "target agnostic" CPU definitions
> + *
> + *  Copyright (c) 2003 Fabrice Bellard
> + *
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +
> +#ifndef ARM_CPU_DEFS_H
> +#define ARM_CPU_DEFS_H
> +
> +#define GTIMER_PHYS     0
> +#define GTIMER_VIRT     1
> +#define GTIMER_HYP      2
> +#define GTIMER_SEC      3
> +#define GTIMER_HYPVIRT  4
> +#define NUM_GTIMERS     5
> +
> +#endif

Hmm.  cpu-defs.h is pretty generic.
Without looking forward in the patch series, perhaps better as gtimer.h?

Is hw/arm/bcm2836.c really "non-arm-specific"?  Or did you mean "non-ARMCPU-specific"?


r~

