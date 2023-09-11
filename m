Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B16479A465
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 09:26:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfbHi-0000IS-Gq; Mon, 11 Sep 2023 03:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qfbHg-0000IF-7V; Mon, 11 Sep 2023 03:24:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qfbHd-0003Iu-It; Mon, 11 Sep 2023 03:24:35 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38B77Nh2027626; Mon, 11 Sep 2023 07:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xvlT3mDYqCuEJLjKt6I10wMKw8V7LA0khb21RPBgBg8=;
 b=PJh2ImpfqWl9oIcdL9RyVRIeExFm0a9cArvywh91MeDtwgzafCfVgnIZmkJ3z9XtR1MU
 UKyONNtjBNUEvDsPtaVyW0YV/2khqx1ziD9nf8nNfUFOa38JY4OrCpk/hfRrIzz3LuQL
 bxWte1a36rclCJKtH9+J+jN1yPTBBgoLiKZLq9sxF05BSmZT+69eJCKcYaYvapalCQfM
 V4urcaACmq3vNAqTncY8aUYbOovEUGUFINeMjSr86l1uP+9wvZ6x1c8N5yjHtV99QNO7
 Nob9GPPJ1jwYcvAMojRhye0h/+Iym3yCm/+gj67s5iAugeW94E/uXUh/bD605B2uA+/R zw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t1v8a39xv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 07:24:28 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38B78Bwk001688;
 Mon, 11 Sep 2023 07:24:28 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t1v8a39xs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 07:24:28 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38B5O9XX002724; Mon, 11 Sep 2023 07:24:27 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t14hkgj01-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 07:24:27 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38B7OQKL24511106
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Sep 2023 07:24:26 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9884358061;
 Mon, 11 Sep 2023 07:24:26 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD4E95803F;
 Mon, 11 Sep 2023 07:24:21 +0000 (GMT)
Received: from [9.195.37.167] (unknown [9.195.37.167])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 11 Sep 2023 07:24:21 +0000 (GMT)
Message-ID: <8c06ebdc-0649-1a96-4185-4654ba4d22eb@linux.ibm.com>
Date: Mon, 11 Sep 2023 12:54:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RESEND 03/15] ppc: spapr: Use SpaprMachineStateNested's
 ptcr instead of nested_ptcr
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, danielhb413@gmail.com,
 qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, mikey@neuling.org, vaibhav@linux.ibm.com,
 jniethe5@gmail.com, sbhat@linux.ibm.com, kconsul@linux.vnet.ibm.com
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
 <20230906043333.448244-4-harshpb@linux.ibm.com>
 <CVCAC1ITW1TA.1L7Q46DV3IHKA@wheely>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CVCAC1ITW1TA.1L7Q46DV3IHKA@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vOI0ecDUchFZla8TAwwQGzoFebVBYsMq
X-Proofpoint-GUID: NQXvWmjp2NhAT7ZYWQdujM5YancP6W5o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_04,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 mlxlogscore=936 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110064
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 9/7/23 06:43, Nicholas Piggin wrote:
> On Wed Sep 6, 2023 at 2:33 PM AEST, Harsh Prateek Bora wrote:
>> Use nested guest state specific struct for storing related info.
> 
> So this is the patch I would introduce the SpaprMachineStateNested
> struct, with just the .ptrc member. Add other members to it as they
> are used in later patches.

Sure, will do.

> 
>>
>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>>   hw/ppc/spapr.c         | 4 ++--
>>   hw/ppc/spapr_nested.c  | 4 ++--
>>   include/hw/ppc/spapr.h | 3 ++-
>>   3 files changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 07e91e3800..e44686b04d 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1340,8 +1340,8 @@ static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
>>   
>>           assert(lpid != 0);
>>   
>> -        patb = spapr->nested_ptcr & PTCR_PATB;
>> -        pats = spapr->nested_ptcr & PTCR_PATS;
>> +        patb = spapr->nested.ptcr & PTCR_PATB;
>> +        pats = spapr->nested.ptcr & PTCR_PATS;
>>   
>>           /* Check if partition table is properly aligned */
>>           if (patb & MAKE_64BIT_MASK(0, pats + 12)) {
> 
> At this point I wonder if we should first move the nested part of
> spapr_get_pate into nested code. It's a bit of a wart to have it
> here when most of the other nested cases are abstracted from non
> nested code quite well.

Yeh, I also felt similar when modifying the existing nested code here.
Let me do the needful in next version.

> 
>> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
>> index 121aa96ddc..a669470f1a 100644
>> --- a/hw/ppc/spapr_nested.c
>> +++ b/hw/ppc/spapr_nested.c
>> @@ -25,7 +25,7 @@ static target_ulong h_set_ptbl(PowerPCCPU *cpu,
>>           return H_PARAMETER;
>>       }
>>   
>> -    spapr->nested_ptcr = ptcr; /* Save new partition table */
>> +    spapr->nested.ptcr = ptcr; /* Save new partition table */
>>   
>>       return H_SUCCESS;
>>   }
>> @@ -157,7 +157,7 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
>>       struct kvmppc_pt_regs *regs;
>>       hwaddr len;
>>   
>> -    if (spapr->nested_ptcr == 0) {
>> +    if (spapr->nested.ptcr == 0) {
>>           return H_NOT_AVAILABLE;
>>       }
>>   
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 3990fed1d9..c8b42af430 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -12,6 +12,7 @@
>>   #include "hw/ppc/spapr_xive.h"  /* For SpaprXive */
>>   #include "hw/ppc/xics.h"        /* For ICSState */
>>   #include "hw/ppc/spapr_tpm_proxy.h"
>> +#include "hw/ppc/spapr_nested.h" /* for SpaprMachineStateNested */
>>   
>>   struct SpaprVioBus;
>>   struct SpaprPhbState;
>> @@ -216,7 +217,7 @@ struct SpaprMachineState {
>>       uint32_t vsmt;       /* Virtual SMT mode (KVM's "core stride") */
>>   
>>       /* Nested HV support (TCG only) */
>> -    uint64_t nested_ptcr;
>> +    struct SpaprMachineStateNested nested;
> 
> I think convention says to use the typedef for these?

Sure, will update. Thanks.

regards,
Harsh

> 
> Thanks,
> Nick
> 
>>   
>>       Notifier epow_notifier;
>>       QTAILQ_HEAD(, SpaprEventLogEntry) pending_events;
> 

