Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3F77F96BC
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 01:12:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7PEK-0000k0-Nz; Sun, 26 Nov 2023 19:12:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7PEH-0000jX-So
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:12:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7PEG-0006tV-Bh
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:12:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701043918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mj73oNwZImEBHZ5ukMSdx7Sj7ioh2bLGukWSyDfwr2I=;
 b=Caw0xZ+ffBcmmuTpODNk9TEg1R7BQ8YI0ADMAHoMBjW2MF+HH601z1wyla26qdkY3y0dg0
 it0Z/l6M4EEQNeOyXozjUB5PTlStTPJ3XLfMpZtcEt7uaMy1b+KWtNed4fvSdvCDIpsz0q
 8Sb2r6ZBk33GpRah0TLv39XOxgepmE8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-l7EEBv21OFyhI2s1JrhuDg-1; Sun, 26 Nov 2023 19:11:57 -0500
X-MC-Unique: l7EEBv21OFyhI2s1JrhuDg-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1cf7ff75820so43847645ad.1
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 16:11:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701043916; x=1701648716;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mj73oNwZImEBHZ5ukMSdx7Sj7ioh2bLGukWSyDfwr2I=;
 b=AGNQ8SBi3l7coy13ZNSruZiGZPCjmiJ2up621ExHtA+4whPJO2QcfMnF2tHfumYZKT
 i1VW3MeM2w67ImiTJA61Jb3m3ky55C49zqHJFhEhqEtZv+l2DHvf6opGsfGM3uK9IDKt
 +wlLozNnN0IuzxUwGAB2jos71Tz3SNH8vOb5Mh1rsJ8fbd/3IGijsceQoOEmM1/Vv80u
 Uk+AismjeaQvBIZsUBt6BpnPlIJktZsBdyKJpJYOU5R4VxO1B992t35/7q80J2T5ZpA+
 e173H5MIgYC3du2ovC6eguK0RmTWu8a0Ndmyc+xNlOPGwD2T6bwwhr3bIkHdAFLhzmmK
 8aEA==
X-Gm-Message-State: AOJu0Yz0hSOnWDbkp0D5ZewrAnM+1d+eOUk1sDmAw6Hr4R6nDjk8hQ7H
 gNG+4ED3+MZ7s6pSwS00Uhq/TkpSiM4zl6cksVzOTUmTlrFGDIyTc5nARbm7y7Wqk85bNGJxkLh
 HSB82c8kI26hfj00=
X-Received: by 2002:a17:903:183:b0:1cf:68a3:d908 with SMTP id
 z3-20020a170903018300b001cf68a3d908mr11041066plg.24.1701043916226; 
 Sun, 26 Nov 2023 16:11:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdWIqNOdDol4ESoS+DoqQqJmMWdRjgdGACHWpO3/AMpLqsjSZvlGKGe50rBLcDTQ3znXl1BA==
X-Received: by 2002:a17:903:183:b0:1cf:68a3:d908 with SMTP id
 z3-20020a170903018300b001cf68a3d908mr11041054plg.24.1701043915882; 
 Sun, 26 Nov 2023 16:11:55 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 t14-20020a1709027fce00b001cf5d1c85cdsm7100509plb.218.2023.11.26.16.11.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 16:11:55 -0800 (PST)
Message-ID: <04ea22ec-1b3c-4509-8874-d0c92d50b843@redhat.com>
Date: Mon, 27 Nov 2023 11:11:52 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/21] target/arm/kvm: Move
 kvm_arm_reg_syncs_via_cpreg_list and unexport
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-14-richard.henderson@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123044219.896776-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Richard,

On 11/23/23 15:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm_arm.h | 10 ----------
>   target/arm/kvm.c     | 23 +++++++++++++++++++++++
>   target/arm/kvm64.c   | 15 ---------------
>   3 files changed, 23 insertions(+), 25 deletions(-)
> 

With the following nits addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 2755ee8366..1043123cc7 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -77,16 +77,6 @@ void kvm_arm_register_device(MemoryRegion *mr, uint64_t devid, uint64_t group,
>    */
>   int kvm_arm_init_cpreg_list(ARMCPU *cpu);
>   
> -/**
> - * kvm_arm_reg_syncs_via_cpreg_list:
> - * @regidx: KVM register index
> - *
> - * Return true if this KVM register should be synchronized via the
> - * cpreg list of arbitrary system registers, false if it is synchronized
> - * by hand using code in kvm_arch_get/put_registers().
> - */
> -bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx);
> -
>   /**
>    * write_list_to_kvmstate:
>    * @cpu: ARMCPU
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index dadc3fd755..9bca6baf35 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -740,6 +740,29 @@ static uint64_t *kvm_arm_get_cpreg_ptr(ARMCPU *cpu, uint64_t regidx)
>       return &cpu->cpreg_values[res - cpu->cpreg_indexes];
>   }
>   
> +/**
> + * kvm_arm_reg_syncs_via_cpreg_list:
> + * @regidx: KVM register index
> + *
> + * Return true if this KVM register should be synchronized via the
> + * cpreg list of arbitrary system registers, false if it is synchronized
> + * by hand using code in kvm_arch_get/put_registers().
> + */
> +static bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
> +{
> +    /* Return true if the regidx is a register we should synchronize
> +     * via the cpreg_tuples array (ie is not a core or sve reg that
> +     * we sync by hand in kvm_arch_get/put_registers())
> +     */

The comments are fully or partially duplicate to the function's description above.
I think the comments here can be dropped or combined to the function's descrption
above.

> +    switch (regidx & KVM_REG_ARM_COPROC_MASK) {
> +    case KVM_REG_ARM_CORE:
> +    case KVM_REG_ARM64_SVE:
> +        return false;
> +    default:
> +        return true;
> +    }
> +}
> +
>   /* Initialize the ARMCPU cpreg list according to the kernel's
>    * definition of what CPU registers it knows about (and throw away
>    * the previous TCG-created cpreg list).
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index a184cca4dc..52c0a6d3af 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -346,21 +346,6 @@ int kvm_arch_destroy_vcpu(CPUState *cs)
>       return 0;
>   }
>   
> -bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
> -{
> -    /* Return true if the regidx is a register we should synchronize
> -     * via the cpreg_tuples array (ie is not a core or sve reg that
> -     * we sync by hand in kvm_arch_get/put_registers())
> -     */
> -    switch (regidx & KVM_REG_ARM_COPROC_MASK) {
> -    case KVM_REG_ARM_CORE:
> -    case KVM_REG_ARM64_SVE:
> -        return false;
> -    default:
> -        return true;
> -    }
> -}
> -
>   /* Callers must hold the iothread mutex lock */
>   static void kvm_inject_arm_sea(CPUState *c)
>   {

Thanks,
Gavin


