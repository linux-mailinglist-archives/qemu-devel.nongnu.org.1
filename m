Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A467E6B5D
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:45:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15Kk-0000sG-Im; Thu, 09 Nov 2023 08:44:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15Kf-0000Ob-5r; Thu, 09 Nov 2023 08:44:29 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15Kc-0001FF-Br; Thu, 09 Nov 2023 08:44:28 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0D58331B05;
 Thu,  9 Nov 2023 16:43:12 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1E11D344AC;
 Thu,  9 Nov 2023 16:43:04 +0300 (MSK)
Received: (nullmailer pid 1461803 invoked by uid 1000);
 Thu, 09 Nov 2023 13:43:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.3 14/55] lasips2: LASI PS/2 devices are not
 user-createable
Date: Thu,  9 Nov 2023 16:42:18 +0300
Message-Id: <20231109134300.1461632-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
References: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
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

From: Helge Deller <deller@gmx.de>

Those PS/2 ports are created with the LASI controller when
a 32-bit PA-RISC machine is created.

Mark them not user-createable to avoid showing them in
the qemu device list.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: qemu-stable@nongnu.org
(cherry picked from commit a1e6a5c46219bada2c7b932748527553b36559ae)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/input/lasips2.c b/hw/input/lasips2.c
index ea7c07a2ba..6075121b72 100644
--- a/hw/input/lasips2.c
+++ b/hw/input/lasips2.c
@@ -351,6 +351,11 @@ static void lasips2_port_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    /*
+     * The PS/2 mouse port is integreal part of LASI and can not be
+     * created by users without LASI.
+     */
+    dc->user_creatable = false;
     dc->realize = lasips2_port_realize;
 }
 
@@ -397,6 +402,11 @@ static void lasips2_kbd_port_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     LASIPS2PortDeviceClass *lpdc = LASIPS2_PORT_CLASS(klass);
 
+    /*
+     * The PS/2 keyboard port is integreal part of LASI and can not be
+     * created by users without LASI.
+     */
+    dc->user_creatable = false;
     device_class_set_parent_realize(dc, lasips2_kbd_port_realize,
                                     &lpdc->parent_realize);
 }
-- 
2.39.2


