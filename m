Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 426D7744F99
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 20:07:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qG1SD-0000dR-J9; Sun, 02 Jul 2023 14:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qG1Rb-0000aO-RL; Sun, 02 Jul 2023 14:05:09 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qG1RX-000563-KT; Sun, 02 Jul 2023 14:05:06 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CA40210DEC;
 Sun,  2 Jul 2023 21:04:53 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id EDD7B11200;
 Sun,  2 Jul 2023 21:04:51 +0300 (MSK)
Received: (nullmailer pid 2122360 invoked by uid 1000);
 Sun, 02 Jul 2023 18:04:51 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Jakub=20Jerm=C3=A1=C5=99?= <jakub@jermar.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.3 57/65] Revert "hw/sparc64/niagara: Use blk_name()
 instead of open-coding it"
Date: Sun,  2 Jul 2023 21:04:30 +0300
Message-Id: <20230702180439.2122316-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.3-20230702210422@cover.tls.msk.ru>
References: <qemu-stable-8.0.3-20230702210422@cover.tls.msk.ru>
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

From: Markus Armbruster <armbru@redhat.com>

This reverts commit 1881f336a33a8a99cb17ab1c57ed953682e8e107.

This commit breaks "-drive if=pflash,readonly=on,file=image.iso".  It
claims to merely replace an open-coded version of blk_name() by a
call, but that's not the case.  Sorry for the inconvenience!

Reported-by: Jakub Jermář <jakub@jermar.eu>
Cc: qemu-stable@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20230515151104.1350155-1-armbru@redhat.com>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
(cherry picked from commit ac5e8c1dec246950d73e22dceab5cb36e82aac0b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 6725cc61fd..ab3c4ec346 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "block/block_int-common.h"
 #include "qemu/units.h"
 #include "cpu.h"
 #include "hw/boards.h"
@@ -143,9 +144,10 @@ static void niagara_init(MachineState *machine)
             memory_region_add_subregion(get_system_memory(),
                                         NIAGARA_VDISK_BASE, &s->vdisk_ram);
             dinfo->is_default = 1;
-            rom_add_file_fixed(blk_name(blk), NIAGARA_VDISK_BASE, -1);
+            rom_add_file_fixed(blk_bs(blk)->filename, NIAGARA_VDISK_BASE, -1);
         } else {
-            error_report("could not load ram disk '%s'", blk_name(blk));
+            error_report("could not load ram disk '%s'",
+                         blk_bs(blk)->filename);
             exit(1);
         }
     }
-- 
2.39.2


