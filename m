Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FA985F6FC
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Feb 2024 12:33:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd7G7-0005J2-Qi; Thu, 22 Feb 2024 06:29:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rd7Fv-0004e4-Vj; Thu, 22 Feb 2024 06:28:48 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rd7Ft-0005FS-Pc; Thu, 22 Feb 2024 06:28:47 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 647534FB62;
 Thu, 22 Feb 2024 14:26:27 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id DEEFA8718E;
 Thu, 22 Feb 2024 14:26:03 +0300 (MSK)
Received: (nullmailer pid 2526238 invoked by uid 1000);
 Thu, 22 Feb 2024 11:26:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 32/34] hw/hppa/Kconfig: Fix building with "configure
 --without-default-devices"
Date: Thu, 22 Feb 2024 14:25:59 +0300
Message-Id: <20240222112601.2526057-33-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240222112601.2526057-1-mjt@tls.msk.ru>
References: <20240222112601.2526057-1-mjt@tls.msk.ru>
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

From: Thomas Huth <thuth@redhat.com>

When running "configure" with "--without-default-devices", building
of qemu-system-hppa currently fails with:

 /usr/bin/ld: libqemu-hppa-softmmu.fa.p/hw_hppa_machine.c.o: in function `machine_HP_common_init_tail':
 hw/hppa/machine.c:399: undefined reference to `usb_bus_find'
 /usr/bin/ld: hw/hppa/machine.c:399: undefined reference to `usb_create_simple'
 /usr/bin/ld: hw/hppa/machine.c:400: undefined reference to `usb_bus_find'
 /usr/bin/ld: hw/hppa/machine.c:400: undefined reference to `usb_create_simple'
 collect2: error: ld returned 1 exit status
 ninja: build stopped: subcommand failed.
 make: *** [Makefile:162: run-ninja] Error 1

And after fixing this, the qemu-system-hppa binary refuses to run
due to the missing 'pci-ohci' and 'pci-serial' devices. Let's add
the right config switches to fix these problems.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/hppa/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
index ff8528aaa8..dff5df7f72 100644
--- a/hw/hppa/Kconfig
+++ b/hw/hppa/Kconfig
@@ -7,6 +7,7 @@ config HPPA_B160L
     select DINO
     select LASI
     select SERIAL
+    select SERIAL_PCI
     select ISA_BUS
     select I8259
     select IDE_CMD646
@@ -16,3 +17,4 @@ config HPPA_B160L
     select LASIPS2
     select PARALLEL
     select ARTIST
+    select USB_OHCI_PCI
-- 
2.39.2


