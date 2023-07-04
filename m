Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B2874727B
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 15:17:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGftE-00071d-Mr; Tue, 04 Jul 2023 09:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qGbUl-0008N3-PV; Tue, 04 Jul 2023 04:34:47 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qGbUh-0006sh-19; Tue, 04 Jul 2023 04:34:47 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1b8054180acso43063725ad.1; 
 Tue, 04 Jul 2023 01:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688459681; x=1691051681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v5ebw4AZ9C1yav973ETlAW+LrhHpRY3KZGwo4WnDTmY=;
 b=quGZGavZsfAlkeZQrnzDfBcj+xqBnWvPS+i1Kt4GTOrGLWWHlS1mM17YC9u9bBd8O0
 Ae3E7La7HGLr7aVJI4OOoqVE3DMCVTIG0CEp6dmdpxrp16urxPqVsQgHEaMBjki1lh+z
 qp+NnL46v2no4l/XKkVy8+8RJ+7+HEDvQrl4cngM+aPys8LMfCX6+KIv8jS+eOLwaX8L
 CbPOKDUaONLEdUHRPupD4IC6YQ3QBqd9xhZkOGaaR3oYNcAwfgWXCG22omyEbNVyYMxI
 kGvvLftnTDKeb+l0EQKJfaijyO984aGwBg7lsxMUHUv46XIGkd46O43Ub+dJ4tdlwyE9
 1M8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688459681; x=1691051681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v5ebw4AZ9C1yav973ETlAW+LrhHpRY3KZGwo4WnDTmY=;
 b=cbtRwah5WdIsSsEREfCmJsyi1gTILInEHLnkg6e2bl/saTo0GDJUvDMdH0TfIxZOZX
 v5/1okJBTUijewlTKOpKMfwilUjGkHc+StPB4Sa7cnGzK0MDOmUaBmeSRH6LAr6VxAKj
 jNKZDrVr0ZlpvC8sdF3FYhFsRKV6X4b4xxi1CHBhtuANewo8ol9EkbR7fAKw4uVNi7hi
 qxb8Kyyn8do5/SeeBwLXIHSJK4SHvkT6G/3dUaW1O8WbCYkTydSTRUdVbcmIhGnNalLb
 3yPCl6/9zo0gTvYJUhJoicYZ2Y887B4Hl7p7BqhY0OUADe6T9ZnZgLe4rjjTlVyfobmB
 vy0g==
X-Gm-Message-State: ABy/qLZf01OCcNufTFFkxMg5vin7IuHXehP1i3e2UeDy/nz+FAErzVEr
 VSk1KnCmtJ840A96jLrN1cWt+hHv+eyx+A==
X-Google-Smtp-Source: APBJJlFYNmg+25tcNkVNTdQzcqwfeUGCGMZAx9R/4hLh1K/i/GIgNKXM4KY3FnitPH4flb2A9pYzHw==
X-Received: by 2002:a17:902:da92:b0:1b8:4e00:96b with SMTP id
 j18-20020a170902da9200b001b84e00096bmr16507671plx.9.1688459680305; 
 Tue, 04 Jul 2023 01:34:40 -0700 (PDT)
Received: from localhost.localdomain ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 jg10-20020a17090326ca00b001b7fabe8b0asm14943527plb.2.2023.07.04.01.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 01:34:39 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, hreitz@redhat.com, k.jensen@samsung.com, kwolf@redhat.com,
 pbonzini@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com,
 berrange@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, philmd@linaro.org,
 thuth@redhat.com, Jeuk Kim <jeuk20.kim@samsung.com>
Subject: [PATCH v4 1/3] hw/ufs: Initial commit for emulated
 Universal-Flash-Storage
Date: Tue,  4 Jul 2023 17:33:57 +0900
Message-Id: <f2f466072893abfb8a39ddd83894bc75ea86bdd9.1688459061.git.jeuk20.kim@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1688459061.git.jeuk20.kim@gmail.com>
References: <cover.1688459061.git.jeuk20.kim@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 04 Jul 2023 09:16:13 -0400
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

Universal Flash Storage (UFS) is a high-performance mass storage device
with a serial interface. It is primarily used as a high-performance
data storage device for embedded applications.

This commit contains code for UFS device to be recognized
as a UFS PCI device.
Patches to handle UFS logical unit and Transfer Request will follow.

Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 MAINTAINERS              |    6 +
 docs/specs/pci-ids.rst   |    2 +
 hw/Kconfig               |    1 +
 hw/meson.build           |    1 +
 hw/ufs/Kconfig           |    4 +
 hw/ufs/meson.build       |    1 +
 hw/ufs/trace-events      |   33 ++
 hw/ufs/trace.h           |    1 +
 hw/ufs/ufs.c             |  304 +++++++++++
 hw/ufs/ufs.h             |   42 ++
 include/block/ufs.h      | 1048 ++++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci.h     |    1 +
 include/hw/pci/pci_ids.h |    1 +
 meson.build              |    1 +
 14 files changed, 1446 insertions(+)
 create mode 100644 hw/ufs/Kconfig
 create mode 100644 hw/ufs/meson.build
 create mode 100644 hw/ufs/trace-events
 create mode 100644 hw/ufs/trace.h
 create mode 100644 hw/ufs/ufs.c
 create mode 100644 hw/ufs/ufs.h
 create mode 100644 include/block/ufs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 4feea49a6e..756aae8623 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2237,6 +2237,12 @@ F: tests/qtest/nvme-test.c
 F: docs/system/devices/nvme.rst
 T: git git://git.infradead.org/qemu-nvme.git nvme-next
 
+ufs
+M: Jeuk Kim <jeuk20.kim@samsung.com>
+S: Supported
+F: hw/ufs/*
+F: include/block/ufs.h
+
 megasas
 M: Hannes Reinecke <hare@suse.com>
 L: qemu-block@nongnu.org
diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
index e302bea484..d6707fa069 100644
--- a/docs/specs/pci-ids.rst
+++ b/docs/specs/pci-ids.rst
@@ -92,6 +92,8 @@ PCI devices (other than virtio):
   PCI PVPanic device (``-device pvpanic-pci``)
 1b36:0012
   PCI ACPI ERST device (``-device acpi-erst``)
+1b36:0013
+  PCI UFS device (``-device ufs``)
 
 All these devices are documented in :doc:`index`.
 
diff --git a/hw/Kconfig b/hw/Kconfig
index ba62ff6417..9ca7b38c31 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -38,6 +38,7 @@ source smbios/Kconfig
 source ssi/Kconfig
 source timer/Kconfig
 source tpm/Kconfig
+source ufs/Kconfig
 source usb/Kconfig
 source virtio/Kconfig
 source vfio/Kconfig
diff --git a/hw/meson.build b/hw/meson.build
index c7ac7d3d75..f01fac4617 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -37,6 +37,7 @@ subdir('smbios')
 subdir('ssi')
 subdir('timer')
 subdir('tpm')
+subdir('ufs')
 subdir('usb')
 subdir('vfio')
 subdir('virtio')
diff --git a/hw/ufs/Kconfig b/hw/ufs/Kconfig
new file mode 100644
index 0000000000..b7b3392e85
--- /dev/null
+++ b/hw/ufs/Kconfig
@@ -0,0 +1,4 @@
+config UFS_PCI
+    bool
+    default y if PCI_DEVICES
+    depends on PCI
diff --git a/hw/ufs/meson.build b/hw/ufs/meson.build
new file mode 100644
index 0000000000..eb5164bde9
--- /dev/null
+++ b/hw/ufs/meson.build
@@ -0,0 +1 @@
+system_ss.add(when: 'CONFIG_UFS_PCI', if_true: files('ufs.c'))
diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
new file mode 100644
index 0000000000..17793929b1
--- /dev/null
+++ b/hw/ufs/trace-events
@@ -0,0 +1,33 @@
+# ufs.c
+ufs_irq_raise(void) "INTx"
+ufs_irq_lower(void) "INTx"
+ufs_mmio_read(uint64_t addr, uint64_t data, unsigned size) "addr 0x%"PRIx64" data 0x%"PRIx64" size %d"
+ufs_mmio_write(uint64_t addr, uint64_t data, unsigned size) "addr 0x%"PRIx64" data 0x%"PRIx64" size %d"
+ufs_process_db(uint32_t slot) "UTRLDBR slot %"PRIu32""
+ufs_process_req(uint32_t slot) "UTRLDBR slot %"PRIu32""
+ufs_complete_req(uint32_t slot) "UTRLDBR slot %"PRIu32""
+ufs_sendback_req(uint32_t slot) "UTRLDBR slot %"PRIu32""
+ufs_exec_nop_cmd(uint32_t slot) "UTRLDBR slot %"PRIu32""
+ufs_exec_scsi_cmd(uint32_t slot, uint8_t lun, uint8_t opcode) "slot %"PRIu32", lun 0x%"PRIx8", opcode 0x%"PRIx8""
+ufs_exec_query_cmd(uint32_t slot, uint8_t opcode) "slot %"PRIu32", opcode 0x%"PRIx8""
+ufs_process_uiccmd(uint32_t uiccmd, uint32_t ucmdarg1, uint32_t ucmdarg2, uint32_t ucmdarg3) "uiccmd 0x%"PRIx32", ucmdarg1 0x%"PRIx32", ucmdarg2 0x%"PRIx32", ucmdarg3 0x%"PRIx32""
+
+# error condition
+ufs_err_memory_allocation(void) "failed to allocate memory"
+ufs_err_dma_read_utrd(uint32_t slot, uint64_t addr) "failed to read utrd. UTRLDBR slot %"PRIu32", UTRD dma addr %"PRIu64""
+ufs_err_dma_read_req_upiu(uint32_t slot, uint64_t addr) "failed to read req upiu. UTRLDBR slot %"PRIu32", request upiu addr %"PRIu64""
+ufs_err_dma_read_prdt(uint32_t slot, uint64_t addr) "failed to read prdt. UTRLDBR slot %"PRIu32", prdt addr %"PRIu64""
+ufs_err_dma_write_utrd(uint32_t slot, uint64_t addr) "failed to write utrd. UTRLDBR slot %"PRIu32", UTRD dma addr %"PRIu64""
+ufs_err_dma_write_rsp_upiu(uint32_t slot, uint64_t addr) "failed to write rsp upiu. UTRLDBR slot %"PRIu32", response upiu addr %"PRIu64""
+ufs_err_utrl_slot_busy(uint32_t slot) "UTRLDBR slot %"PRIu32" is busy"
+ufs_err_unsupport_register_offset(uint32_t offset) "Register offset 0x%"PRIx32" is not yet supported"
+ufs_err_invalid_register_offset(uint32_t offset) "Register offset 0x%"PRIx32" is invalid"
+ufs_err_scsi_cmd_invalid_lun(uint8_t lun) "scsi command has invalid lun: 0x%"PRIx8""
+ufs_err_query_flag_not_readable(uint8_t idn) "query flag idn 0x%"PRIx8" is denied to read"
+ufs_err_query_flag_not_writable(uint8_t idn) "query flag idn 0x%"PRIx8" is denied to write"
+ufs_err_query_attr_not_readable(uint8_t idn) "query attribute idn 0x%"PRIx8" is denied to read"
+ufs_err_query_attr_not_writable(uint8_t idn) "query attribute idn 0x%"PRIx8" is denied to write"
+ufs_err_query_invalid_opcode(uint8_t opcode) "query request has invalid opcode. opcode: 0x%"PRIx8""
+ufs_err_query_invalid_idn(uint8_t opcode, uint8_t idn) "query request has invalid idn. opcode: 0x%"PRIx8", idn 0x%"PRIx8""
+ufs_err_query_invalid_index(uint8_t opcode, uint8_t index) "query request has invalid index. opcode: 0x%"PRIx8", index 0x%"PRIx8""
+ufs_err_invalid_trans_code(uint32_t slot, uint8_t trans_code) "request upiu has invalid transaction code. slot: %"PRIu32", trans_code: 0x%"PRIx8""
diff --git a/hw/ufs/trace.h b/hw/ufs/trace.h
new file mode 100644
index 0000000000..2dbd6397c3
--- /dev/null
+++ b/hw/ufs/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_ufs.h"
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
new file mode 100644
index 0000000000..99e5e55e97
--- /dev/null
+++ b/hw/ufs/ufs.c
@@ -0,0 +1,304 @@
+/*
+ * QEMU Universal Flash Storage (UFS) Controller
+ *
+ * Copyright (c) 2023 Samsung Electronics Co., Ltd. All rights reserved.
+ *
+ * Written by Jeuk Kim <jeuk20.kim@samsung.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+#include "ufs.h"
+
+/* The QEMU-UFS device follows spec version 3.1 */
+#define UFS_SPEC_VER 0x00000310
+#define UFS_MAX_NUTRS 32
+#define UFS_MAX_NUTMRS 8
+
+static void ufs_irq_check(UfsHc *u)
+{
+    PCIDevice *pci = PCI_DEVICE(u);
+    uint32_t is = ldl_le_p(&u->reg.is);
+    uint32_t ie = ldl_le_p(&u->reg.ie);
+
+    if ((is & UFS_INTR_MASK) & ie) {
+        trace_ufs_irq_raise();
+        pci_irq_assert(pci);
+    } else {
+        trace_ufs_irq_lower();
+        pci_irq_deassert(pci);
+    }
+}
+
+static void ufs_process_uiccmd(UfsHc *u, uint32_t val)
+{
+    uint32_t is = ldl_le_p(&u->reg.is);
+    uint32_t hcs = ldl_le_p(&u->reg.hcs);
+    uint32_t ucmdarg1 = ldl_le_p(&u->reg.ucmdarg1);
+    uint32_t ucmdarg2 = ldl_le_p(&u->reg.ucmdarg2);
+    uint32_t ucmdarg3 = ldl_le_p(&u->reg.ucmdarg3);
+
+    trace_ufs_process_uiccmd(val, ucmdarg1, ucmdarg2, ucmdarg3);
+    /*
+     * Only the essential uic commands for running drivers on Linux and Windows
+     * are implemented.
+     */
+    switch (val) {
+    case UIC_CMD_DME_LINK_STARTUP:
+        hcs = FIELD_DP32(hcs, HCS, DP, 1);
+        hcs = FIELD_DP32(hcs, HCS, UTRLRDY, 1);
+        hcs = FIELD_DP32(hcs, HCS, UTMRLRDY, 1);
+        ucmdarg2 = UIC_CMD_RESULT_SUCCESS;
+        break;
+    /* TODO: Revisit it when Power Management is implemented */
+    case UIC_CMD_DME_HIBER_ENTER:
+        is = FIELD_DP32(is, IS, UHES, 1);
+        hcs = FIELD_DP32(hcs, HCS, UPMCRS, PWR_LOCAL);
+        ucmdarg2 = UIC_CMD_RESULT_SUCCESS;
+        break;
+    case UIC_CMD_DME_HIBER_EXIT:
+        is = FIELD_DP32(is, IS, UHXS, 1);
+        hcs = FIELD_DP32(hcs, HCS, UPMCRS, PWR_LOCAL);
+        ucmdarg2 = UIC_CMD_RESULT_SUCCESS;
+        break;
+    default:
+        ucmdarg2 = UIC_CMD_RESULT_FAILURE;
+    }
+
+    is = FIELD_DP32(is, IS, UCCS, 1);
+
+    stl_le_p(&u->reg.is, is);
+    stl_le_p(&u->reg.hcs, hcs);
+    stl_le_p(&u->reg.ucmdarg1, ucmdarg1);
+    stl_le_p(&u->reg.ucmdarg2, ucmdarg2);
+    stl_le_p(&u->reg.ucmdarg3, ucmdarg3);
+
+    ufs_irq_check(u);
+}
+
+static void ufs_write_reg(UfsHc *u, hwaddr offset, uint32_t data, unsigned size)
+{
+    uint32_t is = ldl_le_p(&u->reg.is);
+    uint32_t hcs = ldl_le_p(&u->reg.hcs);
+    uint32_t hce = ldl_le_p(&u->reg.hce);
+    uint32_t utrlcnr = ldl_le_p(&u->reg.utrlcnr);
+    uint32_t utrlba, utmrlba;
+
+    switch (offset) {
+    case A_IS:
+        is &= ~data;
+        stl_le_p(&u->reg.is, is);
+        ufs_irq_check(u);
+        break;
+    case A_IE:
+        stl_le_p(&u->reg.ie, data);
+        ufs_irq_check(u);
+        break;
+    case A_HCE:
+        if (!FIELD_EX32(hce, HCE, HCE) && FIELD_EX32(data, HCE, HCE)) {
+            hcs = FIELD_DP32(hcs, HCS, UCRDY, 1);
+            hce = FIELD_DP32(hce, HCE, HCE, 1);
+            stl_le_p(&u->reg.hcs, hcs);
+            stl_le_p(&u->reg.hce, hce);
+        } else if (FIELD_EX32(hce, HCE, HCE) && !FIELD_EX32(data, HCE, HCE)) {
+            hcs = 0;
+            hce = FIELD_DP32(hce, HCE, HCE, 0);
+            stl_le_p(&u->reg.hcs, hcs);
+            stl_le_p(&u->reg.hce, hce);
+        }
+        break;
+    case A_UTRLBA:
+        utrlba = data & R_UTRLBA_UTRLBA_MASK;
+        stl_le_p(&u->reg.utrlba, utrlba);
+        break;
+    case A_UTRLBAU:
+        stl_le_p(&u->reg.utrlbau, data);
+        break;
+    case A_UTRLDBR:
+        /* Not yet supported */
+        break;
+    case A_UTRLRSR:
+        stl_le_p(&u->reg.utrlrsr, data);
+        break;
+    case A_UTRLCNR:
+        utrlcnr &= ~data;
+        stl_le_p(&u->reg.utrlcnr, utrlcnr);
+        break;
+    case A_UTMRLBA:
+        utmrlba = data & R_UTMRLBA_UTMRLBA_MASK;
+        stl_le_p(&u->reg.utmrlba, utmrlba);
+        break;
+    case A_UTMRLBAU:
+        stl_le_p(&u->reg.utmrlbau, data);
+        break;
+    case A_UICCMD:
+        ufs_process_uiccmd(u, data);
+        break;
+    case A_UCMDARG1:
+        stl_le_p(&u->reg.ucmdarg1, data);
+        break;
+    case A_UCMDARG2:
+        stl_le_p(&u->reg.ucmdarg2, data);
+        break;
+    case A_UCMDARG3:
+        stl_le_p(&u->reg.ucmdarg3, data);
+        break;
+    case A_UTRLCLR:
+    case A_UTMRLDBR:
+    case A_UTMRLCLR:
+    case A_UTMRLRSR:
+        trace_ufs_err_unsupport_register_offset(offset);
+        break;
+    default:
+        trace_ufs_err_invalid_register_offset(offset);
+        break;
+    }
+}
+
+static uint64_t ufs_mmio_read(void *opaque, hwaddr addr, unsigned size)
+{
+    UfsHc *u = (UfsHc *)opaque;
+    uint8_t *ptr = (uint8_t *)&u->reg;
+    uint64_t value;
+
+    if (addr > sizeof(u->reg) - size) {
+        trace_ufs_err_invalid_register_offset(addr);
+        return 0;
+    }
+
+    value = ldn_le_p(ptr + addr, size);
+    trace_ufs_mmio_read(addr, value, size);
+    return value;
+}
+
+static void ufs_mmio_write(void *opaque, hwaddr addr, uint64_t data,
+                           unsigned size)
+{
+    UfsHc *u = (UfsHc *)opaque;
+
+    if (addr > sizeof(u->reg) - size) {
+        trace_ufs_err_invalid_register_offset(addr);
+        return;
+    }
+
+    trace_ufs_mmio_write(addr, data, size);
+    ufs_write_reg(u, addr, data, size);
+}
+
+static const MemoryRegionOps ufs_mmio_ops = {
+    .read = ufs_mmio_read,
+    .write = ufs_mmio_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static bool ufs_check_constraints(UfsHc *u, Error **errp)
+{
+    if (u->params.nutrs > UFS_MAX_NUTRS) {
+        error_setg(errp, "nutrs must be less than or equal to %d",
+                   UFS_MAX_NUTRS);
+        return false;
+    }
+
+    if (u->params.nutmrs > UFS_MAX_NUTMRS) {
+        error_setg(errp, "nutmrs must be less than or equal to %d",
+                   UFS_MAX_NUTMRS);
+        return false;
+    }
+
+    return true;
+}
+
+static void ufs_init_pci(UfsHc *u, PCIDevice *pci_dev)
+{
+    uint8_t *pci_conf = pci_dev->config;
+
+    pci_conf[PCI_INTERRUPT_PIN] = 1;
+    pci_config_set_prog_interface(pci_conf, 0x1);
+
+    memory_region_init_io(&u->iomem, OBJECT(u), &ufs_mmio_ops, u, "ufs",
+                          u->reg_size);
+    pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &u->iomem);
+    u->irq = pci_allocate_irq(pci_dev);
+}
+
+static void ufs_init_hc(UfsHc *u)
+{
+    uint32_t cap = 0;
+
+    u->reg_size = pow2ceil(sizeof(UfsReg));
+
+    memset(&u->reg, 0, sizeof(u->reg));
+    cap = FIELD_DP32(cap, CAP, NUTRS, (u->params.nutrs - 1));
+    cap = FIELD_DP32(cap, CAP, RTT, 2);
+    cap = FIELD_DP32(cap, CAP, NUTMRS, (u->params.nutmrs - 1));
+    cap = FIELD_DP32(cap, CAP, AUTOH8, 0);
+    cap = FIELD_DP32(cap, CAP, 64AS, 1);
+    cap = FIELD_DP32(cap, CAP, OODDS, 0);
+    cap = FIELD_DP32(cap, CAP, UICDMETMS, 0);
+    cap = FIELD_DP32(cap, CAP, CS, 0);
+    stl_le_p(&u->reg.cap, cap);
+    stl_le_p(&u->reg.ver, UFS_SPEC_VER);
+}
+
+static void ufs_realize(PCIDevice *pci_dev, Error **errp)
+{
+    UfsHc *u = UFS(pci_dev);
+
+    if (!ufs_check_constraints(u, errp)) {
+        return;
+    }
+
+    ufs_init_hc(u);
+    ufs_init_pci(u, pci_dev);
+}
+
+static Property ufs_props[] = {
+    DEFINE_PROP_STRING("serial", UfsHc, params.serial),
+    DEFINE_PROP_UINT8("nutrs", UfsHc, params.nutrs, 32),
+    DEFINE_PROP_UINT8("nutmrs", UfsHc, params.nutmrs, 8),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static const VMStateDescription ufs_vmstate = {
+    .name = "ufs",
+    .unmigratable = 1,
+};
+
+static void ufs_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
+
+    pc->realize = ufs_realize;
+    pc->vendor_id = PCI_VENDOR_ID_REDHAT;
+    pc->device_id = PCI_DEVICE_ID_REDHAT_UFS;
+    pc->class_id = PCI_CLASS_STORAGE_UFS;
+
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    dc->desc = "Universal Flash Storage";
+    device_class_set_props(dc, ufs_props);
+    dc->vmsd = &ufs_vmstate;
+}
+
+static const TypeInfo ufs_info = {
+    .name = TYPE_UFS,
+    .parent = TYPE_PCI_DEVICE,
+    .class_init = ufs_class_init,
+    .instance_size = sizeof(UfsHc),
+    .interfaces = (InterfaceInfo[]){ { INTERFACE_PCIE_DEVICE }, {} },
+};
+
+static void ufs_register_types(void)
+{
+    type_register_static(&ufs_info);
+}
+
+type_init(ufs_register_types)
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
new file mode 100644
index 0000000000..e7ae887001
--- /dev/null
+++ b/hw/ufs/ufs.h
@@ -0,0 +1,42 @@
+/*
+ * QEMU UFS
+ *
+ * Copyright (c) 2023 Samsung Electronics Co., Ltd. All rights reserved.
+ *
+ * Written by Jeuk Kim <jeuk20.kim@samsung.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_UFS_UFS_H
+#define HW_UFS_UFS_H
+
+#include "hw/pci/pci_device.h"
+#include "hw/scsi/scsi.h"
+#include "block/ufs.h"
+
+#define UFS_MAX_LUS 32
+#define UFS_LOGICAL_BLK_SIZE 4096
+
+typedef struct UfsParams {
+    char *serial;
+    uint8_t nutrs; /* Number of UTP Transfer Request Slots */
+    uint8_t nutmrs; /* Number of UTP Task Management Request Slots */
+} UfsParams;
+
+typedef struct UfsHc {
+    PCIDevice parent_obj;
+    MemoryRegion iomem;
+    UfsReg reg;
+    UfsParams params;
+    uint32_t reg_size;
+
+    qemu_irq irq;
+    QEMUBH *doorbell_bh;
+    QEMUBH *complete_bh;
+} UfsHc;
+
+#define TYPE_UFS "ufs"
+#define UFS(obj) OBJECT_CHECK(UfsHc, (obj), TYPE_UFS)
+
+#endif /* HW_UFS_UFS_H */
diff --git a/include/block/ufs.h b/include/block/ufs.h
new file mode 100644
index 0000000000..8d2f079b25
--- /dev/null
+++ b/include/block/ufs.h
@@ -0,0 +1,1048 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef BLOCK_UFS_H
+#define BLOCK_UFS_H
+
+#include "hw/registerfields.h"
+
+typedef struct QEMU_PACKED UfsReg {
+    uint32_t cap;
+    uint32_t rsvd0;
+    uint32_t ver;
+    uint32_t rsvd1;
+    uint32_t hcpid;
+    uint32_t hcmid;
+    uint32_t ahit;
+    uint32_t rsvd2;
+    uint32_t is;
+    uint32_t ie;
+    uint32_t rsvd3[2];
+    uint32_t hcs;
+    uint32_t hce;
+    uint32_t uecpa;
+    uint32_t uecdl;
+    uint32_t uecn;
+    uint32_t uect;
+    uint32_t uecdme;
+    uint32_t utriacr;
+    uint32_t utrlba;
+    uint32_t utrlbau;
+    uint32_t utrldbr;
+    uint32_t utrlclr;
+    uint32_t utrlrsr;
+    uint32_t utrlcnr;
+    uint32_t rsvd4[2];
+    uint32_t utmrlba;
+    uint32_t utmrlbau;
+    uint32_t utmrldbr;
+    uint32_t utmrlclr;
+    uint32_t utmrlrsr;
+    uint32_t rsvd5[3];
+    uint32_t uiccmd;
+    uint32_t ucmdarg1;
+    uint32_t ucmdarg2;
+    uint32_t ucmdarg3;
+    uint32_t rsvd6[4];
+    uint32_t rsvd7[4];
+    uint32_t rsvd8[16];
+    uint32_t ccap;
+} UfsReg;
+
+REG32(CAP, offsetof(UfsReg, cap))
+    FIELD(CAP, NUTRS, 0, 5)
+    FIELD(CAP, RTT, 8, 8)
+    FIELD(CAP, NUTMRS, 16, 3)
+    FIELD(CAP, AUTOH8, 23, 1)
+    FIELD(CAP, 64AS, 24, 1)
+    FIELD(CAP, OODDS, 25, 1)
+    FIELD(CAP, UICDMETMS, 26, 1)
+    FIELD(CAP, CS, 28, 1)
+REG32(VER, offsetof(UfsReg, ver))
+REG32(HCPID, offsetof(UfsReg, hcpid))
+REG32(HCMID, offsetof(UfsReg, hcmid))
+REG32(AHIT, offsetof(UfsReg, ahit))
+REG32(IS, offsetof(UfsReg, is))
+    FIELD(IS, UTRCS, 0, 1)
+    FIELD(IS, UDEPRI, 1, 1)
+    FIELD(IS, UE, 2, 1)
+    FIELD(IS, UTMS, 3, 1)
+    FIELD(IS, UPMS, 4, 1)
+    FIELD(IS, UHXS, 5, 1)
+    FIELD(IS, UHES, 6, 1)
+    FIELD(IS, ULLS, 7, 1)
+    FIELD(IS, ULSS, 8, 1)
+    FIELD(IS, UTMRCS, 9, 1)
+    FIELD(IS, UCCS, 10, 1)
+    FIELD(IS, DFES, 11, 1)
+    FIELD(IS, UTPES, 12, 1)
+    FIELD(IS, HCFES, 16, 1)
+    FIELD(IS, SBFES, 17, 1)
+    FIELD(IS, CEFES, 18, 1)
+REG32(IE, offsetof(UfsReg, ie))
+REG32(HCS, offsetof(UfsReg, hcs))
+    FIELD(HCS, DP, 0, 1)
+    FIELD(HCS, UTRLRDY, 1, 1)
+    FIELD(HCS, UTMRLRDY, 2, 1)
+    FIELD(HCS, UCRDY, 3, 1)
+    FIELD(HCS, UPMCRS, 8, 3)
+REG32(HCE, offsetof(UfsReg, hce))
+    FIELD(HCE, HCE, 0, 1)
+    FIELD(HCE, CGE, 1, 1)
+REG32(UECPA, offsetof(UfsReg, uecpa))
+REG32(UECDL, offsetof(UfsReg, uecdl))
+REG32(UECN, offsetof(UfsReg, uecn))
+REG32(UECT, offsetof(UfsReg, uect))
+REG32(UECDME, offsetof(UfsReg, uecdme))
+REG32(UTRIACR, offsetof(UfsReg, utriacr))
+REG32(UTRLBA, offsetof(UfsReg, utrlba))
+    FIELD(UTRLBA, UTRLBA, 9, 22)
+REG32(UTRLBAU, offsetof(UfsReg, utrlbau))
+REG32(UTRLDBR, offsetof(UfsReg, utrldbr))
+REG32(UTRLCLR, offsetof(UfsReg, utrlclr))
+REG32(UTRLRSR, offsetof(UfsReg, utrlrsr))
+REG32(UTRLCNR, offsetof(UfsReg, utrlcnr))
+REG32(UTMRLBA, offsetof(UfsReg, utmrlba))
+    FIELD(UTMRLBA, UTMRLBA, 9, 22)
+REG32(UTMRLBAU, offsetof(UfsReg, utmrlbau))
+REG32(UTMRLDBR, offsetof(UfsReg, utmrldbr))
+REG32(UTMRLCLR, offsetof(UfsReg, utmrlclr))
+REG32(UTMRLRSR, offsetof(UfsReg, utmrlrsr))
+REG32(UICCMD, offsetof(UfsReg, uiccmd))
+REG32(UCMDARG1, offsetof(UfsReg, ucmdarg1))
+REG32(UCMDARG2, offsetof(UfsReg, ucmdarg2))
+REG32(UCMDARG3, offsetof(UfsReg, ucmdarg3))
+REG32(CCAP, offsetof(UfsReg, ccap))
+
+#define UFS_INTR_MASK                                    \
+    ((1 << R_IS_CEFES_SHIFT) | (1 << R_IS_SBFES_SHIFT) | \
+     (1 << R_IS_HCFES_SHIFT) | (1 << R_IS_UTPES_SHIFT) | \
+     (1 << R_IS_DFES_SHIFT) | (1 << R_IS_UCCS_SHIFT) |   \
+     (1 << R_IS_UTMRCS_SHIFT) | (1 << R_IS_ULSS_SHIFT) | \
+     (1 << R_IS_ULLS_SHIFT) | (1 << R_IS_UHES_SHIFT) |   \
+     (1 << R_IS_UHXS_SHIFT) | (1 << R_IS_UPMS_SHIFT) |   \
+     (1 << R_IS_UTMS_SHIFT) | (1 << R_IS_UE_SHIFT) |     \
+     (1 << R_IS_UDEPRI_SHIFT) | (1 << R_IS_UTRCS_SHIFT))
+
+#define UFS_UPIU_HEADER_TRANSACTION_TYPE_SHIFT 24
+#define UFS_UPIU_HEADER_TRANSACTION_TYPE_MASK 0xff
+#define UFS_UPIU_HEADER_TRANSACTION_TYPE(dword0)                       \
+    ((be32_to_cpu(dword0) >> UFS_UPIU_HEADER_TRANSACTION_TYPE_SHIFT) & \
+     UFS_UPIU_HEADER_TRANSACTION_TYPE_MASK)
+
+#define UFS_UPIU_HEADER_QUERY_FUNC_SHIFT 16
+#define UFS_UPIU_HEADER_QUERY_FUNC_MASK 0xff
+#define UFS_UPIU_HEADER_QUERY_FUNC(dword1)                       \
+    ((be32_to_cpu(dword1) >> UFS_UPIU_HEADER_QUERY_FUNC_SHIFT) & \
+     UFS_UPIU_HEADER_QUERY_FUNC_MASK)
+
+#define UFS_UPIU_HEADER_DATA_SEGMENT_LENGTH_SHIFT 0
+#define UFS_UPIU_HEADER_DATA_SEGMENT_LENGTH_MASK 0xffff
+#define UFS_UPIU_HEADER_DATA_SEGMENT_LENGTH(dword2)                       \
+    ((be32_to_cpu(dword2) >> UFS_UPIU_HEADER_DATA_SEGMENT_LENGTH_SHIFT) & \
+     UFS_UPIU_HEADER_DATA_SEGMENT_LENGTH_MASK)
+
+typedef struct QEMU_PACKED DeviceDescriptor {
+    uint8_t length;
+    uint8_t descriptor_idn;
+    uint8_t device;
+    uint8_t device_class;
+    uint8_t device_sub_class;
+    uint8_t protocol;
+    uint8_t number_lu;
+    uint8_t number_wlu;
+    uint8_t boot_enable;
+    uint8_t descr_access_en;
+    uint8_t init_power_mode;
+    uint8_t high_priority_lun;
+    uint8_t secure_removal_type;
+    uint8_t security_lu;
+    uint8_t background_ops_term_lat;
+    uint8_t init_active_icc_level;
+    uint16_t spec_version;
+    uint16_t manufacture_date;
+    uint8_t manufacturer_name;
+    uint8_t product_name;
+    uint8_t serial_number;
+    uint8_t oem_id;
+    uint16_t manufacturer_id;
+    uint8_t ud_0_base_offset;
+    uint8_t ud_config_p_length;
+    uint8_t device_rtt_cap;
+    uint16_t periodic_rtc_update;
+    uint8_t ufs_features_support;
+    uint8_t ffu_timeout;
+    uint8_t queue_depth;
+    uint16_t device_version;
+    uint8_t num_secure_wp_area;
+    uint32_t psa_max_data_size;
+    uint8_t psa_state_timeout;
+    uint8_t product_revision_level;
+    uint8_t reserved[36];
+    uint32_t extended_ufs_features_support;
+    uint8_t write_booster_buffer_preserve_user_space_en;
+    uint8_t write_booster_buffer_type;
+    uint32_t num_shared_write_booster_buffer_alloc_units;
+} DeviceDescriptor;
+
+typedef struct QEMU_PACKED GeometryDescriptor {
+    uint8_t length;
+    uint8_t descriptor_idn;
+    uint8_t media_technology;
+    uint8_t reserved;
+    uint64_t total_raw_device_capacity;
+    uint8_t max_number_lu;
+    uint32_t segment_size;
+    uint8_t allocation_unit_size;
+    uint8_t min_addr_block_size;
+    uint8_t optimal_read_block_size;
+    uint8_t optimal_write_block_size;
+    uint8_t max_in_buffer_size;
+    uint8_t max_out_buffer_size;
+    uint8_t rpmb_read_write_size;
+    uint8_t dynamic_capacity_resource_policy;
+    uint8_t data_ordering;
+    uint8_t max_context_id_number;
+    uint8_t sys_data_tag_unit_size;
+    uint8_t sys_data_tag_res_size;
+    uint8_t supported_sec_r_types;
+    uint16_t supported_memory_types;
+    uint32_t system_code_max_n_alloc_u;
+    uint16_t system_code_cap_adj_fac;
+    uint32_t non_persist_max_n_alloc_u;
+    uint16_t non_persist_cap_adj_fac;
+    uint32_t enhanced_1_max_n_alloc_u;
+    uint16_t enhanced_1_cap_adj_fac;
+    uint32_t enhanced_2_max_n_alloc_u;
+    uint16_t enhanced_2_cap_adj_fac;
+    uint32_t enhanced_3_max_n_alloc_u;
+    uint16_t enhanced_3_cap_adj_fac;
+    uint32_t enhanced_4_max_n_alloc_u;
+    uint16_t enhanced_4_cap_adj_fac;
+    uint32_t optimal_logical_block_size;
+    uint8_t reserved2[7];
+    uint32_t write_booster_buffer_max_n_alloc_units;
+    uint8_t device_max_write_booster_l_us;
+    uint8_t write_booster_buffer_cap_adj_fac;
+    uint8_t supported_write_booster_buffer_user_space_reduction_types;
+    uint8_t supported_write_booster_buffer_types;
+} GeometryDescriptor;
+
+#define UFS_GEOMETRY_CAPACITY_SHIFT 9
+
+typedef struct QEMU_PACKED UnitDescriptor {
+    uint8_t length;
+    uint8_t descriptor_idn;
+    uint8_t unit_index;
+    uint8_t lu_enable;
+    uint8_t boot_lun_id;
+    uint8_t lu_write_protect;
+    uint8_t lu_queue_depth;
+    uint8_t psa_sensitive;
+    uint8_t memory_type;
+    uint8_t data_reliability;
+    uint8_t logical_block_size;
+    uint64_t logical_block_count;
+    uint32_t erase_block_size;
+    uint8_t provisioning_type;
+    uint64_t phy_mem_resource_count;
+    uint16_t context_capabilities;
+    uint8_t large_unit_granularity_m1;
+    uint8_t reserved[6];
+    uint32_t lu_num_write_booster_buffer_alloc_units;
+} UnitDescriptor;
+
+typedef struct QEMU_PACKED RpmbUnitDescriptor {
+    uint8_t length;
+    uint8_t descriptor_idn;
+    uint8_t unit_index;
+    uint8_t lu_enable;
+    uint8_t boot_lun_id;
+    uint8_t lu_write_protect;
+    uint8_t lu_queue_depth;
+    uint8_t psa_sensitive;
+    uint8_t memory_type;
+    uint8_t reserved;
+    uint8_t logical_block_size;
+    uint64_t logical_block_count;
+    uint32_t erase_block_size;
+    uint8_t provisioning_type;
+    uint64_t phy_mem_resource_count;
+    uint8_t reserved2[3];
+} RpmbUnitDescriptor;
+
+typedef struct QEMU_PACKED PowerParametersDescriptor {
+    uint8_t length;
+    uint8_t descriptor_idn;
+    uint16_t active_icc_levels_vcc[16];
+    uint16_t active_icc_levels_vccq[16];
+    uint16_t active_icc_levels_vccq_2[16];
+} PowerParametersDescriptor;
+
+typedef struct QEMU_PACKED InterconnectDescriptor {
+    uint8_t length;
+    uint8_t descriptor_idn;
+    uint16_t bcd_unipro_version;
+    uint16_t bcd_mphy_version;
+} InterconnectDescriptor;
+
+typedef struct QEMU_PACKED StringDescriptor {
+    uint8_t length;
+    uint8_t descriptor_idn;
+    uint16_t UC[126];
+} StringDescriptor;
+
+typedef struct QEMU_PACKED DeviceHealthDescriptor {
+    uint8_t length;
+    uint8_t descriptor_idn;
+    uint8_t pre_eol_info;
+    uint8_t device_life_time_est_a;
+    uint8_t device_life_time_est_b;
+    uint8_t vendor_prop_info[32];
+    uint32_t refresh_total_count;
+    uint32_t refresh_progress;
+} DeviceHealthDescriptor;
+
+typedef struct QEMU_PACKED Flags {
+    uint8_t reserved;
+    uint8_t device_init;
+    uint8_t permanent_wp_en;
+    uint8_t power_on_wp_en;
+    uint8_t background_ops_en;
+    uint8_t device_life_span_mode_en;
+    uint8_t purge_enable;
+    uint8_t refresh_enable;
+    uint8_t phy_resource_removal;
+    uint8_t busy_rtc;
+    uint8_t reserved2;
+    uint8_t permanently_disable_fw_update;
+    uint8_t reserved3[2];
+    uint8_t wb_en;
+    uint8_t wb_buffer_flush_en;
+    uint8_t wb_buffer_flush_during_hibernate;
+    uint8_t reserved4[2];
+} Flags;
+
+typedef struct Attributes {
+    uint8_t boot_lun_en;
+    uint8_t reserved;
+    uint8_t current_power_mode;
+    uint8_t active_icc_level;
+    uint8_t out_of_order_data_en;
+    uint8_t background_op_status;
+    uint8_t purge_status;
+    uint8_t max_data_in_size;
+    uint8_t max_data_out_size;
+    uint32_t dyn_cap_needed;
+    uint8_t ref_clk_freq;
+    uint8_t config_descr_lock;
+    uint8_t max_num_of_rtt;
+    uint16_t exception_event_control;
+    uint16_t exception_event_status;
+    uint32_t seconds_passed;
+    uint16_t context_conf;
+    uint8_t device_ffu_status;
+    uint8_t psa_state;
+    uint32_t psa_data_size;
+    uint8_t ref_clk_gating_wait_time;
+    uint8_t device_case_rough_temperaure;
+    uint8_t device_too_high_temp_boundary;
+    uint8_t device_too_low_temp_boundary;
+    uint8_t throttling_status;
+    uint8_t wb_buffer_flush_status;
+    uint8_t available_wb_buffer_size;
+    uint8_t wb_buffer_life_time_est;
+    uint32_t current_wb_buffer_size;
+    uint8_t refresh_status;
+    uint8_t refresh_freq;
+    uint8_t refresh_unit;
+    uint8_t refresh_method;
+} Attributes;
+
+#define UFS_TRANSACTION_SPECIFIC_FIELD_SIZE 20
+#define UFS_MAX_QUERY_DATA_SIZE 256
+
+/* Command response result code */
+typedef enum CommandRespCode {
+    COMMAND_RESULT_SUCESS = 0x00,
+    COMMAND_RESULT_FAIL = 0x01,
+} CommandRespCode;
+
+enum {
+    UFS_UPIU_FLAG_UNDERFLOW = 0x20,
+    UFS_UPIU_FLAG_OVERFLOW = 0x40,
+};
+
+typedef struct QEMU_PACKED UtpUpiuHeader {
+    uint8_t trans_type;
+    uint8_t flags;
+    uint8_t lun;
+    uint8_t task_tag;
+    uint8_t iid_cmd_set_type;
+    uint8_t query_func;
+    uint8_t response;
+    uint8_t scsi_status;
+    uint8_t ehs_len;
+    uint8_t device_inf;
+    uint16_t data_segment_length;
+} UtpUpiuHeader;
+
+/*
+ * The code below is copied from the linux kernel
+ * ("include/uapi/scsi/scsi_bsg_ufs.h") and modified to fit the qemu style.
+ */
+
+typedef struct QEMU_PACKED UtpUpiuQuery {
+    uint8_t opcode;
+    uint8_t idn;
+    uint8_t index;
+    uint8_t selector;
+    uint16_t reserved_osf;
+    uint16_t length;
+    uint32_t value;
+    uint32_t reserved[2];
+    /* EHS length should be 0. We don't have to worry about EHS area. */
+    uint8_t data[UFS_MAX_QUERY_DATA_SIZE];
+} UtpUpiuQuery;
+
+#define UFS_CDB_SIZE 16
+
+/*
+ * struct UtpUpiuCmd - Command UPIU structure
+ * @data_transfer_len: Data Transfer Length DW-3
+ * @cdb: Command Descriptor Block CDB DW-4 to DW-7
+ */
+typedef struct QEMU_PACKED UtpUpiuCmd {
+    uint32_t exp_data_transfer_len;
+    uint8_t cdb[UFS_CDB_SIZE];
+} UtpUpiuCmd;
+
+/*
+ * struct UtpUpiuReq - general upiu request structure
+ * @header:UPIU header structure DW-0 to DW-2
+ * @sc: fields structure for scsi command DW-3 to DW-7
+ * @qr: fields structure for query request DW-3 to DW-7
+ * @uc: use utp_upiu_query to host the 4 dwords of uic command
+ */
+typedef struct QEMU_PACKED UtpUpiuReq {
+    UtpUpiuHeader header;
+    union {
+        UtpUpiuCmd sc;
+        UtpUpiuQuery qr;
+    };
+} UtpUpiuReq;
+
+/*
+ * The code below is copied from the linux kernel ("include/ufs/ufshci.h") and
+ * modified to fit the qemu style.
+ */
+
+enum {
+    PWR_OK = 0x0,
+    PWR_LOCAL = 0x01,
+    PWR_REMOTE = 0x02,
+    PWR_BUSY = 0x03,
+    PWR_ERROR_CAP = 0x04,
+    PWR_FATAL_ERROR = 0x05,
+};
+
+/* UIC Commands */
+enum uic_cmd_dme {
+    UIC_CMD_DME_GET = 0x01,
+    UIC_CMD_DME_SET = 0x02,
+    UIC_CMD_DME_PEER_GET = 0x03,
+    UIC_CMD_DME_PEER_SET = 0x04,
+    UIC_CMD_DME_POWERON = 0x10,
+    UIC_CMD_DME_POWEROFF = 0x11,
+    UIC_CMD_DME_ENABLE = 0x12,
+    UIC_CMD_DME_RESET = 0x14,
+    UIC_CMD_DME_END_PT_RST = 0x15,
+    UIC_CMD_DME_LINK_STARTUP = 0x16,
+    UIC_CMD_DME_HIBER_ENTER = 0x17,
+    UIC_CMD_DME_HIBER_EXIT = 0x18,
+    UIC_CMD_DME_TEST_MODE = 0x1A,
+};
+
+/* UIC Config result code / Generic error code */
+enum {
+    UIC_CMD_RESULT_SUCCESS = 0x00,
+    UIC_CMD_RESULT_INVALID_ATTR = 0x01,
+    UIC_CMD_RESULT_FAILURE = 0x01,
+    UIC_CMD_RESULT_INVALID_ATTR_VALUE = 0x02,
+    UIC_CMD_RESULT_READ_ONLY_ATTR = 0x03,
+    UIC_CMD_RESULT_WRITE_ONLY_ATTR = 0x04,
+    UIC_CMD_RESULT_BAD_INDEX = 0x05,
+    UIC_CMD_RESULT_LOCKED_ATTR = 0x06,
+    UIC_CMD_RESULT_BAD_TEST_FEATURE_INDEX = 0x07,
+    UIC_CMD_RESULT_PEER_COMM_FAILURE = 0x08,
+    UIC_CMD_RESULT_BUSY = 0x09,
+    UIC_CMD_RESULT_DME_FAILURE = 0x0A,
+};
+
+#define MASK_UIC_COMMAND_RESULT 0xFF
+
+/*
+ * Request Descriptor Definitions
+ */
+
+/* Transfer request command type */
+enum {
+    UTP_CMD_TYPE_SCSI = 0x0,
+    UTP_CMD_TYPE_UFS = 0x1,
+    UTP_CMD_TYPE_DEV_MANAGE = 0x2,
+};
+
+/* To accommodate UFS2.0 required Command type */
+enum {
+    UTP_CMD_TYPE_UFS_STORAGE = 0x1,
+};
+
+enum {
+    UTP_SCSI_COMMAND = 0x00000000,
+    UTP_NATIVE_UFS_COMMAND = 0x10000000,
+    UTP_DEVICE_MANAGEMENT_FUNCTION = 0x20000000,
+    UTP_REQ_DESC_INT_CMD = 0x01000000,
+    UTP_REQ_DESC_CRYPTO_ENABLE_CMD = 0x00800000,
+};
+
+/* UTP Transfer Request Data Direction (DD) */
+enum {
+    UTP_NO_DATA_TRANSFER = 0x00000000,
+    UTP_HOST_TO_DEVICE = 0x02000000,
+    UTP_DEVICE_TO_HOST = 0x04000000,
+};
+
+/* Overall command status values */
+enum UtpOcsCodes {
+    OCS_SUCCESS = 0x0,
+    OCS_INVALID_CMD_TABLE_ATTR = 0x1,
+    OCS_INVALID_PRDT_ATTR = 0x2,
+    OCS_MISMATCH_DATA_BUF_SIZE = 0x3,
+    OCS_MISMATCH_RESP_UPIU_SIZE = 0x4,
+    OCS_PEER_COMM_FAILURE = 0x5,
+    OCS_ABORTED = 0x6,
+    OCS_FATAL_ERROR = 0x7,
+    OCS_DEVICE_FATAL_ERROR = 0x8,
+    OCS_INVALID_CRYPTO_CONFIG = 0x9,
+    OCS_GENERAL_CRYPTO_ERROR = 0xa,
+    OCS_INVALID_COMMAND_STATUS = 0xf,
+};
+
+enum {
+    MASK_OCS = 0x0F,
+};
+
+/*
+ * struct UfshcdSgEntry - UFSHCI PRD Entry
+ * @addr: Physical address; DW-0 and DW-1.
+ * @reserved: Reserved for future use DW-2
+ * @size: size of physical segment DW-3
+ */
+typedef struct QEMU_PACKED UfshcdSgEntry {
+    uint64_t addr;
+    uint32_t reserved;
+    uint32_t size;
+    /*
+     * followed by variant-specific fields if
+     * CONFIG_SCSI_UFS_VARIABLE_SG_ENTRY_SIZE has been defined.
+     */
+} UfshcdSgEntry;
+
+/*
+ * struct RequestDescHeader - Descriptor Header common to both UTRD and UTMRD
+ * @dword0: Descriptor Header DW0
+ * @dword1: Descriptor Header DW1
+ * @dword2: Descriptor Header DW2
+ * @dword3: Descriptor Header DW3
+ */
+typedef struct QEMU_PACKED RequestDescHeader {
+    uint32_t dword_0;
+    uint32_t dword_1;
+    uint32_t dword_2;
+    uint32_t dword_3;
+} RequestDescHeader;
+
+/*
+ * struct UtpTransferReqDesc - UTP Transfer Request Descriptor (UTRD)
+ * @header: UTRD header DW-0 to DW-3
+ * @command_desc_base_addr_lo: UCD base address low DW-4
+ * @command_desc_base_addr_hi: UCD base address high DW-5
+ * @response_upiu_length: response UPIU length DW-6
+ * @response_upiu_offset: response UPIU offset DW-6
+ * @prd_table_length: Physical region descriptor length DW-7
+ * @prd_table_offset: Physical region descriptor offset DW-7
+ */
+typedef struct QEMU_PACKED UtpTransferReqDesc {
+    /* DW 0-3 */
+    RequestDescHeader header;
+
+    /* DW 4-5*/
+    uint32_t command_desc_base_addr_lo;
+    uint32_t command_desc_base_addr_hi;
+
+    /* DW 6 */
+    uint16_t response_upiu_length;
+    uint16_t response_upiu_offset;
+
+    /* DW 7 */
+    uint16_t prd_table_length;
+    uint16_t prd_table_offset;
+} UtpTransferReqDesc;
+
+/*
+ * The code below is copied from the linux kernel ("include/ufs/ufs.h") and
+ * modified to fit the qemu style.
+ */
+
+#define GENERAL_UPIU_REQUEST_SIZE (sizeof(UtpUpiuReq))
+#define QUERY_DESC_MAX_SIZE 255
+#define QUERY_DESC_MIN_SIZE 2
+#define QUERY_DESC_HDR_SIZE 2
+#define QUERY_OSF_SIZE (GENERAL_UPIU_REQUEST_SIZE - (sizeof(UtpUpiuHeader)))
+#define UFS_SENSE_SIZE 18
+
+/*
+ * UFS device may have standard LUs and LUN id could be from 0x00 to
+ * 0x7F. Standard LUs use "Peripheral Device Addressing Format".
+ * UFS device may also have the Well Known LUs (also referred as W-LU)
+ * which again could be from 0x00 to 0x7F. For W-LUs, device only use
+ * the "Extended Addressing Format" which means the W-LUNs would be
+ * from 0xc100 (SCSI_W_LUN_BASE) onwards.
+ * This means max. LUN number reported from UFS device could be 0xC17F.
+ */
+#define UFS_UPIU_MAX_UNIT_NUM_ID 0x7F
+#define UFS_UPIU_WLUN_ID (1 << 7)
+
+/* WriteBooster buffer is available only for the logical unit from 0 to 7 */
+#define UFS_UPIU_MAX_WB_LUN_ID 8
+
+/*
+ * WriteBooster buffer lifetime has a limit setted by vendor.
+ * If it is over the limit, WriteBooster feature will be disabled.
+ */
+#define UFS_WB_EXCEED_LIFETIME 0x0B
+
+/*
+ * In UFS Spec, the Extra Header Segment (EHS) starts from byte 32 in UPIU
+ * request/response packet
+ */
+#define EHS_OFFSET_IN_RESPONSE 32
+
+/* Well known logical unit id in LUN field of UPIU */
+enum {
+    UFS_UPIU_REPORT_LUNS_WLUN = 0x81,
+    UFS_UPIU_UFS_DEVICE_WLUN = 0xD0,
+    UFS_UPIU_BOOT_WLUN = 0xB0,
+    UFS_UPIU_RPMB_WLUN = 0xC4,
+};
+
+/*
+ * UFS Protocol Information Unit related definitions
+ */
+
+/* Task management functions */
+enum {
+    UFS_ABORT_TASK = 0x01,
+    UFS_ABORT_TASK_SET = 0x02,
+    UFS_CLEAR_TASK_SET = 0x04,
+    UFS_LOGICAL_RESET = 0x08,
+    UFS_QUERY_TASK = 0x80,
+    UFS_QUERY_TASK_SET = 0x81,
+};
+
+/* UTP UPIU Transaction Codes Initiator to Target */
+enum {
+    UPIU_TRANSACTION_NOP_OUT = 0x00,
+    UPIU_TRANSACTION_COMMAND = 0x01,
+    UPIU_TRANSACTION_DATA_OUT = 0x02,
+    UPIU_TRANSACTION_TASK_REQ = 0x04,
+    UPIU_TRANSACTION_QUERY_REQ = 0x16,
+};
+
+/* UTP UPIU Transaction Codes Target to Initiator */
+enum {
+    UPIU_TRANSACTION_NOP_IN = 0x20,
+    UPIU_TRANSACTION_RESPONSE = 0x21,
+    UPIU_TRANSACTION_DATA_IN = 0x22,
+    UPIU_TRANSACTION_TASK_RSP = 0x24,
+    UPIU_TRANSACTION_READY_XFER = 0x31,
+    UPIU_TRANSACTION_QUERY_RSP = 0x36,
+    UPIU_TRANSACTION_REJECT_UPIU = 0x3F,
+};
+
+/* UPIU Read/Write flags */
+enum {
+    UPIU_CMD_FLAGS_NONE = 0x00,
+    UPIU_CMD_FLAGS_WRITE = 0x20,
+    UPIU_CMD_FLAGS_READ = 0x40,
+};
+
+/* UPIU Task Attributes */
+enum {
+    UPIU_TASK_ATTR_SIMPLE = 0x00,
+    UPIU_TASK_ATTR_ORDERED = 0x01,
+    UPIU_TASK_ATTR_HEADQ = 0x02,
+    UPIU_TASK_ATTR_ACA = 0x03,
+};
+
+/* UPIU Query request function */
+enum {
+    UPIU_QUERY_FUNC_STANDARD_READ_REQUEST = 0x01,
+    UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST = 0x81,
+};
+
+/* Flag idn for Query Requests*/
+enum flag_idn {
+    QUERY_FLAG_IDN_FDEVICEINIT = 0x01,
+    QUERY_FLAG_IDN_PERMANENT_WPE = 0x02,
+    QUERY_FLAG_IDN_PWR_ON_WPE = 0x03,
+    QUERY_FLAG_IDN_BKOPS_EN = 0x04,
+    QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE = 0x05,
+    QUERY_FLAG_IDN_PURGE_ENABLE = 0x06,
+    QUERY_FLAG_IDN_REFRESH_ENABLE = 0x07,
+    QUERY_FLAG_IDN_FPHYRESOURCEREMOVAL = 0x08,
+    QUERY_FLAG_IDN_BUSY_RTC = 0x09,
+    QUERY_FLAG_IDN_RESERVED3 = 0x0A,
+    QUERY_FLAG_IDN_PERMANENTLY_DISABLE_FW_UPDATE = 0x0B,
+    QUERY_FLAG_IDN_WB_EN = 0x0E,
+    QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN = 0x0F,
+    QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8 = 0x10,
+    QUERY_FLAG_IDN_HPB_RESET = 0x11,
+    QUERY_FLAG_IDN_HPB_EN = 0x12,
+    QUERY_FLAG_IDN_COUNT,
+};
+
+/* Attribute idn for Query requests */
+enum attr_idn {
+    QUERY_ATTR_IDN_BOOT_LU_EN = 0x00,
+    QUERY_ATTR_IDN_MAX_HPB_SINGLE_CMD = 0x01,
+    QUERY_ATTR_IDN_POWER_MODE = 0x02,
+    QUERY_ATTR_IDN_ACTIVE_ICC_LVL = 0x03,
+    QUERY_ATTR_IDN_OOO_DATA_EN = 0x04,
+    QUERY_ATTR_IDN_BKOPS_STATUS = 0x05,
+    QUERY_ATTR_IDN_PURGE_STATUS = 0x06,
+    QUERY_ATTR_IDN_MAX_DATA_IN = 0x07,
+    QUERY_ATTR_IDN_MAX_DATA_OUT = 0x08,
+    QUERY_ATTR_IDN_DYN_CAP_NEEDED = 0x09,
+    QUERY_ATTR_IDN_REF_CLK_FREQ = 0x0A,
+    QUERY_ATTR_IDN_CONF_DESC_LOCK = 0x0B,
+    QUERY_ATTR_IDN_MAX_NUM_OF_RTT = 0x0C,
+    QUERY_ATTR_IDN_EE_CONTROL = 0x0D,
+    QUERY_ATTR_IDN_EE_STATUS = 0x0E,
+    QUERY_ATTR_IDN_SECONDS_PASSED = 0x0F,
+    QUERY_ATTR_IDN_CNTX_CONF = 0x10,
+    QUERY_ATTR_IDN_CORR_PRG_BLK_NUM = 0x11,
+    QUERY_ATTR_IDN_RESERVED2 = 0x12,
+    QUERY_ATTR_IDN_RESERVED3 = 0x13,
+    QUERY_ATTR_IDN_FFU_STATUS = 0x14,
+    QUERY_ATTR_IDN_PSA_STATE = 0x15,
+    QUERY_ATTR_IDN_PSA_DATA_SIZE = 0x16,
+    QUERY_ATTR_IDN_REF_CLK_GATING_WAIT_TIME = 0x17,
+    QUERY_ATTR_IDN_CASE_ROUGH_TEMP = 0x18,
+    QUERY_ATTR_IDN_HIGH_TEMP_BOUND = 0x19,
+    QUERY_ATTR_IDN_LOW_TEMP_BOUND = 0x1A,
+    QUERY_ATTR_IDN_THROTTLING_STATUS = 0x1B,
+    QUERY_ATTR_IDN_WB_FLUSH_STATUS = 0x1C,
+    QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE = 0x1D,
+    QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST = 0x1E,
+    QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE = 0x1F,
+    QUERY_ATTR_IDN_REFRESH_STATUS = 0x2C,
+    QUERY_ATTR_IDN_REFRESH_FREQ = 0x2D,
+    QUERY_ATTR_IDN_REFRESH_UNIT = 0x2E,
+    QUERY_ATTR_IDN_COUNT,
+};
+
+/* Descriptor idn for Query requests */
+enum desc_idn {
+    QUERY_DESC_IDN_DEVICE = 0x0,
+    QUERY_DESC_IDN_CONFIGURATION = 0x1,
+    QUERY_DESC_IDN_UNIT = 0x2,
+    QUERY_DESC_IDN_RFU_0 = 0x3,
+    QUERY_DESC_IDN_INTERCONNECT = 0x4,
+    QUERY_DESC_IDN_STRING = 0x5,
+    QUERY_DESC_IDN_RFU_1 = 0x6,
+    QUERY_DESC_IDN_GEOMETRY = 0x7,
+    QUERY_DESC_IDN_POWER = 0x8,
+    QUERY_DESC_IDN_HEALTH = 0x9,
+    QUERY_DESC_IDN_MAX,
+};
+
+enum desc_header_offset {
+    QUERY_DESC_LENGTH_OFFSET = 0x00,
+    QUERY_DESC_DESC_TYPE_OFFSET = 0x01,
+};
+
+/* Unit descriptor parameters offsets in bytes*/
+enum unit_desc_param {
+    UNIT_DESC_PARAM_LEN = 0x0,
+    UNIT_DESC_PARAM_TYPE = 0x1,
+    UNIT_DESC_PARAM_UNIT_INDEX = 0x2,
+    UNIT_DESC_PARAM_LU_ENABLE = 0x3,
+    UNIT_DESC_PARAM_BOOT_LUN_ID = 0x4,
+    UNIT_DESC_PARAM_LU_WR_PROTECT = 0x5,
+    UNIT_DESC_PARAM_LU_Q_DEPTH = 0x6,
+    UNIT_DESC_PARAM_PSA_SENSITIVE = 0x7,
+    UNIT_DESC_PARAM_MEM_TYPE = 0x8,
+    UNIT_DESC_PARAM_DATA_RELIABILITY = 0x9,
+    UNIT_DESC_PARAM_LOGICAL_BLK_SIZE = 0xA,
+    UNIT_DESC_PARAM_LOGICAL_BLK_COUNT = 0xB,
+    UNIT_DESC_PARAM_ERASE_BLK_SIZE = 0x13,
+    UNIT_DESC_PARAM_PROVISIONING_TYPE = 0x17,
+    UNIT_DESC_PARAM_PHY_MEM_RSRC_CNT = 0x18,
+    UNIT_DESC_PARAM_CTX_CAPABILITIES = 0x20,
+    UNIT_DESC_PARAM_LARGE_UNIT_SIZE_M1 = 0x22,
+    UNIT_DESC_PARAM_HPB_LU_MAX_ACTIVE_RGNS = 0x23,
+    UNIT_DESC_PARAM_HPB_PIN_RGN_START_OFF = 0x25,
+    UNIT_DESC_PARAM_HPB_NUM_PIN_RGNS = 0x27,
+    UNIT_DESC_PARAM_WB_BUF_ALLOC_UNITS = 0x29,
+};
+
+/* RPMB Unit descriptor parameters offsets in bytes*/
+enum rpmb_unit_desc_param {
+    RPMB_UNIT_DESC_PARAM_LEN = 0x0,
+    RPMB_UNIT_DESC_PARAM_TYPE = 0x1,
+    RPMB_UNIT_DESC_PARAM_UNIT_INDEX = 0x2,
+    RPMB_UNIT_DESC_PARAM_LU_ENABLE = 0x3,
+    RPMB_UNIT_DESC_PARAM_BOOT_LUN_ID = 0x4,
+    RPMB_UNIT_DESC_PARAM_LU_WR_PROTECT = 0x5,
+    RPMB_UNIT_DESC_PARAM_LU_Q_DEPTH = 0x6,
+    RPMB_UNIT_DESC_PARAM_PSA_SENSITIVE = 0x7,
+    RPMB_UNIT_DESC_PARAM_MEM_TYPE = 0x8,
+    RPMB_UNIT_DESC_PARAM_REGION_EN = 0x9,
+    RPMB_UNIT_DESC_PARAM_LOGICAL_BLK_SIZE = 0xA,
+    RPMB_UNIT_DESC_PARAM_LOGICAL_BLK_COUNT = 0xB,
+    RPMB_UNIT_DESC_PARAM_REGION0_SIZE = 0x13,
+    RPMB_UNIT_DESC_PARAM_REGION1_SIZE = 0x14,
+    RPMB_UNIT_DESC_PARAM_REGION2_SIZE = 0x15,
+    RPMB_UNIT_DESC_PARAM_REGION3_SIZE = 0x16,
+    RPMB_UNIT_DESC_PARAM_PROVISIONING_TYPE = 0x17,
+    RPMB_UNIT_DESC_PARAM_PHY_MEM_RSRC_CNT = 0x18,
+};
+
+/* Device descriptor parameters offsets in bytes*/
+enum device_desc_param {
+    DEVICE_DESC_PARAM_LEN = 0x0,
+    DEVICE_DESC_PARAM_TYPE = 0x1,
+    DEVICE_DESC_PARAM_DEVICE_TYPE = 0x2,
+    DEVICE_DESC_PARAM_DEVICE_CLASS = 0x3,
+    DEVICE_DESC_PARAM_DEVICE_SUB_CLASS = 0x4,
+    DEVICE_DESC_PARAM_PRTCL = 0x5,
+    DEVICE_DESC_PARAM_NUM_LU = 0x6,
+    DEVICE_DESC_PARAM_NUM_WLU = 0x7,
+    DEVICE_DESC_PARAM_BOOT_ENBL = 0x8,
+    DEVICE_DESC_PARAM_DESC_ACCSS_ENBL = 0x9,
+    DEVICE_DESC_PARAM_INIT_PWR_MODE = 0xA,
+    DEVICE_DESC_PARAM_HIGH_PR_LUN = 0xB,
+    DEVICE_DESC_PARAM_SEC_RMV_TYPE = 0xC,
+    DEVICE_DESC_PARAM_SEC_LU = 0xD,
+    DEVICE_DESC_PARAM_BKOP_TERM_LT = 0xE,
+    DEVICE_DESC_PARAM_ACTVE_ICC_LVL = 0xF,
+    DEVICE_DESC_PARAM_SPEC_VER = 0x10,
+    DEVICE_DESC_PARAM_MANF_DATE = 0x12,
+    DEVICE_DESC_PARAM_MANF_NAME = 0x14,
+    DEVICE_DESC_PARAM_PRDCT_NAME = 0x15,
+    DEVICE_DESC_PARAM_SN = 0x16,
+    DEVICE_DESC_PARAM_OEM_ID = 0x17,
+    DEVICE_DESC_PARAM_MANF_ID = 0x18,
+    DEVICE_DESC_PARAM_UD_OFFSET = 0x1A,
+    DEVICE_DESC_PARAM_UD_LEN = 0x1B,
+    DEVICE_DESC_PARAM_RTT_CAP = 0x1C,
+    DEVICE_DESC_PARAM_FRQ_RTC = 0x1D,
+    DEVICE_DESC_PARAM_UFS_FEAT = 0x1F,
+    DEVICE_DESC_PARAM_FFU_TMT = 0x20,
+    DEVICE_DESC_PARAM_Q_DPTH = 0x21,
+    DEVICE_DESC_PARAM_DEV_VER = 0x22,
+    DEVICE_DESC_PARAM_NUM_SEC_WPA = 0x24,
+    DEVICE_DESC_PARAM_PSA_MAX_DATA = 0x25,
+    DEVICE_DESC_PARAM_PSA_TMT = 0x29,
+    DEVICE_DESC_PARAM_PRDCT_REV = 0x2A,
+    DEVICE_DESC_PARAM_HPB_VER = 0x40,
+    DEVICE_DESC_PARAM_HPB_CONTROL = 0x42,
+    DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP = 0x4F,
+    DEVICE_DESC_PARAM_WB_PRESRV_USRSPC_EN = 0x53,
+    DEVICE_DESC_PARAM_WB_TYPE = 0x54,
+    DEVICE_DESC_PARAM_WB_SHARED_ALLOC_UNITS = 0x55,
+};
+
+/* Interconnect descriptor parameters offsets in bytes*/
+enum interconnect_desc_param {
+    INTERCONNECT_DESC_PARAM_LEN = 0x0,
+    INTERCONNECT_DESC_PARAM_TYPE = 0x1,
+    INTERCONNECT_DESC_PARAM_UNIPRO_VER = 0x2,
+    INTERCONNECT_DESC_PARAM_MPHY_VER = 0x4,
+};
+
+/* Geometry descriptor parameters offsets in bytes*/
+enum geometry_desc_param {
+    GEOMETRY_DESC_PARAM_LEN = 0x0,
+    GEOMETRY_DESC_PARAM_TYPE = 0x1,
+    GEOMETRY_DESC_PARAM_DEV_CAP = 0x4,
+    GEOMETRY_DESC_PARAM_MAX_NUM_LUN = 0xC,
+    GEOMETRY_DESC_PARAM_SEG_SIZE = 0xD,
+    GEOMETRY_DESC_PARAM_ALLOC_UNIT_SIZE = 0x11,
+    GEOMETRY_DESC_PARAM_MIN_BLK_SIZE = 0x12,
+    GEOMETRY_DESC_PARAM_OPT_RD_BLK_SIZE = 0x13,
+    GEOMETRY_DESC_PARAM_OPT_WR_BLK_SIZE = 0x14,
+    GEOMETRY_DESC_PARAM_MAX_IN_BUF_SIZE = 0x15,
+    GEOMETRY_DESC_PARAM_MAX_OUT_BUF_SIZE = 0x16,
+    GEOMETRY_DESC_PARAM_RPMB_RW_SIZE = 0x17,
+    GEOMETRY_DESC_PARAM_DYN_CAP_RSRC_PLC = 0x18,
+    GEOMETRY_DESC_PARAM_DATA_ORDER = 0x19,
+    GEOMETRY_DESC_PARAM_MAX_NUM_CTX = 0x1A,
+    GEOMETRY_DESC_PARAM_TAG_UNIT_SIZE = 0x1B,
+    GEOMETRY_DESC_PARAM_TAG_RSRC_SIZE = 0x1C,
+    GEOMETRY_DESC_PARAM_SEC_RM_TYPES = 0x1D,
+    GEOMETRY_DESC_PARAM_MEM_TYPES = 0x1E,
+    GEOMETRY_DESC_PARAM_SCM_MAX_NUM_UNITS = 0x20,
+    GEOMETRY_DESC_PARAM_SCM_CAP_ADJ_FCTR = 0x24,
+    GEOMETRY_DESC_PARAM_NPM_MAX_NUM_UNITS = 0x26,
+    GEOMETRY_DESC_PARAM_NPM_CAP_ADJ_FCTR = 0x2A,
+    GEOMETRY_DESC_PARAM_ENM1_MAX_NUM_UNITS = 0x2C,
+    GEOMETRY_DESC_PARAM_ENM1_CAP_ADJ_FCTR = 0x30,
+    GEOMETRY_DESC_PARAM_ENM2_MAX_NUM_UNITS = 0x32,
+    GEOMETRY_DESC_PARAM_ENM2_CAP_ADJ_FCTR = 0x36,
+    GEOMETRY_DESC_PARAM_ENM3_MAX_NUM_UNITS = 0x38,
+    GEOMETRY_DESC_PARAM_ENM3_CAP_ADJ_FCTR = 0x3C,
+    GEOMETRY_DESC_PARAM_ENM4_MAX_NUM_UNITS = 0x3E,
+    GEOMETRY_DESC_PARAM_ENM4_CAP_ADJ_FCTR = 0x42,
+    GEOMETRY_DESC_PARAM_OPT_LOG_BLK_SIZE = 0x44,
+    GEOMETRY_DESC_PARAM_HPB_REGION_SIZE = 0x48,
+    GEOMETRY_DESC_PARAM_HPB_NUMBER_LU = 0x49,
+    GEOMETRY_DESC_PARAM_HPB_SUBREGION_SIZE = 0x4A,
+    GEOMETRY_DESC_PARAM_HPB_MAX_ACTIVE_REGS = 0x4B,
+    GEOMETRY_DESC_PARAM_WB_MAX_ALLOC_UNITS = 0x4F,
+    GEOMETRY_DESC_PARAM_WB_MAX_WB_LUNS = 0x53,
+    GEOMETRY_DESC_PARAM_WB_BUFF_CAP_ADJ = 0x54,
+    GEOMETRY_DESC_PARAM_WB_SUP_RED_TYPE = 0x55,
+    GEOMETRY_DESC_PARAM_WB_SUP_WB_TYPE = 0x56,
+};
+
+/* Health descriptor parameters offsets in bytes*/
+enum health_desc_param {
+    HEALTH_DESC_PARAM_LEN = 0x0,
+    HEALTH_DESC_PARAM_TYPE = 0x1,
+    HEALTH_DESC_PARAM_EOL_INFO = 0x2,
+    HEALTH_DESC_PARAM_LIFE_TIME_EST_A = 0x3,
+    HEALTH_DESC_PARAM_LIFE_TIME_EST_B = 0x4,
+};
+
+/* WriteBooster buffer mode */
+enum {
+    WB_BUF_MODE_LU_DEDICATED = 0x0,
+    WB_BUF_MODE_SHARED = 0x1,
+};
+
+/*
+ * Logical Unit Write Protect
+ * 00h: LU not write protected
+ * 01h: LU write protected when fPowerOnWPEn =1
+ * 02h: LU permanently write protected when fPermanentWPEn =1
+ */
+enum ufs_lu_wp_type {
+    UFS_LU_NO_WP = 0x00,
+    UFS_LU_POWER_ON_WP = 0x01,
+    UFS_LU_PERM_WP = 0x02,
+};
+
+/* UTP QUERY Transaction Specific Fields OpCode */
+enum query_opcode {
+    UPIU_QUERY_OPCODE_NOP = 0x0,
+    UPIU_QUERY_OPCODE_READ_DESC = 0x1,
+    UPIU_QUERY_OPCODE_WRITE_DESC = 0x2,
+    UPIU_QUERY_OPCODE_READ_ATTR = 0x3,
+    UPIU_QUERY_OPCODE_WRITE_ATTR = 0x4,
+    UPIU_QUERY_OPCODE_READ_FLAG = 0x5,
+    UPIU_QUERY_OPCODE_SET_FLAG = 0x6,
+    UPIU_QUERY_OPCODE_CLEAR_FLAG = 0x7,
+    UPIU_QUERY_OPCODE_TOGGLE_FLAG = 0x8,
+};
+
+/* Query response result code */
+typedef enum QueryRespCode {
+    QUERY_RESULT_SUCCESS = 0x00,
+    QUERY_RESULT_NOT_READABLE = 0xF6,
+    QUERY_RESULT_NOT_WRITEABLE = 0xF7,
+    QUERY_RESULT_ALREADY_WRITTEN = 0xF8,
+    QUERY_RESULT_INVALID_LENGTH = 0xF9,
+    QUERY_RESULT_INVALID_VALUE = 0xFA,
+    QUERY_RESULT_INVALID_SELECTOR = 0xFB,
+    QUERY_RESULT_INVALID_INDEX = 0xFC,
+    QUERY_RESULT_INVALID_IDN = 0xFD,
+    QUERY_RESULT_INVALID_OPCODE = 0xFE,
+    QUERY_RESULT_GENERAL_FAILURE = 0xFF,
+} QueryRespCode;
+
+/* UTP Transfer Request Command Type (CT) */
+enum {
+    UPIU_COMMAND_SET_TYPE_SCSI = 0x0,
+    UPIU_COMMAND_SET_TYPE_UFS = 0x1,
+    UPIU_COMMAND_SET_TYPE_QUERY = 0x2,
+};
+
+/* Task management service response */
+enum {
+    UPIU_TASK_MANAGEMENT_FUNC_COMPL = 0x00,
+    UPIU_TASK_MANAGEMENT_FUNC_NOT_SUPPORTED = 0x04,
+    UPIU_TASK_MANAGEMENT_FUNC_SUCCEEDED = 0x08,
+    UPIU_TASK_MANAGEMENT_FUNC_FAILED = 0x05,
+    UPIU_INCORRECT_LOGICAL_UNIT_NO = 0x09,
+};
+
+/* UFS device power modes */
+enum ufs_dev_pwr_mode {
+    UFS_ACTIVE_PWR_MODE = 1,
+    UFS_SLEEP_PWR_MODE = 2,
+    UFS_POWERDOWN_PWR_MODE = 3,
+    UFS_DEEPSLEEP_PWR_MODE = 4,
+};
+
+/*
+ * struct UtpCmdRsp - Response UPIU structure
+ * @residual_transfer_count: Residual transfer count DW-3
+ * @reserved: Reserved double words DW-4 to DW-7
+ * @sense_data_len: Sense data length DW-8 U16
+ * @sense_data: Sense data field DW-8 to DW-12
+ */
+typedef struct QEMU_PACKED UtpCmdRsp {
+    uint32_t residual_transfer_count;
+    uint32_t reserved[4];
+    uint16_t sense_data_len;
+    uint8_t sense_data[UFS_SENSE_SIZE];
+} UtpCmdRsp;
+
+/*
+ * struct UtpUpiuRsp - general upiu response structure
+ * @header: UPIU header structure DW-0 to DW-2
+ * @sr: fields structure for scsi command DW-3 to DW-12
+ * @qr: fields structure for query request DW-3 to DW-7
+ */
+typedef struct QEMU_PACKED UtpUpiuRsp {
+    UtpUpiuHeader header;
+    union {
+        UtpCmdRsp sr;
+        UtpUpiuQuery qr;
+    };
+} UtpUpiuRsp;
+
+static inline void _ufs_check_size(void)
+{
+    QEMU_BUILD_BUG_ON(sizeof(UfsReg) != 0x104);
+    QEMU_BUILD_BUG_ON(sizeof(DeviceDescriptor) != 89);
+    QEMU_BUILD_BUG_ON(sizeof(GeometryDescriptor) != 87);
+    QEMU_BUILD_BUG_ON(sizeof(UnitDescriptor) != 45);
+    QEMU_BUILD_BUG_ON(sizeof(RpmbUnitDescriptor) != 35);
+    QEMU_BUILD_BUG_ON(sizeof(PowerParametersDescriptor) != 98);
+    QEMU_BUILD_BUG_ON(sizeof(InterconnectDescriptor) != 6);
+    QEMU_BUILD_BUG_ON(sizeof(StringDescriptor) != 254);
+    QEMU_BUILD_BUG_ON(sizeof(DeviceHealthDescriptor) != 45);
+    QEMU_BUILD_BUG_ON(sizeof(Flags) != 0x13);
+    QEMU_BUILD_BUG_ON(sizeof(UtpUpiuHeader) != 12);
+    QEMU_BUILD_BUG_ON(sizeof(UtpUpiuQuery) != 276);
+    QEMU_BUILD_BUG_ON(sizeof(UtpUpiuCmd) != 20);
+    QEMU_BUILD_BUG_ON(sizeof(UtpUpiuReq) != 288);
+    QEMU_BUILD_BUG_ON(sizeof(UfshcdSgEntry) != 16);
+    QEMU_BUILD_BUG_ON(sizeof(RequestDescHeader) != 16);
+    QEMU_BUILD_BUG_ON(sizeof(UtpTransferReqDesc) != 32);
+    QEMU_BUILD_BUG_ON(sizeof(UtpCmdRsp) != 40);
+    QEMU_BUILD_BUG_ON(sizeof(UtpUpiuRsp) != 288);
+}
+#endif
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index e6d0574a29..1094274546 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -114,6 +114,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_REDHAT_NVME        0x0010
 #define PCI_DEVICE_ID_REDHAT_PVPANIC     0x0011
 #define PCI_DEVICE_ID_REDHAT_ACPI_ERST   0x0012
+#define PCI_DEVICE_ID_REDHAT_UFS         0x0013
 #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
 
 #define FMT_PCIBUS                      PRIx64
diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
index e4386ebb20..85469b9b53 100644
--- a/include/hw/pci/pci_ids.h
+++ b/include/hw/pci/pci_ids.h
@@ -26,6 +26,7 @@
 #define PCI_CLASS_STORAGE_SATA           0x0106
 #define PCI_CLASS_STORAGE_SAS            0x0107
 #define PCI_CLASS_STORAGE_EXPRESS        0x0108
+#define PCI_CLASS_STORAGE_UFS            0x0109
 #define PCI_CLASS_STORAGE_OTHER          0x0180
 
 #define PCI_BASE_CLASS_NETWORK           0x02
diff --git a/meson.build b/meson.build
index a9ba0bfab3..30b2acc113 100644
--- a/meson.build
+++ b/meson.build
@@ -3278,6 +3278,7 @@ if have_system
     'hw/ssi',
     'hw/timer',
     'hw/tpm',
+    'hw/ufs',
     'hw/usb',
     'hw/vfio',
     'hw/virtio',
-- 
2.34.1


