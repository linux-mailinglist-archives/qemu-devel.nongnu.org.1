Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1EB82C08E
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:11:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHBI-00054G-SJ; Fri, 12 Jan 2024 08:02:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHAv-0004Bt-0Z
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:02:18 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHAr-000231-EL
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l3dad72Fn6EHurpGqR/Kh29ypmbUbOCNnJyUEvUbgSg=; b=lJU+afwkZ3MTfR7ViHtLEjMek2
 y82zl5j2MGVzugWXlpElwvsbKolt5rQiKtrT611kFnn2rWR/J1gf3x7/8PiYfEegqF7xLRXu2uPUx
 QLjXW7gRsFsT0/mA9LENe0J7ARppq6HstLutJH1kHkHUfSdoRM4SOakp37ro90JqJPR6KIETz7ZPP
 uxmiUfvXje4Gtgk6SdZSBpx8lRZShknW8cXdWRiULVGKZ21RPc+YgwOi1NGxwN/deb6JbEkbBShGr
 HQK+uX5SoxtfDG+QsmqP/AvuHakYyeZvE3vaAtiOsOYgBItWhcX+DF96mGnk/kkmALCBeGWAPxfSq
 BsREmx7fsEjW5LibPdZ4jA+lTMgchQeFId9i8OtyFnZ8zYzU7plRXUEmJqJSLHL54gQCerFgifc5c
 2it3P99CSiaNsJbQcSfUffqOyiZLjfHjMLD+3TMAMEdfv/OpmLvJqbRxcOzGlpIrQwTvMqhtwUyYT
 QlHO76QzIhDzTyqdrMVBxgwXS6+CMu8MG520m4WbQ+Dx9B7CK5UBB/4Nwd7oN+HYIqImP+QNzPF5r
 8Ut4MD/ar4oXOisbiBpPjxo2hF7Af/tsJIuAlmPKacY3H6vhUnYl16aSQyy2VVAGRqlKTSGnb6cmk
 v/WELbAo8Dbd3wjDK/OeISmkD+xC7SjOP+aK19MDs=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH6Z-0008jM-Dp; Fri, 12 Jan 2024 12:57:51 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:54:03 +0000
Message-Id: <20240112125420.514425-72-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 71/88] esp.c: don't clear the SCSI phase when reading ESP_RINTR
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

According to the documentation ESP_RSTAT is cleared (except the STAT_TC bit)
when ESP_RINTR is read. This should not include the SCSI bus phase bits which
are currently live from the SCSI bus, otherwise the current SCSI phase is lost
when clearing an end-of-transfer interrupt.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 604fb9235d..8ea100ee9c 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1128,7 +1128,7 @@ uint64_t esp_reg_read(ESPState *s, uint32_t saddr)
         val = s->rregs[ESP_RINTR];
         s->rregs[ESP_RINTR] = 0;
         esp_lower_irq(s);
-        s->rregs[ESP_RSTAT] &= ~STAT_TC;
+        s->rregs[ESP_RSTAT] &= STAT_TC | 7;
         /*
          * According to the datasheet ESP_RSEQ should be cleared, but as the
          * emulation currently defers information transfers to the next TI
-- 
2.39.2


