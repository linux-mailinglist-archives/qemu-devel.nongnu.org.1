Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0BC82C064
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:03:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH5U-0002RS-IS; Fri, 12 Jan 2024 07:56:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5F-0001kA-Rz
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:30 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5C-0007MZ-Bp
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=noBEM1vgwgC3/a8GeQ1iSWp0MNpWGitlTAL7oRoptXo=; b=bwGurSf+FsNEBj9ywkbYaaozjs
 MT+rw8oh/5GylGhJDA2Wybvt5Y0QYYfSk19RPfDrXBdcHZqWSs3HssZ9fN2uyUlQGb1yLXtU8w4Qx
 a/j51E04Xjrdeq+EkttzoryF7VHUjBt/HMveXFkRQkJO7wgZ7bO/zbWV2rWpqov8HUvMkx7rt+QtH
 QrCgy5cTmGz32Hvz6ljCXylkL33BDGj95n1fgbn1AupTkhdnNAKS4GBXo5KoffyZYSPz0PNn/mA5s
 MFW3B19kiec4m1662vr0aosZXlBtkl1g/jB1u3sScXritNQZ0bh+zBcr0s9JeyQaokGu4L66ALTnu
 yEVDu9D3rf7xiucCpY8YMO0myXJu40M2Qd6FACu29zhQzofCqpg2uTsSWyHO0O1cuPuxbgkwet/jd
 WcnOUFSX1AHj9E/q7HplvNu25iw1B69downCjvD9MbSAL/NnI7wiqNNdIfu0i+6YW8GkApO0spdyK
 p2RNc+DDdCZj675YlcIefUwxR8t3aqAXK7qJhIuCViNIrAsXvH8o1UXS8k+Bqw6JSA9qofn+bOJ8u
 ZWrZ0C5eKsDrbDEzRa6O9EGPlYC1jELc66IkHIrrlSIgZvclgZiLsmd4+KxdQihWVClu4tgCaeHc7
 5pbyGlnOmoKPejRUhncF96eo9oZqvni5lv861sDZM=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4M-0008jM-AH; Fri, 12 Jan 2024 12:55:34 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:18 +0000
Message-Id: <20240112125420.514425-27-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 26/88] esp.c: remove unneeded if() check in esp_transfer_data()
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

The following ti_cmd checks ensure that only DMA and non-DMA TI commmands will
can call into the esp_do_dma() and esp_do_nodma() callbacks.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 3db90c9ab7..96123c5f7d 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -916,16 +916,13 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
         esp_raise_irq(s);
     }
 
-    if (s->ti_cmd == 0) {
-        /*
-         * Always perform the initial transfer upon reception of the next TI
-         * command to ensure the DMA/non-DMA status of the command is correct.
-         * It is not possible to use s->dma directly in the section below as
-         * some OSs send non-DMA NOP commands after a DMA transfer. Hence if the
-         * async data transfer is delayed then s->dma is set incorrectly.
-         */
-        return;
-    }
+    /*
+     * Always perform the initial transfer upon reception of the next TI
+     * command to ensure the DMA/non-DMA status of the command is correct.
+     * It is not possible to use s->dma directly in the section below as
+     * some OSs send non-DMA NOP commands after a DMA transfer. Hence if the
+     * async data transfer is delayed then s->dma is set incorrectly.
+     */
 
     if (s->ti_cmd == (CMD_TI | CMD_DMA)) {
         if (dmalen) {
-- 
2.39.2


