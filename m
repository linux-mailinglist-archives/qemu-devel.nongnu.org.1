Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEB27E6BFE
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:05:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15bj-0001l4-Qq; Thu, 09 Nov 2023 09:02:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15aQ-00065a-Fn; Thu, 09 Nov 2023 09:00:53 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15aM-00060P-Og; Thu, 09 Nov 2023 09:00:46 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 487BC31BC6;
 Thu,  9 Nov 2023 16:59:42 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 50E6D344FF;
 Thu,  9 Nov 2023 16:59:34 +0300 (MSK)
Received: (nullmailer pid 1462803 invoked by uid 1000);
 Thu, 09 Nov 2023 13:59:33 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Vasiliy Ulyanov <vulyanov@suse.de>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.7 16/62] optionrom: Remove build-id section
Date: Thu,  9 Nov 2023 16:58:44 +0300
Message-Id: <20231109135933.1462615-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
References: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
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

From: Fabiano Rosas <farosas@suse.de>

Our linker script for optionroms specifies only the placement of the
.text section, leaving the linker free to place the remaining sections
at arbitrary places in the file.

Since at least binutils 2.39, the .note.gnu.build-id section is now
being placed at the start of the file, which causes label addresses to
be shifted. For linuxboot_dma.bin that means that the PnP header
(among others) will not be found when determining the type of ROM at
optionrom_setup():

(0x1c is the label _pnph, where the magic "PnP" is)

$ xxd /usr/share/qemu/linuxboot_dma.bin | grep "PnP"
00000010: 0000 0000 0000 0000 0000 1c00 2450 6e50  ............$PnP

$ xxd pc-bios/optionrom/linuxboot_dma.bin | grep "PnP"
00000010: 0000 0000 0000 0000 0000 4c00 2450 6e50  ............$PnP
                                   ^bad

Using a freshly built linuxboot_dma.bin ROM results in a broken boot:

  SeaBIOS (version rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org)
  Booting from Hard Disk...
  Boot failed: could not read the boot disk

  Booting from Floppy...
  Boot failed: could not read the boot disk

  No bootable device.

We're not using the build-id section, so pass the --build-id=none
option to the linker to remove it entirely.

Note: In theory, this same issue could happen with any other
section. The ideal solution would be to have all unused sections
discarded in the linker script. However that would be a larger change,
specially for the pvh rom which uses the .bss and COMMON sections so
I'm addressing only the immediate issue here.

Reported-by: Vasiliy Ulyanov <vulyanov@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20230926192502.15986-1-farosas@suse.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 35ed01ba5448208695ada5fa20a13c0a4689a1c1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(mjt: remove unrelated stable@vger)

diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile
index b1fff0ba6c..30d07026c7 100644
--- a/pc-bios/optionrom/Makefile
+++ b/pc-bios/optionrom/Makefile
@@ -36,7 +36,7 @@ config-cc.mak: Makefile
 	    $(call cc-option,-Wno-array-bounds)) 3> config-cc.mak
 -include config-cc.mak
 
-override LDFLAGS = -nostdlib -Wl,-T,$(SRC_DIR)/flat.lds
+override LDFLAGS = -nostdlib -Wl,--build-id=none,-T,$(SRC_DIR)/flat.lds
 
 pvh.img: pvh.o pvh_main.o
 
-- 
2.39.2


