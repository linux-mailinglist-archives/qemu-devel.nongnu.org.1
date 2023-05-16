Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB6E704810
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 10:44:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyqHy-0001M0-9r; Tue, 16 May 2023 04:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1pyqHo-0001Kr-9p; Tue, 16 May 2023 04:44:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1pyqHi-0008S8-Hx; Tue, 16 May 2023 04:44:00 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34G8WfpP024613; Tue, 16 May 2023 08:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=TWYcnf/9Tb40jdDaASyz2PZOpuwdsphWUvHvq1PXx+4=;
 b=iPSgP1hjZvcPqkw8Z8RHdZAuory1aa8sJdGO8sts0jrY19uPnbqxwru6jYNBVwgHV+al
 bSC2kTPlT6DF7XA4ml4whPMR84yd46ZoQcRPy+8kRAp1H3UgONU6hy7SUytFMBm0yTuQ
 MIUCKBk4lVNXGcc3hXi0CmE+KUJtREzoQEEfpVv1n+R/JrhwCu3QebzzHJbbpXwX7AKf
 wugknlZOq578TUBIW7aNXEgTd6a6qZ0WKaFHPwfuY5b5Fc6WPEQN83gfaV4BV4gt+STr
 QPY0oGCbweXP3M5W8tEd5gtT2m3efMfp9zJ5+Nuuyq0qUZQLU++Coi3ghT5YJkvx9Auz Sg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm6dm8jy1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 May 2023 08:43:51 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34G8gvDD020125;
 Tue, 16 May 2023 08:43:51 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm6dm8jxw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 May 2023 08:43:51 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34G827j2000665;
 Tue, 16 May 2023 08:43:50 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
 by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3qj265ke77-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 May 2023 08:43:50 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34G8hnM365536256
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 May 2023 08:43:49 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5475F58066;
 Tue, 16 May 2023 08:43:49 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BA3A58059;
 Tue, 16 May 2023 08:43:47 +0000 (GMT)
Received: from [9.109.242.129] (unknown [9.109.242.129])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 May 2023 08:43:47 +0000 (GMT)
Message-ID: <4b1147e0-498d-e3ae-d97a-4063055099b1@linux.ibm.com>
Date: Tue, 16 May 2023 14:13:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] target/ppc: Use SMT4 small core chip type in POWER9/10
 PVRs
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20230515160131.394562-1-npiggin@gmail.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20230515160131.394562-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NYmuFUC27F-FUvJ5L32klNw8X_HiiY_q
X-Proofpoint-GUID: hgDt-NLcS8nMvYCq5hwQFVukR11HciMf
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_02,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=888
 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305160072
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.811,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

<correcting my email id in CC>

On 5/15/23 21:31, Nicholas Piggin wrote:
> QEMU's PVR value for POWER9 DD2.0 has chip type 1, which is the SMT4
> "small core" type that OpenPOWER processors use. QEMU's PVR for all
> other POWER9/10 have chip type 0, which "enterprise" systems use.
> 
> The difference does not really matter to QEMU (because it does not care
> about SMT mode in the target), but for consistency all PVRs should use
> the same chip type. We'll go with the SMT4 OpenPOWER type.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> This is a replacement for
> 
> https://lists.gnu.org/archive/html/qemu-ppc/2022-03/msg00227.html
> 
> But the chip type is changed to 1 instead of 0, because that's the
> more familiar SM4 / small core CPU.
> 
> Thanks,
> Nick
> 
>   target/ppc/cpu-models.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
> index 1326493a9a..a77e036b3a 100644
> --- a/target/ppc/cpu-models.h
> +++ b/target/ppc/cpu-models.h
> @@ -348,11 +348,11 @@ enum {
>       CPU_POWERPC_POWER8NVL_BASE     = 0x004C0000,
>       CPU_POWERPC_POWER8NVL_v10      = 0x004C0100,
>       CPU_POWERPC_POWER9_BASE        = 0x004E0000,
> -    CPU_POWERPC_POWER9_DD1         = 0x004E0100,
> +    CPU_POWERPC_POWER9_DD1         = 0x004E1100,

Could you please point me to the doc location you are referring here?
The P9 UM document that I have access to mentions this bit (0/1) for 
12/24 cores. Not sure if this change is intended here.

regards,
Harsh

>       CPU_POWERPC_POWER9_DD20        = 0x004E1200,
>       CPU_POWERPC_POWER10_BASE       = 0x00800000,
> -    CPU_POWERPC_POWER10_DD1        = 0x00800100,
> -    CPU_POWERPC_POWER10_DD20       = 0x00800200,
> +    CPU_POWERPC_POWER10_DD1        = 0x00801100,
> +    CPU_POWERPC_POWER10_DD20       = 0x00801200,
>       CPU_POWERPC_970_v22            = 0x00390202,
>       CPU_POWERPC_970FX_v10          = 0x00391100,
>       CPU_POWERPC_970FX_v20          = 0x003C0200,

