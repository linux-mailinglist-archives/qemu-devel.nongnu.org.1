Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B35749743
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 10:17:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHKAw-0002Bp-EZ; Thu, 06 Jul 2023 04:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1qHKAs-0002AY-Ri
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:17:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1qHKAp-0007cr-4Y
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688631427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ak63oS2wbQ//CZ4bFZf9UUgZgbNOOrgNyyi0Qi15lYM=;
 b=GaZlC38I0hRdz3HmpIRGS7Xk0kt3wj/CJWCBflJLgEoV6rei79GJb9m4osaW2pVOsCF0PL
 DqAopEFj4n3ClmY82SMVY/TW4d4n3ISnwF6h4vULXcjisj1irTR+r75WnvjPUMy3PoX8vw
 WHB01XMFThwF1TS+8Z39e/gIE18PQkY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-kZdO0zFYPUC0DQOHNVM7qA-1; Thu, 06 Jul 2023 04:17:06 -0400
X-MC-Unique: kZdO0zFYPUC0DQOHNVM7qA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6237c937691so12254576d6.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 01:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688631426; x=1691223426;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ak63oS2wbQ//CZ4bFZf9UUgZgbNOOrgNyyi0Qi15lYM=;
 b=EsY9kk/ktbyCQboQfEHu2v7MIcaAAS05ovTc3bRWMQqDtZJ3NDAzXuK9a2krg9F0su
 R00ujhA0UMf/CRbxQf8cspWz7jMqhZY1Jkdku0z70F/9PcN5VcTNv/oSDfDbV19by4qV
 L4dY6qy+CutcawHJ2emvs2cK4eVqFCfPzR5emPrSkix60idquLzNFPZPfl20CkHnQZIz
 8HhqN8sYiUwQV5VFbugz6h/5MRNCAlOFni5NBIMWeZ2YQFR5Vh8049eyuNmT0GRYxvDv
 0ai9/pJqqqJxUr4LKN9addaQO0/3oZq9LnGtiZRAN1SpbpVHSDkk3SRLV8MLMfG3mPYa
 MiKA==
X-Gm-Message-State: ABy/qLaAusyZ+atXJnx5v+pScenWsJ/DAdPWrS8YhwpfMduL5EHzXGbR
 MhQD5wyfDgvvENcCaerCdf2UEXWNppecmOtKJJcOR/+EbN4fpQ9XBcegfoOJX+uZnqjkqwnsiZc
 AW78VlGezCuuoZRo=
X-Received: by 2002:a05:6214:242a:b0:62d:e73b:c4ab with SMTP id
 gy10-20020a056214242a00b0062de73bc4abmr6032390qvb.1.1688631426255; 
 Thu, 06 Jul 2023 01:17:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHC6UA3pnbWYiiPmpgO16Ohru9iIDPOolHdm2aD5gGhok6K5mFNUQ8I10tpXZgQOO7e5LXt4Q==
X-Received: by 2002:a05:6214:242a:b0:62d:e73b:c4ab with SMTP id
 gy10-20020a056214242a00b0062de73bc4abmr6032372qvb.1.1688631425966; 
 Thu, 06 Jul 2023 01:17:05 -0700 (PDT)
Received: from [192.168.1.91] (176-152-201-187.abo.bbox.fr. [176.152.201.187])
 by smtp.gmail.com with ESMTPSA id
 a25-20020a0ca999000000b0063645f62bdasm592176qvb.80.2023.07.06.01.17.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 01:17:05 -0700 (PDT)
Message-ID: <acb446c4-dddb-30f6-5faf-e976fbe0c605@redhat.com>
Date: Thu, 6 Jul 2023 10:16:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC PATCH 4/5] target/arm: enable feature ARM_FEATURE_EL2 if EL2
 is supported
Content-Language: en-US
To: Miguel Luis <miguel.luis@oracle.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Haibo Xu <haibo.xu@linaro.org>,
 Andrew Jones <drjones@redhat.com>, Marc Zyngier <maz@kernel.org>
References: <20230227163718.62003-1-miguel.luis@oracle.com>
 <20230227163718.62003-5-miguel.luis@oracle.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20230227163718.62003-5-miguel.luis@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Miguel,

On 2/27/23 17:37, Miguel Luis wrote:
> From: Haibo Xu <haibo.xu@linaro.org>
> 
> KVM_CAP_ARM_EL2 must be supported by the cpu to enable ARM_FEATURE_EL2.
> EL2 bits on ID_AA64PFR0 state unsupported on the value 0b0000.
> 
> Ref: https://lore.kernel.org/qemu-devel/b7c2626e6c720ccc43e57197dff3dac72d613640.1616052890.git.haibo.xu@linaro.org/
> 
> Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
> [Miguel Luis: use of ID_AA64PFR0 for cpu features]
> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
> ---
>  target/arm/cpu.h   |  2 +-
>  target/arm/kvm64.c | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 9aeed3c848..de2a88b43e 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -3961,7 +3961,7 @@ static inline bool isar_feature_aa64_aa32_el1(const ARMISARegisters *id)
>  
>  static inline bool isar_feature_aa64_aa32_el2(const ARMISARegisters *id)
>  {
> -    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, EL2) >= 2;
> +    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, EL2) != 0;
>  }
>  
>  static inline bool isar_feature_aa64_ras(const ARMISARegisters *id)
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index be8144a2b5..f7ebd731aa 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -505,6 +505,7 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>       */
>      int fdarray[3];
>      bool sve_supported;
> +    bool el2_supported;
>      bool pmu_supported = false;
>      uint64_t features = 0;
>      int err;
> @@ -535,6 +536,14 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>          init.features[0] |= 1 << KVM_ARM_VCPU_SVE;
>      }
>  
> +    /*
> +     * Ask for EL2 if supported.
> +     */
> +    el2_supported = kvm_arm_el2_supported();
> +    if (el2_supported) {
> +        init.features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2;
This doesn't work if your host both supports SVE & NV.

The error output by qemu is not straightforward

qemu-system-aarch64: can't apply global host-arm-cpu.sve=off: Property
'host-arm-cpu.sve' not found

The problem is that we create a scratch VM with a CPU featuring both SVE
and NV and this fails at kernel level, I think on vcpu reset.

The trouble is that we do that even if sve=off at qemu level. So I think
this is a more generic issue related to the way we validate host cpu
features.

Thanks

Eric


> +    }
> +
>      /*
>       * Ask for Pointer Authentication if supported, so that we get
>       * the unsanitized field values for AA64ISAR1_EL1.
> @@ -714,6 +723,10 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>      features |= 1ULL << ARM_FEATURE_PMU;
>      features |= 1ULL << ARM_FEATURE_GENERIC_TIMER;
>  
> +    if (el2_supported) {
> +        features |= 1ULL << ARM_FEATURE_EL2;
> +    }
> +
>      ahcf->features = features;
>  
>      return true;
> @@ -881,6 +894,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          assert(kvm_arm_sve_supported());
>          cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_SVE;
>      }
> +    if (cpu_isar_feature(aa64_aa32_el2, cpu)) {
> +        cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2;
> +    }
>      if (cpu_isar_feature(aa64_pauth, cpu)) {
>          cpu->kvm_init_features[0] |= (1 << KVM_ARM_VCPU_PTRAUTH_ADDRESS |
>                                        1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);


