Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD7D73EAED
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 21:09:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrU5-0003Ie-7s; Mon, 26 Jun 2023 15:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrTk-0002TF-39; Mon, 26 Jun 2023 15:02:24 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrTi-0007ye-D7; Mon, 26 Jun 2023 15:02:23 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2FAC3EFC9;
 Mon, 26 Jun 2023 21:59:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id BDF66F804;
 Mon, 26 Jun 2023 21:59:13 +0300 (MSK)
Received: (nullmailer pid 1575394 invoked by uid 1000);
 Mon, 26 Jun 2023 18:59:05 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.4 39/43] target/hppa: New SeaBIOS-hppa version 7
Date: Mon, 26 Jun 2023 21:58:57 +0300
Message-Id: <20230626185902.1575177-39-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.4-20230626215033@cover.tls.msk.ru>
References: <qemu-stable-7.2.4-20230626215033@cover.tls.msk.ru>
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

Update SeaBIOS-hppa to version 7 which fixes a boot problem
with Debian-12 install CD images.

The problem with Debian-12 is, that the ramdisc got bigger
than what the firmware could load in one call to the LSI
scsi driver.

Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit bb9c998ca9343d445c76b69fa15dea9db692f526)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: pick this one before picking next 34ec3aea54368a92b6 "SeaBIOS-hppa version 8")

diff --git a/pc-bios/hppa-firmware.img b/pc-bios/hppa-firmware.img
index b2cbb71ee0..e7660b0458 100644
Binary files a/pc-bios/hppa-firmware.img and b/pc-bios/hppa-firmware.img differ
diff --git a/roms/seabios-hppa b/roms/seabios-hppa
index 458626c4c6..1cfbe76ff6 160000
--- a/roms/seabios-hppa
+++ b/roms/seabios-hppa
@@ -1 +1 @@
-Subproject commit 458626c4c6441045c0612f24313c7cf1f95e71c6
+Subproject commit 1cfbe76ff625fce9ed5991f7e13d80ffec900f40
-- 
2.39.2


