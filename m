Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C053B025FA
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Jul 2025 22:52:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaKef-0003ah-VA; Fri, 11 Jul 2025 16:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uaKdt-0003Jg-ST
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 16:46:55 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uaKdp-0003ib-SC
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 16:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=2csROVQZI1m/Xv7Ap0gy16ro6mTRFLG2FbzahoL7710=; b=QWtUG62MqlO3cTpLnltApzOSPn
 ihVSS6pl6aYvySC5ucdQuSaUSkY8yfCFKaVBPlnsygLlFrO+Ui8by8FosRHkz1p+Uyfn/4Mh+v7rZ
 F1HasNtn3JiP4+x3xdSEkVmPY7RcvKLfla4z0458krzQGt7s1i+cRnuD6KdoWyOY18OPALeYZmSKG
 k0r/Vq4fCnyDB1kH1kktpDZ8VjfwecNQqW3bHN3+WBOucQGyneMLYzIe8NqldPgTKjM294PbGUXIC
 BiGQWD/gwx+/TJHP+9ITboO4NBOEhyjA3TC9EhqhTUeKSX/rvxUSx6ADssWcbYYRi/RxzVXDOIe5L
 e8MlX39FlfFW6ja7euMkydMLOyh0WKwLjqhfpqiHbzRLxJYetJ8OgcC9vnUF46s0r5V2nmvBaG7ym
 fEfhjBxswgvvKf4eCO72ofOPvxDe1B0wg5eW4UZrzjdmTp5vPUqiGh9DRBNb5gtPJWg0BKliO7djd
 CqQ8xDIUScE1Iyxu9EJ2YnmpRXcBZEGvW+9tlcPmwh4rtMO3TP28t+JiMcLN2C8paLXR74njzjS06
 7BsuC0JobfjEFXIsar3TKd56CCLPMCD1wnoQ25VKQzM9LOlTWigB9N4G9QndVQy+SrCLSS9DsDVeX
 sB/6uJ3erMxG8p7ioYr9Ah5+0Z1JW39FNlyNfP9Bc=;
Received: from [2a02:8012:2f01:0:d1ff:478a:c096:2d0c]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uaKcC-000Bmy-2V; Fri, 11 Jul 2025 21:45:04 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com,
	fam@euphon.net,
	qemu-devel@nongnu.org
Date: Fri, 11 Jul 2025 21:46:30 +0100
Message-Id: <20250711204636.542964-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250711204636.542964-1-mark.cave-ayland@ilande.co.uk>
References: <20250711204636.542964-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:d1ff:478a:c096:2d0c
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 1/7] esp.c: only raise IRQ in esp_transfer_data() for
 CMD_SEL, CMD_SELATN and CMD_TI commands
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

Clarify the logic in esp_transfer_data() to ensure that the deferred interrupt code
can only be triggered for CMD_SEL, CMD_SELATN and CMD_TI commands. This should already
be the case, but make it explicit to ensure the logic isn't triggered unexpectedly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/esp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index f24991fd16..9181c8810f 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1012,6 +1012,7 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
              */
              s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
              s->rregs[ESP_RSEQ] = SEQ_CD;
+             esp_raise_irq(s);
              break;
 
         case CMD_SELATNS | CMD_DMA:
@@ -1022,6 +1023,7 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
              */
              s->rregs[ESP_RINTR] |= INTR_BS;
              s->rregs[ESP_RSEQ] = SEQ_MO;
+             esp_raise_irq(s);
              break;
 
         case CMD_TI | CMD_DMA:
@@ -1032,10 +1034,9 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
              */
             s->rregs[ESP_CMD] = 0;
             s->rregs[ESP_RINTR] |= INTR_BS;
+            esp_raise_irq(s);
             break;
         }
-
-        esp_raise_irq(s);
     }
 
     /*
-- 
2.39.5


