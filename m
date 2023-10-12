Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2C37C6B65
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 12:47:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqtBz-0007RX-KD; Thu, 12 Oct 2023 06:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mironov@fintech.ru>)
 id 1qqtBq-0007RH-Me
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 06:45:15 -0400
Received: from exchange.fintech.ru ([195.54.195.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mironov@fintech.ru>)
 id 1qqtBm-0003gA-FO
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 06:45:14 -0400
Received: from Ex16-02.fintech.ru (10.0.10.19) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 12 Oct
 2023 13:44:58 +0300
Received: from infra.fintech.ru (10.10.1.240) by Ex16-02.fintech.ru
 (10.0.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 12 Oct
 2023 13:44:58 +0300
From: Sergey Mironov <mironov@fintech.ru>
To: <kraxel@redhat.com>, <marcandre.lureau@redhat.com>, <qemu-devel@nongnu.org>
CC: Sergey Mironov <mironov@fintech.ru>, Linux Verification Center
 <sdl.qemu@linuxtesting.org>
Subject: [PATCH 1/1] ui: Replacing pointer in function 
Date: Thu, 12 Oct 2023 13:44:48 +0300
Message-ID: <20231012104448.1251039-1-mironov@fintech.ru>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.10.1.240]
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-02.fintech.ru
 (10.0.10.19)
Received-SPF: pass client-ip=195.54.195.159; envelope-from=mironov@fintech.ru;
 helo=exchange.fintech.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

At the end of the first if we see 'vc->gfx.surface = NULL;',
further checking of it is pointless. In the second if, ectx is taken.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Co-developed-by: Linux Verification Center <sdl.qemu@linuxtesting.org>
Signed-off-by: Sergey Mironov <mironov@fintech.ru>
---
 ui/gtk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 935de1209b..5da3f9b022 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1400,7 +1400,7 @@ static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
             eglDestroySurface(qemu_egl_display, vc->gfx.esurface);
             vc->gfx.esurface = NULL;
         }
-        if (vc->gfx.esurface) {
+        if (vc->gfx.ectx) {
             eglDestroyContext(qemu_egl_display, vc->gfx.ectx);
             vc->gfx.ectx = NULL;
         }
-- 
2.31.1


