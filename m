Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EF882C099
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:12:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHBY-0007OC-W0; Fri, 12 Jan 2024 08:02:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHBV-00073B-58
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:02:53 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHBT-0002Bt-68
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:02:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Cmw6I4jbaWD3QpctZrYmBINWPkyQ+rF0nYeNhKu/uSM=; b=b4TNlkAjKOdgvynPGw4qbgoELD
 gkhQgOVbnK+Y4vmstc3VERCu7mkL4ZBEwmQ3urmC1t671TUaVzPaeAkax23rlNZAMw20BDO+9JNJ5
 6DwBeCXaTXWrlJnlsWdhpPdlpXPqDLJl4yBfH1hc/cyrLy/q6fuRP/UjARx5lERhVrJhotSvEfcCr
 e6aoCMFjHDu+oUANhJzdG3mlLORTczd09umBp9rg2cev1xiRNwhfH8ertr4jehf+32tF8++fPjmWI
 i71bzub7SbSvDMEEkb3Q9gkGZCj153Z1Fy3A4I4IFybGj5FbC2SZbX0IqHAIkRbT9YfsW5W89YkZM
 +CvvHcqATowGXsv9Fn5QaBpnSNbn24RCixgojlFzKZHOQOFp8rDh7clODBWjdGjeVaydHPZed/ISb
 aswF/XtJ0FdY+9eOA9O3iMfz/qy/TOut3BMWvCYERzD6qLpgTbBqUTIqHyJlzb36DKbcDPS+twcwK
 eif5WcPa02V5nWeWpxZLkR6XuPugDcbaVx3sDzj5X3jV4M3QduVv0qNHwESOVLyc20tpLiqzl/drB
 bAtFvScxBavV1cNzJI1lrv/d1jmdEOiGI3hSd5SsidswMayoxo3r8X5v6mx1QF5e82JQNpswo8XDH
 ULnGmMpCbKppVptOZeMZl/M58DlHbbwfVDpLFw6rM=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH6i-0008jM-0z; Fri, 12 Jan 2024 12:57:56 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:54:05 +0000
Message-Id: <20240112125420.514425-74-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 73/88] esp.c: remove restriction on FIFO read access when DMA
 memory routines defined
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

The latest state machines can handle mixing DMA and non-DMA FIFO access for all
SCSI phases except DATA IN and DATA OUT. For DATA IN and DATA OUT phases, the
transfer is complete when TC == 0 and the updated logic will now handle TC
underflow correctly, which makes it just about impossible to manually manipulate
the FIFO during a DMA transfer.

Remove the restriction on FIFO read access when DMA memory routines are defined
which also allows the NeXTCube machine to pass its self-test.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index a3e18bb3d7..f9d848171f 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1133,14 +1133,7 @@ uint64_t esp_reg_read(ESPState *s, uint32_t saddr)
 
     switch (saddr) {
     case ESP_FIFO:
-        if (s->dma_memory_read && s->dma_memory_write &&
-                (s->rregs[ESP_RSTAT] & STAT_PIO_MASK) == 0) {
-            /* Data out.  */
-            qemu_log_mask(LOG_UNIMP, "esp: PIO data read not implemented\n");
-            s->rregs[ESP_FIFO] = 0;
-        } else {
-            s->rregs[ESP_FIFO] = esp_fifo_pop(&s->fifo);
-        }
+        s->rregs[ESP_FIFO] = esp_fifo_pop(&s->fifo);
         val = s->rregs[ESP_FIFO];
         break;
     case ESP_RINTR:
-- 
2.39.2


