Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C90D1754E8C
	for <lists+qemu-devel@lfdr.de>; Sun, 16 Jul 2023 14:00:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qL0OM-0004D2-Tn; Sun, 16 Jul 2023 07:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qL0OJ-0004CX-Sn; Sun, 16 Jul 2023 07:58:19 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qL0OI-0001r5-1o; Sun, 16 Jul 2023 07:58:19 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CCB4714246;
 Sun, 16 Jul 2023 14:58:24 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id BE2DF14F2F;
 Sun, 16 Jul 2023 14:58:04 +0300 (MSK)
Received: (nullmailer pid 1505318 invoked by uid 1000);
 Sun, 16 Jul 2023 11:58:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 1/6] docs/system/target-riscv.rst: tidy CPU firmware section
Date: Sun, 16 Jul 2023 14:57:56 +0300
Message-Id: <20230716115801.1505288-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230716115801.1505288-1-mjt@tls.msk.ru>
References: <20230716115801.1505288-1-mjt@tls.msk.ru>
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

This is how the content of the "RISC-V CPU firmware" section is
displayed after the html is generated:

"When using the sifive_u or virt machine there are three different
firmware boot options: 1. -bios default - This is the default behaviour
if no -bios option is included. (...) 3. -bios <file> - Tells QEMU to
load the specified file as the firmware."

It's all in the same paragraph, in a numbered list, and no special
formatting for the options.

Tidy it a bit by adding line breaks between items and its description.
Remove the numbered list. And apply formatting for the options cited in
the middle of the text.

Cc: qemu-trivial@nongnu.org
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/system/target-riscv.rst | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index 89a866e4f4..ba195f1518 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -76,11 +76,19 @@ RISC-V CPU firmware
 
 When using the ``sifive_u`` or ``virt`` machine there are three different
 firmware boot options:
-1. ``-bios default`` - This is the default behaviour if no -bios option
-is included. This option will load the default OpenSBI firmware automatically.
-The firmware is included with the QEMU release and no user interaction is
-required. All a user needs to do is specify the kernel they want to boot
-with the -kernel option
-2. ``-bios none`` - QEMU will not automatically load any firmware. It is up
-to the user to load all the images they need.
-3. ``-bios <file>`` - Tells QEMU to load the specified file as the firmware.
+
+* ``-bios default``
+
+This is the default behaviour if no ``-bios`` option is included. This option
+will load the default OpenSBI firmware automatically. The firmware is included
+with the QEMU release and no user interaction is required. All a user needs to
+do is specify the kernel they want to boot with the ``-kernel`` option
+
+* ``-bios none``
+
+QEMU will not automatically load any firmware. It is up to the user to load all
+the images they need.
+
+* ``-bios <file>``
+
+Tells QEMU to load the specified file as the firmware.
-- 
2.39.2


