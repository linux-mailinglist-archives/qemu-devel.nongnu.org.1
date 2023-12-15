Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E44A815099
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 21:03:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEEMh-0005ri-NI; Fri, 15 Dec 2023 15:00:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rEEMH-0005q7-Mr
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 15:00:31 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rEEMD-0002SW-8v
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 15:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dWdQOrKqi7TIDtPC9PXd7iw5QvDlsvXkFi8XseBFMVw=; b=guG1ZOUMHy+5+736SlVEZmsDbD
 UoDkQwsQ0TW1En3YXd6gkDHYlCAPnT7u1EpbUfYaI8wJaMc1Ic+cs5WR41AtyRum+3jnXYWeYObyH
 HouTUdF6ua8tiGJ3Fs69AOnSKRdzQVvxL2D19nIvSIzaB9EqXklrHnzTez0dZA6Q3oGp5WFaXOCqL
 /QRF4ciFZmz4jGI4bHm61MG/2mVdUAznozBkKoDaWfcHtVhzm4X1gWEubIbJHDrXkbnUfQqvm+A86
 xGuSjlFSMlEG0Y93p7y3k/pEu21mtF0XOOMZgPuT4fwU6l+0KmbQYF9KA8T2s/A5GomTLugXhZlCu
 HiIkJ1aWZW0j24/zBsjtjplk2MpA/F2k4CpG9p+IIBB8ypcB4GgM9rKxt4Iu/aNlsRhv9UN6LG11v
 474TiNxGSusYKV3RqgJ0SlqkVFup1i/BJE0mBPn/sU66jecY6l1DgsiKxNlns2o/wC39OMdGu9W31
 CyEhi4SmO8r/YR360QA3jTbWS+nhPvJP640TZMEDf/3bzVvVa7V+vQo80ZYI5uL/FQJoquOvykxPv
 K2/3Mx9pifoXc83u7xKbAxIBbNfLs5/5dY8FNCc6fZ+7den2Atj9aaLUXBsjlYXucDhdXhXjll9NR
 NiGqFvCX+bxUEjOwZK+rKo/EQe50iwVB8ML5j86qk=;
Received: from [2a00:23c4:8bb0:f100:5e2c:460f:a6a7:b066]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rEELo-000AEs-GC; Fri, 15 Dec 2023 20:00:02 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Fri, 15 Dec 2023 19:59:59 +0000
Message-Id: <20231215200009.346212-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
References: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:f100:5e2c:460f:a6a7:b066
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 02/12] next-cube.c: don't pulse SCSI DMA IRQ upon reception of
 FLUSH command
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

Normally a DMA FLUSH command is used to ensure that data is completely written
to the device and/or memory, so remove the pulse of the SCSI DMA IRQ if a DMA
FLUSH command is received. This enables the NeXT ROM monitor to start to load
from a SCSI disk.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index feeda23475..87ddaf4329 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -473,7 +473,6 @@ static void scr_writeb(NeXTPC *s, hwaddr addr, uint32_t value)
             DPRINTF("SCSICSR FIFO Flush\n");
             /* will have to add another irq to the esp if this is needed */
             /* esp_puflush_fifo(esp_g); */
-            qemu_irq_pulse(s->scsi_dma);
         }
 
         if (value & SCSICSR_ENABLE) {
-- 
2.39.2


