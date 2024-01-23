Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33135839395
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 16:49:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSJ11-0003R5-Ef; Tue, 23 Jan 2024 10:48:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rSJ05-0002pm-Bg; Tue, 23 Jan 2024 10:47:52 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rSIzy-0000ie-RG; Tue, 23 Jan 2024 10:47:40 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F3D7646924;
 Tue, 23 Jan 2024 18:47:50 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0EB3C69EB3;
 Tue, 23 Jan 2024 18:47:10 +0300 (MSK)
Received: (nullmailer pid 3847915 invoked by uid 1000);
 Tue, 23 Jan 2024 15:47:08 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 45/54] hw/pflash: use ldn_{be,le}_p and stn_{be,le}_p
Date: Tue, 23 Jan 2024 18:46:46 +0300
Message-Id: <20240123154708.3847837-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240123123124@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240123123124@cover.tls.msk.ru>
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

Use the helper functions we have to read/write multi-byte values
in correct byte order.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240108160900.104835-3-kraxel@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 5dd58358a57048e5ceabf5c91c0544f4f56afdcd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 82f592d420..f1a9dd571f 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -225,34 +225,10 @@ static uint32_t pflash_data_read(PFlashCFI01 *pfl, hwaddr offset,
     uint32_t ret;
 
     p = pfl->storage;
-    switch (width) {
-    case 1:
-        ret = p[offset];
-        break;
-    case 2:
-        if (be) {
-            ret = p[offset] << 8;
-            ret |= p[offset + 1];
-        } else {
-            ret = p[offset];
-            ret |= p[offset + 1] << 8;
-        }
-        break;
-    case 4:
-        if (be) {
-            ret = p[offset] << 24;
-            ret |= p[offset + 1] << 16;
-            ret |= p[offset + 2] << 8;
-            ret |= p[offset + 3];
-        } else {
-            ret = p[offset];
-            ret |= p[offset + 1] << 8;
-            ret |= p[offset + 2] << 16;
-            ret |= p[offset + 3] << 24;
-        }
-        break;
-    default:
-        abort();
+    if (be) {
+        ret = ldn_be_p(p + offset, width);
+    } else {
+        ret = ldn_le_p(p + offset, width);
     }
     trace_pflash_data_read(pfl->name, offset, width, ret);
     return ret;
@@ -408,34 +384,11 @@ static inline void pflash_data_write(PFlashCFI01 *pfl, hwaddr offset,
     trace_pflash_data_write(pfl->name, offset, width, value, pfl->counter);
     p = pfl->storage + offset;
 
-    switch (width) {
-    case 1:
-        p[0] = value;
-        break;
-    case 2:
-        if (be) {
-            p[0] = value >> 8;
-            p[1] = value;
-        } else {
-            p[0] = value;
-            p[1] = value >> 8;
-        }
-        break;
-    case 4:
-        if (be) {
-            p[0] = value >> 24;
-            p[1] = value >> 16;
-            p[2] = value >> 8;
-            p[3] = value;
-        } else {
-            p[0] = value;
-            p[1] = value >> 8;
-            p[2] = value >> 16;
-            p[3] = value >> 24;
-        }
-        break;
+    if (be) {
+        stn_be_p(p, width, value);
+    } else {
+        stn_le_p(p, width, value);
     }
-
 }
 
 static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
-- 
2.39.2


