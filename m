Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0477BD50E
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 10:24:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qplYI-0003HJ-I1; Mon, 09 Oct 2023 04:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qplYE-0003GY-6R; Mon, 09 Oct 2023 04:23:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qplYB-0007Td-JB; Mon, 09 Oct 2023 04:23:41 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3998Krot021507; Mon, 9 Oct 2023 08:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rF73r+CUYggiJVioylNqkoYh07A/B1saLT4DGPenDDU=;
 b=e9vQ6GOciXDHhSeSIv3mIZz1FOhDNUCIG8X2fv6nZ9Z83bZPTyNfN9cAdxUEuvVfyT4r
 xp/uGiS+b7ceFV6RLeqGwZ9e4tDKMKOW06CuG/fcvU73oUKLhCz28zh5Mfi3K7QTB2h+
 BZHEeS9ZN5f60pQErJC36xMpCXtuM1LLfYSz0RdCrxM2RYH8N67CQx4FKSvKKJA9MleO
 hxfLsPQQc6DIYw2HCi7WaPuktznmO7TUXT1YmyRH2Kc7vjpHByiKIScJXskbN1dNbq9P
 GoCww6EQ3CbILAB1ikro45MQHP0yy+hiXbZdGPZm9Bk5AZVt6QSnbxoCurxHr9qykp1l hg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tmdx283dr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Oct 2023 08:23:33 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3998LTLo023568;
 Mon, 9 Oct 2023 08:23:32 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tmdx283dg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Oct 2023 08:23:32 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3995PdH7028182; Mon, 9 Oct 2023 08:23:31 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkj1xqtwj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Oct 2023 08:23:31 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3998NUPK5833270
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Oct 2023 08:23:30 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 898E658043;
 Mon,  9 Oct 2023 08:23:30 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 219B358059;
 Mon,  9 Oct 2023 08:23:27 +0000 (GMT)
Received: from [9.109.242.129] (unknown [9.109.242.129])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Oct 2023 08:23:26 +0000 (GMT)
Message-ID: <a10dc8c5-a992-87b4-4a93-30f41cf90ec6@linux.ibm.com>
Date: Mon, 9 Oct 2023 13:53:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RESEND 11/15] ppc: spapr: Implement nested PAPR hcall -
 H_GUEST_[GET|SET]_STATE
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, danielhb413@gmail.com,
 qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, mikey@neuling.org, vaibhav@linux.ibm.com,
 jniethe5@gmail.com, sbhat@linux.ibm.com, kconsul@linux.vnet.ibm.com
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
 <20230906043333.448244-12-harshpb@linux.ibm.com>
 <CVCD8OCRI1FI.19OOXLKWHGZ00@wheely>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CVCD8OCRI1FI.19OOXLKWHGZ00@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sNOsJf135utMr5vDLYKHDQuSQElncrNP
X-Proofpoint-GUID: o7D0U1pDSQPTc0p1NWUdJAkIV3UifocZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_07,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 phishscore=0
 impostorscore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310090070
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.818,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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



On 9/7/23 09:00, Nicholas Piggin wrote:
> On Wed Sep 6, 2023 at 2:33 PM AEST, Harsh Prateek Bora wrote:
>> L1 can reuest to get/set state of any of the supported Guest State
>> Buffer (GSB) elements using h_guest_[get|set]_state hcalls.
>> These hcalls needs to do some necessary validation check for each
>> get/set request based on the flags passed and operation supported.
>>
>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>>   hw/ppc/spapr_nested.c         | 267 ++++++++++++++++++++++++++++++++++
>>   include/hw/ppc/spapr_nested.h |  22 +++
>>   2 files changed, 289 insertions(+)
>>
>> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
>> index 6fbb1bcb02..498e7286fa 100644
>> --- a/hw/ppc/spapr_nested.c
>> +++ b/hw/ppc/spapr_nested.c
>> @@ -897,6 +897,138 @@ void init_nested(void)
>>       }
>>   }
>>   
>> +static struct guest_state_element *guest_state_element_next(
>> +    struct guest_state_element *element,
>> +    int64_t *len,
>> +    int64_t *num_elements)
>> +{
>> +    uint16_t size;
>> +
>> +    /* size is of element->value[] only. Not whole guest_state_element */
>> +    size = be16_to_cpu(element->size);
>> +
>> +    if (len) {
>> +        *len -= size + offsetof(struct guest_state_element, value);
>> +    }
>> +
>> +    if (num_elements) {
>> +        *num_elements -= 1;
>> +    }
>> +
>> +    return (struct guest_state_element *)(element->value + size);
>> +}
>> +
>> +static
>> +struct guest_state_element_type *guest_state_element_type_find(uint16_t id)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(guest_state_element_types); i++)
>> +        if (id == guest_state_element_types[i].id) {
>> +            return &guest_state_element_types[i];
>> +        }
>> +
>> +    return NULL;
>> +}
>> +
>> +static void print_element(struct guest_state_element *element,
>> +                          struct guest_state_request *gsr)
>> +{
>> +    printf("id:0x%04x size:0x%04x %s ",
>> +           be16_to_cpu(element->id), be16_to_cpu(element->size),
>> +           gsr->flags & GUEST_STATE_REQUEST_SET ? "set" : "get");
>> +    printf("buf:0x%016lx ...\n", be64_to_cpu(*(uint64_t *)element->value));
> 
> No printfs. These could be GUEST_ERROR qemu logs if anything, make
> sure they're relatively well formed messages if you keep them, i.e.,
> something a Linux/KVM developer could understand what went wrong.
> I.e., no __func__ which is internal to QEMU, use "H_GUEST_GET_STATE"
> etc. Ditto for all the rest of the printfs.
> 

Sure, changing to qemu_log_mask(LOG_GUEST_ERROR, "h_guest_%s_state ..."

>> +}
>> +
>> +static bool guest_state_request_check(struct guest_state_request *gsr)
>> +{
>> +    int64_t num_elements, len = gsr->len;
>> +    struct guest_state_buffer *gsb = gsr->gsb;
>> +    struct guest_state_element *element;
>> +    struct guest_state_element_type *type;
>> +    uint16_t id, size;
>> +
>> +    /* gsb->num_elements = 0 == 32 bits long */
>> +    assert(len >= 4);
> 
> I haven't looked closely, but can the guest can't crash the
> host with malformed requests here?
> 
The GSB communication is happening between L1 host and L0 only.
L2 guest doesnt participate and remains unaware of this state exchange.
Hence, Only L1 with malformed request can crash itself, not L2.

> This API is pretty complicated, make sure you sanitize all inputs
> carefully, as early as possible, and without too deep a call and
> control flow chain from the API entry point.
> 

Noted.

> 
>> +
>> +    num_elements = be32_to_cpu(gsb->num_elements);
>> +    element = gsb->elements;
>> +    len -= sizeof(gsb->num_elements);
>> +
>> +    /* Walk the buffer to validate the length */
>> +    while (num_elements) {
>> +
>> +        id = be16_to_cpu(element->id);
>> +        size = be16_to_cpu(element->size);
>> +
>> +        if (false) {
>> +            print_element(element, gsr);
>> +        }
>> +        /* buffer size too small */
>> +        if (len < 0) {
>> +            return false;
>> +        }
>> +
>> +        type = guest_state_element_type_find(id);
>> +        if (!type) {
>> +            printf("%s: Element ID %04x unknown\n", __func__, id);
>> +            print_element(element, gsr);
>> +            return false;
>> +        }
>> +
>> +        if (id == GSB_HV_VCPU_IGNORED_ID) {
>> +            goto next_element;
>> +        }
>> +
>> +        if (size != type->size) {
>> +            printf("%s: Size mismatch. Element ID:%04x. Size Exp:%i Got:%i\n",
>> +                   __func__, id, type->size, size);
>> +            print_element(element, gsr);
>> +            return false;
>> +        }
>> +
>> +        if ((type->flags & GUEST_STATE_ELEMENT_TYPE_FLAG_READ_ONLY) &&
>> +            (gsr->flags & GUEST_STATE_REQUEST_SET)) {
>> +            printf("%s: trying to set a read-only Element ID:%04x.\n",
>> +                   __func__, id);
>> +            return false;
>> +        }
>> +
>> +        if (type->flags & GUEST_STATE_ELEMENT_TYPE_FLAG_GUEST_WIDE) {
>> +            /* guest wide element type */
>> +            if (!(gsr->flags & GUEST_STATE_REQUEST_GUEST_WIDE)) {
>> +                printf("%s: trying to set a guest wide Element ID:%04x.\n",
>> +                       __func__, id);
>> +                return false;
>> +            }
>> +        } else {
>> +            /* thread wide element type */
>> +            if (gsr->flags & GUEST_STATE_REQUEST_GUEST_WIDE) {
>> +                printf("%s: trying to set a thread wide Element ID:%04x.\n",
>> +                       __func__, id);
>> +                return false;
>> +            }
>> +        }
>> +next_element:
>> +        element = guest_state_element_next(element, &len, &num_elements);
>> +
>> +    }
>> +    return true;
>> +}
>> +
>> +static bool is_gsr_invalid(struct guest_state_request *gsr,
>> +                                   struct guest_state_element *element,
>> +                                   struct guest_state_element_type *type)
>> +{
>> +    if ((gsr->flags & GUEST_STATE_REQUEST_SET) &&
>> +        (*(uint64_t *)(element->value) & ~(type->mask))) {
>> +        print_element(element, gsr);
>> +        printf("L1 can't set reserved bits (allowed mask: 0x%08lx)\n",
>> +               type->mask);
>> +        return true;
>> +    }
>> +    return false;
>> +}
>>   
>>   static target_ulong h_guest_get_capabilities(PowerPCCPU *cpu,
>>                                                SpaprMachineState *spapr,
>> @@ -1108,6 +1240,139 @@ static target_ulong h_guest_create_vcpu(PowerPCCPU *cpu,
>>       return H_SUCCESS;
>>   }
>>   
>> +static target_ulong getset_state(SpaprMachineStateNestedGuest *guest,
>> +                                 uint64_t vcpuid,
>> +                                 struct guest_state_request *gsr)
>> +{
>> +    void *ptr;
>> +    uint16_t id;
>> +    struct guest_state_element *element;
>> +    struct guest_state_element_type *type;
>> +    int64_t lenleft, num_elements;
>> +
>> +    lenleft = gsr->len;
>> +
>> +    if (!guest_state_request_check(gsr)) {
>> +        return H_P3;
>> +    }
>> +
>> +    num_elements = be32_to_cpu(gsr->gsb->num_elements);
>> +    element = gsr->gsb->elements;
>> +    /* Process the elements */
>> +    while (num_elements) {
>> +        type = NULL;
>> +        /* Debug print before doing anything */
>> +        if (false) {
>> +            print_element(element, gsr);
>> +        }
>> +
>> +        id = be16_to_cpu(element->id);
>> +        if (id == GSB_HV_VCPU_IGNORED_ID) {
>> +            goto next_element;
>> +        }
>> +
>> +        type = guest_state_element_type_find(id);
>> +        assert(type);
>> +
>> +        /* Get pointer to guest data to get/set */
>> +        if (type->location && type->copy) {
>> +            ptr = type->location(guest, vcpuid);
>> +            assert(ptr);
>> +            if (!~(type->mask) && is_gsr_invalid(gsr, element, type)) {
>> +                return H_INVALID_ELEMENT_VALUE;
>> +            }
>> +            type->copy(ptr + type->offset, element->value,
>> +                       gsr->flags & GUEST_STATE_REQUEST_SET ? true : false);
>> +        }
>> +
>> +next_element:
>> +        element = guest_state_element_next(element, &lenleft, &num_elements);
>> +    }
>> +
>> +    return H_SUCCESS;
>> +}
>> +
>> +static target_ulong map_and_getset_state(PowerPCCPU *cpu,
>> +                                         SpaprMachineStateNestedGuest *guest,
>> +                                         uint64_t vcpuid,
>> +                                         struct guest_state_request *gsr)
>> +{
>> +    target_ulong rc;
>> +    int64_t lenleft, len;
>> +    bool is_write;
>> +
>> +    assert(gsr->len < (1024 * 1024)); /* sanity check */
> 
> Use a #define for this, make sure guest can't crash host.

Defined a macro GSB_MAX_BUF_SIZE for this and moving check to caller.
As explained earlier, nested guest cant crash the host as get/set is
happening only between L1 and L0. L2 doesnt participate.

>> +
>> +    lenleft = len = gsr->len;
> 
> Why lenleft? Can't you just check gsr->len like you do gsr->gsb?

My bad, updated.

> 
>> +    gsr->gsb = address_space_map(CPU(cpu)->as, gsr->buf, (uint64_t *)&len,
>> +                                 false, MEMTXATTRS_UNSPECIFIED);
> 
> So it's a read-only memory access to gsr->buf? Even for the set?

Hmm, actually set_state should need RO access, get_state would need RW
access to the provided buffer. However, not sure if there is bug in
these routines as it has been working like this for now. I shall update
and re-validate.

> 
>> +    if (!gsr->gsb) {
>> +        rc = H_P3;
>> +        goto out1;
>> +    }
>> +
>> +    if (len != lenleft) {
>> +        rc = H_P3;
>> +        goto out1;
>> +    }
>> +
>> +    rc = getset_state(guest, vcpuid, gsr);
>> +
>> +out1:
>> +    is_write = (rc == H_SUCCESS) ? len : 0;
>> +    address_space_unmap(CPU(cpu)->as, gsr->gsb, len, is_write, false);
> 
> I don't think this is right, you want to specify the length of memory
> you actually accessed, even if there was some error.
> 
> Over-specifying I think would be okay. So I think just use len.

Hmm, we are specifying len as expected, it's the is_write arg wrongly
set. I think this got carried forward from existing code as a typo as I
see most of the unmaps in spapr_exit_nested are passing last two args
unexpectedly. I shall update this call as appropriate for now and bugs
in existing code can be fixed in separate patches.

> 
> 
>> +    return rc;
>> +}
>> +
>> +static target_ulong h_guest_getset_state(PowerPCCPU *cpu,
>> +                                         SpaprMachineState *spapr,
>> +                                         target_ulong *args,
>> +                                         bool set)
>> +{
>> +    target_ulong flags = args[0];
>> +    target_ulong lpid = args[1];
>> +    target_ulong vcpuid = args[2];
>> +    target_ulong buf = args[3];
>> +    target_ulong buflen = args[4];
>> +    struct guest_state_request gsr;
>> +    SpaprMachineStateNestedGuest *guest;
>> +
>> +    guest = spapr_get_nested_guest(spapr, lpid);
>> +    if (!guest) {
>> +        return H_P2;
>> +    }
>> +    gsr.buf = buf;
>> +    gsr.len = buflen;
>> +    gsr.flags = 0;
> 
> Not a big fan of packaging up some args into a structure,
> especially if it's pretty static to a file and no need to be
> carried around with some data. Do you even need this gsr
> thing?

IMHO, it makes sense to keep related meta-data together for a guest 
state request in this case. It also helps reducing the number of args 
being passed to multiple helper routines down the path, each of which 
may use one or more of its members. If you have strong objections for 
better reasons, I am willing to revisit this.

> 
>> +    if (flags & H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
>> +        gsr.flags |= GUEST_STATE_REQUEST_GUEST_WIDE;
>> +    }
>> +    if (flags & !H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
>> +        return H_PARAMETER; /* flag not supported yet */
>> +    }
>> +
>> +    if (set) {
>> +        gsr.flags |= GUEST_STATE_REQUEST_SET;
>> +    }
>> +    return map_and_getset_state(cpu, guest, vcpuid, &gsr);
>> +}
>> +
>> +static target_ulong h_guest_set_state(PowerPCCPU *cpu,
>> +                                      SpaprMachineState *spapr,
>> +                                      target_ulong opcode,
>> +                                      target_ulong *args)
>> +{
>> +    return h_guest_getset_state(cpu, spapr, args, true);
>> +}
>> +
>> +static target_ulong h_guest_get_state(PowerPCCPU *cpu,
>> +                                      SpaprMachineState *spapr,
>> +                                      target_ulong opcode,
>> +                                      target_ulong *args)
>> +{
>> +    return h_guest_getset_state(cpu, spapr, args, false);
>> +}
>> +
>>   void spapr_register_nested(void)
>>   {
>>       spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
>> @@ -1122,6 +1387,8 @@ void spapr_register_nested_phyp(void)
>>       spapr_register_hypercall(H_GUEST_SET_CAPABILITIES, h_guest_set_capabilities);
>>       spapr_register_hypercall(H_GUEST_CREATE          , h_guest_create);
>>       spapr_register_hypercall(H_GUEST_CREATE_VCPU     , h_guest_create_vcpu);
>> +    spapr_register_hypercall(H_GUEST_SET_STATE       , h_guest_set_state);
>> +    spapr_register_hypercall(H_GUEST_GET_STATE       , h_guest_get_state);
>>   }
>>   
>>   #else
>> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
>> index 3c0d6a486e..eaee624b87 100644
>> --- a/include/hw/ppc/spapr_nested.h
>> +++ b/include/hw/ppc/spapr_nested.h
>> @@ -206,6 +206,9 @@
>>   #define HVMASK_MSR            0xEBFFFFFFFFBFEFFF
>>   #define HVMASK_HDEXCR         0x00000000FFFFFFFF
>>   #define HVMASK_TB_OFFSET      0x000000FFFFFFFFFF
>> +#define H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE 0x8000000000000000 /* BE in GSB */
>> +#define GUEST_STATE_REQUEST_GUEST_WIDE       0x1
>> +#define GUEST_STATE_REQUEST_SET              0x2
>>   
>>   #define GUEST_STATE_ELEMENT(i, sz, s, f, ptr, c) { \
>>       .id = (i),                                     \
>> @@ -336,6 +339,25 @@ struct guest_state_element_type {
>>       uint64_t mask;
>>   };
>>   
>> +struct guest_state_element {
>> +    uint16_t id;   /* Big Endian */
>> +    uint16_t size; /* Big Endian */
>> +    uint8_t value[]; /* Big Endian (based on size above) */
>> +} QEMU_PACKED;
>> +
>> +struct guest_state_buffer {
>> +    uint32_t num_elements; /* Big Endian */
>> +    struct guest_state_element elements[];
>> +} QEMU_PACKED;
> 
> I think it's probably enough to add one comment saying the PAPR
> API numbers are all in BE format. This is actually expected of PAPR
> so it goes without saying really, but the nested HV API actually had
> some things in guest endian format so it's worth calling out.
> 
> Actually maybe single out the nested HV structures as different. I
> don't know if the upstream code actually handles endian properly...
> 

Sure, removing all BE related comments for now for changes in this series.

regards,
Harsh

> Thanks,
> Nick
> 
>> +
>> +/* Actuall buffer plus some metadata about the request */
>> +struct guest_state_request {
>> +    struct guest_state_buffer *gsb;
>> +    int64_t buf;
>> +    int64_t len;
>> +    uint16_t flags;
>> +};
>> +
>>   /*
>>    * Register state for entering a nested guest with H_ENTER_NESTED.
>>    * New member must be added at the end.
> 

