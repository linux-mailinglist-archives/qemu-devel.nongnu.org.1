Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6837B07DD
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 17:13:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlWD3-0003Aw-Ar; Wed, 27 Sep 2023 11:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlWD1-00036s-3W
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:12:15 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlWCw-0005kO-8v
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:12:14 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-405417465aaso105017555e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 08:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695827528; x=1696432328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=knOoQHNBrJNNAq0xZUah/ix3dH4MX2Wi/EWus+SFSVQ=;
 b=m0LyF9FBU5PCxxsHO2896MbdkN54Sxar7/ZSeJ59SkKk8EeoeFvWfeyonEgmXlMjFl
 HwjnixJts0ICl+JyJhj9fky4uOwOlJsd61r/KE/ACJvjM3hN1VT4pzpokqyiXLIY3aZZ
 1DhKjp3Ku04VgbP3ZPAG1fUmd7ug6SdB4JbvJ9KQoTis/X3D2SJMv0bJ2mB+UkuWyR03
 a/5n6l0fu6U310PPKnm2ZgV+VFkdZdj4nYcCJlYEX7wotMzzexn7nvX/zRBSER6yURQR
 GAHe76Bq1uV4RaUDnmzLDLzE0L8WunOunj2g9B51j1pSChuWMQ/tjjZcehq3XRFz7us9
 R8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695827528; x=1696432328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=knOoQHNBrJNNAq0xZUah/ix3dH4MX2Wi/EWus+SFSVQ=;
 b=nwjPDBffOTcz6EBfeIORNbOs0/25zX1qtIQjUWfcOtY9MskZXlbF800VqHp68A+K1K
 VZ3D6EqfNs2wbtQN70cdNQdQfvE+Ej8Ob3M4zMF1fMcJ6EIzLh21zdQAM/tL2uHB+1I/
 eLnHV0lwNMSDVNbdwIaUloMsFIdwVaN4kmW4FB2qqzZS4qsOLdYYD14V+/Kafl77hn0A
 Fg+nAPDQCu5S9jvcnzzXBDW3q2KtwxUKJ6mhazKJjvYHXGVqKwONYm585pqOpV0Hc6U8
 zBZr9RDaORsZW3vgpWQAxDyo0S8s1NReod1Z7f+wZaN3ogEkeHZU2Jp3GFwyZcDwWhjU
 t3rA==
X-Gm-Message-State: AOJu0Yy0v3YveOjqswtjcnNgQxfup2MGwvnOC/NfM0eofI4MswHCk+W9
 9RL340bsNMn1/gaUW0boNxqb0nTPXOUkq0q1sLw=
X-Google-Smtp-Source: AGHT+IFpvjJxXTWc1I5E3PcfcEbxFFKB5S9r+a3Kc4XhhZAqfnAw0Bk1WmYYL/5PwOgSc3nTjmsnZw==
X-Received: by 2002:a05:600c:22d4:b0:401:c436:8999 with SMTP id
 20-20020a05600c22d400b00401c4368999mr2224602wmg.30.1695827527772; 
 Wed, 27 Sep 2023 08:12:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a1c7209000000b00401bbfb9b2bsm467474wmc.0.2023.09.27.08.12.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 08:12:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/8] docs/specs/vmw_pvscsi-spec: Convert to rST
Date: Wed, 27 Sep 2023 16:11:58 +0100
Message-Id: <20230927151205.70930-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927151205.70930-1-peter.maydell@linaro.org>
References: <20230927151205.70930-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Convert the docs/specs/vmw_pvscsi-spec.txt file to rST format.
This conversion includes some minor wordsmithing of the text
to fix some grammar nits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
The number of lines changed for markup formatting was
such a large amount of the document that it didn't seem
worth breaking out the wording tweaks separately...
---
 MAINTAINERS                    |   1 +
 docs/specs/index.rst           |   1 +
 docs/specs/vmw_pvscsi-spec.rst | 115 +++++++++++++++++++++++++++++++++
 docs/specs/vmw_pvscsi-spec.txt |  92 --------------------------
 4 files changed, 117 insertions(+), 92 deletions(-)
 create mode 100644 docs/specs/vmw_pvscsi-spec.rst
 delete mode 100644 docs/specs/vmw_pvscsi-spec.txt

diff --git a/MAINTAINERS b/MAINTAINERS
index 355b1960ce4..e0e23907871 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2283,6 +2283,7 @@ S: Maintained
 F: hw/net/vmxnet*
 F: hw/scsi/vmw_pvscsi*
 F: tests/qtest/vmxnet3-test.c
+F: docs/specs/vwm_pvscsi-spec.rst
 
 Rocker
 M: Jiri Pirko <jiri@resnulli.us>
diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index e58be38c41c..d23efbe2480 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -24,3 +24,4 @@ guest hardware that is specific to QEMU.
    acpi_erst
    sev-guest-firmware
    fw_cfg
+   vmw_pvscsi-spec
diff --git a/docs/specs/vmw_pvscsi-spec.rst b/docs/specs/vmw_pvscsi-spec.rst
new file mode 100644
index 00000000000..b6f434a4187
--- /dev/null
+++ b/docs/specs/vmw_pvscsi-spec.rst
@@ -0,0 +1,115 @@
+==============================
+VMWare PVSCSI Device Interface
+==============================
+
+..
+   Created by Dmitry Fleytman (dmitry@daynix.com), Daynix Computing LTD.
+
+This document describes the VMWare PVSCSI device interface specification,
+based on the source code of the PVSCSI Linux driver from kernel 3.0.4.
+
+Overview
+========
+
+The interface is based on a memory area shared between hypervisor and VM.
+The memory area is obtained by driver as a device IO memory resource of
+``PVSCSI_MEM_SPACE_SIZE`` length.
+The shared memory consists of a registers area and a rings area.
+The registers area is used to raise hypervisor interrupts and issue device
+commands. The rings area is used to transfer data descriptors and SCSI
+commands from VM to hypervisor and to transfer messages produced by
+hypervisor to VM. Data itself is transferred via virtual scatter-gather DMA.
+
+PVSCSI Device Registers
+=======================
+
+The length of the registers area is 1 page
+(``PVSCSI_MEM_SPACE_COMMAND_NUM_PAGES``).  The structure of the
+registers area is described by the ``PVSCSIRegOffset`` enum.  There
+are registers to issue device commands (with optional short data),
+issue device interrupts, and control interrupt masking.
+
+PVSCSI Device Rings
+===================
+
+There are three rings in shared memory:
+
+Request ring (``struct PVSCSIRingReqDesc *req_ring``)
+    ring for OS to device requests
+
+Completion ring (``struct PVSCSIRingCmpDesc *cmp_ring``)
+    ring for device request completions
+
+Message ring (``struct PVSCSIRingMsgDesc *msg_ring``)
+    ring for messages from device. This ring is optional and the
+    guest might not configure it.
+
+There is a control area (``struct PVSCSIRingsState *rings_state``)
+used to control rings operation.
+
+PVSCSI Device to Host Interrupts
+================================
+
+The following interrupt types are supported by the PVSCSI device:
+
+Completion interrupts (completion ring notifications):
+
+- ``PVSCSI_INTR_CMPL_0``
+- ``PVSCSI_INTR_CMPL_1``
+
+Message interrupts (message ring notifications):
+
+- ``PVSCSI_INTR_MSG_0``
+- ``PVSCSI_INTR_MSG_1``
+
+Interrupts are controlled via the ``PVSCSI_REG_OFFSET_INTR_MASK``
+register.  If a bit is set it means the interrupt is enabled, and if
+it is clear then the interrupt is disabled.
+
+The interrupt modes supported are legacy, MSI and MSI-X.
+In the case of legacy interrupts, the ``PVSCSI_REG_OFFSET_INTR_STATUS``
+register is used to check which interrupt has arrived.  Interrupts are
+acknowledged when the corresponding bit is written to the interrupt
+status register.
+
+PVSCSI Device Operation Sequences
+=================================
+
+Startup sequence
+----------------
+
+a. Issue ``PVSCSI_CMD_ADAPTER_RESET`` command
+b. Windows driver reads interrupt status register here
+c. Issue ``PVSCSI_CMD_SETUP_MSG_RING`` command with no additional data,
+   check status and disable device messages if error returned
+   (Omitted if device messages disabled by driver configuration)
+d. Issue ``PVSCSI_CMD_SETUP_RINGS`` command, provide rings configuration
+   as ``struct PVSCSICmdDescSetupRings``
+e. Issue ``PVSCSI_CMD_SETUP_MSG_RING`` command again, provide
+   rings configuration as ``struct PVSCSICmdDescSetupMsgRing``
+f. Unmask completion and message (if device messages enabled) interrupts
+
+Shutdown sequence
+-----------------
+
+a. Mask interrupts
+b. Flush request ring using ``PVSCSI_REG_OFFSET_KICK_NON_RW_IO``
+c. Issue ``PVSCSI_CMD_ADAPTER_RESET`` command
+
+Send request
+------------
+
+a. Fill next free request ring descriptor
+b. Issue ``PVSCSI_REG_OFFSET_KICK_RW_IO`` for R/W operations
+   or ``PVSCSI_REG_OFFSET_KICK_NON_RW_IO`` for other operations
+
+Abort command
+-------------
+
+a. Issue ``PVSCSI_CMD_ABORT_CMD`` command
+
+Request completion processing
+-----------------------------
+
+a. Upon completion interrupt arrival process completion
+   and message (if enabled) rings
diff --git a/docs/specs/vmw_pvscsi-spec.txt b/docs/specs/vmw_pvscsi-spec.txt
deleted file mode 100644
index 49affb2a423..00000000000
--- a/docs/specs/vmw_pvscsi-spec.txt
+++ /dev/null
@@ -1,92 +0,0 @@
-General Description
-===================
-
-This document describes VMWare PVSCSI device interface specification.
-Created by Dmitry Fleytman (dmitry@daynix.com), Daynix Computing LTD.
-Based on source code of PVSCSI Linux driver from kernel 3.0.4
-
-PVSCSI Device Interface Overview
-================================
-
-The interface is based on memory area shared between hypervisor and VM.
-Memory area is obtained by driver as device IO memory resource of
-PVSCSI_MEM_SPACE_SIZE length.
-The shared memory consists of registers area and rings area.
-The registers area is used to raise hypervisor interrupts and issue device
-commands. The rings area is used to transfer data descriptors and SCSI
-commands from VM to hypervisor and to transfer messages produced by
-hypervisor to VM. Data itself is transferred via virtual scatter-gather DMA.
-
-PVSCSI Device Registers
-=======================
-
-The length of the registers area is 1 page (PVSCSI_MEM_SPACE_COMMAND_NUM_PAGES).
-The structure of the registers area is described by the PVSCSIRegOffset enum.
-There are registers to issue device command (with optional short data),
-issue device interrupt, control interrupts masking.
-
-PVSCSI Device Rings
-===================
-
-There are three rings in shared memory:
-
-    1. Request ring (struct PVSCSIRingReqDesc *req_ring)
-        - ring for OS to device requests
-    2. Completion ring (struct PVSCSIRingCmpDesc *cmp_ring)
-        - ring for device request completions
-    3. Message ring (struct PVSCSIRingMsgDesc *msg_ring)
-        - ring for messages from device.
-       This ring is optional and the guest might not configure it.
-There is a control area (struct PVSCSIRingsState *rings_state) used to control
-rings operation.
-
-PVSCSI Device to Host Interrupts
-================================
-There are following interrupt types supported by PVSCSI device:
-    1. Completion interrupts (completion ring notifications):
-        PVSCSI_INTR_CMPL_0
-        PVSCSI_INTR_CMPL_1
-    2. Message interrupts (message ring notifications):
-        PVSCSI_INTR_MSG_0
-        PVSCSI_INTR_MSG_1
-
-Interrupts are controlled via PVSCSI_REG_OFFSET_INTR_MASK register
-Bit set means interrupt enabled, bit cleared - disabled
-
-Interrupt modes supported are legacy, MSI and MSI-X
-In case of legacy interrupts, register PVSCSI_REG_OFFSET_INTR_STATUS
-is used to check which interrupt has arrived.  Interrupts are
-acknowledged when the corresponding bit is written to the interrupt
-status register.
-
-PVSCSI Device Operation Sequences
-=================================
-
-1. Startup sequence:
-    a. Issue PVSCSI_CMD_ADAPTER_RESET command;
-    aa. Windows driver reads interrupt status register here;
-    b. Issue PVSCSI_CMD_SETUP_MSG_RING command with no additional data,
-       check status and disable device messages if error returned;
-       (Omitted if device messages disabled by driver configuration)
-    c. Issue PVSCSI_CMD_SETUP_RINGS command, provide rings configuration
-       as struct PVSCSICmdDescSetupRings;
-    d. Issue PVSCSI_CMD_SETUP_MSG_RING command again, provide
-       rings configuration as struct PVSCSICmdDescSetupMsgRing;
-    e. Unmask completion and message (if device messages enabled) interrupts.
-
-2. Shutdown sequences
-    a. Mask interrupts;
-    b. Flush request ring using PVSCSI_REG_OFFSET_KICK_NON_RW_IO;
-    c. Issue PVSCSI_CMD_ADAPTER_RESET command.
-
-3. Send request
-    a. Fill next free request ring descriptor;
-    b. Issue PVSCSI_REG_OFFSET_KICK_RW_IO for R/W operations;
-       or PVSCSI_REG_OFFSET_KICK_NON_RW_IO for other operations.
-
-4. Abort command
-    a. Issue PVSCSI_CMD_ABORT_CMD command;
-
-5. Request completion processing
-    a. Upon completion interrupt arrival process completion
-       and message (if enabled) rings.
-- 
2.34.1


