Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DB274BBF3
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 07:15:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI0GC-0006ML-KH; Sat, 08 Jul 2023 01:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qI0Fw-0006FY-Dm; Sat, 08 Jul 2023 01:13:16 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qI0Fu-0001kJ-Je; Sat, 08 Jul 2023 01:13:16 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 724A812682;
 Sat,  8 Jul 2023 08:13:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 9BF70139D0;
 Sat,  8 Jul 2023 08:13:04 +0300 (MSK)
Received: (nullmailer pid 3229985 invoked by uid 1000);
 Sat, 08 Jul 2023 05:13:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Jan Kratochvil <jan@jankratochvil.net>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 03/10] trivial: man page: document display::gtk::zoom-to-fit
Date: Sat,  8 Jul 2023 08:12:43 +0300
Message-Id: <c35d9373be7b60a442b9bbb6cfd2ad5f5bde581d.1688793073.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1688793073.git.mjt@tls.msk.ru>
References: <cover.1688793073.git.mjt@tls.msk.ru>
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

From: Jan Kratochvil <jan@jankratochvil.net>

Document display::gtk::zoom-to-fit.

info from: https://superuser.com/questions/1752209/qemu-zoom-to-fit-shortcut-or-cli-switch

Signed-off-by: Jan Kratochvil <jan@jankratochvil.net>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-options.hx | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 3a6c7d3ef9..80bd0252d9 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2143,6 +2143,9 @@ SRST
 
         ``show-menubar=on|off`` : Display the main window menubar, defaults to "on"
 
+        ``zoom-to-fit=on|off`` : Expand video output to the window size,
+                                 defaults to "off"
+
     ``curses[,charset=<encoding>]``
         Display video output via curses. For graphics device models
         which support a text mode, QEMU can display this output using a
-- 
2.39.2


