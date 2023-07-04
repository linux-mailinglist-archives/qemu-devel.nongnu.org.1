Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B529746E28
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 12:00:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGcp6-0006EE-CR; Tue, 04 Jul 2023 05:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qGcp4-0006E1-79; Tue, 04 Jul 2023 05:59:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qGcp2-0004kY-7u; Tue, 04 Jul 2023 05:59:49 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3649qAqO022950; Tue, 4 Jul 2023 09:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=b+MYw9070SETweTUycuTM06z72s6UJE1ceJddXyKWQE=;
 b=chsrsZGDlLJ+IlOxgqj0MZNqdgV4WHHJMFRai2tpOMZ7CXYccttBeJjtvETzDND5ftR/
 Z98cGLRwAZG/Z5k0SBmAG84U68jVaaaDxXCOcO7yZ8ZxKsVd8DVMZKexTLb6ULSoOlOb
 /1vwLMTJ+meu5mQvwtLQIwFMjbTZFaHhuH9rrcKX85WHutt3tX2gNv0GWhdP3lsJuNgW
 BWVa0mHsYE49qWpYfSb67U7C3QZK4DixSOcrbxL59fwlhRk9r32/AJ58+lU3JfHJMlzO
 l2kTbE8dr5W6/wGh4A2FifnHnVlcpbmnIE0Ejd/Ck04OxxNLl6QiAoi8DpVMDZIm0KX2 OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmh5t8491-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 09:59:38 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3649sW3X030064;
 Tue, 4 Jul 2023 09:59:38 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmh5t848d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 09:59:38 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3642rWBv018938;
 Tue, 4 Jul 2023 09:59:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rjbs4sy2e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 09:59:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3649xXE919071590
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Jul 2023 09:59:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE9102004B;
 Tue,  4 Jul 2023 09:59:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4083C20043;
 Tue,  4 Jul 2023 09:59:33 +0000 (GMT)
Received: from [9.179.4.4] (unknown [9.179.4.4])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Jul 2023 09:59:33 +0000 (GMT)
Message-ID: <96ee32ed-56d5-1e0b-9eeb-3ce130800b10@linux.ibm.com>
Date: Tue, 4 Jul 2023 11:59:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/5] ppc/pnv: quad xscom callbacks are P9 specific
To: Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20230704054204.168547-1-joel@jms.id.au>
 <20230704054204.168547-2-joel@jms.id.au>
Content-Language: en-US
From: Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <20230704054204.168547-2-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1r7lmmWyZCYOC1lTfC8wh6gpmoEgFzye
X-Proofpoint-ORIG-GUID: kuXDTkS0tRp6jSf5T_8-jlz8UJg2aiPU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_06,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 bulkscore=0 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040078
Received-SPF: pass client-ip=148.163.156.1; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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



On 04/07/2023 07:42, Joel Stanley wrote:
> Rename the functions to include P9 in the name in preparation for adding
> P10 versions.
> 
> Correct the unimp read message while we're changing the function.
> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---


Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>


> v2: Fix unimp print, and grammar in the commit message
> ---
>   hw/ppc/pnv_core.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 0bc3ad41c81c..0f451b3b6e1f 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -360,8 +360,8 @@ DEFINE_TYPES(pnv_core_infos)
>   
>   #define P9X_EX_NCU_SPEC_BAR                     0x11010
>   
> -static uint64_t pnv_quad_xscom_read(void *opaque, hwaddr addr,
> -                                    unsigned int width)
> +static uint64_t pnv_quad_power9_xscom_read(void *opaque, hwaddr addr,
> +                                           unsigned int width)
>   {
>       uint32_t offset = addr >> 3;
>       uint64_t val = -1;
> @@ -372,15 +372,15 @@ static uint64_t pnv_quad_xscom_read(void *opaque, hwaddr addr,
>           val = 0;
>           break;
>       default:
> -        qemu_log_mask(LOG_UNIMP, "%s: writing @0x%08x\n", __func__,
> +        qemu_log_mask(LOG_UNIMP, "%s: reading @0x%08x\n", __func__,
>                         offset);
>       }
>   
>       return val;
>   }
>   
> -static void pnv_quad_xscom_write(void *opaque, hwaddr addr, uint64_t val,
> -                                 unsigned int width)
> +static void pnv_quad_power9_xscom_write(void *opaque, hwaddr addr, uint64_t val,
> +                                        unsigned int width)
>   {
>       uint32_t offset = addr >> 3;
>   
> @@ -394,9 +394,9 @@ static void pnv_quad_xscom_write(void *opaque, hwaddr addr, uint64_t val,
>       }
>   }
>   
> -static const MemoryRegionOps pnv_quad_xscom_ops = {
> -    .read = pnv_quad_xscom_read,
> -    .write = pnv_quad_xscom_write,
> +static const MemoryRegionOps pnv_quad_power9_xscom_ops = {
> +    .read = pnv_quad_power9_xscom_read,
> +    .write = pnv_quad_power9_xscom_write,
>       .valid.min_access_size = 8,
>       .valid.max_access_size = 8,
>       .impl.min_access_size = 8,
> @@ -410,7 +410,8 @@ static void pnv_quad_realize(DeviceState *dev, Error **errp)
>       char name[32];
>   
>       snprintf(name, sizeof(name), "xscom-quad.%d", eq->quad_id);
> -    pnv_xscom_region_init(&eq->xscom_regs, OBJECT(dev), &pnv_quad_xscom_ops,
> +    pnv_xscom_region_init(&eq->xscom_regs, OBJECT(dev),
> +                          &pnv_quad_power9_xscom_ops,
>                             eq, name, PNV9_XSCOM_EQ_SIZE);
>   }
>   

