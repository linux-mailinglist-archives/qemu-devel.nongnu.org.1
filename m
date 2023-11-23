Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5D57F579B
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 06:05:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r61u3-00073X-UG; Thu, 23 Nov 2023 00:05:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1r61u0-0006z9-NV; Thu, 23 Nov 2023 00:05:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1r61tu-00012O-Kr; Thu, 23 Nov 2023 00:05:20 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AN3QjP7011694; Thu, 23 Nov 2023 05:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=KST9wMZrhbey4XY3atyffIt5jJqZmwz0Zx/ZiS52Sfg=;
 b=Q6hhtWK2K7rlAOgz4MLBRX1go5WoIbLFzbjQrmKG7blOJ1fVTKMgNYLpyoqsIs+bj/9/
 VWwEEpNoqvRar1Kx6S8mLHJ2lE5b7Ya4K7YPir7houExcXtNarRPwEU5U0XEsZl1S+ck
 vLF2yhqK6/EsOkQV/uXvAolegW9WaE2Pwbr3BHXnVMiUa1GiONk+oo59O92mCOMQm8Kq
 1ZtybFaBwRCETWcuVIlOsV8knaR94EHMgi3WR06dWI84cqZehrlhKVVwRrYfnVekUKAE
 uUACm0vbTV7CTiC2CE/vNUtMIoFs2y1pY3lRm1e8VUx1LbcQXG3jGlEgvLyMPApCYp5p eQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhwf53954-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Nov 2023 05:05:02 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AN3gg4M015454;
 Thu, 23 Nov 2023 05:05:02 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhwf5394y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Nov 2023 05:05:02 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AN44MGb002225; Thu, 23 Nov 2023 05:05:01 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf9tkmp2r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Nov 2023 05:05:01 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AN5519713238882
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Nov 2023 05:05:01 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE2045805B;
 Thu, 23 Nov 2023 05:05:00 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 64B5E58059;
 Thu, 23 Nov 2023 05:04:58 +0000 (GMT)
Received: from [9.109.242.129] (unknown [9.109.242.129])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Nov 2023 05:04:58 +0000 (GMT)
Message-ID: <cad94a14-c58b-ee9b-9293-cc8d04249de5@linux.ibm.com>
Date: Thu, 23 Nov 2023 10:34:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/2] ppc/spapr: Introduce SPAPR_NR_IPIS to refer IRQ
 range for CPU IPIs.
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, npiggin@gmail.com,
 qemu-ppc@nongnu.org
Cc: danielhb413@gmail.com, david@gibson.dropbear.id.au, qemu-devel@nongnu.org
References: <20231122092845.973949-1-harshpb@linux.ibm.com>
 <20231122092845.973949-2-harshpb@linux.ibm.com>
 <cfcbfcd0-8d46-4360-badd-ec44de587c34@kaod.org>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <cfcbfcd0-8d46-4360-badd-ec44de587c34@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lavIby-nI-ZOgwUHcCgtjZ9OMJX2Nwb7
X-Proofpoint-ORIG-GUID: ZhrQOBWTbMeC5cKA9zw0n0hPLv3xVRRw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_02,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 mlxscore=0 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311230034
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 11/22/23 17:01, Cédric Le Goater wrote:
> Hello Harsh,
> 
> Please add to your .git/config file:
> 
> [diff]
>      orderFile = /path/to/qemu/scripts/git.orderfile
> 

Sure, thanks for the suggestion.

> 
> On 11/22/23 10:28, Harsh Prateek Bora wrote:
>> spapr_irq_init currently uses existing macro SPAPR_XIRQ_BASE to refer to
>> the range of CPU IPIs during initialization of nr-irqs property.
>> It is more appropriate to have its own define which can be further
>> reused as appropriate for correct interpretation.
>>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> Suggested-by: Cedric Le Goater <clg@kaod.org>
>> ---
>>   hw/ppc/spapr_irq.c         | 4 ++--
>>   include/hw/ppc/spapr_irq.h | 1 +
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>> index a0d1e1298e..0c5db6b161 100644
>> --- a/hw/ppc/spapr_irq.c
>> +++ b/hw/ppc/spapr_irq.c
>> @@ -329,7 +329,7 @@ void spapr_irq_init(SpaprMachineState *spapr, 
>> Error **errp)
>>           int i;
>>           dev = qdev_new(TYPE_SPAPR_XIVE);
>> -        qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + 
>> SPAPR_XIRQ_BASE);
>> +        qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + 
>> SPAPR_NR_IPIS);
> 
> SPAPR_IRQ_NR_IPIS ?
> 
>>           /*
>>            * 8 XIVE END structures per CPU. One for each available
>>            * priority
>> @@ -356,7 +356,7 @@ void spapr_irq_init(SpaprMachineState *spapr, 
>> Error **errp)
>>       }
>>       spapr->qirqs = qemu_allocate_irqs(spapr_set_irq, spapr,
>> -                                      smc->nr_xirqs + SPAPR_XIRQ_BASE);
>> +                                      smc->nr_xirqs + SPAPR_NR_IPIS);
>>       /*
>>        * Mostly we don't actually need this until reset, except that not
>> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
>> index c22a72c9e2..e7a80a8349 100644
>> --- a/include/hw/ppc/spapr_irq.h
>> +++ b/include/hw/ppc/spapr_irq.h
>> @@ -28,6 +28,7 @@
> 
> In include/hw/ppc/spapr_irq.h, we should describe the ranges a bit more.
> See commit dcc345b61ebe and ad8de98636e7 for more info. Something like :
> 
>    /*
>     * The XIVE IRQ backend uses the same layout as the XICS backend but
>     * covers the full range of the IRQ number space. The IRQ numbers for
>     * the CPU IPIs are allocated at the bottom of this space, below 4K,
>     * to preserve compatibility with XICS which does not use that range.
>     */
> 
>    /*
>     * CPU IPI range (XIVE only)
>     */
>    #define SPAPR_IRQ_IPI        0x0
>    #define SPAPR_IRQ_NR_IPIS    0x1000
> 
>    /*
>     * IRQ range offsets per device type
>     */
>    #define SPAPR_XIRQ_BASE      XICS_IRQ_BASE /* 0x1000 */
> 
> 
> And to make sure the ranges don't overlap, let's add :
> 
>    QEMU_BUILD_BUG_ON(SPAPR_IRQ_NR_IPIS > SPAPR_XIRQ_BASE)
> 

Yeh, this looks much better. Will update and post.

regards,
Harsh
> 
> Thanks,
> 
> C.
> 
> 

