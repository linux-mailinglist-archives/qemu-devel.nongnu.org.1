Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B527BAAE87C
	for <lists+qemu-devel@lfdr.de>; Wed,  7 May 2025 20:08:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCjBh-0003KL-15; Wed, 07 May 2025 14:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uCjBM-0002Tr-1T; Wed, 07 May 2025 14:07:48 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uCjBD-00008u-Va; Wed, 07 May 2025 14:07:47 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0BC4111FF2F;
 Wed, 07 May 2025 21:07:25 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id DD69B206718;
 Wed,  7 May 2025 21:07:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Integral <integral@archlinuxcn.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 21/21] docs: replace `-hda` with `-drive` & update `root=`
 kernel parameter
Date: Wed,  7 May 2025 21:07:37 +0300
Message-Id: <20250507180737.183147-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250507180737.183147-1-mjt@tls.msk.ru>
References: <20250507180737.183147-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Integral <integral@archlinuxcn.org>

According to QEMU manual:

Older options like `-hda` are essentially macros which expand into
`-drive` options for various drive interfaces. The original forms
bake in a lot of assumptions from the days when QEMU was emulating a
legacy PC, they are not recommended for modern configurations.

Signed-off-by: Integral <integral@archlinuxcn.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/system/gdb.rst         | 2 +-
 docs/system/linuxboot.rst   | 6 +++---
 docs/system/target-mips.rst | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/docs/system/gdb.rst b/docs/system/gdb.rst
index 4228cb56bb..d50470b135 100644
--- a/docs/system/gdb.rst
+++ b/docs/system/gdb.rst
@@ -20,7 +20,7 @@ connection, use the ``-gdb dev`` option instead of ``-s``. See
 
 .. parsed-literal::
 
-   |qemu_system| -s -S -kernel bzImage -hda rootdisk.img -append "root=/dev/hda"
+   |qemu_system| -s -S -kernel bzImage -drive file=rootdisk.img,format=raw -append "root=/dev/sda"
 
 QEMU will launch but will silently wait for gdb to connect.
 
diff --git a/docs/system/linuxboot.rst b/docs/system/linuxboot.rst
index 5db2e560dc..2328b4a73d 100644
--- a/docs/system/linuxboot.rst
+++ b/docs/system/linuxboot.rst
@@ -11,7 +11,7 @@ The syntax is:
 
 .. parsed-literal::
 
-   |qemu_system| -kernel bzImage -hda rootdisk.img -append "root=/dev/hda"
+   |qemu_system| -kernel bzImage -drive file=rootdisk.img,format=raw -append "root=/dev/sda"
 
 Use ``-kernel`` to provide the Linux kernel image and ``-append`` to
 give the kernel command line arguments. The ``-initrd`` option can be
@@ -23,8 +23,8 @@ virtual serial port and the QEMU monitor to the console with the
 
 .. parsed-literal::
 
-   |qemu_system| -kernel bzImage -hda rootdisk.img \
-                    -append "root=/dev/hda console=ttyS0" -nographic
+   |qemu_system| -kernel bzImage -drive file=rootdisk.img,format=raw \
+                    -append "root=/dev/sda console=ttyS0" -nographic
 
 Use Ctrl-a c to switch between the serial console and the monitor (see
 :ref:`GUI_keys`).
diff --git a/docs/system/target-mips.rst b/docs/system/target-mips.rst
index 83239fb9df..9028c3b304 100644
--- a/docs/system/target-mips.rst
+++ b/docs/system/target-mips.rst
@@ -112,5 +112,5 @@ https://mipsdistros.mips.com/LinuxDistro/nanomips/kernels/v4.15.18-432-gb2eb9a8b
 Start system emulation of Malta board with nanoMIPS I7200 CPU::
 
    qemu-system-mipsel -cpu I7200 -kernel <kernel_image_file> \
-       -M malta -serial stdio -m <memory_size> -hda <disk_image_file> \
+       -M malta -serial stdio -m <memory_size> -drive file=<disk_image_file>,format=raw \
        -append "mem=256m@0x0 rw console=ttyS0 vga=cirrus vesa=0x111 root=/dev/sda"
-- 
2.39.5


