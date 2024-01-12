Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E0982C0A2
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:14:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHCR-0003GI-7p; Fri, 12 Jan 2024 08:03:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHC4-00029p-KA
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:03:29 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHC2-0002YP-Jq
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:03:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NgTNrJzKu4Dc9Z+RRe6FhnpzkC+mlxVnSkgKXnGTgG0=; b=05YNDNTWfF0MSzNcxHD7u9K258
 pn2rPSXKG/FWbFbZlU+blJwv/BNia64N43EgS20F8/iHVwY8VjTqeQblp78GGpe47d851ZFEAsGKg
 6m+kX8kDcxlayylq2rSUFaiOx5nfJet5uFinDRlPw+VVDMetcIdXD0eNerwsevpvzZEbDeHkCrzP2
 EFKH2SDtSRh8M3vB7eZZTOqZWKtKhlx4AEG8hvTC0U5ZfG9GIWYr1vB5aNOqm8wXrJyJ5/jlDJHQ9
 UAQGVLDtsuBegse8zfZ1Qwvvlzkam90pv98LXGyyD/UmP4RcH4sIj8HpwtpgJ51e60KT6RGgI5xCp
 sbQH54wydAeFbQYHJOZypigZhl6Q6DqS7h1mdwUyrSkX5j4XBaZBTamZkBv4wuP/RPks4ph7d9lPG
 td/rFd5SfDjyysMwE8iQVzYfBYeBdQT4hAs9NyFl3VbctaHw29/yJD7FZCyuGlakYz5LM9qzIwVap
 C+BYbCGcaafDk7vUd79hmdkAqUjzsY1mVYlyIfoMy5ZLkjtoVlUWlc0v1nTpqYUz1wn8fKuTc3C1h
 c/QkJFnp2UHUBYIW+52MyJ3S9wYcnMsPD9Ig0KMPFvAequte9yYdVJNSzU8PyvK9xdseFiwvb1psP
 1uQRFXKunsUGRjhzkn/m5TNfuPjERAWkHIJK63/Wo=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH63-0008jM-2S; Fri, 12 Jan 2024 12:57:19 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:53 +0000
Message-Id: <20240112125420.514425-62-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 61/88] esp.c: remove DATA IN phase logic when reading from FIFO
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

Whilst the FIFO is used a storage buffer for both DMA and non-DMA requests, the
loading and unloading is managed directly issuing commands to the ESP. As a
result there is no need to manually invoke the non-DMA command handler.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index d71465718c..4c1ca63a57 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1067,17 +1067,6 @@ uint64_t esp_reg_read(ESPState *s, uint32_t saddr)
             qemu_log_mask(LOG_UNIMP, "esp: PIO data read not implemented\n");
             s->rregs[ESP_FIFO] = 0;
         } else {
-            if (esp_get_phase(s) == STAT_DI) {
-                if (s->ti_size) {
-                    esp_do_nodma(s);
-                } else {
-                    /*
-                     * The last byte of a non-DMA transfer has been read out
-                     * of the FIFO so switch to status phase
-                     */
-                    esp_set_phase(s, STAT_ST);
-                }
-            }
             s->rregs[ESP_FIFO] = esp_fifo_pop(&s->fifo);
         }
         val = s->rregs[ESP_FIFO];
-- 
2.39.2


