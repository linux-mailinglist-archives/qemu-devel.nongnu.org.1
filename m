Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF3679F315
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 22:46:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgWj0-0007wN-Lq; Wed, 13 Sep 2023 16:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qgWiw-0007w7-IT
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 16:44:34 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qgWir-0007NS-CQ
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 16:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DVxzxH+aMVL1Mz4gK1nPDYOSkhTi79kfdn8A6RFNfUs=; b=L5DuVP03okpisSZhps1ev3WEuh
 xeQP1M1H4vZ37ZucteHUAfSwFQ5VJbf8HX9FfSDFVmCWr2z7CM/+/mn/vijl7mYmaYmVn8eOTpIww
 JH6D2Q+8YgVmd/0sgUUhxkKCZhIPJnV8GPyEaMtiaTmzA4iDuDDD01j9pc7Sd3B/Ml2ezwXbNW+Ro
 E6SBlkynaiaPYCyM4LDvf2XRe1BDLdBrtWJHoZmnLq0L+LXbgE8Bukt2aZRLL6a6L/dP2JeCMCVXb
 h9x/LIqAdcx+nQsQqffWyaQapRdmt8jj5NUzHh6piuBgm1LNFf0wZxNgCOFFS7LZH7QHwkjZyiRv4
 pL3BrCd+PasTMuXFZPfHfJg9wBNXfTA+oOc5Pkq6EhqPgoxEbQI7C/vbi//HSQrod5/mSHLjWq4bd
 xfT28dSX1hjVWy0WTUH4pIGjt7M4thOSoDd79ecDsQvDnk2O0/9MvUVf0mzyHdi5/28tR3/ZRQZJw
 VKO8nC+a23aAa3uwi6eEYkDgOZkwXS38enckqu5J4zJEc/+04RWyUgeN74ml+WrcorRXwIdNAWbe9
 3P8GljLvDWR9vUW9OF4vLv1w3N8qbV90mBz6LFZsN0rmpgUMo44nvtBksMi7FhRl0AG4giUscAClx
 +Amx5YKzSWf+PgVHxg9JstJuCxaXPGN/UT7YJUrH8=;
Received: from [2a00:23c4:8baf:5f00:38a1:1ac:b42:501a]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qgWid-0003uU-P8; Wed, 13 Sep 2023 21:44:19 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com,
	fam@euphon.net,
	qemu-devel@nongnu.org
Date: Wed, 13 Sep 2023 21:44:08 +0100
Message-Id: <20230913204410.65650-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913204410.65650-1-mark.cave-ayland@ilande.co.uk>
References: <20230913204410.65650-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:38a1:1ac:b42:501a
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 1/3] esp: use correct type for esp_dma_enable() in
 sysbus_esp_gpio_demux()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The call to esp_dma_enable() was being made with the SYSBUS_ESP type instead of
the ESP type. This meant that when GPIO 1 was being used to trigger a DMA
request from an external DMA controller, the setting of ESPState's dma_enabled
field would clobber unknown memory whilst the dma_cb callback pointer would
typically return NULL so the DMA request would never start.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index e52188d022..4218a6a960 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1395,7 +1395,7 @@ static void sysbus_esp_gpio_demux(void *opaque, int irq, int level)
         parent_esp_reset(s, irq, level);
         break;
     case 1:
-        esp_dma_enable(opaque, irq, level);
+        esp_dma_enable(s, irq, level);
         break;
     }
 }
-- 
2.39.2


