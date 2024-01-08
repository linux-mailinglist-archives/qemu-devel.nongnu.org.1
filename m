Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F66F826F09
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 13:54:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMp96-00031t-N9; Mon, 08 Jan 2024 07:54:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMp8j-00030e-B0
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 07:54:01 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMp8f-0006It-O1
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 07:54:00 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40d8902da73so16449555e9.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 04:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704718436; x=1705323236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GmyBpmtz8oXX8KnZsDsq1mJ6m0zHjrv/X6q6YSk63xs=;
 b=GmcYILCjtScSciAIBMyJIbwhY9OCXElf2fYsgbaT61SOFV24m5rwd8WIUjVTfI6lKI
 pKjR8/bJ055ZfDz8HXSCnelkQkIRz6hA4+Vyscq1bULMxPMY4w7waDcxLDtJHaq6En7E
 aav1l6eMLpE5e06SnQIotKKttbdK1A8z/fFT0wjdxCz9/lnWbb3qWesGOR8Ng4H6GE4W
 8SKLG5OCTcNHFSRfnrzsTxxifwECDDAb1Ts9YZaMvlrrVP7V+RkYrCCYMUPHQRhuD55Y
 Cb9F5Y1MreWb5fv+gJ0myGeNrPJrIHMoHLcnt7dMGAH4szsGz7FSiUOJXU1jVOGRScjo
 nC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704718436; x=1705323236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GmyBpmtz8oXX8KnZsDsq1mJ6m0zHjrv/X6q6YSk63xs=;
 b=j0MPZRUlIbXrm7pL837XBpP1cjYJJg2xVePU1LminByaxDBLL9fc6fvH4oZQxfsCV5
 ZElupYSOA8VGU8zE1eVCd1mHMPuNI6ZobgCwhbLDaL8gXoE6wEeHMDGye5jgd5tidQGc
 i3tu/knSsPI1WXSArXeUDOzprI82N8b63dJjsXZ/0ILMwQ3ahUuJ2yYDajMPmGzLbLu5
 zhiChAHl89nuRl1okKi/sbRngWaGNAEdKfg88j3gXT3a+3x6pDKbJ5r90w8QQ2zS4V6C
 AqJsliZswzj8Z0yr8sAMeZXly3K02MDLZXhHjhHnjgvpPkOkFpBo4fkwu9W8XNn3uFoj
 GLVw==
X-Gm-Message-State: AOJu0YwMW/C8V1z76Rl57qE8+rLzbUitmmmEY5HIY64xqoLWXPnWdcx3
 YO7WgjSShOlXAB7+0H+wEh65xaVNjNXz8w==
X-Google-Smtp-Source: AGHT+IGWKcStg5Woh+ajuCGVlKzkXp8d2x+A2cyMAOffD+IL5zbZUrdBCqYSR/Qy5wDkRF9OoASxWQ==
X-Received: by 2002:a05:600c:5493:b0:40e:4aef:26bf with SMTP id
 iv19-20020a05600c549300b0040e4aef26bfmr123659wmb.30.1704718435880; 
 Mon, 08 Jan 2024 04:53:55 -0800 (PST)
Received: from localhost.localdomain ([176.176.175.62])
 by smtp.gmail.com with ESMTPSA id
 k7-20020a5d6d47000000b0033725783839sm7750457wri.110.2024.01.08.04.53.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 08 Jan 2024 04:53:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/2] hw/pflash: implement update buffer for block writes
Date: Mon,  8 Jan 2024 13:53:42 +0100
Message-ID: <20240108125342.48298-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240108125342.48298-1-philmd@linaro.org>
References: <20240108125342.48298-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Message-ID: <20240105135855.268064-3-kraxel@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/block/pflash_cfi01.c | 106 ++++++++++++++++++++++++++++++----------
 1 file changed, 80 insertions(+), 26 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index ce63ba43b6..0120462648 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -80,16 +80,39 @@ struct PFlashCFI01 {
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
@@ -101,6 +124,10 @@ static const VMStateDescription vmstate_pflash = {
         VMSTATE_UINT8(status, PFlashCFI01),
         VMSTATE_UINT64(counter, PFlashCFI01),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_pflash_blk_write,
+        NULL
     }
 };
 
@@ -376,12 +403,51 @@ static void pflash_update(PFlashCFI01 *pfl, int offset,
     }
 }
 
+/* copy current flash content to block update buffer */
+static void pflash_blk_write_start(PFlashCFI01 *pfl, hwaddr offset)
+{
+    hwaddr mask = ~(pfl->writeblock_size - 1);
+
+    pfl->blk_offset = offset & mask;
+    memcpy(pfl->blk_bytes, pfl->storage + pfl->blk_offset,
+           pfl->writeblock_size);
+}
+
+/* commit block update buffer changes */
+static void pflash_blk_write_flush(PFlashCFI01 *pfl)
+{
+    g_assert(pfl->blk_offset != -1);
+    memcpy(pfl->storage + pfl->blk_offset, pfl->blk_bytes,
+           pfl->writeblock_size);
+    pflash_update(pfl, pfl->blk_offset, pfl->writeblock_size);
+    pfl->blk_offset = -1;
+}
+
+/* discard block update buffer changes */
+static void pflash_blk_write_abort(PFlashCFI01 *pfl)
+{
+    pfl->blk_offset = -1;
+}
+
 static inline void pflash_data_write(PFlashCFI01 *pfl, hwaddr offset,
                                      uint32_t value, int width, int be)
 {
-    uint8_t *p = pfl->storage;
+    uint8_t *p;
+
+    if (pfl->blk_offset != -1) {
+        /* block write: redirect writes to block update buffer */
+        if ((offset < pfl->blk_offset) ||
+            (offset + width > pfl->blk_offset + pfl->writeblock_size)) {
+            pfl->status |= 0x10; /* Programming error */
+            return;
+        }
+        p = pfl->blk_bytes + (offset - pfl->blk_offset);
+    } else {
+        /* write directly to storage */
+        trace_pflash_data_write(pfl->name, offset, width, value, pfl->counter);
+        p = pfl->storage + offset;
+    }
 
-    trace_pflash_data_write(pfl->name, offset, width, value, pfl->counter);
     if (be) {
         stn_be_p(p, width, value);
     } else {
@@ -504,6 +570,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
             trace_pflash_write_block(pfl->name, value);
             pfl->counter = value;
             pfl->wcycle++;
+            pflash_blk_write_start(pfl, offset);
             break;
         case 0x60:
             if (cmd == 0xd0) {
@@ -534,12 +601,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
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
@@ -548,18 +610,8 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
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
@@ -571,20 +623,17 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
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
@@ -818,6 +867,9 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
     pfl->cmd = 0x00;
     pfl->status = 0x80; /* WSM ready */
     pflash_cfi01_fill_cfi_table(pfl);
+
+    pfl->blk_bytes = g_malloc(pfl->writeblock_size);
+    pfl->blk_offset = -1;
 }
 
 static void pflash_cfi01_system_reset(DeviceState *dev)
@@ -837,6 +889,8 @@ static void pflash_cfi01_system_reset(DeviceState *dev)
      * This model deliberately ignores this delay.
      */
     pfl->status = 0x80;
+
+    pfl->blk_offset = -1;
 }
 
 static Property pflash_cfi01_properties[] = {
-- 
2.41.0


