Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 630C67EB51B
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 17:45:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2wWX-0000rg-6v; Tue, 14 Nov 2023 11:44:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1r2wWU-0000rA-EQ
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:44:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1r2wWQ-00018C-Ph
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:44:21 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AEGRTih012228; Tue, 14 Nov 2023 16:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=PNb1xImrWjhwosCV4fbe3iaXZPYrg9HFDM4llERcMEk=;
 b=U8CC4LVPHVHIHPDNK4b2dliz1isHbYUHFjTuP9i3wwxVbj95XMVs9AcqQSengT3b8FWV
 Lmf6tNE14cNUHXVf4TK9Wucum2gfL4gQWmLPylj9TFz8sI+fyDCY35kv3GWVokfBAy9O
 Fgu8sgkt1fdzwLW2UvTgbOjgJrnJCCE2a6srof6K0XxSlpf20gW8ZGoBocNw4xqr6Ct5
 UQGqOX+2zAGcwKzn/ibY5NQs0y1C6Q5660ewAWj6jgUS+EMI/gri/t0ccxumLazN8x8p
 gdBFRl7fHs315rrj+N14UfDYMcZoZnZHv8+7iSjZ0jH+f0vSChqxmGjBPsS22bUPe9ty QA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucce78hba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Nov 2023 16:44:12 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AEGT6Nk019920;
 Tue, 14 Nov 2023 16:44:11 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucce78hay-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Nov 2023 16:44:11 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AEGXuqk022334; Tue, 14 Nov 2023 16:44:10 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uap5k0rcs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Nov 2023 16:44:10 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AEGiAH221496452
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Nov 2023 16:44:10 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B62158059;
 Tue, 14 Nov 2023 16:44:10 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2412B58043;
 Tue, 14 Nov 2023 16:44:09 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Nov 2023 16:44:09 +0000 (GMT)
Message-ID: <20340277-648c-4ebd-825b-20199ceafe64@linux.ibm.com>
Date: Tue, 14 Nov 2023 11:44:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/14] tpm_crb: move ACPI table building to device
 interface
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20231114020927.62315-1-j@getutm.app>
 <20231114020927.62315-6-j@getutm.app>
 <865e5b38-0e83-4522-8d3e-410ba2394173@linux.ibm.com>
In-Reply-To: <865e5b38-0e83-4522-8d3e-410ba2394173@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cmhqHFJ3tLlQIAfZvt85nEkxkiXqV5PV
X-Proofpoint-ORIG-GUID: _TqLEfzRsdqNNIFJpzkzH6uiJFAgmhJn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_16,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311140128
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 11/14/23 11:37, Stefan Berger wrote:
> 
> 
> On 11/13/23 21:09, Joelle van Dyne wrote:
>> This logic is similar to TPM TIS ISA device. Since TPM CRB can only
>> support TPM 2.0 backends, we check for this in realize.
>>
>> Signed-off-by: Joelle van Dyne <j@getutm.app>
>> ---
>>   hw/tpm/tpm_crb.h        |  2 ++
>>   hw/i386/acpi-build.c    | 16 +---------------
>>   hw/tpm/tpm_crb.c        | 16 ++++++++++++++++
>>   hw/tpm/tpm_crb_common.c | 19 +++++++++++++++++++
>>   4 files changed, 38 insertions(+), 15 deletions(-)
>>
>> diff --git a/hw/tpm/tpm_crb.h b/hw/tpm/tpm_crb.h
>> index 36863e1664..e6a86e3fd1 100644
>> --- a/hw/tpm/tpm_crb.h
>> +++ b/hw/tpm/tpm_crb.h
>> @@ -73,5 +73,7 @@ void tpm_crb_init_memory(Object *obj, TPMCRBState 
>> *s, Error **errp);
>>   void tpm_crb_mem_save(TPMCRBState *s, uint32_t *saved_regs, void 
>> *saved_cmdmem);
>>   void tpm_crb_mem_load(TPMCRBState *s, const uint32_t *saved_regs,
>>                         const void *saved_cmdmem);
>> +void tpm_crb_build_aml(TPMIf *ti, Aml *scope, uint32_t baseaddr, 
>> uint32_t size,
>> +                       bool build_ppi);
>>
>>   #endif /* TPM_TPM_CRB_H */
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 80db183b78..7491cee2af 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -1792,21 +1792,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>
>>   #ifdef CONFIG_TPM
>>       if (TPM_IS_CRB(tpm)) {
>> -        dev = aml_device("TPM");
>> -        aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
>> -        aml_append(dev, aml_name_decl("_STR",
>> -                                      aml_string("TPM 2.0 Device")));
>> -        crs = aml_resource_template();
>> -        aml_append(crs, aml_memory32_fixed(TPM_CRB_ADDR_BASE,
>> -                                           TPM_CRB_ADDR_SIZE, 
>> AML_READ_WRITE));
>> -        aml_append(dev, aml_name_decl("_CRS", crs));
>> -
>> -        aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
>> -        aml_append(dev, aml_name_decl("_UID", aml_int(1)));
>> -
>> -        tpm_build_ppi_acpi(tpm, dev);
>> -
>> -        aml_append(sb_scope, dev);
>> +        call_dev_aml_func(DEVICE(tpm), scope);
> 
> For an x86_64 VM we have to call it directly otherwise the ACPI table 
> won't be there.
> 
>          tpm_crb_build_aml(tpm, sb_scope, TPM_CRB_ADDR_BASE, 
> TPM_CRB_ADDR_SIZE, true);
> 
> 
I looks like a good place for the moved code would be in hw/acpi/tpm.c

