Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F5B82C078
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:05:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHA5-0002fr-QO; Fri, 12 Jan 2024 08:01:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH9H-0001vv-Cq
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:00:43 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH9D-0001Fp-NB
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:00:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RX8suPy1gNm2SICly4WBODoxn3FIMb8MK+d3UzOnUYI=; b=PuytSSWIJfG1SyRLGuUJdbLE0y
 1/9kQopKpqngcDyHX8lwjmWpLoPnX4pA4I2fhDvt5dceLe4JC5MSUeXB/z0GmcnnIFvsd3TCXeJTd
 KVykgBiZ6YkWjmJvzhmoCowhZ07wSrfc204jin4f3CTpGWbCfR/6Xr0mDH81b/bN+hocUl57AZwxo
 wWEn4kSIpya6Z3khJAjzcQaYSr7U2BCopm7TK77jqocwn89Qk1BXfnRMF3MOPRS9s93XS/MOs+P37
 jzby190mgMG4Wa84gsqSIHZ+E9EPZbpjdS6LYtlDc47wfE3o1yEcVTNwEXcuwWi3Kn3v0xmFir69F
 eBJeHwcrR+H6UJeXckXIxNTqlDU2bEBFc4f64LzX2X8KzQ9/aKlLWP7AFlN+VsAD6gjn0QcD7bV+S
 N1NO4hrMXINZqwciOzlzf909lpJcEJqqSmF/+4gSzfjDt9ES4hVz/ruANSybFd5CPJj+lAJrWe9c6
 VQ9p1W+9u41pLBvraD3TUJ/VFsg0TgjAqLGpKWxcULvnJwWiXcA7z2zcbWdIxYUAGFYwWULnuxuWS
 9YfJ3QgYAgF08C1bLH0XWsoPpaOVxSm8ty/U5lPpTF995M1fJabep35fK2N9YhaEBUpru3pa2N0U3
 RTI5r1N4NOgp8myEgXg1/g0DkfCud6c4A0cV42+h8=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5r-0008jM-9R; Fri, 12 Jan 2024 12:57:07 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:49 +0000
Message-Id: <20240112125420.514425-58-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 57/88] esp.c: rename data_in_ready to to data_ready
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

This field is currently used to handle deferred interrupts for the DATA IN phase
but the code will soon be updated to do the same for the DATA OUT phase.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c         | 8 ++++----
 include/hw/scsi/esp.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 5061c9d5a1..73c723afcc 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -328,7 +328,7 @@ static void do_command_phase(ESPState *s)
              * Switch to DATA IN phase but wait until initial data xfer is
              * complete before raising the command completion interrupt
              */
-            s->data_in_ready = false;
+            s->data_ready = false;
             esp_set_phase(s, STAT_DI);
         } else {
             esp_set_phase(s, STAT_DO);
@@ -859,12 +859,12 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
     s->async_len = len;
     s->async_buf = scsi_req_get_buf(req);
 
-    if (!to_device && !s->data_in_ready) {
+    if (!to_device && !s->data_ready) {
         /*
          * Initial incoming data xfer is complete so raise command
          * completion interrupt
          */
-        s->data_in_ready = true;
+        s->data_ready = true;
         s->rregs[ESP_RINTR] |= INTR_BS;
         esp_raise_irq(s);
     }
@@ -1241,7 +1241,7 @@ const VMStateDescription vmstate_esp = {
         VMSTATE_UINT32_TEST(mig_cmdlen, ESPState, esp_is_before_version_5),
         VMSTATE_UINT32(do_cmd, ESPState),
         VMSTATE_UINT32_TEST(mig_dma_left, ESPState, esp_is_before_version_5),
-        VMSTATE_BOOL_TEST(data_in_ready, ESPState, esp_is_version_5),
+        VMSTATE_BOOL_TEST(data_ready, ESPState, esp_is_version_5),
         VMSTATE_UINT8_TEST(cmdfifo_cdb_offset, ESPState, esp_is_version_5),
         VMSTATE_FIFO8_TEST(fifo, ESPState, esp_is_version_5),
         VMSTATE_FIFO8_TEST(cmdfifo, ESPState, esp_is_version_5),
diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index 6f942864a6..1036606943 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -40,7 +40,7 @@ struct ESPState {
     uint8_t lun;
     uint32_t do_cmd;
 
-    bool data_in_ready;
+    bool data_ready;
     uint8_t ti_cmd;
     int dma_enabled;
 
-- 
2.39.2


