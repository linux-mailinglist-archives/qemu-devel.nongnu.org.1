Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4C672908E
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 09:07:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7WBq-0000ju-CG; Fri, 09 Jun 2023 03:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1q7WBd-0000gT-4j; Fri, 09 Jun 2023 03:05:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1q7WBa-0006OR-Lh; Fri, 09 Jun 2023 03:05:28 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3596pKbP026862; Fri, 9 Jun 2023 07:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7j/yuB5ynuIIXDqmrmYP8a3tgmr/8Az9dGMp+8YDxBg=;
 b=YznHag/THD8MfT/yr8XCiXWJxNLJZ35DANdEGRGSQxBVyARThKUqLMBfZ31b2BfIr4dZ
 AS1r5JcOMgPdG5a2CZTGekpUwA/tBfm/sZpEyNhI1cPQSjUP0h6S6BPPPVY3OKqE6i8x
 IKZJhwm4sceulfFHgpcBYcsp2otQUzYbwyyeuS2hBiKr7tzX0KKEvOs83ztXJVWRZ8t1
 3+bmwQgW47Fy6lPBedSd2bv9P37vk4uewi0ChVnsS6xUgQ49KJ9zKol4kJYKVhg9wp+v
 tRut3hPwuGWu2JtYdWLaYIhgKXm8mrorAobZPJ/zf2Wq64vjAMozydoa6ezkzg4fL064 jw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r3y698cmu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Jun 2023 07:05:12 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3596pXIU027975;
 Fri, 9 Jun 2023 07:05:12 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r3y698cky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Jun 2023 07:05:12 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35974IXm008963;
 Fri, 9 Jun 2023 07:05:11 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
 by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3r2a77kaqx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Jun 2023 07:05:11 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3597595B47055272
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Jun 2023 07:05:09 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C0D45806B;
 Fri,  9 Jun 2023 07:05:09 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA85758059;
 Fri,  9 Jun 2023 07:05:06 +0000 (GMT)
Received: from [9.171.48.82] (unknown [9.171.48.82])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 Jun 2023 07:05:06 +0000 (GMT)
Message-ID: <33465d2b-3c2b-8a29-d6c3-c379e742e259@linux.ibm.com>
Date: Fri, 9 Jun 2023 12:35:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/4] ppc/spapr: H_ENTER_NESTED should restore host XER ca
 field
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20230608091344.88685-1-npiggin@gmail.com>
 <20230608091344.88685-2-npiggin@gmail.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20230608091344.88685-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -yKC_G0QjEZiSM8B-GMerJQ0KKwH1H2W
X-Proofpoint-GUID: pf7bFr2VynS9Vth1dXaEU5g-3OAcTx9f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_04,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 suspectscore=0 clxscore=1011 impostorscore=0 adultscore=0 mlxlogscore=992
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090062
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

Since we have the spapr_exit_nested routine that gets executed during 
return path which contains the below change, I think mentioning 
spapr_exit_nested in the title may be more specific/appropriate.

On 6/8/23 14:43, Nicholas Piggin wrote:
> Fix missing env->ca restore when going from L2 back to the host.
> 
> Fixes: 120f738a467 ("spapr: implement nested-hv capability for the virtual hypervisor")
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/ppc/spapr_hcall.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index b904755575..0582b524d1 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1773,6 +1773,7 @@ out_restore_l1:
>       env->cfar = spapr_cpu->nested_host_state->cfar;
>       env->xer = spapr_cpu->nested_host_state->xer;
>       env->so = spapr_cpu->nested_host_state->so;
> +    env->ca = spapr_cpu->nested_host_state->ca;
>       env->ov = spapr_cpu->nested_host_state->ov;
>       env->ov32 = spapr_cpu->nested_host_state->ov32;
>       env->ca32 = spapr_cpu->nested_host_state->ca32;

