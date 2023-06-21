Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE27737DDC
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 10:55:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBtbQ-0001uT-Fu; Wed, 21 Jun 2023 04:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtbP-0001tz-4N
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:54:11 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtbM-00035G-N7
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A3/WkMfkaejjywJyaK8uB5G9dA8YvQzmw0BKHuM085M=; b=lbZT5qUWcnG2plZem0q01atRqP
 9Lx7D9gVXl01FGpX1YYaAsbetDulAXXO3ELaIdXSa+YTaFe5HGtyIKYOPz3LXa8+nHrIGkKYJXhC6
 Wa279eIePpTGgxib9PUurPEbGT191gS0ZNtTp5OliE0icz+Vfc2QmJizLrbKiL3bEWcJPKewOZDlD
 5knx5VV8ZcVb3iZSRP2tMPV1CirUHEAulNKYhBrPv9bCJdisubUDMG9VETBY4gnrkXG4N84D4CtWf
 x1mT0wSYV74ohzLDoNw8wBnjIsskUomX633bZSCIuMkAm6WSls7Ayvgi8GSePYY5Nt/la2GcbpBsR
 mjJc/MPUgAUjWXSI+MepwBkkgQ/EYghbp7Uzls1HdiFyh4w9lRxQo6mbIAQlheqxoniKgbGO2N2yP
 inlhwHiIrNURGX2CMidjmoKtse1P0Yzc1I0JA1PlqltgR5nHQ6EqcUQ66n+YGxsPxTvZpaL43I2zq
 UI1r9qWl/aOPxpdnTbBlJCYLohNwVL99ynZ9PGR1hA8UvmaYpd503vrj42o4dMRVgr3/DPJ5LThnN
 6VdipTqemBRyt9ALTdj4x4xqZV8nSpILxMLup2LHxJxbfn0f1z1lSuLid+kqFk6/OpWutCmig3For
 cHmNp/2Gbcms3EjNtM7y4zAbu7F2GOtSNfBRQwO6s=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtbA-0001ZB-2f; Wed, 21 Jun 2023 09:54:00 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 21 Jun 2023 09:53:30 +0100
Message-Id: <20230621085353.113233-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 01/24] q800: fix up minor spacing issues in hw_compat_q800
 GlobalProperty array
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Ensure there is a space before the final closing brace for all global
properties.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/m68k/q800.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 68f0cd8cac..dda57c60bf 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -719,14 +719,14 @@ static void q800_init(MachineState *machine)
 }
 
 static GlobalProperty hw_compat_q800[] = {
-    { "scsi-hd", "quirk_mode_page_vendor_specific_apple", "on"},
+    { "scsi-hd", "quirk_mode_page_vendor_specific_apple", "on" },
     { "scsi-hd", "vendor", " SEAGATE" },
     { "scsi-hd", "product", "          ST225N" },
     { "scsi-hd", "ver", "1.0 " },
-    { "scsi-cd", "quirk_mode_page_apple_vendor", "on"},
-    { "scsi-cd", "quirk_mode_sense_rom_use_dbd", "on"},
-    { "scsi-cd", "quirk_mode_page_vendor_specific_apple", "on"},
-    { "scsi-cd", "quirk_mode_page_truncated", "on"},
+    { "scsi-cd", "quirk_mode_page_apple_vendor", "on" },
+    { "scsi-cd", "quirk_mode_sense_rom_use_dbd", "on" },
+    { "scsi-cd", "quirk_mode_page_vendor_specific_apple", "on" },
+    { "scsi-cd", "quirk_mode_page_truncated", "on" },
     { "scsi-cd", "vendor", "MATSHITA" },
     { "scsi-cd", "product", "CD-ROM CR-8005" },
     { "scsi-cd", "ver", "1.0k" },
-- 
2.30.2


