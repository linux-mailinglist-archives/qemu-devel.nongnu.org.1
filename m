Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D10F674095A
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 08:00:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEOCL-0008Fe-Dv; Wed, 28 Jun 2023 01:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.vnet.ibm.com>)
 id 1qEOCF-0008Dy-3V; Wed, 28 Jun 2023 01:58:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.vnet.ibm.com>)
 id 1qEOCC-0001ch-Ss; Wed, 28 Jun 2023 01:58:30 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35S5l7Xc032572; Wed, 28 Jun 2023 05:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=2GobPJFrHXVfGuqHkg+R8CkK/QcRlDcJ65ZZWWFToqA=;
 b=jl7DdGbXVFg6yfVvNvIVFSIQurnhFFRhlSFLSdjczl6e86SCIKy2u22xIaSx6WzPrBn3
 oW8wqAnGbv3bvB3S/BSLJubok14VdR5ZvH9LIJpz7Lp0AGcvNZ5/Hyw+Twe17D6u5arN
 zbDhVxXLpggh8705/UTytiItakg3Q5u15PqgvmFR75DJepjghq3Zwi1pYuJhZ2unnxT4
 /w1oyuqlB63oZFwWroC1wso76Pdnwiim7i7knesn8fv4bRBn27xq5Z02bKDvYVVQqEbH
 Ri1ghiqwQwqmPCdSV0Lj0GBjqhYUE7JGP57cj0SHxJI0tWoeuhsrzAciSWEhw0kRMx3/ kQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rgf10g66h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jun 2023 05:57:34 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35S5lbBp001774;
 Wed, 28 Jun 2023 05:57:34 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rgf10g65u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jun 2023 05:57:34 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35S5aqpY024778;
 Wed, 28 Jun 2023 05:56:39 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
 by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3rdr45vfnb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jun 2023 05:56:39 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35S5ucG54719162
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Jun 2023 05:56:38 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E14B58054;
 Wed, 28 Jun 2023 05:56:38 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3011A5803F;
 Wed, 28 Jun 2023 05:56:36 +0000 (GMT)
Received: from [9.109.244.180] (unknown [9.109.244.180])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 28 Jun 2023 05:56:35 +0000 (GMT)
Message-ID: <48e48bba-2aab-1212-7f5d-7c31fa841091@linux.vnet.ibm.com>
Date: Wed, 28 Jun 2023 11:26:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/4] target/ppc: Fixes for instruction-related
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20230620131044.169110-1-npiggin@gmail.com>
From: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
In-Reply-To: <20230620131044.169110-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UmQSHc6ZQRyCvODJ6BhF_R_sUDYitEyU
X-Proofpoint-ORIG-GUID: EAwJdfpFBaVUfntT0lpFjL0Wfl92LtvM
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_02,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 malwarescore=0
 mlxlogscore=953 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280048
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=anushree.mathur@linux.vnet.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 6/20/23 18:40, Nicholas Piggin wrote:
> Because they got more complexities than I first thought, these patches
> are broken out from the bigger series here:
>
> https://lists.gnu.org/archive/html/qemu-ppc/2023-05/msg00425.html
>
> Since then I fixed the --disable-tcg compile bug reported by Anushree
> hopefully. Also added a workaround for KVM so injected interrupts
> wouldn't attempt to find the prefix bit setting. I don't know how much
> that is really needed, but injection callers would have to set it one
> way or anohter if we need to add it.
>
> Thanks,
> Nick
>
> Nicholas Piggin (4):
>    target/ppc: Fix instruction loading endianness in alignment interrupt
>    target/ppc: Change partition-scope translate interface
>    target/ppc: Add SRR1 prefix indication to interrupt handlers
>    target/ppc: Implement HEIR SPR
>
>   target/ppc/cpu.h         |   1 +
>   target/ppc/cpu_init.c    |  23 ++++++++
>   target/ppc/excp_helper.c | 110 ++++++++++++++++++++++++++++++++++++++-
>   target/ppc/mmu-radix64.c |  38 ++++++++++----
>   4 files changed, 159 insertions(+), 13 deletions(-)
>
Hye Nick,

I tried this patch-set and the compilation of qemu with --disable-tcg 
parameter happened successfully!

Thanks & Regards,

Anushree-Mathur


