Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D28DB83138C
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:58:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQNFh-0002yz-MU; Thu, 18 Jan 2024 02:55:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNFY-0002iL-4f; Thu, 18 Jan 2024 02:55:44 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNFW-0007eo-6H; Thu, 18 Jan 2024 02:55:43 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 345634503F;
 Thu, 18 Jan 2024 10:54:36 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 6100F661A8;
 Thu, 18 Jan 2024 10:54:06 +0300 (MSK)
Received: (nullmailer pid 2381691 invoked by uid 1000);
 Thu, 18 Jan 2024 07:54:05 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 21/38] edk2: update build config,
 set PcdUninstallMemAttrProtocol = TRUE.
Date: Thu, 18 Jan 2024 10:52:48 +0300
Message-Id: <20240118075404.2381519-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
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

From: Gerd Hoffmann <kraxel@redhat.com>

Needed to workaround buggy EFI_MEMORY_ATTRIBUTE_PROTOCOL
usage in shim.efi.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
(cherry picked from commit 6f79fa5f097aa41fc96a14dfccdb0ea8d9facd6c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/roms/edk2-build.config b/roms/edk2-build.config
index bab6a9caeb..0d367dbdb7 100644
--- a/roms/edk2-build.config
+++ b/roms/edk2-build.config
@@ -22,9 +22,15 @@ SMM_REQUIRE              = TRUE
 [opts.armvirt.silent]
 DEBUG_PRINT_ERROR_LEVEL  = 0x80000000
 
-[pcds.nx.broken.grub]
+[pcds.nx.strict]
+PcdDxeNxMemoryProtectionPolicy = 0xC000000000007FD5
+PcdUninstallMemAttrProtocol    = FALSE
+
+[pcds.nx.broken.shim.grub]
 # grub.efi uses EfiLoaderData for code
 PcdDxeNxMemoryProtectionPolicy = 0xC000000000007FD1
+# shim.efi has broken MemAttr code
+PcdUninstallMemAttrProtocol    = TRUE
 
 [pcds.workaround.202308]
 PcdFirstTimeWakeUpAPsBySipi = FALSE
@@ -95,7 +101,7 @@ conf = ArmVirtPkg/ArmVirtQemu.dsc
 arch = ARM
 opts = common
        armvirt.silent
-pcds = nx.broken.grub
+pcds = nx.broken.shim.grub
 plat = ArmVirtQemu-ARM
 dest = ../pc-bios
 cpy1 = FV/QEMU_EFI.fd    edk2-arm-code.fd
@@ -112,7 +118,7 @@ conf = ArmVirtPkg/ArmVirtQemu.dsc
 arch = AARCH64
 opts = common
        armvirt.silent
-pcds = nx.broken.grub
+pcds = nx.broken.shim.grub
 plat = ArmVirtQemu-AARCH64
 dest = ../pc-bios
 cpy1 = FV/QEMU_EFI.fd  edk2-aarch64-code.fd
-- 
2.39.2


