Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 831CA7E0319
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 13:44:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qytWc-0005Pf-04; Fri, 03 Nov 2023 08:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qytWV-0005PG-Rs
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 08:43:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qytWS-0005Fo-0g
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 08:43:39 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A3CeuLn023504; Fri, 3 Nov 2023 12:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=0DwUxkAIZ7n3YAqjtZ3vL78YodikpJr9XVJdWfFjePg=;
 b=tQOO7VryXpEP+3uAUouMsBPp/s8/6s7tWFKu9Yb1f9EkfJ5oVwv0ZO/PmRxhBTAA7Jes
 07zRQtw4X49shLRHwInr7A8JIA+XOFIO2nIuNcl0FR2KFSSXubFpuYPPO5mJlGFJsEU/
 za8abudeeF9g4/0OLBYM67Ee1hRXG7k0iPtAWyMEq2khtsuf95iMadkromaFLiTM3ZZC
 8dcHG9FuYAQqmBpNo3ilXky12TWFVkNKVOspkqF/IicMC6lp+QG3gS7b/SC5QRQjeyV0
 3YUYykkU8PtLPemIcTQVbHJ7WDf33+bea4jOr8EpYn56Z6Xh9l9emwUhuv4KvKd9UbFr Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u512x8277-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Nov 2023 12:43:27 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A3CfNNN025677;
 Fri, 3 Nov 2023 12:43:26 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u512x823w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Nov 2023 12:43:26 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A3ARs1e031403; Fri, 3 Nov 2023 12:43:19 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1fb2ndkg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Nov 2023 12:43:19 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A3ChJ4x13894264
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Nov 2023 12:43:19 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4184558043;
 Fri,  3 Nov 2023 12:43:19 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6351A5805D;
 Fri,  3 Nov 2023 12:43:18 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Fri,  3 Nov 2023 12:43:18 +0000 (GMT)
Message-ID: <1cf94fa2-bf6b-4817-ac1d-eb9a22793761@linux.ibm.com>
Date: Fri, 3 Nov 2023 08:43:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/14] tpm_crb: move ACPI table building to device
 interface
Content-Language: en-US
To: Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20231031040021.65582-1-j@getutm.app>
 <20231031040021.65582-6-j@getutm.app>
 <33cc4e46-c48c-4fd8-bcec-b57698598a0e@linux.ibm.com>
 <CA+E+eSACJs1oHPjqT4h7F32+y+HS_en45aVYSPKoUyAmoax11w@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CA+E+eSACJs1oHPjqT4h7F32+y+HS_en45aVYSPKoUyAmoax11w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1yKwNFLgdXSxvtfkwPxhAJoHl9ElSi7P
X-Proofpoint-ORIG-GUID: hcaVb82JulwFv7SqFo3Soj_F39o1zvUA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_12,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 malwarescore=0 impostorscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311030106
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 11/2/23 22:37, Joelle van Dyne wrote:
> On Thu, Nov 2, 2023 at 11:50 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>>
>>
>> On 10/31/23 00:00, Joelle van Dyne wrote:
>>> This logic is similar to TPM TIS ISA device. Since TPM CRB can only
>>> support TPM 2.0 backends, we check for this in realize.
>>
>> The problem on x86_64 is that the creation of the ACPI doesn't seem to
>> get invoked. The device then ends up not working under Linux. The
>> problem seems to be
>>
>> .parent = TYPE_DEVICE
>>
>> When I change this to TYPE_ISA_DEVICE it starts generating the ACPI
>> table. I am not sure what other side effects this may have, though.
> Ah sorry, this is probably a side effect of the patch I dropped where
> the bus was moved back from ISA to SysBus. The patch was dropped
> because people complained that the side effects of a new device
> appearing on the ISA bus during migration is unknown. That means we
> will probably have to add some logic to call the ACPI build methods on
> non-ISA devices.

If you moved tpm_crb_build_aml() into a common file like tpm_acpi.c as 
tpm_build_aml() it could be called from multiple drivers. For the x86_64 
driver I would just call this function from its old location then.


     Stefan

> 
>>
>>      Stefan
>>>
>>> Signed-off-by: Joelle van Dyne <j@getutm.app>
>>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>>> ---
>>>    hw/tpm/tpm_crb.h        |  2 ++
>>>    hw/i386/acpi-build.c    | 23 -----------------------
>>>    hw/tpm/tpm_crb.c        | 16 ++++++++++++++++
>>>    hw/tpm/tpm_crb_common.c | 19 +++++++++++++++++++
>>>    4 files changed, 37 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/hw/tpm/tpm_crb.h b/hw/tpm/tpm_crb.h
>>> index 36863e1664..e6a86e3fd1 100644
>>> --- a/hw/tpm/tpm_crb.h
>>> +++ b/hw/tpm/tpm_crb.h
>>> @@ -73,5 +73,7 @@ void tpm_crb_init_memory(Object *obj, TPMCRBState *s, Error **errp);
>>>    void tpm_crb_mem_save(TPMCRBState *s, uint32_t *saved_regs, void *saved_cmdmem);
>>>    void tpm_crb_mem_load(TPMCRBState *s, const uint32_t *saved_regs,
>>>                          const void *saved_cmdmem);
>>> +void tpm_crb_build_aml(TPMIf *ti, Aml *scope, uint32_t baseaddr, uint32_t size,
>>> +                       bool build_ppi);
>>>
>>>    #endif /* TPM_TPM_CRB_H */
>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>> index 80db183b78..ce3f7b2d91 100644
>>> --- a/hw/i386/acpi-build.c
>>> +++ b/hw/i386/acpi-build.c
>>> @@ -1441,9 +1441,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>>        uint32_t nr_mem = machine->ram_slots;
>>>        int root_bus_limit = 0xFF;
>>>        PCIBus *bus = NULL;
>>> -#ifdef CONFIG_TPM
>>> -    TPMIf *tpm = tpm_find();
>>> -#endif
>>>        bool cxl_present = false;
>>>        int i;
>>>        VMBusBridge *vmbus_bridge = vmbus_bridge_find();
>>> @@ -1790,26 +1787,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>>            }
>>>        }
>>>
>>> -#ifdef CONFIG_TPM
>>> -    if (TPM_IS_CRB(tpm)) {
>>> -        dev = aml_device("TPM");
>>> -        aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
>>> -        aml_append(dev, aml_name_decl("_STR",
>>> -                                      aml_string("TPM 2.0 Device")));
>>> -        crs = aml_resource_template();
>>> -        aml_append(crs, aml_memory32_fixed(TPM_CRB_ADDR_BASE,
>>> -                                           TPM_CRB_ADDR_SIZE, AML_READ_WRITE));
>>> -        aml_append(dev, aml_name_decl("_CRS", crs));
>>> -
>>> -        aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
>>> -        aml_append(dev, aml_name_decl("_UID", aml_int(1)));
>>> -
>>> -        tpm_build_ppi_acpi(tpm, dev);
>>> -
>>> -        aml_append(sb_scope, dev);
>>> -    }
>>> -#endif
>>> -
>>>        if (pcms->sgx_epc.size != 0) {
>>>            uint64_t epc_base = pcms->sgx_epc.base;
>>>            uint64_t epc_size = pcms->sgx_epc.size;
>>> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
>>> index 99c64dd72a..8d57295b15 100644
>>> --- a/hw/tpm/tpm_crb.c
>>> +++ b/hw/tpm/tpm_crb.c
>>> @@ -19,6 +19,8 @@
>>>    #include "qemu/module.h"
>>>    #include "qapi/error.h"
>>>    #include "exec/address-spaces.h"
>>> +#include "hw/acpi/acpi_aml_interface.h"
>>> +#include "hw/acpi/tpm.h"
>>>    #include "hw/qdev-properties.h"
>>>    #include "hw/pci/pci_ids.h"
>>>    #include "hw/acpi/tpm.h"
>>> @@ -121,6 +123,11 @@ static void tpm_crb_none_realize(DeviceState *dev, Error **errp)
>>>            return;
>>>        }
>>>
>>> +    if (tpm_crb_none_get_version(TPM_IF(s)) != TPM_VERSION_2_0) {
>>> +        error_setg(errp, "TPM CRB only supports TPM 2.0 backends");
>>> +        return;
>>> +    }
>>> +
>>>        tpm_crb_init_memory(OBJECT(s), &s->state, errp);
>>>
>>>        /* only used for migration */
>>> @@ -142,10 +149,17 @@ static void tpm_crb_none_realize(DeviceState *dev, Error **errp)
>>>        }
>>>    }
>>>
>>> +static void build_tpm_crb_none_aml(AcpiDevAmlIf *adev, Aml *scope)
>>> +{
>>> +    tpm_crb_build_aml(TPM_IF(adev), scope, TPM_CRB_ADDR_BASE, TPM_CRB_ADDR_SIZE,
>>> +                      true);
>>> +}
>>> +
>>>    static void tpm_crb_none_class_init(ObjectClass *klass, void *data)
>>>    {
>>>        DeviceClass *dc = DEVICE_CLASS(klass);
>>>        TPMIfClass *tc = TPM_IF_CLASS(klass);
>>> +    AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
>>>
>>>        dc->realize = tpm_crb_none_realize;
>>>        device_class_set_props(dc, tpm_crb_none_properties);
>>> @@ -154,6 +168,7 @@ static void tpm_crb_none_class_init(ObjectClass *klass, void *data)
>>>        tc->model = TPM_MODEL_TPM_CRB;
>>>        tc->get_version = tpm_crb_none_get_version;
>>>        tc->request_completed = tpm_crb_none_request_completed;
>>> +    adevc->build_dev_aml = build_tpm_crb_none_aml;
>>>
>>>        set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>>>    }
>>> @@ -166,6 +181,7 @@ static const TypeInfo tpm_crb_none_info = {
>>>        .class_init  = tpm_crb_none_class_init,
>>>        .interfaces = (InterfaceInfo[]) {
>>>            { TYPE_TPM_IF },
>>> +        { TYPE_ACPI_DEV_AML_IF },
>>>            { }
>>>        }
>>>    };
>>> diff --git a/hw/tpm/tpm_crb_common.c b/hw/tpm/tpm_crb_common.c
>>> index 605e8576e9..4fff0c6b59 100644
>>> --- a/hw/tpm/tpm_crb_common.c
>>> +++ b/hw/tpm/tpm_crb_common.c
>>> @@ -239,3 +239,22 @@ void tpm_crb_mem_load(TPMCRBState *s, const uint32_t *saved_regs,
>>>        memcpy(regs, saved_regs, TPM_CRB_R_MAX);
>>>        memcpy(&regs[R_CRB_DATA_BUFFER], saved_cmdmem, A_CRB_DATA_BUFFER);
>>>    }
>>> +
>>> +void tpm_crb_build_aml(TPMIf *ti, Aml *scope, uint32_t baseaddr, uint32_t size,
>>> +                       bool build_ppi)
>>> +{
>>> +    Aml *dev, *crs;
>>> +
>>> +    dev = aml_device("TPM");
>>> +    aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
>>> +    aml_append(dev, aml_name_decl("_STR", aml_string("TPM 2.0 Device")));
>>> +    aml_append(dev, aml_name_decl("_UID", aml_int(1)));
>>> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
>>> +    crs = aml_resource_template();
>>> +    aml_append(crs, aml_memory32_fixed(baseaddr, size, AML_READ_WRITE));
>>> +    aml_append(dev, aml_name_decl("_CRS", crs));
>>> +    if (build_ppi) {
>>> +        tpm_build_ppi_acpi(ti, dev);
>>> +    }
>>> +    aml_append(scope, dev);
>>> +}

