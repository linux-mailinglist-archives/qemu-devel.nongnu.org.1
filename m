Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0697E7E1D
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 18:25:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1VE9-0004X6-S2; Fri, 10 Nov 2023 12:23:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r1VE3-0004Vg-Q6; Fri, 10 Nov 2023 12:23:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r1VE1-0001IE-Hy; Fri, 10 Nov 2023 12:23:23 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AAH7cTk022175; Fri, 10 Nov 2023 17:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=0oNru5c1cMIytGkSU7X+8wxPOdwWkdKf//rGFWnQbGA=;
 b=FSZJ1TDYT8NeDnbqR3LFBGFngqfIp9JsZZBsk+A14lfYDcV5Tn/UOI3ckL8j8i5d3n1K
 mxb2ae8b1Xw2HpmZfO7ISXLasER6t2HCzZhDKqiHFxjUWkejWhwSSCvd0mNKL3BXQGoB
 6SJa/WQMpAoO0z6grmfg1+DN2VIeUQ4OcZPIldWcT6fdf8BfeBxcjJLqTaDPHFv9pO2O
 XGgBB/6E4ahXoztp0fUgEJ4yH3TYaSHEqKFrY3w1qweCyGGE6aCx0X2aEmuGaQ09erXK
 kTl55S7Mq1gxHFXLYShFGaoxucE4lTSLl7g6Yrxsb0i1gas72pmm1kNymmyq4wZw9iDN MQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9rmy0mj0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 17:23:11 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AAHFR6W006137;
 Fri, 10 Nov 2023 17:23:11 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9rmy0mha-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 17:23:10 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AAGk0B8014325; Fri, 10 Nov 2023 17:23:09 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u7w22cbw3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 17:23:09 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AAHN9F718481754
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Nov 2023 17:23:09 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0703158052;
 Fri, 10 Nov 2023 17:23:09 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F74958045;
 Fri, 10 Nov 2023 17:23:08 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Nov 2023 17:23:08 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH 0/8] Add powernv10 I2C devices and tests
Date: Fri, 10 Nov 2023 11:22:40 -0600
Message-Id: <20231110172248.3885194-1-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: d9yetOMtgFUEDYIx9P8uvnJmh9Uik7iY
X-Proofpoint-GUID: gAFqmVzavhyEWEruwm2uZlBLa7U18_SW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_15,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 malwarescore=0 mlxlogscore=599 adultscore=0 mlxscore=0
 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311100144
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

This series of patches includes support, tests and fixes for
adding PCA9552 and PCA9554 I2C devices to the powernv10 chip.

The PCA9552 device is used for PCIe slot hotplug power control
and monitoring, while the PCA9554 device is used for presence
detection of IBM CableCard devices.  Both devices are required
by the Power Hypervisor Firmware on Power10 platforms.

Glenn Miles (8):
  ppc/pnv: Add pca9552 to powernv10 for PCIe hotplug power control
  ppc/pnv: Wire up pca9552 GPIO pins for PCIe hotplug power control
  ppc/pnv: PNV I2C engines assigned incorrect XSCOM addresses
  ppc/pnv: Fix PNV I2C invalid status after reset
  ppc/pnv: Use resettable interface to reset child I2C buses
  misc: Add a pca9554 GPIO device model
  ppc/pnv: Add a pca9554 I2C device to powernv10
  ppc/pnv: Test pnv i2c master and connected devices

 MAINTAINERS                     |   2 +
 hw/misc/Kconfig                 |   4 +
 hw/misc/meson.build             |   1 +
 hw/misc/pca9554.c               | 328 ++++++++++++++++
 hw/ppc/Kconfig                  |   2 +
 hw/ppc/pnv.c                    |  35 +-
 hw/ppc/pnv_i2c.c                |  47 ++-
 include/hw/misc/pca9554.h       |  36 ++
 include/hw/misc/pca9554_regs.h  |  19 +
 tests/qtest/meson.build         |   1 +
 tests/qtest/pnv-host-i2c-test.c | 653 ++++++++++++++++++++++++++++++++
 11 files changed, 1106 insertions(+), 22 deletions(-)
 create mode 100644 hw/misc/pca9554.c
 create mode 100644 include/hw/misc/pca9554.h
 create mode 100644 include/hw/misc/pca9554_regs.h
 create mode 100644 tests/qtest/pnv-host-i2c-test.c

-- 
2.31.1


