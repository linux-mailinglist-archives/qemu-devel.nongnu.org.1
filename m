Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8015A7B7C19
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:28:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnyAv-00030J-Ul; Wed, 04 Oct 2023 05:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qnyAl-0002z6-PW; Wed, 04 Oct 2023 05:28:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qnyAj-0007is-MA; Wed, 04 Oct 2023 05:28:03 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3949OZLT020527; Wed, 4 Oct 2023 09:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=U8/5sRk4Qnz2DMjOYNBhruainJZfS68vQrHRPHdVczU=;
 b=FmYeEp9YEyXlMja+Mcu4Us/cvU8L716TIUmhm/VimBI0RqRkl7z7wZHD4xb5ZphUmZUk
 nqS494AWZRh4uYFIRN1/mWcr4J1Bqe8tUQkUVkj4mpkCysryM/7wA3Nq1/azHk/jTomi
 +K3us5whoiG1gr/nJ8dVYwNMuMgnmGV2UD+6fh7sw6YLDd9Id1ha8W/h3QHFF1AmZ5Ch
 ax+DIF/xWCW+VSNK0OXe2+2D52fnPLGUXSR6vodfRDrx7dkoFZCzAgrgcUJsYqXEyuxZ
 lVtb0WZDgrBiqg3Sosz2QF32RNI3AAhd8YcsQe1igUa3S/5egH3V3cTdoaGIxjTnjlE1 bg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3th5cy01yp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 09:27:54 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3949PRwb022283;
 Wed, 4 Oct 2023 09:27:54 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3th5cy01yf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 09:27:54 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3949RkrF007437; Wed, 4 Oct 2023 09:27:53 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3teygkj98q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 09:27:53 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3949RqF753412204
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Oct 2023 09:27:52 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 803315805F;
 Wed,  4 Oct 2023 09:27:52 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E25B358054;
 Wed,  4 Oct 2023 09:27:48 +0000 (GMT)
Received: from [9.43.72.102] (unknown [9.43.72.102])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Oct 2023 09:27:48 +0000 (GMT)
Message-ID: <3fc620bf-c43e-248b-ad4a-9a69812ca235@linux.ibm.com>
Date: Wed, 4 Oct 2023 14:57:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RESEND 10/15] ppc: spapr: Initialize the GSB Elements
 lookup table.
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, danielhb413@gmail.com,
 qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, mikey@neuling.org, vaibhav@linux.ibm.com,
 jniethe5@gmail.com, sbhat@linux.ibm.com, kconsul@linux.vnet.ibm.com
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
 <20230906043333.448244-11-harshpb@linux.ibm.com>
 <CVCCMLRLPB9H.3T7JJ2S044E0I@wheely>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CVCCMLRLPB9H.3T7JJ2S044E0I@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zDSRu3ZrF2N_CAO6kCFfnvYpTcxCOGDp
X-Proofpoint-ORIG-GUID: rY9WNQV8xhSCsCpzTlQ7LnRHlRDl7HU8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 impostorscore=0 spamscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040060
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 9/7/23 08:31, Nicholas Piggin wrote:
> Might be good to add a common nested: prefix to all patches actually.
> 
Noted.

> On Wed Sep 6, 2023 at 2:33 PM AEST, Harsh Prateek Bora wrote:
>> This is a first step towards enabling support for nested PAPR hcalls for
>> providing the get/set of various Guest State Buffer (GSB) elements via
>> h_guest_[g|s]et_state hcalls. This enables for identifying correct
>> callbacks for get/set for each of the elements supported via
>> h_guest_[g|s]et_state hcalls, support for which is added in next patch.
> 
> Changelog could use work.
> 
Sure, will update.

>>
>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>>   hw/ppc/spapr_hcall.c          |   1 +
>>   hw/ppc/spapr_nested.c         | 487 ++++++++++++++++++++++++++++++++++
>>   include/hw/ppc/ppc.h          |   2 +
>>   include/hw/ppc/spapr_nested.h | 102 +++++++
>>   4 files changed, 592 insertions(+)
>>
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index 9b1f225d4a..ca609cb5a4 100644
>> --- a/hw/ppc/spapr_hcall.c
>> +++ b/hw/ppc/spapr_hcall.c
>> @@ -1580,6 +1580,7 @@ static void hypercall_register_types(void)
>>       spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
>>   
>>       spapr_register_nested();
>> +    init_nested();
> 
> This is for hcall registration, not general subsystem init I think.
> Arguably not sure if it matters, it just looks odd for everything
> else to be an hcall except this. I would just add a new init
> function.

I have introduced a new spapr_nested_init routine in spapr_nested.c 
which shall be called from spapr_instance_init. I think we can move GSB 
init there.

> 
> And actually now I look closer at this, I would not do your papr
> hcall init in the cap apply function, if it is possible to do
> inside spapr_register_nested(), then that function could look at
> which caps are enabled and register the appropriate hcalls. Then
> no change to move this into cap code.
> 

IIRC, I had initially tried that during early development but faced 
runtime issues with spapr init at this stage, which is needed to 
identify nested.api. However, keeping cap specific registration in cap
apply function made more sense to me. Further optimizations can be taken 
up later though.

>>   }
>>   
>>   type_init(hypercall_register_types)
>> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
>> index e7956685af..6fbb1bcb02 100644
>> --- a/hw/ppc/spapr_nested.c
>> +++ b/hw/ppc/spapr_nested.c
> 
> [snip]
> 
> My eyes are going square, I'll review this later.
> 

Sure.

>> diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
>> index e095c002dc..d7acc28d17 100644
>> --- a/include/hw/ppc/ppc.h
>> +++ b/include/hw/ppc/ppc.h
>> @@ -33,6 +33,8 @@ struct ppc_tb_t {
>>       QEMUTimer *decr_timer;
>>       /* Hypervisor decrementer management */
>>       uint64_t hdecr_next;    /* Tick for next hdecr interrupt  */
>> +    /* TB that HDEC should fire and return ctrl back to the Host partition */
>> +    uint64_t hdecr_expiry_tb;
> 
> Why is this here?

Since there is an existing hypervisor decrementer related variable, it 
appeared appropriate to me to keep it there. Will move it inside
SpaprMachineStateNestedGuestVcpu if that sounds better.

> 
>>       QEMUTimer *hdecr_timer;
>>       int64_t purr_offset;
>>       void *opaque;
>> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
>> index 2e8c6ba1ca..3c0d6a486e 100644
>> --- a/include/hw/ppc/spapr_nested.h
>> +++ b/include/hw/ppc/spapr_nested.h
> 
> [snip]
> 
>>   
>> +struct guest_state_element_type {
>> +    uint16_t id;
>> +    int size;
>> +#define GUEST_STATE_ELEMENT_TYPE_FLAG_GUEST_WIDE 0x1
>> +#define GUEST_STATE_ELEMENT_TYPE_FLAG_READ_ONLY  0x2
>> +   uint16_t flags;
>> +    void *(*location)(SpaprMachineStateNestedGuest *, target_ulong);
>> +    size_t offset;
>> +    void (*copy)(void *, void *, bool);
>> +    uint64_t mask;
>> +};
> 
> I have to wonder whether this is the best way to go. Having
> these indicrect function calls and array of "ops" like this
> might be limiting the compiler. I wonder if it should just
> be done in a switch table, which is how most interpreters
> I've seen (which admittedly is not many) seem to do it.
> 
Hmm, this was chosen after evaluating other approaches as it appeared
better. I think we can move forward with the existing approach and any
further optimizations can be taken up as a follow-up patch.

regards,
Harsh

> Thanks,
> Nick
> 

