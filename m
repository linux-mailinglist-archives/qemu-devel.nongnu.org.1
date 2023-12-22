Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC2081CEB6
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 20:19:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGl1o-0000jB-89; Fri, 22 Dec 2023 14:17:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rGl1i-0000iP-KK; Fri, 22 Dec 2023 14:17:42 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rGl1f-0006JD-GD; Fri, 22 Dec 2023 14:17:42 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 851593E20A;
 Fri, 22 Dec 2023 22:17:46 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 58A99514C5;
 Fri, 22 Dec 2023 22:17:27 +0300 (MSK)
Received: (nullmailer pid 414192 invoked by uid 1000);
 Fri, 22 Dec 2023 19:17:27 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Elen Avan <elen.avan@bk.ru>, qemu-stable@nongnu.org
Subject: [PATCH] include/ui/rect.h: fix qemu_rect_init() mis-assignment
Date: Fri, 22 Dec 2023 22:17:21 +0300
Message-Id: <20231222191721.414176-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

From: Elen Avan <elen.avan@bk.ru>
Signed-off-by: Elen Avan <elen.avan@bk.ru>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2051
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2050
Fixes: a200d53b1fde "virtio-gpu: replace PIXMAN for region/rect test"
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/ui/rect.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

(Re-sending this as a more accurate patch which actually can be applied)
Stefan: please apply it directly as an obvious bugfix

diff --git a/include/ui/rect.h b/include/ui/rect.h
index 94898f92d0..68f05d78a8 100644
--- a/include/ui/rect.h
+++ b/include/ui/rect.h
@@ -19,7 +19,7 @@ static inline void qemu_rect_init(QemuRect *rect,
                                   uint16_t width, uint16_t height)
 {
     rect->x = x;
-    rect->y = x;
+    rect->y = y;
     rect->width = width;
     rect->height = height;
 }
-- 
2.39.2


