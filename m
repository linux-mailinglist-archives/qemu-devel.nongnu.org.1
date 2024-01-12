Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1B882C072
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:05:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH4j-0000FT-Q8; Fri, 12 Jan 2024 07:55:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4d-0008Iv-74
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:55:47 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4b-0006wV-QA
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Kohj8aWe0bSl+Prntzy99RkYfDJVZ6WkKBOYa/gxkRE=; b=XR48erWfnxyYw+EFl534VLwDpU
 my0+bxsUjP1Sz0mgx4hCnsixAJy+CmkeTwc3qz94AWWqT+NeAFqpCaKyD8zoQSGJkqp8+aOn+SDF1
 fCj5PzgLsO1HqyrR0GbYCHkHGQq5tiJjTZJwqHqmted7FKkjVjIGiuaDo/9EFl8pvhOQdBboQ9LyU
 k9sAV7JD654c5puW9K7BajgopMspHJEXUGqicMDuMiiTwVY2HMhpOfxJ5GrYLh7w9khCn3BoQvznf
 i0ZL3yZdXsf08wTYxnfjKdT0/afUJmUp6tglXy7j4dP7n2qztJ+NoCj93LWPN16klVALp/cQfXYpT
 Ugcaj1nDiy/3GJ3sSBTdlcsJT3epT4vXqyCDCPuDpu75swRUljnJyLf+iImtqfg1LsRbeu7S+RtmJ
 ikjbQyug7wIgz/Gwh4m/mYBoB/1n16EQuI5PQATNsWI1MQJOWDrkfec4L9SeGbgdJH9T5ywmlifrO
 JC5gZM1b6uR1Ax516MJqpBDnT6fJyqBWsIkp90Pe2NMkW42EqiuKlxXNQHYUFweL8kujiCOHEP9UW
 jHAuLVP0OES2bdfz/SAoxrZ2D6lZHw4OD3AEB+9O6m/spVy5+THcjTtV0qkr+7mLQJJCQAHF56hKx
 J0FVptWYsPAtjaGqbDi1LCyhPyqiqwdpfLrmUBK+0=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH3n-0008jM-GG; Fri, 12 Jan 2024 12:54:59 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:08 +0000
Message-Id: <20240112125420.514425-17-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 16/88] esp.c: remove MacOS TI workaround that pads FIFO
 transfers to ESP_FIFO_SZ
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

This workaround is no longer required with the current code and so can be
removed.

[Note: whilst MacOS itself can boot correctly, removing this hack prevents
a bootable EMILE CDROM from working. This is caused by a separate bug which
will be fixed by a subsequent patch]

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 6fd5c8767a..f41b2421f9 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -772,18 +772,6 @@ static void esp_do_dma(ESPState *s)
             s->async_buf += len;
             s->async_len -= len;
             s->ti_size -= len;
-
-            /*
-             * MacOS toolbox uses a TI length of 16 bytes for all commands, so
-             * commands shorter than this must be padded accordingly
-             */
-            if (len < esp_get_tc(s) && esp_get_tc(s) <= ESP_FIFO_SZ) {
-                while (fifo8_num_used(&s->fifo) < ESP_FIFO_SZ) {
-                    esp_fifo_push(&s->fifo, 0);
-                    len++;
-                }
-            }
-
             esp_set_tc(s, esp_get_tc(s) - len);
             esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
             esp_raise_drq(s);
-- 
2.39.2


