Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 659367438D9
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 12:01:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFAvv-0002rW-41; Fri, 30 Jun 2023 06:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qFAvt-0002qS-0S
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:00:53 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qFAvq-0007I4-EU
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:00:52 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6b867acbf6dso1011357a34.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 03:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688119249; x=1690711249;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q8MtiHwkLZ3I4tvyMVayNgX+OarZrg4wOjLBqNFijog=;
 b=cmKMWLL35pIbNRkfAPVqHU2HsAO0GNp3RQurrr/52rTgI3mv+6NNVb/8ZlUCM5UePs
 /eWV+/Tdao41b9/P3yIk+PRnzpfXaxpJY98YihqFfwVrMQOOxc2c7HEt7ARZ/4MpHFG3
 24LYJwGeRR1uEMBBJnrs5qODPS7b0icocbVTklJhXjmbBwaPRNK0JMahWmrwwwp928uc
 bNexFbGnAPfsrYV0AL0o46mHYsCRFTgNv4ginw4udipk1j/04zwbQQCu7SGrgNgH3tkD
 +ZUhVf4mQFdoTFOj46JZspY7fWzbu+VgdNYXHpmUR6Kv2XJrCEdl90AK0Gsn0HCagA0j
 9Htw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688119249; x=1690711249;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q8MtiHwkLZ3I4tvyMVayNgX+OarZrg4wOjLBqNFijog=;
 b=ZAhH1u7NaifJQI9qSme2DT7c2d2E2wm7a+dkH2cjNAZhCPzY3t6QrJgvUUBP8/jlYA
 5yRwItZ74QLculrb987o4jG3ZpGYNN3eLoSYZaWFaQWdtb5fCFxwPkQblaKrbEQr75S7
 d64STSk2eeGxbsQUw+Ud5vF4Dgn2xqcWYEkkKvnF8APl3zVVCeu2EN1cGoefVjw/BzHK
 uSdq3yyEUlj9ogL4fgBfoN1eg4qRGTWYJLAQBb6/PKZg9oNumiBdMycftsELJNg63Cm1
 hnNTM3/2CafsfQWIjEHJva9OfGU/j0LBSe9jZV4CKd3gUyWAHfQ0ta9gepQkYW+PfxEF
 VrNw==
X-Gm-Message-State: AC+VfDy7/aTWGXfpGocncJBJ7/A0DpyLCyZACOkJNIh46W5yMpCiPSwn
 dfQGrUum6Xiy27VXxBD2O7wsuw==
X-Google-Smtp-Source: ACHHUZ4bqGtbHre6KmqgAt9Z3F+2Hi6WOkaAcDDEdExlDpa59ik67J1oVf6IMQrslV44kqI21foXkA==
X-Received: by 2002:a05:6808:23c9:b0:3a0:3ee2:87c2 with SMTP id
 bq9-20020a05680823c900b003a03ee287c2mr1366422oib.20.1688119248976; 
 Fri, 30 Jun 2023 03:00:48 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 j14-20020a056808034e00b003a0697dce2csm6465043oie.35.2023.06.30.03.00.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 03:00:48 -0700 (PDT)
Message-ID: <e21ea550-20f6-257b-549d-75b1d5efe0a1@ventanamicro.com>
Date: Fri, 30 Jun 2023 07:00:43 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 1/6] update-linux-headers: sync-up header with Linux
 for KVM AIA support placeholder
Content-Language: en-US
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: rkanwal@rivosinc.com, anup@brainfault.org, atishp@atishpatra.org,
 vincent.chen@sifive.com, greentime.hu@sifive.com, frank.chang@sifive.com,
 jim.shu@sifive.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org
References: <20230621145500.25624-1-yongxuan.wang@sifive.com>
 <20230621145500.25624-2-yongxuan.wang@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230621145500.25624-2-yongxuan.wang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 6/21/23 11:54, Yong-Xuan Wang wrote:
> Sync-up Linux header to get latest KVM RISC-V headers having AIA support.
> 
> Note: This is a placeholder commit and could be replaced when all referenced Linux patchsets are mainlined.
> 
> The linux-headers changes are from 2 different patchsets.
> [1] https://lore.kernel.org/lkml/20230404153452.2405681-1-apatel@ventanamicro.com/
> [2] https://www.spinics.net/lists/kernel/msg4791872.html


It looks like Anup sent a PR for [2] for Linux 6.5. IIUC this would be then a 6.5
linux-header update.

In this case I'm not sure whether we can pick this up for QEMU 8.1 (code freeze is
July 10th) since we can't keep a 6.5 placeholder header. I'll let Alistair comment
on that.


Thanks,

Daniel

> 
> Currently, patchset 1 is already merged into mainline kernel in v6.4-rc1 and patchset 2 is not.
> 
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>
> ---
>   linux-headers/asm-riscv/kvm.h | 123 +++++++++++++++++++++++++++++++++-
>   linux-headers/linux/kvm.h     |   2 +
>   2 files changed, 124 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-headers/asm-riscv/kvm.h b/linux-headers/asm-riscv/kvm.h
> index 92af6f3f05..a16ca62419 100644
> --- a/linux-headers/asm-riscv/kvm.h
> +++ b/linux-headers/asm-riscv/kvm.h
> @@ -12,8 +12,10 @@
>   #ifndef __ASSEMBLY__
>   
>   #include <linux/types.h>
> +#include <asm/bitsperlong.h>
>   #include <asm/ptrace.h>
>   
> +#define __KVM_HAVE_IRQ_LINE
>   #define __KVM_HAVE_READONLY_MEM
>   
>   #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
> @@ -64,7 +66,7 @@ struct kvm_riscv_core {
>   #define KVM_RISCV_MODE_S	1
>   #define KVM_RISCV_MODE_U	0
>   
> -/* CSR registers for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
> +/* General CSR registers for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
>   struct kvm_riscv_csr {
>   	unsigned long sstatus;
>   	unsigned long sie;
> @@ -78,6 +80,17 @@ struct kvm_riscv_csr {
>   	unsigned long scounteren;
>   };
>   
> +/* AIA CSR registers for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
> +struct kvm_riscv_aia_csr {
> +	unsigned long siselect;
> +	unsigned long iprio1;
> +	unsigned long iprio2;
> +	unsigned long sieh;
> +	unsigned long siph;
> +	unsigned long iprio1h;
> +	unsigned long iprio2h;
> +};
> +
>   /* TIMER registers for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
>   struct kvm_riscv_timer {
>   	__u64 frequency;
> @@ -105,9 +118,28 @@ enum KVM_RISCV_ISA_EXT_ID {
>   	KVM_RISCV_ISA_EXT_SVINVAL,
>   	KVM_RISCV_ISA_EXT_ZIHINTPAUSE,
>   	KVM_RISCV_ISA_EXT_ZICBOM,
> +	KVM_RISCV_ISA_EXT_ZBB,
> +	KVM_RISCV_ISA_EXT_SSAIA,
>   	KVM_RISCV_ISA_EXT_MAX,
>   };
>   
> +/*
> + * SBI extension IDs specific to KVM. This is not the same as the SBI
> + * extension IDs defined by the RISC-V SBI specification.
> + */
> +enum KVM_RISCV_SBI_EXT_ID {
> +	KVM_RISCV_SBI_EXT_V01 = 0,
> +	KVM_RISCV_SBI_EXT_TIME,
> +	KVM_RISCV_SBI_EXT_IPI,
> +	KVM_RISCV_SBI_EXT_RFENCE,
> +	KVM_RISCV_SBI_EXT_SRST,
> +	KVM_RISCV_SBI_EXT_HSM,
> +	KVM_RISCV_SBI_EXT_PMU,
> +	KVM_RISCV_SBI_EXT_EXPERIMENTAL,
> +	KVM_RISCV_SBI_EXT_VENDOR,
> +	KVM_RISCV_SBI_EXT_MAX,
> +};
> +
>   /* Possible states for kvm_riscv_timer */
>   #define KVM_RISCV_TIMER_STATE_OFF	0
>   #define KVM_RISCV_TIMER_STATE_ON	1
> @@ -118,6 +150,8 @@ enum KVM_RISCV_ISA_EXT_ID {
>   /* If you need to interpret the index values, here is the key: */
>   #define KVM_REG_RISCV_TYPE_MASK		0x00000000FF000000
>   #define KVM_REG_RISCV_TYPE_SHIFT	24
> +#define KVM_REG_RISCV_SUBTYPE_MASK	0x0000000000FF0000
> +#define KVM_REG_RISCV_SUBTYPE_SHIFT	16
>   
>   /* Config registers are mapped as type 1 */
>   #define KVM_REG_RISCV_CONFIG		(0x01 << KVM_REG_RISCV_TYPE_SHIFT)
> @@ -131,8 +165,12 @@ enum KVM_RISCV_ISA_EXT_ID {
>   
>   /* Control and status registers are mapped as type 3 */
>   #define KVM_REG_RISCV_CSR		(0x03 << KVM_REG_RISCV_TYPE_SHIFT)
> +#define KVM_REG_RISCV_CSR_GENERAL	(0x0 << KVM_REG_RISCV_SUBTYPE_SHIFT)
> +#define KVM_REG_RISCV_CSR_AIA		(0x1 << KVM_REG_RISCV_SUBTYPE_SHIFT)
>   #define KVM_REG_RISCV_CSR_REG(name)	\
>   		(offsetof(struct kvm_riscv_csr, name) / sizeof(unsigned long))
> +#define KVM_REG_RISCV_CSR_AIA_REG(name)	\
> +	(offsetof(struct kvm_riscv_aia_csr, name) / sizeof(unsigned long))
>   
>   /* Timer registers are mapped as type 4 */
>   #define KVM_REG_RISCV_TIMER		(0x04 << KVM_REG_RISCV_TYPE_SHIFT)
> @@ -152,6 +190,89 @@ enum KVM_RISCV_ISA_EXT_ID {
>   /* ISA Extension registers are mapped as type 7 */
>   #define KVM_REG_RISCV_ISA_EXT		(0x07 << KVM_REG_RISCV_TYPE_SHIFT)
>   
> +/* SBI extension registers are mapped as type 8 */
> +#define KVM_REG_RISCV_SBI_EXT		(0x08 << KVM_REG_RISCV_TYPE_SHIFT)
> +#define KVM_REG_RISCV_SBI_SINGLE	(0x0 << KVM_REG_RISCV_SUBTYPE_SHIFT)
> +#define KVM_REG_RISCV_SBI_MULTI_EN	(0x1 << KVM_REG_RISCV_SUBTYPE_SHIFT)
> +#define KVM_REG_RISCV_SBI_MULTI_DIS	(0x2 << KVM_REG_RISCV_SUBTYPE_SHIFT)
> +#define KVM_REG_RISCV_SBI_MULTI_REG(__ext_id)	\
> +		((__ext_id) / __BITS_PER_LONG)
> +#define KVM_REG_RISCV_SBI_MULTI_MASK(__ext_id)	\
> +		(1UL << ((__ext_id) % __BITS_PER_LONG))
> +#define KVM_REG_RISCV_SBI_MULTI_REG_LAST	\
> +		KVM_REG_RISCV_SBI_MULTI_REG(KVM_RISCV_SBI_EXT_MAX - 1)
> +
> +/* Device Control API: RISC-V AIA */
> +#define KVM_DEV_RISCV_APLIC_ALIGN		0x1000
> +#define KVM_DEV_RISCV_APLIC_SIZE		0x4000
> +#define KVM_DEV_RISCV_APLIC_MAX_HARTS		0x4000
> +#define KVM_DEV_RISCV_IMSIC_ALIGN		0x1000
> +#define KVM_DEV_RISCV_IMSIC_SIZE		0x1000
> +
> +#define KVM_DEV_RISCV_AIA_GRP_CONFIG		0
> +#define KVM_DEV_RISCV_AIA_CONFIG_MODE		0
> +#define KVM_DEV_RISCV_AIA_CONFIG_IDS		1
> +#define KVM_DEV_RISCV_AIA_CONFIG_SRCS		2
> +#define KVM_DEV_RISCV_AIA_CONFIG_GROUP_BITS	3
> +#define KVM_DEV_RISCV_AIA_CONFIG_GROUP_SHIFT	4
> +#define KVM_DEV_RISCV_AIA_CONFIG_HART_BITS	5
> +#define KVM_DEV_RISCV_AIA_CONFIG_GUEST_BITS	6
> +
> +/*
> + * Modes of RISC-V AIA device:
> + * 1) EMUL (aka Emulation): Trap-n-emulate IMSIC
> + * 2) HWACCEL (aka HW Acceleration): Virtualize IMSIC using IMSIC guest files
> + * 3) AUTO (aka Automatic): Virtualize IMSIC using IMSIC guest files whenever
> + *    available otherwise fallback to trap-n-emulation
> + */
> +#define KVM_DEV_RISCV_AIA_MODE_EMUL		0
> +#define KVM_DEV_RISCV_AIA_MODE_HWACCEL		1
> +#define KVM_DEV_RISCV_AIA_MODE_AUTO		2
> +
> +#define KVM_DEV_RISCV_AIA_IDS_MIN		63
> +#define KVM_DEV_RISCV_AIA_IDS_MAX		2048
> +#define KVM_DEV_RISCV_AIA_SRCS_MAX		1024
> +#define KVM_DEV_RISCV_AIA_GROUP_BITS_MAX	8
> +#define KVM_DEV_RISCV_AIA_GROUP_SHIFT_MIN	24
> +#define KVM_DEV_RISCV_AIA_GROUP_SHIFT_MAX	56
> +#define KVM_DEV_RISCV_AIA_HART_BITS_MAX		16
> +#define KVM_DEV_RISCV_AIA_GUEST_BITS_MAX	8
> +
> +#define KVM_DEV_RISCV_AIA_GRP_ADDR		1
> +#define KVM_DEV_RISCV_AIA_ADDR_APLIC		0
> +#define KVM_DEV_RISCV_AIA_ADDR_IMSIC(__vcpu)	(1 + (__vcpu))
> +#define KVM_DEV_RISCV_AIA_ADDR_MAX		\
> +		(1 + KVM_DEV_RISCV_APLIC_MAX_HARTS)
> +
> +#define KVM_DEV_RISCV_AIA_GRP_CTRL		2
> +#define KVM_DEV_RISCV_AIA_CTRL_INIT		0
> +
> +/*
> + * The device attribute type contains the memory mapped offset of the
> + * APLIC register (range 0x0000-0x3FFF) and it must be 4-byte aligned.
> + */
> +#define KVM_DEV_RISCV_AIA_GRP_APLIC		3
> +
> +/*
> + * The lower 12-bits of the device attribute type contains the iselect
> + * value of the IMSIC register (range 0x70-0xFF) whereas the higher order
> + * bits contains the VCPU id.
> + */
> +#define KVM_DEV_RISCV_AIA_GRP_IMSIC		4
> +#define KVM_DEV_RISCV_AIA_IMSIC_ISEL_BITS	12
> +#define KVM_DEV_RISCV_AIA_IMSIC_ISEL_MASK	\
> +		((1U << KVM_DEV_RISCV_AIA_IMSIC_ISEL_BITS) - 1)
> +#define KVM_DEV_RISCV_AIA_IMSIC_MKATTR(__vcpu, __isel)	\
> +		(((__vcpu) << KVM_DEV_RISCV_AIA_IMSIC_ISEL_BITS) | \
> +		 ((__isel) & KVM_DEV_RISCV_AIA_IMSIC_ISEL_MASK))
> +#define KVM_DEV_RISCV_AIA_IMSIC_GET_ISEL(__attr)	\
> +		((__attr) & KVM_DEV_RISCV_AIA_IMSIC_ISEL_MASK)
> +#define KVM_DEV_RISCV_AIA_IMSIC_GET_VCPU(__attr)	\
> +		((__attr) >> KVM_DEV_RISCV_AIA_IMSIC_ISEL_BITS)
> +
> +/* One single KVM irqchip, ie. the AIA */
> +#define KVM_NR_IRQCHIPS			1
> +
>   #endif
>   
>   #endif /* __LINUX_KVM_RISCV_H */
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index 599de3c6e3..a9a4f5791d 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -1434,6 +1434,8 @@ enum kvm_device_type {
>   #define KVM_DEV_TYPE_XIVE		KVM_DEV_TYPE_XIVE
>   	KVM_DEV_TYPE_ARM_PV_TIME,
>   #define KVM_DEV_TYPE_ARM_PV_TIME	KVM_DEV_TYPE_ARM_PV_TIME
> +	KVM_DEV_TYPE_RISCV_AIA,
> +#define KVM_DEV_TYPE_RISCV_AIA		KVM_DEV_TYPE_RISCV_AIA
>   	KVM_DEV_TYPE_MAX,
>   };
>   

