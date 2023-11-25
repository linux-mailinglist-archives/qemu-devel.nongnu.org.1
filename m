Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6F17F88F4
	for <lists+qemu-devel@lfdr.de>; Sat, 25 Nov 2023 08:56:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6nV7-0007uR-Er; Sat, 25 Nov 2023 02:54:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <a_lijiejun@163.com>)
 id 1r6nV5-0007sZ-6f
 for qemu-devel@nongnu.org; Sat, 25 Nov 2023 02:54:51 -0500
Received: from m15.mail.163.com ([45.254.50.220])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <a_lijiejun@163.com>) id 1r6nV1-0006JO-11
 for qemu-devel@nongnu.org; Sat, 25 Nov 2023 02:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=3KVcC
 uKLNr4yHlpvsJxpOlYlNbuqpUeQ+xgB15DEgUg=; b=Jl7YT2Z64aMz3SHv7KMNE
 qCjoYZUuhN9gCTfqqRK4l3DySlWWDVmp9aPzAJh2QqDACD8UlSETleD9ak5HOwHT
 BIIxDw1JMU+HqdwkImLj4iqidVPBmzIBqEQ9DYyn4BnV4R0sfhjaattBu3X7edcZ
 iC62TOAzC55ki1JJMCdscE=
Received: from test123.sz.office (unknown [121.12.80.215])
 by zwqz-smtp-mta-g2-0 (Coremail) with SMTP id _____wBnT04iqGFlpWS+Dw--.14146S2;
 Sat, 25 Nov 2023 15:54:24 +0800 (CST)
From: lijiejun <a_lijiejun@163.com>
To: kraxel@redhat.com
Cc: qemu-devel@nongnu.org,
	lijiejun <a_lijiejun@163.com>
Subject: [PATCH] ui: Optimization dirty rect empty check logic
Date: Sat, 25 Nov 2023 15:54:08 +0800
Message-Id: <20231125075408.131075-1-a_lijiejun@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBnT04iqGFlpWS+Dw--.14146S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF1UZw15ur4rJFWxJw1fWFg_yoWkCwb_G3
 yxZrs3AFy3t3Z3Xas8KFyakryrXFZxCFs3u3yDtFWrGr1SvF45tF9aqr4xJr9xCFZ8tFyr
 urn8CF93AF4fKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRCksD5UUUUU==
X-Originating-IP: [121.12.80.215]
X-CM-SenderInfo: pdboxyplhm30i6rwjhhfrp/1tbiSBQzFF+FinzESAAAsb
Received-SPF: pass client-ip=45.254.50.220; envelope-from=a_lijiejun@163.com;
 helo=m15.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reduce unnecessary code execution in function qemu_spice_create_update,
such as "int blocks = DIV_ROUND_UP(surface_width(ssd->ds), blksize);"
and "int bpp = surface_bytes_per_pixel(ssd->ds);".

Signed-off-by: lijiejun <a_lijiejun@163.com>
---
 ui/spice-display.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/ui/spice-display.c b/ui/spice-display.c
index 6eb98a5a5c..508e35ed0f 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -194,10 +194,6 @@ static void qemu_spice_create_update(SimpleSpiceDisplay *ssd)
     int bpp = surface_bytes_per_pixel(ssd->ds);
     uint8_t *guest, *mirror;
 
-    if (qemu_spice_rect_is_empty(&ssd->dirty)) {
-        return;
-    };
-
     dirty_top = g_new(int, blocks);
     for (blk = 0; blk < blocks; blk++) {
         dirty_top[blk] = -1;
@@ -488,7 +484,9 @@ void qemu_spice_display_refresh(SimpleSpiceDisplay *ssd)
 
     WITH_QEMU_LOCK_GUARD(&ssd->lock) {
         if (QTAILQ_EMPTY(&ssd->updates) && ssd->ds) {
-            qemu_spice_create_update(ssd);
+            if (!qemu_spice_rect_is_empty(&ssd->dirty)) {
+                qemu_spice_create_update(ssd);
+            }
             ssd->notify++;
         }
     }
-- 
2.25.1


