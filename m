Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C01E82871E
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 14:32:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNCCf-0001fj-S7; Tue, 09 Jan 2024 08:31:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNCCK-0001cc-Ol
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 08:31:17 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNCCF-0006vR-3P
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 08:31:15 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40e4f1f519aso6614015e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 05:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704807066; x=1705411866; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8tZaOxh8sXvPY7EuKjNICYqWEHqtF6t31467tcsqEas=;
 b=aosbcxf90vPPjSzc69q7YNg/9IZtDQXNu2e86/uQvkogX70ANCsiNTQc1ddbZeLVXB
 nLW2TR319fmHoprym4E4oqh8X0ThO4QcTX9otVUij6KgStMIAFKPKgprXEr9X8uyXFuZ
 lichVMwnvEqafX0MltRAVoI6DPrGSzYFL/J+xuPVa3HH/2iGv9N7IcGkU48CPJrFHwge
 msO8gHKKWGLCaDxLCHsypHn1dz0/a6PsynzI7XAJxOSuGaINiu+bJRcSz+IjuO0DaLOQ
 0Uy3Z8m1T/GcGbqbq2RxSxyjeoQ5vnLOK9r9agL1/sdFhC6wM51cUPk/aoOQOxMs/bIY
 e7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704807066; x=1705411866;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8tZaOxh8sXvPY7EuKjNICYqWEHqtF6t31467tcsqEas=;
 b=JtRPZ1uXexGbQcH4LLtRQ7KxFHUrqaUMwhraTSvX9HMc2fN08IwjfSdong91494sbt
 VQ45EaZSnYT7rNgxFKLzJykpbRdedD3nIaOLAF5HTPXYBwI0g0bITGuUiLmV8ECOuTd9
 AKIQeUoJkdqBy83qe4RAyhTALVWKnEjlQ8o9n3jhSMwu+U1yy0fVxGyqbEYhUFk5XSAw
 rF6mGyIak9MzHnubH02RsWkcM46WRs5yRs3QqV8nVS6sy+wvz7Oj5v0ujZVIsOXyjV+E
 TK4YB3cbSwCnu/73zaKrGsFfQYFa8cJmqZAlue1AKpD08EGuiXP7q78XmC6GDkMyiwcM
 Cr3g==
X-Gm-Message-State: AOJu0YxJ+cuVfsUKwzhvikFmWdYWFjgFeeovcuGl+0kecrXNkrmHUpUP
 HE2aWVXI20tBRQuCiLPvajAan6Weq5pvew==
X-Google-Smtp-Source: AGHT+IFBzIkF1sEG9hY3lyE8hBQCKL1dhyzyIqwAewzsaChrAyC6gBNU2Am9L1NAzMpbtdNqocFLfw==
X-Received: by 2002:a05:600c:458d:b0:40d:9208:ece4 with SMTP id
 r13-20020a05600c458d00b0040d9208ece4mr2736176wmo.33.1704807066535; 
 Tue, 09 Jan 2024 05:31:06 -0800 (PST)
Received: from [192.168.69.100] (rsa59-h02-176-184-32-47.dsl.sta.abo.bbox.fr.
 [176.184.32.47]) by smtp.gmail.com with ESMTPSA id
 fj14-20020a05600c0c8e00b0040d83ab2ecdsm3836420wmb.21.2024.01.09.05.31.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 05:31:06 -0800 (PST)
Message-ID: <48ca6b12-6838-4788-8484-90621b46d65f@linaro.org>
Date: Tue, 9 Jan 2024 14:31:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/PATCH v1 07/11] gunyah: Specify device-tree location
Content-Language: en-US
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>, peter.maydell@linaro.org, 
 alex.bennee@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: quic_tsoni@quicinc.com, quic_pheragu@quicinc.com,
 quic_eberman@quicinc.com, quic_yvasi@quicinc.com, quic_cvanscha@quicinc.com,
 quic_mnalajal@quicinc.com
References: <20240109090039.1636383-1-quic_svaddagi@quicinc.com>
 <20240109090039.1636383-8-quic_svaddagi@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240109090039.1636383-8-quic_svaddagi@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Hi Srivatsa,

On 9/1/24 10:00, Srivatsa Vaddagiri wrote:
> Specify the location of device-tree and its size, as Gunyah requires the
> device-tree to be parsed before VM can begin its execution.
> 
> Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
> ---
>   MAINTAINERS               |  1 +
>   accel/stubs/gunyah-stub.c |  5 +++++
>   hw/arm/virt.c             |  6 ++++++
>   include/sysemu/gunyah.h   |  2 ++
>   target/arm/gunyah.c       | 45 +++++++++++++++++++++++++++++++++++++++
>   target/arm/meson.build    |  3 +++
>   6 files changed, 62 insertions(+)
>   create mode 100644 target/arm/gunyah.c

(Please enable scripts/git.orderfile)

> diff --git a/include/sysemu/gunyah.h b/include/sysemu/gunyah.h
> index 4f26938521..a73d17bfb9 100644
> --- a/include/sysemu/gunyah.h
> +++ b/include/sysemu/gunyah.h
> @@ -27,4 +27,6 @@ typedef struct GUNYAHState GUNYAHState;
>   DECLARE_INSTANCE_CHECKER(GUNYAHState, GUNYAH_STATE,
>                            TYPE_GUNYAH_ACCEL)
>   
> +int gunyah_arm_set_dtb(__u64 dtb_start, __u64 dtb_size);
I'm getting:

In file included from hw/intc/arm_gicv3_common.c:35:
include/sysemu/gunyah.h:30:24: error: unknown type name '__u64'
int gunyah_arm_set_dtb(__u64 dtb_start, __u64 dtb_size);
                        ^
include/sysemu/gunyah.h:30:41: error: unknown type name '__u64'
int gunyah_arm_set_dtb(__u64 dtb_start, __u64 dtb_size);
                                         ^
2 errors generated.


