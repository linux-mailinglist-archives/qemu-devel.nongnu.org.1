Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 885F782C0BB
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:19:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH9r-0002Y7-WE; Fri, 12 Jan 2024 08:01:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH98-0001vc-Nv
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:00:31 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH94-00019G-Ou
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aYkI1ympF2TtAe3OjgOf0aiycDwRi+cMrXqX8Pger3U=; b=HFnOoNWENgZqPtNuGCDf7ihRYy
 4vUroXSxO9pXU66sijy4IR/REJbONlvj5Zzy4bMAOakxdSA/Bp5qD4IlcyswDdSmHvtO5KWxkiNWs
 Rrd6OU8BL2LcIsWEtl7bd3Yi7nZfF03esQc8XSEbOHO1pM+wto6W50qz3PBocyb9MVJDR5CAV25e6
 5m/tPedj+8l9jubaWBmUc/+KHV/5DSrGToFIFbbhzQ55Tea3m6qYKant7eGCvJtYUvKTRkGuBqs2a
 ReAx59TKnN0HmfY3bUpBomqWXqSKfFBX3slei0gOqN1xUOVP01C4/JO2ZsreN8Isp/p13gtVZz/MK
 zCmlDtKs/yZfiGJP0BaZkZDcbUvl91DqI7F37iXPW5TKGYdnig07y/tGnHvR+4n/lPghfp5thtoau
 SfdPchal5wYD0VHCs+DUIZ6IcbwgZOJZ2djEY5Q/JIeGoPARG0+++cG9tQ2mmvBrzqujocRiF295i
 KKblM5MuP2HiCKxMvZStNOdBXaZVt2DlZ6IcMZ0iMvnNbERjaR9hMFE1jj1lEz2mv2ZH1MpYjlY05
 tsk9ef4I0q0B5pcQqkwv98gAnLJleCJ+YFrk/wnzyqNf7LgTmD7uCSDxjm/vg2TKwyrsD4zGAjB+A
 9vBO++2SwnwfP7+XIIzKQKQVCmLpX5sUrbtXWBuWM=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH6i-0008jM-EK; Fri, 12 Jan 2024 12:57:56 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:54:06 +0000
Message-Id: <20240112125420.514425-75-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 74/88] esp.c: handle non-DMA FIFO writes used to terminate DMA
 commands
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

Certain versions of MacOS send the first 5 bytes of the CDB using DMA and then
send the last byte of the CDB by writing to the FIFO. Update the non-DMA state
machine to detect the end of the CDB and execute the SCSI command using similar
logic as that which already exists for transferring the remainder of the CDB
using the ESP TI command.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index f9d848171f..aa7dec71e3 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -787,6 +787,16 @@ static void esp_do_nodma(ESPState *s)
             }
             break;
 
+        case CMD_SEL | CMD_DMA:
+        case CMD_SELATN | CMD_DMA:
+            /* Handle when DMA transfer is terminated by non-DMA FIFO write */
+            if (esp_cdb_length(s) && esp_cdb_length(s) ==
+                fifo8_num_used(&s->cmdfifo) - s->cmdfifo_cdb_offset) {
+                    /* Command has been received */
+                    do_cmd(s);
+            }
+            break;
+
         case CMD_SEL:
         case CMD_SELATN:
             /* FIFO already contain entire CDB */
-- 
2.39.2


