Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FC17F33E4
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 17:36:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Tji-0007zt-Uu; Tue, 21 Nov 2023 11:36:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r5Tjc-0007py-W9; Tue, 21 Nov 2023 11:36:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r5Tja-0003ru-U5; Tue, 21 Nov 2023 11:36:24 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ALGC1Pb031848; Tue, 21 Nov 2023 16:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=8mCtJGNvRs08/retz/MwyO+/Hqby7Vx6mcMwAlX9waQ=;
 b=FrHGidEh6u77zKEHu2r9FonbTdTt883f9OFA5c+pfgr3oE/2YMJ8/NW04BRmRMRaBGk9
 3r2Uk4/4TzbI7QXKL8UJP9WfE74En2CPeJ3d2rZUK1XEO6uTGVSSRoV9VTtxxGaJKtFM
 RVPeuLPIHDOX67qYcnQMy/y1T0qXAbG4pLdZFUY28WAg5mLZPNSh8oH74qYmUXsixJDD
 wTElfXJkGPTtmot39oHDpgtLdio/H8EReTW+Bk1s1wgBoAr+VqlXfhFywnX1RSW+hmbz
 9nfPVkHn28lkIPXvce2preXn45MlfjpaPkQwdjvKXTuvtYo9tkGn1xkzgnXqsju+EwX9 rA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ugygt1gca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Nov 2023 16:36:13 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ALGT190012438;
 Tue, 21 Nov 2023 16:36:13 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ugygt1gbt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Nov 2023 16:36:13 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ALGIq4G007432; Tue, 21 Nov 2023 16:36:13 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf8knsw15-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Nov 2023 16:36:12 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3ALGaCdq49152436
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Nov 2023 16:36:12 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB50E58062;
 Tue, 21 Nov 2023 16:36:11 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9085D5805C;
 Tue, 21 Nov 2023 16:36:11 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Nov 2023 16:36:11 +0000 (GMT)
Message-ID: <2e0854faea5c520512f903420f91f153e3287532.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 03/11] ppc/pnv: New powernv10-rainier machine type
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Nicholas Piggin
 <npiggin@gmail.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat <fbarrat@linux.ibm.com>
Date: Tue, 21 Nov 2023 10:36:11 -0600
In-Reply-To: <31af40b3-a6c8-467c-8ef0-63e370465a9a@kaod.org>
References: <20231120235112.1951342-1-milesg@linux.vnet.ibm.com>
 <20231120235112.1951342-4-milesg@linux.vnet.ibm.com>
 <CX43Q4CXT43G.16NTWUAWGGXCB@wheely>
 <31af40b3-a6c8-467c-8ef0-63e370465a9a@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ph_aA67qJkSlG5JqGTKlzXsaSs74acjM
X-Proofpoint-GUID: 1Ou6wBU0aJo9ipmmJUzeVKpmZSayKtbu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_09,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210129
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

On Tue, 2023-11-21 at 08:29 +0100, Cédric Le Goater wrote:
> On 11/21/23 02:33, Nicholas Piggin wrote:
> > On Tue Nov 21, 2023 at 9:51 AM AEST, Glenn Miles wrote:
> > > Create a new powernv machine type, powernv10-rainier, that
> > > will contain rainier-specific devices.
> > 
> > Is the plan to have a base powernv10 common to all and then
> > powernv10-rainier looks like a Rainier? Or would powernv10
> > just be a rainier?
> > 
> > It's fine to structure code this way, I'm just wondering about
> > the machine types available to user. Is a base powernv10 machine
> > useful to run?
> 
> There are multiple P10 boards defined in Linux :
> 
>    aspeed-bmc-ibm-bonnell.dts
>    aspeed-bmc-ibm-everest.dts
>    aspeed-bmc-ibm-rainier-1s4u.dts
>    aspeed-bmc-ibm-rainier-4u.dts
>    aspeed-bmc-ibm-rainier.dts
> 
> and we could model the machines above with a fixed number of sockets.
> The "powernv10" would be the generic system that can be customized
> at will on the command line, even I2C devices. There is also the
> P10 Denali which is FSP based. This QEMU machine would certainly be
> very different. I thought of doing the same for P9 with a -zaius
> and include NPU2 models for it. I lacked time and the interest was
> small at the time of OpenPOWER.
> 
> Anyhow, adding a new machine makes sense and it prepares ground for
> possible new ones. I am OK with or without. As primary users, you are
> the ones that can tell if there will be a second machine.
>   
> Thanks,
> 
> C.
> 

I am not sure what the powernv10 machine would be used for.  The
only reason I kept it was because I didn't want to break anyone out
there that might be using it.

My preference would have been to just make powernv10-rainier an
alias of the powernv10 machine, but only one alias name per machine
is supported and there is already a plan to make "powernv" an
alias for the powernv10 machine.

Thanks,

Glenn

> 
> > > Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> > > ---
> > >   hw/ppc/pnv.c | 29 +++++++++++++++++++++++++++--
> > >   1 file changed, 27 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > > index 9c29727337..3481a1220e 100644
> > > --- a/hw/ppc/pnv.c
> > > +++ b/hw/ppc/pnv.c
> > > @@ -2249,7 +2249,7 @@ static void
> > > pnv_machine_power9_class_init(ObjectClass *oc, void *data)
> > >       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
> > >   }
> > >   
> > > -static void pnv_machine_power10_class_init(ObjectClass *oc, void
> > > *data)
> > > +static void pnv_machine_p10_common_class_init(ObjectClass *oc,
> > > void *data)
> > >   {
> > >       MachineClass *mc = MACHINE_CLASS(oc);
> > >       PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
> > > @@ -2261,7 +2261,6 @@ static void
> > > pnv_machine_power10_class_init(ObjectClass *oc, void *data)
> > >           { TYPE_PNV_PHB_ROOT_PORT, "version", "5" },
> > >       };
> > >   
> > > -    mc->desc = "IBM PowerNV (Non-Virtualized) POWER10";
> > >       mc->default_cpu_type =
> > > POWERPC_CPU_TYPE_NAME("power10_v2.0");
> > >       compat_props_add(mc->compat_props, phb_compat,
> > > G_N_ELEMENTS(phb_compat));
> > >   
> > > @@ -2274,6 +2273,23 @@ static void
> > > pnv_machine_power10_class_init(ObjectClass *oc, void *data)
> > >       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
> > >   }
> > >   
> > > +static void pnv_machine_power10_class_init(ObjectClass *oc, void
> > > *data)
> > > +{
> > > +    MachineClass *mc = MACHINE_CLASS(oc);
> > > +
> > > +    pnv_machine_p10_common_class_init(oc, data);
> > > +    mc->desc = "IBM PowerNV (Non-Virtualized) POWER10";
> > > +
> > > +}
> > > +
> > > +static void pnv_machine_p10_rainier_class_init(ObjectClass *oc,
> > > void *data)
> > > +{
> > > +    MachineClass *mc = MACHINE_CLASS(oc);
> > > +
> > > +    pnv_machine_p10_common_class_init(oc, data);
> > > +    mc->desc = "IBM PowerNV (Non-Virtualized) POWER10 rainier";
> > > +}
> > > +
> > >   static bool pnv_machine_get_hb(Object *obj, Error **errp)
> > >   {
> > >       PnvMachineState *pnv = PNV_MACHINE(obj);
> > > @@ -2379,6 +2395,15 @@ static void
> > > pnv_machine_class_init(ObjectClass *oc, void *data)
> > >       }
> > >   
> > >   static const TypeInfo types[] = {
> > > +    {
> > > +        .name          = MACHINE_TYPE_NAME("powernv10-rainier"),
> > > +        .parent        = TYPE_PNV_MACHINE,
> > > +        .class_init    = pnv_machine_p10_rainier_class_init,
> > > +        .interfaces = (InterfaceInfo[]) {
> > > +            { TYPE_XIVE_FABRIC },
> > > +            { },
> > > +        },
> > > +    },
> > >       {
> > >           .name          = MACHINE_TYPE_NAME("powernv10"),
> > >           .parent        = TYPE_PNV_MACHINE,


