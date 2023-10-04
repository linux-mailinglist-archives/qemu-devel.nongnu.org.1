Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F3C7B7A50
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:40:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxPj-0005Cn-7T; Wed, 04 Oct 2023 04:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnxPg-0005CN-V6
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:39:25 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnxPc-0007jy-A6
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wj1kRK2UFSUTjJkP3sSSNCXThjQ7dL0dyJS9XEJSezI=; b=XRRQqZPEkI/Rm4GW52k03i7BXL
 eiIWir5CePRsVXlGVl0HKuCoMTaSSYwPqqVuDh5VoUoc657FVzu9P/SHYKznABWOvRM+VZagDsNIl
 FY9Z5ANCI188r5cvPYsTMH9M3lK7rHLIZwrTr34yA9/rCOmZ7+m8vlW/rIZCNONyHIQq+RNamjK1u
 az4IXpIgmkWq7RxXhXAmokdqEiawx/dteu2mK+f6AdXt1fR5BWOexygHJU0e9p0mpTbrF48r1l4ix
 4hHn65Y1kR7BayykfQ3fkZvb61o3ibS6S+xogeevBjwZKMOQe4hXgmnQP68K7NXU2YGJBRt3Fn6o9
 8dqD315kU2DH5BA/uaqzgp/Mh6p6MiNQMWj8NxOeCZghVWwvGWwBQZ+SLR1TaRGYTPnEEIvmpyvWk
 6rUVxsohpwBM56qAY2Z3mQI8K1cpWOiJW4C5Ef4HTR3ZxuXAh1O6VjMLMNwxxxZ76dix95FB2e+iN
 yo8950YxNLtrZ3J8jpniuVjalCWxTkZU4imFdtMy4wn51OwiByw6ahcHK64zvxKJ3p4NzNEICE4Ku
 c2pKhDr9i2wJskxbkGOF3StSWmAeRdDZ3Ruqo+LxnqUGIfbsyCL03RWDmFU+vbzDmyY9WgK1F/mIY
 Oc7wHl/7Cs5cgY912TPZbmwwcywN5jFUF95eBMJbY=;
Received: from host86-159-123-68.range86-159.btcentralplus.com
 ([86.159.123.68] helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnxPL-0006za-Pd; Wed, 04 Oct 2023 09:39:09 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed,  4 Oct 2023 09:38:02 +0100
Message-Id: <20231004083806.757242-17-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004083806.757242-1-mark.cave-ayland@ilande.co.uk>
References: <20231004083806.757242-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.159.123.68
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 16/20] mac_via: implement ADB_STATE_IDLE state if shift
 register in input mode
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

NetBSD switches directly to IDLE state without switching the shift register to
input mode. Duplicate the existing ADB_STATE_IDLE logic in input mode from when
the shift register is in output mode which allows the ADB autopoll handler to
handle the response.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/misc/mac_via.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 9f9c2815d0..3c41d6263d 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -702,6 +702,12 @@ static void adb_via_send(MOS6522Q800VIA1State *v1s, int state, uint8_t data)
         break;
 
     case ADB_STATE_IDLE:
+        ms->b |= VIA1B_vADBInt;
+        adb_autopoll_unblock(adb_bus);
+
+        trace_via1_adb_send("IDLE", data,
+                            (ms->b & VIA1B_vADBInt) ? "+" : "-");
+
         return;
     }
 
-- 
2.39.2


