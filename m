Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4565F82C063
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:03:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH5q-0004MD-VX; Fri, 12 Jan 2024 07:57:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5m-00048m-D1
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:58 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5k-0007kR-H3
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yOo+aEy0k2OX72yvt4axQlFJAgTlc3T4leGrB2paOPQ=; b=mN2iFGGPOqSAerGDuQUNRVwvno
 P0W7TMbVGcM11Hm20S/YlfLyjlWEpCSx0sMkZ/Y0S0YgMWhAYZkNSXecfz63Wz7AlSPVBo9p291sW
 LWL8DLhrPNE8FwnI7D/9MBd6G9LXZZx6v7w7TdjU3hYVVonmkkHnARK7KRnuK4/pk7Xwr46bOpHys
 g7yjyp/wuPDBU0z09M3FcncjVlquc3Snm8aEDUnBE01ZpQINUA3nbBn6ullSVuQvmmoGuN8cCStbf
 mlrUjO/4erR/Yt52BEwt/nvRYxA8RwPklgWISeMG23VaTkZWYZhSCHVOMFSTgw6CSG3HvDZJqZ3QN
 6nEpQyqazXDfOcJ4p3XUjhCBKTM47DH+j+efjMDTcTc1eXHFfb7bvELU0nNzcH3GfBxDxoRcCZc2Y
 o3u7nU6RCNLW+19vpiOZvcM89wM0neCOvW4o/yUAI8yb7CsLr7ZFBZCT7WOs4K9UwGiMDp9QEAsuV
 wUip3u8ycH41mJr9ggXO7xzmVDMrWegyyrN/7df8VU79O/nK+DelWpsj5O/J00/OrdkQuSVLBva/l
 aLba7S14Y/AAdE47gr91bpyNZxrBq0B9HuOldiM8QNBjUEBlMpZngLvBonYd/Crecdk4dvbLwrVQ1
 mG+18WbVAiRzlDgHP7KjFbxSVG7oKSYr7YNkXcfVU=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4w-0008jM-Dd; Fri, 12 Jan 2024 12:56:10 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:29 +0000
Message-Id: <20240112125420.514425-38-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 37/88] esp.c: introduce esp_get_phase() function
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

Make use of this new function in all places where the SCSI phase bits are
manually masked from the ESP_RSTAT register.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 16cb6c72fd..de8d98082a 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -196,6 +196,11 @@ static void esp_set_phase(ESPState *s, uint8_t phase)
     trace_esp_set_phase(esp_phase_names[phase]);
 }
 
+static uint8_t esp_get_phase(ESPState *s)
+{
+    return s->rregs[ESP_RSTAT] & 7;
+}
+
 static uint8_t esp_pdma_read(ESPState *s)
 {
     uint8_t val;
@@ -537,7 +542,7 @@ static void esp_dma_ti_check(ESPState *s)
 
 static void do_dma_pdma_cb(ESPState *s)
 {
-    int to_device = ((s->rregs[ESP_RSTAT] & 7) == STAT_DO);
+    int to_device = (esp_get_phase(s) == STAT_DO);
     uint8_t buf[ESP_CMDFIFO_SZ];
     int len;
     uint32_t n;
@@ -554,7 +559,7 @@ static void do_dma_pdma_cb(ESPState *s)
         }
 
         s->ti_size = 0;
-        if ((s->rregs[ESP_RSTAT] & 7) == STAT_CD) {
+        if (esp_get_phase(s) == STAT_CD) {
             /* No command received */
             if (s->cmdfifo_cdb_offset == fifo8_num_used(&s->cmdfifo)) {
                 return;
@@ -621,7 +626,7 @@ static void do_dma_pdma_cb(ESPState *s)
 static void esp_do_dma(ESPState *s)
 {
     uint32_t len, cmdlen;
-    int to_device = ((s->rregs[ESP_RSTAT] & 7) == STAT_DO);
+    int to_device = (esp_get_phase(s) == STAT_DO);
     uint8_t buf[ESP_CMDFIFO_SZ];
     int n;
 
@@ -654,7 +659,7 @@ static void esp_do_dma(ESPState *s)
         }
         trace_esp_handle_ti_cmd(cmdlen);
         s->ti_size = 0;
-        if ((s->rregs[ESP_RSTAT] & 7) == STAT_CD) {
+        if (esp_get_phase(s) == STAT_CD) {
             /* No command received */
             if (s->cmdfifo_cdb_offset == fifo8_num_used(&s->cmdfifo)) {
                 return;
@@ -762,7 +767,7 @@ static void esp_do_dma(ESPState *s)
 
 static void esp_do_nodma(ESPState *s)
 {
-    int to_device = ((s->rregs[ESP_RSTAT] & 7) == STAT_DO);
+    int to_device = (esp_get_phase(s) == STAT_DO);
     uint8_t buf[ESP_FIFO_SZ];
     uint32_t cmdlen;
     int len, n;
@@ -776,7 +781,7 @@ static void esp_do_nodma(ESPState *s)
         cmdlen = fifo8_num_used(&s->cmdfifo);
         trace_esp_handle_ti_cmd(cmdlen);
         s->ti_size = 0;
-        if ((s->rregs[ESP_RSTAT] & 7) == STAT_CD) {
+        if (esp_get_phase(s) == STAT_CD) {
             /* No command received */
             if (s->cmdfifo_cdb_offset == fifo8_num_used(&s->cmdfifo)) {
                 return;
@@ -856,7 +861,7 @@ static void esp_pdma_cb(ESPState *s)
 void esp_command_complete(SCSIRequest *req, size_t resid)
 {
     ESPState *s = req->hba_private;
-    int to_device = ((s->rregs[ESP_RSTAT] & 7) == STAT_DO);
+    int to_device = (esp_get_phase(s) == STAT_DO);
 
     trace_esp_command_complete();
 
@@ -909,7 +914,7 @@ void esp_command_complete(SCSIRequest *req, size_t resid)
 void esp_transfer_data(SCSIRequest *req, uint32_t len)
 {
     ESPState *s = req->hba_private;
-    int to_device = ((s->rregs[ESP_RSTAT] & 7) == STAT_DO);
+    int to_device = (esp_get_phase(s) == STAT_DO);
     uint32_t dmalen = esp_get_tc(s);
 
     assert(!s->do_cmd);
@@ -1103,7 +1108,7 @@ uint64_t esp_reg_read(ESPState *s, uint32_t saddr)
             qemu_log_mask(LOG_UNIMP, "esp: PIO data read not implemented\n");
             s->rregs[ESP_FIFO] = 0;
         } else {
-            if ((s->rregs[ESP_RSTAT] & 0x7) == STAT_DI) {
+            if (esp_get_phase(s) == STAT_DI) {
                 if (s->ti_size) {
                     esp_do_nodma(s);
                 } else {
-- 
2.39.2


