Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B673D7F4185
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 10:25:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5jSL-0008N4-RF; Wed, 22 Nov 2023 04:23:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1r5jSH-0008Me-EL; Wed, 22 Nov 2023 04:23:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1r5jSF-0005V2-IY; Wed, 22 Nov 2023 04:23:33 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AM8lQZQ008227; Wed, 22 Nov 2023 09:23:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=jZ/6h783zmFAuluzMivc3ixqUgnJ4gKFI9YgqdpReME=;
 b=iWkbaA/W9RPLvz2MJtmBD/dZRrr+KAjG1myCUt/cI5BzMp3RZ65Bvm+z0l/GzygZSIbk
 0fHdGlA3MPiN086k3ZsFcOe0ImAFrqy1ZhaHPl1XBmLjLEgxBB4LSOAwBw+8e98pbUBq
 5RCOJ9Id0XOB9aFBh5QcjoGA8FCj2drvSrNaVJsn/mVm6ra2E3Yjnp/o92SMH74ta1TR
 PyHpodzx2fcT86Ura6UNgpM0a+WBfWgpHqWFMFjDZwhtGz/N39/FwQliafc+zhvMatZV
 dsznk/NtXXs2lcsYLnUQiGxrZ+oK+MR7RaOytRR4oiQETEDcLGRmLMrjEpDtmQ+LBI5H tw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhdg3b8sk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Nov 2023 09:23:17 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AM9B3VT010267;
 Wed, 22 Nov 2023 09:23:17 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhdg3b8s5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Nov 2023 09:23:17 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AM7JKhD002677; Wed, 22 Nov 2023 09:23:16 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf93kxqq7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Nov 2023 09:23:16 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AM9NFwm21299900
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Nov 2023 09:23:15 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6162758051;
 Wed, 22 Nov 2023 09:23:15 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6AC85805A;
 Wed, 22 Nov 2023 09:23:12 +0000 (GMT)
Received: from [9.43.17.116] (unknown [9.43.17.116])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 22 Nov 2023 09:23:12 +0000 (GMT)
Message-ID: <f957ffc5-a575-9756-22c7-3b4480395c2f@linux.ibm.com>
Date: Wed, 22 Nov 2023 14:53:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] ppc/spapr: Initialize max_cpus limit to an allowed usable
 limit.
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, npiggin@gmail.com,
 qemu-ppc@nongnu.org
Cc: danielhb413@gmail.com, david@gibson.dropbear.id.au, qemu-devel@nongnu.org
References: <20231122074802.868083-1-harshpb@linux.ibm.com>
 <ebcaeaae-31b8-4531-8b6a-ebd2ac96872f@kaod.org>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <ebcaeaae-31b8-4531-8b6a-ebd2ac96872f@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PD7ucyAtIW4EHIhyRNZGr47TvK-zPmbs
X-Proofpoint-ORIG-GUID: 9grqs5so2-CIOjR4RWJUUfzvgS1FEeV-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_06,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220065
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.996,
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



On 11/22/23 14:06, Cédric Le Goater wrote:
> On 11/22/23 08:48, Harsh Prateek Bora wrote:
>> Initialize the machine specific max_cpus limit to a usable limit 4096.
>> Keeping between 4096 to 8192 will throw IRQ not free error due to XIVE
>> limitation and keeping beyond 8192 will hit assert in tcg_region_init
>> or spapr_xive_claim_irq.
> 
> The IRQ number space is defined in include/hw/ppc/spapr_irq.h. XICS and
> XIVE have the same IRQ number space, it is not a XIVE limitation. It
> is how we organized interrupt numbers in the pseries-3.1 machine.
> 
> SPAPR_XIRQ_BASE defines an offset, at which the device IRQ numbers
> start, and below that offset, the range of IRQ numbers is reserved
> for IPIs. An assumption is made on the fact the both ranges, IPIs and
> devices, are contiguous and there is a little shortcut being done with
> the SPAPR_XIRQ_BASE define.
> 
> hw/ppc/spapr_irq.c:        qdev_prop_set_uint32(dev, "nr-irqs", 
> smc->nr_xirqs + SPAPR_XIRQ_BASE);
> hw/ppc/spapr_irq.c:                                      smc->nr_xirqs + 
> SPAPR_XIRQ_BASE);
> 
> This should use a SPAPR_NR_IPIS define (like we have a SPAPR_NR_XIRQS
> define) instead, which could be used to define mc->max_cpus like we
> define smc->nr_xirqs.
> 

Thanks Cedric for your review comments.
I have posted a v2 incorporating your suggestion.

regards,
Harsh
> Thanks,
> 
> C.
> 
> 
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
>>   hw/ppc/spapr.c         | 9 +++------
>>   include/hw/ppc/spapr.h | 1 +
>>   2 files changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index df09aa9d6a..1995949ea5 100644
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
>> +     * In TCG the limit is restricted by max-irqs setup by XIVE which 
>> is 4096.
>>        */
>> -    mc->max_cpus = INT32_MAX;
>> +    mc->max_cpus = SPAPR_MAX_CPUS;
>>       mc->no_parallel = 1;
>>       mc->default_boot_order = "";
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index e91791a1a9..210849a494 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -23,6 +23,7 @@ typedef struct SpaprPendingHpt SpaprPendingHpt;
>>   typedef struct Vof Vof;
>> +#define SPAPR_MAX_CPUS          4096
>>   #define HPTE64_V_HPTE_DIRTY     0x0000000000000040ULL
>>   #define SPAPR_ENTRY_POINT       0x100
>>
> 

