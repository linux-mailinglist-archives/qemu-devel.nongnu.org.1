Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4422B87937A
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Mar 2024 13:00:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0mg-0007Ae-JX; Tue, 12 Mar 2024 07:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rk0me-00079C-8N; Tue, 12 Mar 2024 07:59:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rk0mc-0007av-En; Tue, 12 Mar 2024 07:59:03 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42CAXFaE032668; Tue, 12 Mar 2024 11:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=p+LCNvpWeZabLjSPp2HKTGcFSmMAyKmNdIC1Fj+Yh/Y=;
 b=thlnnm7OQPKyaIgAY99gN/WWtXmOrmIG0oiSN7mAeVsSeVrxFeQZvJRb2ow9797P4xEg
 vSkCei7f/L6vlpjZ6WHXpoKeV+jspkE+/7MVw5AEUgUKP4gnaOrn6odDCrtKXQfK7jtv
 wKm0OOSKZ7k6HKVodxqjuOk5hZwi9oaxzZASaOEf7rQqkhlwlLOsmOepBOmc3QXAJLVX
 FkLzEjHYMQ4+3r1LY0TsOjXHwQ4bi3e31Iamli+YQc5Mt99elhTtPr5w7xp4NA+rumgj
 6FyQQT32shib++QjspyBHZT+tX9wap+UMIt9zWVoVsPF0eNFJ6mt+5XsYJLaGduIaGiA aQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtncss9r7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 11:58:50 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42CBrGEK003545;
 Tue, 12 Mar 2024 11:58:50 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtncss9r2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 11:58:50 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42CBIOWD018189; Tue, 12 Mar 2024 11:58:49 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws23t72m2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 11:58:49 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42CBwjVA34931134
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Mar 2024 11:58:48 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DCD675806C;
 Tue, 12 Mar 2024 11:58:45 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CDEC758068;
 Tue, 12 Mar 2024 11:58:41 +0000 (GMT)
Received: from [9.171.18.209] (unknown [9.171.18.209])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Mar 2024 11:58:41 +0000 (GMT)
Message-ID: <57b0c81b-17d0-4697-aa26-6074290fbd1c@linux.ibm.com>
Date: Tue, 12 Mar 2024 17:28:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/14] spapr: nested: Use correct source for parttbl
 info for nested PAPR API.
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: clg@kaod.org, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
References: <20240308111940.1617660-1-harshpb@linux.ibm.com>
 <20240308111940.1617660-13-harshpb@linux.ibm.com>
 <CZRQSJXJRBEV.3LTQFO71EUU1O@wheely>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CZRQSJXJRBEV.3LTQFO71EUU1O@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SmcWVQDf-gOqsN4WSenpZ18P6dyI3VEJ
X-Proofpoint-ORIG-GUID: 9ightadzmI2WeJxX2X11GqQYpCSKb1x_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 clxscore=1015 malwarescore=0 bulkscore=0 mlxlogscore=801
 spamscore=0 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120091
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 3/12/24 17:11, Nicholas Piggin wrote:
> On Fri Mar 8, 2024 at 9:19 PM AEST, Harsh Prateek Bora wrote:
>> For nested PAPR API, we use SpaprMachineStateNestedGuest struct to store
>> partition table info, use the same in spapr_get_pate_nested() via
>> helper.
>>
>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>>   include/hw/ppc/spapr_nested.h |  4 ++++
>>   hw/ppc/spapr.c                |  6 ++++--
>>   hw/ppc/spapr_nested.c         | 22 +++++++++++++++++++++-
>>   3 files changed, 29 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
>> index bd43c6b6ef..152019fe3d 100644
>> --- a/include/hw/ppc/spapr_nested.h
>> +++ b/include/hw/ppc/spapr_nested.h
>> @@ -518,4 +518,8 @@ bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
>>                                 target_ulong lpid, ppc_v3_pate_t *entry);
>>   uint8_t spapr_nested_api(SpaprMachineState *spapr);
>>   void spapr_nested_gsb_init(void);
>> +bool spapr_get_pate_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cpu,
>> +                                target_ulong lpid, ppc_v3_pate_t *entry);
>> +SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *spapr,
>> +                                                     target_ulong lpid);
> 
> Why is this made non-static? Doesn't seem to be needed in later patches
> either? Other than that,
> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> 

You're right, looks like I missed it in v5, but kindly squash in below
incremental update with this patch, just relocating static helper above
caller?

regards,
Harsh

diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index 152019fe3d..3a36ba446b 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -520,6 +520,4 @@ uint8_t spapr_nested_api(SpaprMachineState *spapr);
  void spapr_nested_gsb_init(void);
  bool spapr_get_pate_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cpu,
                                  target_ulong lpid, ppc_v3_pate_t *entry);
-SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState 
*spapr,
-                                                     target_ulong lpid);
  #endif /* HW_SPAPR_NESTED_H */
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 8db9dc19e3..df22bd69bd 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -60,6 +60,15 @@ bool spapr_get_pate_nested_hv(SpaprMachineState 
*spapr, PowerPCCPU *cpu,
      return true;
  }

+static SpaprMachineStateNestedGuest 
*spapr_get_nested_guest(SpaprMachineState *spapr,
+                                                     target_ulong guestid)
+{
+    SpaprMachineStateNestedGuest *guest;
+
+    guest = g_hash_table_lookup(spapr->nested.guests, 
GINT_TO_POINTER(guestid));
+    return guest;
+}
+
  bool spapr_get_pate_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cpu,
                                  target_ulong lpid, ppc_v3_pate_t *entry)
  {
@@ -549,15 +558,6 @@ static void spapr_exit_nested_hv(PowerPCCPU *cpu, 
int excp)
      address_space_unmap(CPU(cpu)->as, regs, len, len, true);
  }

-SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState 
*spapr,
-                                                     target_ulong guestid)
-{
-    SpaprMachineStateNestedGuest *guest;
-
-    guest = g_hash_table_lookup(spapr->nested.guests, 
GINT_TO_POINTER(guestid));
-    return guest;
-}
-
  static bool spapr_nested_vcpu_check(SpaprMachineStateNestedGuest *guest,
                                      target_ulong vcpuid, bool inoutbuf)
  {



>>   #endif /* HW_SPAPR_NESTED_H */
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index a08ffe55b6..54fc01e462 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1376,11 +1376,13 @@ static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
>>           entry->dw1 = spapr->patb_entry;
>>           return true;
>>       } else {
>> -        assert(spapr_nested_api(spapr));
>>           if (spapr_nested_api(spapr) == NESTED_API_KVM_HV) {
>>               return spapr_get_pate_nested_hv(spapr, cpu, lpid, entry);
>> +        } else if (spapr_nested_api(spapr) == NESTED_API_PAPR) {
>> +            return spapr_get_pate_nested_papr(spapr, cpu, lpid, entry);
>> +        } else {
>> +            g_assert_not_reached();
>>           }
>> -        return false;
>>       }
>>   }
>>   
>> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
>> index ca99805ce8..e0b234c786 100644
>> --- a/hw/ppc/spapr_nested.c
>> +++ b/hw/ppc/spapr_nested.c
>> @@ -58,6 +58,21 @@ bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
>>       return true;
>>   }
>>   
>> +bool spapr_get_pate_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cpu,
>> +                                target_ulong lpid, ppc_v3_pate_t *entry)
>> +{
>> +    SpaprMachineStateNestedGuest *guest;
>> +    assert(lpid != 0);
>> +    guest = spapr_get_nested_guest(spapr, lpid);
>> +    if (!guest) {
>> +        return false;
>> +    }
>> +
>> +    entry->dw0 = guest->parttbl[0];
>> +    entry->dw1 = guest->parttbl[1];
>> +    return true;
>> +}
>> +
>>   #define PRTS_MASK      0x1f
>>   
>>   static target_ulong h_set_ptbl(PowerPCCPU *cpu,
>> @@ -540,7 +555,6 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
>>       }
>>   }
>>   
>> -static
>>   SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *spapr,
>>                                                        target_ulong guestid)
>>   {
>> @@ -1585,6 +1599,12 @@ bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
>>       return false;
>>   }
>>   
>> +bool spapr_get_pate_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cpu,
>> +                                target_ulong lpid, ppc_v3_pate_t *entry)
>> +{
>> +    return false;
>> +}
>> +
>>   void spapr_register_nested_papr(void)
>>   {
>>       /* DO NOTHING */
> 

