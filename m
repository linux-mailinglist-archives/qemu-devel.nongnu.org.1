Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFA1752A5E
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 20:37:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK1AE-0003JO-RI; Thu, 13 Jul 2023 14:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qK1A9-0003J6-GL
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 14:35:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qK1A5-0001xX-Su
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 14:35:35 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36DIHw1T030794; Thu, 13 Jul 2023 18:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=6p2YsRvwpmYxWGh3dfCxMZokjm8LXgvF37E8bw78s+I=;
 b=oxEdSmnbpd1rBLKNPyACqdcCZ8M/NQPS1gYR+CIHVStc4T6d4A/vjwj+Z6l7/rYw2iFL
 CdO+5SDwXlNolQSs8QRNwPWzyu0PjLOVIsa38IyA+kSvIJd97LiDiGT+eoSBr+6E/UG6
 JYtNQ7fwF0KAQW3dnbcF4MVHcaJTdfHQhL2jELt4ijykMk3WQ1fil7xf6brXpi634s9L
 w+Vy77gI95EJ/hYeen0jQMCd71JXKwWtfmOdz+7LCo1g+Y3G47DrQkFN602y/sv0CslI
 TmPPJXG9DEvHCgCkmOExqIKiM0acAwwvPwQ4iS5KlkhM3wljwniVSArz0gcdiD3aZJgW qg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rtpe4rcc4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 18:35:31 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36DIYjAk011059;
 Thu, 13 Jul 2023 18:35:30 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rtpe4rcbk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 18:35:30 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36DDtomL005042; Thu, 13 Jul 2023 18:35:30 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rqj4rrrk1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 18:35:29 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36DIZT6w30933756
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jul 2023 18:35:29 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF4C35805C;
 Thu, 13 Jul 2023 18:35:28 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D37C5805A;
 Thu, 13 Jul 2023 18:35:28 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Jul 2023 18:35:28 +0000 (GMT)
Message-ID: <ed67cdd1-3987-7432-960e-36ce59face96@linux.ibm.com>
Date: Thu, 13 Jul 2023 14:35:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 05/11] tpm_crb: use the ISA bus
Content-Language: en-US
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20230713035232.48406-1-j@getutm.app>
 <20230713035232.48406-6-j@getutm.app>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230713035232.48406-6-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: weiWVTfClIl_qY38GIxrH484CptuYvOn
X-Proofpoint-ORIG-GUID: wQRqB8UMpiQWYrRmXpT7x9EijElnvvYZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130165
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
> Since this device is gated to only build for targets with the PC
> configuration, we should use the ISA bus like with TPM TIS.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>

I think this patch is good but I'd like to try it with resuming and old VM snapshot and for this to work we need 04/11 to have the registers in the VM state.


    Stefan
> ---
>   hw/tpm/tpm_crb.c | 52 ++++++++++++++++++++++++------------------------
>   hw/tpm/Kconfig   |  2 +-
>   2 files changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 07c6868d8d..6144081d30 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -22,6 +22,7 @@
>   #include "hw/qdev-properties.h"
>   #include "hw/pci/pci_ids.h"
>   #include "hw/acpi/tpm.h"
> +#include "hw/isa/isa.h"
>   #include "migration/vmstate.h"
>   #include "sysemu/tpm_backend.h"
>   #include "sysemu/tpm_util.h"
> @@ -34,7 +35,7 @@
>   #include "tpm_crb.h"
> 
>   struct CRBState {
> -    DeviceState parent_obj;
> +    ISADevice parent_obj;
> 
>       TPMCRBState state;
>   };
> @@ -43,49 +44,49 @@ typedef struct CRBState CRBState;
>   DECLARE_INSTANCE_CHECKER(CRBState, CRB,
>                            TYPE_TPM_CRB)
> 
> -static void tpm_crb_none_request_completed(TPMIf *ti, int ret)
> +static void tpm_crb_isa_request_completed(TPMIf *ti, int ret)
>   {
>       CRBState *s = CRB(ti);
> 
>       tpm_crb_request_completed(&s->state, ret);
>   }
> 
> -static enum TPMVersion tpm_crb_none_get_version(TPMIf *ti)
> +static enum TPMVersion tpm_crb_isa_get_version(TPMIf *ti)
>   {
>       CRBState *s = CRB(ti);
> 
>       return tpm_crb_get_version(&s->state);
>   }
> 
> -static int tpm_crb_none_pre_save(void *opaque)
> +static int tpm_crb_isa_pre_save(void *opaque)
>   {
>       CRBState *s = opaque;
> 
>       return tpm_crb_pre_save(&s->state);
>   }
> 
> -static const VMStateDescription vmstate_tpm_crb_none = {
> +static const VMStateDescription vmstate_tpm_crb_isa = {
>       .name = "tpm-crb",
> -    .pre_save = tpm_crb_none_pre_save,
> +    .pre_save = tpm_crb_isa_pre_save,
>       .fields = (VMStateField[]) {
>           VMSTATE_END_OF_LIST(),
>       }
>   };
> 
> -static Property tpm_crb_none_properties[] = {
> +static Property tpm_crb_isa_properties[] = {
>       DEFINE_PROP_TPMBE("tpmdev", CRBState, state.tpmbe),
>       DEFINE_PROP_BOOL("ppi", CRBState, state.ppi_enabled, true),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> 
> -static void tpm_crb_none_reset(void *dev)
> +static void tpm_crb_isa_reset(void *dev)
>   {
>       CRBState *s = CRB(dev);
> 
>       return tpm_crb_reset(&s->state, TPM_CRB_ADDR_BASE);
>   }
> 
> -static void tpm_crb_none_realize(DeviceState *dev, Error **errp)
> +static void tpm_crb_isa_realize(DeviceState *dev, Error **errp)
>   {
>       CRBState *s = CRB(dev);
> 
> @@ -100,52 +101,51 @@ static void tpm_crb_none_realize(DeviceState *dev, Error **errp)
> 
>       tpm_crb_init_memory(OBJECT(s), &s->state, errp);
> 
> -    memory_region_add_subregion(get_system_memory(),
> +    memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
>           TPM_CRB_ADDR_BASE, &s->state.mmio);
> 
>       if (s->state.ppi_enabled) {
> -        memory_region_add_subregion(get_system_memory(),
> +        memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
>               TPM_PPI_ADDR_BASE, &s->state.ppi.ram);
>       }
> 
>       if (xen_enabled()) {
> -        tpm_crb_none_reset(dev);
> +        tpm_crb_isa_reset(dev);
>       } else {
> -        qemu_register_reset(tpm_crb_none_reset, dev);
> +        qemu_register_reset(tpm_crb_isa_reset, dev);
>       }
>   }
> 
> -static void tpm_crb_none_class_init(ObjectClass *klass, void *data)
> +static void tpm_crb_isa_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       TPMIfClass *tc = TPM_IF_CLASS(klass);
> 
> -    dc->realize = tpm_crb_none_realize;
> -    device_class_set_props(dc, tpm_crb_none_properties);
> -    dc->vmsd  = &vmstate_tpm_crb_none;
> +    dc->realize = tpm_crb_isa_realize;
> +    device_class_set_props(dc, tpm_crb_isa_properties);
> +    dc->vmsd  = &vmstate_tpm_crb_isa;
>       dc->user_creatable = true;
>       tc->model = TPM_MODEL_TPM_CRB;
> -    tc->get_version = tpm_crb_none_get_version;
> -    tc->request_completed = tpm_crb_none_request_completed;
> +    tc->get_version = tpm_crb_isa_get_version;
> +    tc->request_completed = tpm_crb_isa_request_completed;
> 
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>   }
> 
> -static const TypeInfo tpm_crb_none_info = {
> +static const TypeInfo tpm_crb_isa_info = {
>       .name = TYPE_TPM_CRB,
> -    /* could be TYPE_SYS_BUS_DEVICE (or LPC etc) */
> -    .parent = TYPE_DEVICE,
> +    .parent = TYPE_ISA_DEVICE,
>       .instance_size = sizeof(CRBState),
> -    .class_init  = tpm_crb_none_class_init,
> +    .class_init  = tpm_crb_isa_class_init,
>       .interfaces = (InterfaceInfo[]) {
>           { TYPE_TPM_IF },
>           { }
>       }
>   };
> 
> -static void tpm_crb_none_register(void)
> +static void tpm_crb_isa_register(void)
>   {
> -    type_register_static(&tpm_crb_none_info);
> +    type_register_static(&tpm_crb_isa_info);
>   }
> 
> -type_init(tpm_crb_none_register)
> +type_init(tpm_crb_isa_register)
> diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
> index a46663288c..1fd73fe617 100644
> --- a/hw/tpm/Kconfig
> +++ b/hw/tpm/Kconfig
> @@ -22,7 +22,7 @@ config TPM_TIS
> 
>   config TPM_CRB
>       bool
> -    depends on TPM && PC
> +    depends on TPM && ISA_BUS
>       select TPM_BACKEND
> 
>   config TPM_SPAPR

