Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D365A7420B9
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 09:05:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qElhn-00063L-1m; Thu, 29 Jun 2023 03:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qElhi-0005vP-TD; Thu, 29 Jun 2023 03:04:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qElhd-0001Rs-Kp; Thu, 29 Jun 2023 03:04:34 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35T6wumW006662; Thu, 29 Jun 2023 07:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=pXWJaEWqaqgDz9aA6cjIaDLwncdD88Fud5d6zE7oMew=;
 b=GliT57wllNo80blH3HytK70kAvWyH0gB1NseHaO+wDoYKwksTSiCTWGoyfbiBipwg6rQ
 MlP7L+v2hS2+b1PaNz9KQx9g9zQ2mxNTLcBot7M8YHTOuuKY0HY/9BNIjhzFgbyXTjrF
 sSM3xK86MFAYu0iwRh4rarTTMXyscBf46SOivMhpEvz2Eehb5mkrwhjngqgf3GRWtZDz
 1EAtLQhTmVZP0PP0jZM3IobbjVOiwUMzS8nG+qfaGO2HV5unhzAlFDYNySYCztGPg+dy
 A1M2Ar09tDmMnGteB11paa38fMTmnNSXK34UkI81pnR1zMalokL4HOmCB/1bTuxIYSlP Dg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rh55ug3r6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jun 2023 07:04:18 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35T70Ulm011402;
 Thu, 29 Jun 2023 07:04:18 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rh55ug3qd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jun 2023 07:04:18 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35T2pSxA026359;
 Thu, 29 Jun 2023 07:04:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rdqre378b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jun 2023 07:04:16 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35T74E6J43909674
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jun 2023 07:04:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E94CA20040;
 Thu, 29 Jun 2023 07:04:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C3F22004D;
 Thu, 29 Jun 2023 07:04:13 +0000 (GMT)
Received: from [9.171.5.151] (unknown [9.171.5.151])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Jun 2023 07:04:13 +0000 (GMT)
Message-ID: <e793d122-91fd-41ad-7151-b97073ac9753@linux.ibm.com>
Date: Thu, 29 Jun 2023 09:04:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] hw/ppc: Fix clock update drift
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-stable@nongnu.org
References: <20230629020713.327745-1-npiggin@gmail.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <20230629020713.327745-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WbwLKTXrfw2ZEXxauGlUUxsx6vGrM35e
X-Proofpoint-GUID: BsO7PP3tjXEAtJDgeAWTtWKC9N2bOPVo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1011 malwarescore=0 adultscore=0 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290061
Received-SPF: pass client-ip=148.163.158.5; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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



On 29/06/2023 04:07, Nicholas Piggin wrote:
> The clock update logic reads the clock twice to compute the new clock
> value, with a value derived from the later time subtracted from a value
> derived from the earlier time. The delta causes time to be lost.
> 
> This can ultimately result in time becoming unsynchronized between CPUs
> and that can cause OS lockups, timeouts, watchdogs, etc. This can be
> seen running a KVM guest (that causes lots of TB updates) on a powernv
> SMP machine.
> 
> Fix this by reading the clock once.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---


Nice! It must have been a nightmare to debug.
Do you know where that ATB spr comes from? I can't relate it to the ISA.

Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>



> I also made a test case that can trigger this with kvm-unit-tests, but
> it's been taking me a while to get that upstreamed.
> 
> Thanks,
> Nick
> 
>   hw/ppc/ppc.c | 33 +++++++++++++++++----------------
>   1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index 82e4408c5c..6233f43c01 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -535,23 +535,24 @@ static inline void cpu_ppc_store_tb(ppc_tb_t *tb_env, uint64_t vmclk,
>   void cpu_ppc_store_tbl (CPUPPCState *env, uint32_t value)
>   {
>       ppc_tb_t *tb_env = env->tb_env;
> +    int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>       uint64_t tb;
>   
> -    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), tb_env->tb_offset);
> +    tb = cpu_ppc_get_tb(tb_env, clock, tb_env->tb_offset);
>       tb &= 0xFFFFFFFF00000000ULL;
> -    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> -                     &tb_env->tb_offset, tb | (uint64_t)value);
> +    cpu_ppc_store_tb(tb_env, clock, &tb_env->tb_offset, tb | (uint64_t)value);
>   }
>   
>   static inline void _cpu_ppc_store_tbu(CPUPPCState *env, uint32_t value)
>   {
>       ppc_tb_t *tb_env = env->tb_env;
> +    int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>       uint64_t tb;
>   
> -    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), tb_env->tb_offset);
> +    tb = cpu_ppc_get_tb(tb_env, clock, tb_env->tb_offset);
>       tb &= 0x00000000FFFFFFFFULL;
> -    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> -                     &tb_env->tb_offset, ((uint64_t)value << 32) | tb);
> +    cpu_ppc_store_tb(tb_env, clock, &tb_env->tb_offset,
> +                     ((uint64_t)value << 32) | tb);
>   }
>   
>   void cpu_ppc_store_tbu (CPUPPCState *env, uint32_t value)
> @@ -584,23 +585,24 @@ uint32_t cpu_ppc_load_atbu (CPUPPCState *env)
>   void cpu_ppc_store_atbl (CPUPPCState *env, uint32_t value)
>   {
>       ppc_tb_t *tb_env = env->tb_env;
> +    int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>       uint64_t tb;
>   
> -    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), tb_env->atb_offset);
> +    tb = cpu_ppc_get_tb(tb_env, clock, tb_env->atb_offset);
>       tb &= 0xFFFFFFFF00000000ULL;
> -    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> -                     &tb_env->atb_offset, tb | (uint64_t)value);
> +    cpu_ppc_store_tb(tb_env, clock, &tb_env->atb_offset, tb | (uint64_t)value);
>   }
>   
>   void cpu_ppc_store_atbu (CPUPPCState *env, uint32_t value)
>   {
>       ppc_tb_t *tb_env = env->tb_env;
> +    int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>       uint64_t tb;
>   
> -    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), tb_env->atb_offset);
> +    tb = cpu_ppc_get_tb(tb_env, clock, tb_env->atb_offset);
>       tb &= 0x00000000FFFFFFFFULL;
> -    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> -                     &tb_env->atb_offset, ((uint64_t)value << 32) | tb);
> +    cpu_ppc_store_tb(tb_env, clock, &tb_env->atb_offset,
> +                     ((uint64_t)value << 32) | tb);
>   }
>   
>   uint64_t cpu_ppc_load_vtb(CPUPPCState *env)
> @@ -622,14 +624,13 @@ void cpu_ppc_store_vtb(CPUPPCState *env, uint64_t value)
>   void cpu_ppc_store_tbu40(CPUPPCState *env, uint64_t value)
>   {
>       ppc_tb_t *tb_env = env->tb_env;
> +    int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>       uint64_t tb;
>   
> -    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> -                        tb_env->tb_offset);
> +    tb = cpu_ppc_get_tb(tb_env, clock, tb_env->tb_offset);
>       tb &= 0xFFFFFFUL;
>       tb |= (value & ~0xFFFFFFUL);
> -    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> -                     &tb_env->tb_offset, tb);
> +    cpu_ppc_store_tb(tb_env, clock, &tb_env->tb_offset, tb);
>   }
>   
>   static void cpu_ppc_tb_stop (CPUPPCState *env)

