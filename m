Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FC582C033
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 13:57:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH5i-0003dO-Q6; Fri, 12 Jan 2024 07:56:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5g-0003T9-F4
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:52 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5e-0007aY-Od
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q/AdNcGn3vCK1TaCYWE81JK3tzPwF4guPaAP74tcRoE=; b=BWZDlSFcnVyJVpCrWHOOCQ9Dui
 kIECxxaJPH24cd6Ocioo3agZ0V9OdNgVzg2juzEKLHF/LTNazO1NjqAK5Ats75mDvzXWo5Rcjwn4y
 6Xm3TgRLjBByyO9PRuE5E/dudyMpBNG5e7YlJqw268H+YDTZ2YRUaqms11gfuReLc+l0GKVoXTFxG
 EtQsMEROR/EATSEfcIvpJA6aIk0WPZUvV1hO/R6zOgPD7MN0K3IfJLTtJO3SczvYs9Zpe7UkR0wYA
 aPYodgJrUjQTn5UcDX0XDVBuOgDYssGoIVoa3k8HaqXmAOCVL9zSdbxbNAbO7MTG9FZBwR7n23hyH
 9WulcaKJiJf8Uqda0bInUm1JKXpxmXtOQ2IaGXkZfvJi7iSM/l2ffrYx8m3zTC8sOMLPz0bQbiVwS
 RdG+PnpdlCzlcZRTV/m6EKEQrVov9n2swS7+8UresQDbb+8OXbeJBnA7viJL13sra8iCcZ28Qehv+
 gqO9fXS+FMxpxrZuKEs+cc9YGZbgmteKSTfRS+huOEHIhkZepjJJJ4yBp5CQw9phBHg/hU6cS209M
 HX+rLrbAIrUOA676m4s3dsTITO3yz4ZOsllNHTaKDk1qmX7PvhEbKlLLQZPSKIo6qWeA38LVJ9HnC
 Ujdbv7CR8jBnK5DHTDvQXSDr8hgg7c7sfuw37+18E=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4m-0008jM-UV; Fri, 12 Jan 2024 12:56:01 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:26 +0000
Message-Id: <20240112125420.514425-35-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 34/88] esp.c: update esp_do_dma() bypass if async_len is zero
 to include non-zero transfer check
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

In the PDMA case the last transfer from the device to the FIFO has occurred
(async_len is zero) but esp_do_dma() is still being called to drain the
remaining FIFO contents.

The additional non-zero transfer check ensures that we still defer the SCSI
layer in the case where we are waiting for data for a TI command or a DMA
enable signal.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 14284ef54a..9647be4cc3 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -696,7 +696,7 @@ static void esp_do_dma(ESPState *s)
     if (!s->current_req) {
         return;
     }
-    if (s->async_len == 0) {
+    if (s->async_len == 0 && esp_get_tc(s) && s->ti_size) {
         /* Defer until data is available.  */
         return;
     }
-- 
2.39.2


