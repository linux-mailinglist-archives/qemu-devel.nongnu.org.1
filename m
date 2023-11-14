Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E14F7EB383
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 16:28:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2vJc-0000zy-5e; Tue, 14 Nov 2023 10:27:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r2vJZ-0000zS-Kz; Tue, 14 Nov 2023 10:26:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r2vJW-0001E3-7H; Tue, 14 Nov 2023 10:26:56 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AEFGO7t002001; Tue, 14 Nov 2023 15:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=e5L3jYwvCYAoXcdm7aUjhPMmDjibyLauW11yNWm8ffY=;
 b=pbKgVl49uxbVY9GukGw5uKIMJzcUAV1zU5LrAjqaAFahZAAWJf4XO9LY9Xfe+6jn3HH4
 rcp2BOVWw3R0mIvlQEIX6EEltYyba84Hu/YUB2872gUtm26bvvVEIofOCfolnvv9QodS
 hzNLo9RWZu5N2PK6eMOwYq+hSL1QtV21nK7ZELwy8d3XQy2x/vMeVcJvPRWAUF2MsyzS
 2H9AJu1qfa4tfWOODcwZI7J7QKCVw1GUdOUd4GJnY1CvMPJDrCRDJn4V/EOFfqybJhmt
 YFL8MYI1NyYnbUMXQiaoa52QWMnu8QsjyWK/TikGoMV92D3lHbUW4GR+juEWQiVj3gCh QA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucb5fgx1y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Nov 2023 15:26:51 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AEFGjXQ005063;
 Tue, 14 Nov 2023 15:26:50 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucb5fgx1k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Nov 2023 15:26:50 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AEE2M7A029428; Tue, 14 Nov 2023 15:26:50 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uakxss2sx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Nov 2023 15:26:49 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AEFQn5G18023028
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Nov 2023 15:26:49 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2CC2758058;
 Tue, 14 Nov 2023 15:26:49 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7CFB5805E;
 Tue, 14 Nov 2023 15:26:48 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Nov 2023 15:26:48 +0000 (GMT)
Message-ID: <be493d52dd58df3205b0055ce75d7026bc18b8c2.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 4/8] ppc/pnv: Fix PNV I2C invalid status after reset
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, =?ISO-8859-1?Q?Fr=E9d=E9ric?=
 Barrat <fbarrat@linux.ibm.com>
Date: Tue, 14 Nov 2023 09:26:48 -0600
In-Reply-To: <1605799c-86d5-46be-b7ac-ed7e465d7013@kaod.org>
References: <20231110194925.475909-1-milesg@linux.vnet.ibm.com>
 <20231110194925.475909-5-milesg@linux.vnet.ibm.com>
 <1605799c-86d5-46be-b7ac-ed7e465d7013@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MXViNFGH3QOR9QzC6r4nJ9MXyw2KLKhC
X-Proofpoint-ORIG-GUID: cY2klaiCGCaF5S0kd_1OdIH38EQ167ds
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_14,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=995
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 impostorscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140118
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

On Mon, 2023-11-13 at 10:10 +0100, Cédric Le Goater wrote:
> On 11/10/23 20:49, Glenn Miles wrote:
> > The PNV I2C Controller was clearing the status register
> > after a reset without repopulating the "upper threshold
> > for I2C ports", "Command Complete" and the SCL/SDA input
> > level fields.
> > 
> > Fixed this for resets caused by a system reset as well
> > as from writing to the "Immediate Reset" register.
> > 
> > Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> > ---
> >   hw/ppc/pnv_i2c.c | 42 ++++++++++++++++++------------------------
> >   1 file changed, 18 insertions(+), 24 deletions(-)
> > 
> > diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
> > index b2c738da50..f80589157b 100644
> > --- a/hw/ppc/pnv_i2c.c
> > +++ b/hw/ppc/pnv_i2c.c
> > @@ -462,6 +462,23 @@ static uint64_t pnv_i2c_xscom_read(void
> > *opaque, hwaddr addr,
> >       return val;
> >   }
> >   
> > +static void pnv_i2c_reset(void *dev)
> > +{
> > +    PnvI2C *i2c = PNV_I2C(dev);
> > +
> > +    memset(i2c->regs, 0, sizeof(i2c->regs));
> > +
> > +    i2c->regs[I2C_STAT_REG] =
> > +        SETFIELD(I2C_STAT_UPPER_THRS, 0ull, i2c->num_busses - 1) |
> > +        I2C_STAT_CMD_COMP | I2C_STAT_SCL_INPUT_LEVEL |
> > +        I2C_STAT_SDA_INPUT_LEVEL;
> > +    i2c->regs[I2C_EXTD_STAT_REG] =
> > +        SETFIELD(I2C_EXTD_STAT_FIFO_SIZE, 0ull, PNV_I2C_FIFO_SIZE)
> > |
> > +        SETFIELD(I2C_EXTD_STAT_I2C_VERSION, 0ull, 23); /* last
> > version */
> > +
> > +    fifo8_reset(&i2c->fifo);
> > +}
> > +
> >   static void pnv_i2c_xscom_write(void *opaque, hwaddr addr,
> >                                   uint64_t val, unsigned size)
> >   {
> > @@ -499,16 +516,7 @@ static void pnv_i2c_xscom_write(void *opaque,
> > hwaddr addr,
> >           break;
> >   
> >       case I2C_RESET_I2C_REG:
> > -        i2c->regs[I2C_MODE_REG] = 0;
> > -        i2c->regs[I2C_CMD_REG] = 0;
> > -        i2c->regs[I2C_WATERMARK_REG] = 0;
> > -        i2c->regs[I2C_INTR_MASK_REG] = 0;
> > -        i2c->regs[I2C_INTR_COND_REG] = 0;
> > -        i2c->regs[I2C_INTR_RAW_COND_REG] = 0;
> > -        i2c->regs[I2C_STAT_REG] = 0;
> > -        i2c->regs[I2C_RESIDUAL_LEN_REG] = 0;
> > -        i2c->regs[I2C_EXTD_STAT_REG] &=
> > -            (I2C_EXTD_STAT_FIFO_SIZE | I2C_EXTD_STAT_I2C_VERSION);
> > +        pnv_i2c_reset(i2c);
> 
> or simply call device_cold_reset()
> 
> 
> Thanks,
> 
> C.
> 

The device_cold_reset() function performs a recursive reset, which
I believe performs a reset on the specified device as well as a reset
on all child devices.  For the case of doing an "immediate reset" of
the i2c controller, I think we just want to reset the i2c controller
and not any child devices, so I think I prefer leaving it how it is
if that is ok.

Thanks,

Glenn

> 
> 
> >           break;
> >   
> >       case I2C_RESET_ERRORS:
> > @@ -620,20 +628,6 @@ static int pnv_i2c_dt_xscom(PnvXScomInterface
> > *dev, void *fdt,
> >       return 0;
> >   }
> >   
> > -static void pnv_i2c_reset(void *dev)
> > -{
> > -    PnvI2C *i2c = PNV_I2C(dev);
> > -
> > -    memset(i2c->regs, 0, sizeof(i2c->regs));
> > -
> > -    i2c->regs[I2C_STAT_REG] = I2C_STAT_CMD_COMP;
> > -    i2c->regs[I2C_EXTD_STAT_REG] =
> > -        SETFIELD(I2C_EXTD_STAT_FIFO_SIZE, 0ull, PNV_I2C_FIFO_SIZE)
> > |
> > -        SETFIELD(I2C_EXTD_STAT_I2C_VERSION, 0ull, 23); /* last
> > version */
> > -
> > -    fifo8_reset(&i2c->fifo);
> > -}
> > -
> >   static void pnv_i2c_realize(DeviceState *dev, Error **errp)
> >   {
> >       PnvI2C *i2c = PNV_I2C(dev);


