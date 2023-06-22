Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0262F7398DE
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 10:00:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCFFF-0003Qe-0L; Thu, 22 Jun 2023 04:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qCFEs-0003Jr-5k; Thu, 22 Jun 2023 04:00:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qCFEp-00009g-FE; Thu, 22 Jun 2023 04:00:21 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35M7wfZu024271; Thu, 22 Jun 2023 08:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5iige622nueld80GJR2fHC47QDQ7jPiqE+zQFh1Dmp4=;
 b=kDAojQonzd8aV2RKeLjWqM5pjuZjeJMaFYWTrUQJHYNbCdehEq1RUTZQEDws3h29PojU
 7Ydtq0OtPgqqtyewoIgl7qJwUOdVY7qIj66pnx2Gd0NzeMRpbXyRyPlOOypq217ut/pR
 AfG5ysgr/ukY1nIw1IoaRQXad0KL51KVS98mT2CWY1UJHbC+Go/m5uQ6/zqEe3uz7Hzm
 KD4bP5VW86genQ7WAwYT2RDd9kMRSo45yuZ5UBpiTUDsSx/i13iBlFFrf25ZCXwDGlYb
 rqrTV/wdbagg57mKMRYYEGwUt/BFUOV7JE2+LX1NN37eTEZkZ13wJu30yBBZkipMN64D xQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rchwggw68-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Jun 2023 08:00:16 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35M7QKDj020074;
 Thu, 22 Jun 2023 08:00:16 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rchwggw5e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Jun 2023 08:00:16 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35M4juPh016312;
 Thu, 22 Jun 2023 08:00:15 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
 by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3r94f68gph-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Jun 2023 08:00:14 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35M80D6Z11010702
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 08:00:14 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 929305805F;
 Thu, 22 Jun 2023 08:00:13 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1626058045;
 Thu, 22 Jun 2023 08:00:12 +0000 (GMT)
Received: from [9.109.242.129] (unknown [9.109.242.129])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 22 Jun 2023 08:00:11 +0000 (GMT)
Message-ID: <ceed7522-ac70-02fd-14b5-e97fad5e52a3@linux.ibm.com>
Date: Thu, 22 Jun 2023 13:30:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] target/ppc: Fix sc instruction handling of LEV field
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20230621110938.239066-1-npiggin@gmail.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20230621110938.239066-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JiJjaaOTmGM9p_yQHgIIhgue1ZuxXdGL
X-Proofpoint-ORIG-GUID: zCWpQYLbTHhwtp59fpwfXoCKLwej9kru
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_04,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=795 spamscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220062
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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



On 6/21/23 16:39, Nicholas Piggin wrote:
> The top bits of the LEV field of the sc instruction are to be treated as
> as a reserved field rather than a reserved value, meaning LEV is
> effectively the bottom bit. LEV=0xF should be treated as LEV=1 and be
> a hypercall, for example.
> 
> This changes the instruction execution to just set lev from the low bit
> of the field. Processors which don't support the LEV field will continue
> to ignore it.
> 
> ISA v3.1 defines LEV to be 2 bits, in order to add the 'sc 2' ultracall
> instruction. TCG does not support Ultravisor, so don't worry about
> that bit.
> 
> Suggested-by: "Harsh Prateek Bora" <harshpb@linux.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> This should probably go ahead of the ISA 3.1 LEV in SRR1 patch. I
> don't think they need to be backported to stable though, have not
> caused any real problems.
> 
> Thanks to Harsh for spotting it.
> 
> Thanks,
> Nick
> 
>   target/ppc/translate.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 15a00bd4fa..3c62f9188a 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4424,7 +4424,12 @@ static void gen_sc(DisasContext *ctx)
>   {
>       uint32_t lev;
>   
> -    lev = (ctx->opcode >> 5) & 0x7F;
> +    /*
> +     * LEV is a 7-bit field, but the top 6 bits are treated as a reserved
> +     * field (i.e., ignored). ISA v3.1 changes that to 5 bits, but that is
> +     * for Ultravisor which TCG does not support, so just ignore the top 6.
> +     */
> +    lev = (ctx->opcode >> 5) & 0x1;

should this change be applied to gen_scv() defined next to it as well ?

Otherwise,
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

>       gen_exception_err(ctx, POWERPC_SYSCALL, lev);
>   }
>   

