Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F287EB670
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 19:35:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2yEz-00019t-NM; Tue, 14 Nov 2023 13:34:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r2yEs-000198-8L; Tue, 14 Nov 2023 13:34:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r2yEp-0006C1-N7; Tue, 14 Nov 2023 13:34:17 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AEIBlGL025838; Tue, 14 Nov 2023 18:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Z8U5bK0l55aT7xctG01Sh43Y0ExKRBBJE8+m1aJbwWM=;
 b=B2yfdN1xoo5WrgBx0SyysuYwTBP7MwWNv92T9yNWqRMJstUb+JsOOj/RMTk1mBUsM/U2
 e24XeTNsCO6n1kFfVoqyTcjMYFEgjfq1gP9vn0+A5KcMKSzuqBxcwKzrWhzNH24vjWxL
 3+SM/fd32SxRhKBAhhfQuk1O6YSVzJb+v39Rnk10mbMI5DtEezxQWp8bLKRiEDrJPbuQ
 LKo34G6gn6mCEx6ZqznkICMpwdkDrdWIbbZW8yB3qnVfO8kVuYH25PyNAxtOkZWoJeSK
 uGly8x5GsKFxlXyM0f8qhp8eN491iPVWwShY+9m8N+zrOW8MY8BQl6SGrEEAsyKxHpGX 0w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucdy60k5n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Nov 2023 18:34:05 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AEICO9R027695;
 Tue, 14 Nov 2023 18:34:05 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucdy60k59-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Nov 2023 18:34:05 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AEGXuG3009525; Tue, 14 Nov 2023 18:34:04 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uakxst5wy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Nov 2023 18:34:04 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AEIY3dx8389160
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Nov 2023 18:34:03 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D73C58062;
 Tue, 14 Nov 2023 18:34:03 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 262AD5805E;
 Tue, 14 Nov 2023 18:34:03 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Nov 2023 18:34:03 +0000 (GMT)
Message-ID: <105757d802eb509315a71426b5f0b794664aa42e.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 4/8] ppc/pnv: Fix PNV I2C invalid status after reset
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, =?ISO-8859-1?Q?Fr=E9d=E9ric?=
 Barrat <fbarrat@linux.ibm.com>
Date: Tue, 14 Nov 2023 12:34:02 -0600
In-Reply-To: <38f88e9d-7679-4cd6-b117-3c893f9e3e7c@kaod.org>
References: <20231110194925.475909-1-milesg@linux.vnet.ibm.com>
 <20231110194925.475909-5-milesg@linux.vnet.ibm.com>
 <1605799c-86d5-46be-b7ac-ed7e465d7013@kaod.org>
 <be493d52dd58df3205b0055ce75d7026bc18b8c2.camel@linux.vnet.ibm.com>
 <38f88e9d-7679-4cd6-b117-3c893f9e3e7c@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XRWGWwlESlReq4j6iqcQsl4ZXksL5Hey
X-Proofpoint-ORIG-GUID: 09rp7FpaEjgQT7eGHiGt0pD3vu8PJKtD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_19,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140141
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

On Tue, 2023-11-14 at 18:55 +0100, Cédric Le Goater wrote:
> On 11/14/23 16:26, Miles Glenn wrote:
> > On Mon, 2023-11-13 at 10:10 +0100, Cédric Le Goater wrote:
> > > On 11/10/23 20:49, Glenn Miles wrote:
> > > > The PNV I2C Controller was clearing the status register
> > > > after a reset without repopulating the "upper threshold
> > > > for I2C ports", "Command Complete" and the SCL/SDA input
> > > > level fields.
> > > > 
> > > > Fixed this for resets caused by a system reset as well
> > > > as from writing to the "Immediate Reset" register.
> > > > 
> > > > Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> > > > ---
> > > >    hw/ppc/pnv_i2c.c | 42 ++++++++++++++++++------------------
> > > > ------
> > > >    1 file changed, 18 insertions(+), 24 deletions(-)
> > > > 
> > > > diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
> > > > index b2c738da50..f80589157b 100644
> > > > --- a/hw/ppc/pnv_i2c.c
> > > > +++ b/hw/ppc/pnv_i2c.c
> > > > @@ -462,6 +462,23 @@ static uint64_t pnv_i2c_xscom_read(void
> > > > *opaque, hwaddr addr,
> > > >        return val;
> > > >    }
> > > >    
> > > > +static void pnv_i2c_reset(void *dev)
> > > > +{
> > > > +    PnvI2C *i2c = PNV_I2C(dev);
> > > > +
> > > > +    memset(i2c->regs, 0, sizeof(i2c->regs));
> > > > +
> > > > +    i2c->regs[I2C_STAT_REG] =
> > > > +        SETFIELD(I2C_STAT_UPPER_THRS, 0ull, i2c->num_busses -
> > > > 1) |
> > > > +        I2C_STAT_CMD_COMP | I2C_STAT_SCL_INPUT_LEVEL |
> > > > +        I2C_STAT_SDA_INPUT_LEVEL;
> > > > +    i2c->regs[I2C_EXTD_STAT_REG] =
> > > > +        SETFIELD(I2C_EXTD_STAT_FIFO_SIZE, 0ull,
> > > > PNV_I2C_FIFO_SIZE)
> > > > +        SETFIELD(I2C_EXTD_STAT_I2C_VERSION, 0ull, 23); /* last
> > > > version */
> > > > +
> > > > +    fifo8_reset(&i2c->fifo);
> > > > +}
> > > > +
> > > >    static void pnv_i2c_xscom_write(void *opaque, hwaddr addr,
> > > >                                    uint64_t val, unsigned size)
> > > >    {
> > > > @@ -499,16 +516,7 @@ static void pnv_i2c_xscom_write(void
> > > > *opaque,
> > > > hwaddr addr,
> > > >            break;
> > > >    
> > > >        case I2C_RESET_I2C_REG:
> > > > -        i2c->regs[I2C_MODE_REG] = 0;
> > > > -        i2c->regs[I2C_CMD_REG] = 0;
> > > > -        i2c->regs[I2C_WATERMARK_REG] = 0;
> > > > -        i2c->regs[I2C_INTR_MASK_REG] = 0;
> > > > -        i2c->regs[I2C_INTR_COND_REG] = 0;
> > > > -        i2c->regs[I2C_INTR_RAW_COND_REG] = 0;
> > > > -        i2c->regs[I2C_STAT_REG] = 0;
> > > > -        i2c->regs[I2C_RESIDUAL_LEN_REG] = 0;
> > > > -        i2c->regs[I2C_EXTD_STAT_REG] &=
> > > > -            (I2C_EXTD_STAT_FIFO_SIZE |
> > > > I2C_EXTD_STAT_I2C_VERSION);
> > > > +        pnv_i2c_reset(i2c);
> > > 
> > > or simply call device_cold_reset()
> > > 
> > > 
> > > Thanks,
> > > 
> > > C.
> > > 
> > 
> > The device_cold_reset() function performs a recursive reset, which
> > I believe performs a reset on the specified device as well as a
> > reset
> > on all child devices.  For the case of doing an "immediate reset"
> > of
> > the i2c controller, I think we just want to reset the i2c
> > controller
> > and not any child devices, so I think I prefer leaving it how it is
> > if that is ok.
> 
> OK. Is is a fix for 8.2 ?
> 
> Thanks,
> 
> C.
> 

Yes, I will send out a v3 stating that.

Thanks,

Glenn

> 
> > Thanks,
> > 
> > Glenn
> > 
> > > 
> > > >            break;
> > > >    
> > > >        case I2C_RESET_ERRORS:
> > > > @@ -620,20 +628,6 @@ static int
> > > > pnv_i2c_dt_xscom(PnvXScomInterface
> > > > *dev, void *fdt,
> > > >        return 0;
> > > >    }
> > > >    
> > > > -static void pnv_i2c_reset(void *dev)
> > > > -{
> > > > -    PnvI2C *i2c = PNV_I2C(dev);
> > > > -
> > > > -    memset(i2c->regs, 0, sizeof(i2c->regs));
> > > > -
> > > > -    i2c->regs[I2C_STAT_REG] = I2C_STAT_CMD_COMP;
> > > > -    i2c->regs[I2C_EXTD_STAT_REG] =
> > > > -        SETFIELD(I2C_EXTD_STAT_FIFO_SIZE, 0ull,
> > > > PNV_I2C_FIFO_SIZE)
> > > > -        SETFIELD(I2C_EXTD_STAT_I2C_VERSION, 0ull, 23); /* last
> > > > version */
> > > > -
> > > > -    fifo8_reset(&i2c->fifo);
> > > > -}
> > > > -
> > > >    static void pnv_i2c_realize(DeviceState *dev, Error **errp)
> > > >    {
> > > >        PnvI2C *i2c = PNV_I2C(dev);


