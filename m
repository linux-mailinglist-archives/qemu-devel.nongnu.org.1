Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6A07B62FC
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 09:58:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnaHX-0004cP-8m; Tue, 03 Oct 2023 03:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qnaHU-0004bi-T3; Tue, 03 Oct 2023 03:57:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qnaHT-0002UW-08; Tue, 03 Oct 2023 03:57:24 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3937r09R020951; Tue, 3 Oct 2023 07:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=j72u0hXcBeqgS26N9fwsXuA5bh58pta6bVgempEZ+ds=;
 b=phwk4kCfyuDhFHdT3fSdvvlmfT6y1GY2ZUZlB4IwOwuTyBwYoT1Lu5oLkg1btudFUciT
 4WrG2f//nME1CantC6836gWtETDPrEGJ8B6QlRPn0tzdpBqbLb8NvUFRpG22RF1cRngc
 i5uwG/s8YtK33qcamqC/078HPTK4AIZjesX0M7bZVD2kTPXYC46NLnxRJkqqEwPUGmZ+
 uwUI7MvumM9skn5DO9Bdrvl1vlStQayqPhK0ojmWeNtLcPu9QM4ltoALttdnf1kUTfd6
 8yVtqFbTrdYQRDG9asnrrjCoVnBwxwtun6JwRuZQCxPqWYpWH3/RS9H6Kx4WHsHakOFa xg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tgesy8ej8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Oct 2023 07:57:17 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3937grnf017090;
 Tue, 3 Oct 2023 07:57:17 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tgesy8ehr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Oct 2023 07:57:17 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3936jJQt005868; Tue, 3 Oct 2023 07:57:16 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tex0sgaaf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Oct 2023 07:57:16 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3937vFS930671314
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Oct 2023 07:57:15 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41CF458057;
 Tue,  3 Oct 2023 07:57:15 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 478D858058;
 Tue,  3 Oct 2023 07:57:12 +0000 (GMT)
Received: from [9.109.242.129] (unknown [9.109.242.129])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  3 Oct 2023 07:57:11 +0000 (GMT)
Message-ID: <8cd839d4-b0fc-5d3f-a16a-fd13f750d49b@linux.ibm.com>
Date: Tue, 3 Oct 2023 13:27:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RESEND 08/15] ppc: spapr: Implement nested PAPR hcall -
 H_GUEST_CREATE
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, danielhb413@gmail.com,
 qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, mikey@neuling.org, vaibhav@linux.ibm.com,
 jniethe5@gmail.com, sbhat@linux.ibm.com, kconsul@linux.vnet.ibm.com
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
 <20230906043333.448244-9-harshpb@linux.ibm.com>
 <CVCBX2FBQ7B8.KXFOWS32C9IQ@wheely>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CVCBX2FBQ7B8.KXFOWS32C9IQ@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Z3Pmh9ldUqkkgP6z7NzEJ8RMm2MbiMSb
X-Proofpoint-GUID: 5D3SuDuqHXKMeDWUB-qirB3L8-x-PDzk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_04,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=727
 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030056
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 9/7/23 07:58, Nicholas Piggin wrote:
> On Wed Sep 6, 2023 at 2:33 PM AEST, Harsh Prateek Bora wrote:
>> This hcall is used by L1 to indicate to L0 that a new nested guest needs
>> to be created and therefore necessary resource allocation shall be made.
>> The L0 uses a hash table for nested guest specific resource management.
>> This data structure is further utilized by other hcalls to operate on
>> related members during entire life cycle of the nested guest.
> 
> Similar comment for changelog re detail. Detailed specification of API
> and implementation could go in comments or documentation if useful.
> 
Sure, squashing guest create/delete together and updating commit log to 
be abstract as needed.

>>
>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>>   hw/ppc/spapr_nested.c         | 75 +++++++++++++++++++++++++++++++++++
>>   include/hw/ppc/spapr_nested.h |  3 ++
>>   2 files changed, 78 insertions(+)
>>
>> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
>> index 9af65f257f..09bbbfb341 100644
>> --- a/hw/ppc/spapr_nested.c
>> +++ b/hw/ppc/spapr_nested.c
>> @@ -444,6 +444,80 @@ static target_ulong h_guest_set_capabilities(PowerPCCPU *cpu,
>>       return H_SUCCESS;
>>   }
>>   
>> +static void
>> +destroy_guest_helper(gpointer value)
>> +{
>> +    struct SpaprMachineStateNestedGuest *guest = value;
>> +    g_free(guest);
>> +}
>> +
>> +static target_ulong h_guest_create(PowerPCCPU *cpu,
>> +                                   SpaprMachineState *spapr,
>> +                                   target_ulong opcode,
>> +                                   target_ulong *args)
>> +{
>> +    CPUPPCState *env = &cpu->env;
>> +    target_ulong flags = args[0];
>> +    target_ulong continue_token = args[1];
>> +    uint64_t lpid;
>> +    int nguests = 0;
>> +    struct SpaprMachineStateNestedGuest *guest;
>> +
>> +    if (flags) { /* don't handle any flags for now */
>> +        return H_UNSUPPORTED_FLAG;
>> +    }
>> +
>> +    if (continue_token != -1) {
>> +        return H_P2;
>> +    }
>> +
>> +    if (!spapr_get_cap(spapr, SPAPR_CAP_NESTED_PAPR)) {
>> +        return H_FUNCTION;
>> +    }
>> +
>> +    if (!spapr->nested.capabilities_set) {
>> +        return H_STATE;
>> +    }
>> +
>> +    if (!spapr->nested.guests) {
>> +        spapr->nested.lpid_max = NESTED_GUEST_MAX;
>> +        spapr->nested.guests = g_hash_table_new_full(NULL,
>> +                                                     NULL,
>> +                                                     NULL,
>> +                                                     destroy_guest_helper);
> 
> Is lpid_max only used by create? Probably no need to have it in spapr
> then->nested then. Also, do we even need to have a limit?

Yes, as of now, it is being used only by create and doesnt need to part
of spapr->nested. We can simply use the macro for max guests. Keeping it
to emulate a finite resource model.
For all practical purposes, nested guests in an TCG emulated L0
shouldn't reach that limit.

> 
>> +    }
>> +
>> +    nguests = g_hash_table_size(spapr->nested.guests);
>> +
>> +    if (nguests == spapr->nested.lpid_max) {
>> +        return H_NO_MEM;
>> +    }
>> +
>> +    /* Lookup for available lpid */
>> +    for (lpid = 1; lpid < spapr->nested.lpid_max; lpid++) {
> 
> PAPR API calls it "guest ID" I think. Should change all references to
> lpid to that.

Changing it to "guestid".

> 
>> +        if (!(g_hash_table_lookup(spapr->nested.guests,
>> +                                  GINT_TO_POINTER(lpid)))) {
>> +            break;
>> +        }
>> +    }
>> +    if (lpid == spapr->nested.lpid_max) {
>> +        return H_NO_MEM;
>> +    }
>> +
>> +    guest = g_try_new0(struct SpaprMachineStateNestedGuest, 1);
>> +    if (!guest) {
>> +        return H_NO_MEM;
>> +    }
>> +
>> +    guest->pvr_logical = spapr->nested.pvr_base;
>> +
>> +    g_hash_table_insert(spapr->nested.guests, GINT_TO_POINTER(lpid), guest);
>> +    printf("%s: lpid: %lu (MAX: %i)\n", __func__, lpid, spapr->nested.lpid_max);
> 
> Remove printf.
> 
Done.

>> +
>> +    env->gpr[4] = lpid;
>> +    return H_SUCCESS;
>> +}
>> +
>>   void spapr_register_nested(void)
>>   {
>>       spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
>> @@ -456,6 +530,7 @@ void spapr_register_nested_phyp(void)
>>   {
>>       spapr_register_hypercall(H_GUEST_GET_CAPABILITIES, h_guest_get_capabilities);
>>       spapr_register_hypercall(H_GUEST_SET_CAPABILITIES, h_guest_set_capabilities);
>> +    spapr_register_hypercall(H_GUEST_CREATE          , h_guest_create);
>>   }
>>   
>>   #else
>> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
>> index a7996251cb..7841027df8 100644
>> --- a/include/hw/ppc/spapr_nested.h
>> +++ b/include/hw/ppc/spapr_nested.h
>> @@ -197,6 +197,9 @@
>>   #define H_GUEST_CAP_P9_MODE_BMAP    1
>>   #define H_GUEST_CAP_P10_MODE_BMAP   2
>>   
>> +/* Nested PAPR API macros */
>> +#define NESTED_GUEST_MAX 4096
> 
> Prefix with PAPR_?

Done.

Thanks
Harsh
> 
> Thanks,
> Nick
> 
>> +
>>   typedef struct SpaprMachineStateNestedGuest {
>>       unsigned long vcpus;
>>       struct SpaprMachineStateNestedGuestVcpu *vcpu;
> 

