Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CAC7F8B99
	for <lists+qemu-devel@lfdr.de>; Sat, 25 Nov 2023 15:21:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6tVR-000202-LD; Sat, 25 Nov 2023 09:19:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r6tVN-0001zn-FL; Sat, 25 Nov 2023 09:19:33 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r6tVL-00044Y-LS; Sat, 25 Nov 2023 09:19:33 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B859775A4C3;
 Sat, 25 Nov 2023 15:19:26 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id ABE8175A4C0; Sat, 25 Nov 2023 15:19:26 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH for 8.2] ppc/amigaone: Allow running without firmware image
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org,
 philmd@linaro.org
Message-Id: <20231125141926.ABE8175A4C0@zero.eik.bme.hu>
Date: Sat, 25 Nov 2023 15:19:26 +0100 (CET)
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The machine uses a modified U-Boot under GPL license but the sources
of it are lost with only a binary available so it cannot be included
in QEMU. Allow running without the firmware image by specifying -bios
none which can be used when calling a boot loader directly which does
not need the firmware and thus simplifying booting guests.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
Please merge for 8.2 as ir allows booting AmigaOS simpler without
having to download separate firmware.

 hw/ppc/amigaone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 992a55e632..f3d702814a 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -105,7 +105,7 @@ static void amigaone_init(MachineState *machine)
             exit(1);
         }
         g_free(filename);
-    } else if (!qtest_enabled()) {
+    } else if (!qtest_enabled() && strcmp(fwname, "none") != 0) {
         error_report("Could not find firmware '%s'", fwname);
         exit(1);
     }
-- 
2.30.9


