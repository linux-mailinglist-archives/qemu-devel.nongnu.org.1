Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1502282C084
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:07:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHCQ-0002z8-G4; Fri, 12 Jan 2024 08:03:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHCD-0002sp-16
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:03:37 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHCA-0002aj-5D
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oc1EdbXYwT+2pK47wP2cm+Sv5Ow2RDunfUR9sxZxHmo=; b=Z6GIfU+uuzN7qukStcxAUgGnZ7
 aa3FA8bpwsIiK2DEpOXTTonlL0g0zlH+UAWeAFZgEAO82b4OQNBr+jAG/ep8UQbhgTFyXOJGIyok3
 dgJkm0PSxsbIHLFQSObIwHPQEMEMjzxUpaHtrKpZCIDJd4lJha671fYjMYJZSd2i+VeihhRujFUNo
 zEAgA+xPmh7DRU3atxYvdhTjWfXYzKijNFDExdHJkGQ2gDvn3z++3MnQyKxwkrDyVAR8YPLbJdOwo
 E47McytiPq8DUNbuR5edP0vEfFqy00+YHouP5djMQN7DWG4wi5iWbpWFgfvdMQXMqNZzNVRQIRTKt
 qbd1gGVUPkejfpBshJD59q2fGL+0GmrknFuiH7qiON30aumxmx3HCEpyXDzJLdgYPdtiOvdYhcX/M
 f2cucPmBeSDYBWyTSleGhCtopRQkF22LfWmfbAv/7eGO6zVKSGyXyxeaFixnIuHYJPCH0+iu0F9sI
 /v2tUcgkRtkzf9kXgg7RBI/v5Dy1dgPAX1khdhYzo8/4i+HDcdnMt6o3HqlokNZHJhkpSyI3ncLaU
 wItmMQKQhtOcYyfjc7TEzSM6GFonNZ0TO+YIy6ahPSEKp2Cr9Fr/zTXnDXFEItyTsimR3s1BRd+kr
 8hBVSrq4TOvN/OqRPDLSyZ0I8qP3DJqFxkmCLDS9s=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH6r-0008jM-BB; Fri, 12 Jan 2024 12:58:09 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:54:09 +0000
Message-Id: <20240112125420.514425-78-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 77/88] esp.c: only transfer non-DMA MESSAGE OUT phase data for
 specific commands
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

The contents of the FIFO should only be copied to cmdfifo for ESP commands that
are sending data to the SCSI bus, which are the SEL_* commands and the TI
command. Otherwise any incoming data should be held in the FIFO as normal.

This fixes booting of NetBSD m68k under the Q800 machine once again.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 17e2db442c..d63039af89 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -712,14 +712,13 @@ static void esp_do_nodma(ESPState *s)
 
     switch (esp_get_phase(s)) {
     case STAT_MO:
-        /* Copy FIFO into cmdfifo */
-        n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
-        n = MIN(fifo8_num_free(&s->cmdfifo), n);
-        fifo8_push_all(&s->cmdfifo, buf, n);
-        s->cmdfifo_cdb_offset += n;
-
         switch (s->rregs[ESP_CMD]) {
         case CMD_SELATN:
+            /* Copy FIFO into cmdfifo */
+            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            n = MIN(fifo8_num_free(&s->cmdfifo), n);
+            fifo8_push_all(&s->cmdfifo, buf, n);
+
             if (fifo8_num_used(&s->cmdfifo) >= 1) {
                 /* First byte received, switch to command phase */
                 esp_set_phase(s, STAT_CD);
@@ -734,6 +733,11 @@ static void esp_do_nodma(ESPState *s)
             break;
 
         case CMD_SELATNS:
+            /* Copy one byte from FIFO into cmdfifo */
+            n = esp_fifo_pop_buf(&s->fifo, buf, 1);
+            n = MIN(fifo8_num_free(&s->cmdfifo), n);
+            fifo8_push_all(&s->cmdfifo, buf, n);
+
             if (fifo8_num_used(&s->cmdfifo) >= 1) {
                 /* First byte received, stop in message out phase */
                 s->rregs[ESP_RSEQ] = SEQ_MO;
@@ -746,6 +750,11 @@ static void esp_do_nodma(ESPState *s)
             break;
 
         case CMD_TI:
+            /* Copy FIFO into cmdfifo */
+            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            n = MIN(fifo8_num_free(&s->cmdfifo), n);
+            fifo8_push_all(&s->cmdfifo, buf, n);
+
             /* ATN remains asserted until FIFO empty */
             s->cmdfifo_cdb_offset = fifo8_num_used(&s->cmdfifo);
             esp_set_phase(s, STAT_CD);
-- 
2.39.2


