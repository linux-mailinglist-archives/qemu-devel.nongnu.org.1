Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA7782C087
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:07:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH4N-0007p2-Bx; Fri, 12 Jan 2024 07:55:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4J-0007kl-UN
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:55:28 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4I-0006sC-Dr
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lq49uNZB3MLODjuJyeTX8Ffd1tQLBuTAp1UP6rI1PfI=; b=rivqto6bA/3ZMi3PJzHDyxu9jM
 gLnJTDsLWhu7bOoawQXPyy572YkUcr2ts3SpBpFMC3XQwES1f0JSRTosnIn/EKFC6fkv8sI9YbHp2
 79/28sCW2BHJjWUm6aRpEEO69YGtL4ITAb+8jNQDSp2a8jlJgyv8B4UNJu3j4qCWEM81A/UiN9sF7
 8YcDXz0L99dKHyjgTfsJJLjtZxlJpRhsiqWbNsQ9Y1Bt9H66EovSYvPdLqhF8DC+jg7G66el/03Va
 DCd6XZ6BbbqvLEOiIpNvBX/s8hzW7+7X0mCfWs3Ij/JowqqRrMzajXgswgl35bqsu7zf1YxIdxtdh
 p51tFknKoRtgaBHPz5uAVwcPmPt07dx8FT1pOcSAx0MDySUlNy9eD72DtqUmzq8Owrwiy1yHNQgZZ
 9SVxR4n2jGMvbBHcYhkM+wJvKJPRYsljz2AL3bgrmj9e2BIdIpw4A+jh/WmfZiiMGYp2Bxf7BpBkh
 wGTFSiVm8BaN+4A9b/ERm2rXRin1jdRcdGKFwMcwd2E6V66yxXkPC4B28UnD/hF3sh32dm1gZ0/LJ
 +6MYYDYne5tFU40dbN0jR3bolHYORtXCv7x80KtpwNFHdNqLxOKRTWZqpcJ1hloT6zrCHj2utiYHS
 62ZCfxQgW9VFacW3D5Lz2cn0ALZFTJzvAh7W3WF9E=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH3e-0008jM-Cc; Fri, 12 Jan 2024 12:54:50 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:05 +0000
Message-Id: <20240112125420.514425-14-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 13/88] esp.c: decrement the TC during MESSAGE OUT and COMMAND
 phases
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

This is to ensure that STAT_TC is triggered during the right parts of the
transfer when it is controlled exclusively by the TC.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 9e9bbe8431..f08b816aba 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -259,6 +259,7 @@ static uint32_t get_cmd(ESPState *s, uint32_t maxlen)
             s->dma_memory_read(s->dma_opaque, buf, dmalen);
             dmalen = MIN(fifo8_num_free(&s->cmdfifo), dmalen);
             fifo8_push_all(&s->cmdfifo, buf, dmalen);
+            esp_set_tc(s, esp_get_tc(s) - dmalen);
         } else {
             return 0;
         }
@@ -657,6 +658,7 @@ static void esp_do_dma(ESPState *s)
             len = MIN(len, fifo8_num_free(&s->cmdfifo));
             s->dma_memory_read(s->dma_opaque, buf, len);
             fifo8_push_all(&s->cmdfifo, buf, len);
+            esp_set_tc(s, esp_get_tc(s) - len);
         } else {
             esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
             esp_raise_drq(s);
-- 
2.39.2


