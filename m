Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAD679A3D1
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:48:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfaiC-0006EE-6p; Mon, 11 Sep 2023 02:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qfai9-00068k-GN; Mon, 11 Sep 2023 02:47:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qfai6-0005Ro-O0; Mon, 11 Sep 2023 02:47:53 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38B6dMMJ024725; Mon, 11 Sep 2023 06:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=B32OWzzhNsV2aQRRgXmbWXRrTK9cdJBEXnJvq3Nk54A=;
 b=D446Kfsw2CvZJMTUSfbPURZCBbMyj91UVqhaZTWoTFECLoKTNEEHN8Riu47CgGaKSuTW
 jAmGngiUbmrbW90a7hkG7uDV8hv5wOs8aPOiu4yNiMw7CrgaHRr4wE4Ze7pWu4R2so5z
 dXWfkPoJP4KcyxEib0+xHue2mXEukdo8l0l1HWxQIUBgSvU3nlteon2ef1+bqKDeNZWT
 4iSxuRaVmg4tDUkEtpWCHbWzTzhPSAVXwpmIh+C2EJ6qfYTiYayIDNvigPzCqO+t05m3
 lMcB09lQjeyeG6DMbaoH8pNaltg1bXbCSO91nlfm+8u2Mjs5SpPXeg2P5VFuADBZDipG aw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t1m3p9tyc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 06:47:45 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38B6jT77013102;
 Mon, 11 Sep 2023 06:47:44 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t1m3p9ty0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 06:47:44 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38B6Z6Pc024034; Mon, 11 Sep 2023 06:47:44 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t131srv5n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 06:47:43 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38B6lgQm7996060
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Sep 2023 06:47:42 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA73F58045;
 Mon, 11 Sep 2023 06:47:42 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FC1358050;
 Mon, 11 Sep 2023 06:47:38 +0000 (GMT)
Received: from [9.195.37.147] (unknown [9.195.37.147])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 11 Sep 2023 06:47:37 +0000 (GMT)
Message-ID: <913a8994-57df-fdb1-8e0a-2900e16d47fb@linux.ibm.com>
Date: Mon, 11 Sep 2023 12:17:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RESEND 02/15] ppc: spapr: Add new/extend structs to
 support Nested PAPR API
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, danielhb413@gmail.com,
 qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, mikey@neuling.org, vaibhav@linux.ibm.com,
 jniethe5@gmail.com, sbhat@linux.ibm.com, kconsul@linux.vnet.ibm.com
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
 <20230906043333.448244-3-harshpb@linux.ibm.com>
 <CVCA6OLHLKVI.2IH1W8J3WBXFY@wheely>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CVCA6OLHLKVI.2IH1W8J3WBXFY@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XjVpXGT_I_2b80wMAniPdDQ90H_muDDR
X-Proofpoint-GUID: Xcl1KPLA01RpoAHOvTJeZ9X6rHEa0C_m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110059
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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



On 9/7/23 06:36, Nicholas Piggin wrote:
> On Wed Sep 6, 2023 at 2:33 PM AEST, Harsh Prateek Bora wrote:
>> This patch introduces new data structures to be used with Nested PAPR
>> API. Also extends kvmppc_hv_guest_state with additional set of registers
>> supported with nested PAPR API.
>>
>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>>   include/hw/ppc/spapr_nested.h | 48 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>
>> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
>> index 5cb668dd53..f8db31075b 100644
>> --- a/include/hw/ppc/spapr_nested.h
>> +++ b/include/hw/ppc/spapr_nested.h
>> @@ -189,6 +189,39 @@
>>   /* End of list of Guest State Buffer Element IDs */
>>   #define GSB_LAST                GSB_VCPU_SPR_ASDR
>>   
>> +typedef struct SpaprMachineStateNestedGuest {
>> +    unsigned long vcpus;
>> +    struct SpaprMachineStateNestedGuestVcpu *vcpu;
>> +    uint64_t parttbl[2];
>> +    uint32_t pvr_logical;
>> +    uint64_t tb_offset;
>> +} SpaprMachineStateNestedGuest;
>> +
>> +struct SpaprMachineStateNested {
>> +
>> +    uint8_t api;
>> +#define NESTED_API_KVM_HV  1
>> +#define NESTED_API_PAPR    2
>> +    uint64_t ptcr;
>> +    uint32_t lpid_max;
>> +    uint32_t pvr_base;
>> +    bool capabilities_set;
>> +    GHashTable *guests;
>> +};
>> +
>> +struct SpaprMachineStateNestedGuestVcpuRunBuf {
>> +    uint64_t addr;
>> +    uint64_t size;
>> +};
>> +
>> +typedef struct SpaprMachineStateNestedGuestVcpu {
>> +    bool enabled;
>> +    struct SpaprMachineStateNestedGuestVcpuRunBuf runbufin;
>> +    struct SpaprMachineStateNestedGuestVcpuRunBuf runbufout;
>> +    CPUPPCState env;
>> +    int64_t tb_offset;
>> +    int64_t dec_expiry_tb;
>> +} SpaprMachineStateNestedGuestVcpu;
>>   
>>   /*
>>    * Register state for entering a nested guest with H_ENTER_NESTED.
>> @@ -228,6 +261,21 @@ struct kvmppc_hv_guest_state {
>>       uint64_t dawr1;
>>       uint64_t dawrx1;
>>       /* Version 2 ends here */
>> +    uint64_t dec;
>> +    uint64_t fscr;
>> +    uint64_t fpscr;
>> +    uint64_t bescr;
>> +    uint64_t ebbhr;
>> +    uint64_t ebbrr;
>> +    uint64_t tar;
>> +    uint64_t dexcr;
>> +    uint64_t hdexcr;
>> +    uint64_t hashkeyr;
>> +    uint64_t hashpkeyr;
>> +    uint64_t ctrl;
>> +    uint64_t vscr;
>> +    uint64_t vrsave;
>> +    ppc_vsr_t vsr[64];
>>   };
> 
> Why? I can't see where it's used... This is API for the original HV
> hcalls which is possibly now broken because the code uses sizeof()
> when mapping it.

Yeh, I had realised after posting the patches to cleanup these 
leftovers. Please ignore these additions, shall be removed.

> 
> In general I'm not a fan of splitting patches by the type of code they
> add. Definitions for external APIs okay. But for things like internal
> structures I prefer added where they are introduced.
> 
Make sense, I shall revisit and move declarations wherever used first.

> It's actually harder to review a patch if related / dependent changes
> aren't in it, IMO. What should be split is unrelated or independent
> changes and logical steps. Same goes for hcalls too actually. Take a
> look at the series that introduced nested HV. 120f738a467 adds all the
> hcalls, all the structures, etc.
> 
> So I would also hink about squashing at least get/set capabilities
> hcalls together, and guest create/delete, and probably vcpu create/run.

Hmm, I think we can keep get/set capab, guest create/delete together as
you suggested. We may want to keep vcpu_run separate as it has
significant changes, to keep it easier for review?
Let me know if you think otherwise.

regards,
Harsh

> 
> Thanks,
> Nick

