Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C5B82C057
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:02:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH5S-00025K-HZ; Fri, 12 Jan 2024 07:56:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH59-0001UF-BF
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:19 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH51-0007Iv-5j
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Qab9peJFZQHq4g0ah/0J+qGpM5fA/VyNtmbY/bhz/FQ=; b=TwuqYR9q5G6e+TdGXshy9h5lBB
 BMjlxefMNnUZObQuEEpRgVFZhdWysrlZMnjr19y/LfMyVvXBbu4vE0ugVrm5WHcWOcQQBk1bPoOhc
 260t3hng9yEhpCzNM1wzWpOe043qtRlJf7UcUXKuNXw8n8hDnI6lUbeBXUbYElNy0qmWPMZo4Vzl9
 gPx0PafasG1jDT/nWPWC+0Np+JCiugEbZyU+uOTsDWHHC/KslrTq3SeKF3NgOfcqxWfEIlryYgFGj
 upodAj7Qo4DuoWjAXNonvioxBJh6MQp9TLVHGHBwJ1FT1V7/kaNYIKH/FJlpatApQa7P//trnNxjy
 QecmtcrtjbHDc3AxoHCTYORJv48ykUakmcoKgK4xOBOI57tb/CrUCdbYa1J3Dxc18RjaJNHF/AKCL
 dS3+zxsqG/M2/3AHEummXG0PkBvev9RjLQvv7BkbgS6eDPgLN/JoMZ8EStegd+UKLAmjfSvg4N9iR
 2MLjj7wrdwvNO6+9bl3H1DDShIfFQPfJlla9wgU7+Wj069zwztPFpZyj23Hd+bI1C+vxXC6CGB5lx
 q5YaQ497D9SRcE/AtdcgSBt5ylhmBgRI2bEu3jLxqLFFtlkx3auCcAkJkM9BcXq1uAYoE2//2hWIj
 uvX+I0nmgCZrhpOaY1oCGxpYXXppfSKSqorxmN7Vw=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4D-0008jM-3B; Fri, 12 Jan 2024 12:55:25 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:14 +0000
Message-Id: <20240112125420.514425-23-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 22/88] esp.c: ensure that the PDMA callback is called for
 every device read
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

Rather than wait for the FIFO to fill up before calling the PDMA callback, push
that logic directly into the from_device logic in do_dma_pdma_cb().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 06be9f2e74..d80a38daa0 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -625,14 +625,14 @@ static void do_dma_pdma_cb(ESPState *s)
 
         return;
     } else {
-        if (s->async_len == 0) {
+        if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
             /* Defer until the scsi layer has completed */
             scsi_req_continue(s->current_req);
             s->data_in_ready = false;
             return;
         }
 
-        if (esp_get_tc(s) == 0) {
+        if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
             esp_lower_drq(s);
             esp_dma_done(s);
         }
@@ -1419,9 +1419,7 @@ static uint64_t sysbus_esp_pdma_read(void *opaque, hwaddr addr,
         val = (val << 8) | esp_pdma_read(s);
         break;
     }
-    if (fifo8_num_used(&s->fifo) < 2) {
-        esp_pdma_cb(s);
-    }
+    esp_pdma_cb(s);
     return val;
 }
 
-- 
2.39.2


