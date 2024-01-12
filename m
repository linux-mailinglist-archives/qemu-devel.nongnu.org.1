Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4458782C058
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:02:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH5m-00045s-Sj; Fri, 12 Jan 2024 07:56:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5j-0003pc-F8
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:55 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5g-0007e5-HB
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pWhbAo1KuskGcxzVSqb6P67HV9y1ZJu+Eye91KL2wmE=; b=TGGXW08pKV6gqh4xRDvxJQ+pKm
 Z9X/123MvNe/iuBGhg2cwMaQUNDT8GKTA8ZpnI1/jUi4SOBrSqu49hRsZeInpXvzG/S/wcp27Xdsr
 WJGACrGCfOOj8zszZLYT4kY7ahTlBgtrH2ghYv3beT6APkaMFYTSM+xpJVEkCjxfgd/llRenZrK+F
 Hy/WGr1t3tXAkjXray7ONBDTtrUxGcpIrTGqO611PpZ0ZsZMxQlb46316Xke4axuZliGVbdz1ABj8
 ixiV1iu+YSyE+R0TVDzhA5Uy7Q2o2ANg7GtsRT99MNf2ddLhZN1ZrwgmVqep6sg1YuMdMQFEg9q1m
 moepfnwxbYZZqrMP2bzZmeQ67pLycmpRNkF6Z4yXWk9T/ODTcfB/4jf7zTAMcN3HeFiVbC86RECk5
 bomXsmubyrPPbYOJ4+jtuIPQ1UzSnH94AfVN/NfQ/ou16hq2Lq0BDkeJknQbenHSwLXVqnaIIq+OO
 IRsWU5BYDnWtNner3uioh0SqyAX5hmCWQ+4Bx7RoVa+OYubHgLNgbgDdqIRKxBBl1SdKgmQfXJgX7
 OqwUXEo7P9STNcXmnKMJLsftXG3HiNqVxwUqAykb8+v+Qw2yJBVh+F/nWIznuIs972JNgbAu0eMAP
 tSSphru5vDjwHYWBhtk2kxfodY0KVrJCrtgNgn0aw=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4s-0008jM-2O; Fri, 12 Jan 2024 12:56:06 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:28 +0000
Message-Id: <20240112125420.514425-37-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 36/88] esp.c: remove s_without_satn_pdma_cb() PDMA callback
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

This can now be handled by the existing do_dma_pdma_cb() function.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c         | 22 +---------------------
 include/hw/scsi/esp.h |  1 -
 2 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index df4d5f8811..16cb6c72fd 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -408,23 +408,6 @@ static void handle_satn(ESPState *s)
     }
 }
 
-static void s_without_satn_pdma_cb(ESPState *s)
-{
-    uint8_t buf[ESP_FIFO_SZ];
-    int n;
-
-    /* Copy FIFO into cmdfifo */
-    n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
-    n = MIN(fifo8_num_free(&s->cmdfifo), n);
-    fifo8_push_all(&s->cmdfifo, buf, n);
-
-    if (!esp_get_tc(s) && !fifo8_is_empty(&s->cmdfifo)) {
-        s->cmdfifo_cdb_offset = 0;
-        s->do_cmd = 0;
-        do_cmd(s);
-    }
-}
-
 static void handle_s_without_atn(ESPState *s)
 {
     int32_t cmdlen;
@@ -433,7 +416,7 @@ static void handle_s_without_atn(ESPState *s)
         s->dma_cb = handle_s_without_atn;
         return;
     }
-    esp_set_pdma_cb(s, S_WITHOUT_SATN_PDMA_CB);
+    esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
     if (esp_select(s) < 0) {
         return;
     }
@@ -856,9 +839,6 @@ static void esp_pdma_cb(ESPState *s)
     case SATN_PDMA_CB:
         satn_pdma_cb(s);
         break;
-    case S_WITHOUT_SATN_PDMA_CB:
-        s_without_satn_pdma_cb(s);
-        break;
     case SATN_STOP_PDMA_CB:
         satn_stop_pdma_cb(s);
         break;
diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index 13b17496f8..b727181da9 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -153,7 +153,6 @@ struct SysBusESPState {
 /* PDMA callbacks */
 enum pdma_cb {
     SATN_PDMA_CB = 0,
-    S_WITHOUT_SATN_PDMA_CB = 1,
     SATN_STOP_PDMA_CB = 2,
     WRITE_RESPONSE_PDMA_CB = 3,
     DO_DMA_PDMA_CB = 4
-- 
2.39.2


