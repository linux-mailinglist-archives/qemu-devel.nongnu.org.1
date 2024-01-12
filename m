Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EABF82C0B8
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:19:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH5V-0002YQ-B6; Fri, 12 Jan 2024 07:56:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5L-0001zu-JT
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:31 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5E-0007N8-IG
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0Z/RmCqKEGcQUxlqoVzURtE6xvdTuZGHnEEF2GIpMuE=; b=J4a8wIgp83GW6lrnxSkDyClNcB
 4Jku+AgCeaMHqoWCI+URBOR/8MzAfeUdeCye3i3gImFGlIdaUmUkKOo+6k8jTZbyT2PrZrX9Nuwzy
 qlL+cHjrPRn7B/+iboSFlqUqMqJAB9vMOktmBV4SgkhgrOEDCC2uhu1WOQ0qDsDOw70IraZtKvEeF
 hpiUh1r2RgBOt8/ItGGXyYPiIzjJnW8aEPgFBidovIWOKoPlJi6fmrz4MvT1hcDJMrstqdDd2/NGR
 s7E41XOSScY+WsWWrLRRhDGazFa3OexrN/Tu/vSpzvos+BlceovYd363/i+z1LP3RDKGpKhXHR8Pj
 oRZbVC+roXNmcdY3aZTF6TQNAkp3tCZxD468cJAM1UOozM4Fj10Un4FRJRTcwMH24Yr67kUVMpaWa
 N6OW3SNPlNNt42nbu9remL3JSvcgg8IjJRJH9TthQtBXq79j708OvgYS4HDeQSSkbiP+cvTijGwnb
 YwBwVYOomW+OVYu4Cq+/mANGpbKNN3TGypYJYy2DiHxKnjXksD1/9rdk+E1B1voshIU8QgZOmhCH7
 leZc2cHn/UdogVCieUSJ5F+dgirplUGyyCjK8twNtvu2uBMXOn7aPN7ojYjr6Z9zEduvLy0xZT11i
 04drDYL/dV40cF84oAixAeQVxJzwTsvPPCA3Ql6gs=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4Q-0008jM-Jv; Fri, 12 Jan 2024 12:55:38 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:19 +0000
Message-Id: <20240112125420.514425-28-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 27/88] esp.c: update end of transfer logic at the end of
 esp_transfer_data()
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

Since esp_dma_done() is called in both cases, and ti_size cannot be zero
(otherwise esp_command_complete() would have been called instead), replace
the conditional logic with a single call to esp_dma_done().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 96123c5f7d..6b0811d3ce 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -925,16 +925,10 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
      */
 
     if (s->ti_cmd == (CMD_TI | CMD_DMA)) {
-        if (dmalen) {
-            esp_do_dma(s);
-        } else if (s->ti_size <= 0) {
-            /*
-             * If this was the last part of a DMA transfer then the
-             * completion interrupt is deferred to here.
-             */
-            esp_dma_done(s);
-            esp_lower_drq(s);
-        }
+        /* When the SCSI layer returns more data, raise deferred INTR_BS */
+        esp_dma_done(s);
+
+        esp_do_dma(s);
     } else if (s->ti_cmd == CMD_TI) {
         esp_do_nodma(s);
     }
-- 
2.39.2


