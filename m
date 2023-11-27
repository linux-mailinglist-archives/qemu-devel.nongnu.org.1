Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECD97F9839
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 05:20:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7T6m-0000WS-6O; Sun, 26 Nov 2023 23:20:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7T6Z-0000Vw-8k
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 23:20:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7T6U-0006qA-O9
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 23:20:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701058814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ks9X9JJQQewYQA3Vvy8V5vKQxKc5V+DXnMwD9d5dJC0=;
 b=jM3SN8ehvLLoUCRjz3JLgvufJ9fhrjqZ0ATCGmyTn0pQYj0p1XV8bC4qujL6Nbtlvj3coR
 rsduftIvu2K3kEKIDB+1S/AALrApFBdITFtdKkFz9M9CqvsN2CtIvZrL7FtGR6dL3qMrZd
 ZJrPUgxnGHPzM7mYg9aqe3DoZ4EhH34=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-18RcpdFLPqiAnlCMdJ8fWg-1; Sun, 26 Nov 2023 23:20:12 -0500
X-MC-Unique: 18RcpdFLPqiAnlCMdJ8fWg-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1cf9dded6fbso44232715ad.1
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 20:20:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701058811; x=1701663611;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ks9X9JJQQewYQA3Vvy8V5vKQxKc5V+DXnMwD9d5dJC0=;
 b=ZF6jAGNSbLFlXJaYBlnYvpd6JfGxmj+rRaqMdC+FdvtILthGey2ajUlOT5Pw3GTXJm
 caCptmTk5XoDnUYCyd81Yso1LP55NYWQhFc8AN6qbOAdQjI6/BEiwfJr4UoWLUck4XWI
 B3RJgZ/umRPvcNupNCI8vAtckp3JdPVBny7nTcBTH1Z51QRq9Ty1HdOaQX6DlfECAuRu
 rxWh74PasAlpGk/LJhxcPshI9+0YXFSLCxptM3XvYOCLa2QgZemZycTwtiMHB0Jtjk3J
 e4VYWjNHl9bEAYLkOq4jUw3ixoc/nsLloNlcAEcy/TWTD+4rvvdEjYYeTp6FkwKkSdPG
 TvRw==
X-Gm-Message-State: AOJu0YzLNYN7y6CVe6SLf+3rhjzidN6I3TDS5/uzdYzBSZRNx5HgB7Ns
 TTWyx2m7RD/zUFt0I5bsYdhjyWSTyoNufZjcmxfi++u39vp54+OGESVv0qLT3dI1BpupBMCBhcR
 YXx6WCxMgABgYVqQ=
X-Received: by 2002:a17:903:1ce:b0:1cf:c518:fa39 with SMTP id
 e14-20020a17090301ce00b001cfc518fa39mr3234381plh.19.1701058811230; 
 Sun, 26 Nov 2023 20:20:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9CSJyki0vMHQ9AIryxgQfnckmlDB/5/8+j7rX1uobM+7KIeXuvXQoSnSXnkPn/B6e4LTxKA==
X-Received: by 2002:a17:903:1ce:b0:1cf:c518:fa39 with SMTP id
 e14-20020a17090301ce00b001cfc518fa39mr3234375plh.19.1701058810943; 
 Sun, 26 Nov 2023 20:20:10 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 2-20020a170902c14200b001c755810f89sm7146531plj.181.2023.11.26.20.20.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 20:20:10 -0800 (PST)
Message-ID: <802e9dcd-68d2-4c38-95e8-fe99d46b911f@redhat.com>
Date: Mon, 27 Nov 2023 15:20:06 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 08/16] target/arm/kvm: Have kvm_arm_pmu_init take
 a ARMCPU argument
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20231123183518.64569-1-philmd@linaro.org>
 <20231123183518.64569-9-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123183518.64569-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Phil,

On 11/24/23 05:35, Philippe Mathieu-Daudé wrote:
> Unify the "kvm_arm.h" API: All functions related to ARM vCPUs
> take a ARMCPU* argument. Use the CPU() QOM cast macro When
> calling the generic vCPU API from "sysemu/kvm.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/kvm_arm.h | 4 ++--
>   hw/arm/virt.c        | 2 +-
>   target/arm/kvm.c     | 6 +++---
>   3 files changed, 6 insertions(+), 6 deletions(-)
> 

One nit below, but I guess it doesn't matter.

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 0e12a008ab..fde1c45609 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -200,8 +200,8 @@ int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa);
>   
>   int kvm_arm_vgic_probe(void);
>   
> +void kvm_arm_pmu_init(ARMCPU *cpu);
>   void kvm_arm_pmu_set_irq(CPUState *cs, int irq);
> -void kvm_arm_pmu_init(CPUState *cs);
>   

Why the order of the declaration is changed? I guess the reason would be
kvm_arm_pmu_init() is called prior to kvm_arm_pmu_set_irq().

>   /**
>    * kvm_arm_pvtime_init:
> @@ -263,7 +263,7 @@ static inline void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
>       g_assert_not_reached();
>   }
>   
> -static inline void kvm_arm_pmu_init(CPUState *cs)
> +static inline void kvm_arm_pmu_init(ARMCPU *cpu)
>   {
>       g_assert_not_reached();
>   }
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index b6efe9da4d..63f3c0b750 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2000,7 +2000,7 @@ static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
>                   if (kvm_irqchip_in_kernel()) {
>                       kvm_arm_pmu_set_irq(cpu, VIRTUAL_PMU_IRQ);
>                   }
> -                kvm_arm_pmu_init(cpu);
> +                kvm_arm_pmu_init(ARM_CPU(cpu));
>               }
>               if (steal_time) {
>                   kvm_arm_pvtime_init(ARM_CPU(cpu), pvtime_reg_base
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 82c5924ab5..e7cbe1ff05 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -1711,17 +1711,17 @@ static bool kvm_arm_set_device_attr(ARMCPU *cpu, struct kvm_device_attr *attr,
>       return true;
>   }
>   
> -void kvm_arm_pmu_init(CPUState *cs)
> +void kvm_arm_pmu_init(ARMCPU *cpu)
>   {
>       struct kvm_device_attr attr = {
>           .group = KVM_ARM_VCPU_PMU_V3_CTRL,
>           .attr = KVM_ARM_VCPU_PMU_V3_INIT,
>       };
>   
> -    if (!ARM_CPU(cs)->has_pmu) {
> +    if (!cpu->has_pmu) {
>           return;
>       }
> -    if (!kvm_arm_set_device_attr(ARM_CPU(cs), &attr, "PMU")) {
> +    if (!kvm_arm_set_device_attr(cpu, &attr, "PMU")) {
>           error_report("failed to init PMU");
>           abort();
>       }

Thanks,
Gavin


