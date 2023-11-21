Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 758437F36A9
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 20:12:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5W8i-0008CX-Pc; Tue, 21 Nov 2023 14:10:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r5W8X-0008Aa-Si; Tue, 21 Nov 2023 14:10:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r5W8J-0003p3-Ih; Tue, 21 Nov 2023 14:10:15 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ALJ8Zjq012256; Tue, 21 Nov 2023 19:10:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=0r99vX046cwEiaBjwWubP37XIEKIDKYy7+2v9Pq2wTo=;
 b=eYWdXAfT/Fluz7918WWAHvZ3FnpRMlPuB6G/6jG2Rwz5pYjtDT6F2KjHGrSFacDPG/eN
 QGW4uGoG4lwAlXSj7P51+uzRzThaewTbsMr2khM2BfOKLashBNvzTZ3WCuNMfWeEbMZ2
 Ic59f3Js75ZttNFfvSnf1YrmgcuAlRYebu9MEdINvSYsqu0w2jKdwj/N6BakJt1JvEIR
 11hqYIsWmbYhrxiz+eu/zP6hQyWuh0hmhDCVUqr6pR5OZv8HExQFdBmZtUQ6ThfUO4m5
 /m7J7C8DNC9Ui/5Mw3XmVp8N2ieZ3uMaFQJG7edZBjzH8oNiWGDwBqYs+Ac9aBrjj1E4 lQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh2en01tt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Nov 2023 19:09:59 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ALJ9Efk014790;
 Tue, 21 Nov 2023 19:09:59 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh2en01sy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Nov 2023 19:09:59 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ALIY2ZL010300; Tue, 21 Nov 2023 19:09:58 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf93ktqq5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Nov 2023 19:09:58 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3ALJ9vZ015794806
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Nov 2023 19:09:58 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D12785805C;
 Tue, 21 Nov 2023 19:09:57 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A38B55805A;
 Tue, 21 Nov 2023 19:09:57 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Nov 2023 19:09:57 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v5 0/9] Add powernv10 I2C devices and tests
Date: Tue, 21 Nov 2023 13:09:36 -0600
Message-Id: <20231121190945.3140221-1-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pIMLWDr9DG2q4I4CUl6urVQGg_sFcVpe
X-Proofpoint-GUID: H1YnTQnT8EWiJ345LpBpp0dk6ZUjnj6e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_10,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=773 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210150
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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
by the Power Hypervisor Firmware on the Power10 Ranier platform.

Changes from previous version:
  - Removed two already merged patches
  - Various formatting changes
  - Capitalized "Rainier" in machine description string
  - Changed powernv10-rainier parent to MACHINE_TYPE_NAME("powernv10")


Glenn Miles (9):
  misc/pca9552: Fix inverted input status
  misc/pca9552: Let external devices set pca9552 inputs
  ppc/pnv: New powernv10-rainier machine type
  ppc/pnv: Add pca9552 to powernv10-rainier for PCIe hotplug power
    control
  ppc/pnv: Wire up pca9552 GPIO pins for PCIe hotplug power control
  ppc/pnv: Use resettable interface to reset child I2C buses
  misc: Add a pca9554 GPIO device model
  ppc/pnv: Add a pca9554 I2C device to powernv10-rainier
  ppc/pnv: Test pnv i2c master and connected devices

 MAINTAINERS                     |  10 +-
 hw/misc/Kconfig                 |   4 +
 hw/misc/meson.build             |   1 +
 hw/misc/pca9552.c               |  58 ++-
 hw/misc/pca9554.c               | 328 ++++++++++++++++
 hw/ppc/Kconfig                  |   2 +
 hw/ppc/pnv.c                    |  72 +++-
 hw/ppc/pnv_i2c.c                |  15 +-
 include/hw/misc/pca9552.h       |   3 +-
 include/hw/misc/pca9554.h       |  36 ++
 include/hw/misc/pca9554_regs.h  |  19 +
 include/hw/ppc/pnv.h            |   1 +
 tests/qtest/meson.build         |   1 +
 tests/qtest/pca9552-test.c      |   6 +-
 tests/qtest/pnv-host-i2c-test.c | 650 ++++++++++++++++++++++++++++++++
 15 files changed, 1190 insertions(+), 16 deletions(-)
 create mode 100644 hw/misc/pca9554.c
 create mode 100644 include/hw/misc/pca9554.h
 create mode 100644 include/hw/misc/pca9554_regs.h
 create mode 100644 tests/qtest/pnv-host-i2c-test.c

-- 
2.31.1


