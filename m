Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6193754191
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 19:55:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKN0a-0005uZ-MS; Fri, 14 Jul 2023 13:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qKN0Y-0005uR-V7
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 13:55:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qKN0X-0000Rp-6c
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 13:55:10 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36EHmi11016825; Fri, 14 Jul 2023 17:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=haLR2OKAZst7VNc3u8TvC8AOdoaAvN5AErPikJkR28I=;
 b=lxd6U2m2L4JhIZNSvilP0t7VTyEJ9m6W4ByklHWAdZtoUKKXAyfm57cEX7+aZnIi800z
 SHIPNgoC9ahxJUUeEkE6MeTqyqiV1Qj1LzeLprfVaV6uqzFmL1BKTXgCI3bYaEzHjLr8
 us49JSreDcZtk5RnYZO51VrSTm161/Z6axtDmdrlG1VMIdr8gI98WJ1+nr+8EatLRIhe
 e5gdxdnv2zdcxpl5d2gnkppkWtIFdgaEe8YTWK1jEQAuvQVvhdMLeSFgpW8dZArBHiJT
 NC70IyfDv5p3LcPc/FlgqNYnmySvAkdM6lBADOFe/yBv9rbEVbhK0QjXfWUG15DnbC4R jw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rub3304hx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 17:55:06 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36EHpjSi024530;
 Fri, 14 Jul 2023 17:55:05 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rub3304fx-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 17:55:05 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36EG9a9t008108;
 Fri, 14 Jul 2023 17:21:35 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
 by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3rtqkhvm0b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 17:21:35 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36EHLYsg4456980
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jul 2023 17:21:34 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F48558043;
 Fri, 14 Jul 2023 17:21:34 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 90D2E58055;
 Fri, 14 Jul 2023 17:21:33 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 14 Jul 2023 17:21:33 +0000 (GMT)
Message-ID: <c3e07358-0d07-ffdc-6dbf-aab763ef92be@linux.ibm.com>
Date: Fri, 14 Jul 2023 13:21:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 06/11] tpm_crb: move ACPI table building to device
 interface
Content-Language: en-US
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20230714070931.23476-1-j@getutm.app>
 <20230714070931.23476-7-j@getutm.app>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230714070931.23476-7-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fItq4F4UBDX-Qy_g6ASKAM3etczK21bh
X-Proofpoint-ORIG-GUID: mAE8UogTHS8Fobc_8DB76HAeZW_n3hnD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_08,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140160
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
> This logic is similar to TPM TIS ISA device. Since TPM CRB can only
> support TPM 2.0 backends, we check for this in realize.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>

This patch changes the order of in which the ACPI table elements are created but doesn't matter and also doesn't seem to upset ACPI test cases from what I saw:

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   hw/i386/acpi-build.c | 23 -----------------------
>   hw/tpm/tpm_crb.c     | 29 +++++++++++++++++++++++++++++
>   2 files changed, 29 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 9c74fa17ad..b767df39df 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1441,9 +1441,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>       uint32_t nr_mem = machine->ram_slots;
>       int root_bus_limit = 0xFF;
>       PCIBus *bus = NULL;
> -#ifdef CONFIG_TPM
> -    TPMIf *tpm = tpm_find();
> -#endif
>       bool cxl_present = false;
>       int i;
>       VMBusBridge *vmbus_bridge = vmbus_bridge_find();
> @@ -1793,26 +1790,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>           }
>       }
> 
> -#ifdef CONFIG_TPM
> -    if (TPM_IS_CRB(tpm)) {
> -        dev = aml_device("TPM");
> -        aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
> -        aml_append(dev, aml_name_decl("_STR",
> -                                      aml_string("TPM 2.0 Device")));
> -        crs = aml_resource_template();
> -        aml_append(crs, aml_memory32_fixed(TPM_CRB_ADDR_BASE,
> -                                           TPM_CRB_ADDR_SIZE, AML_READ_WRITE));
> -        aml_append(dev, aml_name_decl("_CRS", crs));
> -
> -        aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
> -        aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> -
> -        tpm_build_ppi_acpi(tpm, dev);
> -
> -        aml_append(sb_scope, dev);
> -    }
> -#endif
> -
>       if (pcms->sgx_epc.size != 0) {
>           uint64_t epc_base = pcms->sgx_epc.base;
>           uint64_t epc_size = pcms->sgx_epc.size;
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 6144081d30..594696ffb8 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -19,6 +19,8 @@
>   #include "qemu/module.h"
>   #include "qapi/error.h"
>   #include "exec/address-spaces.h"
> +#include "hw/acpi/acpi_aml_interface.h"
> +#include "hw/acpi/tpm.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/pci/pci_ids.h"
>   #include "hw/acpi/tpm.h"
> @@ -99,6 +101,11 @@ static void tpm_crb_isa_realize(DeviceState *dev, Error **errp)
>           return;
>       }
> 
> +    if (tpm_crb_isa_get_version(TPM_IF(s)) != TPM_VERSION_2_0) {
> +        error_setg(errp, "TPM CRB only supports TPM 2.0 backends");
> +        return;
> +    }
> +
>       tpm_crb_init_memory(OBJECT(s), &s->state, errp);
> 
>       memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
> @@ -116,10 +123,30 @@ static void tpm_crb_isa_realize(DeviceState *dev, Error **errp)
>       }
>   }
> 
> +static void build_tpm_crb_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
> +{
> +    Aml *dev, *crs;
> +    CRBState *s = CRB(adev);
> +    TPMIf *ti = TPM_IF(s);
> +
> +    dev = aml_device("TPM");
> +    aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
> +    aml_append(dev, aml_name_decl("_STR", aml_string("TPM 2.0 Device")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
> +    crs = aml_resource_template();
> +    aml_append(crs, aml_memory32_fixed(TPM_CRB_ADDR_BASE, TPM_CRB_ADDR_SIZE,
> +                                      AML_READ_WRITE));
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +    tpm_build_ppi_acpi(ti, dev);
> +    aml_append(scope, dev);
> +}
> +
>   static void tpm_crb_isa_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       TPMIfClass *tc = TPM_IF_CLASS(klass);
> +    AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
> 
>       dc->realize = tpm_crb_isa_realize;
>       device_class_set_props(dc, tpm_crb_isa_properties);
> @@ -128,6 +155,7 @@ static void tpm_crb_isa_class_init(ObjectClass *klass, void *data)
>       tc->model = TPM_MODEL_TPM_CRB;
>       tc->get_version = tpm_crb_isa_get_version;
>       tc->request_completed = tpm_crb_isa_request_completed;
> +    adevc->build_dev_aml = build_tpm_crb_isa_aml;
> 
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>   }
> @@ -139,6 +167,7 @@ static const TypeInfo tpm_crb_isa_info = {
>       .class_init  = tpm_crb_isa_class_init,
>       .interfaces = (InterfaceInfo[]) {
>           { TYPE_TPM_IF },
> +        { TYPE_ACPI_DEV_AML_IF },
>           { }
>       }
>   };

