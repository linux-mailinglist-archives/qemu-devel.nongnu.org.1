Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA214746E54
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 12:13:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGd1D-0002VU-Pj; Tue, 04 Jul 2023 06:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qGd18-0002Ua-Tb; Tue, 04 Jul 2023 06:12:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qGd16-0007Pz-Ue; Tue, 04 Jul 2023 06:12:18 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3649qA1v022950; Tue, 4 Jul 2023 10:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=x5lLJd2Z3YmMGDFerac5dP0SCoPymM2noHAbPDMHGd8=;
 b=TBJtPHmfLMYbOYwyiEF2LlX2Obv7tWaszmoqnfFCCvD/EqBlumtESp26pJ14qW33rEO9
 7nwRXxr7ZpKsDaerX1+CRNJicWpoPIvX6EzmXZT3aaYGx8TOAupdC0pMTq1mYyk6c6/C
 Y54gGYnvJnj67dB6kDPrGEOD6IJSPOfz47lIoeJJg/Z+/WXqYo7A2ma4DoxIIKI7GfWO
 f7y07EGx//iC7Zjp5XOPWTqPy2mPkM9ZsfrEkGDO2hi1+v5fL0x+3II7S62k23ZNWqIv
 j8mBoQ9PfD2sHDDq+Bix2s+VNTnDQ4wc1Oex/1FkC97psfzJUawOzSm+gGrihly87BAj qA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmh5t8hvg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 10:12:03 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3649s0Zl028843;
 Tue, 4 Jul 2023 10:12:03 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmh5t8hup-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 10:12:03 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3644U74w005378;
 Tue, 4 Jul 2023 10:12:00 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3rjbs4sdyf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 10:12:00 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 364ABwhJ26477284
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Jul 2023 10:11:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 260B02006C;
 Tue,  4 Jul 2023 10:11:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4AB020065;
 Tue,  4 Jul 2023 10:11:57 +0000 (GMT)
Received: from [9.179.4.4] (unknown [9.179.4.4])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Jul 2023 10:11:57 +0000 (GMT)
Message-ID: <ba65ba98-7e27-5727-f58d-f32580f9fbb3@linux.ibm.com>
Date: Tue, 4 Jul 2023 12:11:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/5] ppc/pnv: Add P10 quad xscom model
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20230704054204.168547-1-joel@jms.id.au>
 <20230704054204.168547-4-joel@jms.id.au>
From: Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <20230704054204.168547-4-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eKtfvL4cQukwbQUl52jbFKS4bkd4tRPF
X-Proofpoint-ORIG-GUID: u-d3sM3YkqiFn6hNGvqZFMR_dDVsz3f8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_06,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 bulkscore=0 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040083
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
> Add a PnvQuad class for the P10 powernv machine. No xscoms are
> implemented yet, but this allows them to be added.
> 
> The size is reduced to avoid the quad region from overlapping with the
> core region.
> 
>    address-space: xscom-0
>      0000000000000000-00000003ffffffff (prio 0, i/o): xscom-0
>        0000000100000000-00000001000fffff (prio 0, i/o): xscom-quad.0
>        0000000100108000-0000000100907fff (prio 0, i/o): xscom-core.3
>        0000000100110000-000000010090ffff (prio 0, i/o): xscom-core.2
>        0000000100120000-000000010091ffff (prio 0, i/o): xscom-core.1
>        0000000100140000-000000010093ffff (prio 0, i/o): xscom-core.0
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---


Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>


   Fred


> v2: Fix unimp read message
>      Wrap lines at 80 col
>      Set size
> ---
>   include/hw/ppc/pnv_xscom.h |  2 +-
>   hw/ppc/pnv.c               |  2 +-
>   hw/ppc/pnv_core.c          | 54 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 56 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index cbe848d27ba0..f7da9a1dc617 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -129,7 +129,7 @@ struct PnvXScomInterfaceClass {
>   
>   #define PNV10_XSCOM_EQ_BASE(core)     \
>       ((uint64_t) PNV10_XSCOM_EQ(PNV10_XSCOM_EQ_CHIPLET(core)))
> -#define PNV10_XSCOM_EQ_SIZE        0x100000
> +#define PNV10_XSCOM_EQ_SIZE        0x20000
>   
>   #define PNV10_XSCOM_EC_BASE(core) \
>       ((uint64_t) PNV10_XSCOM_EQ_BASE(core) | PNV10_XSCOM_EC(core & 0x3))
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index c77fdb6747a4..5f25fe985ab2 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1669,7 +1669,7 @@ static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp)
>           PnvQuad *eq = &chip10->quads[i];
>   
>           pnv_chip_quad_realize_one(chip, eq, chip->cores[i * 4],
> -                                  PNV_QUAD_TYPE_NAME("power9"));
> +                                  PNV_QUAD_TYPE_NAME("power10"));
>   
>           pnv_xscom_add_subregion(chip, PNV10_XSCOM_EQ_BASE(eq->quad_id),
>                                   &eq->xscom_regs);
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 73d25409c937..e4df435b15e9 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -404,6 +404,47 @@ static const MemoryRegionOps pnv_quad_power9_xscom_ops = {
>       .endianness = DEVICE_BIG_ENDIAN,
>   };
>   
> +/*
> + * POWER10 Quads
> + */
> +
> +static uint64_t pnv_quad_power10_xscom_read(void *opaque, hwaddr addr,
> +                                            unsigned int width)
> +{
> +    uint32_t offset = addr >> 3;
> +    uint64_t val = -1;
> +
> +    switch (offset) {
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: reading @0x%08x\n", __func__,
> +                      offset);
> +    }
> +
> +    return val;
> +}
> +
> +static void pnv_quad_power10_xscom_write(void *opaque, hwaddr addr,
> +                                         uint64_t val, unsigned int width)
> +{
> +    uint32_t offset = addr >> 3;
> +
> +    switch (offset) {
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: writing @0x%08x\n", __func__,
> +                      offset);
> +    }
> +}
> +
> +static const MemoryRegionOps pnv_quad_power10_xscom_ops = {
> +    .read = pnv_quad_power10_xscom_read,
> +    .write = pnv_quad_power10_xscom_write,
> +    .valid.min_access_size = 8,
> +    .valid.max_access_size = 8,
> +    .impl.min_access_size = 8,
> +    .impl.max_access_size = 8,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +};
> +
>   static void pnv_quad_realize(DeviceState *dev, Error **errp)
>   {
>       PnvQuad *eq = PNV_QUAD(dev);
> @@ -430,6 +471,14 @@ static void pnv_quad_power9_class_init(ObjectClass *oc, void *data)
>       pqc->xscom_size = PNV9_XSCOM_EQ_SIZE;
>   }
>   
> +static void pnv_quad_power10_class_init(ObjectClass *oc, void *data)
> +{
> +    PnvQuadClass *pqc = PNV_QUAD_CLASS(oc);
> +
> +    pqc->xscom_ops = &pnv_quad_power10_xscom_ops;
> +    pqc->xscom_size = PNV10_XSCOM_EQ_SIZE;
> +}
> +
>   static void pnv_quad_class_init(ObjectClass *oc, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(oc);
> @@ -453,6 +502,11 @@ static const TypeInfo pnv_quad_infos[] = {
>           .name = PNV_QUAD_TYPE_NAME("power9"),
>           .class_init = pnv_quad_power9_class_init,
>       },
> +    {
> +        .parent = TYPE_PNV_QUAD,
> +        .name = PNV_QUAD_TYPE_NAME("power10"),
> +        .class_init = pnv_quad_power10_class_init,
> +    },
>   };
>   
>   DEFINE_TYPES(pnv_quad_infos);

