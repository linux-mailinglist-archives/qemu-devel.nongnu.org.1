Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E88B7F5799
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 06:05:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r61sh-0006Qp-Cy; Thu, 23 Nov 2023 00:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1r61sa-0006Q5-15; Thu, 23 Nov 2023 00:03:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1r61sW-0000m0-4W; Thu, 23 Nov 2023 00:03:55 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AN53GNJ005218; Thu, 23 Nov 2023 05:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=dA0PNQ6+Wvi+d3y6kLjbnmrtPclvWxi5YiK8J6W2Xto=;
 b=rLlGWFcAxn0o11LkjDeU5kgF8Rp9uyAsGHxhSmtd2t5N3yB1bnNE56+sZuUTWZNdu6Zg
 yNzxvRubu2FsiBX/OxsHQB57ku5jtk+27yN3jYvC6b1SLyHvTYDFNPAU2Y47ZxEZCuxP
 Y+2o2JE4RbUbOHlKlNzNyrds/+3OscUTGQFrkerwokLHpnAokBy1L3T+PCFNoiwk6xCl
 5cIvm0bYAfZrtm7DUK9OxSAHgefOkML9mTx5b33Ww6o/9P+YQPuvYw3bRd35DUod1oYs
 JhbkRb929GSzzMdVxlq3MJyc0NaqlGSW18XAmmfe+S/LZ54oZQxJ7lH0hv5Qq4J42eeG Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uj08c0061-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Nov 2023 05:03:37 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AN53bVR006096;
 Thu, 23 Nov 2023 05:03:37 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uj08c005r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Nov 2023 05:03:37 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AN44Mck002211; Thu, 23 Nov 2023 05:03:36 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf9tkmnsq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Nov 2023 05:03:36 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AN53a0o46334546
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Nov 2023 05:03:36 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03C3A58058;
 Thu, 23 Nov 2023 05:03:36 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B33F15805B;
 Thu, 23 Nov 2023 05:03:33 +0000 (GMT)
Received: from [9.109.242.129] (unknown [9.109.242.129])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Nov 2023 05:03:33 +0000 (GMT)
Message-ID: <504a8c39-711c-2fcf-ffc7-396898d5e84b@linux.ibm.com>
Date: Thu, 23 Nov 2023 10:33:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/2] ppc/spapr: Initialize max_cpus limit to
 SPAPR_NR_IPIS.
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: danielhb413@gmail.com, clg@kaod.org, david@gibson.dropbear.id.au,
 qemu-devel@nongnu.org
References: <20231122092845.973949-1-harshpb@linux.ibm.com>
 <20231122092845.973949-3-harshpb@linux.ibm.com>
 <4eaf8cf4-94b1-425b-a712-c006abb114c3@linaro.org>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <4eaf8cf4-94b1-425b-a712-c006abb114c3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: R6yAqp3eldf902Q8FOZr1WbLa5Fvtr9b
X-Proofpoint-GUID: qDjV9MksTJhSh792idb6TKZo9N13pWAX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_02,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311230034
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

Hi Philippe,

On 11/22/23 16:46, Philippe Mathieu-Daudé wrote:
> Hi Harsh,
> 
> On 22/11/23 10:28, Harsh Prateek Bora wrote:
>> Initialize the machine specific max_cpus limit as per the maximum range
>> of CPU IPIs available. Keeping between 4096 to 8192 will throw IRQ not
>> free error due to XIVE/XICS limitation and keeping beyond 8192 will hit
>> assert in tcg_region_init or spapr_xive_claim_irq.
>>
>> Logs:
>>
>> Without patch fix:
>>
>> [root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=4097
>> qemu-system-ppc64: IRQ 4096 is not free
>> [root@host build]#
>>
>> On LPAR:
>> [root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=8193
>> **
>> ERROR:../tcg/region.c:774:tcg_region_init: assertion failed:
>> (region_size >= 2 * page_size)
>> Bail out! ERROR:../tcg/region.c:774:tcg_region_init: assertion failed:
>> (region_size >= 2 * page_size)
>> Aborted (core dumped)
>> [root@host build]#
>>
>> On x86:
>> [root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=8193
>> qemu-system-ppc64: ../hw/intc/spapr_xive.c:596: spapr_xive_claim_irq:
>> Assertion `lisn < xive->nr_irqs' failed.
>> Aborted (core dumped)
>> [root@host build]#
>>
>> With patch fix:
>> [root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=4097
>> qemu-system-ppc64: Invalid SMP CPUs 4097. The max CPUs supported by
>> machine 'pseries-8.2' is 4096
>> [root@host build]#
>>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>>   hw/ppc/spapr.c | 9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index df09aa9d6a..0de11a4458 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -4647,13 +4647,10 @@ static void 
>> spapr_machine_class_init(ObjectClass *oc, void *data)
>>       mc->block_default_type = IF_SCSI;
>>       /*
>> -     * Setting max_cpus to INT32_MAX. Both KVM and TCG max_cpus values
>> -     * should be limited by the host capability instead of hardcoded.
>> -     * max_cpus for KVM guests will be checked in kvm_init(), and TCG
>> -     * guests are welcome to have as many CPUs as the host are capable
>> -     * of emulate.
>> +     * While KVM determines max cpus in kvm_init() using 
>> kvm_max_vcpus(),
>> +     * In TCG the limit is restricted by the range of CPU IPIs 
>> available.
>>        */
>> -    mc->max_cpus = INT32_MAX;
>> +    mc->max_cpus = SPAPR_NR_IPIS;
> 
> Is SPAPR_NR_IPIS also the upper limit for KVM?

In KVM mode, the limit is restricted to what is supported by KVM which 
is checked using kvm_ioctl via wrappers in kvm_init and appears to be 
evaluating to 2048. So, having a larger default works for both case.

regards,
Harsh

> 
>>       mc->no_parallel = 1;
>>       mc->default_boot_order = "";
> 

