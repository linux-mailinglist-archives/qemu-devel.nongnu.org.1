Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DB5755CF7
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 09:33:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLIiO-0006sg-Ej; Mon, 17 Jul 2023 03:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.vnet.ibm.com>)
 id 1qLIiI-0006rb-50; Mon, 17 Jul 2023 03:32:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.vnet.ibm.com>)
 id 1qLIiE-0008VJ-I6; Mon, 17 Jul 2023 03:32:08 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36H78N2s027299; Mon, 17 Jul 2023 07:31:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=nevCWMqUfEKrdNiM0zvq7d3OqCcPYyqzcG38xhIx9S4=;
 b=hXRAKcRfD5sOD84RCOA3Gii9XMdZ/yArJHEC2Gc9mxvhs52SgAVQc1QnYuFA9IfkjSjV
 MWEzBwKFQ2M7s/jz8lNnSIgX04nYDVOGNjXTenfyMZE3xdAHaZOawBYL4NNcdOQip8SV
 CRaGwjn71onMIrKRP/QuenzGaeHF6fq0PmeTEuko00em95H9+fNeDXhtMp/WrfZmJaMH
 MNHi1GPsUfAzRh+nYh23VU67dQwk6R8LFrZHsOsL2wTuCfTSocl4ZZ8hiMrOTSylcTrk
 7k26G8uD37uSRGuxtyC6fyfqZlutH12tICopPPqOpbpkivXaMgHvrpcoFfF6bm/6S8rE qw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rw0nnh0x9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jul 2023 07:31:52 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36H79vL8030914;
 Mon, 17 Jul 2023 07:31:51 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rw0nnh0wm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jul 2023 07:31:51 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36H4kMVW002855;
 Mon, 17 Jul 2023 07:31:50 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
 by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3ruk35f3gn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jul 2023 07:31:50 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36H7VmNQ29033148
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jul 2023 07:31:48 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E5F85805C;
 Mon, 17 Jul 2023 07:31:48 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4A2358059;
 Mon, 17 Jul 2023 07:31:44 +0000 (GMT)
Received: from [9.171.56.165] (unknown [9.171.56.165])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Jul 2023 07:31:44 +0000 (GMT)
Message-ID: <45d5aedc-d558-79c9-6f64-cfa3e28714d4@linux.vnet.ibm.com>
Date: Mon, 17 Jul 2023 13:01:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] tcg/ppc: Fix race in goto_tb implementation
Content-Language: en-US
To: Jordan Niethe <jniethe5@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org, 
 dbarboza@ventanamicro.com, npiggin@gmail.com, mjt@tls.msk.ru,
 clg@kaod.org, bgray@linux.ibm.com,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20230717012327.20149-1-jniethe5@gmail.com>
From: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
In-Reply-To: <20230717012327.20149-1-jniethe5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nr_-ZwY5vayl88La8kx2Mu2ehOhXk2Gl
X-Proofpoint-GUID: eT6eAKkx_HoAb3ACu4tHK-KLZwDev08d
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_05,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1011
 mlxscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170067
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=anushree.mathur@linux.vnet.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 7/17/23 06:53, Jordan Niethe wrote:
> Commit 20b6643324 ("tcg/ppc: Reorg goto_tb implementation") modified
> goto_tb to ensure only a single instruction was patched to prevent
> incorrect behaviour if a thread was in the middle of multiple
> instructions when they were replaced. However this introduced a race
> between loading the jmp target into TCG_REG_TB and patching and
> executing the direct branch.
>
> The relevent part of the goto_tb implementation:
>
>      ld TCG_REG_TB, TARGET_ADDR_LOCATION(TCG_REG_TB)
>    patch_location:
>      mtctr TCG_REG_TB
>      bctr
>
> tb_target_set_jmp_target() will replace 'patch_location' with a direct
> branch if the target is in range. The direct branch now relies on
> TCG_REG_TB being set up correctly by the ld. Prior to this commit
> multiple instructions were patched in for the direct branch case; these
> instructions would initalise TCG_REG_TB to the same value as the branch
> target.
>
> Imagine the following sequence:
>
> 1) Thread A is executing the goto_tb sequence and loads the jmp
>     target into TCG_REG_TB.
>
> 2) Thread B updates the jmp target address and calls
>     tb_target_set_jmp_target(). This patches a new direct branch into the
>     goto_tb sequence.
>
> 3) Thread A executes the newly patched direct branch. The value in
>     TCG_REG_TB still contains the old jmp target.
>
> TCG_REG_TB MUST contain the translation block's tc.ptr. Execution will
> eventually crash after performing memory accesses generated from a
> faulty value in TCG_REG_TB.
>
> This presents as segfaults or illegal instruction exceptions.
>
> Do not revert commit 20b6643324 as it did fix a different race
> condition. Instead remove the direct branch optimization and always use
> indirect branches.
>
> The direct branch optimization can be re-added later with a race free
> sequence.
>
> Gitlab issue: https://gitlab.com/qemu-project/qemu/-/issues/1726
>
> Fixes: 20b6643324 ("tcg/ppc: Reorg goto_tb implementation")
>
> Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
> Co-developed-by: Benjamin Gray <bgray@linux.ibm.com>
> Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
I tested with -smp 2/4/8/16 and it works fine with all.

Tested-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>

Thanks,

Anushree-Mathur

> ---
>   tcg/ppc/tcg-target.c.inc | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 8d6899cf40..a7323f479b 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -2533,11 +2533,10 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
>           ptrdiff_t offset = tcg_tbrel_diff(s, (void *)ptr);
>           tcg_out_mem_long(s, LD, LDX, TCG_REG_TB, TCG_REG_TB, offset);
>       
> -        /* Direct branch will be patched by tb_target_set_jmp_target. */
> +        /* TODO: Use direct branches when possible. */
>           set_jmp_insn_offset(s, which);
>           tcg_out32(s, MTSPR | RS(TCG_REG_TB) | CTR);
>
> -        /* When branch is out of range, fall through to indirect. */
>           tcg_out32(s, BCCTR | BO_ALWAYS);
>
>           /* For the unlinked case, need to reset TCG_REG_TB.  */
> @@ -2565,10 +2564,11 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
>       intptr_t diff = addr - jmp_rx;
>       tcg_insn_unit insn;
>
> +    if (USE_REG_TB)
> +        return;
> +
>       if (in_range_b(diff)) {
>           insn = B | (diff & 0x3fffffc);
> -    } else if (USE_REG_TB) {
> -        insn = MTSPR | RS(TCG_REG_TB) | CTR;
>       } else {
>           insn = NOP;
>       }

