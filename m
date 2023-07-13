Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7904075280B
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 18:09:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJyrf-00055h-HW; Thu, 13 Jul 2023 12:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qJyra-00052V-Ke
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 12:08:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qJyrX-0008Tu-B7
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 12:08:18 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36DFnB1u000534; Thu, 13 Jul 2023 16:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=z3d+6DyXWU7WHWgR19GETHuah9MxTv8UHpARsMEnHU4=;
 b=RlduLpdb9R+4zb/EsF6WOxrmadNeGsgjYPiyWTFOskFXPfUE/7DqvhyLCYcgJ0Uon957
 63fVz8K/ugoiczDF7GVCQt+jjjeTqnAn5iQJzzfdiGHY1e50O+rm54FfbwW4vtbh3kee
 Mu75LRI3BQGitQpLBCQOkG3K7ScA0seOUSiMcSzkZ0egzP1wyd560jKBycAzeUNVGq8r
 Nf9xJqceQdIzS6mSpw/Y5yZkRTAiwfNZXyB+EkCKhAq8UhCjWO7ywUccx3+jeeehMlud
 rG9/2rlaYGAWSqxGBi9LtlGmbWAZInwe/VCeWM4ATy0PjrtYSxfH/keABF3M7vBTsOYH hw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rtm838ecn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 16:08:11 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36DG7rPD025366;
 Thu, 13 Jul 2023 16:08:10 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rtm838ebw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 16:08:10 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36DDuj0G005820; Thu, 13 Jul 2023 16:08:10 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rqj4rrbmd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 16:08:10 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36DG89nB3015348
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jul 2023 16:08:09 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4CDCA5805B;
 Thu, 13 Jul 2023 16:08:09 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 602C55804B;
 Thu, 13 Jul 2023 16:08:08 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Jul 2023 16:08:08 +0000 (GMT)
Message-ID: <d51ec99a-81d3-76ab-648f-f80550856271@linux.ibm.com>
Date: Thu, 13 Jul 2023 12:08:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 06/11] tpm_crb: move ACPI table building to device
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
References: <20230713035232.48406-1-j@getutm.app>
 <20230713035232.48406-7-j@getutm.app>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230713035232.48406-7-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8oze-fy8k7nam6lS7Xo-Ro79SJWzTC0D
X-Proofpoint-GUID: iBaqShk9NPS566cx8km_R2kQcMwV4fD6
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307130142
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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



On 7/12/23 23:51, Joelle van Dyne wrote:
> This logic is similar to TPM TIS ISA device.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>   hw/i386/acpi-build.c | 23 -----------------------
>   hw/tpm/tpm_crb.c     | 28 ++++++++++++++++++++++++++++
>   2 files changed, 28 insertions(+), 23 deletions(-)
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
> index 6144081d30..14feb9857f 100644
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
> @@ -116,10 +118,34 @@ static void tpm_crb_isa_realize(DeviceState *dev, Error **errp)
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
> +    if (tpm_crb_isa_get_version(ti) == TPM_VERSION_2_0) {
> +        aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
> +        aml_append(dev, aml_name_decl("_STR", aml_string("TPM 2.0 Device")));
> +    } else {
> +        aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C31")));
> +    }

CRB only exists for TPM 2.0 and that's why we didn't have a different case here before.

CRB only has MSFT0101: https://elixir.bootlin.com/linux/latest/source/drivers/char/tpm/tpm_crb.c#L820
TIS has PNP0C31: https://elixir.bootlin.com/linux/latest/source/drivers/char/tpm/tpm_tis.c

You should remove the check for TPM_VERSION_2_0.

    Stefan
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
> @@ -128,6 +154,7 @@ static void tpm_crb_isa_class_init(ObjectClass *klass, void *data)
>       tc->model = TPM_MODEL_TPM_CRB;
>       tc->get_version = tpm_crb_isa_get_version;
>       tc->request_completed = tpm_crb_isa_request_completed;
> +    adevc->build_dev_aml = build_tpm_crb_isa_aml;
> 
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>   }
> @@ -139,6 +166,7 @@ static const TypeInfo tpm_crb_isa_info = {
>       .class_init  = tpm_crb_isa_class_init,
>       .interfaces = (InterfaceInfo[]) {
>           { TYPE_TPM_IF },
> +        { TYPE_ACPI_DEV_AML_IF },
>           { }
>       }
>   };

