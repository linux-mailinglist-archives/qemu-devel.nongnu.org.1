Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 445EB82C060
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:03:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH5l-0003uQ-0b; Fri, 12 Jan 2024 07:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5i-0003hc-G8
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:54 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5f-0007Wc-Iq
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z3QBOz3FMqE2H09aqXMvaGnxq8QGkgS6Z1kIP/kLno8=; b=DyKp4bdD5eP5hDxmW4UxFP5MkZ
 +wWyFIeGJ0cWbLVpmVcj88w2GLqC6NGiyI+TmxeL+RTX9uz3Ki8YQUQCqcRBIqjBUTic22pIjKeu+
 haKgVkBA7MuwdjKHpp5GSBZ8DiUDwcbbmhsd1j3eJorhiJusHFsHajfiQ5Weli7BOCJ7/hvqF1Qqi
 eRmeIv92WMa0TETuw7Yw2Oz7ahcSaxW140oL2IkA3BQ+AS7moPsehiX25pyLw0i9oHmlYHurI9m+o
 k/bLkXDh3yVEHn+vvSU+KhSqYpKH+/HTXcyCUEqdVRCId6/O5/I/xiQ0nVhfxrV8jeNlIRPSVlUjI
 QfDk8imdi+RMFC1QeDXqihBMqF5dmSn6kcpSIeY9swVxlwJqmnR1emYyIyL84OM04oIqWg6NFsMbU
 LnoqU7ylFD6MN2XAVKf7/AnSBWDcW0CbQYGxPvZE6jpTV8PcS1O5TX0VS5m6Kc5WFNO0cmXStzFJ9
 zm9H8fKtgLbqmegMFn0G9RjLdothLpwe4cB7x5T4/6yekg+BdREK7E67gnbUfGaRL7IOkhDFZg5Kv
 mLWP73q/vLF85Bx8fNHKf2xPsozw2eRHiJmMVoIeOJW5rAzpkrnUkZXXJk6otB8wFovtUfxrafQON
 DLLbgH3yXsViR5z89ZuNrUb6YVnN3hO68j6wQ9dhM=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4m-0008jM-H8; Fri, 12 Jan 2024 12:55:56 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:25 +0000
Message-Id: <20240112125420.514425-34-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 33/88] esp.c: copy logic for do_cmd transfers from
 do_dma_pdma_cb() to esp_do_dma()
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

This is so that PDMA transfers can be performend by esp_do_dma() as well as
do_dma_pdma_cb().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 65b4baab83..14284ef54a 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -656,9 +656,18 @@ static void esp_do_dma(ESPState *s)
             fifo8_push_all(&s->cmdfifo, buf, len);
             esp_set_tc(s, esp_get_tc(s) - len);
         } else {
+            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            n = MIN(fifo8_num_free(&s->cmdfifo), n);
+            fifo8_push_all(&s->cmdfifo, buf, n);
+            esp_set_tc(s, esp_get_tc(s) - n);
+
             esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
             esp_raise_drq(s);
-            return;
+
+            /* Ensure we have received complete command after SATN and stop */
+            if (esp_get_tc(s) || fifo8_is_empty(&s->cmdfifo)) {
+                return;
+            }
         }
         trace_esp_handle_ti_cmd(cmdlen);
         s->ti_size = 0;
-- 
2.39.2


