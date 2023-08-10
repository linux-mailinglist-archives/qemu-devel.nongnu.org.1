Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4F1777702
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 13:31:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU3r4-0002cL-Ot; Thu, 10 Aug 2023 07:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qU3r2-0002VO-19
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 07:29:24 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qU3qy-0002FA-JQ
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 07:29:23 -0400
Received: by mail-ed1-x541.google.com with SMTP id
 4fb4d7f45d1cf-522bd411679so983727a12.0
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 04:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1691666958; x=1692271758;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Bh7Sj+kqkRV0gqlbNRjiH2S8kOFmPRbp90ZFvA+uUh8=;
 b=njS7eVWH5G+R+/A4ergoX3MehKu1XSxT1vmjDt7KX4+LQTgyFZ5Ky6E7UcdqTAziwW
 WNktRK+SL2+d6nrpD1mo+onRX5spVPZNNFDOiC5eVkUWhssc4PFO0HShTbEQQZA1cyd1
 gt6paar0QrRZnkKxS8DZmXy8Ribt90VlUCZDfZqGel68ZsZP3oBwmuxMoDZvkSsf768d
 hIvFC2DbqEEa5CdEw0Kua0EPlJuEdC+gOiKSUW8rgV3lLKJK/+tc4nN6JLe774bV5apq
 k1MKTOnBftYiWmVA2QlOIH5nTXdijG0j7v3tNCzC4kGpu5r0EJcI6dkve/gA2QLqKECE
 hKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691666958; x=1692271758;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bh7Sj+kqkRV0gqlbNRjiH2S8kOFmPRbp90ZFvA+uUh8=;
 b=G0acpfjFWc0tpZVyvsQGcjVYuqVEkMFyDWl2eY6pjHDNCtElXsfx/hqJWRy46OMX3V
 11Z8cNl4Ga3P7INb02tx0OC/ZQQsLcWH5bEMtIMszignGYqiiGghElfTEZvCpPQWK92u
 Z05MB1sKDOWTja5Ye/1pxAj3oMdML6Rnr7UvO6zKNrcgM1XWogR0UPZHlNElggtC/KBn
 Vz88lDuTiz7Ad5WPa7ZJCjjW7jtCfsUUQUWY+8AvgyQucUTTG6lnesl0YH4jTqENlnBA
 WNqDhdoI1vd63BZDNPKNjHTKLa1N8NIUK08GUZ7bpHWOdi/qdbssTNd5+4TstvDbMOsj
 EHLw==
X-Gm-Message-State: AOJu0YzvaxGvpWAu9LG5khtTQNNLeKUlJdrQBelUrausw3CyGWLn1YHQ
 6jAGQPE6hM86bg0oW2D7g1kthgrpZAKSZXaPT+B7sx0l
X-Google-Smtp-Source: AGHT+IGb7dkySxBzEFQQqa5q659MDhLMebByd/PMCt4fi0poeQ1kLANqv563ck8nPJv+thcFh63AKA==
X-Received: by 2002:aa7:c70a:0:b0:523:3510:b22 with SMTP id
 i10-20020aa7c70a000000b0052335100b22mr1515698edq.42.1691666958541; 
 Thu, 10 Aug 2023 04:29:18 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 d7-20020aa7d5c7000000b0052286e8dee1sm675097eds.76.2023.08.10.04.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 04:29:18 -0700 (PDT)
Date: Thu, 10 Aug 2023 13:29:17 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, peter.maydell@linaro.org, 
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, thuth@redhat.com, 
 dbarboza@ventanamicro.com, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org
Subject: Re: [PATCH v2] kvm: Remove KVM_CREATE_IRQCHIP support assumption
Message-ID: <20230810-3326d0a412d01fe729f7e6e4@orel>
References: <20230725122601.424738-2-ajones@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725122601.424738-2-ajones@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x541.google.com
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


Hi Paolo,

Is this good for 8.1?

Thanks,
drew


On Tue, Jul 25, 2023 at 02:26:02PM +0200, Andrew Jones wrote:
> Since Linux commit 00f918f61c56 ("RISC-V: KVM: Skeletal in-kernel AIA
> irqchip support") checking KVM_CAP_IRQCHIP returns non-zero when the
> RISC-V platform has AIA. The cap indicates KVM supports at least one
> of the following ioctls:
> 
>   KVM_CREATE_IRQCHIP
>   KVM_IRQ_LINE
>   KVM_GET_IRQCHIP
>   KVM_SET_IRQCHIP
>   KVM_GET_LAPIC
>   KVM_SET_LAPIC
> 
> but the cap doesn't imply that KVM must support any of those ioctls
> in particular. However, QEMU was assuming the KVM_CREATE_IRQCHIP
> ioctl was supported. Stop making that assumption by introducing a
> KVM parameter that each architecture which supports KVM_CREATE_IRQCHIP
> sets. Adding parameters isn't awesome, but given how the
> KVM_CAP_IRQCHIP isn't very helpful on its own, we don't have a lot of
> options.
> 
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
> 
> While this fixes booting guests on riscv KVM with AIA it's unlikely
> to get merged before the QEMU support for KVM AIA[1] lands, which
> would also fix the issue. I think this patch is still worth considering
> though since QEMU's assumption is wrong.
> 
> [1] https://lore.kernel.org/all/20230714084429.22349-1-yongxuan.wang@sifive.com/
> 
> v2:
>   - Move the s390x code to an s390x file. [Thomas]
>   - Drop the KVM_CAP_IRQCHIP check from the top of kvm_irqchip_create(),
>     as it's no longer necessary.
> 
>  accel/kvm/kvm-all.c    | 16 ++++------------
>  include/sysemu/kvm.h   |  1 +
>  target/arm/kvm.c       |  3 +++
>  target/i386/kvm/kvm.c  |  2 ++
>  target/s390x/kvm/kvm.c | 11 +++++++++++
>  5 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 373d876c0580..cddcb6eca641 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -86,6 +86,7 @@ struct KVMParkedVcpu {
>  };
>  
>  KVMState *kvm_state;
> +bool kvm_has_create_irqchip;
>  bool kvm_kernel_irqchip;
>  bool kvm_split_irqchip;
>  bool kvm_async_interrupts_allowed;
> @@ -2358,17 +2359,6 @@ static void kvm_irqchip_create(KVMState *s)
>      int ret;
>  
>      assert(s->kernel_irqchip_split != ON_OFF_AUTO_AUTO);
> -    if (kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
> -        ;
> -    } else if (kvm_check_extension(s, KVM_CAP_S390_IRQCHIP)) {
> -        ret = kvm_vm_enable_cap(s, KVM_CAP_S390_IRQCHIP, 0);
> -        if (ret < 0) {
> -            fprintf(stderr, "Enable kernel irqchip failed: %s\n", strerror(-ret));
> -            exit(1);
> -        }
> -    } else {
> -        return;
> -    }
>  
>      /* First probe and see if there's a arch-specific hook to create the
>       * in-kernel irqchip for us */
> @@ -2377,8 +2367,10 @@ static void kvm_irqchip_create(KVMState *s)
>          if (s->kernel_irqchip_split == ON_OFF_AUTO_ON) {
>              error_report("Split IRQ chip mode not supported.");
>              exit(1);
> -        } else {
> +        } else if (kvm_has_create_irqchip) {
>              ret = kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
> +        } else {
> +            return;
>          }
>      }
>      if (ret < 0) {
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 115f0cca79d1..84b1bb3dc91e 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -32,6 +32,7 @@
>  #ifdef CONFIG_KVM_IS_POSSIBLE
>  
>  extern bool kvm_allowed;
> +extern bool kvm_has_create_irqchip;
>  extern bool kvm_kernel_irqchip;
>  extern bool kvm_split_irqchip;
>  extern bool kvm_async_interrupts_allowed;
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index b4c7654f4980..2fa87b495d68 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -250,6 +250,9 @@ int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa)
>  int kvm_arch_init(MachineState *ms, KVMState *s)
>  {
>      int ret = 0;
> +
> +    kvm_has_create_irqchip = kvm_check_extension(s, KVM_CAP_IRQCHIP);
> +
>      /* For ARM interrupt delivery is always asynchronous,
>       * whether we are using an in-kernel VGIC or not.
>       */
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index ebfaf3d24c79..6363e67f092d 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -2771,6 +2771,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>          }
>      }
>  
> +    kvm_has_create_irqchip = kvm_check_extension(s, KVM_CAP_IRQCHIP);
> +
>      return 0;
>  }
>  
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index a9e5880349d9..bcc735227f7d 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -391,6 +391,17 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      }
>  
>      kvm_set_max_memslot_size(KVM_SLOT_MAX_BYTES);
> +
> +    kvm_has_create_irqchip = kvm_check_extension(s, KVM_CAP_S390_IRQCHIP);
> +    if (kvm_has_create_irqchip) {
> +        int ret = kvm_vm_enable_cap(s, KVM_CAP_S390_IRQCHIP, 0);
> +
> +        if (ret < 0) {
> +            fprintf(stderr, "Enable kernel irqchip failed: %s\n", strerror(-ret));
> +            exit(1);
> +        }
> +    }
> +
>      return 0;
>  }
>  
> -- 
> 2.41.0
> 

