Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1382B822CA5
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 13:06:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL003-00077Y-No; Wed, 03 Jan 2024 07:05:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowsjois@linux.vnet.ibm.com>)
 id 1rL001-00076m-8K; Wed, 03 Jan 2024 07:05:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowsjois@linux.vnet.ibm.com>)
 id 1rKzzy-0000PJ-9H; Wed, 03 Jan 2024 07:05:29 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 4039mOvV013602; Wed, 3 Jan 2024 12:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=8EPlNQJ7KtRTSLAwJfLjK8XWGb9b6ixO66Q5MLQE464=;
 b=KaoKVZtdta6KWCXvuXsiQtFgcJcPCMILxzX4uWFrF+jKWodEv4Kl6c4ktn1qJPnYcVWJ
 GiDYuDny8RQYnduTFcKFvckj0ZplDqJs36bkVSugMhzPzLzxu1KI2DGbrpVCNu/mqd9m
 26GOeh1ayhQYjHh10ntoDEUaarTaoOIRBkyT37HCvMXg6RPn2YhnOP5bEXkCxtZ1NdEr
 uF6t0jMfXEe8uvxTsgUUFjH9HsLXJse8tvlivs0dtOwZO1kHg958oHYO2HeB4Oy2JuBE
 8rPiIyZFlpNYyUvrRGWAIi1QkdRX0R9PzupDjaGg1bNk160jXJ/uiq+6npn70eMwXGoC +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vd591w22h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Jan 2024 12:05:10 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 403BLoVO014121;
 Wed, 3 Jan 2024 12:05:10 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vd591w21w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Jan 2024 12:05:09 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 403B0e0g019424; Wed, 3 Jan 2024 12:05:09 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vc30shwvc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Jan 2024 12:05:09 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 403C577l23397118
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 3 Jan 2024 12:05:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1401B20043;
 Wed,  3 Jan 2024 12:05:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3294320040;
 Wed,  3 Jan 2024 12:05:05 +0000 (GMT)
Received: from [9.43.62.72] (unknown [9.43.62.72])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  3 Jan 2024 12:05:04 +0000 (GMT)
Message-ID: <449ae601-e7df-4c26-aad7-aca8bf79400f@linux.vnet.ibm.com>
Date: Wed, 3 Jan 2024 17:35:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] ppc/spapr: Introduce SPAPR_IRQ_NR_IPIS to refer
 IRQ range for CPU IPIs.
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, npiggin@gmail.com,
 qemu-ppc@nongnu.org
Cc: danielhb413@gmail.com, david@gibson.dropbear.id.au, qemu-devel@nongnu.org
References: <20231123055733.1002890-1-harshpb@linux.ibm.com>
 <20231123055733.1002890-2-harshpb@linux.ibm.com>
 <1523c986-7022-4b3f-8e26-b25d8621c623@kaod.org>
 <3030ea29-3611-bd4f-cfd5-b34e4cf6b800@linux.ibm.com>
 <adb6e571-004c-4c28-94e7-efadd61d88c1@kaod.org>
 <7bda3fad-e4df-8e2b-bb8b-8f984d89fcff@linux.ibm.com>
 <9880236c-cc89-4a83-a377-e680d2ca7163@kaod.org>
From: Kowshik Jois B S <kowsjois@linux.vnet.ibm.com>
In-Reply-To: <9880236c-cc89-4a83-a377-e680d2ca7163@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oRH3sC4zI5WkSD_ELBpc-DLr5r5EiMCm
X-Proofpoint-GUID: 1etwjSUciVep4V9DSgjNLL-lMyMEzpcq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_06,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401030100
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=kowsjois@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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


On 24/11/23 13:39, Cédric Le Goater wrote:
> On 11/24/23 09:01, Harsh Prateek Bora wrote:
>>
>>
>> On 11/23/23 19:42, Cédric Le Goater wrote:
>>> On 11/23/23 10:31, Harsh Prateek Bora wrote:
>>>>
>>>>
>>>> On 11/23/23 14:20, CI've applied these patches and verified on the 
>>>> latest upstream qemu. The code is working as expected.
>>>>
>>>> Tested-by: Kowshik Jois<kowsjois@linux.ibm.com>édric Le Goater wrote:
>>>>> On 11/23/23 06:57, Harsh Prateek Bora wrote:
>>>>>> spapr_irq_init currently uses existing macro SPAPR_XIRQ_BASE to 
>>>>>> refer to
>>>>>> the range of CPU IPIs during initialization of nr-irqs property.
>>>>>> It is more appropriate to have its own define which can be further
>>>>>> reused as appropriate for correct interpretation.
>>>>>>
>>>>>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>>>>> Suggested-by: Cedric Le Goater <clg@kaod.org>
>>>>>
>>>>> One comment below
>>>>>
>>>>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>>>>>
>>>>
>>>> Thanks, responding below ..
>>>>
>>>>>> ---
>>>>>>   include/hw/ppc/spapr_irq.h | 14 +++++++++++++-
>>>>>>   hw/ppc/spapr_irq.c         |  6 ++++--
>>>>>>   2 files changed, 17 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
>>>>>> index c22a72c9e2..4fd2d5853d 100644
>>>>>> --- a/include/hw/ppc/spapr_irq.h
>>>>>> +++ b/include/hw/ppc/spapr_irq.h
>>>>>> @@ -14,9 +14,21 @@
>>>>>>   #include "qom/object.h"
>>>>>>   /*
>>>>>> - * IRQ range offsets per device type
>>>>>> + * The XIVE IRQ backend uses the same layout as the XICS backend 
>>>>>> but
>>>>>> + * covers the full range of the IRQ number space. The IRQ 
>>>>>> numbers for
>>>>>> + * the CPU IPIs are allocated at the bottom of this space, below 
>>>>>> 4K,
>>>>>> + * to preserve compatibility with XICS which does not use that 
>>>>>> range.
>>>>>> + */
>>>>>> +
>>>>>> +/*
>>>>>> + * CPU IPI range (XIVE only)
>>>>>>    */
>>>>>>   #define SPAPR_IRQ_IPI        0x0
>>>>>> +#define SPAPR_IRQ_NR_IPIS    0x1000
>>>>>> +
>>>>>> +/*
>>>>>> + * IRQ range offsets per device type
>>>>>> + */
>>>>>>   #define SPAPR_XIRQ_BASE      XICS_IRQ_BASE /* 0x1000 */
>>>>>>   #define SPAPR_IRQ_EPOW       (SPAPR_XIRQ_BASE + 0x0000)
>>>>>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>>>>>> index a0d1e1298e..97b2fc42ab 100644
>>>>>> --- a/hw/ppc/spapr_irq.c
>>>>>> +++ b/hw/ppc/spapr_irq.c
>>>>>> @@ -23,6 +23,8 @@
>>>>>>   #include "trace.h"
>>>>>> +QEMU_BUILD_BUG_ON(SPAPR_IRQ_NR_IPIS > SPAPR_XIRQ_BASE);
>>>>>> +
>>>>>
>>>>> I would have put the check in include/hw/ppc/spapr_irq.h but since
>>>>> SPAPR_XIRQ_BASE is only used in hw/ppc/spapr_irq.c which is always
>>>>> compiled, this is fine. You might want to change that in case a
>>>>> respin is asked for.
>>>>>
>>>>
>>>> I had initially tried keeping it in spapr_irq.h , but that would 
>>>> give a build break for XICS_IRQ_BASE not defined since that gets 
>>>> defined in spapr_xics.h and is included later in some files, 
>>>> however, the QEMU_BUILD_BUG_ON expects it to be defined before it 
>>>> reaches here.
>>>
>>> ah. good catch. this went unnoticed and is a bit ugly. We should fix
>>> in some ways. May with a define SPAPR_XIRQ_BASE to 0x1000 simply ?
>>>
>>
>> Hmm, I can do that if a re-spin is reqd, or can be done as a separate
>> patch later also along with other improvements.
>
> yes. This is food for thoughts for further improvements.
>
> Thanks,
>
> C.
>
>
>
>>
>>> Also, we could probably define the ICS offset to SPAPR_XIRQ_BASE
>>> directly under spapr_irq_init() and get rid of ics_instance_init().
>>> The HW IRQ Number offset in the PNV ICS instances is assigned
>>> dynamically by the OS (see pnv_phb3). So it should befine to do
>>> the same for spapr. In which case we can get rid of XICS_IRQ_BASE.
>>>
>>
>> Hmm, I am not so familiar with XICS yet, so not sure if we really need
>> to do that, but it can be done along with other improvements if needed.
>>
>> regards,
>> Harsh
>>
>>> Thanks,
>>>
>>> C.
>>>
>>>
>>>
>>>>
>>>> regards,
>>>> Harsh
>>>>
>>>>> Thanks,
>>>>>
>>>>> C.
>>>>>
>>>>>
>>>>>>   static const TypeInfo spapr_intc_info = {
>>>>>>       .name = TYPE_SPAPR_INTC,
>>>>>>       .parent = TYPE_INTERFACE,
>>>>>> @@ -329,7 +331,7 @@ void spapr_irq_init(SpaprMachineState *spapr, 
>>>>>> Error **errp)
>>>>>>           int i;
>>>>>>           dev = qdev_new(TYPE_SPAPR_XIVE);
>>>>>> -        qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + 
>>>>>> SPAPR_XIRQ_BASE);
>>>>>> +        qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + 
>>>>>> SPAPR_IRQ_NR_IPIS);
>>>>>>           /*
>>>>>>            * 8 XIVE END structures per CPU. One for each available
>>>>>>            * priority
>>>>>> @@ -356,7 +358,7 @@ void spapr_irq_init(SpaprMachineState *spapr, 
>>>>>> Error **errp)
>>>>>>       }
>>>>>>       spapr->qirqs = qemu_allocate_irqs(spapr_set_irq, spapr,
>>>>>> -                                      smc->nr_xirqs + 
>>>>>> SPAPR_XIRQ_BASE);
>>>>>> +                                      smc->nr_xirqs + 
>>>>>> SPAPR_IRQ_NR_IPIS);
>>>>>>       /*
>>>>>>        * Mostly we don't actually need this until reset, except 
>>>>>> that not
>>>>>
>>>
>
> I've applied these patches and verified on the latest upstream qemu. 
> The code is working as expected.
>
> Tested-by: Kowshik Jois<kowsjois@linux.ibm.com>

