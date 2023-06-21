Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 275AA737DFF
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 11:06:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBtmm-0002gr-1p; Wed, 21 Jun 2023 05:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qBtmh-0002fn-Sq; Wed, 21 Jun 2023 05:05:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qBtmc-00081n-Ds; Wed, 21 Jun 2023 05:05:49 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35L8hJSI029082; Wed, 21 Jun 2023 09:04:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=KiuGYSFvMZdi9oFlfHWolbdYLE8I02nagxyVRa/FANU=;
 b=cX1Ytaj1wzldIZ4NmYihr89LRl+QWjnO8HrJmITAO6cP5y/YEudbS8uqyaOORktpHLZi
 ydg3C2AnRWFLeTASbfaLQPkqBCEaKwoZgB/+MWaMIWmFghoncdVjzs5I6vUXRiXqW1ET
 Da/SwESzpZeI+p51gt26K9E1/W0VS9gXfyDWAI+NVLxvN9Ge3qL8aAXq747WbS4h2hRr
 j/Xqh3bwP/6oLfgWDDODwaplZebq//hVBW0TQWiAE1zOE/X5Vb24wqCyEUgzpX6xK08m
 1w3O+Qo914GznFVpJcBYRwot23IDEnPvi/UXRNVY+TCS0DWbnur6QZYQKZjnyucI3Zum oA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rbvpbtes7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 09:04:41 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35L8tqWd026578;
 Wed, 21 Jun 2023 09:04:41 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rbvpbter6-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 09:04:41 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35L8Dtvo028352;
 Wed, 21 Jun 2023 08:31:31 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
 by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3r94f5udtq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 08:31:31 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35L8VUa838273624
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Jun 2023 08:31:31 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C6BBD5806A;
 Wed, 21 Jun 2023 08:31:30 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1088E5805A;
 Wed, 21 Jun 2023 08:31:29 +0000 (GMT)
Received: from [9.109.242.129] (unknown [9.109.242.129])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 21 Jun 2023 08:31:28 +0000 (GMT)
Message-ID: <a3dce513-d55a-7116-c6f8-5d30e4f3d131@linux.ibm.com>
Date: Wed, 21 Jun 2023 14:01:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] target/ppc: Add ISA v3.1 LEV indication in SRR1 for
 system call interrupts
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20230620131321.169261-1-npiggin@gmail.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20230620131321.169261-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pcj2UF_bL7Z-DopRofdXP6-nhOTpQiMM
X-Proofpoint-GUID: zoTtxoOUPvlOkeksuhgftMZ3q0-PblH_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_06,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=958 mlxscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306210071
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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



On 6/20/23 18:43, Nicholas Piggin wrote:
> System call interrupts in ISA v3.1 CPUs add a LEV indication in SRR1
> that corresponds with the LEV field of the instruction that caused the
> interrupt.
> 

Did we encounter any issue without this patch leading to this fix?
If so, it will be great to talk about it in short if possible.

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> This is unchanged, just taken out of the bigger series since it is
> independent.
> 
> Thanks,
> Nick
> 
>   target/ppc/excp_helper.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 77bfc18734..c7550fea13 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -1591,6 +1591,10 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>               vhc->hypercall(cpu->vhyp, cpu);
>               return;
>           }
> +        if (env->insns_flags2 & PPC2_ISA310) {
> +            /* ISAv3.1 puts LEV into SRR1 */
> +            msr |= lev << 20;

Since LEV values greater than 2 are reserved, should we do:
                msr |= (lev <= 2) ? lev << 20 : 0;


Otherwise,
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> +        }
>           if (lev == 1) {
>               new_msr |= (target_ulong)MSR_HVB;
>           }

