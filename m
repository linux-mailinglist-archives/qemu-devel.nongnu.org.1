Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6726887E9A
	for <lists+qemu-devel@lfdr.de>; Sun, 24 Mar 2024 20:19:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roTMH-0007ti-MC; Sun, 24 Mar 2024 15:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTME-0007sj-UC
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:18:14 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTMC-0005My-Hw
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Qq2xVPmXrv8SIN3YP2xiQ0x8a5PjJLotBVF2qHiVoY0=; b=1d+dagTHFENFkjw9jHeYwETC4L
 OtKAxyuQHL+iZkmfHBIOVS5V2vY5tzX4Yr/2ud9A6o6qFmfHWhajdX0wp/VPe/2kIxrzlFW29VTw/
 Zl7YBj5JUl4NxvTIdSjMh8UmNkcamwx5psVKI2J6std7AlJnxASowRfNXuNet0Ki4Tb1n1o/A94WN
 FEG1mg+14b57lUEYvjJoXRjOVS9f7lajbt4bmx31k7rEvteSJPJsk/2xAdqyzWTBvBM9r2CH3oGvI
 g5xeDMhSmkAHUU9nJuAp9ApUcTsoRG3P0ZyS7wC1vow43z4N/Gf5da9ewuFCgrH4AwKpUYNwW4RW0
 HdT7FvtJreIXIPM+SI15zc629nzlKQTB6VkZ968qoQXE1Yb3BAjYWhV1bddVC6++GOZVbaBk+F4nj
 9ZJkELfF5DBfxUgaCjkdNnXIaipgAsZXV2/vaGX1fEy/4JrOjG6v26WyenuscF6xddeX1yEJRot9N
 4gScv/NZ6o45fpc8SqzwXc8QuGIh6u/3H8cI+Twc16QMnamev5UhjJRhKiKVjSTEUcKZUj3zhg9t4
 dmIWsKnexPfJY8EutTn2O3Hoe40oXS9f2mq8gU1m09fqmhHIGS1RtlrOOO3LIFgewEZsgtEXDF+Sg
 lRLuAAvqZkariRX1HMIY3tVOVl9IlRlggS1mUHiLs=;
Received: from [2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTLD-0000dj-Qa; Sun, 24 Mar 2024 19:17:15 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Sun, 24 Mar 2024 19:17:02 +0000
Message-Id: <20240324191707.623175-14-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
References: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 13/17] esp.c: move esp_set_phase() and esp_get_phase()
 towards the beginning of the file
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This allows these functions to be used earlier in the file without needing a
separate forward declaration.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/esp.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index d8db33b921..9e35c00927 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -79,6 +79,24 @@ static void esp_lower_drq(ESPState *s)
     }
 }
 
+static const char *esp_phase_names[8] = {
+    "DATA OUT", "DATA IN", "COMMAND", "STATUS",
+    "(reserved)", "(reserved)", "MESSAGE OUT", "MESSAGE IN"
+};
+
+static void esp_set_phase(ESPState *s, uint8_t phase)
+{
+    s->rregs[ESP_RSTAT] &= ~7;
+    s->rregs[ESP_RSTAT] |= phase;
+
+    trace_esp_set_phase(esp_phase_names[phase]);
+}
+
+static uint8_t esp_get_phase(ESPState *s)
+{
+    return s->rregs[ESP_RSTAT] & 7;
+}
+
 void esp_dma_enable(ESPState *s, int irq, int level)
 {
     if (level) {
@@ -200,24 +218,6 @@ static uint32_t esp_get_stc(ESPState *s)
     return dmalen;
 }
 
-static const char *esp_phase_names[8] = {
-    "DATA OUT", "DATA IN", "COMMAND", "STATUS",
-    "(reserved)", "(reserved)", "MESSAGE OUT", "MESSAGE IN"
-};
-
-static void esp_set_phase(ESPState *s, uint8_t phase)
-{
-    s->rregs[ESP_RSTAT] &= ~7;
-    s->rregs[ESP_RSTAT] |= phase;
-
-    trace_esp_set_phase(esp_phase_names[phase]);
-}
-
-static uint8_t esp_get_phase(ESPState *s)
-{
-    return s->rregs[ESP_RSTAT] & 7;
-}
-
 static uint8_t esp_pdma_read(ESPState *s)
 {
     uint8_t val;
-- 
2.39.2


