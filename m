Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B7E853B65
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Feb 2024 20:43:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZygS-0008G4-46; Tue, 13 Feb 2024 14:43:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygQ-00085O-4w
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:10 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygO-0006TL-Hu
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jtHuybESn9RMD5N86rN7fm1Ea108OnJ+SQGaxYKfcKI=; b=GdVHlfsq/POiZffYLRMX5y+EuQ
 p9PKNM3cqC3ylQ3prF2nRBuqcsFg3FIhTpj/K10FtYG1P8g2OjNPS/cpheI8zh8PHjuIkDpvpyj5y
 dZBWD/8tvQZ62JZ1/bjm/L7ZnSDl3ZQ2gb3dZZ5M9sFx7nmQ5kZu5fj8MGQYBEA3FlRNnZdNViUDk
 0X2CUy2Z1km/88Q+4BpsfjjmJCp4glgfbi97dmlG7X2YUzzmoFvzzvSGoHsOEg7j/XJDBulVLhg+i
 PKhtwj3IA1Ena1FigRMAkwYD1KAb1G16mwfNCJZHKkrs/1cYBq7d8fqqzkYW+JQeSxjxFwq1ffiER
 5QF4oxcPpU+M6qhZ4EJ/uOrxgDRg9SFhM4OunOFRsLGW+JGgzThkpFup7sEn6KKWe7ssTDiBGbn7U
 wde0CcGiADE6Mhe5HRlTEC3lwjdmyN6o7TXjolp8gW/LbVDipP+ZSTTbIqDrHAxQvx3el923DdLBK
 G/ik0a8Nhn34GylnbRgPoPBRm2fzBh4oL175KyxeXkqNZ6cfZGgWB1gFdCOmj8wEdAyl9LTD9Rpse
 2rLoAXdtkdtvnMWJRzoKXteUijP/P4J1F4mp6zYMOrIJn8lJJw3RHFdbhBjcGrf5PcjPc22Dpn5lq
 rjEMeh30edciA5azCaquzPVQUQhMApr2b5SJtkFsQ=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfV-0008m4-Su; Tue, 13 Feb 2024 19:42:17 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:58 +0000
Message-Id: <20240213194052.1162753-35-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 34/88] esp.c: update esp_do_dma() bypass if async_len is zero
 to include non-zero transfer check
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

In the PDMA case the last transfer from the device to the FIFO has occurred
(async_len is zero) but esp_do_dma() is still being called to drain the
remaining FIFO contents.

The additional non-zero transfer check ensures that we still defer the SCSI
layer in the case where we are waiting for data for a TI command or a DMA
enable signal.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-35-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 14284ef54a..9647be4cc3 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -696,7 +696,7 @@ static void esp_do_dma(ESPState *s)
     if (!s->current_req) {
         return;
     }
-    if (s->async_len == 0) {
+    if (s->async_len == 0 && esp_get_tc(s) && s->ti_size) {
         /* Defer until data is available.  */
         return;
     }
-- 
2.39.2


