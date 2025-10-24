Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6F0C055C3
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Oct 2025 11:34:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCEBI-0001T8-8t; Fri, 24 Oct 2025 05:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1vCEBG-0001Sd-JR; Fri, 24 Oct 2025 05:33:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1vCEBE-0004N9-KW; Fri, 24 Oct 2025 05:33:54 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NJFiYS002342;
 Fri, 24 Oct 2025 09:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+wR6bE
 gTTa4UhdiZLIjSS8SA9BYKpUmvA8JXKVRZ+hw=; b=IqhebImFTZ9r1dHBqKhJ3P
 hKqRPZbgH5giaH5F2d5ADj3cs3G1cyhC59KZ2giZFSGkWtJkWBRq4wVGwQ+zXt+l
 kGz4M+xXUln1R2Erp1WBVRpaqiTHN+RirT3UgSNGHNy7xAKvSBwaTt5QrFP2cwxd
 MlURNV14/xahdlQ/+UcYDH5UmBNGP4OtWDjENyo4mvI64PY85q+LE9r+9XTRdkJW
 bxj3PxIlU/13DrdAtGjkf/o50N2MY2Z88zr/5o9ixUIaBIhvthtu+wDc4rsWEKQk
 GaRAsldTlQGsGqtbmZGDrFIGEojHn16HDOvzCxDitfgXo89poINAgNmkqp0Z4qgA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cn5kr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 09:33:41 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59O9SJtF029158;
 Fri, 24 Oct 2025 09:33:41 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cn5kq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 09:33:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59O6s5sq011033;
 Fri, 24 Oct 2025 09:33:40 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx1j5e2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 09:33:40 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59O9XeqY33161904
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Oct 2025 09:33:40 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 222F258052;
 Fri, 24 Oct 2025 09:33:40 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 432255805A;
 Fri, 24 Oct 2025 09:33:38 +0000 (GMT)
Received: from [9.124.223.159] (unknown [9.124.223.159])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 24 Oct 2025 09:33:37 +0000 (GMT)
Message-ID: <4af19292-2191-4592-bbaa-8fe48cd0d3e5@linux.ibm.com>
Date: Fri, 24 Oct 2025 15:03:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/ppc/cpu_init: Simplify the setup of the
 TLBxCFG SPR registers
To: Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20251024065726.738005-1-thuth@redhat.com>
 <20251024065726.738005-2-thuth@redhat.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20251024065726.738005-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Siz1o014ZMns67TjuFYJNzKSWDSd3rj2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX9A3RTJioZMbq
 lD2Yl77cgtyhyv8JZ3bLgFvJy6JINh2vFdhc0CrQ3WgFA0GdbUgDo08WQg9tl+UUZROTRMfR3Ar
 OYjtHQqSbUdRoQJBn0GR6hJ3iYKEmSkWFSmxAF10spI73JnkUVCOUJjVllSMDVwoA4IWDytOJfa
 Lk0RU1sgXfciDIr4UzfGfxyXXSH1Ad9Pzg4fAe0TZz5TVSSCtQixQtJkSrTuKl68T+R6w2uRiqa
 8WuYiiiwc5g2GwwbRKScEZWX5afnOuvP7V1uw4v1bm1OqlxAxgbGmPNsdtRl6YHzhZbfArQVWOy
 OCVuvM+YRki3EO0/xdQtw7NyMzvboH+86MNOTYY7GKgGcBh3QduMMATZkUrgl3E/1KhTvo2LAjV
 uhWlLQl8fGSCdzmYsPLDCQzkBpHe0Q==
X-Proofpoint-GUID: lO8nvXdMaVcRrWWiEUHVRAjtXcJjcPZt
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68fb47f5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=A-lGm8-zJQb8mlAFDSgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 10/24/25 12:27, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
>
> The next commit is going to remove init_proc_e200(), which is one of
> the two calling sites of register_BookE206_sprs(). This causes recent
> versions of GCC to inline the register_BookE206_sprs() function into
> the other only remaining calling site, init_proc_e500(), which in
> turn causes some false-positives compiler warnings:
>
>   In file included from ../../devel/qemu/target/ppc/cpu_init.c:46:
>   In function ‘register_BookE206_sprs’,
>       inlined from ‘init_proc_e500’ at ../../devel/qemu/target/ppc/cpu_init.c:2910:5:
>   ../../devel/qemu/target/ppc/cpu_init.c:897:29: error:
>    array subscript 3 is outside array bounds of ‘uint32_t[2]’ {aka ‘unsigned int[2]’}
>    [-Werror=array-bounds=]
>     897 |                      tlbncfg[3]);
>         |                      ~~~~~~~^~~
>   ../../devel/qemu/target/ppc/spr_common.h:61:39: note: in definition of macro ‘spr_register_kvm_hv’
>      61 |                   KVM_ARG(one_reg_id) initial_value)
>         |                                       ^~~~~~~~~~~~~
>   ../../devel/qemu/target/ppc/spr_common.h:77:5: note: in expansion of macro ‘spr_register_kvm’
>      77 |     spr_register_kvm(env, num, name, uea_read, uea_write,                    \
>         |     ^~~~~~~~~~~~~~~~
>   ../../devel/qemu/target/ppc/cpu_init.c:894:9: note: in expansion of macro ‘spr_register’
>     894 |         spr_register(env, SPR_BOOKE_TLB3CFG, "TLB3CFG",
>         |         ^~~~~~~~~~~~
>   ../../devel/qemu/target/ppc/cpu_init.c: In function ‘init_proc_e500’:
>   ../../devel/qemu/target/ppc/cpu_init.c:2809:14: note: at offset 12 into object ‘tlbncfg’ of size 8
>    2809 |     uint32_t tlbncfg[2];
>         |              ^~~~~~~
>   cc1: all warnings being treated as errors
>
> init_proc_e500() only defines "uint32_t tlbncfg[2];", but it is OK since
> it also sets "env->nb_ways = 2", so the code that GCC warns about in
> register_BookE206_sprs() is never reached. Unfortunately, GCC is not smart
> enough to see this, so it emits these warnings.
>
> To fix it, let's simplify the code in register_BookE206_sprs() a little
> bit to set up the SPRs in a loop, so we don't reference the tlbncfg[3]
> entry directly anymore.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   target/ppc/cpu_init.c | 38 ++++++++++++--------------------------
>   1 file changed, 12 insertions(+), 26 deletions(-)
>
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 3aa3aefc136..12c645699e8 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -850,6 +850,13 @@ static void register_BookE206_sprs(CPUPPCState *env, uint32_t mas_mask,
>           SPR_BOOKE_MAS0, SPR_BOOKE_MAS1, SPR_BOOKE_MAS2, SPR_BOOKE_MAS3,
>           SPR_BOOKE_MAS4, SPR_BOOKE_MAS5, SPR_BOOKE_MAS6, SPR_BOOKE_MAS7,
>       };
> +    const char *tlbcfg_names[4] = {
> +        "TLB0CFG", "TLB1CFG", "TLB2CFG", "TLB3CFG",
> +    };
> +    const int tlbcfg_sprn[4] = {
> +        SPR_BOOKE_TLB0CFG, SPR_BOOKE_TLB1CFG,
> +        SPR_BOOKE_TLB2CFG, SPR_BOOKE_TLB3CFG,
> +    };
>       int i;
>   
>       /* TLB assist registers */
> @@ -889,34 +896,13 @@ static void register_BookE206_sprs(CPUPPCState *env, uint32_t mas_mask,
>                    SPR_NOACCESS, SPR_NOACCESS,
>                    &spr_read_generic, SPR_NOACCESS,
>                    mmucfg);
> -    switch (env->nb_ways) {
> -    case 4:
> -        spr_register(env, SPR_BOOKE_TLB3CFG, "TLB3CFG",
> -                     SPR_NOACCESS, SPR_NOACCESS,
> -                     &spr_read_generic, SPR_NOACCESS,
> -                     tlbncfg[3]);
> -        /* Fallthru */
> -    case 3:
> -        spr_register(env, SPR_BOOKE_TLB2CFG, "TLB2CFG",
> -                     SPR_NOACCESS, SPR_NOACCESS,
> -                     &spr_read_generic, SPR_NOACCESS,
> -                     tlbncfg[2]);
> -        /* Fallthru */
> -    case 2:
> -        spr_register(env, SPR_BOOKE_TLB1CFG, "TLB1CFG",
> -                     SPR_NOACCESS, SPR_NOACCESS,
> -                     &spr_read_generic, SPR_NOACCESS,
> -                     tlbncfg[1]);
> -        /* Fallthru */
> -    case 1:
> -        spr_register(env, SPR_BOOKE_TLB0CFG, "TLB0CFG",
> +
> +    assert(env->nb_ways <= ARRAY_SIZE(tlbcfg_names));
> +    for (i = 0; i < env->nb_ways; i++) {
> +        spr_register(env, tlbcfg_sprn[i], tlbcfg_names[i],
>                        SPR_NOACCESS, SPR_NOACCESS,
>                        &spr_read_generic, SPR_NOACCESS,
> -                     tlbncfg[0]);
> -        /* Fallthru */
> -    case 0:
> -    default:
> -        break;
> +                     tlbncfg[i]);
>       }
>   #endif
>   }

