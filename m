Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0C2753FC2
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 18:20:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKLVl-0001Fn-Hx; Fri, 14 Jul 2023 12:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qKLVj-0001FI-G2; Fri, 14 Jul 2023 12:19:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qKLVh-0005XU-DK; Fri, 14 Jul 2023 12:19:15 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36EFmEeT027738; Fri, 14 Jul 2023 16:19:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=VGFgLUnJnG+wvEMBCmbJBP95C4pVe2OF1T2r4rX2TY0=;
 b=qFkDvHOOFqv1iPv8rix8m802LzyqUF9l6fSlWXGiVz66TWM3YHgki2MZDFn51R8t2oFY
 7FgPSxMjVkgKZ66R/IO3iYzX6h1EXdALyRdfQNFXXkwiPL/3FT89dF9wUY3nNuSHKyBJ
 +7uZYVLNxroBcUb3lHJ3H+Y6y8RTqjsWCdyIukHzIs3bJt9ZiZfH2gYG2sZIUCUA9BBs
 G/UVQLA/Z6C0rBlkAqOqWUyMACmubv0wpcJicNg6yv7CsBBVMVP2ar6BtqTbhWy0+Chk
 SKaIVOw6rQzO4ZFQgOGYn59jNKZdryW+yc1Rkk1m+nSHI62Al/0k+LLrX6l2Skc7FjMd Pw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ru9a5rtrm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 16:19:05 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36EG8D7W029590;
 Fri, 14 Jul 2023 16:19:05 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ru9a5rtr6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 16:19:05 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36EGEpI1008121;
 Fri, 14 Jul 2023 16:19:04 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
 by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3rtqkhvcbj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 16:19:04 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36EGJ32f35783064
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jul 2023 16:19:04 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9ACE75805D;
 Fri, 14 Jul 2023 16:19:03 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A36415805A;
 Fri, 14 Jul 2023 16:19:02 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 14 Jul 2023 16:19:02 +0000 (GMT)
Message-ID: <d3d3d9d0-fb88-9500-34d9-9780f9c2644f@linux.ibm.com>
Date: Fri, 14 Jul 2023 12:19:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 09/11] tpm_tis_sysbus: move DSDT AML generation to
 device
Content-Language: en-US
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "open list:ARM ACPI Subsystem" <qemu-arm@nongnu.org>
References: <20230714070931.23476-1-j@getutm.app>
 <20230714070931.23476-10-j@getutm.app>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230714070931.23476-10-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7g0WAZkZv68hF1bolBaxdhmHiag0Fx6y
X-Proofpoint-ORIG-GUID: -6T0gFKGXwnMsuuHKBBuY1OIM9BQs9RU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_07,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 spamscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140146
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 7/14/23 03:09, Joelle van Dyne wrote:
> This reduces redundent code in different machine types with ACPI table
> generation. Additionally, this will allow us to support multiple TPM
> interfaces. Finally, this matches up with the TPM TIS ISA

I don't know whether we would want multiple devices. tpm_find() usage is certainly not prepared for multiple devices.

> implementation.
> 
> Ideally, we would be able to call `qbus_build_aml` and avoid any TPM
> specific code in the ACPI table generation. However, currently we
> still have to call `build_tpm2` anyways and it does not look like
> most other ACPI devices support the `ACPI_DEV_AML_IF` interface.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>   hw/arm/virt-acpi-build.c  | 38 ++------------------------------------
>   hw/loongarch/acpi-build.c | 38 ++------------------------------------
>   hw/tpm/tpm_tis_sysbus.c   | 35 +++++++++++++++++++++++++++++++++++
>   3 files changed, 39 insertions(+), 72 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 6b674231c2..49b2f19440 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -35,6 +35,7 @@
>   #include "target/arm/cpu.h"
>   #include "hw/acpi/acpi-defs.h"
>   #include "hw/acpi/acpi.h"
> +#include "hw/acpi/acpi_aml_interface.h"
>   #include "hw/nvram/fw_cfg.h"
>   #include "hw/acpi/bios-linker-loader.h"
>   #include "hw/acpi/aml-build.h"
> @@ -208,41 +209,6 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
>       aml_append(scope, dev);
>   }
> 
> -#ifdef CONFIG_TPM
> -static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
> -{
> -    PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
> -    hwaddr pbus_base = vms->memmap[VIRT_PLATFORM_BUS].base;
> -    SysBusDevice *sbdev = SYS_BUS_DEVICE(tpm_find());
> -    MemoryRegion *sbdev_mr;
> -    hwaddr tpm_base;
> -
> -    if (!sbdev) {
> -        return;
> -    }
> -
> -    tpm_base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
> -    assert(tpm_base != -1);
> -
> -    tpm_base += pbus_base;
> -
> -    sbdev_mr = sysbus_mmio_get_region(sbdev, 0);
> -
> -    Aml *dev = aml_device("TPM0");
> -    aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
> -    aml_append(dev, aml_name_decl("_STR", aml_string("TPM 2.0 Device")));
> -    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> -
> -    Aml *crs = aml_resource_template();
> -    aml_append(crs,
> -               aml_memory32_fixed(tpm_base,
> -                                  (uint32_t)memory_region_size(sbdev_mr),
> -                                  AML_READ_WRITE));
> -    aml_append(dev, aml_name_decl("_CRS", crs));
> -    aml_append(scope, dev);
> -}
> -#endif
> -
>   #define ID_MAPPING_ENTRY_SIZE 20
>   #define SMMU_V3_ENTRY_SIZE 68
>   #define ROOT_COMPLEX_ENTRY_SIZE 36
> @@ -891,7 +857,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> 
>       acpi_dsdt_add_power_button(scope);
>   #ifdef CONFIG_TPM
> -    acpi_dsdt_add_tpm(scope, vms);
> +    call_dev_aml_func(DEVICE(tpm_find()), scope);
>   #endif
> 
>       aml_append(dsdt, scope);
> diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
> index 0b62c3a2f7..4291e670c8 100644
> --- a/hw/loongarch/acpi-build.c
> +++ b/hw/loongarch/acpi-build.c
> @@ -14,6 +14,7 @@
>   #include "target/loongarch/cpu.h"
>   #include "hw/acpi/acpi-defs.h"
>   #include "hw/acpi/acpi.h"
> +#include "hw/acpi/acpi_aml_interface.h"
>   #include "hw/nvram/fw_cfg.h"
>   #include "hw/acpi/bios-linker-loader.h"
>   #include "migration/vmstate.h"
> @@ -328,41 +329,6 @@ static void build_flash_aml(Aml *scope, LoongArchMachineState *lams)
>       aml_append(scope, dev);
>   }
> 
> -#ifdef CONFIG_TPM
> -static void acpi_dsdt_add_tpm(Aml *scope, LoongArchMachineState *vms)
> -{
> -    PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
> -    hwaddr pbus_base = VIRT_PLATFORM_BUS_BASEADDRESS;
> -    SysBusDevice *sbdev = SYS_BUS_DEVICE(tpm_find());
> -    MemoryRegion *sbdev_mr;
> -    hwaddr tpm_base;
> -
> -    if (!sbdev) {
> -        return;
> -    }
> -
> -    tpm_base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
> -    assert(tpm_base != -1);
> -
> -    tpm_base += pbus_base;
> -
> -    sbdev_mr = sysbus_mmio_get_region(sbdev, 0);
> -
> -    Aml *dev = aml_device("TPM0");
> -    aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
> -    aml_append(dev, aml_name_decl("_STR", aml_string("TPM 2.0 Device")));
> -    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> -
> -    Aml *crs = aml_resource_template();
> -    aml_append(crs,
> -               aml_memory32_fixed(tpm_base,
> -                                  (uint32_t)memory_region_size(sbdev_mr),
> -                                  AML_READ_WRITE));
> -    aml_append(dev, aml_name_decl("_CRS", crs));
> -    aml_append(scope, dev);
> -}
> -#endif
> -

Good for the consolidation.

>   /* build DSDT */
>   static void
>   build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
> @@ -379,7 +345,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>       build_la_ged_aml(dsdt, machine);
>       build_flash_aml(dsdt, lams);
>   #ifdef CONFIG_TPM
> -    acpi_dsdt_add_tpm(dsdt, lams);
> +    call_dev_aml_func(DEVICE(tpm_find()), dsdt);
>   #endif
>       /* System State Package */
>       scope = aml_scope("\\");
> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
> index 45e63efd63..b3ea2305b5 100644
> --- a/hw/tpm/tpm_tis_sysbus.c
> +++ b/hw/tpm/tpm_tis_sysbus.c
> @@ -30,6 +30,7 @@
>   #include "hw/sysbus.h"
>   #include "tpm_tis.h"
>   #include "qom/object.h"
> +#include "hw/acpi/acpi_aml_interface.h"
> 
>   struct TPMStateSysBus {
>       /*< private >*/
> @@ -37,6 +38,8 @@ struct TPMStateSysBus {
> 
>       /*< public >*/
>       TPMState state; /* not a QOM object */
> +    uint64_t baseaddr;
> +    uint64_t size;

Does moving the TIS to a different address help on aarch64?

Can the size really be an option? I don't see it useful and if one gave the wrong size it may break things.

>   };
> 
>   OBJECT_DECLARE_SIMPLE_TYPE(TPMStateSysBus, TPM_TIS_SYSBUS)
> @@ -94,6 +97,8 @@ static Property tpm_tis_sysbus_properties[] = {
>       DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num, TPM_TIS_IRQ),
>       DEFINE_PROP_TPMBE("tpmdev", TPMStateSysBus, state.be_driver),
>       DEFINE_PROP_BOOL("ppi", TPMStateSysBus, state.ppi_enabled, false),
> +    DEFINE_PROP_UINT64("baseaddr", TPMStateSysBus, baseaddr, TPM_TIS_ADDR_BASE),
> +    DEFINE_PROP_UINT64("size", TPMStateSysBus, size, TPM_TIS_ADDR_SIZE),


>       DEFINE_PROP_END_OF_LIST(),
>   };
> 
> @@ -126,10 +131,38 @@ static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
>       }
>   }
> 
> +static void build_tpm_tis_sysbus_aml(AcpiDevAmlIf *adev, Aml *scope)
> +{
> +    Aml *dev, *crs;
> +    TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(adev);
> +    TPMIf *ti = TPM_IF(sbdev);
> +
> +    dev = aml_device("TPM");
> +    if (tpm_tis_sysbus_get_tpm_version(ti) == TPM_VERSION_2_0) {
> +        aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
> +        aml_append(dev, aml_name_decl("_STR", aml_string("TPM 2.0 Device")));
> +    } else {
> +        aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C31")));
> +    }
> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
> +    crs = aml_resource_template();
> +    aml_append(crs, aml_memory32_fixed(sbdev->baseaddr, sbdev->size,
> +                                      AML_READ_WRITE));
> +    /*
> +     * FIXME: TPM_TIS_IRQ=5 conflicts with PNP0C0F irqs,
> +     * fix default TPM_TIS_IRQ value there to use some unused IRQ
> +     */
> +    /* aml_append(crs, aml_irq_no_flags(sbdev->state.irq_num)); */
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +    aml_append(scope, dev);
> +}
> +
>   static void tpm_tis_sysbus_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       TPMIfClass *tc = TPM_IF_CLASS(klass);
> +    AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
> 
>       device_class_set_props(dc, tpm_tis_sysbus_properties);
>       dc->vmsd  = &vmstate_tpm_tis_sysbus;
> @@ -140,6 +173,7 @@ static void tpm_tis_sysbus_class_init(ObjectClass *klass, void *data)
>       tc->request_completed = tpm_tis_sysbus_request_completed;
>       tc->get_version = tpm_tis_sysbus_get_tpm_version;
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    adevc->build_dev_aml = build_tpm_tis_sysbus_aml;
>   }
> 
>   static const TypeInfo tpm_tis_sysbus_info = {
> @@ -150,6 +184,7 @@ static const TypeInfo tpm_tis_sysbus_info = {
>       .class_init  = tpm_tis_sysbus_class_init,
>       .interfaces = (InterfaceInfo[]) {
>           { TYPE_TPM_IF },
> +        { TYPE_ACPI_DEV_AML_IF },
>           { }
>       }
>   };

