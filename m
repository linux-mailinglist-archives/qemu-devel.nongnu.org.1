Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0060170FFCD
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 23:13:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1vlZ-0001D6-Ph; Wed, 24 May 2023 17:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vlX-0001Ck-KD
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:11:27 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vlO-0001wA-NP
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JQPGoq5NqjtQQZ8R/mAs8jWKs55GwHHiilT7jUAWlyg=; b=pWo/8hivEKKIIqLl5JcR5bVZgP
 3PM6lsBsBnIUBPSM0pK5HKH3vByBNz5c/tt/CwPdRA4SU+LGjKH+Omx53Lp+DIkUaHFvyQB3JVEZn
 AF7gkRxroULPpcaI/u3HOsIl4npsArV22kmBlXaaCRS1vOM9wvUD89lZvw6baMr7fgBvOJE7Ist26
 UFV8tR07sDE8DgGM2N6N9R2446nk5EeudKK5WLxCxa5/eoOovr6SJv+FX+COBsSJmeL+EgPdvSiIg
 w7bw8M7VAsddlBe6qlLIfZOc6lFypupeHuv55isFPLrhJm8VnI6/cGYDLddGeeGOCR0wcl0dzz32V
 0EZs0sSZSdNJfaKMGuZkikYZxsleFnuh44UQQgGRy3PXrTyUZsTJhBS+u57kOZ1mDQ1Zsx/kI/GiW
 ni/LtpEQZ1Y6PoXVAGgQMBWIDhHCkxKe6E0q9VjPA/skjReByOWYJ+SQfhuqzlNhSaRC90uKfXZv7
 e+UhK42x8Cs+XdakKm86/wuoGrC80mNyh1v91io6C7AvC6PxC6RdV15BR9m1CkFihqqjwiEaoEbbq
 GOSqFBlcIx7dz6TOwO9WN2/czvTCDDyQDOFxAijOXh80MHiUzTRGtLM3PrE3VoKj4XfwrIXgzjD5n
 4Wx/csvnNNL92ukoYOD5jofywyvP6rLKQ9CadWMVE=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vlG-0005XR-Tw; Wed, 24 May 2023 22:11:15 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 24 May 2023 22:10:35 +0100
Message-Id: <20230524211104.686087-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 01/30] q800: fix up minor spacing issues in hw_compat_q800
 GlobalProperty array
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
---
 hw/m68k/q800.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index b35ecafbc7..1aead224e2 100644
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


