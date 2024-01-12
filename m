Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3912882C08A
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:08:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHBD-0004Rf-QG; Fri, 12 Jan 2024 08:02:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHAc-0003uF-66
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:01:59 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHAa-0001xz-J0
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AwCFNghRr2ccUEvp2DS9gkDztp6Uyv4u07aWmdBAAtQ=; b=m+91OkakIUxF8odvm73jfQWI9y
 Ja5q1neTgeqSWsD97I0zgcMMBfYirrC+XOInbmiqjhRESgH89V+GJWt602LPvOkepMVdM1RZg73Cj
 +y94Nf+6ZO7Nylp8lz+tQaJA6KwaIaPaKEZe5735/mCqqHqm0cJ4uMc+VINLArdstmenp2h31CieR
 Ns5ZBSuSIEd48mC1Fzqdx3R2tZ3GGw8wKQMJFBuXSSHsrKdUrk3upDfLSbXqMiWXDlO7PlzaQ4J3A
 RnmrwzH9ieOKl1IB1O//HMl67zCpWPsvIqtz/MwDAdDsBUCMfUwFGWYwUDRLRmkwroRKeMPt/niNs
 qxCsAtRAJlbhQEWPX/WDIb7gujX4T/rxUsQWvesZkLWKJhw40+rMmCxF+nCIyArFhBxCsRqFSCs5t
 rOPaAMGSjPbTLo9ubhXiMaFP9xYkpwCxflFc/vwwHt7jDLYHIwodBBqEbguNbWKfPDdRP5hNumMmX
 YZDZizVb7hCA+RwlgO7Y34PuJhU4VdNwVttN+VJejGJkECymf6lsIqcaWoIdOJ/pqJY8uXWMfo8+q
 1lce6sGli4WQ495C+5YebZvj9nzaZCZbG1S/eBRMhKJ/QK22cVVyg/gqr+1qPhuupEZejoV2GaBjF
 NPhATMxe4EiYeIEfU7UVGgzBWFbNuV5QD8NMeD8fE=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH6V-0008jM-4I; Fri, 12 Jan 2024 12:57:47 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:54:02 +0000
Message-Id: <20240112125420.514425-71-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 70/88] esp.c: ensure that STAT_INT is cleared when reading
 ESP_RINTR
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

Both esp_raise_irq() and esp_lower_irq() check the STAT_INT bit in ESP_RSTAT
to ensure that the IRQ is raised or lowered if its state changes. When reading
ESP_RINTR, esp_lower_irq() was being called *after* ESP_RSTAT had been
cleared meaning that STAT_INT was already clear, and so if STAT_INT was
asserted beforehand then the esp_lower_irq() would have no effect.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 6c62417985..604fb9235d 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1127,6 +1127,7 @@ uint64_t esp_reg_read(ESPState *s, uint32_t saddr)
          */
         val = s->rregs[ESP_RINTR];
         s->rregs[ESP_RINTR] = 0;
+        esp_lower_irq(s);
         s->rregs[ESP_RSTAT] &= ~STAT_TC;
         /*
          * According to the datasheet ESP_RSEQ should be cleared, but as the
@@ -1137,7 +1138,6 @@ uint64_t esp_reg_read(ESPState *s, uint32_t saddr)
          *
          * s->rregs[ESP_RSEQ] = SEQ_0;
          */
-        esp_lower_irq(s);
         break;
     case ESP_TCHI:
         /* Return the unique id if the value has never been written */
-- 
2.39.2


