Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1945B82C02B
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 13:56:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH3q-0007f7-E8; Fri, 12 Jan 2024 07:54:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH3j-0007dt-RH
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:54:51 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH3f-0006NO-R6
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:54:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qMKPIv7n3BpNzLL/42ApfjQFsQY3H7ShLO+eO9sIBdM=; b=c9yTH16VPIOBj9Y9EvwNH7wxwI
 8FDkNjH4pVINM5eGJI/bKiBBFaBhV/6VY9vFYLoJKawfinZ0gCQ7BW8qU4SXs05WzVW0Sxnv3P9fC
 Q/ulEWH1aaS8RfYseTXunofbn3TwGpNWdUSk3u3Iq6aM5OVWsab488w6Ixyb27n3YyrJ+1O64K3nA
 ppS1d72Ay0MgILX6E5EeFcZtXlUSi3ypAjgVnC51T3uuLlQdA/3rHEZbzD5hnvxiv79S8P8mFE+Cs
 r7wubPwX8l7k0uNNuW79o/tHYEZQiLsx+aUboC0hIjsw+nMKXSZ+HHo/YMehTAVyVPxvr7krsM304
 VD5H/rWwkM9dLqaY8scjzQtHcsm7XxSX5ZLM+Gd4jPTUwP5To7+A8NKlaBIeowtaVLNuUkb53NKli
 FZhVgd3R3drNlwXBGV4FZIv4lFMtrRrSTiJFJTY24SarHZ3cq+86WrpChBNBZqccd+iotuBZtiPZp
 UCxp4Ab2PdvX+EagxrVMnBYj8hPvxPyTHuqHT1jnKUvNCS3O8aUvkCBxTCxmmGKFdizEKdQ/j+Tat
 AzGKIWPYigVZVPaHTT68XAYhoXqquLAAHMq4naQNDSS13ComNFmQ+6qMpADhS9LRI8PBb69SRogYV
 FwkDEIodPODXkHoPsT34bsVnYPR72NQmbONq1KUOk=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH2w-0008jM-S9; Fri, 12 Jan 2024 12:54:06 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:52:54 +0000
Message-Id: <20240112125420.514425-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 02/88] esp: move existing request cancel check into
 esp_select()
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

Since get_cmd() can be called multiple times during a mixed FIFO/DMA request,
move the existing request cancel check into esp_select() which always occurs
at the start of new SCSI request.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 68d07edc05..b382865426 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -209,6 +209,11 @@ static int esp_select(ESPState *s)
     s->ti_size = 0;
     fifo8_reset(&s->fifo);
 
+    if (s->current_req) {
+        /* Started a new command before the old one finished. Cancel it. */
+        scsi_req_cancel(s->current_req);
+    }
+
     s->current_dev = scsi_device_find(&s->bus, 0, target, 0);
     if (!s->current_dev) {
         /* No such drive */
@@ -235,11 +240,6 @@ static uint32_t get_cmd(ESPState *s, uint32_t maxlen)
     uint32_t dmalen, n;
     int target;
 
-    if (s->current_req) {
-        /* Started a new command before the old one finished.  Cancel it.  */
-        scsi_req_cancel(s->current_req);
-    }
-
     target = s->wregs[ESP_WBUSID] & BUSID_DID;
     if (s->dma) {
         dmalen = MIN(esp_get_tc(s), maxlen);
-- 
2.39.2


