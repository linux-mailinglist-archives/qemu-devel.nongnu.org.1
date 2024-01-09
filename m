Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D738282AB
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 10:03:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN7zL-0007v1-EJ; Tue, 09 Jan 2024 04:01:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1rN7zF-0007tQ-IP; Tue, 09 Jan 2024 04:01:29 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1rN7zD-0003YY-KC; Tue, 09 Jan 2024 04:01:29 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4095soxg006699; Tue, 9 Jan 2024 09:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 qcppdkim1; bh=qQ+OnwmDLRd9/yjp8Zeaf6SoGLiuUJN8GvojF4kAm0o=; b=f6
 38DZ5pulavCErSe9XAYi+pbht5l9A4h+svUiHd5Dls9KjynwCXlUbce7yE+kbSGZ
 Sghk0XYCXYOZA3VQF4DaBTksuEtDDEjYY12A56uKiS5Cn70EADbDN12sLR96mUk2
 TnVFe2U8HjWxmfQ+RlgzXYrqpTS/yCX1ygyf+A7iadekbmcBvvM3Q781vbgPD5wH
 OMVtmVnfRR9dfNdceB6mJVubCplN4CJw6xfyT+Jg4Fk1TebIYst4Gm2PpvLoc6Rs
 +06iZlXdMd2Hk8A+o4vAGkWB9Dbs835bPEH4wwy7Xk7GwfnQNv5Gw/ygQh44Rtam
 Dw88gLxvKWAifXP2704A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgwx38k1t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 09:01:24 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40991OaY026659
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 9 Jan 2024 09:01:24 GMT
Received: from blr-ubuntu-31.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 01:01:20 -0800
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: <peter.maydell@linaro.org>, <philmd@linaro.org>, <alex.bennee@linaro.org>, 
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <quic_svaddagi@quicinc.com>, <quic_tsoni@quicinc.com>,
 <quic_pheragu@quicinc.com>, <quic_eberman@quicinc.com>,
 <quic_yvasi@quicinc.com>, <quic_cvanscha@quicinc.com>,
 <quic_mnalajal@quicinc.com>
Subject: [RFC/PATCH v1 07/11] gunyah: Specify device-tree location
Date: Tue, 9 Jan 2024 09:00:35 +0000
Message-ID: <20240109090039.1636383-8-quic_svaddagi@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240109090039.1636383-1-quic_svaddagi@quicinc.com>
References: <20240109090039.1636383-1-quic_svaddagi@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: xtO6UimA42mn_gyCY0yu98jq5rC4byLi
X-Proofpoint-ORIG-GUID: xtO6UimA42mn_gyCY0yu98jq5rC4byLi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=636
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401090070
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_svaddagi@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Specify the location of device-tree and its size, as Gunyah requires the
device-tree to be parsed before VM can begin its execution.

Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
---
 MAINTAINERS               |  1 +
 accel/stubs/gunyah-stub.c |  5 +++++
 hw/arm/virt.c             |  6 ++++++
 include/sysemu/gunyah.h   |  2 ++
 target/arm/gunyah.c       | 45 +++++++++++++++++++++++++++++++++++++++
 target/arm/meson.build    |  3 +++
 6 files changed, 62 insertions(+)
 create mode 100644 target/arm/gunyah.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b90a4558a1..171713bedc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -541,6 +541,7 @@ GUNYAH
 M: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
 S: Maintained
 F: accel/gunyah
+F: target/arm/gunyah.c
 F: include/sysemu/gunyah.h
 F: include/sysemu/gunyah_int.h
 F: target/arm/arm_gicv3_gunyah.c
diff --git a/accel/stubs/gunyah-stub.c b/accel/stubs/gunyah-stub.c
index 1edbe1433e..faeb2af915 100644
--- a/accel/stubs/gunyah-stub.c
+++ b/accel/stubs/gunyah-stub.c
@@ -11,3 +11,8 @@
 #include "sysemu/gunyah.h"
 
 bool gunyah_allowed;
+
+int gunyah_arm_set_dtb(__u64 dtb_start, __u64 dtb_size)
+{
+    return -1;
+}
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4f4e10c234..60fbe2f7c4 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1656,6 +1656,12 @@ void virt_machine_done(Notifier *notifier, void *data)
         exit(1);
     }
 
+    if (gunyah_enabled()) {
+        if (gunyah_arm_set_dtb(info->dtb_start, vms->fdt_size)) {
+            exit(1);
+        }
+    }
+
     fw_cfg_add_extra_pci_roots(vms->bus, vms->fw_cfg);
 
     virt_acpi_setup(vms);
diff --git a/include/sysemu/gunyah.h b/include/sysemu/gunyah.h
index 4f26938521..a73d17bfb9 100644
--- a/include/sysemu/gunyah.h
+++ b/include/sysemu/gunyah.h
@@ -27,4 +27,6 @@ typedef struct GUNYAHState GUNYAHState;
 DECLARE_INSTANCE_CHECKER(GUNYAHState, GUNYAH_STATE,
                          TYPE_GUNYAH_ACCEL)
 
+int gunyah_arm_set_dtb(__u64 dtb_start, __u64 dtb_size);
+
 #endif  /* QEMU_GUNYAH_H */
diff --git a/target/arm/gunyah.c b/target/arm/gunyah.c
new file mode 100644
index 0000000000..73c1c2a88a
--- /dev/null
+++ b/target/arm/gunyah.c
@@ -0,0 +1,45 @@
+/*
+ * QEMU Gunyah hypervisor support
+ *
+ * Copyright(c) 2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "sysemu/gunyah.h"
+#include "sysemu/gunyah_int.h"
+#include "linux-headers/linux/gunyah.h"
+
+/*
+ * Specify location of device-tree in guest address space.
+ *
+ * @dtb_start - Guest physical address where VM's device-tree is found
+ * @dtb_size - Size of device-tree (and any free space after it).
+ *
+ * RM or Resource Manager VM is a trusted and privileged VM that works in
+ * collaboration with Gunyah hypevisor to setup resources for a VM before it can
+ * begin execution. One of its functions includes inspection/modification of a
+ * VM's device-tree before VM begins its execution. Modification can
+ * include specification of runtime resources allocated by hypervisor,
+ * details of which needs to be visible to VM.  VM's device-tree is modified
+ * "inline" making use of "free" space that could exist at the end of device
+ * tree.
+ */
+int gunyah_arm_set_dtb(__u64 dtb_start, __u64 dtb_size)
+{
+    int ret;
+    struct gh_vm_dtb_config dtb;
+
+    dtb.guest_phys_addr = dtb_start;
+    dtb.size = dtb_size;
+
+    ret = gunyah_vm_ioctl(GH_VM_SET_DTB_CONFIG, &dtb);
+    if (ret != 0) {
+        error_report("GH_VM_SET_DTB_CONFIG failed: %s", strerror(errno));
+        exit(1);
+    }
+
+    return 0;
+}
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 46b5a21eb3..797df04717 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -36,3 +36,6 @@ endif
 
 target_arch += {'arm': arm_ss}
 target_system_arch += {'arm': arm_system_ss}
+arm_system_ss.add(when: 'CONFIG_GUNYAH', if_true: files(
+  'gunyah.c',
+))
-- 
2.25.1


