Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBDA82C092
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:12:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHBL-0005TE-Bz; Fri, 12 Jan 2024 08:02:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHAN-0003hX-I3
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:01:44 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHAL-0001pb-Ow
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=isg4eqT6mpj+u8nlsxSn/JAamHZfsm6I9p691tnNUXo=; b=BFa0RnH8P07+y4L2kkLO0btmcq
 Jzs/CVJdBBk4nM88IKcHXcvCNSWb9GQ487cDQzecKko0Mp4ushY3oc1O2oCg3R+Q2ZWGkFNUPo9F4
 +dfqMykC6/I5nVUFQJ1F51o00GI/LxL2KePcNTDXMsIWXpjeZv98wvMF5/OceEYCFI4HJz6vIRu66
 gRW7Qpb/kjkDhgJ1CDTvy1W5udaakCdveMr2N9imQQ0gOurCD+gdE51eJrOnn323aMkhAas7tU1uW
 WubmOkAvA/WA5UUt8g7JdrrFXzShxl7erVTxXMm0ro9dPBfYbMeJ7X/NUCYPbozZ1VAlIlyc6flh/
 FjmL3f4TFkMJ+YDMzJ+HLIn8RwkhFShLyvWsHF1tP62NYuFwSj7+q/QDTbblQqW0O603OAX8IR3bg
 Zc98MB/StsBEII/fOxs8nzcG+PUC9qvQmrGgRhRB1HhOK3D1usTFmtiL025xM0r1vrui09p55FTQo
 /UyE/ZFvXtx7M8aljcjxNhdQcqPktFYmnMW3cEnxlyez3R093k2BbMA1x32ntUhyVS635r5o5Qtac
 0rqnNE7dKOPIMg/5NwIgyXxe8IhpT0713kF1T/aa3E/A33uHjVewRVoMlojsDJOQX8zkjL4rBBD6N
 Nkoi+eZPG/8KwzqMrPOFDXzGGaItLX/iXqFlfNMmM=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH74-0008jM-8D; Fri, 12 Jan 2024 12:58:22 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:54:12 +0000
Message-Id: <20240112125420.514425-81-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 80/88] esp.c: consolidate DMA and PDMA logic in MESSAGE OUT
 phase
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

This allows the removal of duplicate logic shared between the two implementations.
Note that we restrict esp_raise_drq() to PDMA to help reduce the log verbosity
for normal DMA.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 49fc059eaa..ae65c2ef37 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -436,17 +436,15 @@ static void esp_do_dma(ESPState *s)
         if (s->dma_memory_read) {
             len = MIN(len, fifo8_num_free(&s->cmdfifo));
             s->dma_memory_read(s->dma_opaque, buf, len);
-            fifo8_push_all(&s->cmdfifo, buf, len);
             esp_set_tc(s, esp_get_tc(s) - len);
-            s->cmdfifo_cdb_offset += len;
         } else {
-            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
-            n = MIN(fifo8_num_free(&s->cmdfifo), n);
-            fifo8_push_all(&s->cmdfifo, buf, n);
-            s->cmdfifo_cdb_offset += n;
+            len = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            len = MIN(fifo8_num_free(&s->cmdfifo), len);
+            esp_raise_drq(s);
         }
 
-        esp_raise_drq(s);
+        fifo8_push_all(&s->cmdfifo, buf, len);
+        s->cmdfifo_cdb_offset += len;
 
         switch (s->rregs[ESP_CMD]) {
         case CMD_SELATN | CMD_DMA:
-- 
2.39.2


