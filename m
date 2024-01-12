Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7555282C046
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:00:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH4x-000187-4G; Fri, 12 Jan 2024 07:56:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4u-00012l-J2
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:04 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4s-0007BU-WE
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tJdK0jGFlBbCMpIBpAerVRNgezRRrjb4h7h9R1wNMF0=; b=bdBVud5GHsmWQNFsF3DPruJ0hw
 cryJzwW3MdWtiIFkXwQghc02pAeVpU4PPuzm9RSCfKe5FOBlbBQd1femb3woPifsCGodn5sg+7jnM
 deeeHjgNVfzy0XE44HcsRSZfcMmsI0c4IBs/gClPFxBF6e/OQHx+OMCQi/1aqsMnMUHmF/4H7vnXk
 LN00LDXqqulHMlyCGFhR32GRU8eddqi0L8h2EBmt75la4QWVLirHjz+aTUdEKcgIyAozf/BOGetBV
 a4rJ42qX0EL1AsS5suyANXD7qwskWavBImtJ+qeBx5BrRJtOuv2pzYdZOw3LZqR6L7wY7Nm2CFltP
 2XRr6i31F1BVj++V0UnDew1ivsDWrydR8cEa5A8sntMj9pCYG+A/c7SBPu4WBYvw9FVvIBlS+ORHv
 yZesxNhG92qUl4TKB1caefS9chOpR8SDNRrKHTo2tmte5kg81CZLzGULDo1KVoJ6WBIwCAHOPOrlN
 eSn9XDJru8sCqTFkFL+rGdYKZRMpf8trhWeVpoQSiM7gJWqFGPnqYxblHC9XZ4dcTa4ljDbLeVarw
 i5PL9iN6VKYdOwhcJA/yBXOVmhxYfsfZPxoQfGyVuS71eyTunXczKFmUL20SsIhawUyGtgXDvvWvE
 U15C0u9MzZcSyc6ZPoPJO0iZjBnzbMVzRBWk1I4CA=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH44-0008jM-Ga; Fri, 12 Jan 2024 12:55:16 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:12 +0000
Message-Id: <20240112125420.514425-21-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 20/88] esp.c: update condition for esp_dma_done() in
 esp_do_dma() from device path
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

No change to the condition itself, other than to clarify that esp_dma_done()
must be called when TC is zero.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index dc515e6435..96723efcf3 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -743,19 +743,13 @@ static void esp_do_dma(ESPState *s)
 
             if (s->async_len == 0) {
                 scsi_req_continue(s->current_req);
-                /*
-                 * If there is still data to be read from the device then
-                 * complete the DMA operation immediately.  Otherwise defer
-                 * until the scsi layer has completed.
-                 */
-                if (esp_get_tc(s) != 0) {
-                    return;
-                }
             }
 
-            /* Partially filled a scsi buffer. Complete immediately.  */
-            esp_dma_done(s);
-            esp_lower_drq(s);
+            if (esp_get_tc(s) == 0) {
+                /* Partially filled a scsi buffer. Complete immediately.  */
+                esp_dma_done(s);
+                esp_lower_drq(s);
+            }
         } else {
             /* Adjust TC for any leftover data in the FIFO */
             if (!fifo8_is_empty(&s->fifo)) {
-- 
2.39.2


