Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0749F8254C1
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 15:00:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLkj3-0005cE-Hw; Fri, 05 Jan 2024 08:59:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rLkj1-0005bC-Fw
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 08:59:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rLkiy-00039s-8p
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 08:59:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704463139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PAuByVo0B+dEgwlN1tCmpWQsJWQ7Y6b7gobdSbP4WP8=;
 b=gpCCg8QHfSZfnICaTuJhg6U3z0MEj5V4pK3/ORSUDsBjxrRW0/fZz7vAWVpmlZPkpx0Exj
 K8I0KS4unZOCOj3R3QCfG5nx+fwWtAXLTyS8Rwl7AS3otzykcmTMhtPOJ19MeGkzYVD2Df
 5qs5C6saWKldX8tMvIH5g1NBOztDTnE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-dZCv0u1TNwiz10aAScsEYA-1; Fri, 05 Jan 2024 08:58:58 -0500
X-MC-Unique: dZCv0u1TNwiz10aAScsEYA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0B0485A58A;
 Fri,  5 Jan 2024 13:58:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA4EB40C6EB9;
 Fri,  5 Jan 2024 13:58:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3B1A718017F8; Fri,  5 Jan 2024 14:58:55 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/2] hw/pflash: implement update buffer for block writes
Date: Fri,  5 Jan 2024 14:58:54 +0100
Message-ID: <20240105135855.268064-3-kraxel@redhat.com>
In-Reply-To: <20240105135855.268064-1-kraxel@redhat.com>
References: <20240105135855.268064-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.679,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add an update buffer where all block updates are staged.
Flush or discard updates properly, so we should never see
half-completed block writes in pflash storage.

Drop a bunch of FIXME comments ;)

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/block/pflash_cfi01.c | 104 ++++++++++++++++++++++++++++++----------
 1 file changed, 78 insertions(+), 26 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 67f1c9773ab3..78ac95b3291e 100644
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
 
@@ -400,13 +427,50 @@ static void pflash_update(PFlashCFI01 *pfl, int offset,
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
+        p = pfl->blk_bytes + (offset - pfl->blk_offset);
+    } else {
+        /* write directly to storage */
+        trace_pflash_data_write(pfl->name, offset, width, value, pfl->counter);
+        p = pfl->storage + offset;
+    }
 
     switch (width) {
     case 1:
@@ -553,6 +617,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
             trace_pflash_write_block(pfl->name, value);
             pfl->counter = value;
             pfl->wcycle++;
+            pflash_blk_write_start(pfl, offset);
             break;
         case 0x60:
             if (cmd == 0xd0) {
@@ -583,12 +648,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
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
@@ -597,18 +657,8 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
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
@@ -620,20 +670,17 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
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
@@ -867,6 +914,9 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
     pfl->cmd = 0x00;
     pfl->status = 0x80; /* WSM ready */
     pflash_cfi01_fill_cfi_table(pfl);
+
+    pfl->blk_bytes = g_malloc(pfl->writeblock_size);
+    pfl->blk_offset = -1;
 }
 
 static void pflash_cfi01_system_reset(DeviceState *dev)
@@ -886,6 +936,8 @@ static void pflash_cfi01_system_reset(DeviceState *dev)
      * This model deliberately ignores this delay.
      */
     pfl->status = 0x80;
+
+    pfl->blk_offset = -1;
 }
 
 static Property pflash_cfi01_properties[] = {
-- 
2.43.0


