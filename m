Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 546AD79989B
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 15:21:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qexdV-0006PU-CI; Sat, 09 Sep 2023 09:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexdR-0006Nj-HM; Sat, 09 Sep 2023 09:04:25 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexdN-00036d-EW; Sat, 09 Sep 2023 09:04:25 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7A88A205B9;
 Sat,  9 Sep 2023 16:01:21 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4BE3226E1F;
 Sat,  9 Sep 2023 16:00:30 +0300 (MSK)
Received: (nullmailer pid 353184 invoked by uid 1000);
 Sat, 09 Sep 2023 13:00:23 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.5 43/43] qxl: don't assert() if device isn't yet
 initialized
Date: Sat,  9 Sep 2023 16:00:09 +0300
Message-Id: <20230909130020.352951-43-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.5-20230909155813@cover.tls.msk.ru>
References: <qemu-stable-8.0.5-20230909155813@cover.tls.msk.ru>
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

If the PCI BAR isn't yet mapped or was unmapped, QXL_IO_SET_MODE will
assert(). Instead, report a guest bug and keep going.

This can be reproduced with:

cat << EOF | ./qemu-system-x86_64 -vga qxl -m 2048 -nodefaults -qtest stdio
outl 0xcf8 0x8000101c
outl 0xcfc 0xc000
outl 0xcf8 0x80001001
outl 0xcfc 0x01000000
outl 0xc006 0x00
EOF

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1829

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(cherry picked from commit 95bef686e490bc3afc3f51f5fc6e20bf260b938c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 80ce1e9a93..4b26aab235 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -1591,7 +1591,10 @@ static void qxl_set_mode(PCIQXLDevice *d, unsigned int modenr, int loadvm)
     }
 
     d->guest_slots[0].slot = slot;
-    assert(qxl_add_memslot(d, 0, devmem, QXL_SYNC) == 0);
+    if (qxl_add_memslot(d, 0, devmem, QXL_SYNC) != 0) {
+        qxl_set_guest_bug(d, "device isn't initialized yet");
+        return;
+    }
 
     d->guest_primary.surface = surface;
     qxl_create_guest_primary(d, 0, QXL_SYNC);
-- 
2.39.2


