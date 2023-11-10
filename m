Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DFF7E7F4E
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 18:52:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1VfN-0000K8-FD; Fri, 10 Nov 2023 12:51:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r1Vf7-0000I6-So; Fri, 10 Nov 2023 12:51:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r1Vf4-0007A6-OG; Fri, 10 Nov 2023 12:51:20 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AAHd9fF006885; Fri, 10 Nov 2023 17:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=u/d5ItASBT/cZ3el9Sbs9U+7WXClkdIPQccA5QoY78Y=;
 b=G3noGfP3Ya1m9dG6NkFu5aKGuQU/PQDhrLDiPSMEvPAQMA1pWAhngmJephiUiTnerFL/
 TI4kcd8m2IcMqyeZSs9p64iZDPfQ4lSfQ0Tj9axVIgUi8aixWgO8LUiyYRLKztbJORMZ
 vqN44DXG8Km9jDs+m06hFPIBdaERGkOgpz4rdPjcK9AS9g0VQa3QxEBERgL5qUAXGvgw
 w+GQ3uZXcAo5l/rPrKfYPO7XrOwXzwZP61LmNAXVHg+/5B4Si/SgGEtB3BfPa0/yDZGh
 gMWH+DPrLaPsSOpy10B4gjrXC++RGdGurfarVIfmQlpZq0AXjZj0GZBiVD5oDPxtFt98 rA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9s3t8ame-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 17:51:15 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AAHoYIB009900;
 Fri, 10 Nov 2023 17:51:15 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9s3t8am6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 17:51:15 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AAGliLt003431; Fri, 10 Nov 2023 17:51:14 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u7w22cfje-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 17:51:14 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AAHpDUO49283812
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Nov 2023 17:51:14 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9FB9858055;
 Fri, 10 Nov 2023 17:51:13 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45F2658063;
 Fri, 10 Nov 2023 17:51:13 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Nov 2023 17:51:13 +0000 (GMT)
Message-ID: <7ab0ff7e881340b8649b18f890ef751e03e9afc2.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/8] Add powernv10 I2C devices and tests
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Nicholas Piggin
 <npiggin@gmail.com>, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>
Date: Fri, 10 Nov 2023 11:51:12 -0600
In-Reply-To: <20231110172248.3885194-1-milesg@linux.vnet.ibm.com>
References: <20231110172248.3885194-1-milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LCoX7t5771gWJmHMOfju9l7VAffmym-z
X-Proofpoint-ORIG-GUID: fC8DZEm9KmW7i4AdHcFlgh0xO62cBfRU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_15,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=646 bulkscore=0
 mlxscore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100148
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

On Fri, 2023-11-10 at 11:22 -0600, Glenn Miles wrote:
> This series of patches includes support, tests and fixes for
> adding PCA9552 and PCA9554 I2C devices to the powernv10 chip.
> 
> The PCA9552 device is used for PCIe slot hotplug power control
> and monitoring, while the PCA9554 device is used for presence
> detection of IBM CableCard devices.  Both devices are required
> by the Power Hypervisor Firmware on Power10 platforms.
> 

Sorry folks, I got a ahead of myself and forgot to test this on
the master branch.  Looks like it's currently failing 'make check'
there so I'll be coming out with a v2 once I get it working.

Regards,

Glenn

> Glenn Miles (8):
>   ppc/pnv: Add pca9552 to powernv10 for PCIe hotplug power control
>   ppc/pnv: Wire up pca9552 GPIO pins for PCIe hotplug power control
>   ppc/pnv: PNV I2C engines assigned incorrect XSCOM addresses
>   ppc/pnv: Fix PNV I2C invalid status after reset
>   ppc/pnv: Use resettable interface to reset child I2C buses
>   misc: Add a pca9554 GPIO device model
>   ppc/pnv: Add a pca9554 I2C device to powernv10
>   ppc/pnv: Test pnv i2c master and connected devices
> 
>  MAINTAINERS                     |   2 +
>  hw/misc/Kconfig                 |   4 +
>  hw/misc/meson.build             |   1 +
>  hw/misc/pca9554.c               | 328 ++++++++++++++++
>  hw/ppc/Kconfig                  |   2 +
>  hw/ppc/pnv.c                    |  35 +-
>  hw/ppc/pnv_i2c.c                |  47 ++-
>  include/hw/misc/pca9554.h       |  36 ++
>  include/hw/misc/pca9554_regs.h  |  19 +
>  tests/qtest/meson.build         |   1 +
>  tests/qtest/pnv-host-i2c-test.c | 653
> ++++++++++++++++++++++++++++++++
>  11 files changed, 1106 insertions(+), 22 deletions(-)
>  create mode 100644 hw/misc/pca9554.c
>  create mode 100644 include/hw/misc/pca9554.h
>  create mode 100644 include/hw/misc/pca9554_regs.h
>  create mode 100644 tests/qtest/pnv-host-i2c-test.c
> 


