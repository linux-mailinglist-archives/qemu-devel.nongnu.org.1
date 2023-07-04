Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1321D746E30
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 12:01:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGcqo-000767-8O; Tue, 04 Jul 2023 06:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qGcqh-00075g-Gt; Tue, 04 Jul 2023 06:01:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qGcqf-0005Ix-I5; Tue, 04 Jul 2023 06:01:31 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3649qGf1023079; Tue, 4 Jul 2023 10:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=81WbJ7PMhsv3PQzwhevsbzMulmZwoM4D2EVARvoPTsM=;
 b=iSOtzbLhQaObSczxG0nI5pPU7KHD+wN1hG5TtZIDBLIurkjau7kCWTsguGdGnmHhLYhs
 ToNOskC2mCph5u61+OEnB2jXP67D3p+xmXaMm9bKr7hYxO3vfK/rUd/J4WoigiF0KZ5r
 6K6VAQzaRtSo/P1g2z3nLVwDct6hOflhd58OuPChbIyiIWvvcEsIwWbzILN87w4afAZR
 hepYHkYEVZLRsvUJRkAh4VPaIUE1CHWd2lWzyE39k2u0/B+j5TKiq5gQjv8F/eH57Wg1
 H9lG3HP3/KCxk65gYsnZ3ErWlbs8DnjmxmJdoLVfUd5ALSUMWpEDeplOswMudU18xgA1 ng== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmh5t86bt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 10:01:22 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3649qQcv023355;
 Tue, 4 Jul 2023 10:01:19 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmh5t85wh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 10:01:18 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3642QESd017820;
 Tue, 4 Jul 2023 10:00:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3rjbs4sxre-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 10:00:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3649xwEw21430870
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Jul 2023 09:59:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0EB5620040;
 Tue,  4 Jul 2023 09:59:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ACB7220043;
 Tue,  4 Jul 2023 09:59:57 +0000 (GMT)
Received: from [9.179.4.4] (unknown [9.179.4.4])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Jul 2023 09:59:57 +0000 (GMT)
Message-ID: <6c4df06c-50be-797a-349b-51caf25156f4@linux.ibm.com>
Date: Tue, 4 Jul 2023 11:59:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/5] ppc/pnv: Subclass quad xscom callbacks
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20230704054204.168547-1-joel@jms.id.au>
 <20230704054204.168547-3-joel@jms.id.au>
From: Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <20230704054204.168547-3-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eD7BTOAWr305W25Y33VPQatFZhWzJdu9
X-Proofpoint-ORIG-GUID: txSUfPVTE5605EB7yu-1xj4ZcRN_uqfB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_06,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 bulkscore=0 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0
 mlxlogscore=946 malwarescore=0 adultscore=0 priorityscore=1501
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
> Make the existing pnv_quad_xscom_read/write be P9 specific, in
> preparation for a different P10 callback.
> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---


Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>

   Fred


> v2: Add scom region size to class
> ---
>   include/hw/ppc/pnv_core.h | 13 ++++++++++++-
>   hw/ppc/pnv.c              | 11 +++++++----
>   hw/ppc/pnv_core.c         | 40 ++++++++++++++++++++++++++-------------
>   3 files changed, 46 insertions(+), 18 deletions(-)
> 
> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> index 3d75706e95da..77ef00f47a72 100644
> --- a/include/hw/ppc/pnv_core.h
> +++ b/include/hw/ppc/pnv_core.h
> @@ -60,8 +60,19 @@ static inline PnvCPUState *pnv_cpu_state(PowerPCCPU *cpu)
>       return (PnvCPUState *)cpu->machine_data;
>   }
>   
> +struct PnvQuadClass {
> +    DeviceClass parent_class;
> +
> +    const MemoryRegionOps *xscom_ops;
> +    uint64_t xscom_size;
> +};
> +
>   #define TYPE_PNV_QUAD "powernv-cpu-quad"
> -OBJECT_DECLARE_SIMPLE_TYPE(PnvQuad, PNV_QUAD)
> +
> +#define PNV_QUAD_TYPE_SUFFIX "-" TYPE_PNV_QUAD
> +#define PNV_QUAD_TYPE_NAME(cpu_model) cpu_model PNV_QUAD_TYPE_SUFFIX
> +
> +OBJECT_DECLARE_TYPE(PnvQuad, PnvQuadClass, PNV_QUAD)
>   
>   struct PnvQuad {
>       DeviceState parent_obj;
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index fc083173f346..c77fdb6747a4 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1429,14 +1429,15 @@ static void pnv_chip_power9_instance_init(Object *obj)
>   }
>   
>   static void pnv_chip_quad_realize_one(PnvChip *chip, PnvQuad *eq,
> -                                      PnvCore *pnv_core)
> +                                      PnvCore *pnv_core,
> +                                      const char *type)
>   {
>       char eq_name[32];
>       int core_id = CPU_CORE(pnv_core)->core_id;
>   
>       snprintf(eq_name, sizeof(eq_name), "eq[%d]", core_id);
>       object_initialize_child_with_props(OBJECT(chip), eq_name, eq,
> -                                       sizeof(*eq), TYPE_PNV_QUAD,
> +                                       sizeof(*eq), type,
>                                          &error_fatal, NULL);
>   
>       object_property_set_int(OBJECT(eq), "quad-id", core_id, &error_fatal);
> @@ -1454,7 +1455,8 @@ static void pnv_chip_quad_realize(Pnv9Chip *chip9, Error **errp)
>       for (i = 0; i < chip9->nr_quads; i++) {
>           PnvQuad *eq = &chip9->quads[i];
>   
> -        pnv_chip_quad_realize_one(chip, eq, chip->cores[i * 4]);
> +        pnv_chip_quad_realize_one(chip, eq, chip->cores[i * 4],
> +                                  PNV_QUAD_TYPE_NAME("power9"));
>   
>           pnv_xscom_add_subregion(chip, PNV9_XSCOM_EQ_BASE(eq->quad_id),
>                                   &eq->xscom_regs);
> @@ -1666,7 +1668,8 @@ static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp)
>       for (i = 0; i < chip10->nr_quads; i++) {
>           PnvQuad *eq = &chip10->quads[i];
>   
> -        pnv_chip_quad_realize_one(chip, eq, chip->cores[i * 4]);
> +        pnv_chip_quad_realize_one(chip, eq, chip->cores[i * 4],
> +                                  PNV_QUAD_TYPE_NAME("power9"));
>   
>           pnv_xscom_add_subregion(chip, PNV10_XSCOM_EQ_BASE(eq->quad_id),
>                                   &eq->xscom_regs);
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 0f451b3b6e1f..73d25409c937 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -407,12 +407,14 @@ static const MemoryRegionOps pnv_quad_power9_xscom_ops = {
>   static void pnv_quad_realize(DeviceState *dev, Error **errp)
>   {
>       PnvQuad *eq = PNV_QUAD(dev);
> +    PnvQuadClass *pqc = PNV_QUAD_GET_CLASS(eq);
>       char name[32];
>   
>       snprintf(name, sizeof(name), "xscom-quad.%d", eq->quad_id);
>       pnv_xscom_region_init(&eq->xscom_regs, OBJECT(dev),
> -                          &pnv_quad_power9_xscom_ops,
> -                          eq, name, PNV9_XSCOM_EQ_SIZE);
> +                          pqc->xscom_ops,
> +                          eq, name,
> +                          pqc->xscom_size);
>   }
>   
>   static Property pnv_quad_properties[] = {
> @@ -420,6 +422,14 @@ static Property pnv_quad_properties[] = {
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> +static void pnv_quad_power9_class_init(ObjectClass *oc, void *data)
> +{
> +    PnvQuadClass *pqc = PNV_QUAD_CLASS(oc);
> +
> +    pqc->xscom_ops = &pnv_quad_power9_xscom_ops;
> +    pqc->xscom_size = PNV9_XSCOM_EQ_SIZE;
> +}
> +
>   static void pnv_quad_class_init(ObjectClass *oc, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(oc);
> @@ -429,16 +439,20 @@ static void pnv_quad_class_init(ObjectClass *oc, void *data)
>       dc->user_creatable = false;
>   }
>   
> -static const TypeInfo pnv_quad_info = {
> -    .name          = TYPE_PNV_QUAD,
> -    .parent        = TYPE_DEVICE,
> -    .instance_size = sizeof(PnvQuad),
> -    .class_init    = pnv_quad_class_init,
> +static const TypeInfo pnv_quad_infos[] = {
> +    {
> +        .name          = TYPE_PNV_QUAD,
> +        .parent        = TYPE_DEVICE,
> +        .instance_size = sizeof(PnvQuad),
> +        .class_size    = sizeof(PnvQuadClass),
> +        .class_init    = pnv_quad_class_init,
> +        .abstract      = true,
> +    },
> +    {
> +        .parent = TYPE_PNV_QUAD,
> +        .name = PNV_QUAD_TYPE_NAME("power9"),
> +        .class_init = pnv_quad_power9_class_init,
> +    },
>   };
>   
> -static void pnv_core_register_types(void)
> -{
> -    type_register_static(&pnv_quad_info);
> -}
> -
> -type_init(pnv_core_register_types)
> +DEFINE_TYPES(pnv_quad_infos);

