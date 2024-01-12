Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 539C982C06A
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:05:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHBJ-00057t-90; Fri, 12 Jan 2024 08:02:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHAV-0003qr-DA
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:01:54 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHAS-0001rN-Tl
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DlE4PqcoYESx4Jr5i+wEaitpO9yTgimL2P1SrYBPLPg=; b=eL0yhHJrxvdWYaRu530utTzkY5
 +HuKUezhhOcITDkGZzU/9OfbGEuTbyE3+Sm2tiuHJL7pAnewOS4sCB3Dqb4TD4lNISfEX8Gyd8qXO
 Amj680GQE7BtN2f08IvfZKOmFbJvjuvvn44a0ZV/1XsO4hBPWI+9Zola4BrkxkE5mFqeqToNszV1o
 4a7bZi6Tfzrp1mIv4wMqqQfRwr12oWOT78VeOQxkqu2M6Dh3aLXpxnjebqlQqINayTb0mfYNiRupx
 MLs+pQ2jXQHESQo+LvIuNVhfLDqUMP2vrMBc/a1tQwmJFly5Swy/ZXA+YRQYSCaQOp0h6Ckc4gj+g
 qxWx+hmfEDgnjVNyVcaowYy6jCwIloo22qoVrl49DhO1t7+2thSvauqLYvtt+Hkj9TP/rY8Bm+5Zp
 +pdsGFYyp2zxnhaO6rRVj24ADOKktk3PurDbBhoYleZPyGWOlgWx4m/jzwDkK3pNjnnhB17NlgzTe
 JJTm7gQqo23TygUNSmtCWFpimM6oiJ7E/pH8P7aRIY9ZlLQpDmOcabJYTI9eYdSGwz3Zn3/MFoiKn
 VJ1JuE+x2kqjzsoZrwXNT+Yyx9IiP65+g1dKUNp8avnJ4fWuHEGuucoEDoCeta8n6Xm9olgiQ6m2l
 CGMe4H2gr/N4U/VpSX2ISyyAoyNtWG1yfR2qJ01G4=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5m-0008jM-ME; Fri, 12 Jan 2024 12:56:58 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:47 +0000
Message-Id: <20240112125420.514425-56-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 55/88] esp.c: always use esp_do_dma() in pdma_cb()
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

There is now only a single implementation contained within esp_do_dma() so
call it directly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index c6e5ddd537..bdbdb209f7 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -807,13 +807,7 @@ static void esp_do_nodma(ESPState *s)
 
 static void esp_pdma_cb(ESPState *s)
 {
-    switch (s->pdma_cb) {
-    case DO_DMA_PDMA_CB:
-        esp_do_dma(s);
-        break;
-    default:
-        g_assert_not_reached();
-    }
+    esp_do_dma(s);
 }
 
 void esp_command_complete(SCSIRequest *req, size_t resid)
-- 
2.39.2


