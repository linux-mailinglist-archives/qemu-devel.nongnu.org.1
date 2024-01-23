Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD6E838988
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 09:50:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSCSj-0001Se-Gp; Tue, 23 Jan 2024 03:48:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rSCSg-0001Qr-DQ; Tue, 23 Jan 2024 03:48:50 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rSCSe-0004w3-5w; Tue, 23 Jan 2024 03:48:50 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 020FF46675;
 Tue, 23 Jan 2024 11:49:12 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B7B23699F3;
 Tue, 23 Jan 2024 11:48:31 +0300 (MSK)
Received: (nullmailer pid 3828123 invoked by uid 1000);
 Tue, 23 Jan 2024 08:48:31 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.9 16/20] hw/pflash: implement update buffer for block
 writes
Date: Tue, 23 Jan 2024 11:48:26 +0300
Message-Id: <20240123084831.3828060-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.9-20240123114733@cover.tls.msk.ru>
References: <qemu-stable-7.2.9-20240123114733@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Gerd Hoffmann <kraxel@redhat.com>

Add an update buffer where all block updates are staged.
Flush or discard updates properly, so we should never see
half-completed block writes in pflash storage.

Drop a bunch of FIXME comments ;)

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240108160900.104835-4-kraxel@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 284a7ee2e290e0c9b8cd3ea6164d92386933054f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: drop const in hw/block/pflash_cfi01.c for before
 v8.2.0-220-g7d5dc0a367 "hw/block: Constify VMState")

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index dbb3d0312d..6bc00254cc 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -81,16 +81,39 @@ struct PFlashCFI01 {
     uint16_t ident3;
     uint8_t cfi_table[0x52];
     uint64_t counter;
-    unsigned int writeblock_size;
+    uint32_t writeblock_size;
     MemoryRegion mem;
     char *name;
     void *storage;
     VMChangeStateEntry *vmstate;
     bool old_multiple_chip_handling;
+
+    /* block update buffer */
+    unsigned char *blk_bytes;
+    uint32_t blk_offset;
 };
 
 static int pflash_post_load(void *opaque, int version_id);
 
+static bool pflash_blk_write_state_needed(void *opaque)
+{
+    PFlashCFI01 *pfl = opaque;
+
+    return (pfl->blk_offset != -1);
+}
+
+static const VMStateDescription vmstate_pflash_blk_write = {
+    .name = "pflash_cfi01_blk_write",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = pflash_blk_write_state_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_VBUFFER_UINT32(blk_bytes, PFlashCFI01, 0, NULL, writeblock_size),
+        VMSTATE_UINT32(blk_offset, PFlashCFI01),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_pflash = {
     .name = "pflash_cfi01",
     .version_id = 1,
@@ -102,6 +125,10 @@ static const VMStateDescription vmstate_pflash = {
         VMSTATE_UINT8(status, PFlashCFI01),
         VMSTATE_UINT64(counter, PFlashCFI01),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_pflash_blk_write,
+        NULL
     }
 };
 
@@ -377,13 +404,55 @@ static void pflash_update(PFlashCFI01 *pfl, int offset,
     }
 }
 
+/* copy current flash content to block update buffer */
+static void pflash_blk_write_start(PFlashCFI01 *pfl, hwaddr offset)
+{
+    hwaddr mask = ~(pfl->writeblock_size - 1);
+
+    trace_pflash_write_block_start(pfl->name, pfl->counter);
+    pfl->blk_offset = offset & mask;
+    memcpy(pfl->blk_bytes, pfl->storage + pfl->blk_offset,
+           pfl->writeblock_size);
+}
+
+/* commit block update buffer changes */
+static void pflash_blk_write_flush(PFlashCFI01 *pfl)
+{
+    g_assert(pfl->blk_offset != -1);
+    trace_pflash_write_block_flush(pfl->name);
+    memcpy(pfl->storage + pfl->blk_offset, pfl->blk_bytes,
+           pfl->writeblock_size);
+    pflash_update(pfl, pfl->blk_offset, pfl->writeblock_size);
+    pfl->blk_offset = -1;
+}
+
+/* discard block update buffer changes */
+static void pflash_blk_write_abort(PFlashCFI01 *pfl)
+{
+    trace_pflash_write_block_abort(pfl->name);
+    pfl->blk_offset = -1;
+}
+
 static inline void pflash_data_write(PFlashCFI01 *pfl, hwaddr offset,
                                      uint32_t value, int width, int be)
 {
     uint8_t *p;
 
-    trace_pflash_data_write(pfl->name, offset, width, value, pfl->counter);
-    p = pfl->storage + offset;
+    if (pfl->blk_offset != -1) {
+        /* block write: redirect writes to block update buffer */
+        if ((offset < pfl->blk_offset) ||
+            (offset + width > pfl->blk_offset + pfl->writeblock_size)) {
+            pfl->status |= 0x10; /* Programming error */
+            return;
+        }
+        trace_pflash_data_write_block(pfl->name, offset, width, value,
+                                      pfl->counter);
+        p = pfl->blk_bytes + (offset - pfl->blk_offset);
+    } else {
+        /* write directly to storage */
+        trace_pflash_data_write(pfl->name, offset, width, value);
+        p = pfl->storage + offset;
+    }
 
     if (be) {
         stn_be_p(p, width, value);
@@ -504,9 +573,9 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
             } else {
                 value = extract32(value, 0, pfl->bank_width * 8);
             }
-            trace_pflash_write_block(pfl->name, value);
             pfl->counter = value;
             pfl->wcycle++;
+            pflash_blk_write_start(pfl, offset);
             break;
         case 0x60:
             if (cmd == 0xd0) {
@@ -537,12 +606,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
         switch (pfl->cmd) {
         case 0xe8: /* Block write */
             /* FIXME check @offset, @width */
-            if (!pfl->ro) {
-                /*
-                 * FIXME writing straight to memory is *wrong*.  We
-                 * should write to a buffer, and flush it to memory
-                 * only on confirm command (see below).
-                 */
+            if (!pfl->ro && (pfl->blk_offset != -1)) {
                 pflash_data_write(pfl, offset, value, width, be);
             } else {
                 pfl->status |= 0x10; /* Programming error */
@@ -551,18 +615,8 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
             pfl->status |= 0x80;
 
             if (!pfl->counter) {
-                hwaddr mask = pfl->writeblock_size - 1;
-                mask = ~mask;
-
                 trace_pflash_write(pfl->name, "block write finished");
                 pfl->wcycle++;
-                if (!pfl->ro) {
-                    /* Flush the entire write buffer onto backing storage.  */
-                    /* FIXME premature! */
-                    pflash_update(pfl, offset & mask, pfl->writeblock_size);
-                } else {
-                    pfl->status |= 0x10; /* Programming error */
-                }
             }
 
             pfl->counter--;
@@ -574,20 +628,17 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
     case 3: /* Confirm mode */
         switch (pfl->cmd) {
         case 0xe8: /* Block write */
-            if (cmd == 0xd0) {
-                /* FIXME this is where we should write out the buffer */
+            if ((cmd == 0xd0) && !(pfl->status & 0x10)) {
+                pflash_blk_write_flush(pfl);
                 pfl->wcycle = 0;
                 pfl->status |= 0x80;
             } else {
-                qemu_log_mask(LOG_UNIMP,
-                    "%s: Aborting write to buffer not implemented,"
-                    " the data is already written to storage!\n"
-                    "Flash device reset into READ mode.\n",
-                    __func__);
+                pflash_blk_write_abort(pfl);
                 goto mode_read_array;
             }
             break;
         default:
+            pflash_blk_write_abort(pfl);
             goto error_flash;
         }
         break;
@@ -821,6 +872,9 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
     pfl->cmd = 0x00;
     pfl->status = 0x80; /* WSM ready */
     pflash_cfi01_fill_cfi_table(pfl);
+
+    pfl->blk_bytes = g_malloc(pfl->writeblock_size);
+    pfl->blk_offset = -1;
 }
 
 static void pflash_cfi01_system_reset(DeviceState *dev)
@@ -840,6 +894,8 @@ static void pflash_cfi01_system_reset(DeviceState *dev)
      * This model deliberately ignores this delay.
      */
     pfl->status = 0x80;
+
+    pfl->blk_offset = -1;
 }
 
 static Property pflash_cfi01_properties[] = {
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 2a99b286b0..6fa56f14c0 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -546,7 +546,7 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
                 }
                 goto reset_flash;
             }
-            trace_pflash_data_write(pfl->name, offset, width, value, 0);
+            trace_pflash_data_write(pfl->name, offset, width, value);
             if (!pfl->ro) {
                 p = (uint8_t *)pfl->storage + offset;
                 if (pfl->be) {
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 2c45a62bd5..196493feae 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -12,7 +12,8 @@ fdctrl_tc_pulse(int level) "TC pulse: %u"
 pflash_chip_erase_invalid(const char *name, uint64_t offset) "%s: chip erase: invalid address 0x%" PRIx64
 pflash_chip_erase_start(const char *name) "%s: start chip erase"
 pflash_data_read(const char *name, uint64_t offset, unsigned size, uint32_t value) "%s: data offset:0x%04"PRIx64" size:%u value:0x%04x"
-pflash_data_write(const char *name, uint64_t offset, unsigned size, uint32_t value, uint64_t counter) "%s: data offset:0x%04"PRIx64" size:%u value:0x%04x counter:0x%016"PRIx64
+pflash_data_write(const char *name, uint64_t offset, unsigned size, uint32_t value) "%s: data offset:0x%04"PRIx64" size:%u value:0x%04x"
+pflash_data_write_block(const char *name, uint64_t offset, unsigned size, uint32_t value, uint64_t counter) "%s: data offset:0x%04"PRIx64" size:%u value:0x%04x counter:0x%016"PRIx64
 pflash_device_id(const char *name, uint16_t id) "%s: read device ID: 0x%04x"
 pflash_device_info(const char *name, uint64_t offset) "%s: read device information offset:0x%04" PRIx64
 pflash_erase_complete(const char *name) "%s: sector erase complete"
@@ -32,7 +33,9 @@ pflash_unlock0_failed(const char *name, uint64_t offset, uint8_t cmd, uint16_t a
 pflash_unlock1_failed(const char *name, uint64_t offset, uint8_t cmd) "%s: unlock0 failed 0x%" PRIx64 " 0x%02x"
 pflash_unsupported_device_configuration(const char *name, uint8_t width, uint8_t max) "%s: unsupported device configuration: device_width:%d max_device_width:%d"
 pflash_write(const char *name, const char *str) "%s: %s"
-pflash_write_block(const char *name, uint32_t value) "%s: block write: bytes:0x%x"
+pflash_write_block_start(const char *name, uint32_t value) "%s: block write start: bytes:0x%x"
+pflash_write_block_flush(const char *name) "%s: block write flush"
+pflash_write_block_abort(const char *name) "%s: block write abort"
 pflash_write_block_erase(const char *name, uint64_t offset, uint64_t len) "%s: block erase offset:0x%" PRIx64 " bytes:0x%" PRIx64
 pflash_write_failed(const char *name, uint64_t offset, uint8_t cmd) "%s: command failed 0x%" PRIx64 " 0x%02x"
 pflash_write_invalid(const char *name, uint8_t cmd) "%s: invalid write for command 0x%02x"
-- 
2.39.2


