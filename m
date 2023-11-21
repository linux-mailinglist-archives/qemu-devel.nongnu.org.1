Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D637F7F3711
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 21:05:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5WyI-0006hP-5U; Tue, 21 Nov 2023 15:03:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r5WyA-0006aL-Kb; Tue, 21 Nov 2023 15:03:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r5Wxy-0008Ot-Qj; Tue, 21 Nov 2023 15:03:29 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ALJ7UDm028284; Tue, 21 Nov 2023 20:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=1G0imdXGaFYcC+7iE0+2nmdfz9KFdj0jctNDHU1Xznw=;
 b=ImDPDOuVftxv+/Q8mMbAEbeur2yOs8A+Jj8j62wAecLtLoCL129Aw6eTEcg299+kKi1H
 i9RPyuWm1rL8B8CCkCXnMzFWgsgnzgt1WrewynbPxhC5vgttAU+ikUaY4wF8Q4eKUrdp
 UCgSTMjJ1lsF1jvxg5mF14iTmYL7LoHuHIYfTZ2rztzraoJTu/7LR1RmqJj8OlBp2kd3
 jiG7MGHxPfMcj9YbSmlM5S2j+r4mJz8+7i2vZ1S1UsS4SS2xRZCqDPHmGHvyOuGGDHSO
 LvnpONp3KQwv/HEbbnEwipFikP6U2KMB/PLtWCQ/1YALc1wiSBVS5w8hMhfR2DXZCCbe cg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh2e41b1h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Nov 2023 20:03:21 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ALK3Lol017748;
 Tue, 21 Nov 2023 20:03:21 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh2e41b1b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Nov 2023 20:03:21 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ALITjrE010190; Tue, 21 Nov 2023 20:03:20 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf9tkasdr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Nov 2023 20:03:20 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3ALK3JLd16712340
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Nov 2023 20:03:19 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 53C0C5805F;
 Tue, 21 Nov 2023 20:03:19 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 377B35805C;
 Tue, 21 Nov 2023 20:03:19 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Nov 2023 20:03:19 +0000 (GMT)
Message-ID: <84600e8239b6aef4915312ab0dd08149f3db4067.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 05/11] ppc/pnv: Wire up pca9552 GPIO pins for PCIe
 hotplug power control
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, =?ISO-8859-1?Q?Fr=E9d=E9ric?=
 Barrat <fbarrat@linux.ibm.com>
Date: Tue, 21 Nov 2023 14:03:19 -0600
In-Reply-To: <85ef1a8b-63c5-4492-9884-f34772a65c28@kaod.org>
References: <20231120235112.1951342-1-milesg@linux.vnet.ibm.com>
 <20231120235112.1951342-6-milesg@linux.vnet.ibm.com>
 <85ef1a8b-63c5-4492-9884-f34772a65c28@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YKkD6yDRlETnZHFIIKF_TbtwM786SkjV
X-Proofpoint-GUID: ddpyCc-B-avpZi1Uxm7gy4bfwXr5BkMP
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_10,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311210156
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On Tue, 2023-11-21 at 19:36 +0100, Cédric Le Goater wrote:
> On 11/21/23 00:51, Glenn Miles wrote:
> > For power10-rainier, a pca9552 device is used for PCIe slot hotplug
> > power control by the Power Hypervisor code.  The code expects that
> > some time after it enables power to a PCIe slot by asserting one of
> > the pca9552 GPIO pins 0-4, it should see a "power good" signal
> > asserted
> > on one of pca9552 GPIO pins 5-9.
> 
> And this is what OPAL is not doing :
> 
>    
> https://github.com/open-power/skiboot/blob/master/platforms/astbmc/rainier.c#L65
> 
> Correct ?
> 

Ah, yes, I believe you are correct!

> > To simulate this behavior, we simply connect the GPIO outputs for
> > pins 0-4 to the GPIO inputs for pins 5-9.
> > 
> > Each PCIe slot is assigned 3 GPIO pins on the pca9552 device, for
> > control of up to 5 PCIe slots.  The per-slot signal names are:
> > 
> >     SLOTx_EN.......PHYP uses this as an output to enable
> >                    slot power.  We connect this to the
> >                    SLOTx_PG pin to simulate a PGOOD signal.
> >     SLOTx_PG.......PHYP uses this as in input to detect
> >                    PGOOD for the slot.  For our purposes
> >                    we just connect this to the SLOTx_EN
> >                    output.
> >     SLOTx_Control..PHYP uses this as an output to prevent
> >                    a race condition in the real hotplug
> >                    circuitry, but we can ignore this output
> >                    for simulation.
> > 
> > Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> > ---
> > 
> > Changes from previous version:
> >    - Code moved from pnv_chip_power10_realize to
> > pnv_rainier_i2c_init
> > 
> >   hw/ppc/pnv.c | 20 ++++++++++++++++++--
> >   1 file changed, 18 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index 9cefcd0fd6..80d25fc1bd 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -1898,8 +1898,24 @@ static void
> > pnv_rainier_i2c_init(PnvMachineState *pnv)
> >            * Add a PCA9552 I2C device for PCIe hotplug control
> >            * to engine 2, bus 1, address 0x63
> >            */
> > -        i2c_slave_create_simple(chip10->i2c[2].busses[1],
> > -                                "pca9552", 0x63);
> > +        I2CSlave *hotplug = i2c_slave_create_simple(chip10-
> > >i2c[2].busses[1],
> > +                                                "pca9552", 0x63);
> 
> hotplug ? why not dev simply ?
> 
> 
> Thanks,
> 
> C.
> 
> 
Sure, dev is fine.  I'll change it.

Thanks,

Glenn

> 
> > +
> > +        /*
> > +         * Connect PCA9552 GPIO pins 0-4 (SLOTx_EN) outputs to
> > GPIO pins 5-9
> > +         * (SLOTx_PG) inputs in order to fake the pgood state of
> > PCIe slots
> > +         * after hypervisor code sets a SLOTx_EN pin high.
> > +         */
> > +        qdev_connect_gpio_out(DEVICE(hotplug), 0,
> > +                              qdev_get_gpio_in(DEVICE(hotplug),
> > 5));
> > +        qdev_connect_gpio_out(DEVICE(hotplug), 1,
> > +                              qdev_get_gpio_in(DEVICE(hotplug),
> > 6));
> > +        qdev_connect_gpio_out(DEVICE(hotplug), 2,
> > +                              qdev_get_gpio_in(DEVICE(hotplug),
> > 7));
> > +        qdev_connect_gpio_out(DEVICE(hotplug), 3,
> > +                              qdev_get_gpio_in(DEVICE(hotplug),
> > 8));
> > +        qdev_connect_gpio_out(DEVICE(hotplug), 4,
> > +                              qdev_get_gpio_in(DEVICE(hotplug),
> > 9));
> >       }
> >   }
> >   


