Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1566B33EFE
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Aug 2025 14:11:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqW19-0005J5-SM; Mon, 25 Aug 2025 08:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uqW0i-0005Cb-AS; Mon, 25 Aug 2025 08:09:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uqW0d-00017w-MY; Mon, 25 Aug 2025 08:09:15 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P9ZdBk028350;
 Mon, 25 Aug 2025 12:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=rw7eT3
 AshK029dqpFM9hrqYXr0qM1eH/qu9eXx287+Q=; b=SwMRsxPlxPqLRc3JNgai79
 lncs9vcG9iRDKcbGkFvqU5y/54nmV4qKDcu4bfnHf+NbZm36z7YEH6Bnc4+ti/NG
 29RHifI0VpbfMszuW1Mqrpcnfp12BdCN+hQjqY6Wzur/cvF2D44euoi75B4hhhE9
 UQTCBdwlb0Wzp/HnHxyrLmmLHU03RTieiuWXv6p7AscQUXfNsyLlEUKkIh1+1eoV
 O3ez1NYKQH41T9xPGoFU8i7C0AzdkRGqH8lmvdLnOdFD6tvbtF7dYdOSScmG4HLs
 BhhZ9l+TUfzleiz2Jm0disf1QZ9rRYE1BSurtLytpXDBigtsGvAZvgIKtW8na6Sw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5av8s02-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Aug 2025 12:09:03 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57PBtVOT022476;
 Mon, 25 Aug 2025 12:09:03 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5av8s00-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Aug 2025 12:09:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57PARnch029986;
 Mon, 25 Aug 2025 12:09:02 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48qsfmdmj1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Aug 2025 12:09:02 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57PC90Ru32244276
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Aug 2025 12:09:00 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E6B758054;
 Mon, 25 Aug 2025 12:09:00 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 31CA55803F;
 Mon, 25 Aug 2025 12:08:57 +0000 (GMT)
Received: from [9.39.20.14] (unknown [9.39.20.14])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 25 Aug 2025 12:08:56 +0000 (GMT)
Message-ID: <0b6d96c7-b28f-42c0-93db-579d80f0298b@linux.ibm.com>
Date: Mon, 25 Aug 2025 17:38:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/ppc: Add IBM PPE42 family of processors
To: Thomas Huth <thuth@redhat.com>, Glenn Miles <milesg@linux.ibm.com>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@redhat.com, npiggin@gmail.com,
 rathc@linux.ibm.com, richard.henderson@linaro.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250819212856.219932-1-milesg@linux.ibm.com>
 <20250819212856.219932-2-milesg@linux.ibm.com>
 <0d2c9aa2-2dcc-4c22-8f33-e5ecac907cf4@linux.ibm.com>
 <c13f63a6-5fef-42f2-89fe-946f71498f51@redhat.com>
 <fd855a38-976f-430e-9db1-1bdce1cf869d@linux.ibm.com>
 <dc6dc7db-f4c3-4641-9707-383737e2b678@redhat.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <dc6dc7db-f4c3-4641-9707-383737e2b678@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zGZORqNvRGtonhtLGJFWY-OPjwQnOuKf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfX8I6/92lX74Hg
 hzCF6lf+R/mlzWStksfAfZvdsEKitNGxSxb6oYfHwA2pCpJ0sn7CUb1BCibKKrQLsBm0zF1oqlt
 OElJGDHwePogP1ml4cXl7LaeQWvx0ZRADwc2LV1BCT+2Wsd9SNqY0+xbN+qkQmnqhZdVmmmok/k
 /lewyTFCd+er4CVoowTbfvrGQASCn2NmY9+4WXwYIxMavMZriBAy2se400BIAtpDmF0iQ7Dgs6r
 fcaKYVaz8PFRMljbW2m9wf5s5ISoCuD8zLp2LqoFyIJmlapSusP4G9fq3SxPIsvK/VJqWMzOOiq
 IOpTz3P2Bny3UeeiRgDRDvxzSd21QqM/+cwELHRYdnGg4uQhsQRUvQJp0VEfmifMzOXLuNvYrSZ
 it5d3vTX
X-Proofpoint-ORIG-GUID: -Xyhodrm5NaLxRH57irQF8Edmtf8MPkL
X-Authority-Analysis: v=2.4 cv=SNNCVPvH c=1 sm=1 tr=0 ts=68ac525f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=f7IdgyKtn90A:10 a=jRLB2SoPAAAA:8
 a=VnNF1IyMAAAA:8 a=hggZ7vyeFM0D7QHDvVIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=yloqiLrygL2q3s9aD-8D:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230021
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 8/25/25 17:28, Thomas Huth wrote:
> On 25/08/2025 13.46, Harsh Prateek Bora wrote:
>> Hi Thomas,
>>
>> On 8/25/25 17:04, Thomas Huth wrote:
>>> On 25/08/2025 13.24, Harsh Prateek Bora wrote:
>>>> Hi Glenn,
>>>>
>>>> This seems significant work. Thanks for upstreaming.
>>>>
>>>> On 8/20/25 02:58, Glenn Miles wrote:
>>>>> Adds the IBM PPE42 family of processors supporting the
>>>>
>>>> family of 32-bit processors ?
>>>>
>>>>> PPE42, PPE42X and PPE42XM processor versions.  These
>>>>> processors are used as embedded processors in the IBM
>>>>> Power9, Power10 and Power12 processors for various
>>>>> tasks.  It is basically a stripped down version of the
>>>>> IBM PowerPC 405 processor, with some added instructions
>>>>> for handling 64-bit loads and stores.
>>>>>
>>>>> For more information on the PPE 42 processor please visit:
>>>>>
>>>>> https://wiki.raptorcs.com/w/images/a/a3/PPE_42X_Core_Users_Manual.pdf
>>>>>
>>>>> Supports PPE42 SPR's (Including the MSR) and  Exceptions.
>>>>>
>>>>> Does not yet support new PPE42 instructions and does not
>>>>> prevent access to some invalid instructions and registers
>>>>> (currently allows for access to invalid GPR's and CR fields).
>>>>>
>>>>> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
>>>>> ---
>>>>>   target/ppc/cpu-models.c      |   7 +
>>>>>   target/ppc/cpu-models.h      |   4 +
>>>>>   target/ppc/cpu.h             |  66 +++++++-
>>>>>   target/ppc/cpu_init.c        | 286 
>>>>> ++++++++++++++++++++++++++++++-----
>>>>>   target/ppc/excp_helper.c     | 171 +++++++++++++++++++++
>>>>>   target/ppc/helper_regs.c     |  28 +++-
>>>>>   target/ppc/tcg-excp_helper.c |  12 ++
>>>>>   target/ppc/translate.c       |   6 +-
>>>>>   8 files changed, 535 insertions(+), 45 deletions(-)
>>>>>
>>>>> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
>>>>> index ea86ea202a..09f73e23a8 100644
>>>>> --- a/target/ppc/cpu-models.c
>>>>> +++ b/target/ppc/cpu-models.c
>>>>> @@ -116,6 +116,13 @@
>>>>>                   NULL)
>>>>>       POWERPC_DEF("x2vp20", CPU_POWERPC_X2VP20,                 405,
>>>>>                   NULL)
>>>>> +    /* PPE42 Embedded 
>>>>> Controllers                                            */
>>>>> +    POWERPC_DEF("PPE42",         CPU_POWERPC_PPE42, ppe42,
>>>>> +                "Generic PPE 42")
>>>>> +    POWERPC_DEF("PPE42X",        CPU_POWERPC_PPE42X, ppe42x,
>>>>> +                "Generic PPE 42X")
>>>>> +    POWERPC_DEF("PPE42XM",       CPU_POWERPC_PPE42XM, ppe42xm,
>>>>> +                "Generic PPE 42XM")
>>>>
>>>> Can all the PPE42 specific code be conditionally compiled only for
>>>> !TARGET_PPC64 (and !CONFIG_USER_ONLY wherever possible)?
>>>> Not only to reduce the bloating size of respective binaries, but 
>>>> also to
>>>> avoid some code being added to hot path routines like 
>>>> hreg_compute_hflags_value().
>>>
>>> qemu-system-ppc64 is a superset of qemu-system-ppc, and there are 
>>> even efforts to unify all system functionality into a singly binary, 
>>> so excluding a 32-bit feature from qemu-system-ppc64 sounds like a 
>>> step into the wrong direction to me right now...?
>>
>> We do have existing code getting conditionally compiled for TARGET_PPC64
>> which I guess gets enabled with:
>>   --configure target-list=<ppc64|ppc>-softmmu
>> I understand the efforts are towards having a single binary to support
>> both, but what gets built-in is still decided with configure choice?
>>
>> Please correct/clarify with above understanding.
> 
> As I said, qemu-system-ppc64 is currently a full superset of 
> qemu-system-ppc. The ppc64 binary contains all the 32-bit code, you can 
> perfectly run a "g3beige" or "bamboo" machine with qemu-system-ppc64, 
> too. By disabling the ppe42 code in the ppc64 binary, this would now 
> introduce an execption to that unwritten rule, so I'd expect that we'd 
> not rather want to do this now.

My understanding is that above holds true only for default builds which
builds all targets. We certainly do not build 32 bit ppc code when using
--configure target-list=ppc64-softmmu. (we have ppc-softmmu for 32 bit 
though)

Could you please add respective folks to this thread who are working on
unifying builds to clarify more on this. We certainly dont want 32-bit
specific code to be running on a 64-bit machine, specially in hot paths.

regards,
Harsh
> 
>   Thomas
> 

