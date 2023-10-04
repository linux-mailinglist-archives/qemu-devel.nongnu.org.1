Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3517B7743
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 06:52:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qntqB-0006MD-Oq; Wed, 04 Oct 2023 00:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qntq5-0006LL-In; Wed, 04 Oct 2023 00:50:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qntpu-00046h-Fc; Wed, 04 Oct 2023 00:50:24 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3944HNw5015994; Wed, 4 Oct 2023 04:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=PyhznFMib3GW30ErER3m2UqObbeIOH7ZYvow2kv2D9o=;
 b=fHjQNUyxqKx0UltfJKj6YUlxtlysy1WkBkXPc7RPsTrj1jOA1Z8hQgwGYmWWFFf8ljPz
 E/KEao9ZYu5yfZeDswmZ9p2H/IBxDphVWrd+zPbJaAxVaQ9J0JNnH+3xFUdlDEj7s0tB
 ulA/nV0YEZcYYQ7digLX6NcR4qn3+iEnZ4d1ExubiJyTK27liJ6cBzDCw7cWmMsf/RYL
 uNxDQs9Z/skfvmH360Vtq+DY3d3Mew7lsPVH5PZnRfJkPlaWJD6n6Uoci79iqsdnjVvf
 6YgfCAIbAcPz1Or2YcKzm8QO+7bmjQ9rldz6cDZt0DIFGyo/w9RBcO2Rsxl+Wu6U7ivn WA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3th0kw0uxv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 04:50:08 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3944g5Ut018640;
 Wed, 4 Oct 2023 04:50:07 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3th0kw0uxg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 04:50:07 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3944WwvD025083; Wed, 4 Oct 2023 04:50:06 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3texcy8kq5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 04:50:06 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3944o5WE21693108
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Oct 2023 04:50:05 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B9715805C;
 Wed,  4 Oct 2023 04:50:05 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 142E758054;
 Wed,  4 Oct 2023 04:50:01 +0000 (GMT)
Received: from [9.43.72.102] (unknown [9.43.72.102])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Oct 2023 04:50:00 +0000 (GMT)
Message-ID: <ee2b7708-628c-4059-4fe7-44abe0caac49@linux.ibm.com>
Date: Wed, 4 Oct 2023 10:19:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RESEND 09/15] ppc: spapr: Implement nested PAPR hcall -
 H_GUEST_CREATE_VCPU
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, danielhb413@gmail.com,
 qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, mikey@neuling.org, vaibhav@linux.ibm.com,
 jniethe5@gmail.com, sbhat@linux.ibm.com, kconsul@linux.vnet.ibm.com
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
 <20230906043333.448244-10-harshpb@linux.ibm.com>
 <CVCCDB85C7Z2.3EOW6KPE9LCRJ@wheely>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CVCCDB85C7Z2.3EOW6KPE9LCRJ@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U2uHUIG2lQ_s6GnGWebLmcdaKESxisJu
X-Proofpoint-ORIG-GUID: x9F5Yw0F2LlKeIcn8OcUnmRWXyLAZX7n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 phishscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310040031
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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



On 9/7/23 08:19, Nicholas Piggin wrote:
> On Wed Sep 6, 2023 at 2:33 PM AEST, Harsh Prateek Bora wrote:
>> This patch implements support for hcall H_GUEST_CREATE_VCPU which is
>> used to instantiate a new VCPU for a previously created nested guest.
>> The L1 provide the guest-id (returned by L0 during call to
>> H_GUEST_CREATE) and an associated unique vcpu-id to refer to this
>> instance in future calls. It is assumed that vcpu-ids are being
>> allocated in a sequential manner and max vcpu limit is 2048.
>>
>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>>   hw/ppc/spapr_nested.c         | 110 ++++++++++++++++++++++++++++++++++
>>   include/hw/ppc/spapr.h        |   1 +
>>   include/hw/ppc/spapr_nested.h |   1 +
>>   3 files changed, 112 insertions(+)
>>
>> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
>> index 09bbbfb341..e7956685af 100644
>> --- a/hw/ppc/spapr_nested.c
>> +++ b/hw/ppc/spapr_nested.c
>> @@ -376,6 +376,47 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
>>       address_space_unmap(CPU(cpu)->as, regs, len, len, true);
>>   }
>>   
>> +static
>> +SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *spapr,
>> +                                                     target_ulong lpid)
>> +{
>> +    SpaprMachineStateNestedGuest *guest;
>> +
>> +    guest = g_hash_table_lookup(spapr->nested.guests, GINT_TO_POINTER(lpid));
>> +    return guest;
>> +}
> 
> Are you namespacing the new API stuff with papr or no? Might be good to
> reduce confusion.
> 
I guess you were referring to vcpu_check below.
Renaming vcpu_check to spapr_nested_vcpu_check().

>> +
>> +static bool vcpu_check(SpaprMachineStateNestedGuest *guest,
>> +                       target_ulong vcpuid,
>> +                       bool inoutbuf)
> 
> What's it checking? That the id is valid? Allocated? Enabled?
> 

This is being introduced to do sanity checks for the provided vcpuid of 
a guest. It should check if the vcpuid is valid, allocated and enabled 
before using further.

>> +{
>> +    struct SpaprMachineStateNestedGuestVcpu *vcpu;
>> +
>> +    if (vcpuid >= NESTED_GUEST_VCPU_MAX) {
>> +        return false;
>> +    }
>> +
>> +    if (!(vcpuid < guest->vcpus)) {
>> +        return false;
>> +    }
>> +
>> +    vcpu = &guest->vcpu[vcpuid];
>> +    if (!vcpu->enabled) {
>> +        return false;
>> +    }
>> +
>> +    if (!inoutbuf) {
>> +        return true;
>> +    }
>> +
>> +    /* Check to see if the in/out buffers are registered */
>> +    if (vcpu->runbufin.addr && vcpu->runbufout.addr) {
>> +        return true;
>> +    }
>> +

I think I shall move in/out buf related checks to vcpu_run patch.

>> +    return false;
>> +}
>> +
>>   static target_ulong h_guest_get_capabilities(PowerPCCPU *cpu,
>>                                                SpaprMachineState *spapr,
>>                                                target_ulong opcode,
>> @@ -448,6 +489,11 @@ static void
>>   destroy_guest_helper(gpointer value)
>>   {
>>       struct SpaprMachineStateNestedGuest *guest = value;
>> +    int i = 0;
> 
> Don't need to set i = 0 twice. A newline would be good though.
> 

Yeh, declaring with for loop and removing above init.

>> +    for (i = 0; i < guest->vcpus; i++) {
>> +        cpu_ppc_tb_free(&guest->vcpu[i].env);
>> +    }
>> +    g_free(guest->vcpu);
>>       g_free(guest);
>>   }
>>   
>> @@ -518,6 +564,69 @@ static target_ulong h_guest_create(PowerPCCPU *cpu,
>>       return H_SUCCESS;
>>   }
>>   
>> +static target_ulong h_guest_create_vcpu(PowerPCCPU *cpu,
>> +                                        SpaprMachineState *spapr,
>> +                                        target_ulong opcode,
>> +                                        target_ulong *args)
>> +{
>> +    CPUPPCState *env = &cpu->env, *l2env;
>> +    target_ulong flags = args[0];
>> +    target_ulong lpid = args[1];
>> +    target_ulong vcpuid = args[2];
>> +    SpaprMachineStateNestedGuest *guest;
>> +
>> +    if (flags) { /* don't handle any flags for now */
>> +        return H_UNSUPPORTED_FLAG;
>> +    }
>> +
>> +    guest = spapr_get_nested_guest(spapr, lpid);
>> +    if (!guest) {
>> +        return H_P2;
>> +    }
>> +
>> +    if (vcpuid < guest->vcpus) {
>> +        return H_IN_USE;
>> +    }
>> +
>> +    if (guest->vcpus >= NESTED_GUEST_VCPU_MAX) {
>> +        return H_P3;
>> +    }
>> +
>> +    if (guest->vcpus) {
>> +        struct SpaprMachineStateNestedGuestVcpu *vcpus;
> 
> Ditto for using typedefs. Do a sweep for this.
> 
Sure, done.

>> +        vcpus = g_try_renew(struct SpaprMachineStateNestedGuestVcpu,
>> +                            guest->vcpu,
>> +                            guest->vcpus + 1);
> 
> g_try_renew doesn't work with NULL mem? That's unfortunate.
> 

Hmm, behaviour with NULL is undefined, so keeping as is.

>> +        if (!vcpus) {
>> +            return H_NO_MEM;
>> +        }
>> +        memset(&vcpus[guest->vcpus], 0,
>> +               sizeof(struct SpaprMachineStateNestedGuestVcpu));
>> +        guest->vcpu = vcpus;
>> +        l2env = &vcpus[guest->vcpus].env;
>> +    } else {
>> +        guest->vcpu = g_try_new0(struct SpaprMachineStateNestedGuestVcpu, 1);
>> +        if (guest->vcpu == NULL) {
>> +            return H_NO_MEM;
>> +        }
>> +        l2env = &guest->vcpu->env;
>> +    }
> 
> These two legs seem to be doing the same thing in different
> ways wrt l2env. Just assign guest->vcpu in the branches and
> get the l2env from guest->vcpu[guest->vcpus] afterward, no?
> 
Sure, that seems better.

>> +    /* need to memset to zero otherwise we leak L1 state to L2 */
>> +    memset(l2env, 0, sizeof(CPUPPCState));
> 
> AFAIKS you just zeroed it above.
> 

Yeh, cleaning up the redundant memset.

>> +    /* Copy L1 PVR to L2 */
>> +    l2env->spr[SPR_PVR] = env->spr[SPR_PVR];
>> +    cpu_ppc_tb_init(l2env, SPAPR_TIMEBASE_FREQ);
> 
> I would move this down to the end, because it's setting up the
> vcpu...
> 

Make sense to re-order above and below chunks.

>> +
>> +    guest->vcpus++;
>> +    assert(vcpuid < guest->vcpus); /* linear vcpuid allocation only */
>> +    guest->vcpu[vcpuid].enabled = true;
>> +
> 
> ... This is still allocating the vcpu so move it up.
> 
>> +    if (!vcpu_check(guest, vcpuid, false)) {
>> +        return H_PARAMETER;
>> +    }
>> +    return H_SUCCESS;
>> +}
>> +
>>   void spapr_register_nested(void)
>>   {
>>       spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
>> @@ -531,6 +640,7 @@ void spapr_register_nested_phyp(void)
>>       spapr_register_hypercall(H_GUEST_GET_CAPABILITIES, h_guest_get_capabilities);
>>       spapr_register_hypercall(H_GUEST_SET_CAPABILITIES, h_guest_set_capabilities);
>>       spapr_register_hypercall(H_GUEST_CREATE          , h_guest_create);
>> +    spapr_register_hypercall(H_GUEST_CREATE_VCPU     , h_guest_create_vcpu);
>>   }
>>   
>>   #else
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 8a6e9ce929..c9f9682a46 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -371,6 +371,7 @@ struct SpaprMachineState {
>>   #define H_UNSUPPORTED     -67
>>   #define H_OVERLAP         -68
>>   #define H_STATE           -75
>> +#define H_IN_USE          -77
> 
> Why add it here and not in the first patch?
> 

Yeh, it was a miss for initial patch, but I guess, we want it here only 
for patch v2. Introducing stuff where they are used first.

>>   #define H_INVALID_ELEMENT_ID               -79
>>   #define H_INVALID_ELEMENT_SIZE             -80
>>   #define H_INVALID_ELEMENT_VALUE            -81
>> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
>> index 7841027df8..2e8c6ba1ca 100644
>> --- a/include/hw/ppc/spapr_nested.h
>> +++ b/include/hw/ppc/spapr_nested.h
>> @@ -199,6 +199,7 @@
>>   
>>   /* Nested PAPR API macros */
>>   #define NESTED_GUEST_MAX 4096
>> +#define NESTED_GUEST_VCPU_MAX 2048
>>   
> 
> PAPR_ prefix?
> 
Done.

Thanks
Harsh
>>   typedef struct SpaprMachineStateNestedGuest {
>>       unsigned long vcpus;
> 

