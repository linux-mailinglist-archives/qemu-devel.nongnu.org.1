Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D2B732C75
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 11:49:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA64F-0003oA-Sz; Fri, 16 Jun 2023 05:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.vnet.ibm.com>)
 id 1qA64D-0003lY-2H; Fri, 16 Jun 2023 05:48:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.vnet.ibm.com>)
 id 1qA64B-0005yL-2w; Fri, 16 Jun 2023 05:48:28 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35G9icKW026264; Fri, 16 Jun 2023 09:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=W2u+GFE0obWGmDxvmkWUummj68IArO9KHRWhU2cwY9s=;
 b=JrBen/M8DDXhUm1PWb8QF9bEqa1GF1PYeQB8cxL5QfEr4DbYag7WkOWf3aCBk5izcRbU
 S9R+WNLG53ny8kfpDJ/SwV2UrUvJkbNl7cQ4jzaAJn5LNAFzlSKE1EUx5PP30gQhLKdN
 ++kJ/7Zl1qkYDqyjeXX4S8KCfboduyEaFP5ZyIfhwqUK0fNVpBhm1P/HEOv8n33YlZXQ
 dG5NYrbbFgD2Ps9KRSL19MSNzwJqtDhWdeDYzCDB5Eqwpe0vboYbiHyhxN5cbUnfPJPh
 sp0ggHqb54FAtOUWlv5ux46GxUi2Wx+peDicG9RQUdXrDZbY2aRtYUp9j6+4gs2U3Hu7 Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r8n0j8r9j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Jun 2023 09:48:24 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35G9K5YZ028865;
 Fri, 16 Jun 2023 09:48:23 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r8n0j8r9c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Jun 2023 09:48:23 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35G9FIHe027245;
 Fri, 16 Jun 2023 09:48:23 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
 by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3r4gt6ghf3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Jun 2023 09:48:22 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35G9mLqt36176276
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Jun 2023 09:48:21 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 39D6A58062;
 Fri, 16 Jun 2023 09:48:21 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F70758056;
 Fri, 16 Jun 2023 09:48:19 +0000 (GMT)
Received: from [9.109.244.180] (unknown [9.109.244.180])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 16 Jun 2023 09:48:19 +0000 (GMT)
Message-ID: <bac794df-5b42-0170-2f1b-d46bdec55f83@linux.vnet.ibm.com>
Date: Fri, 16 Jun 2023 15:18:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 1/6] target/ppc: Fix instruction loading endianness in
 alignment interrupt
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 harshpb@linux.ibm.com
References: <20230530132543.385138-2-npiggin@gmail.com>
 <0bbbffa7-d66c-66f2-f660-321e4f8aa026@linux.vnet.ibm.com>
 <CTCVSVIX21N6.3V2JEPOBPPX3Q@wheely>
From: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
In-Reply-To: <CTCVSVIX21N6.3V2JEPOBPPX3Q@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: j9A0csFnlBQ46hMs4H2g6ZJWDDPP3Uaz
X-Proofpoint-ORIG-GUID: XaN4qxl9nMlXnZeorrRm4XLlhrq2LMCZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_06,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=857 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160085
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=anushree.mathur@linux.vnet.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 6/15/23 08:21, Nicholas Piggin wrote:
> On Wed Jun 14, 2023 at 3:51 PM AEST, Anushree Mathur wrote:
>> On 5/30/23 18:55, Nicholas Piggin wrote:
>>> powerpc ifetch endianness depends on MSR[LE] so it has to byteswap
>>> after cpu_ldl_code(). This corrects DSISR bits in alignment
>>> interrupts when running in little endian mode.
>>>
>>> Reviewed-by: Fabiano Rosas<farosas@suse.de>
>>> Signed-off-by: Nicholas Piggin<npiggin@gmail.com>
>>> ---
>>>    target/ppc/excp_helper.c | 22 +++++++++++++++++++++-
>>>    1 file changed, 21 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
>>> index c13f2afa04..0274617b4a 100644
>>> --- a/target/ppc/excp_helper.c
>>> +++ b/target/ppc/excp_helper.c
>>> @@ -133,6 +133,26 @@ static void dump_hcall(CPUPPCState *env)
>>>                      env->nip);
>>>    }
>>>    
>>> +#ifdef CONFIG_TCG
>>> +/* Return true iff byteswap is needed in a scalar memop */
>>> +static inline bool need_byteswap(CPUArchState *env)
>>> +{
>>> +    /* SOFTMMU builds TARGET_BIG_ENDIAN. Need to swap when MSR[LE] is set */
>>> +    return !!(env->msr & ((target_ulong)1 << MSR_LE));
>>> +}
>>> +
>>> +static uint32_t ppc_ldl_code(CPUArchState *env, abi_ptr addr)
>> This hunk fails to compile with configure --disable-tcg
> I don't see how since it's inside CONFIG_TCG. Seems to work here.
> You don't have an old version of the patch applied?
>
> What configure options exactly?
>
> Thanks,
> Nick

The configure options i used are:

./configure --target-list=ppc64-softmmu --disable-tcg --prefix=/usr

I applied the latest patches but still i was seeing the same issue. Can 
you check this once!

Thanks,

Anushree-Mathur


