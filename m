Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2DC7EC8B2
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 17:38:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3ItR-0006N2-F1; Wed, 15 Nov 2023 11:37:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r3ItP-0006Mj-M5; Wed, 15 Nov 2023 11:37:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r3ItN-0000VF-Kt; Wed, 15 Nov 2023 11:37:31 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AFGOFQU026608; Wed, 15 Nov 2023 16:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=qxP6rCX4vlme++SksTngm2DRUW4sNdyJUIjXK8EQGhE=;
 b=TBiMwN2Ro8heEzRoxrSDcCMPXL4RrpaKzfBphj2cwYpiPFJzHmgJC3pWfgO0lq6v0oFF
 vXVWzYBZOxnoCO7ZJhfQh0vOupiPsY4TrKUqqpWRLULPAt2+p+oOHnr+5tO+Zh+MnQcr
 NUvJryS45yECX+eBqgszVTHQRLoo77Xca+dLOogeYMVgrAu0RJ5YhFx+HBcHLIr+FYn5
 NkY62n+M4VJlgin+QPwllCATU126yjgPBW0gtYA+Eh97tJZ+VPw0dl87dcs9qI/nMKI8
 A+sIHkBPbIR3HGfpMenffKAIjt6Wc1M5GFqPvnk2HpN3SrCLRlLLvMCB3ayygzJf/xn2 Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ud06rtwdk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Nov 2023 16:37:20 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AFGOdQp028969;
 Wed, 15 Nov 2023 16:37:20 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ud06rtwdc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Nov 2023 16:37:20 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AFGAAUP018837; Wed, 15 Nov 2023 16:37:19 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uanekrd87-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Nov 2023 16:37:19 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AFGbI5l46531038
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Nov 2023 16:37:19 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8B935805D;
 Wed, 15 Nov 2023 16:37:18 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A2D1B58052;
 Wed, 15 Nov 2023 16:37:18 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 Nov 2023 16:37:18 +0000 (GMT)
Message-ID: <d5c90e92aa4cf313925de81872e95d0b62c36cce.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/8] ppc/pnv: Add pca9552 to powernv10 for PCIe
 hotplug power control
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, =?ISO-8859-1?Q?Fr=E9d=E9ric?=
 Barrat <fbarrat@linux.ibm.com>
Date: Wed, 15 Nov 2023 10:37:18 -0600
In-Reply-To: <54fad54f-a52e-41c6-90ba-7bc0b637cd59@kaod.org>
References: <20231114195659.1219821-1-milesg@linux.vnet.ibm.com>
 <20231114195659.1219821-2-milesg@linux.vnet.ibm.com>
 <54fad54f-a52e-41c6-90ba-7bc0b637cd59@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 60IAovydDZmdFvz99rNQ5ubkwvGqJ0LE
X-Proofpoint-GUID: qoL-w0-_SMkMMVEqJ0lQpS-R4KzifUXf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_15,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=990
 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150126
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

On Wed, 2023-11-15 at 08:28 +0100, Cédric Le Goater wrote:
> On 11/14/23 20:56, Glenn Miles wrote:
> > The Power Hypervisor code expects to see a pca9552 device connected
> > to the 3rd PNV I2C engine on port 1 at I2C address 0x63 (or left-
> > justified address of 0xC6).  This is used by hypervisor code to
> > control PCIe slot power during hotplug events.
> > 
> > Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> > ---
> > Based-on: <20231024181144.4045056-3-milesg@linux.vnet.ibm.com>
> > [PATCH v3 2/2] misc/pca9552: Let external devices set pca9552
> > inputs
> > 
> > No changes from v2
> > 
> >   hw/ppc/Kconfig | 1 +
> >   hw/ppc/pnv.c   | 7 +++++++
> >   2 files changed, 8 insertions(+)
> > 
> > diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> > index 56f0475a8e..f77ca773cf 100644
> > --- a/hw/ppc/Kconfig
> > +++ b/hw/ppc/Kconfig
> > @@ -32,6 +32,7 @@ config POWERNV
> >       select XIVE
> >       select FDT_PPC
> >       select PCI_POWERNV
> > +    select PCA9552
> >   
> >   config PPC405
> >       bool
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index 9c29727337..7afaf1008f 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -1877,6 +1877,13 @@ static void
> > pnv_chip_power10_realize(DeviceState *dev, Error **errp)
> >                                 qdev_get_gpio_in(DEVICE(&chip10-
> > >psi),
> >                                                  PSIHB9_IRQ_SBE_I2C
> > ));
> >       }
> > +
> > +    /*
> > +     * Add a PCA9552 I2C device for PCIe hotplug control
> > +     * to engine 2, bus 1, address 0x63
> > +     */
> > +    i2c_slave_create_simple(chip10->i2c[2].busses[1], "pca9552",
> > 0x63);
> 
> You didn't answer my question in v2. Is this a P10 chip device or a
> board/machine device ?
> 
> Thanks,
> 
> C.
> 
> 

Sorry, you're right, I did miss that one, and after looking at the
Denali spec, I see that the topology is indeed different from Rainier
(which is what I have been modeling).  For the Denali, the PCA9552
has a different I2C address (0x62 instead of 0x63) and the GPIO
connections are also different.  Also, there is no PCA9554 chip because
it looks like they were able to cover all of the functionality with
just the  GPIO's of the PCA9552.  So, good catch!

I'll look at what they did on the Aspeed machines like you suggested.

Thanks,

Glenn

> 
> >   }
> >   
> >   static uint32_t pnv_chip_power10_xscom_pcba(PnvChip *chip,
> > uint64_t addr)


