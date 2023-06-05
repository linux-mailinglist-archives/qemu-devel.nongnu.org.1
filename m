Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C77B7224A5
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 13:33:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q68Sb-0004Td-2U; Mon, 05 Jun 2023 07:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q68SV-0004Mo-VI
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 07:33:12 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q68ST-0008OW-WC
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 07:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZyZWWitKoyoH4cXwjHb4tS9t9BQik7b1JSC4Z3L2oXs=; b=mL4qarjfo4WGHGz3IxsXoVlZbR
 E2BIA/eY2JnOngIjOOEey6pQu2ddoh6NF6omfsfORf6SR8LjAR6xVuSb6eKCZtMLUTl3guYGTGJAm
 LcCZM+JZUJMtN/EtUo3/qPgn32ss/n+hVFMowaDNAi2Ieo6+bP6tclLCRvm8olV0e0gM0eD1/YPdl
 3CT3sqchdM4GbgzoBTLmMrb6f+vAkyir0jI+hvCSH7RZ0tkxvKKEl6+p3iWC55wwGrYFYfuYe1j8p
 3We0FQo0AD8NmBd5jI2pGN5UvmCl5M39jnCY4F1QiXDTSXTOe2vv9+TMdME0oaYFXdmUVwzCkBm6Q
 VmgEWuX2nsP/XnDBgmJm0zMtUjYtcyvPO0xUT2ciCRRA8RG2YmfsNW9xhLxgWrYa+X7kKIUSVsfEK
 l+OxS1S8xvzgl29dyd3cjPD2Qq76Y+g4UHdFUyaQxpUq+Pk0D/15PsVPQ3Zb1hD/4Im0KnT0da7e3
 Ew3RL8d3F2S3CYswZrxEBD1VKdhEHnBnDXU+9lej7sMMwsKfOlQGw/t7nSL0xIfKt/njGQBTxxIkx
 hbK3BbadMVAfZZRWKRZkLp1l06kM6AyU9HgW/EgGBUT7Cf5qi6LQxSFvktSMU6Khq/+/VxefSxd5c
 i1eF/0ckTZBDc2cUTagICucNGmDJsR2q3xbw1eZXg=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q68SN-0005fJ-Fr; Mon, 05 Jun 2023 12:33:07 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Date: Mon,  5 Jun 2023 12:32:52 +0100
Message-Id: <20230605113253.455937-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230605113253.455937-1-mark.cave-ayland@ilande.co.uk>
References: <20230605113253.455937-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 2/3] hw/arm/omap: Remove unused omap_uart_attach()
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

From: Bernhard Beschow <shentey@gmail.com>

The function is unused since commit
bdad3654d3c55f478e538037d9eccd204e5fc8ee ('hw/arm/nseries: Remove
invalid/unnecessary n8x0_uart_setup()').

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230523195608.125820-3-shentey@gmail.com>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/char/omap_uart.c   | 9 ---------
 include/hw/arm/omap.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/hw/char/omap_uart.c b/hw/char/omap_uart.c
index 1c890b9201..6848bddb4e 100644
--- a/hw/char/omap_uart.c
+++ b/hw/char/omap_uart.c
@@ -175,12 +175,3 @@ struct omap_uart_s *omap2_uart_init(MemoryRegion *sysmem,
 
     return s;
 }
-
-void omap_uart_attach(struct omap_uart_s *s, Chardev *chr)
-{
-    /* TODO: Should reuse or destroy current s->serial */
-    s->serial = serial_mm_init(get_system_memory(), s->base, 2, s->irq,
-                               omap_clk_getrate(s->fclk) / 16,
-                               chr ?: qemu_chr_new("null", "null", NULL),
-                               DEVICE_NATIVE_ENDIAN);
-}
diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index c275d9b681..067e9419f7 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -724,7 +724,6 @@ struct omap_uart_s *omap2_uart_init(MemoryRegion *sysmem,
                 qemu_irq txdma, qemu_irq rxdma,
                 const char *label, Chardev *chr);
 void omap_uart_reset(struct omap_uart_s *s);
-void omap_uart_attach(struct omap_uart_s *s, Chardev *chr);
 
 struct omap_mpuio_s;
 qemu_irq *omap_mpuio_in_get(struct omap_mpuio_s *s);
-- 
2.30.2


