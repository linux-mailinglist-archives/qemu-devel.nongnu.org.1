Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 045CDAB8BDC
	for <lists+qemu-devel@lfdr.de>; Thu, 15 May 2025 18:07:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFb5P-0001UO-1Y; Thu, 15 May 2025 12:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFb51-0001HU-Px; Thu, 15 May 2025 12:05:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFb4z-0000AE-CY; Thu, 15 May 2025 12:05:07 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FDndGt001019;
 Thu, 15 May 2025 16:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=AjtsWDNfDdT4O09ojUONxvou8AmRMPahinqaB8GmPN4=; b=gRDQsewgsjZA
 f0wGse4asDQeyXirviAhsSWKG6cANTDcKPAb4VIscwh5rEo+Em6nVLI3QhXPPhRw
 oPYEzPhoDWOyMvgVpFuLDjTfQ2EyTGeQEUh5wcI/NNoi11NnjSc1vWasscsqEsaN
 nWg7bLm6N1jU77PRNeJmxTutEYRw53Zt1j8X0uMFE83/fQOZJFJYSAYnT8VygywA
 VnH2RavitmhI0sjKM7yg1utJ6lsDd7uiGa3SnM78AQvKz08eSTfd+iwZpkgfzt1H
 Y/h92FHVktfGvKzZJCjEryAUG7wfhTLJfKC7LQSl21rcRmsEBK9BR2E/Ic5tn7Dp
 qbGCWXJWEw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nhg30rub-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:05:02 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FG51xC028705;
 Thu, 15 May 2025 16:05:01 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nhg30ru8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:05:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FDr51b024273;
 Thu, 15 May 2025 16:05:01 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfsb4he-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:05:01 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FG4xuh20316878
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 16:04:59 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72BA358066;
 Thu, 15 May 2025 16:04:59 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E20FD5805D;
 Thu, 15 May 2025 16:04:58 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 16:04:58 +0000 (GMT)
Message-ID: <f156671d5c68024f86898239aeef3542ee421e08.camel@linux.ibm.com>
Subject: Re: [PATCH 34/50] ppc/xive: tctx_accept only lower irq line if an
 interrupt was presented
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 11:04:58 -0500
In-Reply-To: <20250512031100.439842-35-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-35-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cf0I5Krl c=1 sm=1 tr=0 ts=682610ae cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=pRnG_qZzie8L9V9X0xMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NSBTYWx0ZWRfXz8pxyDMHfdlO
 1tSTKA7n9eTTImGy0c6TpoRwbGnIo6RzlS7E0d7DoiW8GHJ1Ga7cMGp0spGotn3+UHukRmr+JnC
 vftJcwonooaxrInbaEikef7tVT7SLn9T1fQme5YJ5rvboDPXAqEQy2P1b+DZv8/DNk/qgxVUdJG
 DLCNP9V62w1kyz1Acx4r+lRjJaBvAMYr6yhz5b+jz1OsxikF+4x5nDh9H+k1Vdn/j31dy9alo1s
 nGqY1t188YOZ3vyoM3JZ1DNWfMsi0VHSU4NoZeQ8uEF2BLoMX8HjrkOiAvPRJO+PSTyKWK7vIEU
 3PVWNHd+tpXfnjh4Bq09TAM+pf5KHRhXuwfaPqcNbQla0jrKDo8SQvTEGwihFkq1o/j/Fz5j5fV
 uC7dCo1466uAAnjAjQ+d0Q4PvZ5xzFOpNtsgRrW0aufW5fvmrlwe1nlUaJ07oPF8rZ4TcgdR
X-Proofpoint-GUID: eo9jRLMosPC5Z8qfOKUGE5_VR6NZwRlt
X-Proofpoint-ORIG-GUID: YNHty2v-7OFa_h5zLTE68mAUbxYy92ru
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=891
 impostorscore=0 phishscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150155
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

On Mon, 2025-05-12 at 13:10 +1000, Nicholas Piggin wrote:
> The relationship between an interrupt signaled in the TIMA and the QEMU
> irq line to the processor to be 1:1, so they should be raised and
> lowered together and "just in case" lowering should be avoided (it could
> mask
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 4e0c71d684..d5dbeab6bd 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -95,8 +95,6 @@ uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t sig_ring)
>      g_assert(tctx->regs[TM_QW2_HV_POOL + TM_PIPR] == 0);
>      g_assert(tctx->regs[TM_QW2_HV_POOL + TM_CPPR] == 0);
>  
> -    qemu_irq_lower(xive_tctx_output(tctx, sig_ring));
> -
>      if (xive_nsr_indicates_exception(sig_ring, nsr)) {
>          uint8_t cppr = sig_regs[TM_PIPR];
>          uint8_t ring;
> @@ -117,6 +115,7 @@ uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t sig_ring)
>  
>          /* Clear the exception from NSR */
>          sig_regs[TM_NSR] = 0;
> +        qemu_irq_lower(xive_tctx_output(tctx, sig_ring));
>  
>          trace_xive_tctx_accept(tctx->cs->cpu_index, ring,
>                                 regs[TM_IPB], sig_regs[TM_PIPR],


