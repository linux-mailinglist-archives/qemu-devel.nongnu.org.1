Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D403C82C082
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:06:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHDd-0004Sw-GV; Fri, 12 Jan 2024 08:05:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHCY-0004Js-HF
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:04:02 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHCW-0002uv-5b
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:03:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IRWmVN7u1WyIsFFHEiosyYaiKIebFBg95VXoAT5KMFM=; b=eoTsX7NUEdHxcm7OBvkkbJEq6A
 zTv4bIne4UIGKusBnnEEzHOMbDQMxjMdiZHTgjjeLajQ1OcuqsJx0Nf1QtktHJ1dONEyUqPNjFF9I
 8wBdMLWJuiuxfS59/7MLg22WXkveW60e/T3qRFXCxgSV5Mn/I6prbyILF+qCW2QRoT285j0JipOLf
 kIHb3JWzavyb5b3acUo9fz+bimNt0+EeW0lxfU5pbh2KzNB7iQHhTjGzLcg92uGrt0wuOHM3NC9WG
 Ib80aZb8mVFDz9pLmUpmwKiHfUo8dL+8lt70Si30oPZrbHlcuGjnB+Jppq1MqlEvEE1XNeIrs0w0V
 p3FhGXdTQthXARAifcbe/iQfZitLwXAvlXMXYOFXwTyPOWE1G/WqviQQxWG3uIA1Uz4WAF9EjZnZN
 HMCQdCIzpfPqdnHNnR44Xdf3/grVqATlcbM8+h9fGM5LeQFa6VQl7smP8tTYSgjlNrytYSVVEQve9
 a6X2s2Z/1P681cvPkZKOnhDQXy2TdtJGwgDeAZotoOqXRtLdUpqkxn4PS4K6OaDSBhiaFgpzI1Jfl
 ky30B9IpfscexogpH1l7HMsErKYEemuDQRZrWiOMlHWwUG2UxOeji4jVzHom78peNRvspAREbRhp/
 A8LSyUJuvqPQMo0Ng4YksOdzRG6ThlBx6+0gPAwNA=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH7C-0008jM-Rg; Fri, 12 Jan 2024 12:58:27 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:54:14 +0000
Message-Id: <20240112125420.514425-83-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 82/88] esp.c: consolidate DMA and PDMA logic in STATUS and
 MESSAGE IN phases
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

This allows the removal of duplicate logic shared between the two implementations.
Note that we restrict esp_raise_drq() to PDMA to help reduce the log verbosity
for normal DMA.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 8ef6d203e0..879e311bc4 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -593,12 +593,11 @@ static void esp_do_dma(ESPState *s)
 
                 if (s->dma_memory_write) {
                     s->dma_memory_write(s->dma_opaque, buf, len);
-                    esp_set_tc(s, esp_get_tc(s) - len);
                 } else {
                     fifo8_push_all(&s->fifo, buf, len);
-                    esp_set_tc(s, esp_get_tc(s) - len);
                 }
 
+                esp_set_tc(s, esp_get_tc(s) - len);
                 esp_set_phase(s, STAT_MI);
 
                 if (esp_get_tc(s) > 0) {
@@ -629,12 +628,12 @@ static void esp_do_dma(ESPState *s)
 
                 if (s->dma_memory_write) {
                     s->dma_memory_write(s->dma_opaque, buf, len);
-                    esp_set_tc(s, esp_get_tc(s) - len);
                 } else {
                     fifo8_push_all(&s->fifo, buf, len);
-                    esp_set_tc(s, esp_get_tc(s) - len);
                 }
 
+                esp_set_tc(s, esp_get_tc(s) - len);
+
                 /* Raise end of command interrupt */
                 s->rregs[ESP_RINTR] |= INTR_FC;
                 esp_raise_irq(s);
-- 
2.39.2


