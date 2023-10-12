Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1757C7629
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 20:51:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr0kr-0006nd-Vy; Thu, 12 Oct 2023 14:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qr0kf-0006nC-27
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 14:49:41 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qr0kd-0000v9-Cp
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 14:49:40 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68bed2c786eso1001302b3a.0
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 11:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1697136578; x=1697741378; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZeTar64N6wuohyz8CUDjvsEqQJWU9Kuliy7gzDa7hn0=;
 b=LwZD5yMhY1zq+UhLnO6goe1E/Hj/Fokplf0Osn9PrcWbWni1wlz5dN4yvUjmJMFz5s
 3SzXSRdTk8qDX+0TFRTgHimozMCgXMtwPn16asoWsWcjehs49DOmvIyxD81avizuLquA
 vCBe8gh+xZawBsMZOQ57P51NuQ8frrwlmKM8B7zykx6k+KC0vfm1JIgG/61/1d79wr97
 QVTLSkJ6rmEc3A9A24587PML2U7vl6+PbE+VhbV8zVRytmy5q737ysjFLf1XYzCierit
 NQER8wRsHeNYWt7tFBAUdZKLYkMQkIRA5IbYtAKe2ZP20TRMSOPwVuOiLoVtvVuz7zup
 uakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697136578; x=1697741378;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZeTar64N6wuohyz8CUDjvsEqQJWU9Kuliy7gzDa7hn0=;
 b=qVsL/ASMLDRe+gpgB1dM7iWl97H6CztFHiyKJcgZtFnzg0KVQ3yWt2NcWKCrCgM7fT
 iQlDFMenR5PymO5sfuxEWuzMrxln3DnmA/9IXbnIx0BUkley/M/JJYmNDKqapWNsR7qd
 48n7StKCxIW4b+NmwYKG1Y52PXT97NdxV/KkIjdtWIuZMIDkEAuc4G5uKQCfjsb/z+QG
 cqYwDRt37v0KayvqVOM18TqPU8HKWuOp6SoD5gj1HHoVQbf5lWOPWh9ZcpbIB3r0wDkL
 joWjgCAZQUNChbjWwjuALVzncOvXesB3CTJRddnHMLoTfBjNqQgn5Pomq6TufiJviyIO
 Ii4w==
X-Gm-Message-State: AOJu0YwBojyoHwHgd3q2T6K/X7kbQ9xD4IDIKG6dBjp0qSNZHEFaXWrH
 vlrNQBoXbJVJ5MC5br87xhhTdg==
X-Google-Smtp-Source: AGHT+IHXsKDRBEja5bS4niSX3rriCA/HCrphDhhcOr6uXCeeOpkaZuBWwysGc/uNrFFtJ7zPVJQzQA==
X-Received: by 2002:a05:6a00:16cd:b0:68b:a137:3739 with SMTP id
 l13-20020a056a0016cd00b0068ba1373739mr26088031pfc.4.1697136577853; 
 Thu, 12 Oct 2023 11:49:37 -0700 (PDT)
Received: from [192.168.68.107] ([177.94.42.196])
 by smtp.gmail.com with ESMTPSA id
 y21-20020aa78555000000b0068fe9f23bf4sm12093155pfn.103.2023.10.12.11.49.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 11:49:37 -0700 (PDT)
Message-ID: <eddb484d-9134-4930-8b2f-c2f21b0b93d7@ventanamicro.com>
Date: Thu, 12 Oct 2023 15:49:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] sysemu/kvm: Restrict kvmppc_get_radix_page_info()
 to ppc targets
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Greg Kurz <groug@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20231003070427.69621-1-philmd@linaro.org>
 <20231003070427.69621-2-philmd@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231003070427.69621-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x431.google.com
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



On 10/3/23 04:04, Philippe Mathieu-Daudé wrote:
> kvm_get_radix_page_info() is only defined for ppc targets (in
> target/ppc/kvm.c). The declaration is not useful in other targets,
> reduce its scope.
> Rename using the 'kvmppc_' prefix following other declarations
> from target/ppc/kvm_ppc.h.
> 
> Suggested-by: Michael Tokarev <mjt@tls.msk.ru>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---



Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>


>   include/sysemu/kvm.h | 1 -
>   target/ppc/kvm.c     | 4 ++--
>   2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index ee9025f8e9..3bcd8f45be 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -551,7 +551,6 @@ int kvm_set_one_reg(CPUState *cs, uint64_t id, void *source);
>    * Returns: 0 on success, or a negative errno on failure.
>    */
>   int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target);
> -struct ppc_radix_page_info *kvm_get_radix_page_info(void);
>   int kvm_get_max_memslots(void);
>   
>   /* Notify resamplefd for EOI of specific interrupts. */
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 51112bd367..19fe6d2d00 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -268,7 +268,7 @@ static void kvm_get_smmu_info(struct kvm_ppc_smmu_info *info, Error **errp)
>                        "KVM failed to provide the MMU features it supports");
>   }
>   
> -struct ppc_radix_page_info *kvm_get_radix_page_info(void)
> +static struct ppc_radix_page_info *kvmppc_get_radix_page_info(void)
>   {
>       KVMState *s = KVM_STATE(current_accel());
>       struct ppc_radix_page_info *radix_page_info;
> @@ -2372,7 +2372,7 @@ static void kvmppc_host_cpu_class_init(ObjectClass *oc, void *data)
>       }
>   
>   #if defined(TARGET_PPC64)
> -    pcc->radix_page_info = kvm_get_radix_page_info();
> +    pcc->radix_page_info = kvmppc_get_radix_page_info();
>   
>       if ((pcc->pvr & 0xffffff00) == CPU_POWERPC_POWER9_DD1) {
>           /*

