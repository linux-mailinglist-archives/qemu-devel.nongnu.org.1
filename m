Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F14D182C093
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:12:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH3s-0007fW-7T; Fri, 12 Jan 2024 07:55:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH3j-0007du-S7
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:54:52 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH3e-0006NL-Mb
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:54:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mJYQo4Js1hKOdK9+l8fMHg//y3I8p0o7rNQUv17cCXk=; b=J/wm6EHaK3w83H1FMSuh4uOWbR
 rSWApUDgZgyYiHwTPlcI+dYWRuCth3mWsds7RaRJxl3F6BW+INBZFETRsBBMsGAQtYqU35uRdr867
 f9BKFRxUu9G65IYSTjJbPovg+QPBXds5W3wJZ6SHWsZv2yyVxW/8NPDcekeCk19JpJziC84jRIKz9
 luj8hc9zBcODB33yWWQleezCvX2K8dU4v4V5Af+PTXh8kuE03ZdFi6LkkDyUhviyKsaC8lxzPDFO4
 QUDC11LrST0MhT4TTMrM2F0gnifwNN64QM514pPuj1smExy6/mnxnt3NbL9/te36iq8WoYle9KeWs
 wW1WhWBl7Izr+WxoRCoOWUGaf+vO+RX6mcPoZFDZ+SCBeRnrTR5LvEllfV2e72Padph4xFOlVSmN/
 0+Q5M19dUwcawpcVvc9YoObz0msP8Si/6vomwK9v0SC/e/ckF3wu5hBoHeOB1Wyr9sFUn/Q1JX6oK
 yBXVk5bYUTaqBWGiZDOpWOpekG8y5Nm2XE7mQLR9pmUf92gqD7/bh9BbAq2pXvE4Tn877X2F0bfSK
 JwBkzINak0+PSqWrMuwClm+9M/8a7oe9/Y4iChw7pjENaMNZ8IbYgmHcpaOPNwxtj+1GhUfKCKge6
 2n4URuIEP2jzIEgxdGsa3SNh869vzoX99lE9CsTOQ=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH2s-0008jM-IE; Fri, 12 Jan 2024 12:54:02 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:52:53 +0000
Message-Id: <20240112125420.514425-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 01/88] esp: don't clear cmdfifo when esp_select() fails in
 get_cmd()
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

The FIFO contents should not be affected if the target selection fails.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 3a1c9f7c3b..68d07edc05 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -252,11 +252,9 @@ static uint32_t get_cmd(ESPState *s, uint32_t maxlen)
             fifo8_push_all(&s->cmdfifo, buf, dmalen);
         } else {
             if (esp_select(s) < 0) {
-                fifo8_reset(&s->cmdfifo);
                 return -1;
             }
             esp_raise_drq(s);
-            fifo8_reset(&s->cmdfifo);
             return 0;
         }
     } else {
@@ -271,7 +269,6 @@ static uint32_t get_cmd(ESPState *s, uint32_t maxlen)
     trace_esp_get_cmd(dmalen, target);
 
     if (esp_select(s) < 0) {
-        fifo8_reset(&s->cmdfifo);
         return -1;
     }
     return dmalen;
-- 
2.39.2


