Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 989CB7121A7
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 09:56:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2SIM-000357-R8; Fri, 26 May 2023 03:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1q2SIK-00034O-2C; Fri, 26 May 2023 03:55:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1q2SIH-0001Mq-LK; Fri, 26 May 2023 03:55:27 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34Q7cxKm000430; Fri, 26 May 2023 07:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=osFeAjpMUYdLuuhYIbQcBYeMyeR/1AANZwRX2ZjVXf4=;
 b=NyWYjm5iHZggMjZ/pKGnjQXaHueFDX8KMdAxv1A62ub7hGyc0cmSQx+m7mGGwupJFs3a
 dHvhWImCbDeVYxJv3l5vACTIn/j2Jkmgt4ipo/s0w2FqwFysUxEHzASb2x2v7tXf8JT7
 zAsVNmUMOF+Z+D++VRDSEnXqIRmHaAjbaFH+4UqkcPd/hPPnsyyLx2eN3K+ji2VZGs19
 1BmnibzUXQhnvRqdImEvmIKIHcxXgJ+qbUT05VLbTTCzA+xqYPGbRDGfcI6SfmUStiIU
 RicWCDUFDr0ghypRfmGVrkmkSvDRKKQVOQARnCVwCuc1NjcJfUitUtze33lw4ESmyV1X 6Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qtrc00k7q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 07:55:19 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34Q7d0CI000617;
 Fri, 26 May 2023 07:55:19 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qtrc00k6p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 07:55:18 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34Q1d0wv026986;
 Fri, 26 May 2023 07:55:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qppdk2tjv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 07:55:17 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34Q7tEt916712252
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 May 2023 07:55:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB0F920043;
 Fri, 26 May 2023 07:55:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 651DF20040;
 Fri, 26 May 2023 07:55:14 +0000 (GMT)
Received: from [9.171.59.191] (unknown [9.171.59.191])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 26 May 2023 07:55:14 +0000 (GMT)
Message-ID: <1be662bb-d530-1a31-dfb6-750776b607a1@linux.ibm.com>
Date: Fri, 26 May 2023 09:55:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] pnv_lpc: disable reentrancy detection for lpc-hc
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, Alexander Bulekov <alxndr@bu.edu>
References: <20230526073850.2772197-1-clg@kaod.org>
Content-Language: en-US
From: Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <20230526073850.2772197-1-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qzcpqul23idZR1YRJzRazlpnB-r8vRax
X-Proofpoint-ORIG-GUID: gMBDvyKjcuRTw9B-ywWQotH6zvLyDiKa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 mlxlogscore=693 spamscore=0 mlxscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260063
Received-SPF: pass client-ip=148.163.158.5; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091, SPF_HELO_NONE=0.001,
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



On 26/05/2023 09:38, Cédric Le Goater wrote:
> From: Alexander Bulekov <alxndr@bu.edu>
> 
> As lpc-hc is designed for re-entrant calls from xscom, mark it
> re-entrancy safe.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> [clg: mark opb_master_regs as re-entrancy safe also ]
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---


Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>

Thanks,

   Fred


>   hw/ppc/pnv_lpc.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index 01f44c19ebba..605d3908617a 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -734,10 +734,13 @@ static void pnv_lpc_realize(DeviceState *dev, Error **errp)
>       /* Create MMIO regions for LPC HC and OPB registers */
>       memory_region_init_io(&lpc->opb_master_regs, OBJECT(dev), &opb_master_ops,
>                             lpc, "lpc-opb-master", LPC_OPB_REGS_OPB_SIZE);
> +    lpc->opb_master_regs.disable_reentrancy_guard = true;
>       memory_region_add_subregion(&lpc->opb_mr, LPC_OPB_REGS_OPB_ADDR,
>                                   &lpc->opb_master_regs);
>       memory_region_init_io(&lpc->lpc_hc_regs, OBJECT(dev), &lpc_hc_ops, lpc,
>                             "lpc-hc", LPC_HC_REGS_OPB_SIZE);
> +    /* xscom writes to lpc-hc. As such mark lpc-hc re-entrancy safe */
> +    lpc->lpc_hc_regs.disable_reentrancy_guard = true;
>       memory_region_add_subregion(&lpc->opb_mr, LPC_HC_REGS_OPB_ADDR,
>                                   &lpc->lpc_hc_regs);
>   

