Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8837A225B
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 17:28:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhAji-0005ed-Cz; Fri, 15 Sep 2023 11:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qhAjY-0005dd-1N; Fri, 15 Sep 2023 11:27:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qhAjW-0005PI-HP; Fri, 15 Sep 2023 11:27:51 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38FFQ55Q009486; Fri, 15 Sep 2023 15:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DrCFFHnu1MJ8O5oleEIdNSOBejb4lif0Xt5UGdSZh2I=;
 b=hpDVR3lB88U79h0fE7wYP+UGAXaiiwidOl+s9fBE3X6IvT056S/j4yDU5YwTQPeHj0o7
 jXoEnkKs/gIiU5jSUhpVXMoFjD4cHbjaeY4QiZjH/Skwq2SaKdd7Sz5UKA5FHaJg/YHo
 Ts5bpyfgA/oGP2rxYHlrBzvB1z0K1QWrDeIoHdvMAlDIW05i1mS75laDEIF3quZtbb22
 6vsAVUZI1WwFfqHAFmBlG4LI0JKsqWjTz0Y5gkSJC+9Vx8x22Q4c+KQZ8lDNbW7xnoMP
 hUgzZEiGiyfAh9czbvmTXE3tyXMTHEpC/y4I91hzrXvhh8yBba4rT8TcDGD+7xFBpRGE Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t4swhr1tt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Sep 2023 15:27:36 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38FFQbOf011726;
 Fri, 15 Sep 2023 15:27:35 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t4swhr1te-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Sep 2023 15:27:35 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38FEATRJ002755; Fri, 15 Sep 2023 15:27:34 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t14hmmqk4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Sep 2023 15:27:34 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38FFRYcc37749354
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Sep 2023 15:27:34 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E1F395803F;
 Fri, 15 Sep 2023 15:27:33 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A4F8F58055;
 Fri, 15 Sep 2023 15:27:28 +0000 (GMT)
Received: from [9.195.40.219] (unknown [9.195.40.219])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 15 Sep 2023 15:27:28 +0000 (GMT)
Message-ID: <09b837fe-d2a7-083d-c67b-b38a7a46bfbf@linux.ibm.com>
Date: Fri, 15 Sep 2023 20:57:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH 4/4] accel/tcg: Keep tlb_set_dirty() internal
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Anton Johansson <anjo@rev.ng>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org
References: <20230914195229.78244-1-philmd@linaro.org>
 <20230914195229.78244-5-philmd@linaro.org>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20230914195229.78244-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FPeWnLe5LAokuHoWknVPMaewQWK98yU1
X-Proofpoint-ORIG-GUID: z_uRWNNUBNai6oxzncoxEHxtLVBlAWMZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_11,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 priorityscore=1501 mlxlogscore=917 mlxscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150134
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



On 9/15/23 01:22, Philippe Mathieu-Daudé wrote:
> Since commit 34d49937e4 ("accel/tcg: Handle atomic accesses
> to notdirty memory correctly") tlb_set_dirty() is only used
> (once) in the very same file it is defined... Make it static.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   include/exec/exec-all.h | 1 -
>   accel/tcg/cputlb.c      | 2 +-
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index b2f5cd4c2a..59efa7bc28 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -695,7 +695,6 @@ static inline void mmap_unlock(void) {}
>   #define WITH_MMAP_LOCK_GUARD()
>   
>   void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
> -void tlb_set_dirty(CPUState *cpu, vaddr addr);
>   
>   MemoryRegionSection *
>   address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr addr,
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index c643d66190..fe9d702f3e 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1062,7 +1062,7 @@ static inline void tlb_set_dirty1_locked(CPUTLBEntry *tlb_entry,
>   
>   /* update the TLB corresponding to virtual page vaddr
>      so that it is no longer dirty */
> -void tlb_set_dirty(CPUState *cpu, vaddr addr)
> +static void tlb_set_dirty(CPUState *cpu, vaddr addr)
>   {
>       CPUArchState *env = cpu->env_ptr;
>       int mmu_idx;

