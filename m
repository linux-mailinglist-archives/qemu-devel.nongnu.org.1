Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB1A82C06D
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:05:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH5T-0002HV-JW; Fri, 12 Jan 2024 07:56:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5B-0001gM-W8
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:23 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH55-0007L9-5L
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=57dIgtjCjsEbnwP2zK0STdYYihbV2C8Z1lAAbvWJyhQ=; b=g64uwjbi40elvQ5OO8uuX15JXz
 ZqErI5PxPcdMPrzasAU4mjwoRcAd98LnXPbLv7L97oa2xkiodGkSqtY+jJggLhnzvyIrxT3uR1PdZ
 h8f2Gwov+rOVOTN1/w+kwydm/f+BJcWXv0BQJleA/02H1A1YOuWAChjLtL8CbAmKHG/xvQe3AoV/B
 8J/bBD+vcR0HQ6EesQyW7PQHlyaFzaMjxpymP6qW1IZGWvS+QcpEqpAsQ+dvplvfXPM3sVzzg2NFb
 roqi9qiCn0hfy2dnoPX45BupcKJawU387Idc8T3jCG4TQO/PEEOZ2wL3r5w2YTyE1zS+vVvnqSp98
 uNJ3B2Pb1HX9pYfVOHb/RglbqhNmilsid646VFOexjYQS3IwqpbHu5ZiPksSEO2GvR0yn+Of6iIXG
 Wzyc2psFSVd2DiVWO+NTpbtnNPPu1EOEH09iz9zMlr1jP0LKEGeUn/Sguv5FwB+FOM1HaWze13JeU
 e8URD4iIu+6BRY1kVqLg2kqB6AryIm5asDx1iFdUk91v1fsXflUOQNBXItX9b5lwT7jYkQ+L7Xmin
 ea4yS1CKsH6BHWhxe0Q2gYnmxTxPsy05Atuwn9nQTUfxG04vPjfMI6UFp3m9xNEzhtwPc8pN5csUS
 O/LhFaBZlbx/3w5H4R6XLz3XEQvdGbg+iXJnPIX4I=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4I-0008jM-0O; Fri, 12 Jan 2024 12:55:30 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:17 +0000
Message-Id: <20240112125420.514425-26-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 25/88] esp.c: remove unaligned adjustment in do_dma_pdma_cb()
 to device path
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

With the latest changes this condition cannot occur anymore and so the logic
can be completely removed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index ec82097a01..3db90c9ab7 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -604,15 +604,6 @@ static void do_dma_pdma_cb(ESPState *s)
         s->async_len -= n;
         s->ti_size += n;
 
-        if (n < len) {
-            /* Unaligned accesses can cause FIFO wraparound */
-            len = len - n;
-            n = esp_fifo_pop_buf(&s->fifo, s->async_buf, len);
-            s->async_buf += n;
-            s->async_len -= n;
-            s->ti_size += n;
-        }
-
         if (s->async_len == 0) {
             scsi_req_continue(s->current_req);
             return;
-- 
2.39.2


