Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9A37516F8
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 05:55:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJnOE-0005S6-74; Wed, 12 Jul 2023 23:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qJnNx-0005OQ-QT
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 23:52:57 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qJnNn-0004bs-0A
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 23:52:57 -0400
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so310786a12.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 20:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689220365; x=1691812365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dVodZWmPbd6tvIYq9Kte/pt60hXgGEfBbR021G78AAE=;
 b=Pqk9x83lNdR2M1UorKH40SN05FDkRtpS/7LjmMHdZqDJlgB30tCNjWtNLu0uTMLuB1
 pgMKXIfas+5awP9MFMT4cB4/xCHBeUFLYslye9op3sWj6eQwZxTfXMIfmK2wrf1Mw25d
 f+e4WtU2VTSetoWuojcKg46fU/E+jAvVEBhs3UfNaW/c+3NH4I9AeOffwOjdH8hNwLyY
 ggpH7iWn99z4eG1NjN21jJbbZUiagGa9AQfYStvYVWP81GGNqrazhSo+zJ2Rwpq01+W3
 LwRpNr56vY8VFVyPM9wpKN3l3vthtEFjRd/wsi0OScqKExzJRePZNJQdKoj6XwbOFqfQ
 uPag==
X-Gm-Message-State: ABy/qLYNKdZi6w98Gdfo09MuJwRUMVJIgF2adsw4K0Rl+Or2qxWep+3c
 tsaxreEmlg/YurasmG2vnDdt0/9zvkjTBw==
X-Google-Smtp-Source: APBJJlG430oyfYTS4voRI94z2VwNyww8xdqgVN8hMpnGKi3/xy7g1Xec9Nzd0vEIkyhCBBuPD0vIIA==
X-Received: by 2002:a17:902:da8b:b0:1b8:6a47:705f with SMTP id
 j11-20020a170902da8b00b001b86a47705fmr527086plx.69.1689220365393; 
 Wed, 12 Jul 2023 20:52:45 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:8b82:587c:b800:84d:31b7:313d])
 by smtp.gmail.com with ESMTPSA id
 x6-20020a1709027c0600b001b8a37ffb5asm4756199pll.4.2023.07.12.20.52.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Jul 2023 20:52:45 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 04/11] tpm_crb: use a single read-as-mem/write-as-mmio mapping
Date: Wed, 12 Jul 2023 20:51:09 -0700
Message-ID: <20230713035232.48406-5-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713035232.48406-1-j@getutm.app>
References: <20230713035232.48406-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.215.180; envelope-from=osy86dev@gmail.com;
 helo=mail-pg1-f180.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Apple Silicon, when Windows performs a LDP on the CRB MMIO space,
the exception is not decoded by hardware and we cannot trap the MMIO
read. This led to the idea from @agraf to use the same mapping type as
ROM devices: namely that reads should be seen as memory type and
writes should trap as MMIO.

Once that was done, the second memory mapping of the command buffer
region was redundent and was removed.

A note about the removal of the read trap for `CRB_LOC_STATE`:
The only usage was to return the most up-to-date value for
`tpmEstablished`. However, `tpmEstablished` is only set when a
TPM2_HashStart operation is called which only exists for locality 4.
Indeed, the comment for the write handler of `CRB_LOC_CTRL` makes the
same argument for why it is not calling the backend to reset the
`tpmEstablished` bit. As this bit is unused, we do not need to worry
about updating it for reads.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 hw/tpm/tpm_crb.h        |   2 -
 hw/tpm/tpm_crb.c        |   3 -
 hw/tpm/tpm_crb_common.c | 124 ++++++++++++++++++++--------------------
 3 files changed, 63 insertions(+), 66 deletions(-)

diff --git a/hw/tpm/tpm_crb.h b/hw/tpm/tpm_crb.h
index da3a0cf256..7cdd37335f 100644
--- a/hw/tpm/tpm_crb.h
+++ b/hw/tpm/tpm_crb.h
@@ -26,9 +26,7 @@
 typedef struct TPMCRBState {
     TPMBackend *tpmbe;
     TPMBackendCmd cmd;
-    uint32_t regs[TPM_CRB_R_MAX];
     MemoryRegion mmio;
-    MemoryRegion cmdmem;
 
     size_t be_buffer_size;
 
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 598c3e0161..07c6868d8d 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -68,7 +68,6 @@ static const VMStateDescription vmstate_tpm_crb_none = {
     .name = "tpm-crb",
     .pre_save = tpm_crb_none_pre_save,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT32_ARRAY(state.regs, CRBState, TPM_CRB_R_MAX),
         VMSTATE_END_OF_LIST(),
     }
 };
@@ -103,8 +102,6 @@ static void tpm_crb_none_realize(DeviceState *dev, Error **errp)
 
     memory_region_add_subregion(get_system_memory(),
         TPM_CRB_ADDR_BASE, &s->state.mmio);
-    memory_region_add_subregion(get_system_memory(),
-        TPM_CRB_ADDR_BASE + sizeof(s->state.regs), &s->state.cmdmem);
 
     if (s->state.ppi_enabled) {
         memory_region_add_subregion(get_system_memory(),
diff --git a/hw/tpm/tpm_crb_common.c b/hw/tpm/tpm_crb_common.c
index e56e910670..f3e40095e3 100644
--- a/hw/tpm/tpm_crb_common.c
+++ b/hw/tpm/tpm_crb_common.c
@@ -33,31 +33,12 @@
 #include "qom/object.h"
 #include "tpm_crb.h"
 
-static uint64_t tpm_crb_mmio_read(void *opaque, hwaddr addr,
-                                  unsigned size)
+static uint8_t tpm_crb_get_active_locty(TPMCRBState *s, uint32_t *regs)
 {
-    TPMCRBState *s = opaque;
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
-static uint8_t tpm_crb_get_active_locty(TPMCRBState *s)
-{
-    if (!ARRAY_FIELD_EX32(s->regs, CRB_LOC_STATE, locAssigned)) {
+    if (!ARRAY_FIELD_EX32(regs, CRB_LOC_STATE, locAssigned)) {
         return TPM_CRB_NO_LOCALITY;
     }
-    return ARRAY_FIELD_EX32(s->regs, CRB_LOC_STATE, activeLocality);
+    return ARRAY_FIELD_EX32(regs, CRB_LOC_STATE, activeLocality);
 }
 
 static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
@@ -65,35 +46,47 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
 {
     TPMCRBState *s = opaque;
     uint8_t locty =  addr >> 12;
+    uint32_t *regs;
+    void *mem;
 
     trace_tpm_crb_mmio_write(addr, size, val);
+    regs = memory_region_get_ram_ptr(&s->mmio);
+    mem = &regs[R_CRB_DATA_BUFFER];
+    assert(regs);
+
+    if (addr >= A_CRB_DATA_BUFFER) {
+        assert(addr + size <= TPM_CRB_ADDR_SIZE);
+        assert(size <= sizeof(val));
+        memcpy(mem + addr - A_CRB_DATA_BUFFER, &val, size);
+        memory_region_set_dirty(&s->mmio, addr, size);
+        return;
+    }
 
     switch (addr) {
     case A_CRB_CTRL_REQ:
         switch (val) {
         case CRB_CTRL_REQ_CMD_READY:
-            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
+            ARRAY_FIELD_DP32(regs, CRB_CTRL_STS,
                              tpmIdle, 0);
             break;
         case CRB_CTRL_REQ_GO_IDLE:
-            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
+            ARRAY_FIELD_DP32(regs, CRB_CTRL_STS,
                              tpmIdle, 1);
             break;
         }
         break;
     case A_CRB_CTRL_CANCEL:
         if (val == CRB_CANCEL_INVOKE &&
-            s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) {
+            regs[R_CRB_CTRL_START] & CRB_START_INVOKE) {
             tpm_backend_cancel_cmd(s->tpmbe);
         }
         break;
     case A_CRB_CTRL_START:
         if (val == CRB_START_INVOKE &&
-            !(s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) &&
-            tpm_crb_get_active_locty(s) == locty) {
-            void *mem = memory_region_get_ram_ptr(&s->cmdmem);
+            !(regs[R_CRB_CTRL_START] & CRB_START_INVOKE) &&
+            tpm_crb_get_active_locty(s, regs) == locty) {
 
-            s->regs[R_CRB_CTRL_START] |= CRB_START_INVOKE;
+            regs[R_CRB_CTRL_START] |= CRB_START_INVOKE;
             s->cmd = (TPMBackendCmd) {
                 .in = mem,
                 .in_len = MIN(tpm_cmd_get_size(mem), s->be_buffer_size),
@@ -110,26 +103,27 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
             /* not loc 3 or 4 */
             break;
         case CRB_LOC_CTRL_RELINQUISH:
-            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
+            ARRAY_FIELD_DP32(regs, CRB_LOC_STATE,
                              locAssigned, 0);
-            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STS,
+            ARRAY_FIELD_DP32(regs, CRB_LOC_STS,
                              Granted, 0);
             break;
         case CRB_LOC_CTRL_REQUEST_ACCESS:
-            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STS,
+            ARRAY_FIELD_DP32(regs, CRB_LOC_STS,
                              Granted, 1);
-            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STS,
+            ARRAY_FIELD_DP32(regs, CRB_LOC_STS,
                              beenSeized, 0);
-            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
+            ARRAY_FIELD_DP32(regs, CRB_LOC_STATE,
                              locAssigned, 1);
             break;
         }
         break;
     }
+
+    memory_region_set_dirty(&s->mmio, 0, A_CRB_DATA_BUFFER);
 }
 
 const MemoryRegionOps tpm_crb_memory_ops = {
-    .read = tpm_crb_mmio_read,
     .write = tpm_crb_mmio_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
@@ -140,12 +134,16 @@ const MemoryRegionOps tpm_crb_memory_ops = {
 
 void tpm_crb_request_completed(TPMCRBState *s, int ret)
 {
-    s->regs[R_CRB_CTRL_START] &= ~CRB_START_INVOKE;
+    uint32_t *regs = memory_region_get_ram_ptr(&s->mmio);
+
+    assert(regs);
+    regs[R_CRB_CTRL_START] &= ~CRB_START_INVOKE;
     if (ret != 0) {
-        ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
+        ARRAY_FIELD_DP32(regs, CRB_CTRL_STS,
                          tpmSts, 1); /* fatal error */
     }
-    memory_region_set_dirty(&s->cmdmem, 0, CRB_CTRL_CMD_SIZE);
+
+    memory_region_set_dirty(&s->mmio, 0, TPM_CRB_ADDR_SIZE);
 }
 
 enum TPMVersion tpm_crb_get_version(TPMCRBState *s)
@@ -162,45 +160,48 @@ int tpm_crb_pre_save(TPMCRBState *s)
 
 void tpm_crb_reset(TPMCRBState *s, uint64_t baseaddr)
 {
+    uint32_t *regs = memory_region_get_ram_ptr(&s->mmio);
+
+    assert(regs);
     if (s->ppi_enabled) {
         tpm_ppi_reset(&s->ppi);
     }
     tpm_backend_reset(s->tpmbe);
 
-    memset(s->regs, 0, sizeof(s->regs));
+    memset(regs, 0, TPM_CRB_ADDR_SIZE);
 
-    ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
+    ARRAY_FIELD_DP32(regs, CRB_LOC_STATE,
                      tpmRegValidSts, 1);
-    ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
+    ARRAY_FIELD_DP32(regs, CRB_CTRL_STS,
                      tpmIdle, 1);
-    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+    ARRAY_FIELD_DP32(regs, CRB_INTF_ID,
                      InterfaceType, CRB_INTF_TYPE_CRB_ACTIVE);
-    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+    ARRAY_FIELD_DP32(regs, CRB_INTF_ID,
                      InterfaceVersion, CRB_INTF_VERSION_CRB);
-    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+    ARRAY_FIELD_DP32(regs, CRB_INTF_ID,
                      CapLocality, CRB_INTF_CAP_LOCALITY_0_ONLY);
-    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+    ARRAY_FIELD_DP32(regs, CRB_INTF_ID,
                      CapCRBIdleBypass, CRB_INTF_CAP_IDLE_FAST);
-    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+    ARRAY_FIELD_DP32(regs, CRB_INTF_ID,
                      CapDataXferSizeSupport, CRB_INTF_CAP_XFER_SIZE_64);
-    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+    ARRAY_FIELD_DP32(regs, CRB_INTF_ID,
                      CapFIFO, CRB_INTF_CAP_FIFO_NOT_SUPPORTED);
-    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+    ARRAY_FIELD_DP32(regs, CRB_INTF_ID,
                      CapCRB, CRB_INTF_CAP_CRB_SUPPORTED);
-    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+    ARRAY_FIELD_DP32(regs, CRB_INTF_ID,
                      InterfaceSelector, CRB_INTF_IF_SELECTOR_CRB);
-    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+    ARRAY_FIELD_DP32(regs, CRB_INTF_ID,
                      RID, 0b0000);
-    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID2,
+    ARRAY_FIELD_DP32(regs, CRB_INTF_ID2,
                      VID, PCI_VENDOR_ID_IBM);
 
     baseaddr += A_CRB_DATA_BUFFER;
-    s->regs[R_CRB_CTRL_CMD_SIZE] = CRB_CTRL_CMD_SIZE;
-    s->regs[R_CRB_CTRL_CMD_LADDR] = (uint32_t)baseaddr;
-    s->regs[R_CRB_CTRL_CMD_HADDR] = (uint32_t)(baseaddr >> 32);
-    s->regs[R_CRB_CTRL_RSP_SIZE] = CRB_CTRL_CMD_SIZE;
-    s->regs[R_CRB_CTRL_RSP_LADDR] = (uint32_t)baseaddr;
-    s->regs[R_CRB_CTRL_RSP_HADDR] = (uint32_t)(baseaddr >> 32);
+    regs[R_CRB_CTRL_CMD_SIZE] = CRB_CTRL_CMD_SIZE;
+    regs[R_CRB_CTRL_CMD_LADDR] = (uint32_t)baseaddr;
+    regs[R_CRB_CTRL_CMD_HADDR] = (uint32_t)(baseaddr >> 32);
+    regs[R_CRB_CTRL_RSP_SIZE] = CRB_CTRL_CMD_SIZE;
+    regs[R_CRB_CTRL_RSP_LADDR] = (uint32_t)baseaddr;
+    regs[R_CRB_CTRL_RSP_HADDR] = (uint32_t)(baseaddr >> 32);
 
     s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->tpmbe),
                             CRB_CTRL_CMD_SIZE);
@@ -208,14 +209,15 @@ void tpm_crb_reset(TPMCRBState *s, uint64_t baseaddr)
     if (tpm_backend_startup_tpm(s->tpmbe, s->be_buffer_size) < 0) {
         exit(1);
     }
+
+    memory_region_rom_device_set_romd(&s->mmio, true);
+    memory_region_set_dirty(&s->mmio, 0, TPM_CRB_ADDR_SIZE);
 }
 
 void tpm_crb_init_memory(Object *obj, TPMCRBState *s, Error **errp)
 {
-    memory_region_init_io(&s->mmio, obj, &tpm_crb_memory_ops, s,
-        "tpm-crb-mmio", sizeof(s->regs));
-    memory_region_init_ram(&s->cmdmem, obj,
-        "tpm-crb-cmd", CRB_CTRL_CMD_SIZE, errp);
+    memory_region_init_rom_device(&s->mmio, obj, &tpm_crb_memory_ops, s,
+        "tpm-crb-mmio", TPM_CRB_ADDR_SIZE, errp);
     if (s->ppi_enabled) {
         tpm_ppi_init_memory(&s->ppi, obj);
     }
-- 
2.39.2 (Apple Git-143)


