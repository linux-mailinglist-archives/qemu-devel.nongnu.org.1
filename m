Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F5582C05E
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:03:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH5S-00023N-EN; Fri, 12 Jan 2024 07:56:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH59-0001UH-BF
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:19 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH52-0007K2-9l
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jrNWwJPR310x2+wDGr3cs+8zpWtPvEByRAcrfFXS/EM=; b=g4ZnqS4AX7Y+zAk3BeZBrJ6pRI
 KbfB1VJLwe41UJSIO07CEitqtmokrsN1uhP4NhsX8Rl7nmt2V8UjpUCR/u9Ogx/w1fCqxsn8q9hjJ
 /rKJeBRn1VBciOmm4GNiEnyxRtXSF0Kd+ktjimLZhYMADTrujzjltDF8PCiv0inGZiHntYLia3k0c
 d58gHO6p3wpvV6sFGFsAgm83/+WV1eAJFJU+vYiwqvHKEBqxOCPD8h5PLDinpoEH510OBheP76mhm
 7nz9/yZHnV5uZZ9oIxscA6CfI1SQfeOz0JiV8etjtr43kx8A8CmMyzPTnO4z2we5RiQqUtEtt7N2S
 frkXqwixB+6f1NObPkserhH48ilgGSfDOR8/JkC3RCerSFE9vwNimDB4Oe7fmBO1jZRRINxewCwSh
 noRMF++72p5WByrnb71+sARNFImSWTtybgj3TvZ7eOfYxwYvE6qpbK+bQVCmicpmNyVwGqJ+qzPXO
 2kJ8EJUKw71YMPRQalFmEUHXA8ZjFtl30cOgk205d7k00y4PrvZJrHPKugr6KeLRszTLINaJfrdX+
 XGTrJBwbWwZClpUqqt8a+IXEOL64X90P+wP/P7jNStBG00+AMP09lFsVyG4eQBcVYEzjzHm0fzU2A
 D5ojO1PgXWI+TJviITv1xHECzIcdA1YKKLRUiP6ts=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4H-0008jM-Mp; Fri, 12 Jan 2024 12:55:25 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:16 +0000
Message-Id: <20240112125420.514425-25-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 24/88] esp.c: remove TC adjustment in esp_do_dma() from device
 path
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

Now that the TC is updated for each PDMA access (rather than once the FIFO is
full) there is no need to adjust the TC at start of each DMA transfer if the
FIFO is not empty.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 1f9902aec0..ec82097a01 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -754,11 +754,6 @@ static void esp_do_dma(ESPState *s)
                 esp_lower_drq(s);
             }
         } else {
-            /* Adjust TC for any leftover data in the FIFO */
-            if (!fifo8_is_empty(&s->fifo)) {
-                esp_set_tc(s, esp_get_tc(s) - fifo8_num_used(&s->fifo));
-            }
-
             /* Copy device data to FIFO */
             len = MIN(len, fifo8_num_free(&s->fifo));
             fifo8_push_all(&s->fifo, s->async_buf, len);
-- 
2.39.2


