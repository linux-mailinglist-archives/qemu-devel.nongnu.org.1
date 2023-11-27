Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA1B7F981C
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 05:06:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7SsU-00027K-U5; Sun, 26 Nov 2023 23:05:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7Ss6-000254-9s
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 23:05:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7Ss3-0004Vp-Oo
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 23:05:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701057917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hsPrLRr4JtnyZHwPvSCPAzP5Lsw6mGAeuHQscrepkcM=;
 b=AyrfaEgNzrjJbx2N6k7UWO3ozst3HbdUzJ5ZBWd4NNARN+47AvXMMrL2B/rfgWD0XQrJcl
 PXBPrW1Qz5tdudp5WBm1uoYdMfIVP5LPS/A3JBhcTV6bbzNcRcZh6iSnpYBrnviroTmSRi
 QljG2CVj0kTLewNMUoLGMmdXffqyw2o=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-VxZIyM4UO16XldiqNLJKBg-1; Sun, 26 Nov 2023 23:05:15 -0500
X-MC-Unique: VxZIyM4UO16XldiqNLJKBg-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1cfc2a7e382so13243775ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 20:05:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701057914; x=1701662714;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hsPrLRr4JtnyZHwPvSCPAzP5Lsw6mGAeuHQscrepkcM=;
 b=uEBp+fmUp3mlsG9EH7xBn5DHA8m50zVfLBADSIPjXhVtYXJeqmA9Yunqy2oqIZ3S+u
 Otmqd4I10SwanyH8RxMu8maSdiTkHzldxjU2pVrLyenaaVzFX/NgG4zUUjFRfN/oe3XK
 6jOKSSF06cjPCLPD+lRTWkrT5B9kp0uef/g0WObGEYfukSoL8AqmYPv82HXn/klcYae4
 5zyKmwcYGWRrciRROP1GHuBetuxhNuKqWyWKq0mckG2WMXlhHSXkyK0IgrnWGu6Fr98U
 FQxLvB1UP9RAptPHRhYEajPXI+p5iyXPgG+S6I9/I/iSq9dRJF9cMQExgpgKcAm5MxPX
 QoEQ==
X-Gm-Message-State: AOJu0YwbcLUoGVcOd9SmifUCJCYdB8qtqD0JBW/00eHF563bgUkkZolI
 lVMDrNcdGxnW6obLGYxcw+/HUFVkhMjchsCrMIZFF5SiqvSAkAwc09r9tqOkad8Lj6QBpefSsXV
 MWsfK1yRKlvQ5Dx8=
X-Received: by 2002:a17:902:c40d:b0:1cf:59ad:9637 with SMTP id
 k13-20020a170902c40d00b001cf59ad9637mr20268644plk.22.1701057914665; 
 Sun, 26 Nov 2023 20:05:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHE7fQJkDMi7BdyUV6ds2GyN5xdLkRIecybDLxFrZYXlc1bSaJ0J5/yXn6LKfFnuQCG1vx95Q==
X-Received: by 2002:a17:902:c40d:b0:1cf:59ad:9637 with SMTP id
 k13-20020a170902c40d00b001cf59ad9637mr20268627plk.22.1701057914327; 
 Sun, 26 Nov 2023 20:05:14 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 c1-20020a170902d48100b001c9c8d761a3sm7102998plg.131.2023.11.26.20.05.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 20:05:14 -0800 (PST)
Message-ID: <52cf8040-b134-4dc6-b6ce-1d51a3dc13ef@redhat.com>
Date: Mon, 27 Nov 2023 15:05:09 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 03/16] target/arm/kvm: Have
 kvm_arm_add_vcpu_properties take a ARMCPU argument
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20231123183518.64569-1-philmd@linaro.org>
 <20231123183518.64569-4-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123183518.64569-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Phil,

On 11/24/23 05:35, Philippe Mathieu-Daudé wrote:
> Unify the "kvm_arm.h" API: All functions related to ARM vCPUs
> take a ARMCPU* argument. Use the CPU() QOM cast macro When
> calling the generic vCPU API from "sysemu/kvm.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/kvm_arm.h | 4 ++--
>   target/arm/cpu.c     | 2 +-
>   target/arm/kvm.c     | 4 ++--
>   3 files changed, 5 insertions(+), 5 deletions(-)
> 

With the following comments resolved:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 50967f4ae9..6fb8a5f67e 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -153,7 +153,7 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
>    * Add all KVM specific CPU properties to the CPU object. These
>    * are the CPU properties with "kvm-" prefixed names.
>    */
> -void kvm_arm_add_vcpu_properties(Object *obj);
> +void kvm_arm_add_vcpu_properties(ARMCPU *cpu);
>   

The function's description needs to be modified since @obj has been
renamed to @cpu?

   /**
    * kvm_arm_add_vcpu_properties:
    * @obj: The CPU object to add the properties to
    *
    */

>   /**
>    * kvm_arm_steal_time_finalize:
> @@ -243,7 +243,7 @@ static inline void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
>       g_assert_not_reached();
>   }
>   
> -static inline void kvm_arm_add_vcpu_properties(Object *obj)
> +static inline void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
>   {
>       g_assert_not_reached();
>   }
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 25e9d2ae7b..97081e0c70 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1686,7 +1686,7 @@ void arm_cpu_post_init(Object *obj)
>       }
>   
>       if (kvm_enabled()) {
> -        kvm_arm_add_vcpu_properties(obj);
> +        kvm_arm_add_vcpu_properties(cpu);
>       }
>   
>   #ifndef CONFIG_USER_ONLY
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 6e3fea1879..03195f5627 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -495,10 +495,10 @@ static void kvm_steal_time_set(Object *obj, bool value, Error **errp)
>   }
>   
>   /* KVM VCPU properties should be prefixed with "kvm-". */
> -void kvm_arm_add_vcpu_properties(Object *obj)
> +void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
>   {
> -    ARMCPU *cpu = ARM_CPU(obj);
>       CPUARMState *env = &cpu->env;
> +    Object *obj = OBJECT(cpu);
>   
>       if (arm_feature(env, ARM_FEATURE_GENERIC_TIMER)) {
>           cpu->kvm_adjvtime = true;

Thanks,
Gavin


