Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A097F21A3
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 00:53:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5E3N-0006qS-Kd; Mon, 20 Nov 2023 18:51:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r5E3L-0006qE-EE; Mon, 20 Nov 2023 18:51:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r5E3J-0001gb-5I; Mon, 20 Nov 2023 18:51:43 -0500
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AKNgGaL022765; Mon, 20 Nov 2023 23:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=pdmN+H7ne3+qQ1tWEwIOOSK29khNstGmbfKaQciUQ8U=;
 b=eTLbhuX+GAJXNEifMY2tq6VAMX5roxSZ6haso/0Qhz3WaRzunGNot0fqz5+qZ+jyiVe8
 tYojUUgHXBhDXDr4n7odGPW2ItP2bW+969ApX6DAjUuhr+ueBwqspIzgJVkqdkIQ6LSO
 LScsjukKts2ZYfGs4UZ15kQogHofW91t/Ogtsg4pYj8XS5da7zHmVu0uagTqYxtNK0j9
 MZolcYK2hAQtWExQdZw9QuZURFgqDvImEyutRi9dOpmDoplTq539X7Z2XG3+mvDP8/5R
 d+by4Pw3NC0eJRqTdCdEmqcSxIbryssSkdtXaO8X2ga6suh1FuF+9zxF3q9hDYuOLDBb Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ughc004vv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Nov 2023 23:51:34 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AKNm2oh006502;
 Mon, 20 Nov 2023 23:51:34 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ughc004vh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Nov 2023 23:51:34 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AKNmpoA004682; Mon, 20 Nov 2023 23:51:33 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf7yyd0nn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Nov 2023 23:51:32 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AKNpW1714877286
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Nov 2023 23:51:32 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 34A225805D;
 Mon, 20 Nov 2023 23:51:32 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 027FD58055;
 Mon, 20 Nov 2023 23:51:32 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 20 Nov 2023 23:51:31 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v4 00/11] Add powernv10 I2C devices and tests
Date: Mon, 20 Nov 2023 17:51:01 -0600
Message-Id: <20231120235112.1951342-1-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EOPT6zwP_KWfjr66NzLXUlCUtJiVJz7N
X-Proofpoint-GUID: Q7x6VXVzE4cdWa7vSH20nULq42q0NJba
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=644 spamscore=0 adultscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200175
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

Changes from previous version:
  - Pulled in fixes/changes for pca9552 devices
  - Created new powernv10-rainier machine type
  - Adds pca9552/pca9554 devices to powernv10-rainier machine
  - Modified MAINTAINERS to make myself maintainer of
    the pca955x devices


Glenn Miles (11):
  misc/pca9552: Fix inverted input status
  misc/pca9552: Let external devices set pca9552 inputs
  ppc/pnv: New powernv10-rainier machine type
  ppc/pnv: Add pca9552 to powernv10-rainier for PCIe hotplug power
    control
  ppc/pnv: Wire up pca9552 GPIO pins for PCIe hotplug power control
  ppc/pnv: PNV I2C engines assigned incorrect XSCOM addresses
  ppc/pnv: Fix PNV I2C invalid status after reset
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
 hw/ppc/pnv.c                    |  83 +++-
 hw/ppc/pnv_i2c.c                |  47 ++-
 include/hw/misc/pca9552.h       |   3 +-
 include/hw/misc/pca9554.h       |  36 ++
 include/hw/misc/pca9554_regs.h  |  19 +
 include/hw/ppc/pnv.h            |   1 +
 tests/qtest/meson.build         |   1 +
 tests/qtest/pca9552-test.c      |   6 +-
 tests/qtest/pnv-host-i2c-test.c | 650 ++++++++++++++++++++++++++++++++
 15 files changed, 1212 insertions(+), 37 deletions(-)
 create mode 100644 hw/misc/pca9554.c
 create mode 100644 include/hw/misc/pca9554.h
 create mode 100644 include/hw/misc/pca9554_regs.h
 create mode 100644 tests/qtest/pnv-host-i2c-test.c

-- 
2.31.1


