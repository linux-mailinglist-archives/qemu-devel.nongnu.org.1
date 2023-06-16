Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 705EC732670
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 06:59:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA1XG-0007kS-Ii; Fri, 16 Jun 2023 00:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qA1XE-0007jv-0f; Fri, 16 Jun 2023 00:58:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qA1XB-0005nI-UK; Fri, 16 Jun 2023 00:58:07 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35G4uXjW005362; Fri, 16 Jun 2023 04:58:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mt6gvq7oYfSsCMxU+vcrNt4LRIyZ08ZDSpTp2603a0o=;
 b=BI4HVg0OAXxRTSCyIP4jkjT3g+fMtw2FGpO90mstiYvgz0wIDUmILjH+sZ8hR59y3AcJ
 IgpaQy16uPv957vQhqSbe17hfiW6Vv8eEF8yltPnwRerJpn0tSSOBIHOGESZ/aq5dBNr
 U5ncPesPrfg+utlTOyVAfgUguE7RomJTUzBjTO/OIApugqMBpwPWSoaWynbxnBH5uDOi
 VUng7nwbxgiY7eEmBvdfprddwthY4bFCsdyJmxYoq3ywdNGRHXVvftY/B7s/ke692CH9
 k4SOrfgCFcmiEZ3HE6q2fdNwzPHmMFv0JmncFZShVvWOwVVw6yneL8NhK3zEIIcGhiYk Sg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r8h5e00y9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Jun 2023 04:58:01 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35G4ux61006842;
 Fri, 16 Jun 2023 04:58:01 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r8h5e00xy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Jun 2023 04:58:01 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35FJFQJh030230;
 Fri, 16 Jun 2023 04:58:00 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
 by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3r4gt51tr7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Jun 2023 04:58:00 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35G4vxXA57016784
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Jun 2023 04:57:59 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 29F2D58051;
 Fri, 16 Jun 2023 04:57:59 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 684535805A;
 Fri, 16 Jun 2023 04:57:57 +0000 (GMT)
Received: from [9.171.16.45] (unknown [9.171.16.45])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 16 Jun 2023 04:57:57 +0000 (GMT)
Message-ID: <b36dae31-d1e1-629b-485b-75442ee2b13e@linux.ibm.com>
Date: Fri, 16 Jun 2023 10:27:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/4] ppc/spapr: Move spapr nested HV to a new file
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20230608091344.88685-1-npiggin@gmail.com>
 <20230608091344.88685-5-npiggin@gmail.com>
 <497ec7c7-2f8e-fb79-92dd-077fa12957af@linux.ibm.com>
 <CTD7AE00VYIP.2IPHRORV44U1P@wheely>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CTD7AE00VYIP.2IPHRORV44U1P@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Re-SDm2ZYXaxhd7EHXR04GzXEG-l8bIF
X-Proofpoint-GUID: gQ_mi8Gz1hzwXhQD5wGLVp7LeAG_aktb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_02,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160041
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 6/15/23 17:21, Nicholas Piggin wrote:
> On Thu Jun 15, 2023 at 4:30 PM AEST, Harsh Prateek Bora wrote:
>>
>>
>> On 6/8/23 14:43, Nicholas Piggin wrote:
>>> Create spapr_nested.c for most of the nested HV implementation.
>>>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>>    hw/ppc/meson.build     |   1 +
>>>    hw/ppc/spapr_hcall.c   | 415 +---------------------------------
>>>    hw/ppc/spapr_nested.c  | 496 +++++++++++++++++++++++++++++++++++++++++
>>>    include/hw/ppc/spapr.h |  61 +----
>>>    4 files changed, 499 insertions(+), 474 deletions(-)
>>>    create mode 100644 hw/ppc/spapr_nested.c
> 
> [snip]
> 
>>> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
>>> new file mode 100644
>>> index 0000000000..c06dd8903c
>>> --- /dev/null
>>> +++ b/hw/ppc/spapr_nested.c
>>> @@ -0,0 +1,496 @@
>>> +#include "qemu/osdep.h"
>>> +#include "qemu/cutils.h"
>>> +#include "exec/exec-all.h"
>>> +#include "helper_regs.h"
>>> +#include "hw/ppc/ppc.h"
>>> +#include "hw/ppc/spapr.h"
>>> +#include "hw/ppc/spapr_cpu_core.h"
>>> +
>>> +/*
>>> + * Register state for entering a nested guest with H_ENTER_NESTED.
>>> + * New member must be added at the end.
>>> + */
>>> +struct kvmppc_hv_guest_state {
>>> +    uint64_t version;      /* version of this structure layout, must be first */
>>> +    uint32_t lpid;
>>> +    uint32_t vcpu_token;
>>> +    /* These registers are hypervisor privileged (at least for writing) */
>>> +    uint64_t lpcr;
>>> +    uint64_t pcr;
>>> +    uint64_t amor;
>>> +    uint64_t dpdes;
>>> +    uint64_t hfscr;
>>> +    int64_t tb_offset;
>>> +    uint64_t dawr0;
>>> +    uint64_t dawrx0;
>>> +    uint64_t ciabr;
>>> +    uint64_t hdec_expiry;
>>> +    uint64_t purr;
>>> +    uint64_t spurr;
>>> +    uint64_t ic;
>>> +    uint64_t vtb;
>>> +    uint64_t hdar;
>>> +    uint64_t hdsisr;
>>> +    uint64_t heir;
>>> +    uint64_t asdr;
>>> +    /* These are OS privileged but need to be set late in guest entry */
>>> +    uint64_t srr0;
>>> +    uint64_t srr1;
>>> +    uint64_t sprg[4];
>>> +    uint64_t pidr;
>>> +    uint64_t cfar;
>>> +    uint64_t ppr;
>>> +    /* Version 1 ends here */
>>> +    uint64_t dawr1;
>>> +    uint64_t dawrx1;
>>> +    /* Version 2 ends here */
>>> +};
>>> +
>>> +/* Latest version of hv_guest_state structure */
>>> +#define HV_GUEST_STATE_VERSION  2
>>> +
>>> +/* Linux 64-bit powerpc pt_regs struct, used by nested HV */
>>> +struct kvmppc_pt_regs {
>>> +    uint64_t gpr[32];
>>> +    uint64_t nip;
>>> +    uint64_t msr;
>>> +    uint64_t orig_gpr3;    /* Used for restarting system calls */
>>> +    uint64_t ctr;
>>> +    uint64_t link;
>>> +    uint64_t xer;
>>> +    uint64_t ccr;
>>> +    uint64_t softe;        /* Soft enabled/disabled */
>>> +    uint64_t trap;         /* Reason for being here */
>>> +    uint64_t dar;          /* Fault registers */
>>> +    uint64_t dsisr;        /* on 4xx/Book-E used for ESR */
>>> +    uint64_t result;       /* Result of a system call */
>>> +};
>>
>> Now that we have a separated spapr_nested.c for nested related code,
>> Can above definitions and other nested related defines (like struct
>> nested_ppc_state below) be moved to a new spapr_nested.h as well?
>> Otherwise, looks good to me.
> 
> They're private to this file, so do we need to? I'm on the fence about
> it, maybe because they're hcall ABI. I don't object to adding a new
> spapr_nested.h for nested related things in general though.
> 

Yeh, I would recommend moving nested specific declarations to 
spapr_nested.h as would be more organized.

Thanks
Harsh

> Thanks,
> Nick

