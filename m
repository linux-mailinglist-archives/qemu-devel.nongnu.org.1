Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6997F5B19
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 10:32:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r664G-0001eT-AA; Thu, 23 Nov 2023 04:32:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1r664D-0001dR-Do; Thu, 23 Nov 2023 04:32:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1r664B-0000zG-Bt; Thu, 23 Nov 2023 04:32:13 -0500
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AN9GJmU001614; Thu, 23 Nov 2023 09:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Ww/qibgS+X6Z8LJwDGpEJ97jlho1uU0FgjAE3GNGscE=;
 b=lMJ2A5rKL+m5lS4DmR61PjN5vV7FyZnXr38hxMclWlWvYf6jc2ei8EHirmTZvLgQM9UJ
 N64PEGDQsM4Lfg3JEn4Mz0y1pBFkhaGHi+hzLt1HgSIOq2tGlWNRSnX0g7/pu5XYohK8
 JaGJdyKAGyY3UGs53MudfWR2h/tjc5CFzZiqyZhFkOaZwNzCvpZ7680MoK53uqiuhpCt
 xOl3ZAYOp32sLCxNf/W1VQ6/D4+20MSrna6LXHYbPdbD7P/HQ2aQ+L5FTLMsl1zbMA+4
 QBg0xm+4CrLwj3W+ysfTYS8C/a8dq0Lr+6yAtq2KRZXsqh05UB0/VbW9+6r08QlZrVgr Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uj2qpt995-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Nov 2023 09:31:54 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AN9HDaa005673;
 Thu, 23 Nov 2023 09:31:53 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uj2qpt98e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Nov 2023 09:31:53 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AN8nG4A021112; Thu, 23 Nov 2023 09:31:52 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf8kp68j3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Nov 2023 09:31:52 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AN9Vpt623069326
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Nov 2023 09:31:52 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD61958059;
 Thu, 23 Nov 2023 09:31:51 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0EE25805C;
 Thu, 23 Nov 2023 09:31:49 +0000 (GMT)
Received: from [9.109.242.129] (unknown [9.109.242.129])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Nov 2023 09:31:49 +0000 (GMT)
Message-ID: <3030ea29-3611-bd4f-cfd5-b34e4cf6b800@linux.ibm.com>
Date: Thu, 23 Nov 2023 15:01:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/2] ppc/spapr: Introduce SPAPR_IRQ_NR_IPIS to refer
 IRQ range for CPU IPIs.
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, npiggin@gmail.com,
 qemu-ppc@nongnu.org
Cc: danielhb413@gmail.com, david@gibson.dropbear.id.au, qemu-devel@nongnu.org
References: <20231123055733.1002890-1-harshpb@linux.ibm.com>
 <20231123055733.1002890-2-harshpb@linux.ibm.com>
 <1523c986-7022-4b3f-8e26-b25d8621c623@kaod.org>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <1523c986-7022-4b3f-8e26-b25d8621c623@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aLFh4RUyhw7FY7yCgQrGVa9uVVsAO1ju
X-Proofpoint-ORIG-GUID: Ks3n0HZqLalq6vAD6hWMv-kLjDz-AZKA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_07,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0
 impostorscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311230068
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.672,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 11/23/23 14:20, Cédric Le Goater wrote:
> On 11/23/23 06:57, Harsh Prateek Bora wrote:
>> spapr_irq_init currently uses existing macro SPAPR_XIRQ_BASE to refer to
>> the range of CPU IPIs during initialization of nr-irqs property.
>> It is more appropriate to have its own define which can be further
>> reused as appropriate for correct interpretation.
>>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> Suggested-by: Cedric Le Goater <clg@kaod.org>
> 
> One comment below
> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> 

Thanks, responding below ..

>> ---
>>   include/hw/ppc/spapr_irq.h | 14 +++++++++++++-
>>   hw/ppc/spapr_irq.c         |  6 ++++--
>>   2 files changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
>> index c22a72c9e2..4fd2d5853d 100644
>> --- a/include/hw/ppc/spapr_irq.h
>> +++ b/include/hw/ppc/spapr_irq.h
>> @@ -14,9 +14,21 @@
>>   #include "qom/object.h"
>>   /*
>> - * IRQ range offsets per device type
>> + * The XIVE IRQ backend uses the same layout as the XICS backend but
>> + * covers the full range of the IRQ number space. The IRQ numbers for
>> + * the CPU IPIs are allocated at the bottom of this space, below 4K,
>> + * to preserve compatibility with XICS which does not use that range.
>> + */
>> +
>> +/*
>> + * CPU IPI range (XIVE only)
>>    */
>>   #define SPAPR_IRQ_IPI        0x0
>> +#define SPAPR_IRQ_NR_IPIS    0x1000
>> +
>> +/*
>> + * IRQ range offsets per device type
>> + */
>>   #define SPAPR_XIRQ_BASE      XICS_IRQ_BASE /* 0x1000 */
>>   #define SPAPR_IRQ_EPOW       (SPAPR_XIRQ_BASE + 0x0000)
>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>> index a0d1e1298e..97b2fc42ab 100644
>> --- a/hw/ppc/spapr_irq.c
>> +++ b/hw/ppc/spapr_irq.c
>> @@ -23,6 +23,8 @@
>>   #include "trace.h"
>> +QEMU_BUILD_BUG_ON(SPAPR_IRQ_NR_IPIS > SPAPR_XIRQ_BASE);
>> +
> 
> I would have put the check in include/hw/ppc/spapr_irq.h but since
> SPAPR_XIRQ_BASE is only used in hw/ppc/spapr_irq.c which is always
> compiled, this is fine. You might want to change that in case a
> respin is asked for.
> 

I had initially tried keeping it in spapr_irq.h , but that would give a 
build break for XICS_IRQ_BASE not defined since that gets defined in 
spapr_xics.h and is included later in some files, however, the 
QEMU_BUILD_BUG_ON expects it to be defined before it reaches here.

regards,
Harsh

> Thanks,
> 
> C.
> 
> 
>>   static const TypeInfo spapr_intc_info = {
>>       .name = TYPE_SPAPR_INTC,
>>       .parent = TYPE_INTERFACE,
>> @@ -329,7 +331,7 @@ void spapr_irq_init(SpaprMachineState *spapr, 
>> Error **errp)
>>           int i;
>>           dev = qdev_new(TYPE_SPAPR_XIVE);
>> -        qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + 
>> SPAPR_XIRQ_BASE);
>> +        qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + 
>> SPAPR_IRQ_NR_IPIS);
>>           /*
>>            * 8 XIVE END structures per CPU. One for each available
>>            * priority
>> @@ -356,7 +358,7 @@ void spapr_irq_init(SpaprMachineState *spapr, 
>> Error **errp)
>>       }
>>       spapr->qirqs = qemu_allocate_irqs(spapr_set_irq, spapr,
>> -                                      smc->nr_xirqs + SPAPR_XIRQ_BASE);
>> +                                      smc->nr_xirqs + 
>> SPAPR_IRQ_NR_IPIS);
>>       /*
>>        * Mostly we don't actually need this until reset, except that not
> 

