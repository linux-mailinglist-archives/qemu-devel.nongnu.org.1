Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B136578E8C6
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 10:51:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbdNz-0007ZE-T1; Thu, 31 Aug 2023 04:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbdNu-0007Sx-LV
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 04:50:39 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbdNq-0004j1-15
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 04:50:37 -0400
Received: by mail-ej1-x644.google.com with SMTP id
 a640c23a62f3a-99bc9e3cbf1so112356066b.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 01:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693471832; x=1694076632; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=siRoHnxH2B5qnMc1TL/JG1FcSNJmyatvNNvU443Upsk=;
 b=RY8enBrHsFOTinCGxrEXVySUdXDBQ4ouvSGfPN19yVYFSQ+gpnFfgRUWgAXnjpF/4b
 FFUL16H4C4yE/0Z14dB/p9fpV7gKImZs4lHnC5CAu4+Vu+BX+j9FJrPwb2igBqtfSC9d
 GXM318fobHfaDBLa6RRn+9XIZlaB50yVnvDlZKGd1JgU3GE19/5gLiFuTMbl3sc11arA
 6jrH710sxV9HqmfJ7q/BzghFjgwMxVgbSbsEB2zw0Jm3V5xW6eYaU7pN82kf5L7ptoCD
 uGGF//qh1DzOwr7uxeCeGngbLex+9IjbII7mr3ggwviVAap1bXzTH4U0KxEebdGmk3Fs
 zVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693471832; x=1694076632;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=siRoHnxH2B5qnMc1TL/JG1FcSNJmyatvNNvU443Upsk=;
 b=EZcz0nN7x5EOhCZOeO/NlETx8PM4GKCNssX9auMP9JJ8B3qafFv2e19nttGx2PVRnX
 udPFGXKE/BA8UPLWNV72YqEC7+lFPuScv6pT9PKqkFjDt6GELzCjA9aT7HccGS0bPODO
 7jRsNS75y2Pmz7Bc+b8hoQQtlvFo8XVwvldKP4N1jx43sRoEvdQ7rbzmTObXbIs4qn99
 ivETBj+uedCYgydBnN9yfWjBSDlwMpAzz12/9EoKvlkqkq57J0vu5uIvudyueUlJV0KH
 mu7RR7cFMXJyivQtYA/NXdM81AS2crJOGbrY3UIKhVJv/Ba+a4o5MiNKQff6tVSsIt0Y
 LsHA==
X-Gm-Message-State: AOJu0Yx9B3KsQdG4+1I615NHvoXpgTA3jT49epkC66L6RsIUC9PLozWf
 OpwHCECOE8hDoDYjqulUKY6s+Q==
X-Google-Smtp-Source: AGHT+IGS8P79n3ppbZoNUXnWeuRYhd7XJ2EWRR/WVcFpOQNBMOVFVXROpmpjUrhi9SYLZ9Uk9JDTCg==
X-Received: by 2002:a17:906:104e:b0:9a5:9f3c:961e with SMTP id
 j14-20020a170906104e00b009a59f3c961emr2450865ejj.18.1693471832279; 
 Thu, 31 Aug 2023 01:50:32 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 o21-20020a1709062e9500b009a13fdc139fsm510051eji.183.2023.08.31.01.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 01:50:31 -0700 (PDT)
Date: Thu, 31 Aug 2023 10:50:30 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, richard.henderson@linaro.org
Subject: Re: [PATCH v2 2/2] hw/intc/riscv_aplic.c fix non-KVM --enable-debug
 build
Message-ID: <20230831-489a09cdba06b2f8a7fd4103@orel>
References: <20230830133503.711138-1-dbarboza@ventanamicro.com>
 <20230830133503.711138-3-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830133503.711138-3-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x644.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Aug 30, 2023 at 10:35:03AM -0300, Daniel Henrique Barboza wrote:
> Commit 6df0b37e2ab breaks a --enable-debug build in a non-KVM
> environment with the following error:
> 
> /usr/bin/ld: libqemu-riscv64-softmmu.fa.p/hw_intc_riscv_aplic.c.o: in function `riscv_kvm_aplic_request':
> ./qemu/build/../hw/intc/riscv_aplic.c:486: undefined reference to `kvm_set_irq'
> collect2: error: ld returned 1 exit status
> 
> This happens because the debug build will poke into the
> 'if (is_kvm_aia(aplic->msimode))' block and fail to find a reference to
> the KVM only function riscv_kvm_aplic_request().
> 
> There are multiple solutions to fix this. We'll go with the same
> solution from the previous patch, i.e. add a kvm_enabled() conditional
> to filter out the block. But there's a catch: riscv_kvm_aplic_request()
> is a local function that would end up being used if the compiler crops
> the block, and this won't work. Quoting Richard Henderson's explanation
> in [1]:
> 
> "(...) the compiler won't eliminate entire unused functions with -O0"
> 
> We'll solve it by moving riscv_kvm_aplic_request() to kvm.c and add its
> declaration in kvm_riscv.h, where all other KVM specific public
> functions are already declared. Other archs handles KVM specific code in
> this manner and we expect to do the same from now on.
> 
> [1] https://lore.kernel.org/qemu-riscv/d2f1ad02-eb03-138f-9d08-db676deeed05@linaro.org/
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  hw/intc/riscv_aplic.c    | 8 ++------
>  target/riscv/kvm.c       | 5 +++++
>  target/riscv/kvm_riscv.h | 1 +
>  3 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 592c3ce768..99aae8ccbe 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -32,6 +32,7 @@
>  #include "target/riscv/cpu.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/kvm.h"
> +#include "kvm_riscv.h"
>  #include "migration/vmstate.h"
>  
>  #define APLIC_MAX_IDC                  (1UL << 14)
> @@ -481,11 +482,6 @@ static uint32_t riscv_aplic_idc_claimi(RISCVAPLICState *aplic, uint32_t idc)
>      return topi;
>  }
>  
> -static void riscv_kvm_aplic_request(void *opaque, int irq, int level)
> -{
> -    kvm_set_irq(kvm_state, irq, !!level);
> -}
> -
>  static void riscv_aplic_request(void *opaque, int irq, int level)
>  {
>      bool update = false;
> @@ -840,7 +836,7 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
>       * have IRQ lines delegated by their parent APLIC.
>       */
>      if (!aplic->parent) {
> -        if (is_kvm_aia(aplic->msimode)) {
> +        if (kvm_enabled() && is_kvm_aia(aplic->msimode)) {
>              qdev_init_gpio_in(dev, riscv_kvm_aplic_request, aplic->num_irqs);
>          } else {
>              qdev_init_gpio_in(dev, riscv_aplic_request, aplic->num_irqs);
> diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
> index faee8536ef..ac28a70723 100644
> --- a/target/riscv/kvm.c
> +++ b/target/riscv/kvm.c
> @@ -46,6 +46,11 @@
>  #include "sysemu/runstate.h"
>  #include "hw/riscv/numa.h"
>  
> +void riscv_kvm_aplic_request(void *opaque, int irq, int level)
> +{
> +    kvm_set_irq(kvm_state, irq, !!level);
> +}
> +
>  static uint64_t kvm_riscv_reg_id(CPURISCVState *env, uint64_t type,
>                                   uint64_t idx)
>  {
> diff --git a/target/riscv/kvm_riscv.h b/target/riscv/kvm_riscv.h
> index 7d4b7c60e2..de8c209ebc 100644
> --- a/target/riscv/kvm_riscv.h
> +++ b/target/riscv/kvm_riscv.h
> @@ -26,5 +26,6 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
>                            uint64_t aia_irq_num, uint64_t aia_msi_num,
>                            uint64_t aplic_base, uint64_t imsic_base,
>                            uint64_t guest_num);
> +void riscv_kvm_aplic_request(void *opaque, int irq, int level);
>  
>  #endif
> -- 
> 2.41.0
> 
>

I'd also try the always_inline trick with is_kvm_aia(), particularly
because now we're inconsistent with how it's used. In two of the three
places it's called we don't guard it with kvm_enabled().

But, I'm also mostly OK with this, so

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

