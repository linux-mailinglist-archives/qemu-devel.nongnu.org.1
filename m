Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB8482C065
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:03:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHBO-0005kM-3K; Fri, 12 Jan 2024 08:02:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHB9-0004UX-3g
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:02:33 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHB7-000243-D9
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:02:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=85Pac9PQZZ68RZ3WymSxF8x6LDnKuCXTtOKl/cSo8ZQ=; b=l4noEbJpAMEZhhn+8j21C+yh6B
 i1UEvzBW9IzQRaTFig6m27FXJ0TzhN5GcSJ0aKAHVig0T0lpbj/rn3ZFMwmF/vb+XpQPU9VayfJMS
 USxs2d6hDzGsAUggD6iCFY7FVBH/XuFp55hs4kpNgjfckS5Klz8qcnf8SmBQG70rTRUPj94nXXyMS
 oy8y4TIIBjVKqebIhIhtrdxMha8bOv8Z39i9RlsicSaRoX6iuUr3A0PSYlTE6Z09qtaq/Ty3OgF1l
 jHFBOUpmSWIY6o5EV6YZ+NdZrvgjokCteUmN6WJPc0NIbSAY+xHxYKMyX7GoZRhobuAs9klrgYwl2
 Om/iH5NklUUVpDFQQmQXZZEYDVjdwIBluCgpZYOUDUqoZQiSQPuU6VdG0oiB438IBYjRLc8E2kQCo
 3U3Brb4Ohlg1xBVLCLB0+ZWErkKZYiFS//bYpvf9DZl7o82b+5CNbdcABLgFcH97HpXFhPUgT1c07
 Cr2GObTUnHBQhISVEazH6Ul36PaLdoKamefAQIfVow7DocVpOnYEbMh5jQZH6XDE5SM7lmyp0RbW0
 yfZkz3Q7MFatmuWRr1loExqxOLyDDZls97RuxmJUFqbJ3EtCPcuOeCdWjXfGL6b4wqZresEJwVzqp
 buZI8WUBE42J5dyubF/KXxmxqBDKBl72hGu3u7/p8=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5d-0008jM-5H; Fri, 12 Jan 2024 12:56:49 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:43 +0000
Message-Id: <20240112125420.514425-52-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 51/88] esp.c: don't use get_cmd() for CMD_SEL DMA commands
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

This can now be done using the existing logic in esp_do_dma() and do_dma_pdma_cb().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 9f787d12a8..3cf8b2b4eb 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -396,8 +396,6 @@ static void handle_satn(ESPState *s)
 
 static void handle_s_without_atn(ESPState *s)
 {
-    int32_t cmdlen;
-
     if (s->dma && !s->dma_enabled) {
         s->dma_cb = handle_s_without_atn;
         return;
@@ -406,17 +404,17 @@ static void handle_s_without_atn(ESPState *s)
     if (esp_select(s) < 0) {
         return;
     }
-    cmdlen = get_cmd(s, ESP_CMDFIFO_SZ);
-    if (cmdlen > 0) {
-        s->cmdfifo_cdb_offset = 0;
-        do_cmd(s);
-    } else if (cmdlen == 0) {
-        if (s->dma) {
-            esp_raise_drq(s);
+
+    esp_set_phase(s, STAT_CD);
+    s->rregs[ESP_RSEQ] = SEQ_CD;
+    s->cmdfifo_cdb_offset = 0;
+
+    if (s->dma) {
+        esp_do_dma(s);
+    } else {
+        if (get_cmd(s, ESP_CMDFIFO_SZ)) {
+            do_cmd(s);
         }
-        /* Target present, but no cmd yet - switch to command phase */
-        s->rregs[ESP_RSEQ] = SEQ_CD;
-        esp_set_phase(s, STAT_CD);
     }
 }
 
-- 
2.39.2


