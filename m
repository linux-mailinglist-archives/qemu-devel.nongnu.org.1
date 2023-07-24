Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9197775F115
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 11:55:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNsGN-00027P-Q7; Mon, 24 Jul 2023 05:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qNsGC-00025j-K0
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 05:53:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qNsG9-0005Ko-LK
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 05:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690192425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W8BnD/WmjfxcZiGA/dUP3aM2hxnahbkcOcilHinU3gM=;
 b=KdcIa3LR4CJVBTxXodS/zNWfvoR0k+YIUfdSVN9TWEVFeSg0OYfzoOE5GQubndxVwk3AR7
 OOQg7kwmZEzkRkdj+tjjuehZrqvaSHGZJ0BOGCoP97/y7ByC7utAJ8xLDKvy7qRPRP0wfn
 l0V/BQtvPbEbKWMs6xOR8pimWXfouzo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-pSsEVaY8M66Z80uiXu14yg-1; Mon, 24 Jul 2023 05:53:43 -0400
X-MC-Unique: pSsEVaY8M66Z80uiXu14yg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31758708b57so811960f8f.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 02:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690192422; x=1690797222;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W8BnD/WmjfxcZiGA/dUP3aM2hxnahbkcOcilHinU3gM=;
 b=LfutyB+NfHAs/Tx1yiUtFqnOLHR/dCVRtjLMg6DVV7GWrblovLeX7O1aFKB6wqleeN
 rH5WqbwpNpBtXu98zf9znVDoAYp9ogQzzMdHrNAhw+9KF5XXhsOVo9xmOLZbBUFyetew
 eKcLNornnFvouFKf61K3xU5D0tluoWCN1aLNtzgPZPQOiCM0pcc+/Sjr+ZdWdFu7NQio
 0yDfgVTfd9fLppmyN/OBtBTL4/L1G6IT4+9Ikt4HYbF/c7Y6JMAJy/nSXRDou8NjDS8i
 mGBMHzP1157NH1yMFy6FUQr7p27vHN+rhMJxKOJ1KsWYQ9pXyeKkw1TGZGkd9us05a+F
 +I+g==
X-Gm-Message-State: ABy/qLY0zPHH3FcSlsC83mYaMIcQcACXngRwgvMOj8RVmeGMZw98mUVx
 PDatlTQ4DKZkT2nc0e42rXsf/q1kAxGnLEZPIVh9+zNs/a1dnRn1/DBoqboPVCuQ1ZC/tVAMIuM
 5hpwjdd6AZkoOGpY=
X-Received: by 2002:a5d:50c7:0:b0:315:99be:6fe4 with SMTP id
 f7-20020a5d50c7000000b0031599be6fe4mr7650809wrt.69.1690192422001; 
 Mon, 24 Jul 2023 02:53:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGxbWUV0xYlSpNLpOV84UuVEJ8ow6uwWgFdY0GnM3+jt3qIuyL2U8kIgBOuTPi71Pe686AN4g==
X-Received: by 2002:a5d:50c7:0:b0:315:99be:6fe4 with SMTP id
 f7-20020a5d50c7000000b0031599be6fe4mr7650795wrt.69.1690192421663; 
 Mon, 24 Jul 2023 02:53:41 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-165.web.vodafone.de.
 [109.43.177.165]) by smtp.gmail.com with ESMTPSA id
 m12-20020adff38c000000b003145559a691sm12402548wro.41.2023.07.24.02.53.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jul 2023 02:53:41 -0700 (PDT)
Message-ID: <81dd6b4c-200f-bb35-69fa-ed623eb7e6d1@redhat.com>
Date: Mon, 24 Jul 2023 11:53:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] kvm: Remove KVM_CREATE_IRQCHIP support assumption
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, peter.maydell@linaro.org,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, dbarboza@ventanamicro.com,
 kvm@vger.kernel.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20230722062115.11950-2-ajones@ventanamicro.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230722062115.11950-2-ajones@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 22/07/2023 08.21, Andrew Jones wrote:
> Since Linux commit 00f918f61c56 ("RISC-V: KVM: Skeletal in-kernel AIA
> irqchip support") checking KVM_CAP_IRQCHIP returns non-zero when the
> RISC-V platform has AIA. The cap indicates KVM supports at least one
> of the following ioctls:
> 
>    KVM_CREATE_IRQCHIP
>    KVM_IRQ_LINE
>    KVM_GET_IRQCHIP
>    KVM_SET_IRQCHIP
>    KVM_GET_LAPIC
>    KVM_SET_LAPIC
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
> 
>   accel/kvm/kvm-all.c    | 5 ++++-
>   include/sysemu/kvm.h   | 1 +
>   target/arm/kvm.c       | 3 +++
>   target/i386/kvm/kvm.c  | 2 ++
>   target/s390x/kvm/kvm.c | 3 +++
>   5 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 373d876c0580..0f5ff8630502 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -86,6 +86,7 @@ struct KVMParkedVcpu {
>   };
>   
>   KVMState *kvm_state;
> +bool kvm_has_create_irqchip;
>   bool kvm_kernel_irqchip;
>   bool kvm_split_irqchip;
>   bool kvm_async_interrupts_allowed;
> @@ -2377,8 +2378,10 @@ static void kvm_irqchip_create(KVMState *s)
>           if (s->kernel_irqchip_split == ON_OFF_AUTO_ON) {
>               error_report("Split IRQ chip mode not supported.");
>               exit(1);
> -        } else {
> +        } else if (kvm_has_create_irqchip) {
>               ret = kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
> +        } else {
> +            return;
>           }
>       }
>       if (ret < 0) {

I think I'd do this differntly... at the beginning of the function, there is 
a check for kvm_check_extension(s, KVM_CAP_IRQCHIP) etc. ... I think you 
could now replace that check with a simple

	if (!kvm_has_create_irqchip) {
		return;
	}

The "kvm_vm_enable_cap(s, KVM_CAP_S390_IRQCHIP, 0)" of course has to be 
moved to the target/s390x/kvm/kvm.c file, too.

  Thomas


> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 115f0cca79d1..84b1bb3dc91e 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -32,6 +32,7 @@
>   #ifdef CONFIG_KVM_IS_POSSIBLE
>   
>   extern bool kvm_allowed;
> +extern bool kvm_has_create_irqchip;
>   extern bool kvm_kernel_irqchip;
>   extern bool kvm_split_irqchip;
>   extern bool kvm_async_interrupts_allowed;
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index b4c7654f4980..2fa87b495d68 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -250,6 +250,9 @@ int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa)
>   int kvm_arch_init(MachineState *ms, KVMState *s)
>   {
>       int ret = 0;
> +
> +    kvm_has_create_irqchip = kvm_check_extension(s, KVM_CAP_IRQCHIP);
> +
>       /* For ARM interrupt delivery is always asynchronous,
>        * whether we are using an in-kernel VGIC or not.
>        */
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index ebfaf3d24c79..6363e67f092d 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -2771,6 +2771,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>           }
>       }
>   
> +    kvm_has_create_irqchip = kvm_check_extension(s, KVM_CAP_IRQCHIP);
> +
>       return 0;
>   }
>   
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index a9e5880349d9..c053304adf94 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -391,6 +391,9 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>       }
>   
>       kvm_set_max_memslot_size(KVM_SLOT_MAX_BYTES);
> +
> +    kvm_has_create_irqchip = kvm_check_extension(s, KVM_CAP_S390_IRQCHIP);
> +
>       return 0;
>   }
>   


