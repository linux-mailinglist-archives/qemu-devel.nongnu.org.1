Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6758AA187
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Apr 2024 19:53:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxVuO-0000U6-44; Thu, 18 Apr 2024 13:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxVuK-0000Sf-Vf; Thu, 18 Apr 2024 13:50:48 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxVuI-0007ao-Cc; Thu, 18 Apr 2024 13:50:48 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EF73C5FD6F;
 Thu, 18 Apr 2024 20:50:02 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 5659CB9349;
 Thu, 18 Apr 2024 20:50:00 +0300 (MSK)
Received: (nullmailer pid 947848 invoked by uid 1000);
 Thu, 18 Apr 2024 17:49:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 102/116] hw/block/nand: Have blk_load() take unsigned
 offset and return boolean
Date: Thu, 18 Apr 2024 20:49:32 +0300
Message-Id: <20240418174955.947730-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240418204921@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240418204921@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Negative offset is meaningless, use unsigned type.
Return a boolean value indicating success.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240409135944.24997-3-philmd@linaro.org>
(cherry picked from commit 2e3e09b368001f7eaeeca7a9b49cb1f0c9092d85)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/block/nand.c b/hw/block/nand.c
index 58ef547c5a..d945c0b9e3 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -84,7 +84,11 @@ struct NANDFlashState {
 
     void (*blk_write)(NANDFlashState *s);
     void (*blk_erase)(NANDFlashState *s);
-    void (*blk_load)(NANDFlashState *s, uint64_t addr, int offset);
+    /*
+     * Returns %true when block containing (@addr + @offset) is
+     * successfully loaded, otherwise %false.
+     */
+    bool (*blk_load)(NANDFlashState *s, uint64_t addr, unsigned offset);
 
     uint32_t ioaddr_vmstate;
 };
@@ -772,11 +776,11 @@ static void glue(nand_blk_erase_, NAND_PAGE_SIZE)(NANDFlashState *s)
     }
 }
 
-static void glue(nand_blk_load_, NAND_PAGE_SIZE)(NANDFlashState *s,
-                uint64_t addr, int offset)
+static bool glue(nand_blk_load_, NAND_PAGE_SIZE)(NANDFlashState *s,
+                                                 uint64_t addr, unsigned offset)
 {
     if (PAGE(addr) >= s->pages) {
-        return;
+        return false;
     }
 
     if (s->blk) {
@@ -804,6 +808,8 @@ static void glue(nand_blk_load_, NAND_PAGE_SIZE)(NANDFlashState *s,
                         offset, NAND_PAGE_SIZE + OOB_SIZE - offset);
         s->ioaddr = s->io;
     }
+
+    return true;
 }
 
 static void glue(nand_init_, NAND_PAGE_SIZE)(NANDFlashState *s)
-- 
2.39.2


