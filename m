Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD267DC16D
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 21:56:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxZIF-0003ab-9t; Mon, 30 Oct 2023 16:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qxZIC-0003Zr-Jk; Mon, 30 Oct 2023 16:55:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qxZIA-0002M9-64; Mon, 30 Oct 2023 16:55:24 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39UKlGQ8002623; Mon, 30 Oct 2023 20:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=x/sj4L5h0A07bhcQAvTKAvwdepBrjgpTtoSFUolZU4I=;
 b=Fk9wjHvyabm/qCkSzAVzLYKU+1RXpwehMylyIsJSrYegnDZQkYMZCL30s+Evv4Y7FE6Z
 mJR43+DFyRTYwD7Y2zMeTpsYimjjxSeONSEuyATCqjdMI5SGZZ/C7MWkmUsjmwm/eHbb
 qeoDOm+hi4pyzdp34/IaoGqIpUX8eCZDFo9cSsZGPrl4BLMycZVTC3Lu0BDlBQpzdEEp
 RVZchaI+9zBYneSmxS6sSqehkuRLcT6c7qP9Puozk7tzUNAUGNCDkilZo54VqS/OTDyO
 xt29Xw/aJXunMqtkoKzShaBpC04L471rqOzZNFvCOdc4ClCnfBSmsNcbKYixJH+wdn5/ Lw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2kty85cb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Oct 2023 20:55:13 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39UKo5xt010467;
 Mon, 30 Oct 2023 20:55:12 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2kty85bx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Oct 2023 20:55:12 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39UIlv55020285; Mon, 30 Oct 2023 20:55:11 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u1d0ybxna-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Oct 2023 20:55:11 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39UKtAkQ197346
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Oct 2023 20:55:11 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8904958060;
 Mon, 30 Oct 2023 20:55:10 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03B145805E;
 Mon, 30 Oct 2023 20:55:10 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 30 Oct 2023 20:55:09 +0000 (GMT)
Message-ID: <7dbcf9fe-4869-47ad-a2b5-ef91f9c223be@linux.ibm.com>
Date: Mon, 30 Oct 2023 16:55:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/14] tpm_tis_sysbus: move DSDT AML generation to
 device
Content-Language: en-US
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Song Gao <gaosong@loongson.cn>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "open list:Virt" <qemu-arm@nongnu.org>
References: <20231029060404.71196-1-j@getutm.app>
 <20231029060404.71196-10-j@getutm.app>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231029060404.71196-10-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xlSerEiDHePwyNeZvtfC1FaHVauZr99o
X-Proofpoint-GUID: JfveDgRd3q25pmI76Al76sWlhB_Mqslo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 priorityscore=1501 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300165
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 10/29/23 02:03, Joelle van Dyne wrote:
> This reduces redundent code in different machine types with ACPI table

s/redundent/redundant


> generation. Additionally, this will allow us to support different TPM
> interfaces with the same AML logic. Finally, this matches up with the
> TPM TIS ISA implementation.
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
>   hw/tpm/tpm_tis_sysbus.c   | 37 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 41 insertions(+), 72 deletions(-)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 9ce136cd88..3efbe6bd09 100644
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
> index ae292fc543..1969bfc8f9 100644
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
> index 2fc550f119..462b0e1571 100644
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
>   };
>
>   OBJECT_DECLARE_SIMPLE_TYPE(TPMStateSysBus, TPM_TIS_SYSBUS)
> @@ -93,6 +96,10 @@ static void tpm_tis_sysbus_reset(DeviceState *dev)
>   static Property tpm_tis_sysbus_properties[] = {
>       DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num, TPM_TIS_IRQ),
>       DEFINE_PROP_TPMBE("tpmdev", TPMStateSysBus, state.be_driver),
> +    DEFINE_PROP_UINT64("x-baseaddr", TPMStateSysBus, baseaddr,
> +                       TPM_TIS_ADDR_BASE),
> +    DEFINE_PROP_UINT64("x-size", TPMStateSysBus, size,
> +                       TPM_TIS_ADDR_SIZE),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>
> @@ -125,10 +132,38 @@ static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
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
> @@ -139,6 +174,7 @@ static void tpm_tis_sysbus_class_init(ObjectClass *klass, void *data)
>       tc->request_completed = tpm_tis_sysbus_request_completed;
>       tc->get_version = tpm_tis_sysbus_get_tpm_version;
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    adevc->build_dev_aml = build_tpm_tis_sysbus_aml;
>   }
>
>   static const TypeInfo tpm_tis_sysbus_info = {
> @@ -149,6 +185,7 @@ static const TypeInfo tpm_tis_sysbus_info = {
>       .class_init  = tpm_tis_sysbus_class_init,
>       .interfaces = (InterfaceInfo[]) {
>           { TYPE_TPM_IF },
> +        { TYPE_ACPI_DEV_AML_IF },
>           { }
>       }
>   };


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>



