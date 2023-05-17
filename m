Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07001706242
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:09:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzC6d-0002Yq-Tl; Wed, 17 May 2023 04:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzC6J-00022j-W5; Wed, 17 May 2023 04:01:36 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzC6F-0000Zj-IY; Wed, 17 May 2023 04:01:35 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D70166757;
 Wed, 17 May 2023 11:00:58 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 5D47E5E0F;
 Wed, 17 May 2023 11:00:58 +0300 (MSK)
Received: (nullmailer pid 3624120 invoked by uid 1000);
 Wed, 17 May 2023 08:00:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v8.0.1 14/36] hw/intc/allwinner-a10-pic: Don't use
 set_bit()/clear_bit()
Date: Wed, 17 May 2023 11:00:34 +0300
Message-Id: <20230517080056.3623993-14-mjt@msgid.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <<20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
References: <20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

The Allwinner PIC model uses set_bit() and clear_bit() to update the
values in its irq_pending[] array when an interrupt arrives.  However
it is using these functions wrongly: they work on an array of type
'long', and it is passing an array of type 'uint32_t'.  Because the
code manually figures out the right array element, this works on
little-endian hosts and on 32-bit big-endian hosts, where bits 0..31
in a 'long' are in the same place as they are in a 'uint32_t'.
However it breaks on 64-bit big-endian hosts.

Remove the use of set_bit() and clear_bit() in favour of using
deposit32() on the array element.  This fixes a bug where on
big-endian 64-bit hosts the guest kernel would hang early on in
bootup.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230424152833.1334136-1-peter.maydell@linaro.org
(cherry picked from commit 2c5fa0778c3b4307f9f3af7f27886c46d129c62f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/intc/allwinner-a10-pic.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/intc/allwinner-a10-pic.c b/hw/intc/allwinner-a10-pic.c
index 8cca124807..4875e68ba6 100644
--- a/hw/intc/allwinner-a10-pic.c
+++ b/hw/intc/allwinner-a10-pic.c
@@ -49,12 +49,9 @@ static void aw_a10_pic_update(AwA10PICState *s)
 static void aw_a10_pic_set_irq(void *opaque, int irq, int level)
 {
     AwA10PICState *s = opaque;
+    uint32_t *pending_reg = &s->irq_pending[irq / 32];
 
-    if (level) {
-        set_bit(irq % 32, (void *)&s->irq_pending[irq / 32]);
-    } else {
-        clear_bit(irq % 32, (void *)&s->irq_pending[irq / 32]);
-    }
+    *pending_reg = deposit32(*pending_reg, irq % 32, 1, level);
     aw_a10_pic_update(s);
 }
 
-- 
2.39.2


