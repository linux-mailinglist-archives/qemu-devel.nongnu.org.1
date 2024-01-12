Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB7182C097
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:12:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHBH-0004nP-Aj; Fri, 12 Jan 2024 08:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHA2-00035n-Hu
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:01:25 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHA0-0001dl-S3
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lsw3BrZEe81TWsQ6pxZhqW8GrE5i0KuQpfnBI/8+sGM=; b=M8v02a4OL9jxjra6L9GOj52onj
 nXcffEeGOO0wLqR4A1uSUe0Y0Ig3sfDb35PEgURMR1fcH/OGuQBSLNPk1HiOaw/KYO/SsU5IOO06D
 g3gsTQMb2QbBl88OXszbS9kwisJYg7P0QebpMmb2OU1n7fqgxC/uYy0IIxM4zcEEGtJbgmhGXdWv8
 B7JW5DHIsRiJnf8uPSIJLB9JElgC1ylQjJvbVR9lygmeybuoWG0Hp1XUqth21NqRLF+jjOOrI1yfB
 yuI9H0VAhjMt6ObNBXkq4JW8aPcjcOebzmI3l8exK3qCbhNxF+KyxfAWf1862C2NHuBXjNnzvCP/3
 dEwy8i3YrGdorrbqPLT/Hab/KcVY9YpbFefNFGmL5hOf04EzvKioYjdeU13vX/CZLXaG12GimaOHm
 XHV1LDvhciN35Q2+rwQcg+pEsubM4DgSXwKNPWegnpkN8/cqDAiBoZEqbeDGMbAKtqGeNWn65WgqP
 v7l2Mv2apGKjFrR5Ez9o9ReVLAzgUqWITp6EW6D74+AvtmcOQuy1zNXp/O+QsJVyG5qZEZaXfGLPP
 U2/qEn712wVdRoUQ2lpWc61/axW4hx9dQlsCBkFHeutfmMeMvtoQn9EvOcKGgYIM9gga86JJkImc8
 bm3v20iLChr3IXS1F7RJEvZlrPVN81s9zIwAptTXk=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH6d-0008jM-Ne; Fri, 12 Jan 2024 12:57:55 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:54:04 +0000
Message-Id: <20240112125420.514425-73-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 72/88] esp.c: handle TC underflow for DMA SCSI requests
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

Detect the case where the guest underflows TC by requesting a DMA transfer which
is larger than the available data. If this case is detected, immediately
complete the SCSI request and handle any remaining FIFO accesses in the STATUS
phase by raising INTR_BS once the FIFO is below the threshold.

Note that handling the premature SCSI bus phase change in the case of TC
underflow fixes booting EMILE on m68k once again.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 8ea100ee9c..a3e18bb3d7 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -579,6 +579,12 @@ static void esp_do_dma(ESPState *s)
             s->async_len -= len;
             s->ti_size -= len;
 
+            if (s->async_len == 0 && s->ti_size == 0 && esp_get_tc(s)) {
+                /* If the guest underflows TC then terminate SCSI request */
+                scsi_req_continue(s->current_req);
+                return;
+            }
+
             if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
                 /* Defer until the scsi layer has completed */
                 scsi_req_continue(s->current_req);
@@ -596,6 +602,12 @@ static void esp_do_dma(ESPState *s)
             esp_set_tc(s, esp_get_tc(s) - len);
             esp_raise_drq(s);
 
+            if (s->async_len == 0 && s->ti_size == 0 && esp_get_tc(s)) {
+                /* If the guest underflows TC then terminate SCSI request */
+                scsi_req_continue(s->current_req);
+                return;
+            }
+
             if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
                 /* Defer until the scsi layer has completed */
                 scsi_req_continue(s->current_req);
@@ -630,6 +642,15 @@ static void esp_do_dma(ESPState *s)
                 }
             }
             break;
+
+        default:
+            /* Consume remaining data if the guest underflows TC */
+            if (fifo8_num_used(&s->fifo) < 2) {
+                s->rregs[ESP_RINTR] |= INTR_BS;
+                esp_raise_irq(s);
+                esp_lower_drq(s);
+            }
+            break;
         }
         break;
 
@@ -884,7 +905,9 @@ void esp_command_complete(SCSIRequest *req, size_t resid)
     esp_set_phase(s, STAT_ST);
     s->rregs[ESP_RINTR] |= INTR_BS;
     esp_raise_irq(s);
-    esp_lower_drq(s);
+
+    /* Ensure DRQ is set correctly for TC underflow or normal completion */
+    esp_dma_ti_check(s);
 
     if (s->current_req) {
         scsi_req_unref(s->current_req);
-- 
2.39.2


