Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7F282C053
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:01:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH5k-0003sU-KT; Fri, 12 Jan 2024 07:56:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5i-0003fL-3e
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:54 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5e-0007Vt-Vf
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xY+rT1LSmlYCTSyqa1KnuN21DtTR1jjOD5PBtIyFuc4=; b=iEUSXcE+yZ6mpQwzfAkHhFxB9+
 LlM0FUf2eRJ5GZJHakcyY1/vBRo1xAr/qXUpCSSnPMSetlHi1Rx+FQF/+1ypwuZiaHASm+Ly1yYjV
 c/aY5trIxFjs6DiArlGWOVejdu+PZj4eq1Ss8ah4wSEzgBJ9SlsbjJ81MhegwhvPFA1hbs5GaZUwZ
 wjfFVy3R9Agx2dkWH7hPyBX4yO0hcGdWpuWbzkwz5ffCXLshN2anquRyx+zxOibRVRvKBwpy5pUOU
 0Y7Ut3iLHLzCchATih4RpWNL7KN35beYlR1AYMfBSRsCxlhinNJawQ3+0ykVZGnKhgqC137H8lEP5
 u2vtG0FLunXz8yAYiGnWvGST5PyWm/Z9lH4HD0XXA59UcJj82W1ouI0HYFUDpJhqdd8cIuWAEk7ya
 h/76bh7YPLjKdZk+WyWvncElF04zj2eZqYtz2j4hvI8tj018GJbHkz1D9mraEc0rHJICeFdYMQmil
 c/1qu5WaFV5MuohsNyDr1lfAadsf2HXeDx6PARGTgGUldRUNcXaVZvSNIVMelG9RJcPcFLIwma3H2
 TV0Zbt7lqE7JaOB5s/TeUHcQxPfwuUH2V8s2niixf6gFd/ai8gbE9yNajfoPLZG9nz0gv2FM6hi+5
 +mXc3l+r1YH4HKzG8jkk7zu9xpEL3BvW6S4yI/AbY=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4i-0008jM-7m; Fri, 12 Jan 2024 12:55:56 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:24 +0000
Message-Id: <20240112125420.514425-33-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 32/88] esp.c: copy PDMA logic for transfers to device from
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
 hw/scsi/esp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 14c6d05253..65b4baab83 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -640,6 +640,7 @@ static void esp_do_dma(ESPState *s)
     uint32_t len, cmdlen;
     int to_device = ((s->rregs[ESP_RSTAT] & 7) == STAT_DO);
     uint8_t buf[ESP_CMDFIFO_SZ];
+    int n;
 
     len = esp_get_tc(s);
     if (s->do_cmd) {
@@ -710,6 +711,14 @@ static void esp_do_dma(ESPState *s)
 
             esp_dma_ti_check(s);
         } else {
+            /* Copy FIFO data to device */
+            len = MIN(s->async_len, ESP_FIFO_SZ);
+            len = MIN(len, fifo8_num_used(&s->fifo));
+            n = esp_fifo_pop_buf(&s->fifo, s->async_buf, len);
+            s->async_buf += n;
+            s->async_len -= n;
+            s->ti_size += n;
+
             esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
             esp_raise_drq(s);
 
-- 
2.39.2


