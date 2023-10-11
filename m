Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DFD7C5998
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 18:54:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqcS9-0008VY-R0; Wed, 11 Oct 2023 12:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1qqcS7-0008VL-HD; Wed, 11 Oct 2023 12:52:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1qqcS5-0000wA-6T; Wed, 11 Oct 2023 12:52:55 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39BFqhE4006699; Wed, 11 Oct 2023 16:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=Zp+LyRF+nJYCLmnOgk8btPd3hFzUI710Z3cxs6LSsvI=;
 b=IKB3HqXAV/mprZgApyrUvtE6MCHKqt5XDUue1fVYCq9aU2spHrov/2M0BtvoKZmpjNtu
 Owwclu2Yj0JqOw56UCFysoNs9nCQ3JcaiqNrdh7hWsnkK6mUwXX9EBdu6Arz0BlrluBm
 0BwnnBwahBXZeQKyu3KP9pKNzM1fgRhZWTAMjSXKBADMObN+JgmITaxG7smcDjl5mXvC
 ca0I+9uhvweAQjD2QC7t/3P1L55TEURFPPH/SvDErvGSaAEkNiFSPYOh/11lAj80qc0E
 AHsClpVexjhWtMDIWP/aJjuINsbhOim+9hTrVKEHmVNScAx7gs7/HR/ax3qp5E2S6kw4 6w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tnv1r8k20-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Oct 2023 16:52:48 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39BGqmcr030247
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Oct 2023 16:52:48 GMT
Received: from blr-ubuntu-31.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 11 Oct 2023 09:52:43 -0700
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: <peter.maydell@linaro.org>, <alex.bennee@linaro.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <quic_svaddagi@quicinc.com>, <quic_tsoni@quicinc.com>,
 <quic_pheragu@quicinc.com>, <quic_eberman@quicinc.com>,
 <quic_yvasi@quicinc.com>, <quic_cvanscha@quicinc.com>,
 <quic_mnalajal@quicinc.com>
Subject: [RFC/PATCH v0 00/12] Gunyah hypervisor support
Date: Wed, 11 Oct 2023 16:52:22 +0000
Message-ID: <20231011165234.1323725-1-quic_svaddagi@quicinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: 7ylMCTAv2g-BG4d65Rnkhd7sDiTu0g-y
X-Proofpoint-GUID: 7ylMCTAv2g-BG4d65Rnkhd7sDiTu0g-y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_12,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 clxscore=1011 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 mlxlogscore=475 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310110148
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_svaddagi@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Gunyah is an open-source Type-1 hypervisor, that is currently supported on ARM64
architecture. Source code for it can be obtained from:

https://github.com/quic/gunyah-hypervisor.

This patch series adds support for Gunyah hypervisor via a new
accelerator option, 'gunyah'. This patch series is based on the Linux kernel's
Gunyah driver, which is being actively developed and not yet merged upstream
[1].

This patch series is thus *NOT YET READY* for merge. Early version of this patch
is being published to solicit comments from Qemu community.

This patch has been tested with the open-source version of Gunyah hypervisor.
Instructions to build hypervisor and test this patch are provided in this
patch series.

Limitations:

1) SMP is not yet supported. This restriction will be removed in the next version
of this patch series.

2) virtio-pci is not yet supported. hw/virtio/virtio-pci.c seems to support only
KVM and would need changes to support other hypervisors. If there is any ongoing
work in this regard, would like to build upon it and add support for Gunyah
hypervisor.


Ref:

1. https://lore.kernel.org/lkml/20230613172054.3959700-1-quic_eberman@quicinc.com/

Base commit on which this series was tested:

d77b7b28a8 target/arm: Fix 64-bit SSRA


Srivatsa Vaddagiri (12):
  hw/arm/virt: Avoid NULL pointer de-reference
  update-linux-headers: Include gunyah.h
  gunyah: Basic support
  gunyah: Add VM properties
  gunyah: Support memory assignment
  gunyah: Add IRQFD and IOEVENTFD functions
  gunyah: Add gicv3 interrupt controller
  gunyah: Specific device-tree location
  gunyah: Customize device-tree
  gunyah: CPU execution loop
  gunyah: Workarounds (NOT FOR MERGE)
  gunyah: Documentation

 MAINTAINERS                     |  10 +
 accel/Kconfig                   |   3 +
 accel/gunyah/gunyah-accel-ops.c | 168 +++++++++
 accel/gunyah/gunyah-all.c       | 629 ++++++++++++++++++++++++++++++++
 accel/gunyah/meson.build        |   7 +
 accel/meson.build               |   1 +
 accel/stubs/gunyah-stub.c       |  13 +
 accel/stubs/meson.build         |   1 +
 docs/about/build-platforms.rst  |   2 +-
 docs/system/arm/gunyah.rst      | 214 +++++++++++
 hw/arm/boot.c                   |   3 +-
 hw/arm/virt.c                   |  27 +-
 hw/intc/arm_gicv3_common.c      |   3 +
 hw/intc/arm_gicv3_gunyah.c      | 106 ++++++
 hw/intc/arm_gicv3_its_common.c  |   4 +
 hw/intc/meson.build             |   1 +
 include/hw/core/cpu.h           |   6 +
 include/sysemu/gunyah.h         |  58 +++
 include/sysemu/gunyah_int.h     |  61 ++++
 meson.build                     |   9 +
 meson_options.txt               |   2 +
 scripts/meson-buildoptions.sh   |   3 +
 scripts/update-linux-headers.sh |   3 +-
 target/arm/cpu64.c              |   5 +-
 target/arm/gunyah.c             | 144 ++++++++
 target/arm/meson.build          |   4 +
 26 files changed, 1480 insertions(+), 7 deletions(-)
 create mode 100644 accel/gunyah/gunyah-accel-ops.c
 create mode 100644 accel/gunyah/gunyah-all.c
 create mode 100644 accel/gunyah/meson.build
 create mode 100644 accel/stubs/gunyah-stub.c
 create mode 100644 docs/system/arm/gunyah.rst
 create mode 100644 hw/intc/arm_gicv3_gunyah.c
 create mode 100644 include/sysemu/gunyah.h
 create mode 100644 include/sysemu/gunyah_int.h
 create mode 100644 target/arm/gunyah.c

-- 
2.25.1

