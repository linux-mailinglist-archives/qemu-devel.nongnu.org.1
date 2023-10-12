Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B6F7C74CA
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 19:30:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqzUV-0004M6-6c; Thu, 12 Oct 2023 13:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qqzUD-0004GZ-1d; Thu, 12 Oct 2023 13:28:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qqzU9-000477-N5; Thu, 12 Oct 2023 13:28:36 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CHQUlo004344; Thu, 12 Oct 2023 17:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=o8Pxa06jx//ALeONUfXP4Ir5vGaMMiYtpVoZd/KjO2c=;
 b=pbKf+b4bBuYdzrBOnnK4VJn8UHRsOAltu7r6ax/RVZ7mCwG1ySD9sbXheEx/QCQ5lOvn
 vGxDwT/qiQYlyMpMMkG45eNtTt1AtYyBR8llzxSS6KvMhE3EnAsj+T0kOcSl4yaaHrrO
 9KskWEoffSo9RayW/V+L9CiYT737yuSDB1sF68s6jS41ekScDn7CeWal0GLXrOUnndS5
 MTDjVMSt+VBFhKs3Vj5rMcO58j7IAYG1f0eefZPQLOwiK0Hx/vpYrMiHVrWM+2RcgEZF
 b3sLzSosC3F/SVPrNaRzcCE9JCDsqmbFniNlsrwsERmPOCFao+suTZYmI6Ehpjv1GJSK cw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpmuhgk29-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 17:28:21 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CHQetV005667;
 Thu, 12 Oct 2023 17:28:21 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpmuhgk1r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 17:28:20 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CGGlXm000653; Thu, 12 Oct 2023 17:28:19 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkk5m10tk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 17:28:19 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39CHSJQP50921754
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Oct 2023 17:28:19 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EDE8658056;
 Thu, 12 Oct 2023 17:28:18 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B77315803F;
 Thu, 12 Oct 2023 17:28:18 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Oct 2023 17:28:18 +0000 (GMT)
Message-ID: <d5ff8d0fc62d5731880315c624df338b1923f7d9.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] ppc/pnv: Connect I2C controller model to powernv9 chip
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clegoate@redhat.com>,
 qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com
Date: Thu, 12 Oct 2023 12:28:18 -0500
In-Reply-To: <7c55e7b5-cff6-0f57-b3ff-9869a920f08a@redhat.com>
References: <20231010171951.4165180-1-milesg@linux.vnet.ibm.com>
 <20231010171951.4165180-3-milesg@linux.vnet.ibm.com>
 <7c55e7b5-cff6-0f57-b3ff-9869a920f08a@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1nR-NIJYzGVstQEcdvSePSDLkpV4rSKs
X-Proofpoint-GUID: bSgA2Af3lkK4t0YcnsZ8TjDO7bwYUZdg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_09,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 clxscore=1015 phishscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120145
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On Tue, 2023-10-10 at 22:14 +0200, Cédric Le Goater wrote:
> On 10/10/23 19:19, Glenn Miles wrote:
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
> > Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> > ---
> >   hw/ppc/pnv.c              | 26 ++++++++++++++++++++++++++
> >   include/hw/ppc/pnv_chip.h |  4 ++++
> >   2 files changed, 30 insertions(+)
> > 
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index eb54f93986..32b6d9889d 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -1438,6 +1438,10 @@ static void
> > pnv_chip_power9_instance_init(Object *obj)
> >           object_initialize_child(obj, "pec[*]", &chip9->pecs[i],
> >                                   TYPE_PNV_PHB4_PEC);
> >       }
> > +
> > +    for (i = 0; i < PNV9_CHIP_MAX_I2C; i++) {
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
> > @@ -1613,6 +1618,27 @@ static void
> > pnv_chip_power9_realize(DeviceState *dev, Error **errp)
> >           error_propagate(errp, local_err);
> >           return;
> >       }
> > +
> > +    /*
> > +     * I2C
> > +     * TODO: The number of busses is specific to each platform
> 
> Could the hardcoded values  used in the properties below be
> PnvChipClass
> attributes instead ?
> 
> Thanks,
> 
> C.
> 

Yes, I can do that.

 
> 
> > +     */
> > +    for (i = 0; i < PNV9_CHIP_MAX_I2C; i++) {
> > +        Object *obj =  OBJECT(&chip9->i2c[i]);
> > +
> > +        object_property_set_int(obj, "engine", i + 1,
> > &error_fatal);
> > +        object_property_set_int(obj, "num-busses", 1,
> > &error_fatal);
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
> > diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> > index 53e1d921d7..3bbe2783c9 100644
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
> > @@ -86,6 +87,9 @@ struct Pnv9Chip {
> >   
> >   #define PNV9_CHIP_MAX_PEC 3
> >       PnvPhb4PecState pecs[PNV9_CHIP_MAX_PEC];
> > +
> > +#define PNV9_CHIP_MAX_I2C 3
> > +    PnvI2C      i2c[PNV9_CHIP_MAX_I2C];
> >   };
> >   
> >   /*


