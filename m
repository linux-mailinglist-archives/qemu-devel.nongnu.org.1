Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B637482C042
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 13:59:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH5L-0001Zh-VA; Fri, 12 Jan 2024 07:56:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH52-0001O3-Ib
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:13 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4x-0007FS-6I
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2z0FKqMn6UPzV+I5UHN9RM5PK+3b5SwEo7FgjWvykkc=; b=xjQUuV6/jHNMOzeDUhhADqFO+D
 9X5wf1gLr04ixkdgk7SD/iFV2FBS9Lje6/B/5A0ExKmsK4ZIzgJ60W1b3/cVLCjrjlTFP2D9tnybR
 RMzNs45Mpqw9Tw7cHP0lRdPLI6vsmzWGa35XElWdNevLt9bD9hKRB1QJfKi+wkWannzqVv71SJnJm
 4BG66koevy+yyxRbb2J045JJZdOKBPA6vbuM41Jb/QoDX4U0ZsWOR9h3kvPiviwkeDboAE3NeAjU1
 lFggiOi4E5JZmamTvmlR2D4KM1Vl2/Pyy2lpEVQVJsxXlH9PFj7DBLzjF6NcXZisOx+5R7vqWVqK6
 PbtvUxv6RdntYh8Ty5UKxRVHvgv6stEn03DVJv8yClUY7IJtnCYbC+wOpgHNTgTN+XF9r5oGFPYHX
 gcoNNQ1u7iuv+zrN1fA+YZQvzEDR4gAg9px4zJXpnaPKvYkBDQ0hk16q4Snxf4uqqcFkpIrBuKQzJ
 yYK8y8/b11vI6V7jG/JIBkQ2qsQ12zKgyDNDTJ+vwAL5oU4eUmI434aioSN06H5qxCahlwW9jCR4W
 sRbtHvMg3ftODaqmg4cBJXNNPSND0QCN48ttKFrMqDcG07kZZsTXUntBhoQBETswA3F/79onOYfcs
 GbZsIDTibr55v0fkbPpw3TqCOXSI2kIxrtHdihaLQ=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH48-0008jM-Pe; Fri, 12 Jan 2024 12:55:20 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:13 +0000
Message-Id: <20240112125420.514425-22-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 21/88] esp.c: update condition for esp_dma_done() in
 esp_do_dma() to device path
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

Ensure that esp_dma_done() is only called when TC is zero, which is currently
always the case for DMA transfers.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 96723efcf3..06be9f2e74 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -725,9 +725,11 @@ static void esp_do_dma(ESPState *s)
                 return;
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
             esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
             esp_raise_drq(s);
-- 
2.39.2


