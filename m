Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 052CD7C87D8
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 16:28:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrJ8r-0003vV-9O; Fri, 13 Oct 2023 10:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrJ8p-0003uC-8X
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:27:51 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrJ8k-0007eu-KO
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:27:51 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c87a85332bso18741885ad.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 07:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697207265; x=1697812065; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NRBjBCXdj5645/oaM7yusVIiSfhhU8aAoSEGZ6gLR7A=;
 b=VpTq/HCMku2fLbLtd2YCgeePICzvPNcS5B+Y/s5dGT/OhsUpoNhQaAHUknJVryiykp
 mgfl3wtfUDV+IpgetwDCZBhDWF4MyiogP1sRbQgeRf7ciGMGfM23mGOV4vMhaPoV5MLO
 LKFtOPRkX2sQqsRtk+hKv20opi+2nEkwvggZt3UxLd241nhMlgVRIhQPcHJmmvQ+WqHK
 MXwb8VvppELJJ6XsPjN3qd4fokTjmLhviVG9OQDvivNDF+Z4Vz4Fiv6x4dTeuV68yjv9
 JM3/+QXzelug6CoIaUqjoCBgOSEmuG8KoDD8RMtu4Q+rz0WrErJkxzh/0VDY2gstaR5Z
 gwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697207265; x=1697812065;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NRBjBCXdj5645/oaM7yusVIiSfhhU8aAoSEGZ6gLR7A=;
 b=aYNqYoqFTaiAlv/EcbhYOsxJO1gFBl4cWwXU1Op25vLiFGdViqUGzesOjBMmJjI5z0
 OTbJyZSOAb7g1b2iLHiXpzoYsyX1BhgHGzi7y+k7SpkZdPpiPaiCB5NEHyvucRjlPdjh
 AYB7qScBmBlOO4mHb3QXY9EgIgCqY2mrO5tunISLHKzsOYR5SmbkXT0Ei7lDlZly+z35
 EIrz+quPs9sBnMKFqebLwITanjdAbj/1XnCaGYef21ZzgyIK6nAnoJzcdvNfB09euwFO
 Wde5gegOXeiFd+LGxlKQAKjzIjDnx89D8UTX/sojpZcIOrTwCIT075LJzHLxTdargpYh
 k3xA==
X-Gm-Message-State: AOJu0YwU8mwdiXNESdv4EyLjE5+y871QIiSPCFXefBqsAcxQWU3pUuYX
 RCBVYf8453oRkMfnOa5vn07D6iCsy6zJ2Ck0+3U=
X-Google-Smtp-Source: AGHT+IEv7T9CtlbY7pmBIbljMbn6Soedih3sMbh+lmLWNDt5x1JOvdv0/Mwpaqi1TRv1v47C1rLyuQ==
X-Received: by 2002:a17:902:f688:b0:1c9:e830:160d with SMTP id
 l8-20020a170902f68800b001c9e830160dmr3928922plg.22.1697207265110; 
 Fri, 13 Oct 2023 07:27:45 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 e7-20020a17090301c700b001b3bf8001a9sm3958048plh.48.2023.10.13.07.27.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 07:27:44 -0700 (PDT)
Message-ID: <64733bf8-58bb-4176-927f-f17c33fa3846@linaro.org>
Date: Fri, 13 Oct 2023 07:27:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] target/arm: Move internal declarations from
 'cpu-qom.h' to 'cpu.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231013140116.255-1-philmd@linaro.org>
 <20231013140116.255-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231013140116.255-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 10/13/23 07:01, Philippe Mathieu-Daudé wrote:
> These definitions and declarations are only used by
> target/arm/, no need to expose them to generic hw/.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/cpu-qom.h | 28 ----------------------------
>   target/arm/cpu.h     | 28 ++++++++++++++++++++++++++++
>   2 files changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
> index dfb9d5b827..35c3b0924e 100644
> --- a/target/arm/cpu-qom.h
> +++ b/target/arm/cpu-qom.h
> @@ -35,9 +35,6 @@ typedef struct ARMCPUInfo {
>       void (*class_init)(ObjectClass *oc, void *data);
>   } ARMCPUInfo;
>   
> -void arm_cpu_register(const ARMCPUInfo *info);
> -void aarch64_cpu_register(const ARMCPUInfo *info);
> -
>   /**
>    * ARMCPUClass:
>    * @parent_realize: The parent class' realize handler.
> @@ -63,29 +60,4 @@ struct AArch64CPUClass {
>       ARMCPUClass parent_class;
>   };
>   
> -void register_cp_regs_for_features(ARMCPU *cpu);
> -void init_cpreg_list(ARMCPU *cpu);
> -
> -/* Callback functions for the generic timer's timers. */
> -void arm_gt_ptimer_cb(void *opaque);
> -void arm_gt_vtimer_cb(void *opaque);
> -void arm_gt_htimer_cb(void *opaque);
> -void arm_gt_stimer_cb(void *opaque);
> -void arm_gt_hvtimer_cb(void *opaque);
> -
> -#define ARM_AFF0_SHIFT 0
> -#define ARM_AFF0_MASK  (0xFFULL << ARM_AFF0_SHIFT)
> -#define ARM_AFF1_SHIFT 8
> -#define ARM_AFF1_MASK  (0xFFULL << ARM_AFF1_SHIFT)
> -#define ARM_AFF2_SHIFT 16
> -#define ARM_AFF2_MASK  (0xFFULL << ARM_AFF2_SHIFT)
> -#define ARM_AFF3_SHIFT 32
> -#define ARM_AFF3_MASK  (0xFFULL << ARM_AFF3_SHIFT)
> -#define ARM_DEFAULT_CPUS_PER_CLUSTER 8
> -
> -#define ARM32_AFFINITY_MASK (ARM_AFF0_MASK|ARM_AFF1_MASK|ARM_AFF2_MASK)
> -#define ARM64_AFFINITY_MASK \
> -    (ARM_AFF0_MASK|ARM_AFF1_MASK|ARM_AFF2_MASK|ARM_AFF3_MASK)
> -#define ARM64_AFFINITY_INVALID (~ARM64_AFFINITY_MASK)
> -
>   #endif
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index fb1b08371c..06f92dacb9 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1116,11 +1116,39 @@ struct ArchCPU {
>       uint64_t gt_cntfrq_hz;
>   };
>   
> +/* Callback functions for the generic timer's timers. */
> +void arm_gt_ptimer_cb(void *opaque);
> +void arm_gt_vtimer_cb(void *opaque);
> +void arm_gt_htimer_cb(void *opaque);
> +void arm_gt_stimer_cb(void *opaque);
> +void arm_gt_hvtimer_cb(void *opaque);
> +
>   unsigned int gt_cntfrq_period_ns(ARMCPU *cpu);
>   void gt_rme_post_el_change(ARMCPU *cpu, void *opaque);
>   
>   void arm_cpu_post_init(Object *obj);
>   
> +void arm_cpu_register(const ARMCPUInfo *info);
> +void aarch64_cpu_register(const ARMCPUInfo *info);
> +
> +void register_cp_regs_for_features(ARMCPU *cpu);
> +void init_cpreg_list(ARMCPU *cpu);

These can go to internals.h.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> +
> +#define ARM_AFF0_SHIFT 0
> +#define ARM_AFF0_MASK  (0xFFULL << ARM_AFF0_SHIFT)
> +#define ARM_AFF1_SHIFT 8
> +#define ARM_AFF1_MASK  (0xFFULL << ARM_AFF1_SHIFT)
> +#define ARM_AFF2_SHIFT 16
> +#define ARM_AFF2_MASK  (0xFFULL << ARM_AFF2_SHIFT)
> +#define ARM_AFF3_SHIFT 32
> +#define ARM_AFF3_MASK  (0xFFULL << ARM_AFF3_SHIFT)
> +#define ARM_DEFAULT_CPUS_PER_CLUSTER 8
> +
> +#define ARM32_AFFINITY_MASK (ARM_AFF0_MASK|ARM_AFF1_MASK|ARM_AFF2_MASK)
> +#define ARM64_AFFINITY_MASK \
> +    (ARM_AFF0_MASK|ARM_AFF1_MASK|ARM_AFF2_MASK|ARM_AFF3_MASK)
> +#define ARM64_AFFINITY_INVALID (~ARM64_AFFINITY_MASK)
> +
>   uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz);
>   
>   #ifndef CONFIG_USER_ONLY


