Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AEC8B3E72
	for <lists+qemu-devel@lfdr.de>; Fri, 26 Apr 2024 19:39:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0PXt-0001rO-Sc; Fri, 26 Apr 2024 13:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0PXS-0001oO-1p; Fri, 26 Apr 2024 13:39:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0PXQ-0006zo-Dg; Fri, 26 Apr 2024 13:39:09 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QHZWcE008552; Fri, 26 Apr 2024 17:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=ZPu1Gxnt7U+bNxEjrbuUuBmfMPmHCNzgrwSQDb9iELM=;
 b=ZwVCq2aZn6bot68K1GJFBCzDLYIGFq/0IgqiaRZhGo694IyUcXFPM2y6iywEc5gQERcU
 ADab5Yiw0WONKlhAxRrzJeBmsU/7HkXMNRVeTWMztGWTRELS3bd4kdHeDbDJd8FlrK8e
 kX4KHBXt+5W9PaXk4k8YserG2mt0OAxVdF1yjzrp/z38rCrkJwUn140Eag6SeDrNLZbf
 OHDqyI0RBiFBvbjz5cRHew3C7IQsgw91kpNR6wo/BmcxmP7oiLthJVTN65OsHp+iJZes
 72zvvu0mkgfxSyBYOYGTQ/L9AFpbOLtOj7C0Bt6iGNvsT59jRfXtBs+dEBFUwemaVfuC TA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrgay023x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:39:04 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43QHd3nb013015;
 Fri, 26 Apr 2024 17:39:03 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrgay023u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:39:03 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QG9PoY015343; Fri, 26 Apr 2024 17:39:03 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmshmrv4u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:39:03 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43QHcvui25428370
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Apr 2024 17:38:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C39B2004B;
 Fri, 26 Apr 2024 17:38:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 366FD20040;
 Fri, 26 Apr 2024 17:38:55 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.171.36.162])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 26 Apr 2024 17:38:54 +0000 (GMT)
Date: Fri, 26 Apr 2024 23:08:52 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org,
 =?utf-8?B?RnLDqWTDqXJpYw==?= Barrat <fbarrat@linux.ibm.com>
Subject: Re: [PATCH v2 06/10] ppc/pnv: Add OCC for Power11
Message-ID: <ce35q6jtfdcqgnnikdj652lwqxlby6l4piasyhyqblyqii7idu@7ggzayqk47ml>
References: <20240426110023.733309-1-adityag@linux.ibm.com>
 <20240426110023.733309-7-adityag@linux.ibm.com>
 <71cc400b-0c24-4f55-874e-9e0dd39ee55c@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71cc400b-0c24-4f55-874e-9e0dd39ee55c@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C0Qr1QJLyqbVAQHq1C5DSdoND1X6tikT
X-Proofpoint-ORIG-GUID: QWQ27RvC_kGwaWLNduyW_bH-OdlOAEwS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_14,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=903
 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260120
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Fri, Apr 26, 2024 at 04:33:13PM +0200, C�dric Le Goater wrote:
> On 4/26/24 13:00, Aditya Gupta wrote:
> > Power11 core is same as Power10, reuse PNV10_OCC initialisation,
> > by declaring `PNV11_OCC` as child class of `PNV10_OCC`
> 
> Reviewed-by: C�dric Le Goater <clg@kaod.org>

Thanks C�dric !

- Aditya Gupta

> 
> Thanks,
> 
> C.
> 
> 
> 
> > 
> > Cc: C�dric Le Goater <clg@kaod.org>
> > Cc: Fr�d�ric Barrat <fbarrat@linux.ibm.com>
> > Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> > Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> > ---
> >   hw/ppc/pnv_occ.c         | 14 ++++++++++++++
> >   include/hw/ppc/pnv_occ.h |  2 ++
> >   2 files changed, 16 insertions(+)
> > 
> > diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
> > index 48123ceae176..4f510419045e 100644
> > --- a/hw/ppc/pnv_occ.c
> > +++ b/hw/ppc/pnv_occ.c
> > @@ -262,6 +262,19 @@ static const TypeInfo pnv_occ_power10_type_info = {
> >       .class_init    = pnv_occ_power10_class_init,
> >   };
> > +static void pnv_occ_power11_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc = DEVICE_CLASS(klass);
> > +
> > +    dc->desc = "PowerNV OCC Controller (POWER11)";
> > +}
> > +
> > +static const TypeInfo pnv_occ_power11_type_info = {
> > +    .name          = TYPE_PNV11_OCC,
> > +    .parent        = TYPE_PNV10_OCC,
> > +    .class_init    = pnv_occ_power11_class_init,
> > +};
> > +
> >   static void pnv_occ_realize(DeviceState *dev, Error **errp)
> >   {
> >       PnvOCC *occ = PNV_OCC(dev);
> > @@ -305,6 +318,7 @@ static void pnv_occ_register_types(void)
> >       type_register_static(&pnv_occ_power8_type_info);
> >       type_register_static(&pnv_occ_power9_type_info);
> >       type_register_static(&pnv_occ_power10_type_info);
> > +    type_register_static(&pnv_occ_power11_type_info);
> >   }
> >   type_init(pnv_occ_register_types);
> > diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
> > index df321244e3b1..7b5e28f13b4f 100644
> > --- a/include/hw/ppc/pnv_occ.h
> > +++ b/include/hw/ppc/pnv_occ.h
> > @@ -34,6 +34,8 @@ DECLARE_INSTANCE_CHECKER(PnvOCC, PNV9_OCC,
> >                            TYPE_PNV9_OCC)
> >   #define TYPE_PNV10_OCC TYPE_PNV_OCC "-POWER10"
> >   DECLARE_INSTANCE_CHECKER(PnvOCC, PNV10_OCC, TYPE_PNV10_OCC)
> > +#define TYPE_PNV11_OCC TYPE_PNV_OCC "-POWER11"
> > +DECLARE_INSTANCE_CHECKER(PnvOCC, PNV11_OCC, TYPE_PNV11_OCC)
> >   #define PNV_OCC_SENSOR_DATA_BLOCK_OFFSET 0x00580000
> >   #define PNV_OCC_SENSOR_DATA_BLOCK_SIZE   0x00025800
> 

