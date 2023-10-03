Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 479137B636E
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:08:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnaQT-0007LQ-I2; Tue, 03 Oct 2023 04:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qnaQR-0007Kh-5d; Tue, 03 Oct 2023 04:06:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qnaQP-0004Yx-2V; Tue, 03 Oct 2023 04:06:38 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3937t3oS024852; Tue, 3 Oct 2023 08:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5Xc9+JPdvYfgsPl7yibZP5RUmmYi8MTEdy+4yC94r9o=;
 b=oIBg76McwYqwVokLAjM1wSfgfh9oVF3in2BRKPDJD5bBZlyVl46WTgjO8Uaw+XcXZw0U
 ONk4F8JWQ/Vmb3guJfGGk37d1G9DpKXWE3C3lc3dpAhbOIFO/UQpDOyB05EwsOIy9i85
 O1suOdrZ/NSL+czBuXMRdedIL60v6TkJKiwyb2ZymODeZqetWzD06RopWKLGc9Ycyo+4
 4pqR+OECPWCiaOaHBTzj2YoSTNGO8MrxYRlkwooPe4i6BjmHpNFTDnzBA1H6KobEpZtp
 vSv+O8HMmz5gjoXDeP9kRjAw52pxg0nFdv1QYr6CG/CyB8/IeZ73H9QDSqiRGhuho6ru 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tgf00gjnu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Oct 2023 08:06:32 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3937v13a030970;
 Tue, 3 Oct 2023 08:06:31 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tgf00gjm1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Oct 2023 08:06:31 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39374JbL005924; Tue, 3 Oct 2023 08:01:30 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tex0sgbdc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Oct 2023 08:01:30 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39381SVe66060704
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Oct 2023 08:01:28 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 94D0758057;
 Tue,  3 Oct 2023 08:01:28 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CFA4C58065;
 Tue,  3 Oct 2023 08:01:25 +0000 (GMT)
Received: from [9.109.242.129] (unknown [9.109.242.129])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  3 Oct 2023 08:01:25 +0000 (GMT)
Message-ID: <5d85b468-4888-15dc-183d-988d7392d219@linux.ibm.com>
Date: Tue, 3 Oct 2023 13:31:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RESEND 14/15] ppc: spapr: Implement nested PAPR hcall -
 H_GUEST_DELETE
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, danielhb413@gmail.com,
 qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, mikey@neuling.org, vaibhav@linux.ibm.com,
 jniethe5@gmail.com, sbhat@linux.ibm.com, kconsul@linux.vnet.ibm.com
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
 <20230906043333.448244-15-harshpb@linux.ibm.com>
 <CVCBZFYKWAJ6.23SX9FTBWFT2J@wheely>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CVCBZFYKWAJ6.23SX9FTBWFT2J@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: A8V_4ksfTLrW2Q8J1-YiNPjCp7gYjnES
X-Proofpoint-ORIG-GUID: XHufUgUZNSzhW3_xiwTuFZmXB9CnDdVK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_04,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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



On 9/7/23 08:01, Nicholas Piggin wrote:
> On Wed Sep 6, 2023 at 2:33 PM AEST, Harsh Prateek Bora wrote:
>> This hcall is used by L1 to delete a guest entry in L0 or can also be
>> used to delete all guests if needed (usually in shutdown scenarios).
> 
> I'd squash with at least the create hcall.

Done.

> 
>>
>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>>   hw/ppc/spapr_nested.c         | 32 ++++++++++++++++++++++++++++++++
>>   include/hw/ppc/spapr_nested.h |  1 +
>>   2 files changed, 33 insertions(+)
>>
>> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
>> index 3605f27115..5afdad4990 100644
>> --- a/hw/ppc/spapr_nested.c
>> +++ b/hw/ppc/spapr_nested.c
>> @@ -1692,6 +1692,37 @@ static void exit_process_output_buffer(PowerPCCPU *cpu,
>>       return;
>>   }
>>   
>> +static target_ulong h_guest_delete(PowerPCCPU *cpu,
>> +                                   SpaprMachineState *spapr,
>> +                                   target_ulong opcode,
>> +                                   target_ulong *args)
>> +{
>> +    target_ulong flags = args[0];
>> +    target_ulong lpid = args[1];
>> +    struct SpaprMachineStateNestedGuest *guest;
>> +
>> +    if (!spapr_get_cap(spapr, SPAPR_CAP_NESTED_PAPR)) {
>> +        return H_FUNCTION;
>> +    }
> 
> If you only register these hcalls when you apply the cap, then you
> don't need to test it, right?
> 
Yes, cleaned up now.

> Open question as to whether it's better to register hcalls when
> enabling such caps, or do the tests for them here. I guess the
> former makes sense.

Yeh, I am inclined towards former as well.

> 
>> +
>> +    /* handle flag deleteAllGuests, remaining bits reserved */
> 
> This comment is confusing. What is flag deleteAllGuests?
> 
This flag, as per spec, if set, should delete all guests and the
provided guestID is ignored. Updating comment to mention the same.

> H_GUEST_DELETE_ALL_MASK? Is that a mask, or a flag?

Flag, Updating it to H_GUEST_DELETE_ALL_FLAG.

> 
>> +    if (flags & ~H_GUEST_DELETE_ALL_MASK) {
>> +        return H_UNSUPPORTED_FLAG;
>> +    } else if (flags & H_GUEST_DELETE_ALL_MASK) {
>> +        g_hash_table_destroy(spapr->nested.guests);
>> +        return H_SUCCESS;
>> +    }
>> +
>> +    guest = g_hash_table_lookup(spapr->nested.guests, GINT_TO_POINTER(lpid));
>> +    if (!guest) {
>> +        return H_P2;
>> +    }
>> +
>> +    g_hash_table_remove(spapr->nested.guests, GINT_TO_POINTER(lpid));
>> +
>> +    return H_SUCCESS;
>> +}
>> +
>>   void spapr_register_nested(void)
>>   {
>>       spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
>> @@ -1709,6 +1740,7 @@ void spapr_register_nested_phyp(void)
>>       spapr_register_hypercall(H_GUEST_SET_STATE       , h_guest_set_state);
>>       spapr_register_hypercall(H_GUEST_GET_STATE       , h_guest_get_state);
>>       spapr_register_hypercall(H_GUEST_RUN_VCPU        , h_guest_run_vcpu);
>> +    spapr_register_hypercall(H_GUEST_DELETE          , h_guest_delete);
>>   }
>>   
>>   #else
>> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
>> index ca5d28c06e..9eb43778ad 100644
>> --- a/include/hw/ppc/spapr_nested.h
>> +++ b/include/hw/ppc/spapr_nested.h
>> @@ -209,6 +209,7 @@
>>   #define H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE 0x8000000000000000 /* BE in GSB */
>>   #define GUEST_STATE_REQUEST_GUEST_WIDE       0x1
>>   #define GUEST_STATE_REQUEST_SET              0x2
>> +#define H_GUEST_DELETE_ALL_MASK              0x8000000000000000ULL
>>   
>>   #define GUEST_STATE_ELEMENT(i, sz, s, f, ptr, c) { \
>>       .id = (i),                                     \
> 

