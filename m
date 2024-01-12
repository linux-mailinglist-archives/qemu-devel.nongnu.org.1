Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C1982C061
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:03:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH62-00050p-Q9; Fri, 12 Jan 2024 07:57:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5z-0004t3-Hv
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:57:12 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5u-0007u4-67
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:57:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lSzkhQ+BjPap4au27j9l5drApsMIxeCabu+p4z0lkcI=; b=GHpe8xhr2jAYGIT1zjwRplKTXU
 glotikqxWmi0lw+zho/gAcuMsO9hdhMtsq080XdhlLw1DNIBMhXea1LSs1/tXeBG2uG1xx/95oNgp
 KJ7XN3QubrfotXeIrGO0bBzYPRUf8PlBIFT9tc61VHvMtUHsPd0Tn2q//aZGWlNHl6QGBvWpHGBsY
 Pirzjxr08XTw2mJsFguyQ5jwKfGgIevk306kW+pep9ViA8g4QqjGCtpPg+AdzVLB/B/wA7byRhqib
 92T495grefjt9LaAUrFu+zC9/JhZ9utCVyFpRqE+yXDGk+BKOI337TwB2yYDos1i+qywQHHzBP/Ef
 TczVW83omiZIvE2lJBAqV6LrAj9LEAOdoZ365l9L/tPNsIRmor/uvwnn2Yl63JK3pyh6xDeIrIWGc
 RV2S1CdNdcWmWrSVu4jdUfi1diSR8oAQkQgYVpwcHi4Hz7hhQ4tSLfVy25PVT3fxAq4EcsNiLusFE
 bDrHFxFs4mQGzvmWR8HkpF/BLsv57MZ8XIlnnYiNHyDyFT033r0/bbrAeX4FtxUBJ4d/iZiBwJZmn
 K2W1jo7W2fZ0aQpfCxEY5WLH77rgHrKcQLAaanSY019l0vgdSEZAom7AoWKjAWiy4s1GnGGEbPwOa
 Avhio2f9PWNubQlZDhSftCot0+WjumzdnyF8PWs40=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5A-0008jM-2j; Fri, 12 Jan 2024 12:56:20 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:34 +0000
Message-Id: <20240112125420.514425-43-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 42/88] esp.c: convert do_dma_pdma_cb() do_cmd path to check
 for SCSI phase instead
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

Currently do_cmd is used to determine whether MESSAGE OUT and COMMAND phase data
is being accumulated in cmdfifo. Update esp_do_dma() to check directly for these
two SCSI phases instead.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 22739d3875..b48e020689 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -546,7 +546,9 @@ static void do_dma_pdma_cb(ESPState *s)
     int len;
     uint32_t n;
 
-    if (s->do_cmd) {
+    switch (esp_get_phase(s)) {
+    case STAT_MO:
+    case STAT_CD:
         /* Copy FIFO into cmdfifo */
         n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
         n = MIN(fifo8_num_free(&s->cmdfifo), n);
@@ -578,10 +580,8 @@ static void do_dma_pdma_cb(ESPState *s)
             s->rregs[ESP_RINTR] |= INTR_BS;
             esp_raise_irq(s);
         }
-        return;
-    }
+        break;
 
-    switch (esp_get_phase(s)) {
     case STAT_DO:
         if (!s->current_req) {
             return;
-- 
2.39.2


