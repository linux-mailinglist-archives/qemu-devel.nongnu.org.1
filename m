Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 525007EB71A
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 20:59:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2zXR-0004pT-Ir; Tue, 14 Nov 2023 14:57:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r2zXO-0004ov-D1; Tue, 14 Nov 2023 14:57:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r2zXM-0003VP-AM; Tue, 14 Nov 2023 14:57:30 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AEJtjAA028821; Tue, 14 Nov 2023 19:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=T2h6Vld3JJl1r+1DAynq4KfyfjylIJodgYV7FUFYb5k=;
 b=YleKe/L6cVtHEmAj2SST7dRGoqguP75hDIJhwI9tVhlvkeL8676lzqBn8i3lg/DA0Gf0
 VWrfKBQrTKk6ItP10ugVXNCij+ELF+5atk+Q9IUV16TZGQEhkpMy5m0fo1uI+QoShFOj
 glzSHxoBwYKSXWMhLu5ac2wfFN+WTljS+ZTxv8s40iwPetXqh5oEPghWug39ORNXlrrJ
 6tragp/fI2Ry+yAVECFA+LBH1a8hTEQl/0HQJ/t/HHmJU+fjmYbb7nXx/2awtvPKIE3w
 9HHeyqI5oSyMmh4w+WDV780rD4DCHE9OpuhL+Y6NqpcZGmWxXIdAqB9L6gFxxi87ZFUH yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucffrg11r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Nov 2023 19:57:24 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AEJuqNP031588;
 Tue, 14 Nov 2023 19:57:24 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucffrg11h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Nov 2023 19:57:24 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AEJnBjU022162; Tue, 14 Nov 2023 19:57:23 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uanekj48q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Nov 2023 19:57:23 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AEJvMV916450074
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Nov 2023 19:57:23 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6CE45805C;
 Tue, 14 Nov 2023 19:57:22 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A2D375805A;
 Tue, 14 Nov 2023 19:57:22 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Nov 2023 19:57:22 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v3 0/8] Add powernv10 I2C devices and tests
Date: Tue, 14 Nov 2023 13:56:51 -0600
Message-Id: <20231114195659.1219821-1-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n2e4sfqilBUsfN30qwFyjfOMpoHeDTXP
X-Proofpoint-ORIG-GUID: RGrOXqaq3awF4r3IkUEZZW-aClXl9U_W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_20,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 mlxlogscore=709 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140150
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

This series of patches includes support, tests and fixes for
adding PCA9552 and PCA9554 I2C devices to the powernv10 chip.

The PCA9552 device is used for PCIe slot hotplug power control
and monitoring, while the PCA9554 device is used for presence
detection of IBM CableCard devices.  Both devices are required
by the Power Hypervisor Firmware on Power10 platforms.

Changes from previous version:
  - Added Fixes: tag to commits 3 and 4
  - Fixed formatting errors in commits 2 and 8

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
 tests/qtest/pnv-host-i2c-test.c | 650 ++++++++++++++++++++++++++++++++
 11 files changed, 1103 insertions(+), 22 deletions(-)
 create mode 100644 hw/misc/pca9554.c
 create mode 100644 include/hw/misc/pca9554.h
 create mode 100644 include/hw/misc/pca9554_regs.h
 create mode 100644 tests/qtest/pnv-host-i2c-test.c

-- 
2.31.1


