Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC3F82C073
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:05:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHDl-0005UW-KU; Fri, 12 Jan 2024 08:05:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHCt-0004PJ-AW
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:04:21 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHCr-00033B-Pm
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:04:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0rMPBBScfvVeY/lAhBIKBN4+Jy5N9kgQG6GJlxR384g=; b=O1wtN+YL9BAntmtfnpUiQ8yVMI
 2eY0r+TaPm7wql3sPTE72KLlfi2kBbH+jEQO86PQgcrtpe0M2l1rzbSlJklCCOaGl13f5juLgEJk9
 reQQ0uZhQHmRCRX13zZ8JTzzSQ1jVHID2q6cOBYaZo5lydVFMNVGImbUXNUCCsSE7CbeYEPftawV/
 s3W1gfd4apfy8AWz4/GW0nmSAlqU5VzCCXPQNvtwisjq4SQid5VK4MrOsnhzCsqMhJtv2shLCsaMS
 x+X/OAeWHNag+ayc/mGCrujddBrB8CXNTbVyKsSBC8wjLalOkoNVHbtSAT4uQiC+MOrfVMBLNVf0P
 jFHE9nb9Wy0ud6OP0LVvLfokxWN0n1pqlIhw7GLuU4SAizZ47XQO5EDEVbUHJXQpP8d23ptjF7la0
 jYgsDp2GFCu4usG762dtMMaF5SIrR9OciCpkOBJuQFiLI7z9TpKGKUWAHsKdC6bcxTKeR5oe7E9lX
 77HAm41aoiiL2I09sFe8L3FoZdoz9vBDXVAmIYjM0qJo2ydzN/rRIRtnTQYImIctGKLeT8cj4EhAC
 MlwCJHTht3Maz3NAKT/om374N6EfMnOJ8NsektgJwVWpVAus8og+UgOTgzJosaBbg3vVLmza1kLtW
 0XVlQs839yW7YSIsykFJ+28GLQ6m9lXRPo/eeKLl4=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH7M-0008jM-2Q; Fri, 12 Jan 2024 12:58:40 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:54:18 +0000
Message-Id: <20240112125420.514425-87-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 86/88] esp.c: keep track of the DRQ state during DMA
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

Currently the DRQ IRQ is updated every time DMA data is sent/received which
is both inefficient and causes excessive logging of the DRQ state. Add a
new drq_state bool that only updates the DRQ IRQ if its state changes.

This commit adds the new drq_state bool to the migration state: since the
version number has already been increased earlier in the series, there is
no need to repeat it again here. The DRQ IRQ is (currently) only used for
PDMA transfers which already have a migration break in this series so
there are no problems setting its value post-load.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c         | 15 +++++++++++----
 include/hw/scsi/esp.h |  1 +
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index fb68606f00..04615d8b5f 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -62,14 +62,20 @@ static void esp_lower_irq(ESPState *s)
 
 static void esp_raise_drq(ESPState *s)
 {
-    qemu_irq_raise(s->drq_irq);
-    trace_esp_raise_drq();
+    if (!(s->drq_state)) {
+        qemu_irq_raise(s->drq_irq);
+        trace_esp_raise_drq();
+        s->drq_state = true;
+    }
 }
 
 static void esp_lower_drq(ESPState *s)
 {
-    qemu_irq_lower(s->drq_irq);
-    trace_esp_lower_drq();
+    if (s->drq_state) {
+        qemu_irq_lower(s->drq_irq);
+        trace_esp_lower_drq();
+        s->drq_state = false;
+    }
 }
 
 void esp_dma_enable(ESPState *s, int irq, int level)
@@ -1358,6 +1364,7 @@ const VMStateDescription vmstate_esp = {
         VMSTATE_UINT8_TEST(mig_ti_cmd, ESPState,
                            esp_is_between_version_5_and_6),
         VMSTATE_UINT8_TEST(lun, ESPState, esp_is_version_6),
+        VMSTATE_BOOL(drq_state, ESPState),
         VMSTATE_END_OF_LIST()
     },
 };
diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index c6e8b64e20..533d856aa3 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -26,6 +26,7 @@ struct ESPState {
     uint8_t wregs[ESP_REGS];
     qemu_irq irq;
     qemu_irq drq_irq;
+    bool drq_state;
     uint8_t chip_id;
     bool tchi_written;
     int32_t ti_size;
-- 
2.39.2


