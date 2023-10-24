Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C3E7D599B
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 19:18:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvL2S-0006Tw-Ai; Tue, 24 Oct 2023 13:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qvL2Q-0006Th-9H; Tue, 24 Oct 2023 13:17:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qvL2M-0007hW-9s; Tue, 24 Oct 2023 13:17:54 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OHA9LZ022077; Tue, 24 Oct 2023 17:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Moy+Qka6UgNPMZzlnlNTmLomioA+BthMDSfrdYE0lbM=;
 b=aSLYrL1vituXs/HNv6t1Ot709acl/paj8awItF8mN22xkg9SFDi5h0t4MX5kKLSpdWC0
 eL97qyFcbIqzwwzjuWCRlVH2iuR/8GHCIMWljN4dM0Jt0rz8iUaqvRd2fuXQNH2adPj7
 nBaWS5P5zX4ssugkHjNLF2gItN/DIW+WaMThyMFUg0RKeffSPBnad1u6f0gwi6EABMlv
 /RWQvblBQ6xej4kzkUn9TfYYRnczukkybSvKBicaSM8xuaPpJuEB1B6O7KhrxS3XwDtA
 Kb2rpTFtqwQD/6KTZcmI48JORROkMfSt3LqPJjJfX6np77OQs1egnjYwzTB2eAk1OfMJ KQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txj32r895-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 17:17:44 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39OHAC5l022315;
 Tue, 24 Oct 2023 17:17:43 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txj32r88v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 17:17:43 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OGTZAq026870; Tue, 24 Oct 2023 17:17:43 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvsyns07n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 17:17:43 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39OHHgVj50463452
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Oct 2023 17:17:42 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51ADC5805D;
 Tue, 24 Oct 2023 17:17:42 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22E4B58055;
 Tue, 24 Oct 2023 17:17:42 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Oct 2023 17:17:42 +0000 (GMT)
Message-ID: <96503cb8e1ebdb4ba50c3e939eb3569814b95e5e.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH] ppc/pnv: Fix number of I2C engines and ports for power9/10
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, fbarrat@linux.ibm.com
Date: Tue, 24 Oct 2023 12:17:41 -0500
In-Reply-To: <2aadcbcf-cfc0-45d1-aaec-51aaa09cd7a7@kaod.org>
References: <20231023165200.3846121-1-milesg@linux.vnet.ibm.com>
 <2aadcbcf-cfc0-45d1-aaec-51aaa09cd7a7@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IySjHXwyxZxwn33tP1KouuHZsl5c5Rb1
X-Proofpoint-GUID: buDuEJbnoRIKVJ-j86xxbijG2UKO_Ush
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_16,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 spamscore=0 mlxlogscore=769 impostorscore=0
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310170001 definitions=main-2310240148
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, 2023-10-24 at 07:47 +0200, Cédric Le Goater wrote:
> Hello Glenn,
> 
> On 10/23/23 18:52, Glenn Miles wrote:
> > Power9 is supposed to have 4 PIB-connected I2C engines with the
> > following number of ports on each engine:
> > 
> >      0: 2
> >      1: 13
> >      2: 2
> >      3: 2
> > 
> > Power10 also has 4 engines but has the following number of ports
> > on each engine:
> > 
> >      0: 14
> >      1: 14
> >      2: 2
> >      3: 16
> > 
> > Current code assumes that they all have the same (maximum) number.
> > This can be a problem if software expects to see a certain number
> > of ports present (Power Hypervisor seems to care).
> 
> Nice ! Do you have plans to populate the I2C busses ?
>   

Yes, I'll be adding a pca9552 (possibly two) very soon.  There's also a
a change coming for fixing an i2c master reset issue and something for
resetting the connected I2C buses at realization so that the slave
devices also are reset.  I think I'll add these as a series.

> > Fixed this by adding separate tables for power9 and power10 that
> > map the I2C controller number to the number of I2C buses that
> > should
> > be attached for that engine.
> > 
> > Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> > ---
> > 
> > Based-on: <20231017221434.810363-1-milesg@linux.vnet.ibm.com>
> > ([PATCH] ppc/pnv: Connect PNV I2C controller to powernv10)
> > 
> >   hw/ppc/pnv.c              | 12 ++++++++----
> >   include/hw/ppc/pnv_chip.h |  5 +----
> >   2 files changed, 9 insertions(+), 8 deletions(-)
> > 
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index 2655b6e506..6ad4a1a7b1 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -1507,6 +1507,8 @@ static void
> > pnv_chip_power9_pec_realize(PnvChip *chip, Error **errp)
> >       }
> >   }
> >   
> > +static int pnv_power9_i2c_ports_per_ctlr[PNV9_CHIP_MAX_I2C] = {2,
> > 13, 2, 2};
> 
> The ports array could be under PnvChipClass. 

Ok, I can look into doing that.

> Anyhow,
> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> 
> Thanks,
> 
> C.
> 
> 
> 
> 
> >   static void pnv_chip_power9_realize(DeviceState *dev, Error
> > **errp)
> >   {
> >       PnvChipClass *pcc = PNV_CHIP_GET_CLASS(dev);
> > @@ -1626,7 +1628,8 @@ static void
> > pnv_chip_power9_realize(DeviceState *dev, Error **errp)
> >           Object *obj =  OBJECT(&chip9->i2c[i]);
> >   
> >           object_property_set_int(obj, "engine", i + 1,
> > &error_fatal);
> > -        object_property_set_int(obj, "num-busses", pcc-
> > >i2c_num_ports,
> > +        object_property_set_int(obj, "num-busses",
> > +                                pnv_power9_i2c_ports_per_ctlr[i],
> >                                   &error_fatal);
> >           object_property_set_link(obj, "chip", OBJECT(chip),
> > &error_abort);
> >           if (!qdev_realize(DEVICE(obj), NULL, errp)) {
> > @@ -1667,7 +1670,6 @@ static void
> > pnv_chip_power9_class_init(ObjectClass *klass, void *data)
> >       dc->desc = "PowerNV Chip POWER9";
> >       k->num_pecs = PNV9_CHIP_MAX_PEC;
> >       k->i2c_num_engines = PNV9_CHIP_MAX_I2C;
> > -    k->i2c_num_ports = PNV9_CHIP_MAX_I2C_PORTS;
> >   
> >       device_class_set_parent_realize(dc, pnv_chip_power9_realize,
> >                                       &k->parent_realize);
> > @@ -1751,6 +1753,8 @@ static void
> > pnv_chip_power10_phb_realize(PnvChip *chip, Error **errp)
> >       }
> >   }
> >   
> > +static int pnv_power10_i2c_ports_per_ctlr[PNV10_CHIP_MAX_I2C] =
> > {14, 14, 2, 16};
> > +
> >   static void pnv_chip_power10_realize(DeviceState *dev, Error
> > **errp)
> >   {
> >       PnvChipClass *pcc = PNV_CHIP_GET_CLASS(dev);
> > @@ -1877,7 +1881,8 @@ static void
> > pnv_chip_power10_realize(DeviceState *dev, Error **errp)
> >           Object *obj =  OBJECT(&chip10->i2c[i]);
> >   
> >           object_property_set_int(obj, "engine", i + 1,
> > &error_fatal);
> > -        object_property_set_int(obj, "num-busses", pcc-
> > >i2c_num_ports,
> > +        object_property_set_int(obj, "num-busses",
> > +                                pnv_power10_i2c_ports_per_ctlr[i],
> >                                   &error_fatal);
> >           object_property_set_link(obj, "chip", OBJECT(chip),
> > &error_abort);
> >           if (!qdev_realize(DEVICE(obj), NULL, errp)) {
> > @@ -1918,7 +1923,6 @@ static void
> > pnv_chip_power10_class_init(ObjectClass *klass, void *data)
> >       dc->desc = "PowerNV Chip POWER10";
> >       k->num_pecs = PNV10_CHIP_MAX_PEC;
> >       k->i2c_num_engines = PNV10_CHIP_MAX_I2C;
> > -    k->i2c_num_ports = PNV10_CHIP_MAX_I2C_PORTS;
> >   
> >       device_class_set_parent_realize(dc, pnv_chip_power10_realize,
> >                                       &k->parent_realize);
> > diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> > index 5815d96ecf..be1fec5698 100644
> > --- a/include/hw/ppc/pnv_chip.h
> > +++ b/include/hw/ppc/pnv_chip.h
> > @@ -88,8 +88,7 @@ struct Pnv9Chip {
> >   #define PNV9_CHIP_MAX_PEC 3
> >       PnvPhb4PecState pecs[PNV9_CHIP_MAX_PEC];
> >   
> > -#define PNV9_CHIP_MAX_I2C 3
> > -#define PNV9_CHIP_MAX_I2C_PORTS 1
> > +#define PNV9_CHIP_MAX_I2C 4
> >       PnvI2C      i2c[PNV9_CHIP_MAX_I2C];
> >   };
> >   
> > @@ -122,7 +121,6 @@ struct Pnv10Chip {
> >       PnvPhb4PecState pecs[PNV10_CHIP_MAX_PEC];
> >   
> >   #define PNV10_CHIP_MAX_I2C 4
> > -#define PNV10_CHIP_MAX_I2C_PORTS 2
> >       PnvI2C       i2c[PNV10_CHIP_MAX_I2C];
> >   };
> >   
> > @@ -140,7 +138,6 @@ struct PnvChipClass {
> >       uint32_t     num_phbs;
> >   
> >       uint32_t     i2c_num_engines;
> > -    uint32_t     i2c_num_ports;
> >   
> >       DeviceRealize parent_realize;
> >   


