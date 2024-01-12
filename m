Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B63F482C074
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:05:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH68-0005BY-Mf; Fri, 12 Jan 2024 07:57:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5z-0004rt-Bp
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:57:12 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5t-0007tc-Ie
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6HWAoI4FhyTXVqyr5pu3vcbWtES6sLbkmpCqYzLTP4M=; b=Upvd9lrjnsIcAWlPUhkGbu6MsT
 PXwqoWkoqoC8mQcP2nne1juVNtzHQU7d2eXfumRGdblwunryQMvqZ/aNro8pWoGQBqCiO+8mQBIRz
 3kTpnjjg8TdsGQ95V0uvDWAgsxCeLyVrA//ls5SzuQW3T4MxVD8MgrygkfNqAVC/2YWn5sBMcm99g
 3ReGl/uOjFhkokhluuB1yEjQYDvGmrMG3T0zHFQnNHRpDvDYuwL1q8HWGKIsQaRlc+xUqTym8JWJh
 5keTCnNXDpe8b4lg+K6at3FIj/NXfGgDygsFOCqbZ5RIdNR3SyaufyAc1+KeuzT6p5CO+aP7iJVdQ
 0n+2m5bmp89UaME6ImR2CciOtMl2HHVmFJnKJFa+JxzcGJsuN6Iooad8LAe4LxhTDlMuKVMglfW3D
 0znfNLkIMAKM23Hy+NWWrx2qvcduA+H/r/f/lTTMXbHETcf3WtvYpOnFyPT0vHpO/I9qBUkkj8vck
 5dFGPRzhHEMYt6B2Rn+TTrW5NN0DrBB72ZrVzE271mieZU2QN1tOetokH9CyovT9m6RFMU7eOMH3x
 g+qI/fzx/kn3Iwi0EdfIxVuIZ/FBvxvr/WasZYQRH3Rq13nz+Pee9SJbsC6PJTtG7lwxJzAYi/p78
 6mDSwAavFnzCT4ZU03EptL2Xls0fYIB9KHgDj5ms8=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH55-0008jM-PE; Fri, 12 Jan 2024 12:56:19 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:33 +0000
Message-Id: <20240112125420.514425-42-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 41/88] esp.c: convert esp_do_dma() do_cmd path to check for
 SCSI phase instead
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
 hw/scsi/esp.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index c1b44e5f18..22739d3875 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -635,11 +635,10 @@ static void esp_do_dma(ESPState *s)
     int n;
 
     len = esp_get_tc(s);
-    if (s->do_cmd) {
-        /*
-         * handle_ti_cmd() case: esp_do_dma() is called only from
-         * handle_ti_cmd() with do_cmd != NULL (see the assert())
-         */
+
+    switch (esp_get_phase(s)) {
+    case STAT_MO:
+    case STAT_CD:
         cmdlen = fifo8_num_used(&s->cmdfifo);
         trace_esp_do_dma(cmdlen, len);
         if (s->dma_memory_read) {
@@ -683,10 +682,8 @@ static void esp_do_dma(ESPState *s)
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


