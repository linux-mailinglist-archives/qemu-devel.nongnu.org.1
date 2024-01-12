Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CD182C05B
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:02:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH5l-0003zW-KR; Fri, 12 Jan 2024 07:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5i-0003fY-5n
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:54 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5f-0007b4-G7
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=02eQijiD/ARIh0JCjiUEsftdph0x5Z1TzAPssMWncPA=; b=r/yZxy0KEbupB5tQaC0CGWX7lv
 oY/VR5PaAmhqYr+xuL4EDbbkreTCFVWpcst71sTZtwJgZixRp+UBBZYfJ+/lPhcHw87leSOuCuyy2
 AL6KE8Kn5+GI5Q1PW2OwI7GFxuha6Cle7arHkwFQvWeTz3g/bxWEcklKlPEUaPpTlQLSXajtAMss5
 NpsExjbc/I2hyi1AzolKIM6lCA15+nxhPMOUBqq2NZQEv+DZHK02xqgyk2SOQCVHSAFpY9P6rVHKg
 st/jjMoRMlFIcOO0L11X9dufN/hX8BDASQtuJxdrt8naWeXimGYVjeV3snfafBGOASwL9wV/hpyJw
 QarwkWnlzZosL8F4w/UmF66vpc6jguze7BUaUapsnudOA2LDNvVGDtYFHe4B7/VMlwNle/o9YFwP+
 M9+wChMyWi8BEbJ7T1BO5bpQNQp7Hbgr6OScDzBmY3JPAt1R/0Yj79WpK0ItnIxTJKwjtBwPtVEBY
 VTNm1h0iP7NiLbMpea+58cHHB/6mlosJkYNp9WLYPoxAoFNvB9FSBrfhEq3M5EpxY+K1v+SfmGVyz
 4udLFCeGdUur1k61V9vps0Ethn24wtuZ59oZXOsLVWq/rvcpGdw60BcvCvE6VFaOtVMv7A2udj94d
 70iEFNuHo/L2LDGpzyNZlTT1mZKlzgwJaM80kcyo0=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4r-0008jM-B5; Fri, 12 Jan 2024 12:56:01 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:27 +0000
Message-Id: <20240112125420.514425-36-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 35/88] esp.c: move end of SCSI transfer check after TC
 adjustment in do_dma_pdma_cb()
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

Now it is possible to move the end of SCSI transfer check to after the TC
adjustment in do_dma_pdma_cb() when transferring data from the device
without triggering an assert() in the SCSI code. This brings this check in
line with all the others in esp_do_dma() and do_dma_pdma_cb().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 9647be4cc3..df4d5f8811 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -615,15 +615,6 @@ static void do_dma_pdma_cb(ESPState *s)
 
         esp_dma_ti_check(s);
     } else {
-        if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
-            /* Defer until the scsi layer has completed */
-            scsi_req_continue(s->current_req);
-            s->data_in_ready = false;
-            return;
-        }
-
-        esp_dma_ti_check(s);
-
         /* Copy device data to FIFO */
         len = MIN(s->async_len, esp_get_tc(s));
         len = MIN(len, fifo8_num_free(&s->fifo));
@@ -632,6 +623,15 @@ static void do_dma_pdma_cb(ESPState *s)
         s->async_len -= len;
         s->ti_size -= len;
         esp_set_tc(s, esp_get_tc(s) - len);
+
+        if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
+            /* Defer until the scsi layer has completed */
+            scsi_req_continue(s->current_req);
+            s->data_in_ready = false;
+            return;
+        }
+
+        esp_dma_ti_check(s);
     }
 }
 
-- 
2.39.2


