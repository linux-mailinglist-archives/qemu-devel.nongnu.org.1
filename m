Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 651D779A5E3
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 10:20:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfc89-0001FV-Cc; Mon, 11 Sep 2023 04:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qfc82-0001Bw-T0; Mon, 11 Sep 2023 04:18:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qfc80-00055M-3d; Mon, 11 Sep 2023 04:18:42 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38B86RQK021028; Mon, 11 Sep 2023 08:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=BEPgIln/z/TP7uDEZJknUnNapic20/coxByZU/S/Uks=;
 b=RK0Y5J8ZEb3fGrzP9LATcErSxgM8E6zkVxvffwJUTUXC+ldDAjP9YIqJQ47oB4ND+sPN
 cRNj4fEIFlwqf5t3RHarJQesm+l6Z2XQr+Ibfq6xgazCtuzfJ6WHScwy2SkJpOvvY0J/
 SGJH52sLeX1AaeBbvmkrPWjYKSjilofg7EBtEe6X61O/1szGNPBji51uYChtc9J87KN7
 YXpNvahDplOarEigybPhyf9hyYcCx2Suu8NysoziFy7F7/lpw/Y/HakPNlFtt/Wg4jZ/
 U37/3TYtNwH2xWuKuB0fO/o1zahQz1OfzKSYaizst926tkp6MIvM7QKFcIlEcLghPLU+ Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t1ut1n4ag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 08:18:35 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38B86VNJ021353;
 Mon, 11 Sep 2023 08:18:35 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t1ut1n4a8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 08:18:35 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38B6Z3Pu011980; Mon, 11 Sep 2023 08:18:34 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t15r1gfpj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 08:18:34 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38B8IWuv36962686
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Sep 2023 08:18:33 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C1AB25805A;
 Mon, 11 Sep 2023 08:18:32 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5346A5803F;
 Mon, 11 Sep 2023 08:18:29 +0000 (GMT)
Received: from [9.195.37.167] (unknown [9.195.37.167])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 11 Sep 2023 08:18:28 +0000 (GMT)
Message-ID: <e9658fe7-dfb9-e94f-f18f-fb1c32a39807@linux.ibm.com>
Date: Mon, 11 Sep 2023 13:48:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RESEND 04/15] ppc: spapr: Start using nested.api for
 nested kvm-hv api
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, danielhb413@gmail.com,
 qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, mikey@neuling.org, vaibhav@linux.ibm.com,
 jniethe5@gmail.com, sbhat@linux.ibm.com, kconsul@linux.vnet.ibm.com
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
 <20230906043333.448244-5-harshpb@linux.ibm.com>
 <CVCASJDMEVOC.6N64CVK7Y0HL@wheely>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CVCASJDMEVOC.6N64CVK7Y0HL@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3rqA7kiPxRyCjPn5WyJJz0Nd2QZ6wrOO
X-Proofpoint-GUID: GlT-he3v6EaWH9mpziUtqYKSjPNn8V2T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_05,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110073
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 9/7/23 07:05, Nicholas Piggin wrote:
> On Wed Sep 6, 2023 at 2:33 PM AEST, Harsh Prateek Bora wrote:
>> With this patch, isolating kvm-hv nested api code to be executed only
>> when cap-nested-hv is set. This helps keeping api specific logic
>> mutually exclusive.
> 
> Changelog needs a bit of improvement. Emphasis on "why" for changelogs.
> If you take a changeset that makes a single logical change to the code,
> you should be able to understand why that is done. You could make some
> assumptions about the bigger series when it comes to details so don't
> have to explain from first principles. But if it's easy to explain why
> the high level, you could.
> 
> Why are we adding this fundamentally? So that the spapr nested code can
> be extended to support a second API.
> 
> This patch should add the api field to the struct, and also the
> NESTED_API_KVM_HV definition.

Sure, folding related changes (struct member, macros) into this patch
and updating changelog as suggested sounds more meaningful to me too.

regards,
Harsh

> 
> Thanks,
> Nick
> 
>>
>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>>   hw/ppc/spapr.c      | 7 ++++++-
>>   hw/ppc/spapr_caps.c | 1 +
>>   2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index e44686b04d..0aa9f21516 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1334,8 +1334,11 @@ static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
>>           /* Copy PATE1:GR into PATE0:HR */
>>           entry->dw0 = spapr->patb_entry & PATE0_HR;
>>           entry->dw1 = spapr->patb_entry;
>> +        return true;
>> +    }
>> +    assert(spapr->nested.api);
>>   
>> -    } else {
>> +    if (spapr->nested.api == NESTED_API_KVM_HV) {
>>           uint64_t patb, pats;
>>   
>>           assert(lpid != 0);
>> @@ -3437,6 +3440,8 @@ static void spapr_instance_init(Object *obj)
>>           spapr_get_host_serial, spapr_set_host_serial);
>>       object_property_set_description(obj, "host-serial",
>>           "Host serial number to advertise in guest device tree");
>> +    /* Nested */
>> +    spapr->nested.api = 0;
>>   }
>>   
>>   static void spapr_machine_finalizefn(Object *obj)
>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
>> index 5a0755d34f..a3a790b026 100644
>> --- a/hw/ppc/spapr_caps.c
>> +++ b/hw/ppc/spapr_caps.c
>> @@ -454,6 +454,7 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
>>           return;
>>       }
>>   
>> +    spapr->nested.api = NESTED_API_KVM_HV;
>>       if (kvm_enabled()) {
>>           if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0,
>>                                 spapr->max_compat_pvr)) {
> 

