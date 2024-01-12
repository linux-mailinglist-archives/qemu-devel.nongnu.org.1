Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B8D82C066
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:04:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHB7-00046w-Sb; Fri, 12 Jan 2024 08:02:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH9Y-0002KI-2i
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:00:52 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH9W-0001Ns-7q
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x156p7wfBoslhd+bnv42ZW1jfmF4Zc961WxQ1y+2R9s=; b=NiYPx/ZVHUCVgmR0t4fnxIfOdK
 piZXHjOcG7F4PfpQg98X2/cvW1uZHuhb/6GJ0MpKSaZ14N41PHZxP1O2XXNadeFA87rn1SNb6tLUo
 OOeFAXpTOai158F0vHukP2k5iHEmk+4t7H9/dz1zprP+iVtDdIXNzvq8r/WGJSUV7TZXFdsbcz0XP
 uvBkHuU3u9YsJATeFeaWTwfGiQJ1dv43E3j3IfiQ0/N4B0fEEUHzPzGSLao2tdI4NlzHWQEpI6e11
 g120NduFNS3bDCvzc/iYgVZy9QF5pFpfFjFog5H6vc3W0+rp2uspKC5LtZl+tNd4b205j32KGiqIw
 plg+sOkazPTfVaFk0fiPgc7Nh9gnYe3aIdOQJuw0EhaqbC7VODyUZZOUBbSrELg6NS6dUIkABmypz
 HiFoVY3/rnEiYKHWVsbppLwInXP3FHJxFczAjyNmrtQjVrYTWtIxlUjQs0Y0mwq71XEq6U9IwJIo5
 kNZtWGJT6aRNTcjf070Upz0hKnjP+T/o61Ipy3Tn0+kpMKI3unp/RE4GUr5YDMwG55KNQ7MsMILU6
 te5pSwGfgoOhfZhNQ1ohjC545zEDlxeDAdlASnSj+T614nQmXk4VDxhJh16KyIuwT/HHKDKQaJ/JV
 iJUppYaRm6xRu1POS2y6Wsd+bLBiei6k6kBkdZchk=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH6n-0008jM-1e; Fri, 12 Jan 2024 12:58:05 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:54:08 +0000
Message-Id: <20240112125420.514425-77-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 76/88] esp.c: only transfer non-DMA COMMAND phase data for
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

This fixes booting of really old 32-bit SPARC Linux kernels such as Aurelien's
debian_etch_sparc_small.qcow2 test image.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index ca26415d5f..17e2db442c 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -757,13 +757,13 @@ static void esp_do_nodma(ESPState *s)
         break;
 
     case STAT_CD:
-        /* Copy FIFO into cmdfifo */
-        n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
-        n = MIN(fifo8_num_free(&s->cmdfifo), n);
-        fifo8_push_all(&s->cmdfifo, buf, n);
-
         switch (s->rregs[ESP_CMD]) {
         case CMD_TI:
+            /* Copy FIFO into cmdfifo */
+            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            n = MIN(fifo8_num_free(&s->cmdfifo), n);
+            fifo8_push_all(&s->cmdfifo, buf, n);
+
             cmdlen = fifo8_num_used(&s->cmdfifo);
             trace_esp_handle_ti_cmd(cmdlen);
 
@@ -788,6 +788,11 @@ static void esp_do_nodma(ESPState *s)
 
         case CMD_SEL | CMD_DMA:
         case CMD_SELATN | CMD_DMA:
+            /* Copy FIFO into cmdfifo */
+            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            n = MIN(fifo8_num_free(&s->cmdfifo), n);
+            fifo8_push_all(&s->cmdfifo, buf, n);
+
             /* Handle when DMA transfer is terminated by non-DMA FIFO write */
             if (esp_cdb_length(s) && esp_cdb_length(s) ==
                 fifo8_num_used(&s->cmdfifo) - s->cmdfifo_cdb_offset) {
@@ -798,7 +803,11 @@ static void esp_do_nodma(ESPState *s)
 
         case CMD_SEL:
         case CMD_SELATN:
-            /* FIFO already contain entire CDB */
+            /* FIFO already contain entire CDB: copy to cmdfifo and execute */
+            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            n = MIN(fifo8_num_free(&s->cmdfifo), n);
+            fifo8_push_all(&s->cmdfifo, buf, n);
+
             do_cmd(s);
             break;
         }
-- 
2.39.2


