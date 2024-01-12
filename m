Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C459D82C079
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:05:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH4D-0007jr-Fs; Fri, 12 Jan 2024 07:55:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4B-0007jj-M7
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:55:19 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4A-0006on-7m
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:55:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=myDJe4/tV7pbo92BZXghNd4hfgAdbUryo4MWAxqSheI=; b=wcLdOo0W/pLj2PAkvcCGV3RAMf
 NwKw76/7NLgRcvkWCOflNQjbyfuMeww8zRx0oTglVHXzFIIosIfy2QtWu73UNLtVqoGX1adSplx5H
 E55QbAXLTvqv0ONnciBtKvG0zyQZpsnfEZvYQmQDy2+Dz3m4lf9zLklDN+ceOaHNlV2RCi+EbyRYX
 Tv2TQWYjWNdzSpXFixZN/LMF3TbVO1rcIaHrQoeU+KXDdLT9AsnM/SHwvSWThwsDV3dxjfGZB0MSl
 /VpQRqF8VbK9+oK3cuUSn/3LNaCJs6LofZNQPrbT9b1EdWclsBv+sQorTOmLwdieQwpXnHfCnMQ88
 CHuB6ciAuMR2H1tjGJJA9HkDCYDcx+EEAA/W9IAPrLwcE71LHtm+U4YmlqEvcXv1jEDtBj583NjLZ
 hsigf75DU3tTJnNUbbdIZub2NfR8a7yRcmDYbhc7IcTEBUGUKUCDnHr0M9kP5gHi1plQk48egM+pC
 qT6DXVv2Y5Zq0a49uKGj97iRuezB56/6t7UKk7XtgjvKy+z/jcyYqEhvEAzqqHl69iEDgvA2OcdYI
 kfbj0IQHe27AaU3FxEgxbfUbSXL3yPXCIHDUHfWWoUxnS1j1Tt9T2sGAfR5FQzVxKFcZfopfcWWtS
 +hOwTU6R/qYzjHdLTkpvn1Lm+pkJThafsRMgGXoy4=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH3V-0008jM-PL; Fri, 12 Jan 2024 12:54:41 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:03 +0000
Message-Id: <20240112125420.514425-12-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 11/88] esp.c: remove unused case from esp_pdma_read()
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

The do_cmd variable is only set for the MESSAGE OUT and COMMAND phases i.e.
those which involve transfers from the host to the SCSI bus, and so the unused
case can be removed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 9893840255..6191c17f10 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -187,12 +187,7 @@ static uint8_t esp_pdma_read(ESPState *s)
 {
     uint8_t val;
 
-    if (s->do_cmd) {
-        val = esp_fifo_pop(&s->cmdfifo);
-    } else {
-        val = esp_fifo_pop(&s->fifo);
-    }
-
+    val = esp_fifo_pop(&s->fifo);
     return val;
 }
 
-- 
2.39.2


