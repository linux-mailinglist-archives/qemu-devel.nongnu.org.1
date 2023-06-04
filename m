Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A96721758
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 15:18:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5nb3-0006cz-WD; Sun, 04 Jun 2023 09:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5naq-0005fL-4K
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 09:16:25 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5nao-0003Rd-PT
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 09:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pm4eOzasyKQj39odUPiLGUIgTcok2oRRMLuxlqhyDDA=; b=ed5Uu/kpfBOFh+NTn7FTcvKwTO
 MM0m7YgNfG5AevD/lG8Yw+j/hu0Ak4inB+fzbDQHWb+9AhaVyWNkD41Z/GlJtwwzuK8fvWgSw+OuZ
 5WrejvwrHcfz9QUGD5bINpJLw6oYVOP4oqOAy7x1dJgcc/ket4FmRKglLLaH1YIuqbf2TE4whv5vb
 Dh83Sxn/kssLkEDQmbLC5EtVah15WUiS35UYCfqgi0DcVN1IXT7MtQeDLxTQAWz3fcyxmtfQd0RbL
 FmiJ4mjjk6iVdz0SQXl8OPddhKhcLrP0MhKEx8y7tcuxZjygiBtaLhNh2dvVsEMM3fGntCYVi/TKU
 vc8gKsF78pqBEMrvXhie+RjsdOlHXX0q4yv+zP0CZxhz9TE+ESM+TS41krFt8URadIwJy64xJJX2n
 DKanHQLpfraJAuJpl8mvyKitUD7YVJGRbaC10+d7o8Ou1ESDAe6+dMOJ2CG9vaCZV/ZTGeQ8zKkTC
 b47m9XxpkilqwCOOGTbAzhJfDjMemyvvqua6Pl6sbkoK/YCvYWK1+ZX4oQ5czQI8aUv5DM00lMtMU
 ZQqA2rNvXB8hl34LILG2Sdl20JX8zK9CEW9Ht+3kwlWgOMIspI2yzPLA533KGDFhgcNZHaYEDP/cG
 n9KPOy+ENjce+0ae+g7vQoKXHgeaOXcy5nHIK2jlg=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5naT-0005pb-IU; Sun, 04 Jun 2023 14:16:05 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sun,  4 Jun 2023 14:14:47 +0100
Message-Id: <20230604131450.428797-21-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
References: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 20/23] q800: don't access Nubus bus directly from the
 mac-nubus-bridge device
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

Instead use the qdev_get_child_bus() function which is intended for this exact
purpose.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/m68k/q800.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 14879310ca..df2765dbd1 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -448,7 +448,7 @@ static void q800_machine_init(MachineState *machine)
                           qdev_get_gpio_in_named(DEVICE(&m->via2), "nubus-irq",
                                                  VIA2_NUBUS_IRQ_9));
 
-    nubus = &NUBUS_BRIDGE(dev)->bus;
+    nubus = NUBUS_BUS(qdev_get_child_bus(dev, "nubus-bus.0"));
 
     /* framebuffer in nubus slot #9 */
 
-- 
2.30.2


