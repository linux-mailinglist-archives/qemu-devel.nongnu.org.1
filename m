Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5D9776322
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 16:58:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTkcP-0001BA-Cz; Wed, 09 Aug 2023 10:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qTkcN-0001Aj-1k; Wed, 09 Aug 2023 10:56:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qTkcL-0005Wb-9T; Wed, 09 Aug 2023 10:56:58 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 379EtQMM032504; Wed, 9 Aug 2023 14:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=CN0DsRSRBMfEMSWQyAdPr7VlkqnL+w7SG5YKFTvET2M=;
 b=lXOF8uhEx4Ekzt5eSp+OScKcxrVWCRetqS3mEvE8hevq9Sg3Nyw6L3Vs7SfxhVjQXhBs
 NDiRPT127MkvVZpA41Sgcf1oWdvHc3zK2Sqqf2jc+5sQt73qoMgg8sWiFaXF+3S82Zv8
 VOkYK/6zRM/eRemewHgPhNudoeyPuxTp9c64hnJJJdcrHvkCzGxtGqlw9nLHhQV2cDTJ
 7sGLJipKlAXMs9W7QrTAYMXu+dysz2o28B7ZTKIsB1D62i0GDjhfsvliIJQgZcabLSEa
 BAvho23gjA53C0j9bKnhC8m6FQZUyCc5+sVFPhn2b99ztg9U4atIWXNDXSApFbg5uSjK Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3scd0700km-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Aug 2023 14:56:42 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 379Eug5G002712;
 Wed, 9 Aug 2023 14:56:42 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3scd0700kf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Aug 2023 14:56:42 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 379EqEsv007552; Wed, 9 Aug 2023 14:56:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa14yhh3v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Aug 2023 14:56:41 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 379EudFY39649624
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Aug 2023 14:56:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7EA0020049;
 Wed,  9 Aug 2023 14:56:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2984320040;
 Wed,  9 Aug 2023 14:56:39 +0000 (GMT)
Received: from [9.171.65.240] (unknown [9.171.65.240])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  9 Aug 2023 14:56:39 +0000 (GMT)
Message-ID: <61cf0069-e845-3a07-2a55-659594e886be@linux.ibm.com>
Date: Wed, 9 Aug 2023 16:56:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 2/3] pnv/lpc: Hook up xscom region for P9/P10
To: Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20230808083445.4613-1-joel@jms.id.au>
 <20230808083445.4613-3-joel@jms.id.au>
Content-Language: en-US
From: Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <20230808083445.4613-3-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8jheH1XaU9G9kLCWFGrQU-RaGUcjL9kO
X-Proofpoint-ORIG-GUID: vs9WfUKuoHIMQQ2-DTtuk8lvfwVCBvAj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_11,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=544
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090128
Received-SPF: pass client-ip=148.163.158.5; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hello Joel,

So we're re-using the same xscom ops as on P8. A quick look at the 
definition of those 4 registers on P8 (0xb0020) and on P9/P10 
(0x00090040) seem to show they are not the same though. Am i missing 
something?

   Fred


On 08/08/2023 10:34, Joel Stanley wrote:
>  From P9 on the LPC bus is memory mapped. However the xscom access still
> is possible, so add it too.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   include/hw/ppc/pnv_xscom.h | 6 ++++++
>   hw/ppc/pnv.c               | 4 ++++
>   hw/ppc/pnv_lpc.c           | 6 ++++++
>   3 files changed, 16 insertions(+)
> 
> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index 9bc64635471e..42601bdf419d 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -96,6 +96,9 @@ struct PnvXScomInterfaceClass {
>   #define PNV9_XSCOM_SBE_CTRL_BASE  0x00050008
>   #define PNV9_XSCOM_SBE_CTRL_SIZE  0x1
>   
> +#define PNV9_XSCOM_LPC_BASE       0x00090040
> +#define PNV9_XSCOM_LPC_SIZE       PNV_XSCOM_LPC_SIZE
> +
>   #define PNV9_XSCOM_SBE_MBOX_BASE  0x000D0050
>   #define PNV9_XSCOM_SBE_MBOX_SIZE  0x16
>   
> @@ -155,6 +158,9 @@ struct PnvXScomInterfaceClass {
>   #define PNV10_XSCOM_SBE_CTRL_BASE  PNV9_XSCOM_SBE_CTRL_BASE
>   #define PNV10_XSCOM_SBE_CTRL_SIZE  PNV9_XSCOM_SBE_CTRL_SIZE
>   
> +#define PNV10_XSCOM_LPC_BASE       PNV9_XSCOM_LPC_BASE
> +#define PNV10_XSCOM_LPC_SIZE       PNV9_XSCOM_LPC_SIZE
> +
>   #define PNV10_XSCOM_SBE_MBOX_BASE  PNV9_XSCOM_SBE_MBOX_BASE
>   #define PNV10_XSCOM_SBE_MBOX_SIZE  PNV9_XSCOM_SBE_MBOX_SIZE
>   
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index afdaa25c2b26..a5db655b41b6 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1566,6 +1566,8 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
>       }
>       memory_region_add_subregion(get_system_memory(), PNV9_LPCM_BASE(chip),
>                                   &chip9->lpc.mmio_regs);
> +    pnv_xscom_add_subregion(chip, PNV9_XSCOM_LPC_BASE,
> +                            &chip9->lpc.xscom_regs);
>   
>       chip->fw_mr = &chip9->lpc.isa_fw;
>       chip->dt_isa_nodename = g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc@0",
> @@ -1785,6 +1787,8 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>       }
>       memory_region_add_subregion(get_system_memory(), PNV10_LPCM_BASE(chip),
>                                   &chip10->lpc.mmio_regs);
> +    pnv_xscom_add_subregion(chip, PNV10_XSCOM_LPC_BASE,
> +                            &chip10->lpc.xscom_regs);
>   
>       chip->fw_mr = &chip10->lpc.isa_fw;
>       chip->dt_isa_nodename = g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc@0",
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index caf5e10a5f96..6c6a3134087f 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -666,6 +666,12 @@ static void pnv_lpc_power9_realize(DeviceState *dev, Error **errp)
>       /* P9 uses a MMIO region */
>       memory_region_init_io(&lpc->mmio_regs, OBJECT(lpc), &pnv_lpc_mmio_ops,
>                             lpc, "lpcm", PNV9_LPCM_SIZE);
> +
> +    /* but the XSCOM region still exists */
> +    pnv_xscom_region_init(&lpc->xscom_regs, OBJECT(lpc),
> +                          &pnv_lpc_xscom_ops, lpc, "xscom-lpc",
> +                          PNV_XSCOM_LPC_SIZE);
> +
>   }
>   
>   static void pnv_lpc_power9_class_init(ObjectClass *klass, void *data)

