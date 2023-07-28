Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 845EB766907
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 11:37:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPJiu-0001xb-Dc; Fri, 28 Jul 2023 05:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Gautam.Menghani@linux.ibm.com>)
 id 1qPJiq-0001qd-5U; Fri, 28 Jul 2023 05:25:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Gautam.Menghani@linux.ibm.com>)
 id 1qPJio-0004hx-Bu; Fri, 28 Jul 2023 05:25:19 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36S9E8aO023143; Fri, 28 Jul 2023 09:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=2YARmVtYYaqww7vu+NxmWQqbtItkuor227S4gmmjpys=;
 b=bIiGLV9OsNza7Lxln3sXmtYPol4iB0oJ5bAd1k62H5dje4/05bLB2OoqLN1vr28MPXhU
 L5PXhH/PVliQMB8vvjTfeoBlVXBIMbsHGXgUWnd5pr8G+6D+UGlDKgXrxC13q/KFZfY2
 SANdFZDu6xsko9jc0cB37/+CPd5ZF206pDtrUwH3dr+z+KYKHBaZ2n8d5JNiC49TppZY
 AGMfSOAL9RsIydpLJF8Vu7M7+5LAQczKG8vJU2D7qcxtUAhtiZ5dQG/R+usmO0KAEoSa
 +CHQHoa7vzeMNiU6EGa3eWufJpM+3pzyXYaLQIBsl7sAHkZDXzJtpaJO6WbAiPi8BVL+ 2w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s4av1r8sw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Jul 2023 09:25:02 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36S9FrvU028635;
 Fri, 28 Jul 2023 09:25:02 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s4av1r8sg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Jul 2023 09:25:02 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36S6vmpL002013; Fri, 28 Jul 2023 09:25:01 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0tenmtfg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Jul 2023 09:25:01 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36S9OxNY66126170
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Jul 2023 09:24:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 81A5A20040;
 Fri, 28 Jul 2023 09:24:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E05EC20049;
 Fri, 28 Jul 2023 09:24:57 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com (unknown
 [9.204.206.66])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 28 Jul 2023 09:24:57 +0000 (GMT)
Date: Fri, 28 Jul 2023 14:54:53 +0530
From: Gautam Menghani <Gautam.Menghani@linux.ibm.com>
To: jianchunfu <chunfu.jian@shingroup.cn>
Cc: danielhb413@gmail.com, clg@kaod.org, david@gibson.dropbear.id.au,
 groug@kaod.org, npiggin@gmail.com, pbonzini@redhat.com,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] target/ppc: Fix the order of kvm_enable judgment about
 kvmppc_set_interrupt()
Message-ID: <fdjlp45hqjifjndt4vxv2za5tw4bbv3dwa5jqdn3txucdfq2oh@5asn2scjqdfq>
References: <20230721073734.219027-1-chunfu.jian@shingroup.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721073734.219027-1-chunfu.jian@shingroup.cn>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -LYvfrXrpG_swIFy_Ejsnl9Bs1ojbolp
X-Proofpoint-GUID: luxlvY0zaVFH1iaqj8Tche6-_r297r5R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=820 mlxscore=0 clxscore=1011
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280082
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=Gautam.Menghani@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Jul 21, 2023 at 03:37:34PM +0800, jianchunfu wrote:
> It's unnecessary for non-KVM accelerators(TCG, for example),
> to call this function, so change the order of kvm_enable() judgment.
> 
> The static inline function that returns -1 directly does not work
>  in TCG's situation.
> 
> Signed-off-by: jianchunfu <chunfu.jian@shingroup.cn>
> ---
>  hw/ppc/ppc.c     | 8 ++++++--
>  target/ppc/kvm.c | 2 +-
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index 0e0a3d93c3..3e96b24487 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -58,7 +58,9 @@ void ppc_set_irq(PowerPCCPU *cpu, int irq, int level)
>  
>      if (old_pending != env->pending_interrupts) {
>          ppc_maybe_interrupt(env);
> -        kvmppc_set_interrupt(cpu, irq, level);
> +        if (kvm_enabled()) {
> +            kvmppc_set_interrupt(cpu, irq, level);
> +        }
>      }
>  
>      trace_ppc_irq_set_exit(env, irq, level, env->pending_interrupts,
> @@ -1465,5 +1467,7 @@ void ppc_irq_reset(PowerPCCPU *cpu)
>      CPUPPCState *env = &cpu->env;
>  
>      env->irq_input_state = 0;
> -    kvmppc_set_interrupt(cpu, PPC_INTERRUPT_EXT, 0);
> +    if (kvm_enabled()) {
> +        kvmppc_set_interrupt(cpu, PPC_INTERRUPT_EXT, 0);
> +    }
>  }
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index a8a935e267..11a1fbc244 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1315,7 +1315,7 @@ int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq, int level)
>          return 0;
>      }
>  
> -    if (!kvm_enabled() || !cap_interrupt_unset) {
> +    if (!cap_interrupt_unset) {
>          return 0;
>      }
>  
> -- 
> 2.27.0
> 

I tested this by launching a QEMU guest in both KVM and TCG modes on a 
Power9 PowerNV box. I was able to use the network, and also read and
write files on the disk.

Tested-by: Gautam Menghani <gautam@linux.ibm.com>

