Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 644197F3571
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 19:00:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5V1Q-0000p9-4r; Tue, 21 Nov 2023 12:58:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r5V1N-0000o6-Ng; Tue, 21 Nov 2023 12:58:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r5V1L-0004ne-4N; Tue, 21 Nov 2023 12:58:48 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ALHkAtQ024235; Tue, 21 Nov 2023 17:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=0wuSHaQPK9I/5wEWljfpu0Wb2mWPtj5ySO9t6ICaDfY=;
 b=toDI4rsNwPkgFYlbnm35X1hRILugkkKZUhpvro9NarXkilOMbIZclCaYvIwVIIHotbwF
 kLny8CXjonDCQ7T7vLUCq6BhorqqCwz6XO32ZeAAatRcDgUEvHZsOUjVbsIuCrb1y0TY
 6rgvrJWxpHDnmne5Tfn1Z5mxxfnIKdlI5lKsR0YMBQ3g0wCVHXOHKa+2EM3/GUt25uGn
 GfYPMukasmgFBFkqUVx2rZoBwSiVpWvvlJYcq07js544XNpmBrDyfxRY6u2g57iOZ+3N
 AU5oFzYxb2P/Z4p3us7zoPkMNT00zvIOuZFPelAtMcmqPJAoJ29vwYQl6ylN0vUK77AB rg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh0ct9y4q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Nov 2023 17:58:43 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ALHlT70029422;
 Tue, 21 Nov 2023 17:58:43 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh0ct9y4e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Nov 2023 17:58:43 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ALGIm3X007404; Tue, 21 Nov 2023 17:58:42 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf8knte6v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Nov 2023 17:58:42 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3ALHwgOO21889566
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Nov 2023 17:58:42 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB5F35805D;
 Tue, 21 Nov 2023 17:58:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C79C658058;
 Tue, 21 Nov 2023 17:58:41 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Nov 2023 17:58:41 +0000 (GMT)
Message-ID: <fa293e804e3faaffbab8d54e817f50c40211bda4.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 03/11] ppc/pnv: New powernv10-rainier machine type
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, =?ISO-8859-1?Q?Fr=E9d=E9ric?=
 Barrat <fbarrat@linux.ibm.com>
Date: Tue, 21 Nov 2023 11:58:41 -0600
In-Reply-To: <67081798-658f-4a9f-b0be-ba8e4f3779db@kaod.org>
References: <20231120235112.1951342-1-milesg@linux.vnet.ibm.com>
 <20231120235112.1951342-4-milesg@linux.vnet.ibm.com>
 <67081798-658f-4a9f-b0be-ba8e4f3779db@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -XWa_bg11psQlTiL9ncaaUWTnvDxLRf4
X-Proofpoint-GUID: c-nf3z1TT0zf-fMKJE8N7C5Mmwg4zmzR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_10,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=968 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311210141
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On Tue, 2023-11-21 at 07:46 +0100, Cédric Le Goater wrote:
> On 11/21/23 00:51, Glenn Miles wrote:
> > Create a new powernv machine type, powernv10-rainier, that
> > will contain rainier-specific devices.
> > 
> > Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> > ---
> >   hw/ppc/pnv.c | 29 +++++++++++++++++++++++++++--
> >   1 file changed, 27 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index 9c29727337..3481a1220e 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -2249,7 +2249,7 @@ static void
> > pnv_machine_power9_class_init(ObjectClass *oc, void *data)
> >       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
> >   }
> >   
> > -static void pnv_machine_power10_class_init(ObjectClass *oc, void
> > *data)
> > +static void pnv_machine_p10_common_class_init(ObjectClass *oc,
> > void *data)
> >   {
> >       MachineClass *mc = MACHINE_CLASS(oc);
> >       PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
> > @@ -2261,7 +2261,6 @@ static void
> > pnv_machine_power10_class_init(ObjectClass *oc, void *data)
> >           { TYPE_PNV_PHB_ROOT_PORT, "version", "5" },
> >       };
> >   
> > -    mc->desc = "IBM PowerNV (Non-Virtualized) POWER10";
> 
> I would keep this description because the "powernv10" machine still
> can
> be used, without I2C devices. Unless we don't want to ?
> 

I'm not sure about the usefulness of the powernv10 machine, but the
description still exists in the pnv_machine_power10_class_init function
(and is unchanged).  The pnv_machine_p10_common_class_init function was
created to hold initialization of things that are common between all
P10 machines, and is called by all power10 based machines (powernv10
and powernv10-rainier so far).

> >       mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
> >       compat_props_add(mc->compat_props, phb_compat,
> > G_N_ELEMENTS(phb_compat));
> >   
> > @@ -2274,6 +2273,23 @@ static void
> > pnv_machine_power10_class_init(ObjectClass *oc, void *data)
> >       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
> >   }
> >   
> > +static void pnv_machine_power10_class_init(ObjectClass *oc, void
> > *data)
> > +{
> > +    MachineClass *mc = MACHINE_CLASS(oc);
> > +
> > +    pnv_machine_p10_common_class_init(oc, data);
> > +    mc->desc = "IBM PowerNV (Non-Virtualized) POWER10";
> > +
> 
> Superfluous white line.
> 
Removed in v5.

> > +}
> > +
> > +static void pnv_machine_p10_rainier_class_init(ObjectClass *oc,
> > void *data)
> > +{
> > +    MachineClass *mc = MACHINE_CLASS(oc);
> > +
> > +    pnv_machine_p10_common_class_init(oc, data);
> > +    mc->desc = "IBM PowerNV (Non-Virtualized) POWER10 rainier";
> > +}
> > +
> >   static bool pnv_machine_get_hb(Object *obj, Error **errp)
> >   {
> >       PnvMachineState *pnv = PNV_MACHINE(obj);
> > @@ -2379,6 +2395,15 @@ static void
> > pnv_machine_class_init(ObjectClass *oc, void *data)
> >       }
> >   
> >   static const TypeInfo types[] = {
> > +    {
> > +        .name          = MACHINE_TYPE_NAME("powernv10-rainier"),
> > +        .parent        = TYPE_PNV_MACHINE,
> 
> Could the parent be :
> 
>              .parent          = MACHINE_TYPE_NAME("powernv10"),
> 
> This should avoid the definition of the .interfaces below.
> 
> Thanks,
> 
> C.
> 

Changed as suggested in v5.

Thanks,

Glenn

> 
> 
> > +        .class_init    = pnv_machine_p10_rainier_class_init,
> > +        .interfaces = (InterfaceInfo[]) {
> > +            { TYPE_XIVE_FABRIC },
> > +            { },
> > +        },
> > +    },
> >       {
> >           .name          = MACHINE_TYPE_NAME("powernv10"),
> >           .parent        = TYPE_PNV_MACHINE,


