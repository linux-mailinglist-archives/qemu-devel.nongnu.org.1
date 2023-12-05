Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDF4804342
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 01:23:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAJCI-00060z-Jb; Mon, 04 Dec 2023 19:21:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1rAJCG-00060X-Vi
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 19:21:56 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1rAJCE-0005VA-VE
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 19:21:56 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B503gHS008346; Tue, 5 Dec 2023 00:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=EYMdKBS7wBKRnAHNftFxEAIyeyEz1k6aw2EyKQ04GT4=;
 b=a0I6b4ZKQmlw/RTBNwy+DhhpM0NgpCsLsOLIH2OfLq/1uVaVko5F11huRd3d04M20Pq3
 MEefEGO1pgMUmHO7gNNEdqUq9pFGHSSqPZbS/qwuuql/Rwt2uCiJlOgcsWyz4oZN81Pn
 b3M0oyRNPjDMfBKZDZKJjaiFbe5hlIpgxpKJChmQhVLmkyFS5X6xVbLs+k5X7Jy+ubtH
 nD9tQ4cODHzSQL8jGosEJy6dXVOHJuyT+Yoxl+sRwOUjhENMKn28vSHe2GdRk3RSWYxQ
 N/hUAx5oaGy0Z26/82py/G7TqPri2wc/e4ZmIgt8qYAfE+p5LV+hLCYALM0JVtJ7Lir8 AQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usrtsg11b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 00:21:51 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B4MIri9018503; Tue, 5 Dec 2023 00:21:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uqu16kj9g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 00:21:51 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B50LoxD015944;
 Tue, 5 Dec 2023 00:21:50 GMT
Received: from localhost.localdomain (dhcp-10-191-8-104.vpn.oracle.com
 [10.191.8.104])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3uqu16kj7u-1; Tue, 05 Dec 2023 00:21:50 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org, imammedo@redhat.com
Cc: annie.li@oracle.com, miguel.luis@oracle.com
Subject: [RFC PATCH 00/11] Support ACPI Control Method Sleep button
Date: Tue,  5 Dec 2023 00:21:43 +0000
Message-Id: <20231205002143.562-1-annie.li@oracle.com>
X-Mailer: git-send-email 2.30.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_22,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=883 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050001
X-Proofpoint-GUID: N_4Q9ge0Eh2OQ7aQffmdLYsbZdzMF3fw
X-Proofpoint-ORIG-GUID: N_4Q9ge0Eh2OQ7aQffmdLYsbZdzMF3fw
Received-SPF: pass client-ip=205.220.177.32; envelope-from=annie.li@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The ACPI sleep button can be implemented as a fixed hardware button
or Control Method Sleep button.

The patch of implementing a fixed hardware sleep button was posted
here 1). More discussions can be found here 2). Essentially, the
discussion mainly focuses on whether the sleep button is implemented
as a fixed hardware button or Control Method Sleep button. The latter
benefits different architectures since the code can be shared among
them.

This patch set implements Control Method Sleep button for both x86
and ARM platform.

For x86, a sleep button GPE event handler is implemented, so a GPE
event is triggered to indicate the OSPM the sleep button is pressed.
Tests have been done for Linux 6.6.0-rc2+, and Windows Server 2016,
the sleep button works as expected.

For ARM, a GED event is triggered to notify the OSPM. With proper
debug knobs it is possible to see the guest OSPM acknowledges the
sleep event:

[ 268.429495] evregion-0119 ev_address_space_dispa: ----Entry
[ 268.430480] evrgnini-0043 ev_system_memory_regio: ----Entry
[ 268.431423] evrgnini-0079 ev_system_memory_regio: ----Exit- AE_OK
[ 268.432303] evregion-0230 ev_address_space_dispa: Handler 0000000081544775 (@00000000e8f0a66d) Address 0000000009080000 [SystemMemory]
[ 268.433943] evregion-0325 ev_address_space_dispa: ----Exit- AE_OK
[ 268.434793]   evmisc-0132 ev_queue_notify_reques: Dispatching Notify on [SLPB] (Device) Value 0x80 (Status Change) Node 00000000ada658b8

But that seems to be all, depicting that sleep/wakeup for ARM is broken
and there are still missing some pieces of the puzzle.

Nonetheless, we would like to take this RFC as an opportunity for updates
on this subject as possible roadmaps.

1) https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg06478.html
2) https://lore.kernel.org/all/20210920095316.2dd133be@redhat.com/T/#mfe24f89778020deeacfe45083f3eea3cf9f55961

Annie Li (6):
  acpi: hmp/qmp: Add hmp/qmp support for system_sleep
  acpi: Implement control method sleep button
  test/acpi: allow DSDT table changes
  acpi: Support Control Method sleep button for x86
  tests/acpi/bios-tables-test: update DSDT tables for Control Method
    Sleep button
  acpi: Send the GPE event of suspend and wakeup for x86

Miguel Luis (5):
  hw/acpi: Add ACPI GED support for the sleep event
  tests/acpi: allow FACP and DSDT table changes for arm/virt
  hw/arm: enable sleep support for arm/virt
  tests/acpi: Update FACP and DSDT tables for sleep button
  arm/virt: enable sleep support

 hmp-commands.hx                               |  14 +++++
 hw/acpi/control_method_device.c               |  49 ++++++++++++++++++
 hw/acpi/core.c                                |  17 ++++--
 hw/acpi/generic_event_device.c                |   9 ++++
 hw/acpi/meson.build                           |   1 +
 hw/arm/virt-acpi-build.c                      |  13 +++++
 hw/arm/virt.c                                 |  14 ++++-
 hw/core/machine-hmp-cmds.c                    |   5 ++
 hw/core/machine-qmp-cmds.c                    |  11 ++++
 hw/i386/acpi-build.c                          |   9 ++++
 include/hw/acpi/acpi.h                        |   1 +
 include/hw/acpi/acpi_dev_interface.h          |   1 +
 include/hw/acpi/control_method_device.h       |  20 +++++++
 include/hw/acpi/generic_event_device.h        |   1 +
 include/hw/arm/virt.h                         |   1 +
 include/monitor/hmp.h                         |   1 +
 qapi/machine.json                             |  18 +++++++
 qapi/pragma.json                              |   1 +
 tests/data/acpi/pc/DSDT                       | Bin 6830 -> 7012 bytes
 tests/data/acpi/pc/DSDT.acpierst              | Bin 6741 -> 6923 bytes
 tests/data/acpi/pc/DSDT.acpihmat              | Bin 8155 -> 8337 bytes
 tests/data/acpi/pc/DSDT.bridge                | Bin 13701 -> 13883 bytes
 tests/data/acpi/pc/DSDT.cphp                  | Bin 7294 -> 7476 bytes
 tests/data/acpi/pc/DSDT.dimmpxm               | Bin 8484 -> 8666 bytes
 tests/data/acpi/pc/DSDT.hpbridge              | Bin 6781 -> 6963 bytes
 tests/data/acpi/pc/DSDT.hpbrroot              | Bin 3337 -> 3519 bytes
 tests/data/acpi/pc/DSDT.ipmikcs               | Bin 6902 -> 7084 bytes
 tests/data/acpi/pc/DSDT.memhp                 | Bin 8189 -> 8371 bytes
 tests/data/acpi/pc/DSDT.nohpet                | Bin 6688 -> 6870 bytes
 tests/data/acpi/pc/DSDT.numamem               | Bin 6836 -> 7018 bytes
 tests/data/acpi/pc/DSDT.roothp                | Bin 10623 -> 10805 bytes
 tests/data/acpi/q35/DSDT                      | Bin 8355 -> 8537 bytes
 tests/data/acpi/q35/DSDT.acpierst             | Bin 8372 -> 8554 bytes
 tests/data/acpi/q35/DSDT.acpihmat             | Bin 9680 -> 9862 bytes
 tests/data/acpi/q35/DSDT.acpihmat-noinitiator | Bin 8634 -> 8816 bytes
 tests/data/acpi/q35/DSDT.applesmc             | Bin 8401 -> 8583 bytes
 tests/data/acpi/q35/DSDT.bridge               | Bin 11968 -> 12150 bytes
 tests/data/acpi/q35/DSDT.core-count           | Bin 12913 -> 13095 bytes
 tests/data/acpi/q35/DSDT.core-count2          | Bin 33770 -> 33952 bytes
 tests/data/acpi/q35/DSDT.cphp                 | Bin 8819 -> 9001 bytes
 tests/data/acpi/q35/DSDT.cxl                  | Bin 9713 -> 9895 bytes
 tests/data/acpi/q35/DSDT.dimmpxm              | Bin 10009 -> 10191 bytes
 tests/data/acpi/q35/DSDT.ipmibt               | Bin 8430 -> 8612 bytes
 tests/data/acpi/q35/DSDT.ipmismbus            | Bin 8443 -> 8625 bytes
 tests/data/acpi/q35/DSDT.ivrs                 | Bin 8372 -> 8554 bytes
 tests/data/acpi/q35/DSDT.memhp                | Bin 9714 -> 9896 bytes
 tests/data/acpi/q35/DSDT.mmio64               | Bin 9485 -> 9667 bytes
 tests/data/acpi/q35/DSDT.multi-bridge         | Bin 13208 -> 13390 bytes
 tests/data/acpi/q35/DSDT.noacpihp             | Bin 8235 -> 8417 bytes
 tests/data/acpi/q35/DSDT.nohpet               | Bin 8213 -> 8395 bytes
 tests/data/acpi/q35/DSDT.numamem              | Bin 8361 -> 8543 bytes
 tests/data/acpi/q35/DSDT.pvpanic-isa          | Bin 8456 -> 8638 bytes
 tests/data/acpi/q35/DSDT.thread-count         | Bin 12913 -> 13095 bytes
 tests/data/acpi/q35/DSDT.thread-count2        | Bin 33770 -> 33952 bytes
 tests/data/acpi/q35/DSDT.tis.tpm12            | Bin 8961 -> 9143 bytes
 tests/data/acpi/q35/DSDT.tis.tpm2             | Bin 8987 -> 9169 bytes
 tests/data/acpi/q35/DSDT.type4-count          | Bin 18589 -> 18771 bytes
 tests/data/acpi/q35/DSDT.viot                 | Bin 9464 -> 9646 bytes
 tests/data/acpi/q35/DSDT.xapic                | Bin 35718 -> 35900 bytes
 tests/data/acpi/virt/DSDT                     | Bin 5196 -> 5278 bytes
 tests/data/acpi/virt/DSDT.acpihmatvirt        | Bin 5282 -> 5364 bytes
 tests/data/acpi/virt/DSDT.memhp               | Bin 6557 -> 6639 bytes
 tests/data/acpi/virt/DSDT.pxb                 | Bin 7679 -> 7761 bytes
 tests/data/acpi/virt/DSDT.topology            | Bin 5398 -> 5480 bytes
 tests/data/acpi/virt/FACP                     | Bin 276 -> 276 bytes
 65 files changed, 181 insertions(+), 5 deletions(-)
 create mode 100644 hw/acpi/control_method_device.c
 create mode 100644 include/hw/acpi/control_method_device.h

-- 
2.34.3


