Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB91B7EA894
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 03:10:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2iry-0001FT-Tn; Mon, 13 Nov 2023 21:09:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r2irx-0001FF-2k
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 21:09:37 -0500
Received: from mail-pg1-f175.google.com ([209.85.215.175])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r2iru-0007Yu-FY
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 21:09:36 -0500
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-5b99bfca064so3313656a12.3
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 18:09:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699927773; x=1700532573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uly2GlWW76uVdEBogdnvfJFvgrZfN8PqNdxFiox0Dc0=;
 b=VvRb4Bv9ODHaLgDfg96d2BgKdMJcXYtkn10eDOj8D6kyKKsYb07aCuFWOKA7JeqJjf
 CFZ/9JiTAER3znVET1LIRuRfi2+jf3ElNh9hRR+K8WnbXJjSa1tFFdoRfhW770pVNbZU
 xFGVwflDLkA7kNohhAGW1a/sDyItp7duOFPDNK3q/ub8zve/eruxnEkcSpCH8zYF9Ddd
 HS30vRKmK9eSNUtIoxtsyNlLPzLy1l5zlRlkOXxl9YIBzxDZ3o2hSUI0xfZCR3Jf9H9L
 tE1nxiAJWVW1S/hiX8YgXxlGDcr+gH80k1GlUTThM2V52s8B1PcHvFaB/Y9mcQO748/i
 sViA==
X-Gm-Message-State: AOJu0YzHfowTKF7PaDoLuVs7dWpv1KWlk+D4fPxkmJDtaBhxkOgQDmdg
 uQRmmVKOT1x3iDd0OjFsqxJLASoPlRk=
X-Google-Smtp-Source: AGHT+IHSrQHEyjU4xp9tpnffoAqh10LEBuab51YPih1jZYM5ZsdQhQT2qpoJRxow7f9uSi8zTU17yg==
X-Received: by 2002:a17:90b:3883:b0:280:2652:d4e with SMTP id
 mu3-20020a17090b388300b0028026520d4emr5751791pjb.29.1699927772763; 
 Mon, 13 Nov 2023 18:09:32 -0800 (PST)
Received: from localhost.localdomain ([2601:642:4c01:2f7:5d09:c219:9099:a639])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a17090ae58d00b0027d12b1e29dsm6175362pjz.25.2023.11.13.18.09.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Nov 2023 18:09:32 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Stefan Berger <stefanb@linux.ibm.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v5 01/14] tpm_crb: refactor common code
Date: Mon, 13 Nov 2023 18:09:11 -0800
Message-ID: <20231114020927.62315-2-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114020927.62315-1-j@getutm.app>
References: <20231114020927.62315-1-j@getutm.app>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.215.175; envelope-from=osy86dev@gmail.com;
 helo=mail-pg1-f175.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

In preparation for the SysBus variant, we move common code styled
after the TPM TIS devices.

To maintain compatibility, we do not rename the existing tpm-crb
device.

Signed-off-by: Joelle van Dyne <j@getutm.app>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 docs/specs/tpm.rst      |   1 +
 hw/tpm/tpm_crb.h        |  76 +++++++++++
 hw/tpm/tpm_crb.c        | 270 ++++++----------------------------------
 hw/tpm/tpm_crb_common.c | 216 ++++++++++++++++++++++++++++++++
 hw/tpm/meson.build      |   1 +
 hw/tpm/trace-events     |   2 +-
 6 files changed, 331 insertions(+), 235 deletions(-)
 create mode 100644 hw/tpm/tpm_crb.h
 create mode 100644 hw/tpm/tpm_crb_common.c

diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
index efe124a148..2bc29c9804 100644
--- a/docs/specs/tpm.rst
+++ b/docs/specs/tpm.rst
@@ -45,6 +45,7 @@ operating system.
 
 QEMU files related to TPM CRB interface:
  - ``hw/tpm/tpm_crb.c``
+ - ``hw/tpm/tpm_crb_common.c``
 
 SPAPR interface
 ---------------
diff --git a/hw/tpm/tpm_crb.h b/hw/tpm/tpm_crb.h
new file mode 100644
index 0000000000..da3a0cf256
--- /dev/null
+++ b/hw/tpm/tpm_crb.h
@@ -0,0 +1,76 @@
+/*
+ * tpm_crb.h - QEMU's TPM CRB interface emulator
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * Authors:
+ *   Marc-André Lureau <marcandre.lureau@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * tpm_crb is a device for TPM 2.0 Command Response Buffer (CRB) Interface
+ * as defined in TCG PC Client Platform TPM Profile (PTP) Specification
+ * Family “2.0” Level 00 Revision 01.03 v22
+ */
+#ifndef TPM_TPM_CRB_H
+#define TPM_TPM_CRB_H
+
+#include "exec/memory.h"
+#include "hw/acpi/tpm.h"
+#include "sysemu/tpm_backend.h"
+#include "tpm_ppi.h"
+
+#define CRB_CTRL_CMD_SIZE (TPM_CRB_ADDR_SIZE - A_CRB_DATA_BUFFER)
+
+typedef struct TPMCRBState {
+    TPMBackend *tpmbe;
+    TPMBackendCmd cmd;
+    uint32_t regs[TPM_CRB_R_MAX];
+    MemoryRegion mmio;
+    MemoryRegion cmdmem;
+
+    size_t be_buffer_size;
+
+    bool ppi_enabled;
+    TPMPPI ppi;
+} TPMCRBState;
+
+#define CRB_INTF_TYPE_CRB_ACTIVE 0b1
+#define CRB_INTF_VERSION_CRB 0b1
+#define CRB_INTF_CAP_LOCALITY_0_ONLY 0b0
+#define CRB_INTF_CAP_IDLE_FAST 0b0
+#define CRB_INTF_CAP_XFER_SIZE_64 0b11
+#define CRB_INTF_CAP_FIFO_NOT_SUPPORTED 0b0
+#define CRB_INTF_CAP_CRB_SUPPORTED 0b1
+#define CRB_INTF_IF_SELECTOR_CRB 0b1
+
+enum crb_loc_ctrl {
+    CRB_LOC_CTRL_REQUEST_ACCESS = BIT(0),
+    CRB_LOC_CTRL_RELINQUISH = BIT(1),
+    CRB_LOC_CTRL_SEIZE = BIT(2),
+    CRB_LOC_CTRL_RESET_ESTABLISHMENT_BIT = BIT(3),
+};
+
+enum crb_ctrl_req {
+    CRB_CTRL_REQ_CMD_READY = BIT(0),
+    CRB_CTRL_REQ_GO_IDLE = BIT(1),
+};
+
+enum crb_start {
+    CRB_START_INVOKE = BIT(0),
+};
+
+enum crb_cancel {
+    CRB_CANCEL_INVOKE = BIT(0),
+};
+
+#define TPM_CRB_NO_LOCALITY 0xff
+
+void tpm_crb_request_completed(TPMCRBState *s, int ret);
+enum TPMVersion tpm_crb_get_version(TPMCRBState *s);
+int tpm_crb_pre_save(TPMCRBState *s);
+void tpm_crb_reset(TPMCRBState *s, uint64_t baseaddr);
+void tpm_crb_init_memory(Object *obj, TPMCRBState *s, Error **errp);
+
+#endif /* TPM_TPM_CRB_H */
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index ea930da545..3ef4977fb5 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -31,257 +31,62 @@
 #include "tpm_ppi.h"
 #include "trace.h"
 #include "qom/object.h"
+#include "tpm_crb.h"
 
 struct CRBState {
     DeviceState parent_obj;
 
-    TPMBackend *tpmbe;
-    TPMBackendCmd cmd;
-    uint32_t regs[TPM_CRB_R_MAX];
-    MemoryRegion mmio;
-    MemoryRegion cmdmem;
-
-    size_t be_buffer_size;
-
-    bool ppi_enabled;
-    TPMPPI ppi;
+    TPMCRBState state;
 };
 typedef struct CRBState CRBState;
 
 DECLARE_INSTANCE_CHECKER(CRBState, CRB,
                          TYPE_TPM_CRB)
 
-#define CRB_INTF_TYPE_CRB_ACTIVE 0b1
-#define CRB_INTF_VERSION_CRB 0b1
-#define CRB_INTF_CAP_LOCALITY_0_ONLY 0b0
-#define CRB_INTF_CAP_IDLE_FAST 0b0
-#define CRB_INTF_CAP_XFER_SIZE_64 0b11
-#define CRB_INTF_CAP_FIFO_NOT_SUPPORTED 0b0
-#define CRB_INTF_CAP_CRB_SUPPORTED 0b1
-#define CRB_INTF_IF_SELECTOR_CRB 0b1
-
-#define CRB_CTRL_CMD_SIZE (TPM_CRB_ADDR_SIZE - A_CRB_DATA_BUFFER)
-
-enum crb_loc_ctrl {
-    CRB_LOC_CTRL_REQUEST_ACCESS = BIT(0),
-    CRB_LOC_CTRL_RELINQUISH = BIT(1),
-    CRB_LOC_CTRL_SEIZE = BIT(2),
-    CRB_LOC_CTRL_RESET_ESTABLISHMENT_BIT = BIT(3),
-};
-
-enum crb_ctrl_req {
-    CRB_CTRL_REQ_CMD_READY = BIT(0),
-    CRB_CTRL_REQ_GO_IDLE = BIT(1),
-};
-
-enum crb_start {
-    CRB_START_INVOKE = BIT(0),
-};
-
-enum crb_cancel {
-    CRB_CANCEL_INVOKE = BIT(0),
-};
-
-#define TPM_CRB_NO_LOCALITY 0xff
-
-static uint64_t tpm_crb_mmio_read(void *opaque, hwaddr addr,
-                                  unsigned size)
-{
-    CRBState *s = CRB(opaque);
-    void *regs = (void *)&s->regs + (addr & ~3);
-    unsigned offset = addr & 3;
-    uint32_t val = *(uint32_t *)regs >> (8 * offset);
-
-    switch (addr) {
-    case A_CRB_LOC_STATE:
-        val |= !tpm_backend_get_tpm_established_flag(s->tpmbe);
-        break;
-    }
-
-    trace_tpm_crb_mmio_read(addr, size, val);
-
-    return val;
-}
-
-static uint8_t tpm_crb_get_active_locty(CRBState *s)
-{
-    if (!ARRAY_FIELD_EX32(s->regs, CRB_LOC_STATE, locAssigned)) {
-        return TPM_CRB_NO_LOCALITY;
-    }
-    return ARRAY_FIELD_EX32(s->regs, CRB_LOC_STATE, activeLocality);
-}
-
-static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
-                               uint64_t val, unsigned size)
-{
-    CRBState *s = CRB(opaque);
-    uint8_t locty =  addr >> 12;
-
-    trace_tpm_crb_mmio_write(addr, size, val);
-
-    switch (addr) {
-    case A_CRB_CTRL_REQ:
-        switch (val) {
-        case CRB_CTRL_REQ_CMD_READY:
-            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
-                             tpmIdle, 0);
-            break;
-        case CRB_CTRL_REQ_GO_IDLE:
-            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
-                             tpmIdle, 1);
-            break;
-        }
-        break;
-    case A_CRB_CTRL_CANCEL:
-        if (val == CRB_CANCEL_INVOKE &&
-            s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) {
-            tpm_backend_cancel_cmd(s->tpmbe);
-        }
-        break;
-    case A_CRB_CTRL_START:
-        if (val == CRB_START_INVOKE &&
-            !(s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) &&
-            tpm_crb_get_active_locty(s) == locty) {
-            void *mem = memory_region_get_ram_ptr(&s->cmdmem);
-
-            s->regs[R_CRB_CTRL_START] |= CRB_START_INVOKE;
-            s->cmd = (TPMBackendCmd) {
-                .in = mem,
-                .in_len = MIN(tpm_cmd_get_size(mem), s->be_buffer_size),
-                .out = mem,
-                .out_len = s->be_buffer_size,
-            };
-
-            tpm_backend_deliver_request(s->tpmbe, &s->cmd);
-        }
-        break;
-    case A_CRB_LOC_CTRL:
-        switch (val) {
-        case CRB_LOC_CTRL_RESET_ESTABLISHMENT_BIT:
-            /* not loc 3 or 4 */
-            break;
-        case CRB_LOC_CTRL_RELINQUISH:
-            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
-                             locAssigned, 0);
-            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STS,
-                             Granted, 0);
-            break;
-        case CRB_LOC_CTRL_REQUEST_ACCESS:
-            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STS,
-                             Granted, 1);
-            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STS,
-                             beenSeized, 0);
-            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
-                             locAssigned, 1);
-            break;
-        }
-        break;
-    }
-}
-
-static const MemoryRegionOps tpm_crb_memory_ops = {
-    .read = tpm_crb_mmio_read,
-    .write = tpm_crb_mmio_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 4,
-    },
-};
-
-static void tpm_crb_request_completed(TPMIf *ti, int ret)
+static void tpm_crb_none_request_completed(TPMIf *ti, int ret)
 {
     CRBState *s = CRB(ti);
 
-    s->regs[R_CRB_CTRL_START] &= ~CRB_START_INVOKE;
-    if (ret != 0) {
-        ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
-                         tpmSts, 1); /* fatal error */
-    }
-    memory_region_set_dirty(&s->cmdmem, 0, CRB_CTRL_CMD_SIZE);
+    tpm_crb_request_completed(&s->state, ret);
 }
 
-static enum TPMVersion tpm_crb_get_version(TPMIf *ti)
+static enum TPMVersion tpm_crb_none_get_version(TPMIf *ti)
 {
     CRBState *s = CRB(ti);
 
-    return tpm_backend_get_tpm_version(s->tpmbe);
+    return tpm_crb_get_version(&s->state);
 }
 
-static int tpm_crb_pre_save(void *opaque)
+static int tpm_crb_none_pre_save(void *opaque)
 {
     CRBState *s = opaque;
 
-    tpm_backend_finish_sync(s->tpmbe);
-
-    return 0;
+    return tpm_crb_pre_save(&s->state);
 }
 
-static const VMStateDescription vmstate_tpm_crb = {
+static const VMStateDescription vmstate_tpm_crb_none = {
     .name = "tpm-crb",
-    .pre_save = tpm_crb_pre_save,
+    .pre_save = tpm_crb_none_pre_save,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT32_ARRAY(regs, CRBState, TPM_CRB_R_MAX),
+        VMSTATE_UINT32_ARRAY(state.regs, CRBState, TPM_CRB_R_MAX),
         VMSTATE_END_OF_LIST(),
     }
 };
 
-static Property tpm_crb_properties[] = {
-    DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
-    DEFINE_PROP_BOOL("ppi", CRBState, ppi_enabled, true),
+static Property tpm_crb_none_properties[] = {
+    DEFINE_PROP_TPMBE("tpmdev", CRBState, state.tpmbe),
+    DEFINE_PROP_BOOL("ppi", CRBState, state.ppi_enabled, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static void tpm_crb_reset(void *dev)
+static void tpm_crb_none_reset(void *dev)
 {
     CRBState *s = CRB(dev);
 
-    if (s->ppi_enabled) {
-        tpm_ppi_reset(&s->ppi);
-    }
-    tpm_backend_reset(s->tpmbe);
-
-    memset(s->regs, 0, sizeof(s->regs));
-
-    ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
-                     tpmRegValidSts, 1);
-    ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
-                     tpmIdle, 1);
-    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
-                     InterfaceType, CRB_INTF_TYPE_CRB_ACTIVE);
-    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
-                     InterfaceVersion, CRB_INTF_VERSION_CRB);
-    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
-                     CapLocality, CRB_INTF_CAP_LOCALITY_0_ONLY);
-    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
-                     CapCRBIdleBypass, CRB_INTF_CAP_IDLE_FAST);
-    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
-                     CapDataXferSizeSupport, CRB_INTF_CAP_XFER_SIZE_64);
-    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
-                     CapFIFO, CRB_INTF_CAP_FIFO_NOT_SUPPORTED);
-    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
-                     CapCRB, CRB_INTF_CAP_CRB_SUPPORTED);
-    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
-                     InterfaceSelector, CRB_INTF_IF_SELECTOR_CRB);
-    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
-                     RID, 0b0000);
-    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID2,
-                     VID, PCI_VENDOR_ID_IBM);
-
-    s->regs[R_CRB_CTRL_CMD_SIZE] = CRB_CTRL_CMD_SIZE;
-    s->regs[R_CRB_CTRL_CMD_LADDR] = TPM_CRB_ADDR_BASE + A_CRB_DATA_BUFFER;
-    s->regs[R_CRB_CTRL_RSP_SIZE] = CRB_CTRL_CMD_SIZE;
-    s->regs[R_CRB_CTRL_RSP_ADDR] = TPM_CRB_ADDR_BASE + A_CRB_DATA_BUFFER;
-
-    s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->tpmbe),
-                            CRB_CTRL_CMD_SIZE);
-
-    if (tpm_backend_startup_tpm(s->tpmbe, s->be_buffer_size) < 0) {
-        exit(1);
-    }
+    return tpm_crb_reset(&s->state, TPM_CRB_ADDR_BASE);
 }
 
-static void tpm_crb_realize(DeviceState *dev, Error **errp)
+static void tpm_crb_none_realize(DeviceState *dev, Error **errp)
 {
     CRBState *s = CRB(dev);
 
@@ -289,64 +94,61 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "at most one TPM device is permitted");
         return;
     }
-    if (!s->tpmbe) {
+    if (!s->state.tpmbe) {
         error_setg(errp, "'tpmdev' property is required");
         return;
     }
 
-    memory_region_init_io(&s->mmio, OBJECT(s), &tpm_crb_memory_ops, s,
-        "tpm-crb-mmio", sizeof(s->regs));
-    memory_region_init_ram(&s->cmdmem, OBJECT(s),
-        "tpm-crb-cmd", CRB_CTRL_CMD_SIZE, errp);
+    tpm_crb_init_memory(OBJECT(s), &s->state, errp);
 
     memory_region_add_subregion(get_system_memory(),
-        TPM_CRB_ADDR_BASE, &s->mmio);
+        TPM_CRB_ADDR_BASE, &s->state.mmio);
     memory_region_add_subregion(get_system_memory(),
-        TPM_CRB_ADDR_BASE + sizeof(s->regs), &s->cmdmem);
+        TPM_CRB_ADDR_BASE + sizeof(s->state.regs), &s->state.cmdmem);
 
-    if (s->ppi_enabled) {
-        tpm_ppi_init(&s->ppi, get_system_memory(),
+    if (s->state.ppi_enabled) {
+        tpm_ppi_init(&s->state.ppi, get_system_memory(),
                      TPM_PPI_ADDR_BASE, OBJECT(s));
     }
 
     if (xen_enabled()) {
-        tpm_crb_reset(dev);
+        tpm_crb_none_reset(dev);
     } else {
-        qemu_register_reset(tpm_crb_reset, dev);
+        qemu_register_reset(tpm_crb_none_reset, dev);
     }
 }
 
-static void tpm_crb_class_init(ObjectClass *klass, void *data)
+static void tpm_crb_none_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     TPMIfClass *tc = TPM_IF_CLASS(klass);
 
-    dc->realize = tpm_crb_realize;
-    device_class_set_props(dc, tpm_crb_properties);
-    dc->vmsd  = &vmstate_tpm_crb;
+    dc->realize = tpm_crb_none_realize;
+    device_class_set_props(dc, tpm_crb_none_properties);
+    dc->vmsd  = &vmstate_tpm_crb_none;
     dc->user_creatable = true;
     tc->model = TPM_MODEL_TPM_CRB;
-    tc->get_version = tpm_crb_get_version;
-    tc->request_completed = tpm_crb_request_completed;
+    tc->get_version = tpm_crb_none_get_version;
+    tc->request_completed = tpm_crb_none_request_completed;
 
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
-static const TypeInfo tpm_crb_info = {
+static const TypeInfo tpm_crb_none_info = {
     .name = TYPE_TPM_CRB,
     /* could be TYPE_SYS_BUS_DEVICE (or LPC etc) */
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(CRBState),
-    .class_init  = tpm_crb_class_init,
+    .class_init  = tpm_crb_none_class_init,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_TPM_IF },
         { }
     }
 };
 
-static void tpm_crb_register(void)
+static void tpm_crb_none_register(void)
 {
-    type_register_static(&tpm_crb_info);
+    type_register_static(&tpm_crb_none_info);
 }
 
-type_init(tpm_crb_register)
+type_init(tpm_crb_none_register)
diff --git a/hw/tpm/tpm_crb_common.c b/hw/tpm/tpm_crb_common.c
new file mode 100644
index 0000000000..fa463f295f
--- /dev/null
+++ b/hw/tpm/tpm_crb_common.c
@@ -0,0 +1,216 @@
+/*
+ * tpm_crb.c - QEMU's TPM CRB interface emulator
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * Authors:
+ *   Marc-André Lureau <marcandre.lureau@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * tpm_crb is a device for TPM 2.0 Command Response Buffer (CRB) Interface
+ * as defined in TCG PC Client Platform TPM Profile (PTP) Specification
+ * Family “2.0” Level 00 Revision 01.03 v22
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "exec/address-spaces.h"
+#include "hw/qdev-properties.h"
+#include "hw/pci/pci_ids.h"
+#include "hw/acpi/tpm.h"
+#include "migration/vmstate.h"
+#include "sysemu/tpm_backend.h"
+#include "sysemu/tpm_util.h"
+#include "tpm_prop.h"
+#include "tpm_ppi.h"
+#include "trace.h"
+#include "qom/object.h"
+#include "tpm_crb.h"
+
+static uint64_t tpm_crb_mmio_read(void *opaque, hwaddr addr,
+                                  unsigned size)
+{
+    TPMCRBState *s = opaque;
+    void *regs = (void *)&s->regs + (addr & ~3);
+    unsigned offset = addr & 3;
+    uint32_t val = *(uint32_t *)regs >> (8 * offset);
+
+    switch (addr) {
+    case A_CRB_LOC_STATE:
+        val |= !tpm_backend_get_tpm_established_flag(s->tpmbe);
+        break;
+    }
+
+    trace_tpm_crb_mmio_read(addr, size, val);
+
+    return val;
+}
+
+static uint8_t tpm_crb_get_active_locty(TPMCRBState *s)
+{
+    if (!ARRAY_FIELD_EX32(s->regs, CRB_LOC_STATE, locAssigned)) {
+        return TPM_CRB_NO_LOCALITY;
+    }
+    return ARRAY_FIELD_EX32(s->regs, CRB_LOC_STATE, activeLocality);
+}
+
+static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
+                               uint64_t val, unsigned size)
+{
+    TPMCRBState *s = opaque;
+    uint8_t locty =  addr >> 12;
+
+    trace_tpm_crb_mmio_write(addr, size, val);
+
+    switch (addr) {
+    case A_CRB_CTRL_REQ:
+        switch (val) {
+        case CRB_CTRL_REQ_CMD_READY:
+            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
+                             tpmIdle, 0);
+            break;
+        case CRB_CTRL_REQ_GO_IDLE:
+            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
+                             tpmIdle, 1);
+            break;
+        }
+        break;
+    case A_CRB_CTRL_CANCEL:
+        if (val == CRB_CANCEL_INVOKE &&
+            s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) {
+            tpm_backend_cancel_cmd(s->tpmbe);
+        }
+        break;
+    case A_CRB_CTRL_START:
+        if (val == CRB_START_INVOKE &&
+            !(s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) &&
+            tpm_crb_get_active_locty(s) == locty) {
+            void *mem = memory_region_get_ram_ptr(&s->cmdmem);
+
+            s->regs[R_CRB_CTRL_START] |= CRB_START_INVOKE;
+            s->cmd = (TPMBackendCmd) {
+                .in = mem,
+                .in_len = MIN(tpm_cmd_get_size(mem), s->be_buffer_size),
+                .out = mem,
+                .out_len = s->be_buffer_size,
+            };
+
+            tpm_backend_deliver_request(s->tpmbe, &s->cmd);
+        }
+        break;
+    case A_CRB_LOC_CTRL:
+        switch (val) {
+        case CRB_LOC_CTRL_RESET_ESTABLISHMENT_BIT:
+            /* not loc 3 or 4 */
+            break;
+        case CRB_LOC_CTRL_RELINQUISH:
+            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
+                             locAssigned, 0);
+            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STS,
+                             Granted, 0);
+            break;
+        case CRB_LOC_CTRL_REQUEST_ACCESS:
+            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STS,
+                             Granted, 1);
+            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STS,
+                             beenSeized, 0);
+            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
+                             locAssigned, 1);
+            break;
+        }
+        break;
+    }
+}
+
+const MemoryRegionOps tpm_crb_memory_ops = {
+    .read = tpm_crb_mmio_read,
+    .write = tpm_crb_mmio_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+void tpm_crb_request_completed(TPMCRBState *s, int ret)
+{
+    s->regs[R_CRB_CTRL_START] &= ~CRB_START_INVOKE;
+    if (ret != 0) {
+        ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
+                         tpmSts, 1); /* fatal error */
+    }
+    memory_region_set_dirty(&s->cmdmem, 0, CRB_CTRL_CMD_SIZE);
+}
+
+enum TPMVersion tpm_crb_get_version(TPMCRBState *s)
+{
+    return tpm_backend_get_tpm_version(s->tpmbe);
+}
+
+int tpm_crb_pre_save(TPMCRBState *s)
+{
+    tpm_backend_finish_sync(s->tpmbe);
+
+    return 0;
+}
+
+void tpm_crb_reset(TPMCRBState *s, uint64_t baseaddr)
+{
+    if (s->ppi_enabled) {
+        tpm_ppi_reset(&s->ppi);
+    }
+    tpm_backend_reset(s->tpmbe);
+
+    memset(s->regs, 0, sizeof(s->regs));
+
+    ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
+                     tpmRegValidSts, 1);
+    ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
+                     tpmIdle, 1);
+    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+                     InterfaceType, CRB_INTF_TYPE_CRB_ACTIVE);
+    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+                     InterfaceVersion, CRB_INTF_VERSION_CRB);
+    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+                     CapLocality, CRB_INTF_CAP_LOCALITY_0_ONLY);
+    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+                     CapCRBIdleBypass, CRB_INTF_CAP_IDLE_FAST);
+    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+                     CapDataXferSizeSupport, CRB_INTF_CAP_XFER_SIZE_64);
+    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+                     CapFIFO, CRB_INTF_CAP_FIFO_NOT_SUPPORTED);
+    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+                     CapCRB, CRB_INTF_CAP_CRB_SUPPORTED);
+    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+                     InterfaceSelector, CRB_INTF_IF_SELECTOR_CRB);
+    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+                     RID, 0b0000);
+    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID2,
+                     VID, PCI_VENDOR_ID_IBM);
+
+    baseaddr += A_CRB_DATA_BUFFER;
+    s->regs[R_CRB_CTRL_CMD_SIZE] = CRB_CTRL_CMD_SIZE;
+    s->regs[R_CRB_CTRL_CMD_LADDR] = (uint32_t)baseaddr;
+    s->regs[R_CRB_CTRL_CMD_HADDR] = (uint32_t)(baseaddr >> 32);
+    s->regs[R_CRB_CTRL_RSP_SIZE] = CRB_CTRL_CMD_SIZE;
+    s->regs[R_CRB_CTRL_RSP_ADDR] = (uint32_t)baseaddr;
+
+    s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->tpmbe),
+                            CRB_CTRL_CMD_SIZE);
+
+    if (tpm_backend_startup_tpm(s->tpmbe, s->be_buffer_size) < 0) {
+        exit(1);
+    }
+}
+
+void tpm_crb_init_memory(Object *obj, TPMCRBState *s, Error **errp)
+{
+    memory_region_init_io(&s->mmio, obj, &tpm_crb_memory_ops, s,
+        "tpm-crb-mmio", sizeof(s->regs));
+    memory_region_init_ram(&s->cmdmem, obj,
+        "tpm-crb-cmd", CRB_CTRL_CMD_SIZE, errp);
+}
diff --git a/hw/tpm/meson.build b/hw/tpm/meson.build
index 6968e60b3f..cb8204d5bc 100644
--- a/hw/tpm/meson.build
+++ b/hw/tpm/meson.build
@@ -3,6 +3,7 @@ system_ss.add(when: 'CONFIG_TPM_TIS_ISA', if_true: files('tpm_tis_isa.c'))
 system_ss.add(when: 'CONFIG_TPM_TIS_SYSBUS', if_true: files('tpm_tis_sysbus.c'))
 system_ss.add(when: 'CONFIG_TPM_TIS_I2C', if_true: files('tpm_tis_i2c.c'))
 system_ss.add(when: 'CONFIG_TPM_CRB', if_true: files('tpm_crb.c'))
+system_ss.add(when: 'CONFIG_TPM_CRB', if_true: files('tpm_crb_common.c'))
 system_ss.add(when: 'CONFIG_TPM_TIS', if_true: files('tpm_ppi.c'))
 system_ss.add(when: 'CONFIG_TPM_CRB', if_true: files('tpm_ppi.c'))
 
diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
index fa882dfefe..3ab1bdb97b 100644
--- a/hw/tpm/trace-events
+++ b/hw/tpm/trace-events
@@ -1,6 +1,6 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
-# tpm_crb.c
+# tpm_crb_common.c
 tpm_crb_mmio_read(uint64_t addr, unsigned size, uint32_t val) "CRB read 0x%016" PRIx64 " len:%u val: 0x%" PRIx32
 tpm_crb_mmio_write(uint64_t addr, unsigned size, uint32_t val) "CRB write 0x%016" PRIx64 " len:%u val: 0x%" PRIx32
 
-- 
2.41.0


