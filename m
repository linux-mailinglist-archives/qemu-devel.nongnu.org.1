Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAE4829DFF
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 16:54:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNati-0000Ta-Lh; Wed, 10 Jan 2024 10:53:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNath-0000TJ-2T
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 10:53:41 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNatf-0005dQ-CM
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 10:53:40 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40d5336986cso55786985e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 07:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704902017; x=1705506817; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NZRqVuenPWIeJ0HEFm/EdEMDQu8jxtzURv+23qvhkQs=;
 b=gLOVWOiE9yqPJFE8j5l0vJKFsSvkB08dzEPDRlk0cubfyv295ZHRsRNikNm9wt0USq
 Vwiiftf0BUS4iGVX9bA42bE03AGHAS0oZ+uX7S+EZZsfUDz7L842kYR+TtGUvvh25v4f
 wub6uf1/8a5gDpol2IRFlYDgDRHCB4G2pOvNGR9jBx8rNsjmYIKEPs7uyfhmojqIV0NX
 gLp+H7Ms9EIgmvwmWT5ijD16d+VqHvtC/QyALdCSHNJy47l/zHZapErXaAx2+/UwOjCc
 w9YazxqYis8tXNlaR/fMwbJy90XyhQcI5hJmklLEUfoZiWlKXdU/oWb7O4J4jDQGGdrS
 ljig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704902017; x=1705506817;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NZRqVuenPWIeJ0HEFm/EdEMDQu8jxtzURv+23qvhkQs=;
 b=IeRPZ4WTuoU3jrGyakTQ0Kr+FEGf0J9kMq4Ai7W+6D7ivkAyE1HzCYSDzPkmVEbQkU
 XbuS4NuQi22XazSgDPxc3lGeeJ3ifvhqqxwUq3Rk5fby1iuwMseFMy/mjn1ntKm4w011
 d69iPA/SJPC3FCTM6GL/F6Nf4ncIpGSktHmIqnIEZRzRVbfExr1vfs64+d6wK7Vr1gvK
 L1nLP+A2TlVQoJK6rS7RhX4Xe0F/oVRMim30dTl4XsUu8v3RK7Hlf15b97Y4u+iNBqfy
 xJld9xL3HUxw/s1wamwoaR+WRuZwfjer+h8iGMr8QTgkTuePugfwZfYd9Hyc7yxN0KvR
 7QsQ==
X-Gm-Message-State: AOJu0Yx2UmIWUIocdti7WWYO9G7nfXxp1aOaHkqeOv2YSXcPVC1zSx7N
 X5Rbl7iTjYgIJswzSIXl08B/tKPK36LHxQ==
X-Google-Smtp-Source: AGHT+IGFuT7224gSV3NRAuDK9vMsaQlN4qgzNy+xdyE9QiKhn6tSOLLiKkQ6MFisG1W9c5g80JcBtw==
X-Received: by 2002:a05:600c:3484:b0:40e:3f83:fc34 with SMTP id
 a4-20020a05600c348400b0040e3f83fc34mr684764wmq.0.1704902017496; 
 Wed, 10 Jan 2024 07:53:37 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-236.dsl.sta.abo.bbox.fr.
 [176.184.43.236]) by smtp.gmail.com with ESMTPSA id
 fl13-20020a05600c0b8d00b0040d8cd116e4sm2632002wmb.37.2024.01.10.07.53.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 07:53:37 -0800 (PST)
Message-ID: <a6b05997-cc3f-453c-93a6-66dce2cd9a2e@linaro.org>
Date: Wed, 10 Jan 2024 16:53:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/PATCH v1 09/11] gunyah: CPU execution loop
Content-Language: en-US
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>, peter.maydell@linaro.org, 
 alex.bennee@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: quic_tsoni@quicinc.com, quic_pheragu@quicinc.com,
 quic_eberman@quicinc.com, quic_yvasi@quicinc.com, quic_cvanscha@quicinc.com,
 quic_mnalajal@quicinc.com
References: <20240109090039.1636383-1-quic_svaddagi@quicinc.com>
 <20240109090039.1636383-10-quic_svaddagi@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240109090039.1636383-10-quic_svaddagi@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
> Complete the cpu execution loop. At this time, we recognize exits
> associated with only MMIO access. Future patches will add support for
> recognizing other exit reasons, such as PSCI calls made by guest.
> 
> Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
> ---
>   accel/gunyah/gunyah-accel-ops.c |   7 ++
>   accel/gunyah/gunyah-all.c       | 201 +++++++++++++++++++++++++++++++-
>   include/hw/core/cpu.h           |   1 +
>   include/sysemu/gunyah_int.h     |   9 ++
>   target/arm/gunyah.c             |  13 +++
>   5 files changed, 230 insertions(+), 1 deletion(-)


> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 238c02c05e..ef248a658b 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -371,6 +371,7 @@ struct CPUWatchpoint {
>   
>   struct KVMState;
>   struct kvm_run;
> +struct gh_vcpu_run;

Please do not forward-declare this structure here, it is not required.

>   
>   /* work queue */
>   
> diff --git a/include/sysemu/gunyah_int.h b/include/sysemu/gunyah_int.h
> index dc5b4847a9..72b3027e4e 100644
> --- a/include/sysemu/gunyah_int.h
> +++ b/include/sysemu/gunyah_int.h
> @@ -46,12 +46,21 @@ struct GUNYAHState {
>       bool preshmem_reserved;
>       uint32_t preshmem_size;
>       uint32_t nr_irqs;
> +    uint32_t vm_started;
> +};
> +
> +struct AccelCPUState {
> +    int fd;
> +    struct gh_vcpu_run *run;
>   };
>   
>   int gunyah_create_vm(void);
> +void gunyah_start_vm(void);
>   int gunyah_vm_ioctl(int type, ...);
>   void *gunyah_cpu_thread_fn(void *arg);
>   int gunyah_add_irqfd(int irqfd, int label, Error **errp);
>   GUNYAHState *get_gunyah_state(void);
> +int gunyah_arch_put_registers(CPUState *cs, int level);
> +void gunyah_cpu_synchronize_post_reset(CPUState *cpu);
>   
>   #endif    /* GUNYAH_INT_H */


