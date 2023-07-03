Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B39A47460B8
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 18:32:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGMSI-00028K-Ie; Mon, 03 Jul 2023 12:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qGMSG-00027e-JT
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 12:31:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qGMSD-0006Jv-Qt
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 12:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688401868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KhZX5lry6gPbSTAGLy3IBpdoRakjPMrnd+LUP0JPMgo=;
 b=O4dOcqpduRICda4D9uiF1uwbxxvp5CKtZrPwmT/tw94FixEanLcDLFNgSj7orexwPq1v3g
 zZKqsiqNcXwVI91sYfsfjumdgQZX93ZX2nTeLxpNWU9IPWBaplE8vHHnxz1Z+B9pYtJads
 foo+3bzXydORAD++yOtKhSa+HFwVLgs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-CFaWnvtsO3qkhWBeb0FpsA-1; Mon, 03 Jul 2023 12:31:07 -0400
X-MC-Unique: CFaWnvtsO3qkhWBeb0FpsA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-635dd236b63so29718996d6.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 09:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688401867; x=1690993867;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KhZX5lry6gPbSTAGLy3IBpdoRakjPMrnd+LUP0JPMgo=;
 b=cVK3G7a6lHPcc2nDF6bX8qQHOFOSIGOwYibM+5VpC92xN1CsvHd4+X6Cd4iNnWdauV
 npVYhrqRfHma1bwDTNez5heFkUXFj+o48x8HKoV0HoKPZPbqGPlYQiCiourTa6kcQ8IS
 Q8S4P9bdubE06Xbpsnu+HDtnps9uz4LWtDXwLNOfrsZDwJ4USb8UgNm8JhOb4vZQHrHL
 jfjj3BtWu7SHClBvfUpDYkI7BBo2qzI57jyrKUFiixLzgtde3wKeitrDy3xtrQuAC8Lg
 pAwKhQcXcCs+oIEANGPXgujs8pyqP7hGLXaRkT4zjAsuBP3nk0Z7JFK1LF27ssBC0nof
 zNFQ==
X-Gm-Message-State: ABy/qLY+r3D7wwmRwPrF+8F9BFcaUTjuiiBHcANGO5oDh0JtrDDzY8DN
 eTFAgX1DYKI9VqtVvyOUB9rVD3sDzeb9QVQNeCrCsqsLwz35EM9V5Au5tZLr0MvVjlTAo6kip/i
 EyMZ9XLFEw+XUoSC4x34wxxg=
X-Received: by 2002:a05:6214:27ed:b0:625:aa49:ea0c with SMTP id
 jt13-20020a05621427ed00b00625aa49ea0cmr11532171qvb.31.1688401867107; 
 Mon, 03 Jul 2023 09:31:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF1M08cHiu3y8nkogewZM66Vez7U7VM06xop1AeviHMrG43TI09uJS1Zmi6G73xViRzdNheVg==
X-Received: by 2002:a05:6214:27ed:b0:625:aa49:ea0c with SMTP id
 jt13-20020a05621427ed00b00625aa49ea0cmr11532144qvb.31.1688401866593; 
 Mon, 03 Jul 2023 09:31:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 q5-20020ad45ca5000000b00623950fbe48sm11628277qvh.41.2023.07.03.09.31.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 09:31:06 -0700 (PDT)
Message-ID: <25e1e7d9-30bb-b3dc-0eeb-1d731262d43d@redhat.com>
Date: Mon, 3 Jul 2023 18:31:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/2] linux-headers: Update with vfio_ap IRQ index
 mapping
Content-Language: en-US
To: Tony Krowiak <akrowiak@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, mjrosato@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, fiuczy@linux.ibm.com, thuth@redhat.com,
 farman@linux.ibm.com, borntraeger@linux.ibm.com, cohuck@redhat.com
References: <20230602141125.448833-1-akrowiak@linux.ibm.com>
 <20230602141125.448833-2-akrowiak@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230602141125.448833-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/2/23 16:11, Tony Krowiak wrote:
> Note: This is a placeholder patch that includes unmerged uapi changes.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Link: https://lore.kernel.org/qemu-devel/20230530225544.280031-1-akrowiak@linux.ibm.com/

I am preparing a vfio-next tree including these changes plus a linux-headers
update. I am just waiting for the 6.5-rc1 tag to be pushed.

Thanks,

C.

> ---
>   include/standard-headers/linux/const.h        |  2 +-
>   include/standard-headers/linux/virtio_blk.h   | 18 +++----
>   .../standard-headers/linux/virtio_config.h    |  6 +++
>   include/standard-headers/linux/virtio_net.h   |  1 +
>   linux-headers/asm-arm64/kvm.h                 | 33 ++++++++++++
>   linux-headers/asm-riscv/kvm.h                 | 53 ++++++++++++++++++-
>   linux-headers/asm-riscv/unistd.h              |  9 ++++
>   linux-headers/asm-s390/unistd_32.h            |  1 +
>   linux-headers/asm-s390/unistd_64.h            |  1 +
>   linux-headers/asm-x86/kvm.h                   |  3 ++
>   linux-headers/linux/const.h                   |  2 +-
>   linux-headers/linux/kvm.h                     | 12 +++--
>   linux-headers/linux/psp-sev.h                 |  7 +++
>   linux-headers/linux/userfaultfd.h             | 17 +++++-
>   linux-headers/linux/vfio.h                    |  9 ++++
>   15 files changed, 158 insertions(+), 16 deletions(-)
> 
> diff --git a/include/standard-headers/linux/const.h b/include/standard-headers/linux/const.h
> index 5e4898725168..1eb84b5087f8 100644
> --- a/include/standard-headers/linux/const.h
> +++ b/include/standard-headers/linux/const.h
> @@ -28,7 +28,7 @@
>   #define _BITUL(x)	(_UL(1) << (x))
>   #define _BITULL(x)	(_ULL(1) << (x))
>   
> -#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
> +#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
>   #define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
>   
>   #define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
> diff --git a/include/standard-headers/linux/virtio_blk.h b/include/standard-headers/linux/virtio_blk.h
> index 7155b1a4701b..d7be3cf5e42f 100644
> --- a/include/standard-headers/linux/virtio_blk.h
> +++ b/include/standard-headers/linux/virtio_blk.h
> @@ -138,11 +138,11 @@ struct virtio_blk_config {
>   
>   	/* Zoned block device characteristics (if VIRTIO_BLK_F_ZONED) */
>   	struct virtio_blk_zoned_characteristics {
> -		uint32_t zone_sectors;
> -		uint32_t max_open_zones;
> -		uint32_t max_active_zones;
> -		uint32_t max_append_sectors;
> -		uint32_t write_granularity;
> +		__virtio32 zone_sectors;
> +		__virtio32 max_open_zones;
> +		__virtio32 max_active_zones;
> +		__virtio32 max_append_sectors;
> +		__virtio32 write_granularity;
>   		uint8_t model;
>   		uint8_t unused2[3];
>   	} zoned;
> @@ -239,11 +239,11 @@ struct virtio_blk_outhdr {
>    */
>   struct virtio_blk_zone_descriptor {
>   	/* Zone capacity */
> -	uint64_t z_cap;
> +	__virtio64 z_cap;
>   	/* The starting sector of the zone */
> -	uint64_t z_start;
> +	__virtio64 z_start;
>   	/* Zone write pointer position in sectors */
> -	uint64_t z_wp;
> +	__virtio64 z_wp;
>   	/* Zone type */
>   	uint8_t z_type;
>   	/* Zone state */
> @@ -252,7 +252,7 @@ struct virtio_blk_zone_descriptor {
>   };
>   
>   struct virtio_blk_zone_report {
> -	uint64_t nr_zones;
> +	__virtio64 nr_zones;
>   	uint8_t reserved[56];
>   	struct virtio_blk_zone_descriptor zones[];
>   };
> diff --git a/include/standard-headers/linux/virtio_config.h b/include/standard-headers/linux/virtio_config.h
> index 965ee6ae237e..8a7d0dc8b007 100644
> --- a/include/standard-headers/linux/virtio_config.h
> +++ b/include/standard-headers/linux/virtio_config.h
> @@ -97,6 +97,12 @@
>    */
>   #define VIRTIO_F_SR_IOV			37
>   
> +/*
> + * This feature indicates that the driver passes extra data (besides
> + * identifying the virtqueue) in its device notifications.
> + */
> +#define VIRTIO_F_NOTIFICATION_DATA	38
> +
>   /*
>    * This feature indicates that the driver can reset a queue individually.
>    */
> diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
> index c0e797067aae..2325485f2ca8 100644
> --- a/include/standard-headers/linux/virtio_net.h
> +++ b/include/standard-headers/linux/virtio_net.h
> @@ -61,6 +61,7 @@
>   #define VIRTIO_NET_F_GUEST_USO6	55	/* Guest can handle USOv6 in. */
>   #define VIRTIO_NET_F_HOST_USO	56	/* Host can handle USO in. */
>   #define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
> +#define VIRTIO_NET_F_GUEST_HDRLEN  59	/* Guest provides the exact hdr_len value. */
>   #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
>   #define VIRTIO_NET_F_RSC_EXT	  61	/* extended coalescing info */
>   #define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another device
> diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
> index d7e7bb885e20..38e5957526c2 100644
> --- a/linux-headers/asm-arm64/kvm.h
> +++ b/linux-headers/asm-arm64/kvm.h
> @@ -198,6 +198,15 @@ struct kvm_arm_copy_mte_tags {
>   	__u64 reserved[2];
>   };
>   
> +/*
> + * Counter/Timer offset structure. Describe the virtual/physical offset.
> + * To be used with KVM_ARM_SET_COUNTER_OFFSET.
> + */
> +struct kvm_arm_counter_offset {
> +	__u64 counter_offset;
> +	__u64 reserved;
> +};
> +
>   #define KVM_ARM_TAGS_TO_GUEST		0
>   #define KVM_ARM_TAGS_FROM_GUEST		1
>   
> @@ -363,6 +372,10 @@ enum {
>   	KVM_REG_ARM_VENDOR_HYP_BIT_PTP		= 1,
>   };
>   
> +/* Device Control API on vm fd */
> +#define KVM_ARM_VM_SMCCC_CTRL		0
> +#define   KVM_ARM_VM_SMCCC_FILTER	0
> +
>   /* Device Control API: ARM VGIC */
>   #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
>   #define KVM_DEV_ARM_VGIC_GRP_DIST_REGS	1
> @@ -402,6 +415,8 @@ enum {
>   #define KVM_ARM_VCPU_TIMER_CTRL		1
>   #define   KVM_ARM_VCPU_TIMER_IRQ_VTIMER		0
>   #define   KVM_ARM_VCPU_TIMER_IRQ_PTIMER		1
> +#define   KVM_ARM_VCPU_TIMER_IRQ_HVTIMER	2
> +#define   KVM_ARM_VCPU_TIMER_IRQ_HPTIMER	3
>   #define KVM_ARM_VCPU_PVTIME_CTRL	2
>   #define   KVM_ARM_VCPU_PVTIME_IPA	0
>   
> @@ -458,6 +473,24 @@ enum {
>   /* run->fail_entry.hardware_entry_failure_reason codes. */
>   #define KVM_EXIT_FAIL_ENTRY_CPU_UNSUPPORTED	(1ULL << 0)
>   
> +enum kvm_smccc_filter_action {
> +	KVM_SMCCC_FILTER_HANDLE = 0,
> +	KVM_SMCCC_FILTER_DENY,
> +	KVM_SMCCC_FILTER_FWD_TO_USER,
> +
> +};
> +
> +struct kvm_smccc_filter {
> +	__u32 base;
> +	__u32 nr_functions;
> +	__u8 action;
> +	__u8 pad[15];
> +};
> +
> +/* arm64-specific KVM_EXIT_HYPERCALL flags */
> +#define KVM_HYPERCALL_EXIT_SMC		(1U << 0)
> +#define KVM_HYPERCALL_EXIT_16BIT	(1U << 1)
> +
>   #endif
>   
>   #endif /* __ARM_KVM_H__ */
> diff --git a/linux-headers/asm-riscv/kvm.h b/linux-headers/asm-riscv/kvm.h
> index 92af6f3f057c..f92790c9481a 100644
> --- a/linux-headers/asm-riscv/kvm.h
> +++ b/linux-headers/asm-riscv/kvm.h
> @@ -12,6 +12,7 @@
>   #ifndef __ASSEMBLY__
>   
>   #include <linux/types.h>
> +#include <asm/bitsperlong.h>
>   #include <asm/ptrace.h>
>   
>   #define __KVM_HAVE_READONLY_MEM
> @@ -52,6 +53,7 @@ struct kvm_riscv_config {
>   	unsigned long mvendorid;
>   	unsigned long marchid;
>   	unsigned long mimpid;
> +	unsigned long zicboz_block_size;
>   };
>   
>   /* CORE registers for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
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
> @@ -105,9 +118,29 @@ enum KVM_RISCV_ISA_EXT_ID {
>   	KVM_RISCV_ISA_EXT_SVINVAL,
>   	KVM_RISCV_ISA_EXT_ZIHINTPAUSE,
>   	KVM_RISCV_ISA_EXT_ZICBOM,
> +	KVM_RISCV_ISA_EXT_ZICBOZ,
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
> @@ -118,6 +151,8 @@ enum KVM_RISCV_ISA_EXT_ID {
>   /* If you need to interpret the index values, here is the key: */
>   #define KVM_REG_RISCV_TYPE_MASK		0x00000000FF000000
>   #define KVM_REG_RISCV_TYPE_SHIFT	24
> +#define KVM_REG_RISCV_SUBTYPE_MASK	0x0000000000FF0000
> +#define KVM_REG_RISCV_SUBTYPE_SHIFT	16
>   
>   /* Config registers are mapped as type 1 */
>   #define KVM_REG_RISCV_CONFIG		(0x01 << KVM_REG_RISCV_TYPE_SHIFT)
> @@ -131,8 +166,12 @@ enum KVM_RISCV_ISA_EXT_ID {
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
> @@ -152,6 +191,18 @@ enum KVM_RISCV_ISA_EXT_ID {
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
>   #endif
>   
>   #endif /* __LINUX_KVM_RISCV_H */
> diff --git a/linux-headers/asm-riscv/unistd.h b/linux-headers/asm-riscv/unistd.h
> index 73d7cdd2ec49..950ab3fd4409 100644
> --- a/linux-headers/asm-riscv/unistd.h
> +++ b/linux-headers/asm-riscv/unistd.h
> @@ -43,3 +43,12 @@
>   #define __NR_riscv_flush_icache (__NR_arch_specific_syscall + 15)
>   #endif
>   __SYSCALL(__NR_riscv_flush_icache, sys_riscv_flush_icache)
> +
> +/*
> + * Allows userspace to query the kernel for CPU architecture and
> + * microarchitecture details across a given set of CPUs.
> + */
> +#ifndef __NR_riscv_hwprobe
> +#define __NR_riscv_hwprobe (__NR_arch_specific_syscall + 14)
> +#endif
> +__SYSCALL(__NR_riscv_hwprobe, sys_riscv_hwprobe)
> diff --git a/linux-headers/asm-s390/unistd_32.h b/linux-headers/asm-s390/unistd_32.h
> index 8e644d65f571..800f3adb2020 100644
> --- a/linux-headers/asm-s390/unistd_32.h
> +++ b/linux-headers/asm-s390/unistd_32.h
> @@ -419,6 +419,7 @@
>   #define __NR_landlock_create_ruleset 444
>   #define __NR_landlock_add_rule 445
>   #define __NR_landlock_restrict_self 446
> +#define __NR_memfd_secret 447
>   #define __NR_process_mrelease 448
>   #define __NR_futex_waitv 449
>   #define __NR_set_mempolicy_home_node 450
> diff --git a/linux-headers/asm-s390/unistd_64.h b/linux-headers/asm-s390/unistd_64.h
> index 51da542fec10..399a6059015e 100644
> --- a/linux-headers/asm-s390/unistd_64.h
> +++ b/linux-headers/asm-s390/unistd_64.h
> @@ -367,6 +367,7 @@
>   #define __NR_landlock_create_ruleset 444
>   #define __NR_landlock_add_rule 445
>   #define __NR_landlock_restrict_self 446
> +#define __NR_memfd_secret 447
>   #define __NR_process_mrelease 448
>   #define __NR_futex_waitv 449
>   #define __NR_set_mempolicy_home_node 450
> diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
> index 2937e7bf6982..2b3a8f7bd2c0 100644
> --- a/linux-headers/asm-x86/kvm.h
> +++ b/linux-headers/asm-x86/kvm.h
> @@ -557,4 +557,7 @@ struct kvm_pmu_event_filter {
>   #define KVM_VCPU_TSC_CTRL 0 /* control group for the timestamp counter (TSC) */
>   #define   KVM_VCPU_TSC_OFFSET 0 /* attribute for the TSC offset */
>   
> +/* x86-specific KVM_EXIT_HYPERCALL flags. */
> +#define KVM_EXIT_HYPERCALL_LONG_MODE	BIT(0)
> +
>   #endif /* _ASM_X86_KVM_H */
> diff --git a/linux-headers/linux/const.h b/linux-headers/linux/const.h
> index 5e4898725168..1eb84b5087f8 100644
> --- a/linux-headers/linux/const.h
> +++ b/linux-headers/linux/const.h
> @@ -28,7 +28,7 @@
>   #define _BITUL(x)	(_UL(1) << (x))
>   #define _BITULL(x)	(_ULL(1) << (x))
>   
> -#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
> +#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
>   #define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
>   
>   #define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index 599de3c6e3aa..65b145b317ac 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -341,8 +341,11 @@ struct kvm_run {
>   			__u64 nr;
>   			__u64 args[6];
>   			__u64 ret;
> -			__u32 longmode;
> -			__u32 pad;
> +
> +			union {
> +				__u32 longmode;
> +				__u64 flags;
> +			};
>   		} hypercall;
>   		/* KVM_EXIT_TPR_ACCESS */
>   		struct {
> @@ -1182,6 +1185,7 @@ struct kvm_ppc_resize_hpt {
>   #define KVM_CAP_S390_PROTECTED_ASYNC_DISABLE 224
>   #define KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP 225
>   #define KVM_CAP_PMU_EVENT_MASKED_EVENTS 226
> +#define KVM_CAP_COUNTER_OFFSET 227
>   
>   #ifdef KVM_CAP_IRQ_ROUTING
>   
> @@ -1449,7 +1453,7 @@ struct kvm_vfio_spapr_tce {
>   #define KVM_CREATE_VCPU           _IO(KVMIO,   0x41)
>   #define KVM_GET_DIRTY_LOG         _IOW(KVMIO,  0x42, struct kvm_dirty_log)
>   #define KVM_SET_NR_MMU_PAGES      _IO(KVMIO,   0x44)
> -#define KVM_GET_NR_MMU_PAGES      _IO(KVMIO,   0x45)
> +#define KVM_GET_NR_MMU_PAGES      _IO(KVMIO,   0x45)  /* deprecated */
>   #define KVM_SET_USER_MEMORY_REGION _IOW(KVMIO, 0x46, \
>   					struct kvm_userspace_memory_region)
>   #define KVM_SET_TSS_ADDR          _IO(KVMIO,   0x47)
> @@ -1541,6 +1545,8 @@ struct kvm_s390_ucas_mapping {
>   #define KVM_SET_PMU_EVENT_FILTER  _IOW(KVMIO,  0xb2, struct kvm_pmu_event_filter)
>   #define KVM_PPC_SVM_OFF		  _IO(KVMIO,  0xb3)
>   #define KVM_ARM_MTE_COPY_TAGS	  _IOR(KVMIO,  0xb4, struct kvm_arm_copy_mte_tags)
> +/* Available with KVM_CAP_COUNTER_OFFSET */
> +#define KVM_ARM_SET_COUNTER_OFFSET _IOW(KVMIO,  0xb5, struct kvm_arm_counter_offset)
>   
>   /* ioctl for vm fd */
>   #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
> diff --git a/linux-headers/linux/psp-sev.h b/linux-headers/linux/psp-sev.h
> index 51d8b3940e14..12ccb70099d4 100644
> --- a/linux-headers/linux/psp-sev.h
> +++ b/linux-headers/linux/psp-sev.h
> @@ -36,6 +36,13 @@ enum {
>    * SEV Firmware status code
>    */
>   typedef enum {
> +	/*
> +	 * This error code is not in the SEV spec. Its purpose is to convey that
> +	 * there was an error that prevented the SEV firmware from being called.
> +	 * The SEV API error codes are 16 bits, so the -1 value will not overlap
> +	 * with possible values from the specification.
> +	 */
> +	SEV_RET_NO_FW_CALL = -1,
>   	SEV_RET_SUCCESS = 0,
>   	SEV_RET_INVALID_PLATFORM_STATE,
>   	SEV_RET_INVALID_GUEST_STATE,
> diff --git a/linux-headers/linux/userfaultfd.h b/linux-headers/linux/userfaultfd.h
> index ba5d0df52fb8..14e402263a8a 100644
> --- a/linux-headers/linux/userfaultfd.h
> +++ b/linux-headers/linux/userfaultfd.h
> @@ -38,7 +38,8 @@
>   			   UFFD_FEATURE_MINOR_HUGETLBFS |	\
>   			   UFFD_FEATURE_MINOR_SHMEM |		\
>   			   UFFD_FEATURE_EXACT_ADDRESS |		\
> -			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM)
> +			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM |	\
> +			   UFFD_FEATURE_WP_UNPOPULATED)
>   #define UFFD_API_IOCTLS				\
>   	((__u64)1 << _UFFDIO_REGISTER |		\
>   	 (__u64)1 << _UFFDIO_UNREGISTER |	\
> @@ -203,6 +204,12 @@ struct uffdio_api {
>   	 *
>   	 * UFFD_FEATURE_WP_HUGETLBFS_SHMEM indicates that userfaultfd
>   	 * write-protection mode is supported on both shmem and hugetlbfs.
> +	 *
> +	 * UFFD_FEATURE_WP_UNPOPULATED indicates that userfaultfd
> +	 * write-protection mode will always apply to unpopulated pages
> +	 * (i.e. empty ptes).  This will be the default behavior for shmem
> +	 * & hugetlbfs, so this flag only affects anonymous memory behavior
> +	 * when userfault write-protection mode is registered.
>   	 */
>   #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
>   #define UFFD_FEATURE_EVENT_FORK			(1<<1)
> @@ -217,6 +224,7 @@ struct uffdio_api {
>   #define UFFD_FEATURE_MINOR_SHMEM		(1<<10)
>   #define UFFD_FEATURE_EXACT_ADDRESS		(1<<11)
>   #define UFFD_FEATURE_WP_HUGETLBFS_SHMEM		(1<<12)
> +#define UFFD_FEATURE_WP_UNPOPULATED		(1<<13)
>   	__u64 features;
>   
>   	__u64 ioctls;
> @@ -297,6 +305,13 @@ struct uffdio_writeprotect {
>   struct uffdio_continue {
>   	struct uffdio_range range;
>   #define UFFDIO_CONTINUE_MODE_DONTWAKE		((__u64)1<<0)
> +	/*
> +	 * UFFDIO_CONTINUE_MODE_WP will map the page write protected on
> +	 * the fly.  UFFDIO_CONTINUE_MODE_WP is available only if the
> +	 * write protected ioctl is implemented for the range
> +	 * according to the uffdio_register.ioctls.
> +	 */
> +#define UFFDIO_CONTINUE_MODE_WP			((__u64)1<<1)
>   	__u64 mode;
>   
>   	/*
> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index 4a534edbdcba..2658fda219e8 100644
> --- a/linux-headers/linux/vfio.h
> +++ b/linux-headers/linux/vfio.h
> @@ -646,6 +646,15 @@ enum {
>   	VFIO_CCW_NUM_IRQS
>   };
>   
> +/*
> + * The vfio-ap bus driver makes use of the following IRQ index mapping.
> + * Unimplemented IRQ types return a count of zero.
> + */
> +enum {
> +	VFIO_AP_REQ_IRQ_INDEX,
> +	VFIO_AP_NUM_IRQS
> +};
> +
>   /**
>    * VFIO_DEVICE_GET_PCI_HOT_RESET_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 12,
>    *					      struct vfio_pci_hot_reset_info)


