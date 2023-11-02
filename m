Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7F07DF8F3
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:41:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybet-0003NB-IB; Thu, 02 Nov 2023 13:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybea-0003CO-85
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:48 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeU-0002iE-TX
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:47 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40838915cecso8911325e9.2
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946721; x=1699551521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SskojryoeBaNET044RrLqzmul/SzDPe7Qrix3P3iV6A=;
 b=Lbw99UXgBzx1zpvzWitOWqHZJjOmtArgBnQ2+bkllEYdrCEF3xFxtC2TvZ66iS8LXs
 TRQLPztT1eYq8NpnbCQ2wH65d8tgjeISOXzWPwpfaWU6rDUtH+XVAAjCqTz5XrGGfJvD
 Wcrh1jIyyGUcOnxyIBSiB8654x/M28x1lQHQZIkdZTz7oG70zBBGJ0LmUFb3Z8ZKbjLg
 dZxgU1fbYWI5C1fDgnD+PPTWGe6Tzc+s4Hkss1b98NCco3oAUmeuAx33lIixG3ngjpt6
 vWMFbA2GoLSVCB1j/XI3b/BRd8JmgYA+LmvxaHSeFlj7sPyDuDtSCGPZjkp2tsOZFryT
 74Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946721; x=1699551521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SskojryoeBaNET044RrLqzmul/SzDPe7Qrix3P3iV6A=;
 b=YzsTIh2L5wZDOnHlzItfC+Oo11S2wArJZUhYN/USL/Wr8P0Dfuu0GOv5DAWHKDCqOM
 IfW832mZERTrO8z+swcMTOhXErMo+0+tv5xrN+Xh4IiEWReq43KosQ7vm9E818piDJHT
 xoFgq4ckZWzQt5HSyk/NVaJBetRAClxAFyJidgdWeKffSdNvcD8boeXhGJavrhq57Ok6
 f69VdwrrgCF31VNHUbEQY+Y+e0Gmmt8/7n5HB9hN38jfIAGorRvnpg0eFj1Zx7a4Nb4E
 /EyoP11i75CSgFcmGzQE9wigUlpijbhcATuubOWlzeD4pVpkG50pGDC4pbuQibgSLkq8
 oa2A==
X-Gm-Message-State: AOJu0YxTydS8QljPGNK8q59pqeg/XZRY4HDvtA3shu9TSpF8ARUUz5vX
 TMNi6l7WSmwdm0Vx2eUFPQ5e9UVZ9tNcnBM8/zE=
X-Google-Smtp-Source: AGHT+IGtAXTiO4wS30k67dFUqasx8CGp7uxI+7zmzOgtCpIJTb1K7mMszC0W997h+8XjNtDL32kvQg==
X-Received: by 2002:a05:600c:5250:b0:409:5a92:4718 with SMTP id
 fc16-20020a05600c525000b004095a924718mr4542905wmb.36.1698946721228; 
 Thu, 02 Nov 2023 10:38:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/33] docs/specs/vmw_pvscsi-spec: Convert to rST
Date: Thu,  2 Nov 2023 17:38:10 +0000
Message-Id: <20231102173835.609985-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Convert the docs/specs/vmw_pvscsi-spec.txt file to rST format.
This conversion includes some minor wordsmithing of the text
to fix some grammar nits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20230927151205.70930-2-peter.maydell@linaro.org
---
 MAINTAINERS                    |   1 +
 docs/specs/index.rst           |   1 +
 docs/specs/vmw_pvscsi-spec.rst | 115 +++++++++++++++++++++++++++++++++
 docs/specs/vmw_pvscsi-spec.txt |  92 --------------------------
 4 files changed, 117 insertions(+), 92 deletions(-)
 create mode 100644 docs/specs/vmw_pvscsi-spec.rst
 delete mode 100644 docs/specs/vmw_pvscsi-spec.txt

diff --git a/MAINTAINERS b/MAINTAINERS
index 018ed62560f..73ec940bea0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2350,6 +2350,7 @@ S: Maintained
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


