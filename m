Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2ABF9C7A80
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Nov 2024 19:01:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBHfY-0005G8-QO; Wed, 13 Nov 2024 13:00:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tBHfW-0005Dp-I9
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:00:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tBHfU-0000B4-MW
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731520839;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q96V3Vi1t766xQh7am498hmWQcF9Cd8a8uGYTFIL4t4=;
 b=K/TokkbDjcn4VM7iNOA/nu3euWR3SEfUmhPw4jE3io8Yk0BAtIPkr8kkA2/IgMHVZuVI8W
 XPXpVhNxMdNza3Ueddp0b9Morxi8Iz5o9hiNh7+gB66QxrMR9wtEmp5vzubAE2FyJd457E
 gUOEy3gw9426jvJZhJgDfqJQSBfV2MM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-Epae-bC6P2aNGg3EkYlsXQ-1; Wed, 13 Nov 2024 13:00:36 -0500
X-MC-Unique: Epae-bC6P2aNGg3EkYlsXQ-1
X-Mimecast-MFC-AGG-ID: Epae-bC6P2aNGg3EkYlsXQ
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315af466d9so50135585e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 10:00:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731520835; x=1732125635;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q96V3Vi1t766xQh7am498hmWQcF9Cd8a8uGYTFIL4t4=;
 b=ldY8nSLQ9NmgZi55MKug4CdtWsfDW8XaTofiHscTumcHVH+X1G15F2S6x3TyBVBICm
 41FZTiG2J8s++SMDyS7PxUtEJ8zdbNB/GBF5IKMdSPhkMNsmOut78PawdkI4PBBRuJu2
 vyCCMNlZOq9uLFgamSzI/nUsjq+n03YzInRLUYhZnxGUkgQnRiVjMNMBqWFpTzlJT9ml
 TGAll5mgTAQd4ZKCxG0QqrG+4ZHKQDtJdrjBVdXTN6ku3ANYPNFLCvl5qhB1+KtOxRFj
 IzWzpANjCeTGUBuUMO5TEOogxA8BhzrGf4ccjRtzntnHGP4pufLKbpyErUeNAGnm1A/b
 JtLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSLFbvflXofCxexoFMMLE8GWVsJcUoKIB6wcyGzQmym444CwypoO69ogoWigTfUUxjK0xNo+nuGaJy@nongnu.org
X-Gm-Message-State: AOJu0YxQ7H78xTnlnTDs+hnTs+rQ8DxxxL4+mRhmjzEfcdK0C9PtrRMi
 K0S1adXssG7ATQtPU8pLhRu6OhmXZc8CLcXHavG7VEb/HJVznSqaq5p/5cjyofnAoYdJUh3PUFK
 Rl1em41w1dafdAJeD8j8yS8w8msZcmbrobE0Mgu9+CR+xCXf3H0yL
X-Received: by 2002:a05:600c:1f88:b0:425:80d5:b8b2 with SMTP id
 5b1f17b1804b1-432b7509ac4mr191988675e9.16.1731520835551; 
 Wed, 13 Nov 2024 10:00:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAJyQV86VurVST0NV7RQCFA7fIw+XSKZkfowxdMK9zpeOtuWaua9Atj94EmK9PpVlK0RFTAA==
X-Received: by 2002:a05:600c:1f88:b0:425:80d5:b8b2 with SMTP id
 5b1f17b1804b1-432b7509ac4mr191988155e9.16.1731520835154; 
 Wed, 13 Nov 2024 10:00:35 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432d4788c2asm26150885e9.0.2024.11.13.10.00.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 10:00:34 -0800 (PST)
Message-ID: <c3c3d515-1014-47fa-9c45-a7d61c7d4770@redhat.com>
Date: Wed, 13 Nov 2024 19:00:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] hw/arm/smmuv3: Add initial support for SMMUv3
 Nested device
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-3-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20241108125242.60136-3-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 11/8/24 13:52, Shameer Kolothum wrote:
> Based on SMMUv3 as a parent device, add a user-creatable
> smmuv3-nested device. Subsequent patches will add support to
> specify a PCI bus for this device.
>
> Currently only supported for "virt", so hook up the sybus mem & irq
> for that  as well.
>
> No FDT support is added for now.
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/smmuv3.c         | 34 ++++++++++++++++++++++++++++++++++
>  hw/arm/virt.c           | 31 +++++++++++++++++++++++++++++--
>  hw/core/sysbus-fdt.c    |  1 +
>  include/hw/arm/smmuv3.h | 15 +++++++++++++++
>  include/hw/arm/virt.h   |  6 ++++++
>  5 files changed, 85 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 2101031a8f..0033eb8125 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -2201,6 +2201,19 @@ static void smmu_realize(DeviceState *d, Error **errp)
>      smmu_init_irq(s, dev);
>  }
>  
> +static void smmu_nested_realize(DeviceState *d, Error **errp)
> +{
> +    SMMUv3NestedState *s_nested = ARM_SMMUV3_NESTED(d);
> +    SMMUv3NestedClass *c = ARM_SMMUV3_NESTED_GET_CLASS(s_nested);
> +    Error *local_err = NULL;
> +
> +    c->parent_realize(d, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +}
> +
>  static const VMStateDescription vmstate_smmuv3_queue = {
>      .name = "smmuv3_queue",
>      .version_id = 1,
> @@ -2299,6 +2312,18 @@ static void smmuv3_class_init(ObjectClass *klass, void *data)
>      device_class_set_props(dc, smmuv3_properties);
>  }
>  
> +static void smmuv3_nested_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    SMMUv3NestedClass *c = ARM_SMMUV3_NESTED_CLASS(klass);
> +
> +    dc->vmsd = &vmstate_smmuv3;
> +    device_class_set_parent_realize(dc, smmu_nested_realize,
> +                                    &c->parent_realize);
> +    dc->user_creatable = true;
this may be set at the very end of the series eventually.

Eric
> +    dc->hotpluggable = false;
> +}
> +
>  static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
>                                        IOMMUNotifierFlag old,
>                                        IOMMUNotifierFlag new,
> @@ -2337,6 +2362,14 @@ static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
>      imrc->notify_flag_changed = smmuv3_notify_flag_changed;
>  }
>  
> +static const TypeInfo smmuv3_nested_type_info = {
> +    .name          = TYPE_ARM_SMMUV3_NESTED,
> +    .parent        = TYPE_ARM_SMMUV3,
> +    .instance_size = sizeof(SMMUv3NestedState),
> +    .class_size    = sizeof(SMMUv3NestedClass),
> +    .class_init    = smmuv3_nested_class_init,
> +};
> +
>  static const TypeInfo smmuv3_type_info = {
>      .name          = TYPE_ARM_SMMUV3,
>      .parent        = TYPE_ARM_SMMU,
> @@ -2355,6 +2388,7 @@ static const TypeInfo smmuv3_iommu_memory_region_info = {
>  static void smmuv3_register_types(void)
>  {
>      type_register(&smmuv3_type_info);
> +    type_register(&smmuv3_nested_type_info);
>      type_register(&smmuv3_iommu_memory_region_info);
>  }
>  
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 780bcff77c..38075f9ab2 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -181,6 +181,7 @@ static const MemMapEntry base_memmap[] = {
>      [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
>      [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
>      [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
> +    [VIRT_SMMU_NESTED] =        { 0x0b000000, 0x01000000 },
>      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
>      [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
>      [VIRT_SECURE_MEM] =         { 0x0e000000, 0x01000000 },
> @@ -226,6 +227,7 @@ static const int a15irqmap[] = {
>      [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
>      [VIRT_SMMU] = 74,    /* ...to 74 + NUM_SMMU_IRQS - 1 */
>      [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 */
> +    [VIRT_SMMU_NESTED] = 200,
>  };
>  
>  static void create_randomness(MachineState *ms, const char *node)
> @@ -2883,10 +2885,34 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>                                          DeviceState *dev, Error **errp)
>  {
>      VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
> +    MachineClass *mc = MACHINE_GET_CLASS(vms);
>  
> -    if (vms->platform_bus_dev) {
> -        MachineClass *mc = MACHINE_GET_CLASS(vms);
> +    /* For smmuv3-nested devices we need to set the mem & irq */
> +    if (device_is_dynamic_sysbus(mc, dev) &&
> +        object_dynamic_cast(OBJECT(dev), TYPE_ARM_SMMUV3_NESTED)) {
> +        hwaddr base = vms->memmap[VIRT_SMMU_NESTED].base;
> +        int irq =  vms->irqmap[VIRT_SMMU_NESTED];
> +
> +        if (vms->smmu_nested_count >= MAX_SMMU_NESTED) {
> +            error_setg(errp, "smmuv3-nested max count reached!");
> +            return;
> +        }
> +
> +        base += (vms->smmu_nested_count * SMMU_IO_LEN);
> +        irq += (vms->smmu_nested_count * NUM_SMMU_IRQS);
>  
> +        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
> +        for (int i = 0; i < 4; i++) {
> +            sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
> +                               qdev_get_gpio_in(vms->gic, irq + i));
> +        }
> +        if (vms->iommu != VIRT_IOMMU_SMMUV3_NESTED) {
> +            vms->iommu = VIRT_IOMMU_SMMUV3_NESTED;
> +        }
> +        vms->smmu_nested_count++;
> +    }
> +
> +    if (vms->platform_bus_dev) {
>          if (device_is_dynamic_sysbus(mc, dev)) {
>              platform_bus_link_device(PLATFORM_BUS_DEVICE(vms->platform_bus_dev),
>                                       SYS_BUS_DEVICE(dev));
> @@ -3067,6 +3093,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_AMD_XGBE);
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_PLATFORM);
> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ARM_SMMUV3_NESTED);
>  #ifdef CONFIG_TPM
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
>  #endif
> diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
> index eebcd28f9a..0f0d0b3e58 100644
> --- a/hw/core/sysbus-fdt.c
> +++ b/hw/core/sysbus-fdt.c
> @@ -489,6 +489,7 @@ static const BindingEntry bindings[] = {
>  #ifdef CONFIG_LINUX
>      TYPE_BINDING(TYPE_VFIO_CALXEDA_XGMAC, add_calxeda_midway_xgmac_fdt_node),
>      TYPE_BINDING(TYPE_VFIO_AMD_XGBE, add_amd_xgbe_fdt_node),
> +    TYPE_BINDING("arm-smmuv3-nested", no_fdt_node),
>      VFIO_PLATFORM_BINDING("amd,xgbe-seattle-v1a", add_amd_xgbe_fdt_node),
>  #endif
>  #ifdef CONFIG_TPM
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index d183a62766..87e628be7a 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -84,6 +84,21 @@ struct SMMUv3Class {
>  #define TYPE_ARM_SMMUV3   "arm-smmuv3"
>  OBJECT_DECLARE_TYPE(SMMUv3State, SMMUv3Class, ARM_SMMUV3)
>  
> +#define TYPE_ARM_SMMUV3_NESTED   "arm-smmuv3-nested"
> +OBJECT_DECLARE_TYPE(SMMUv3NestedState, SMMUv3NestedClass, ARM_SMMUV3_NESTED)
> +
> +struct SMMUv3NestedState {
> +    SMMUv3State smmuv3_state;
> +};
> +
> +struct SMMUv3NestedClass {
> +    /*< private >*/
> +    SMMUv3Class smmuv3_class;
> +    /*< public >*/
> +
> +    DeviceRealize parent_realize;
> +};
> +
>  #define STAGE1_SUPPORTED(s)      FIELD_EX32(s->idr[0], IDR0, S1P)
>  #define STAGE2_SUPPORTED(s)      FIELD_EX32(s->idr[0], IDR0, S2P)
>  
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 46f48fe561..50e47a4ef3 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -50,6 +50,9 @@
>  /* MMIO region size for SMMUv3 */
>  #define SMMU_IO_LEN 0x20000
>  
> +/* Max supported nested SMMUv3 */
> +#define MAX_SMMU_NESTED 128
> +
>  enum {
>      VIRT_FLASH,
>      VIRT_MEM,
> @@ -62,6 +65,7 @@ enum {
>      VIRT_GIC_ITS,
>      VIRT_GIC_REDIST,
>      VIRT_SMMU,
> +    VIRT_SMMU_NESTED,
>      VIRT_UART0,
>      VIRT_MMIO,
>      VIRT_RTC,
> @@ -92,6 +96,7 @@ enum {
>  typedef enum VirtIOMMUType {
>      VIRT_IOMMU_NONE,
>      VIRT_IOMMU_SMMUV3,
> +    VIRT_IOMMU_SMMUV3_NESTED,
>      VIRT_IOMMU_VIRTIO,
>  } VirtIOMMUType;
>  
> @@ -155,6 +160,7 @@ struct VirtMachineState {
>      bool mte;
>      bool dtb_randomness;
>      bool second_ns_uart_present;
> +    int smmu_nested_count;
>      OnOffAuto acpi;
>      VirtGICType gic_version;
>      VirtIOMMUType iommu;


