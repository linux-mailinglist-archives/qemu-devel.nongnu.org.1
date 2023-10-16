Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 085577CB199
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 19:50:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsRiM-0005Df-KS; Mon, 16 Oct 2023 13:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qsRiC-0005Cn-HU; Mon, 16 Oct 2023 13:49:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qsRiA-0006Fs-L9; Mon, 16 Oct 2023 13:49:04 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39GHmnxS003775; Mon, 16 Oct 2023 17:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=6axfaTqrE3aeM/2v70pu+v0sctsybjV33DLDaB8Ixvo=;
 b=kzFytJmaY/uxbYYwFqnjDfbeyxbhnDizmU+6y+oRbt5cZiIfyZsfCUba15TJuf72RT3e
 gZok9jLYstnjT1qs6MHKqFYaNTMGXlAiZbzy9MltXV+ipHPcPANTVgxJduyg9TSahW26
 POj8iHKj+Kpv8yDpH1p3OUFUmW4DRRX5YYM87tdcfRODPqCvplDk9fidh352eCmq57yj
 uaYz2gNgKZrpuej7hkx7pNhS8IqFniytvBk6ZOTRGI8WdQt3gL2lbSAMaDr1/RLRB2eQ
 wk1zE5srkSqblfNTNCNv2oEnr5Z4gYZKYf/eNPUGtcvTMJ7qSpWR31EUw8UoGc4PkoMj XA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ts9seg4ge-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 17:48:50 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39GHmmrR003705;
 Mon, 16 Oct 2023 17:48:48 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ts9seg3n4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 17:48:46 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39GHDEmu012876; Mon, 16 Oct 2023 17:44:11 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr5py2p11-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 17:44:11 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39GHiAWj19726870
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Oct 2023 17:44:10 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 092B15804B;
 Mon, 16 Oct 2023 17:44:10 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D59858059;
 Mon, 16 Oct 2023 17:44:09 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Oct 2023 17:44:09 +0000 (GMT)
Message-ID: <c5e0fc00db02171917fc09d5a3ba62ad9467ad21.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] ppc/pnv: Connect I2C controller model to
 powernv9 chip
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, fbarrat@linux.ibm.com
Date: Mon, 16 Oct 2023 12:44:09 -0500
In-Reply-To: <0e74b396-5c15-43e9-87b7-2f87c6a7dd6c@kaod.org>
References: <20231012200851.3020858-1-milesg@linux.vnet.ibm.com>
 <20231012200851.3020858-3-milesg@linux.vnet.ibm.com>
 <0e74b396-5c15-43e9-87b7-2f87c6a7dd6c@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Rhd72Eu1NNoMvb7ONs4DnaxpeovjYrrV
X-Proofpoint-ORIG-GUID: ipTiasrClfmVFKGLrH0VorMgM2GxQ8W3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_10,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 adultscore=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310160155
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

On Fri, 2023-10-13 at 09:06 +0200, Cédric Le Goater wrote:
> On 10/12/23 22:08, Glenn Miles wrote:
> > From: Cédric Le Goater <clg@kaod.org>
> > 
> > Wires up three I2C controller instances to the powernv9 chip
> > XSCOM address space.
> > 
> > Each controller instance is wired up to a single I2C bus of
> > its own.  No other I2C devices are connected to the buses
> > at this time.
> > 
> > Signed-off-by: Cédric Le Goater <clg@kaod.org>
> > [milesg: Split wiring from addition of model itself]
> > [milesg: Added new commit message]
> > [milesg: Moved hardcoded attributes into PnvChipClass]
> > Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> > ---
> > 
> > Changes in v2:
> >      - Moved some hardcoded attributes into PnvChipClass
> > 
> >   hw/ppc/pnv.c              | 29 +++++++++++++++++++++++++++++
> >   include/hw/ppc/pnv_chip.h |  8 ++++++++
> >   2 files changed, 37 insertions(+)
> > 
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index eb54f93986..7db6f3abe5 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -1438,6 +1438,10 @@ static void
> > pnv_chip_power9_instance_init(Object *obj)
> >           object_initialize_child(obj, "pec[*]", &chip9->pecs[i],
> >                                   TYPE_PNV_PHB4_PEC);
> >       }
> > +
> > +    for (i = 0; i < pcc->i2c_num_engines; i++) {
> > +        object_initialize_child(obj, "i2c[*]", &chip9->i2c[i],
> > TYPE_PNV_I2C);
> > +    }
> >   }
> >   
> >   static void pnv_chip_quad_realize_one(PnvChip *chip, PnvQuad *eq,
> > @@ -1510,6 +1514,7 @@ static void
> > pnv_chip_power9_realize(DeviceState *dev, Error **errp)
> >       PnvChip *chip = PNV_CHIP(dev);
> >       Pnv9Psi *psi9 = &chip9->psi;
> >       Error *local_err = NULL;
> > +    int i;
> >   
> >       /* XSCOM bridge is first */
> >       pnv_xscom_realize(chip, PNV9_XSCOM_SIZE, &local_err);
> > @@ -1613,6 +1618,28 @@ static void
> > pnv_chip_power9_realize(DeviceState *dev, Error **errp)
> >           error_propagate(errp, local_err);
> >           return;
> >       }
> > +
> > +    /*
> > +     * I2C
> > +     * TODO: The number of busses is specific to each platform
> 
> I would remove the TODO now,
> 
Ok, done.

> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> 
> Thanks,
> 
> C.
> 
> 

Thank for the review!  I'll be sending out a v3 shortly.

Glenn

> > +     */
> > +    for (i = 0; i < pcc->i2c_num_engines; i++) {
> > +        Object *obj =  OBJECT(&chip9->i2c[i]);
> > +
> > +        object_property_set_int(obj, "engine", i + 1,
> > &error_fatal);
> > +        object_property_set_int(obj, "num-busses", pcc-
> > >i2c_num_ports,
> > +                                &error_fatal);
> > +        object_property_set_link(obj, "chip", OBJECT(chip),
> > &error_abort);
> > +        if (!qdev_realize(DEVICE(obj), NULL, errp)) {
> > +            return;
> > +        }
> > +        pnv_xscom_add_subregion(chip, PNV9_XSCOM_I2CM_BASE +
> > +                               chip9->i2c[i].engine *
> > PNV9_XSCOM_I2CM_SIZE,
> > +                                &chip9->i2c[i].xscom_regs);
> > +        qdev_connect_gpio_out(DEVICE(&chip9->i2c[i]), 0,
> > +                              qdev_get_gpio_in(DEVICE(&chip9-
> > >psi),
> > +                                               PSIHB9_IRQ_SBE_I2C)
> > );
> > +    }
> >   }
> >   
> >   static uint32_t pnv_chip_power9_xscom_pcba(PnvChip *chip,
> > uint64_t addr)
> > @@ -1640,6 +1667,8 @@ static void
> > pnv_chip_power9_class_init(ObjectClass *klass, void *data)
> >       k->xscom_pcba = pnv_chip_power9_xscom_pcba;
> >       dc->desc = "PowerNV Chip POWER9";
> >       k->num_pecs = PNV9_CHIP_MAX_PEC;
> > +    k->i2c_num_engines = PNV9_CHIP_MAX_I2C;
> > +    k->i2c_num_ports = PNV9_CHIP_MAX_I2C_PORTS;
> >   
> >       device_class_set_parent_realize(dc, pnv_chip_power9_realize,
> >                                       &k->parent_realize);
> > diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> > index 53e1d921d7..90cfbad1a5 100644
> > --- a/include/hw/ppc/pnv_chip.h
> > +++ b/include/hw/ppc/pnv_chip.h
> > @@ -9,6 +9,7 @@
> >   #include "hw/ppc/pnv_psi.h"
> >   #include "hw/ppc/pnv_sbe.h"
> >   #include "hw/ppc/pnv_xive.h"
> > +#include "hw/ppc/pnv_i2c.h"
> >   #include "hw/sysbus.h"
> >   
> >   OBJECT_DECLARE_TYPE(PnvChip, PnvChipClass,
> > @@ -86,6 +87,10 @@ struct Pnv9Chip {
> >   
> >   #define PNV9_CHIP_MAX_PEC 3
> >       PnvPhb4PecState pecs[PNV9_CHIP_MAX_PEC];
> > +
> > +#define PNV9_CHIP_MAX_I2C 3
> > +#define PNV9_CHIP_MAX_I2C_PORTS 1
> > +    PnvI2C      i2c[PNV9_CHIP_MAX_I2C];
> >   };
> >   
> >   /*
> > @@ -130,6 +135,9 @@ struct PnvChipClass {
> >       uint32_t     num_pecs;
> >       uint32_t     num_phbs;
> >   
> > +    uint32_t     i2c_num_engines;
> > +    uint32_t     i2c_num_ports;
> > +
> >       DeviceRealize parent_realize;
> >   
> >       uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);


