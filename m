Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A67752324
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 15:15:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJw8i-0008Ur-F7; Thu, 13 Jul 2023 09:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qJw8a-0008TI-9o; Thu, 13 Jul 2023 09:13:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qJw8X-0003eL-OX; Thu, 13 Jul 2023 09:13:39 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36DCcsWM007699; Thu, 13 Jul 2023 13:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=NnO57kTCGQgwHzYR73QwIhz+NuY9lV53SBjgquzVZMA=;
 b=DNQflXbZFmGH//mNNEGTWDinImYtN2GsxbpeARUZaE9v+YexgRQr03By0yztAc8KXTJm
 MkCL0VeTR6S5pwLlPWqXTABZQTOdIeM3c0hk5LwF94ACr9Wi/xniCfpSzBDDJZ/499Re
 7IM85KQ6plzHbpltd4eq4UnEK6FZTTBPRNdtx3UobcfBqvEfMuWyn+kxuindm8pwMeVb
 r/KQSgIYEz7RlS9OzmpPmDFcvygBg/YqCtQPmQDKdKfrX+MdUSGJTHIbu+V0vc9Cjwtj
 bw274QBPuZep1+RA/z24eUbvjy8XDXqdYANyXytYlFhqif5dR9ARloMXW1VAVWIe1ORv NA== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rtgtf2bjx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 13:13:32 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36DD8ToQ027325;
 Thu, 13 Jul 2023 13:13:32 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
 by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3rpye6gjsb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 13:13:31 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36DDDU86262852
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jul 2023 13:13:31 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9FE4658043;
 Thu, 13 Jul 2023 13:13:30 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A11258055;
 Thu, 13 Jul 2023 13:13:30 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Jul 2023 13:13:30 +0000 (GMT)
Message-ID: <f17c40ee-ba8d-07d5-8673-1387ad98d581@linux.ibm.com>
Date: Thu, 13 Jul 2023 09:13:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 07/11] hw/arm/virt: add plug handler for TPM on SysBus
Content-Language: en-US
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:Virt" <qemu-arm@nongnu.org>
References: <20230713035232.48406-1-j@getutm.app>
 <20230713035232.48406-8-j@getutm.app>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230713035232.48406-8-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ug2mGnXxzTdNTPSARXNdZTyaBBmO3TP2
X-Proofpoint-ORIG-GUID: ug2mGnXxzTdNTPSARXNdZTyaBBmO3TP2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_05,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011
 phishscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxlogscore=629 impostorscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307130114
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
> TPM needs to know its own base address in order to generate its DSDT
> device entry.

This and the loongarch patch seem to have largely identical virt_tpm_plug functions.
Could they be consolidated in hw/tpm/virt.c  ?

    Stefan
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>   hw/arm/virt.c | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 7d9dbc2663..432148ef47 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2732,6 +2732,37 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
>                            dev, &error_abort);
>   }
> 
> +#ifdef CONFIG_TPM
> +static void virt_tpm_plug(VirtMachineState *vms, TPMIf *tpmif)
> +{
> +    PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
> +    hwaddr pbus_base = vms->memmap[VIRT_PLATFORM_BUS].base;
> +    SysBusDevice *sbdev = SYS_BUS_DEVICE(tpmif);
> +    MemoryRegion *sbdev_mr;
> +    hwaddr tpm_base;
> +    uint64_t tpm_size;
> +
> +    if (!sbdev || !object_dynamic_cast(OBJECT(sbdev), TYPE_SYS_BUS_DEVICE)) {
> +        return;
> +    }
> +
> +    tpm_base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
> +    assert(tpm_base != -1);
> +
> +    tpm_base += pbus_base;
> +
> +    sbdev_mr = sysbus_mmio_get_region(sbdev, 0);
> +    tpm_size = memory_region_size(sbdev_mr);
> +
> +    if (object_property_find(OBJECT(sbdev), "baseaddr")) {
> +        object_property_set_uint(OBJECT(sbdev), "baseaddr", tpm_base, NULL);
> +    }
> +    if (object_property_find(OBJECT(sbdev), "size")) {
> +        object_property_set_uint(OBJECT(sbdev), "size", tpm_size, NULL);
> +    }
> +}
> +#endif
> +
>   static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>                                               DeviceState *dev, Error **errp)
>   {
> @@ -2803,6 +2834,12 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>           vms->virtio_iommu_bdf = pci_get_bdf(pdev);
>           create_virtio_iommu_dt_bindings(vms);
>       }
> +
> +#ifdef CONFIG_TPM
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_TPM_IF)) {
> +        virt_tpm_plug(vms, TPM_IF(dev));
> +    }
> +#endif
>   }
> 
>   static void virt_dimm_unplug_request(HotplugHandler *hotplug_dev,

