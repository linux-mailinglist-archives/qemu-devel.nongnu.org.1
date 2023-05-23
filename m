Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B41270E5E6
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 21:46:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1XwS-0004rT-Sa; Tue, 23 May 2023 15:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.vnet.ibm.com>)
 id 1q1WUT-0004Eq-UD; Tue, 23 May 2023 14:12:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.vnet.ibm.com>)
 id 1q1WUR-0000d3-KA; Tue, 23 May 2023 14:12:09 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34NI91us012694; Tue, 23 May 2023 18:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : references : cc : reply-to : from :
 in-reply-to : content-type : content-transfer-encoding; s=pp1;
 bh=sgfW3qs5gywvMnVSI8oFIGndVdthQAWATzdmeiEybfs=;
 b=sUzjY8//fTZ1BZ9uLcrPfW07DW9w3ZbH48MCVkCjvowfWytXbHpxMilePwFfrIYBeSxd
 eV8sjzS0IChlqMi8x1HQsDxMPeNED+E/1OPCZv1QG7A1UUty9I/kbHpvIaEF9rfjkxBx
 1oj1y/5nGsiNLiQtj8E64VRZ9NU2F0fUcNIMjvrC7dqIrk82zs8wk0XuDfPtvleSOqYq
 eMfb+C7xdTXy5TvBTSJ/iRPow+1wt9IhLWFEU8cT17KnHVcONXwOFFmuBy2ewJC6IDV9
 Dis5xgrKjMAZMmM0mG+zVN/3+Tc2y0UPouE1jao7j6i0gjsiIVAiCM4DXrVvwCCYIt77 hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qs1d81rrf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 May 2023 18:12:02 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34NI9oml014889;
 Tue, 23 May 2023 18:12:02 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qs1d81rqh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 May 2023 18:12:02 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34NFZhhZ010757;
 Tue, 23 May 2023 18:12:01 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
 by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3qppds0c8p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 May 2023 18:12:01 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34NIC0pS41484622
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 May 2023 18:12:00 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F105358061;
 Tue, 23 May 2023 18:11:59 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 00D2A58053;
 Tue, 23 May 2023 18:11:58 +0000 (GMT)
Received: from [9.160.114.29] (unknown [9.160.114.29])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 May 2023 18:11:57 +0000 (GMT)
Message-ID: <81a9d6ae-8163-13e0-120b-d794312abdb3@linux.vnet.ibm.com>
Date: Tue, 23 May 2023 23:41:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/6] target/ppc: Fix instruction loading endianness in
 alignment interrupt
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
References: <20230327131218.2721044-3-npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
From: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
In-Reply-To: <20230327131218.2721044-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rJb-TXlfVg_cPnrD1r64jHtWjjZnzfT6
X-Proofpoint-GUID: I3A1J0al6j8BKqG_khFTkQKVDRaa_fbd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_11,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 mlxlogscore=663 suspectscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230145
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=anushree.mathur@linux.vnet.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_REPLYTO=2.095,
 NICE_REPLY_A=-0.089, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 23 May 2023 15:45:04 -0400
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
Reply-To: 20230327131218.2721044-3-npiggin@gmail.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


On 3/27/23 18:42, Nicholas Piggin wrote:
> powerpc ifetch endianness depends on MSR[LE] so it has to byteswap
> after cpu_ldl_code(). This corrects DSISR bits in alignment
> interrupts when running in little endian mode.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> ---
> Since v1:
> - Removed big endian ifdef [Fabiano review]
> - Acaually use need_byswap helper.
>
>   target/ppc/excp_helper.c | 20 +++++++++++++++++++-
>   1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 287659c74d..07729967b5 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -133,6 +133,24 @@ static void dump_hcall(CPUPPCState *env)
>                     env->nip);
>   }
>   
> +/* Return true iff byteswap is needed in a scalar memop */
> +static inline bool need_byteswap(CPUArchState *env)
> +{
> +    /* SOFTMMU builds TARGET_BIG_ENDIAN. Need to swap when MSR[LE] is set */
> +    return !!(env->msr & ((target_ulong)1 << MSR_LE));
> +}
> +
> +static uint32_t ppc_ldl_code(CPUArchState *env, abi_ptr addr)

This hunk fails to compile with configure --disable-tcg

FAILED: libqemu-ppc64-softmmu.fa.p/target_ppc_excp_helper.c.o
cc -m64 -mlittle-endian -Ilibqemu-ppc64-softmmu.fa.p -I. -I.. 
-Itarget/ppc -I../target/ppc -I../dtc/libfdt -Iqapi -Itrace -Iui 
-Iui/shader -I/usr/include/pixman-1 -I/usr/include/glib-2.0 
-I/usr/lib64/glib-2.0/include -I/usr/include/sysprof-4 
-fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu11 -O2 -g 
-fstack-protector-strong -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -Wundef 
-Wwrite-strings -Wmissing-prototypes -Wstrict-prototypes 
-Wredundant-decls -Wold-style-declaration -Wold-style-definition 
-Wtype-limits -Wformat-security -Wformat-y2k -Winit-self 
-Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-labels 
-Wexpansion-to-defined -Wimplicit-fallthrough=2 
-Wmissing-format-attribute -Wno-missing-include-dirs 
-Wno-shift-negative-value -Wno-psabi -isystem 
/home/Shreya/qemu/linux-headers -isystem linux-headers -iquote . -iquote 
/home/Shreya/qemu -iquote /home/Shreya/qemu/include -pthread 
-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE 
-fno-strict-aliasing -fno-common -fwrapv -fPIE -isystem../linux-headers 
-isystemlinux-headers -DNEED_CPU_H 
'-DCONFIG_TARGET="ppc64-softmmu-config-target.h"' 
'-DCONFIG_DEVICES="ppc64-softmmu-config-devices.h"' -MD -MQ 
libqemu-ppc64-softmmu.fa.p/target_ppc_excp_helper.c.o -MF 
libqemu-ppc64-softmmu.fa.p/target_ppc_excp_helper.c.o.d -o 
libqemu-ppc64-softmmu.fa.p/target_ppc_excp_helper.c.o -c 
../target/ppc/excp_helper.c
../target/ppc/excp_helper.c:143:49: error: unknown type name ‘abi_ptr’; 
did you mean ‘si_ptr’?
   143 | static uint32_t ppc_ldl_code(CPUArchState *env, abi_ptr addr)
       |                                                 ^~~~~~~
       |                                                 si_ptr
../target/ppc/excp_helper.c: In function ‘powerpc_excp_books’:
../target/ppc/excp_helper.c:1416:16: error: implicit declaration of 
function ‘ppc_ldl_code’ [-Werror=implicit-function-declaration]
  1416 |         insn = ppc_ldl_code(env, env->nip);
       |                ^~~~~~~~~~~~
../target/ppc/excp_helper.c:1416:16: error: nested extern declaration of 
‘ppc_ldl_code’ [-Werror=nested-externs]
cc1: all warnings being treated as errors

> +{
> +    uint32_t insn = cpu_ldl_code(env, addr);
> +
> +    if (need_byteswap(env)) {
> +        insn = bswap32(insn);
> +    }
> +
> +    return insn;
> +}
> +
>   static void ppc_excp_debug_sw_tlb(CPUPPCState *env, int excp)
>   {
>       const char *es;
> @@ -3097,7 +3115,7 @@ void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
>   
>       /* Restore state and reload the insn we executed, for filling in DSISR.  */
>       cpu_restore_state(cs, retaddr);
> -    insn = cpu_ldl_code(env, env->nip);
> +    insn = ppc_ldl_code(env, env->nip);
>   
>       switch (env->mmu_model) {
>       case POWERPC_MMU_SOFT_4xx:

Thanks

Anushree Mathur


