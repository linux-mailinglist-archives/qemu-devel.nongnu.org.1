Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B817D7EA23C
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 18:42:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2avv-0004lg-4N; Mon, 13 Nov 2023 12:41:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r2ave-0004dV-8o; Mon, 13 Nov 2023 12:40:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r2ava-0002Uv-U4; Mon, 13 Nov 2023 12:40:54 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ADHbQVt016063; Mon, 13 Nov 2023 17:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=3WXKmKZzmW2nKM6O2HszjK/tRnQjrIEsgCXj1bmKv08=;
 b=V70wPUCJyjSXod6+F0OlfJz4VczACKleTkZPEO0St3Hq22ZCemZbslGE9lbDZPwX5u/S
 e4DbpNrKleiZMyFwV84RaquaTrCivJbFLRBehSRXAv+uSM/1prucIEMgXmcvR+OgMHIL
 ZNMZWxeeP8Xmdx2ec+BIOG5bpWEQA91E4NZHV0CXhxX9Ip9iIW1vvtLsZOB+HwA5UmZx
 I9ub5z9dOeB+9UHg1ezGCkm2hkWEyAZIoRbl2IKR4kN9FUU/4CDzLyDkoeDeagESCGH7
 eJdNbX6DK57pft7BlcwKcbO0VPO5hsJEfBCc9F7BgiEUjNCLPdaShFBoXG4klmpJl7xt OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ubrc1g2m0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Nov 2023 17:40:45 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ADHbZSP016541;
 Mon, 13 Nov 2023 17:40:45 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ubrc1g2kn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Nov 2023 17:40:45 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ADH4A8F006888; Mon, 13 Nov 2023 17:40:44 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamay2mcf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Nov 2023 17:40:44 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3ADHehLl12255972
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Nov 2023 17:40:43 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5620958056;
 Mon, 13 Nov 2023 17:40:43 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 26F5958052;
 Mon, 13 Nov 2023 17:40:43 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 13 Nov 2023 17:40:43 +0000 (GMT)
Message-ID: <5bc35de1747b1d7daf75c66af2d9f6957bca3c20.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/8] ppc/pnv: Add pca9552 to powernv10 for PCIe
 hotplug power control
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, =?ISO-8859-1?Q?Fr=E9d=E9ric?=
 Barrat <fbarrat@linux.ibm.com>
Date: Mon, 13 Nov 2023 11:40:42 -0600
In-Reply-To: <dd114f3e-93e1-4fb3-80e8-45fb17725b31@kaod.org>
References: <20231110194925.475909-1-milesg@linux.vnet.ibm.com>
 <20231110194925.475909-2-milesg@linux.vnet.ibm.com>
 <dd114f3e-93e1-4fb3-80e8-45fb17725b31@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IGl8I_qeIgpt-Ak99CTj2WRw8vlAQj87
X-Proofpoint-GUID: 1z60cpdbMYYDGDT28hrkBsWKVhuquJ1E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_08,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 lowpriorityscore=0 mlxlogscore=736 mlxscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311130144
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

On Mon, 2023-11-13 at 10:05 +0100, Cédric Le Goater wrote:
> On 11/10/23 20:49, Glenn Miles wrote:
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
> 
> Has this series been reviewed / merged ? If not, I would include the
> patches in this one.
> 

It has been reviewed but not yet merged.

-Glenn

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
> > +
> 
> Are all POWER10 chips wired this way (on rainier, denali, etc) ?
> or is this device board specific ? If this is the case, then we
> should introduce a new custom powernv10 machine. Please take a
> look at the Aspeed machines for an example.
> 
> 
> Thanks,
> 
> C.
> 
> 
> 
> >   }
> >   
> >   static uint32_t pnv_chip_power10_xscom_pcba(PnvChip *chip,
> > uint64_t addr)


