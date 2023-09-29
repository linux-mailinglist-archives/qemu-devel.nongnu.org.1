Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABD97B3996
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 20:03:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmHnT-0004zW-18; Fri, 29 Sep 2023 14:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qmHnN-0004Nj-Fo
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 14:00:57 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qmHn9-0005nT-EK
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 14:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wj1kRK2UFSUTjJkP3sSSNCXThjQ7dL0dyJS9XEJSezI=; b=yGDza/eB7stcMWng9jIB1oWm8g
 oMv2DvnwigJFn8heUmK+NRU+htQOMqVa2z34mGAyMNn6wGzloKAlAJfjNT5uW7MrbRg6bPP54uGxh
 wZ9qwIE4pv1FH5OfBWO6t9h6DC4tSViE9Fhs7061RrnF1TK7kbVSOcpGanmi5e+8G66/zlE0Y9G00
 zAcAXTbufvG5k9k6m5F0VxaEGYZflY09koM2ycjQHsNetfOeiA3GtLMpDHZkBK26aSB5cH5xfGGCu
 am8GZKbCuL5z2J1nccS5zu2+KZPMuqZpWB961jTZiLU4LGxXpFAOPtyBOFdXAu2mfLZiJP/Gu2Q1W
 GAJ93+0ymdsl0EknkQk00gTSL9dtiLZG9tLeRKpbEBsKTDuyagB96uuwxl1MS+5Vnb/QmMsRdj8s/
 gQuvyZmne1hhBF/2nFKbLN7HzIJ4uh9mEdrHir9ix/5eSIk2sXj+9S20/G8fc2TIKgrNZEunzT1mh
 bcDgnv+djnpw6jzM+DsYz/+VNkiWMNKTOW3qgsNiLyUGGPNHN5VwLIx2o1VoeJPGb7YNfk6/ZmfL9
 dz3aegfwm9mMiP6stsBgkSZwslIS+MiZOphIbQnwEtu7oCCoc6ajH0fusp2dmWOG/7rzd+fLzF+2s
 V+cKO8L8ZxMj1zkHL/r+H2CM4CTemPmRr74E4i5r8=;
Received: from [2a00:23c4:8baf:5f00:c237:5189:8121:f752]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qmHml-00033Y-1F; Fri, 29 Sep 2023 19:00:23 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Fri, 29 Sep 2023 18:59:13 +0100
Message-Id: <20230929175917.511133-17-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230929175917.511133-1-mark.cave-ayland@ilande.co.uk>
References: <20230929175917.511133-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:c237:5189:8121:f752
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 16/20] mac_via: implement ADB_STATE_IDLE state if shift
 register in input mode
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


