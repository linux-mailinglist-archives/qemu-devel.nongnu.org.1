Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A508D7B6028
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 07:00:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnXWB-0008LW-MK; Tue, 03 Oct 2023 01:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qnXW2-0008LF-7x; Tue, 03 Oct 2023 01:00:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qnXVz-0000sm-Nz; Tue, 03 Oct 2023 01:00:13 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3934pmB2030637; Tue, 3 Oct 2023 05:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=bIpmgcDwPln0Mjs8d9B9DVaVFE9PtCZ2e5x+RKjwlkM=;
 b=RNjpq7igE3E+MLtc2oE6SCDqf6M2KuCYGbaYQZUDzvyLVNE6vvZ5KHN4ElBuMMRiCNzF
 X7CesTymJecPqEdlDB6aQs+Ggu3e1An5eP8tMbSXXio6Sa0+AK/CyWRWf7uj9WAAeC/p
 cu8Bth7WtUYOXPYEY5iJq7UcPPK92YyO93S/lcy+r0FQPrxJ3VKYrMaK1ADjNr/WACE9
 rblvtFPvkrm9CCEO4kQCuWE1hkIIF4L0iLDuUBHfr4QkzqyiJOEge1LD5hCbcGxeJfuW
 sbIRzlHxJMgo5PyzVDGmCw01BO2x00vj2YwuYjImVrG92E0DsyHSQeGACsRLvWO+qakk 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tgca6g4cr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Oct 2023 05:00:03 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3934riXE002354;
 Tue, 3 Oct 2023 05:00:02 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tgca6g4bs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Oct 2023 05:00:02 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3932uADX007444; Tue, 3 Oct 2023 05:00:01 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3teygk6r6p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Oct 2023 05:00:01 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 393500U439256716
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Oct 2023 05:00:00 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 774B358075;
 Tue,  3 Oct 2023 05:00:00 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6011A58057;
 Tue,  3 Oct 2023 04:59:57 +0000 (GMT)
Received: from [9.109.242.129] (unknown [9.109.242.129])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  3 Oct 2023 04:59:57 +0000 (GMT)
Message-ID: <dd2bbd48-e017-56d3-cc08-f6332f1029e2@linux.ibm.com>
Date: Tue, 3 Oct 2023 10:29:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RESEND 07/15] ppc: spapr: Implement nested PAPR hcall -
 H_GUEST_SET_CAPABILITIES
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, danielhb413@gmail.com,
 qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, mikey@neuling.org, vaibhav@linux.ibm.com,
 jniethe5@gmail.com, sbhat@linux.ibm.com, kconsul@linux.vnet.ibm.com
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
 <20230906043333.448244-8-harshpb@linux.ibm.com>
 <CVCBILCCQQKB.2L31Z17STQ298@wheely>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CVCBILCCQQKB.2L31Z17STQ298@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: soHhyK-mJPz0Ef4hS-EYehLz26MSfhCP
X-Proofpoint-ORIG-GUID: o0svO8EuKs-bBOsHUr6lZVNnyaLsI7GQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030035
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.321,
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



On 9/7/23 07:39, Nicholas Piggin wrote:
> On Wed Sep 6, 2023 at 2:33 PM AEST, Harsh Prateek Bora wrote:
>> This patch implements nested PAPR hcall H_GUEST_SET_CAPABILITIES.
>> This is used by L1 to set capabilities of the nested guest being
>> created. The capabilities being set are subset of the capabilities
>> returned from the previous call to H_GUEST_GET_CAPABILITIES hcall.
>> Currently, it only supports P9/P10 capability check through PVR.
>>
>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>>   hw/ppc/spapr.c                |  1 +
>>   hw/ppc/spapr_nested.c         | 46 +++++++++++++++++++++++++++++++++++
>>   include/hw/ppc/spapr_nested.h |  3 +++
>>   3 files changed, 50 insertions(+)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index cbab7a825f..7c6f6ee25d 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -3443,6 +3443,7 @@ static void spapr_instance_init(Object *obj)
>>           "Host serial number to advertise in guest device tree");
>>       /* Nested */
>>       spapr->nested.api = 0;
>> +    spapr->nested.capabilities_set = false;
> 
> I would actually think about moving spapr->nested init into
> spapr_nested.c.
> 

Agree, moved.

>>   }
>>   
>>   static void spapr_machine_finalizefn(Object *obj)
>> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
>> index 37f3a49be2..9af65f257f 100644
>> --- a/hw/ppc/spapr_nested.c
>> +++ b/hw/ppc/spapr_nested.c
>> @@ -399,6 +399,51 @@ static target_ulong h_guest_get_capabilities(PowerPCCPU *cpu,
>>       return H_SUCCESS;
>>   }
>>   
>> +static target_ulong h_guest_set_capabilities(PowerPCCPU *cpu,
>> +                                             SpaprMachineState *spapr,
>> +                                             target_ulong opcode,
>> +                                              target_ulong *args)
>> +{
>> +    CPUPPCState *env = &cpu->env;
>> +    target_ulong flags = args[0];
>> +    target_ulong capabilities = args[1];
>> +
>> +    if (flags) { /* don't handle any flags capabilities for now */
>> +        return H_PARAMETER;
>> +    }
>> +
>> +
> 
> May need to do a pass over whitespace.
> 

Sure, done.

>> +    /* isn't supported */
>> +    if (capabilities & H_GUEST_CAPABILITIES_COPY_MEM) {
>> +        env->gpr[4] = 0;
>> +        return H_P2;
>> +    }
>> +
>> +    if ((env->spr[SPR_PVR] & CPU_POWERPC_POWER_SERVER_MASK) ==
>> +        (CPU_POWERPC_POWER9_BASE)) {
>> +        /* We are a P9 */
>> +        if (!(capabilities & H_GUEST_CAPABILITIES_P9_MODE)) {
>> +            env->gpr[4] = 1;
>> +            return H_P2;
>> +        }
>> +    }
>> +
>> +    if ((env->spr[SPR_PVR] & CPU_POWERPC_POWER_SERVER_MASK) ==
>> +        (CPU_POWERPC_POWER10_BASE)) {
>> +        /* We are a P10 */
> 
> The 2 comments above aren't helpful. Just remove them.
> 

Sure, done.

>> +        if (!(capabilities & H_GUEST_CAPABILITIES_P10_MODE)) {
>> +            env->gpr[4] = 2;
>> +            return H_P2;
>> +        }
>> +    }
>> +
>> +    spapr->nested.capabilities_set = true;
> 
> Is it okay to set twice? If not, add a check. If yes, remove
> capabilities_set until it's needed.
> 

Thanks for pointing it out, adding a check as appropriate.

Thanks
Harsh

>> +
>> +    spapr->nested.pvr_base = env->spr[SPR_PVR];
>> +
>> +    return H_SUCCESS;
>> +}
>> +
>>   void spapr_register_nested(void)
>>   {
>>       spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
>> @@ -410,6 +455,7 @@ void spapr_register_nested(void)
>>   void spapr_register_nested_phyp(void)
>>   {
>>       spapr_register_hypercall(H_GUEST_GET_CAPABILITIES, h_guest_get_capabilities);
>> +    spapr_register_hypercall(H_GUEST_SET_CAPABILITIES, h_guest_set_capabilities);
>>   }
>>   
>>   #else
>> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
>> index ce198e9f70..a7996251cb 100644
>> --- a/include/hw/ppc/spapr_nested.h
>> +++ b/include/hw/ppc/spapr_nested.h
>> @@ -193,6 +193,9 @@
>>   #define H_GUEST_CAPABILITIES_COPY_MEM 0x8000000000000000
>>   #define H_GUEST_CAPABILITIES_P9_MODE  0x4000000000000000
>>   #define H_GUEST_CAPABILITIES_P10_MODE 0x2000000000000000
>> +#define H_GUEST_CAP_COPY_MEM_BMAP   0
>> +#define H_GUEST_CAP_P9_MODE_BMAP    1
>> +#define H_GUEST_CAP_P10_MODE_BMAP   2
>>   
>>   typedef struct SpaprMachineStateNestedGuest {
>>       unsigned long vcpus;
> 

