Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD8A878E07
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Mar 2024 05:56:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjuAb-0006FP-DC; Tue, 12 Mar 2024 00:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rjuAZ-0006DY-0l; Tue, 12 Mar 2024 00:55:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rjuAW-0007VP-HG; Tue, 12 Mar 2024 00:55:18 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42C4bVCs022904; Tue, 12 Mar 2024 04:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=8l4BWAzYz7KTjT6nU2BUny5ygPrdJIehQCcqrwRhZow=;
 b=XqMNw2mXc2/clgjqJLDZbUrZyGLrpBcYJfdUZG53C/C4AGrzMN9s6b6A2S5zbb3ak9Mb
 MfGnCmvcgphjF7VZlwmcbMIhMOe9mUCmWXgBEcBNAVseo+jOzRf3b6pqO8F2rqreSfxf
 Xza/5ZsAlq904Pi8ehT2csV3aZfzi6CT8J2t7lt/9H71Vn9wq4q5EIwcJ+CGpZiCdAUB
 jGDMY9wwrtXXmkaCbpLJDuQz1rPMkWZrQvIYbMPZG7tRwku6wm38PLyK5twbBo8YWnwu
 xqu/AAjHeMSnEAb5NhBUnckLgsekQtZbD4Hhio8UihvBHEbldWLQ9x8V6AFPau2lNadK Dg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtg68g4q6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 04:55:11 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42C4tAGQ001622;
 Tue, 12 Mar 2024 04:55:10 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtg68g4np-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 04:55:10 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42C1OW2g015539; Tue, 12 Mar 2024 04:55:09 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws2fyn1wu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 04:55:09 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42C4t6sj41222514
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Mar 2024 04:55:09 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D458C58056;
 Tue, 12 Mar 2024 04:55:06 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3707A58052;
 Tue, 12 Mar 2024 04:55:05 +0000 (GMT)
Received: from [9.109.243.35] (unknown [9.109.243.35])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Mar 2024 04:55:04 +0000 (GMT)
Message-ID: <d1b34bf3-e9b7-48e6-9e46-ec396068b888@linux.ibm.com>
Date: Tue, 12 Mar 2024 10:25:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] ppc: Drop support for POWER9 and POWER10 DD1 chips
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20240311185200.2185753-1-npiggin@gmail.com>
 <20240311185200.2185753-2-npiggin@gmail.com>
 <5f8b269f-1f43-42ab-b4bf-d0314b739493@linux.ibm.com>
In-Reply-To: <5f8b269f-1f43-42ab-b4bf-d0314b739493@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: D8CKRYSmHX_WUpMOmnoKblVCN_mLCU6g
X-Proofpoint-GUID: hs8J-9U5IYlvKnG0tbrmoEHsy4_PcRWV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_04,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120036
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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



On 3/12/24 10:20, Harsh Prateek Bora wrote:
> 
> 
> On 3/12/24 00:21, Nicholas Piggin wrote:
>> The POWER9 DD1 and POWER10 DD1 chips are not public and are no longer of
>> any use in QEMU. Remove them.
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   hw/ppc/spapr_cpu_core.c |  2 --
>>   target/ppc/cpu-models.c |  4 ----
>>   target/ppc/cpu_init.c   |  7 ++-----
>>   target/ppc/kvm.c        | 11 -----------
>>   4 files changed, 2 insertions(+), 22 deletions(-)
> 
> Do we want to squash in removal of the macro as well?
>

<snip>
Actually both, correcting diff:

diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index 0229ef3a9a..7d89b41214 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -348,11 +348,9 @@ enum {
      CPU_POWERPC_POWER8NVL_BASE     = 0x004C0000,
      CPU_POWERPC_POWER8NVL_v10      = 0x004C0100,
      CPU_POWERPC_POWER9_BASE        = 0x004E0000,
-    CPU_POWERPC_POWER9_DD1         = 0x004E1100,
      CPU_POWERPC_POWER9_DD20        = 0x004E1200,
      CPU_POWERPC_POWER9_DD22        = 0x004E1202,
      CPU_POWERPC_POWER10_BASE       = 0x00800000,
-    CPU_POWERPC_POWER10_DD1        = 0x00801100,
      CPU_POWERPC_POWER10_DD20       = 0x00801200,
      CPU_POWERPC_970_v22            = 0x00390202,
      CPU_POWERPC_970FX_v10          = 0x00391100,

> 
> With that,
> 
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> 
> regards,
> Harsh
> 
>>
>> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
>> index 40b7c52f7f..50523ead25 100644
>> --- a/hw/ppc/spapr_cpu_core.c
>> +++ b/hw/ppc/spapr_cpu_core.c
>> @@ -394,10 +394,8 @@ static const TypeInfo spapr_cpu_core_type_infos[] 
>> = {
>>       DEFINE_SPAPR_CPU_CORE_TYPE("power8_v2.0"),
>>       DEFINE_SPAPR_CPU_CORE_TYPE("power8e_v2.1"),
>>       DEFINE_SPAPR_CPU_CORE_TYPE("power8nvl_v1.0"),
>> -    DEFINE_SPAPR_CPU_CORE_TYPE("power9_v1.0"),
>>       DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.0"),
>>       DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.2"),
>> -    DEFINE_SPAPR_CPU_CORE_TYPE("power10_v1.0"),
>>       DEFINE_SPAPR_CPU_CORE_TYPE("power10_v2.0"),
>>   #ifdef CONFIG_KVM
>>       DEFINE_SPAPR_CPU_CORE_TYPE("host"),
>> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
>> index 36e465b390..f2301b43f7 100644
>> --- a/target/ppc/cpu-models.c
>> +++ b/target/ppc/cpu-models.c
>> @@ -728,14 +728,10 @@
>>                   "POWER8 v2.0")
>>       POWERPC_DEF("power8nvl_v1.0", CPU_POWERPC_POWER8NVL_v10,         
>> POWER8,
>>                   "POWER8NVL v1.0")
>> -    POWERPC_DEF("power9_v1.0",   CPU_POWERPC_POWER9_DD1,             
>> POWER9,
>> -                "POWER9 v1.0")
>>       POWERPC_DEF("power9_v2.0",   CPU_POWERPC_POWER9_DD20,            
>> POWER9,
>>                   "POWER9 v2.0")
>>       POWERPC_DEF("power9_v2.2",   CPU_POWERPC_POWER9_DD22,            
>> POWER9,
>>                   "POWER9 v2.2")
>> -    POWERPC_DEF("power10_v1.0",  CPU_POWERPC_POWER10_DD1,            
>> POWER10,
>> -                "POWER10 v1.0")
>>       POWERPC_DEF("power10_v2.0",  CPU_POWERPC_POWER10_DD20,           
>> POWER10,
>>                   "POWER10 v2.0")
>>   #endif /* defined (TARGET_PPC64) */
>> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
>> index 1d3d1db7c3..572cbdf25f 100644
>> --- a/target/ppc/cpu_init.c
>> +++ b/target/ppc/cpu_init.c
>> @@ -6350,10 +6350,7 @@ static bool 
>> ppc_pvr_match_power9(PowerPCCPUClass *pcc, uint32_t pvr, bool best)
>>           return false;
>>       }
>> -    if ((pvr & 0x0f00) == 0x100) {
>> -        /* DD1.x always matches power9_v1.0 */
>> -        return true;
>> -    } else if ((pvr & 0x0f00) == 0x200) {
>> +    if ((pvr & 0x0f00) == 0x200) {
>>           if ((pvr & 0xf) < 2) {
>>               /* DD2.0, DD2.1 match power9_v2.0 */
>>               if ((pcc->pvr & 0xf) == 0) {
>> @@ -6536,7 +6533,7 @@ static bool 
>> ppc_pvr_match_power10(PowerPCCPUClass *pcc, uint32_t pvr, bool best)
>>       }
>>       if ((pvr & 0x0f00) == (pcc->pvr & 0x0f00)) {
>> -        /* Major DD version matches to power10_v1.0 and power10_v2.0 */
>> +        /* Major DD version matches power10_v2.0 */
>>           return true;
>>       }
>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>> index bcf30a5400..525fbe3892 100644
>> --- a/target/ppc/kvm.c
>> +++ b/target/ppc/kvm.c
>> @@ -2369,17 +2369,6 @@ static void 
>> kvmppc_host_cpu_class_init(ObjectClass *oc, void *data)
>>   #if defined(TARGET_PPC64)
>>       pcc->radix_page_info = kvmppc_get_radix_page_info();
>> -
>> -    if ((pcc->pvr & 0xffffff00) == CPU_POWERPC_POWER9_DD1) {
>> -        /*
>> -         * POWER9 DD1 has some bugs which make it not really ISA 3.00
>> -         * compliant.  More importantly, advertising ISA 3.00
>> -         * architected mode may prevent guests from activating
>> -         * necessary DD1 workarounds.
>> -         */
>> -        pcc->pcr_supported &= ~(PCR_COMPAT_3_00 | PCR_COMPAT_2_07
>> -                                | PCR_COMPAT_2_06 | PCR_COMPAT_2_05);
>> -    }
>>   #endif /* defined(TARGET_PPC64) */
>>   }
> 

