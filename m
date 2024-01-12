Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8D582C0B2
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:18:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHDo-0005wU-8k; Fri, 12 Jan 2024 08:05:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHDe-00052y-Ge
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:05:07 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHDc-0003Vz-Kh
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OgDATLDCHEwFonub5prGyeLIQDXbjiADXevzh5OjrJ8=; b=Y18DuqJ5MBl8ghfORyFHxTBzSg
 tQtOxtSJ9PWsaE0UuUBMteJY1G76YrZC84ua4kWO/WWXj/fje9yAKyMZu3WsHbPBrOib2GpctcW+O
 0sA2WVxAfD86dqK9FVTB0y77NtAZ55CP5JP75rTYB8rIYfDHLl/AfsZNJrWMhmRy86tZ2GC2VG4WL
 5xtvgKl3hLWhZ0gzDrZtf8DDMjfb/SYRQZzC3eHYs1Y6RAupuiyz0NoxtchIsmlDxoPSmaixgw+md
 OgxvLPnN7xqaENFA62X+scgB7noZK8EsfhFI38BgshAwCWSqEv/4n9h3Myj0vBQUfcpfVq56JG+6A
 3oipYOqjWN03y9jdvFQv1Wy6wfCDFQjdJ647Mp+nfhgmaZFfKat6xpj8mNouciu843uWwRG94LDWc
 vCfrVKorF/J3yX3LNbkxuzTuQUh7S9Y5IgDp01hADbOWy9oqscfZd2ZD0L3LrOc2ZddZD/Ch7pMSC
 j2QP1tJJS3C8waVyg8S1GJWGi0ZuJl4t54cZrJYDFOpUg4R2D6BhUC/tLzct5La6WAhbF964z+nSF
 Sla5xiAq+rGYixS9lti20ERWfUun3WtmyWuNEFRdST3ArKuDfC1vezTb4YHtZ6aJFba0TmIyhBVm5
 Af1WA6xwqdB3XunTIq1em8Cff/Lu90Z5/o7ylnWew=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH7L-0008jM-Lf; Fri, 12 Jan 2024 12:58:35 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:54:17 +0000
Message-Id: <20240112125420.514425-86-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 85/88] esp.c: rename irq_data IRQ to drq_irq
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

The IRQ represented by irq_data is actually the DRQ (DMA request) line so rename
it accordingly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c         | 8 ++++----
 include/hw/scsi/esp.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 5583b3eb56..fb68606f00 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -62,13 +62,13 @@ static void esp_lower_irq(ESPState *s)
 
 static void esp_raise_drq(ESPState *s)
 {
-    qemu_irq_raise(s->irq_data);
+    qemu_irq_raise(s->drq_irq);
     trace_esp_raise_drq();
 }
 
 static void esp_lower_drq(ESPState *s)
 {
-    qemu_irq_lower(s->irq_data);
+    qemu_irq_lower(s->drq_irq);
     trace_esp_lower_drq();
 }
 
@@ -1062,7 +1062,7 @@ void esp_hard_reset(ESPState *s)
 static void esp_soft_reset(ESPState *s)
 {
     qemu_irq_lower(s->irq);
-    qemu_irq_lower(s->irq_data);
+    qemu_irq_lower(s->drq_irq);
     esp_hard_reset(s);
 }
 
@@ -1489,7 +1489,7 @@ static void sysbus_esp_realize(DeviceState *dev, Error **errp)
     }
 
     sysbus_init_irq(sbd, &s->irq);
-    sysbus_init_irq(sbd, &s->irq_data);
+    sysbus_init_irq(sbd, &s->drq_irq);
     assert(sysbus->it_shift != -1);
 
     s->chip_id = TCHI_FAS100A;
diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index 39b416f538..c6e8b64e20 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -25,7 +25,7 @@ struct ESPState {
     uint8_t rregs[ESP_REGS];
     uint8_t wregs[ESP_REGS];
     qemu_irq irq;
-    qemu_irq irq_data;
+    qemu_irq drq_irq;
     uint8_t chip_id;
     bool tchi_written;
     int32_t ti_size;
-- 
2.39.2


