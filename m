Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D05CD7A7E54
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 14:17:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiw8D-0002LE-K0; Wed, 20 Sep 2023 08:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qiw84-0002Ds-Ha; Wed, 20 Sep 2023 08:16:31 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qiw82-0005MY-MY; Wed, 20 Sep 2023 08:16:28 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4BC8B23A03;
 Wed, 20 Sep 2023 15:16:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A8809296FA;
 Wed, 20 Sep 2023 15:15:55 +0300 (MSK)
Received: (nullmailer pid 105901 invoked by uid 1000);
 Wed, 20 Sep 2023 12:15:53 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Albert Esteve <aesteve@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.6 61/63] ui: fix crash when there are no active_console
Date: Wed, 20 Sep 2023 15:15:46 +0300
Message-Id: <20230920121553.105832-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.6-20230920151401@cover.tls.msk.ru>
References: <qemu-stable-7.2.6-20230920151401@cover.tls.msk.ru>
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

Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
0x0000555555888630 in dpy_ui_info_supported (con=0x0) at ../ui/console.c:812
812	    return con->hw_ops->ui_info != NULL;
(gdb) bt
#0  0x0000555555888630 in dpy_ui_info_supported (con=0x0) at ../ui/console.c:812
#1  0x00005555558a44b1 in protocol_client_msg (vs=0x5555578c76c0, data=0x5555581e93f0 <incomplete sequence \373>, len=24) at ../ui/vnc.c:2585
#2  0x00005555558a19ac in vnc_client_read (vs=0x5555578c76c0) at ../ui/vnc.c:1607
#3  0x00005555558a1ac2 in vnc_client_io (ioc=0x5555581eb0e0, condition=G_IO_IN, opaque=0x5555578c76c0) at ../ui/vnc.c:1635

Fixes:
https://issues.redhat.com/browse/RHEL-2600

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Albert Esteve <aesteve@redhat.com>
(cherry picked from commit 48a35e12faf90a896c5aa4755812201e00d60316)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/console.c b/ui/console.c
index 646202214a..52414d6aa3 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1697,6 +1697,9 @@ bool dpy_ui_info_supported(QemuConsole *con)
     if (con == NULL) {
         con = active_console;
     }
+    if (con == NULL) {
+        return false;
+    }
 
     return con->hw_ops->ui_info != NULL;
 }
-- 
2.39.2


