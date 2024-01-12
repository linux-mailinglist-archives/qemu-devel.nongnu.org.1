Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA6882C07A
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:06:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHBM-0005Vs-0o; Fri, 12 Jan 2024 08:02:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHAF-0003Ge-QU
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:01:36 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHAE-0001mN-88
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VlCGoS6t247f8EcMG8OT8xZVuVkUAlkJYCgQ8hwRDXk=; b=TAW9XbZaGsdABskLmNrnNUlSnk
 yffTLsqTwEvrM+fKFKmXa6GLi0vy1hNwLMd/5b4kF4Cps7ItEGCQ7ENIcg1XLMOPP8ivsTKgJfd9S
 7eQmXl0YKyfy9OwI0skPFC/gDtbkvPUeq2A7kU7v7KN9+ob687HkUQfvhlwqGlBjlm10iToLJ9MP2
 7lcQ8mQQTYo6/msIiXSi9TYm0SEZNhG6q8gTKHOZiIUZB/nnQZlTgL6A1BdmEc7DHbJeyLtFhgCht
 lQ415psGRnchQ7FqEu03+MsVSpr+XqYvt+WOs4sXk90MpTR5CkuYWgRS+Mgt5BTee9SZcCGZrLJ5v
 SywehM7j/998MQCQkbo0S2k2v9vRYsXQ3AcobwPQO43ubq4TknXCHaTxtbwPkYk+UbGnAiwbx8gT1
 iVanZKBPnnVxGg6Da8EI+omreBXg9ki9W3cPWbVkhyXu5IrukdGGUE+MmyY7wI/VmLThuI1uLjbtQ
 lwN3AbwNCshrr86TmWNPDFbEx9J8Bkm3U9Mr1Ql+9AchAAvXCm0wGimX7YvSmYPoJkRUB6NjV1tyr
 TXLRp1gZRHI/OyOxvzZsqDMTCfODjSGKgAyYI0XdrJu4auWfyF0nBPc109nGM+JXYqWDsbKJILgKF
 rh/b9DQeOAjdWjdBkv0zzctwVlElO7i7owigfJqes=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH78-0008jM-Hz; Fri, 12 Jan 2024 12:58:26 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:54:13 +0000
Message-Id: <20240112125420.514425-82-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 81/88] esp.c: remove redundant n variable in PDMA COMMAND phase
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

This variable can be replaced by the existing len variable.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index ae65c2ef37..8ef6d203e0 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -427,7 +427,6 @@ static void esp_do_dma(ESPState *s)
 {
     uint32_t len, cmdlen;
     uint8_t buf[ESP_CMDFIFO_SZ];
-    int n;
 
     len = esp_get_tc(s);
 
@@ -494,10 +493,9 @@ static void esp_do_dma(ESPState *s)
             fifo8_push_all(&s->cmdfifo, buf, len);
             esp_set_tc(s, esp_get_tc(s) - len);
         } else {
-            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
-            n = MIN(fifo8_num_free(&s->cmdfifo), n);
-            fifo8_push_all(&s->cmdfifo, buf, n);
-
+            len = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            len = MIN(fifo8_num_free(&s->cmdfifo), len);
+            fifo8_push_all(&s->cmdfifo, buf, len);
             esp_raise_drq(s);
         }
         trace_esp_handle_ti_cmd(cmdlen);
-- 
2.39.2


