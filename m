Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8E38C7871
	for <lists+qemu-devel@lfdr.de>; Thu, 16 May 2024 16:34:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7cAz-0003OS-6B; Thu, 16 May 2024 10:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1s7cAv-0003KD-S7; Thu, 16 May 2024 10:33:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1s7cAt-0007z4-FQ; Thu, 16 May 2024 10:33:41 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44G8X64V027367;
 Thu, 16 May 2024 14:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=qcppdkim1; bh=Vg+TqVv
 k0ka4+3POtqGbOxcGCLEO0Hf+do5UQ+dZcFc=; b=Fcwue2qDzLapcMXbfxLW2ft
 0/wJnZc06CvXXQw0t3cWf1CO2EGtwBiwNBVlCrcFykgZ+lJ3iUn33rM2yzDCk/Tt
 K0Syr/XyGMJdWFGu/wbm9EypfW1ICyYXyp9P8xIsi+PqZ6fRkKOT0zeFPboV89Uc
 +buEkNQn4V6eN2/gVruGwXpur8B8r8XGePVcuccXv8rVt6v1e46sSF0C87daEy3n
 2JDuDoyM3Ld6wgVRR9jU/zXmtJXrzusnBuxTc869YQDmqmfHQ3IJGmpNdiAaCUHe
 b4QD1Z76Trl7y9qC7K5gF2Yfd5iWXUDN9uMiDVR4IsHUDAvKysaZtpGn0XtYbEg=
 =
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y42kvxgp6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 14:33:34 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44GEXWgQ006308
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 14:33:32 GMT
Received: from blr-ubuntu-31.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 16 May 2024 07:33:28 -0700
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: <peter.maydell@linaro.org>, <philmd@linaro.org>, <alex.bennee@linaro.org>, 
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <quic_svaddagi@quicinc.com>, <quic_tsoni@quicinc.com>,
 <quic_pheragu@quicinc.com>, <quic_eberman@quicinc.com>,
 <quic_yvasi@quicinc.com>, <quic_cvanscha@quicinc.com>,
 <quic_mnalajal@quicinc.com>
Subject: [RFC/PATCH v2 00/12] Gunyah hypervisor support
Date: Thu, 16 May 2024 14:33:08 +0000
Message-ID: <20240516143320.1739118-1-quic_svaddagi@quicinc.com>
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
X-Proofpoint-GUID: I16LP_QJSrxPgInVWPf7kEX8CSBqLnHw
X-Proofpoint-ORIG-GUID: I16LP_QJSrxPgInVWPf7kEX8CSBqLnHw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405160102
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


Appreciate any quick comments you have. This is v2 that I intend to publish on
qemu lists. Main changes since v1 is adding support for protected VM. 

===


Gunyah is an open-source Type-1 hypervisor, that is currently supported on ARM64
architecture. Source code for it can be obtained from:

https://github.com/quic/gunyah-hypervisor

This patch series adds support for Gunyah hypervisor via a new
accelerator option, 'gunyah'. This patch series is based on the Linux kernel's
Gunyah driver, which is being actively developed and not yet merged upstream
[1, 2].

This patch series is thus *NOT YET READY* for merge. Early versions of this patch
is being published to solicit comments from Qemu community.

This patch has been tested with the open-source version of Gunyah hypervisor and
using v14 Linux Gunyah driver [1]. Instructions to build hypervisor and test
this patch are provided in this patch series.

Changes in v2:
* Extended ARM virt machine to support confidential guests 
* Extended CPU run loop to recognize VM shutdown

Changes in v1:

* Fixed SMP boot issues
* Addressed comments received for previous version (v0) of the patches series

Limitations:

* Confidential guests (or protected VMs) are not yet supported by Linux
  Gunyah driver published upstream. I have tested it using a variant of the driver
  available in Android Common Kernel [3].

* Instructions provided to test with open-source Gunyah is based on v14 Gunyah driver
  [1]. Updated instruction that is based on v17 Gunyah driver will be provided
  later.

Prior version, v1, of this patch can be referenced at:

	https://lists.nongnu.org/archive/html/qemu-devel/2024-01/msg01397.html

Ref:

1. https://lore.kernel.org/lkml/20230613172054.3959700-1-quic_eberman@quicinc.com/
2. https://lore.kernel.org/lkml/20240222-gunyah-v17-0-1e9da6763d38@quicinc.com/
3. https://android.googlesource.com/kernel/common/+/refs/heads/android14-6.1/drivers/virt/gunyah/

Base commit on which this series was tested:

4e66a08546 (origin/master, origin/HEAD) Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging


Srivatsa Vaddagiri (12):
  gunyah: UAPI header (NOT FOR MERGE)
  accel: Introduce check_capability() callback
  hw/arm/virt: confidential guest support
  gunyah: Basic support
  gunyah: Support memory assignment
  gunyah: Add IRQFD and IOEVENTFD functions
  gunyah: Add gicv3 interrupt controller
  gunyah: Specific device-tree location
  gunyah: Customize device-tree
  gunyah: CPU execution loop
  gunyah: Workarounds (NOT FOR MERGE)
  gunyah: Documentation

 MAINTAINERS                     |  11 +
 docs/about/build-platforms.rst  |   2 +-
 docs/system/arm/gunyah.rst      | 326 +++++++++++++++
 meson.build                     |  12 +-
 qapi/qom.json                   |  14 +
 include/hw/arm/virt.h           |   1 +
 include/sysemu/accel-ops.h      |   8 +
 include/sysemu/gunyah.h         |  36 ++
 include/sysemu/gunyah_int.h     |  67 +++
 linux-headers/linux/gunyah.h    | 311 ++++++++++++++
 accel/gunyah/gunyah-accel-ops.c | 128 ++++++
 accel/gunyah/gunyah-all.c       | 698 ++++++++++++++++++++++++++++++++
 accel/stubs/gunyah-stub.c       |  28 ++
 hw/arm/boot.c                   |  17 +-
 hw/arm/virt.c                   | 173 +++++++-
 hw/intc/arm_gicv3_common.c      |   3 +
 hw/intc/arm_gicv3_gunyah.c      | 106 +++++
 hw/intc/arm_gicv3_its_common.c  |   3 +
 target/arm/cpu.c                |   3 +-
 target/arm/cpu64.c              |   5 +-
 target/arm/gunyah.c             | 142 +++++++
 accel/Kconfig                   |   3 +
 accel/gunyah/meson.build        |   7 +
 accel/meson.build               |   1 +
 accel/stubs/meson.build         |   1 +
 hw/intc/meson.build             |   1 +
 meson_options.txt               |   2 +
 scripts/meson-buildoptions.sh   |   3 +
 target/arm/meson.build          |   3 +
 29 files changed, 2107 insertions(+), 8 deletions(-)
 create mode 100644 docs/system/arm/gunyah.rst
 create mode 100644 include/sysemu/gunyah.h
 create mode 100644 include/sysemu/gunyah_int.h
 create mode 100644 linux-headers/linux/gunyah.h
 create mode 100644 accel/gunyah/gunyah-accel-ops.c
 create mode 100644 accel/gunyah/gunyah-all.c
 create mode 100644 accel/stubs/gunyah-stub.c
 create mode 100644 hw/intc/arm_gicv3_gunyah.c
 create mode 100644 target/arm/gunyah.c
 create mode 100644 accel/gunyah/meson.build

-- 
2.25.1


