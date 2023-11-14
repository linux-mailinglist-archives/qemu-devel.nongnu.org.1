Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C656B7EB386
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 16:28:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2vKd-0001mN-S8; Tue, 14 Nov 2023 10:28:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r2vKY-0001kJ-9d; Tue, 14 Nov 2023 10:27:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r2vKW-0001IS-GQ; Tue, 14 Nov 2023 10:27:57 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AEFH72u027632; Tue, 14 Nov 2023 15:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=jfZkOW5bgc5eiq/DJtSlx3cuVshAxqanrOVq4YUUxr4=;
 b=QSGKrF+aphKFrqNbLmcwHhXhCCrKoq39j+AikfFdPf2OYpKzLqULF+cok3ULo/ZjXX7a
 D+5nJ2uYIdrdvZDFUiXNrAropOYv4LWqjbHSC6enFaB0VXAX/GmvL9heib+dX2EtIQAf
 /FFZkTmOpwAFjaymMbneDQVWbWD/8Sqh5S1qjvF9QxMZs0u0h0luFtT6Eu8a25i4h/+Y
 j8pXr0vnH67IC566pIQrj7UQiYKnm3hxQ3WJWwk6tY4r0uiCIjAX3d47nc5zHq71Rzws
 SHNE6FmHHIR+/FEfYyyeB1Up/3Msn7KPjHu/YPiR3strRPZqs3v18PXYVKQVvi29f5vI Hg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucbd90bub-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Nov 2023 15:27:53 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AEFHLYA028585;
 Tue, 14 Nov 2023 15:27:52 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucbd90bu2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Nov 2023 15:27:52 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AEEHb6A014693; Tue, 14 Nov 2023 15:27:52 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamay8wgw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Nov 2023 15:27:52 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AEFRpoR22086386
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Nov 2023 15:27:51 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2571D5804B;
 Tue, 14 Nov 2023 15:27:51 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B13DC58059;
 Tue, 14 Nov 2023 15:27:50 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Nov 2023 15:27:50 +0000 (GMT)
Message-ID: <8d7e592694b2c01d8c0334db7fa04f8f99f5730b.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 3/8] ppc/pnv: PNV I2C engines assigned incorrect
 XSCOM addresses
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, =?ISO-8859-1?Q?Fr=E9d=E9ric?=
 Barrat <fbarrat@linux.ibm.com>
Date: Tue, 14 Nov 2023 09:27:50 -0600
In-Reply-To: <d9424b8a-0b4a-4e5c-b5a1-f49fd2afc0d6@kaod.org>
References: <20231110194925.475909-1-milesg@linux.vnet.ibm.com>
 <20231110194925.475909-4-milesg@linux.vnet.ibm.com>
 <d9424b8a-0b4a-4e5c-b5a1-f49fd2afc0d6@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TXnq0Js5BxyhNjmk1ssvmTfPmMzmNBcN
X-Proofpoint-GUID: kQflBgNH8_oobAm363RvCWH-FxPJSi58
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_15,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 adultscore=0 phishscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=761 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311140119
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

On Mon, 2023-11-13 at 10:07 +0100, Cédric Le Goater wrote:
> On 11/10/23 20:49, Glenn Miles wrote:
> > The PNV I2C engines for power9 and power10 were being assigned a
> > base
> > XSCOM address that was off by one I2C engine's address range such
> > that engine 0 had engine 1's address and so on.  The xscom address
> > assignment was being based on the device tree engine numbering,
> > which
> > starts at 1.  Rather than changing the device tree numbering to
> > start
> > with 0, the addressing was changed to be based on the existing
> > device
> > tree numbers minus one.
> > 
> > Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> 
> Looks like a fix to me. Please add a Fixes: tag and the patch will
> be queued for 8.2
> 
> Thanks,
> 
> C.
> 

Yes, I agree.  Sorry, still learning about all of these tags!

Thanks,

Glenn

> 
> > ---
> >   hw/ppc/pnv.c     | 6 ++++--
> >   hw/ppc/pnv_i2c.c | 2 +-
> >   2 files changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index 0b24d7d8ed..516434bc9c 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -1623,7 +1623,8 @@ static void
> > pnv_chip_power9_realize(DeviceState *dev, Error **errp)
> >               return;
> >           }
> >           pnv_xscom_add_subregion(chip, PNV9_XSCOM_I2CM_BASE +
> > -                               chip9->i2c[i].engine *
> > PNV9_XSCOM_I2CM_SIZE,
> > +                                (chip9->i2c[i].engine - 1) *
> > +                                        PNV9_XSCOM_I2CM_SIZE,
> >                                   &chip9->i2c[i].xscom_regs);
> >           qdev_connect_gpio_out(DEVICE(&chip9->i2c[i]), 0,
> >                                 qdev_get_gpio_in(DEVICE(&chip9-
> > >psi),
> > @@ -1871,7 +1872,8 @@ static void
> > pnv_chip_power10_realize(DeviceState *dev, Error **errp)
> >               return;
> >           }
> >           pnv_xscom_add_subregion(chip, PNV10_XSCOM_I2CM_BASE +
> > -                                chip10->i2c[i].engine *
> > PNV10_XSCOM_I2CM_SIZE,
> > +                                (chip10->i2c[i].engine - 1) *
> > +                                        PNV10_XSCOM_I2CM_SIZE,
> >                                   &chip10->i2c[i].xscom_regs);
> >           qdev_connect_gpio_out(DEVICE(&chip10->i2c[i]), 0,
> >                                 qdev_get_gpio_in(DEVICE(&chip10-
> > >psi),
> > diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
> > index f75e59e709..b2c738da50 100644
> > --- a/hw/ppc/pnv_i2c.c
> > +++ b/hw/ppc/pnv_i2c.c
> > @@ -593,7 +593,7 @@ static int pnv_i2c_dt_xscom(PnvXScomInterface
> > *dev, void *fdt,
> >       int i2c_offset;
> >       const char i2c_compat[] = "ibm,power8-i2cm\0ibm,power9-i2cm";
> >       uint32_t i2c_pcba = PNV9_XSCOM_I2CM_BASE +
> > -        i2c->engine * PNV9_XSCOM_I2CM_SIZE;
> > +        (i2c->engine - 1) * PNV9_XSCOM_I2CM_SIZE;
> >       uint32_t reg[2] = {
> >           cpu_to_be32(i2c_pcba),
> >           cpu_to_be32(PNV9_XSCOM_I2CM_SIZE)


