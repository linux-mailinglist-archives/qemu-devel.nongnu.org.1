Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4EE887E97
	for <lists+qemu-devel@lfdr.de>; Sun, 24 Mar 2024 20:18:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roTLd-0007Lw-Mt; Sun, 24 Mar 2024 15:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTLa-0007LD-QE
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:17:34 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTLZ-0005I2-Db
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yNS6TKcFy4nZ3wwXHCM0lJjPHnJGBNovuNkMRKMYhXU=; b=j4Ce55hS4CZALe6PY0u+rjTnJh
 4XmKj12E0XmTKnFwrxJaz/gfexj5C7IToZXdzxm7kW41LsR0NItHJqxAIEPa3ICHUPNAI7p6gqSVj
 yGkHohfM3radMw8tNuibfgrFJiXmLpFSSweGv+SNZ5RkbjBd///dorEOOci1gnU5YPV7Ih4ht3ppO
 PE8sdUxNquY5sc9uUI4NicuskJvfRmsX3vzGP0ndg6+1XPZkOxcJLEvCL3xHWeQ5Yz3W3f2SsTkZF
 YhAQFvpoumM7DA8IK1FwrkiYSwbpQQ/fWNjjocEpXBB1L295ea32Rk6QN+bZGCa0ONGDzsRu3CTBE
 ppvyEMg3aAQ1/05uol0Z1GXzWs0GrM43w/Agti3MsREPtf2Bem6ofxQOhCm3fZkw64dlb+hTLoJOm
 D31lsi+Uh5fWn5OiVFHN6HfQAlyT+GnU3uFwQFExAIH0mTrXfphqdEGlrqOAbdcaaHUof1kxuJUoR
 xsj0bjiy8nz+DnYRpPO2YrKGX3HJ4/tFs+/33I7x+Z6o9OZ6mWgC+Wd3Zj8Z5/IegpSRhdANTy4iI
 ywrHe2GGJOM7wiZc7si9ZBLqm8qxQzCccv44nciy6xj9brf0rbQ/CItwrupy56KWXEM7fsU8TJQV/
 BC9iI7Yrc76JfmqwDD3jR6SeKAbGfbIzFNRE05irk=;
Received: from [2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTKZ-0000dj-7P; Sun, 24 Mar 2024 19:16:35 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Sun, 24 Mar 2024 19:16:52 +0000
Message-Id: <20240324191707.623175-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
References: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 03/17] esp.c: replace esp_fifo_pop_buf() with
 esp_fifo8_pop_buf() in do_message_phase()
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

The aim is to restrict the esp_fifo_*() functions so that they only operate on
the hardware FIFO. When reading from cmdfifo in do_message_phase() use the
underlying esp_fifo8_pop_buf() function directly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index ff51145da7..9386704a58 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -325,7 +325,7 @@ static void do_message_phase(ESPState *s)
     /* Ignore extended messages for now */
     if (s->cmdfifo_cdb_offset) {
         int len = MIN(s->cmdfifo_cdb_offset, fifo8_num_used(&s->cmdfifo));
-        esp_fifo_pop_buf(&s->cmdfifo, NULL, len);
+        esp_fifo8_pop_buf(&s->cmdfifo, NULL, len);
         s->cmdfifo_cdb_offset = 0;
     }
 }
-- 
2.39.2


