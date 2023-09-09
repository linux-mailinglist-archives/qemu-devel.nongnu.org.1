Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2125B799731
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 11:51:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeub3-0006ld-Ey; Sat, 09 Sep 2023 05:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeub1-0006YS-Id
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 05:49:43 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeuaz-0005Ky-FV
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 05:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+iFA7qvPrz373bNL3wc4A40I0zWtZDa/naHKx7FzwNU=; b=Sy9xEsuGIHN/4gIR13MGOxHaq4
 QEqX98YuZU/ayJMiyKAQxJu7S3lcfDrEnWkBNCluMdE1ZuVVvptl6g+r75J+QWvoQlvj0BYk94rLz
 G7CAiTN1GJ25AyIWHu95Zana3tkY4fnvy3fna+pvhig/yTkRdNNZJmmz+UApNR42IepHtCvn1hxlv
 YratlpJnvPvlrr4kME+fW9QfBQKOjYpuO9yeiMLPL3F1vAl2cbgwZa+nLmOkvQJhk3zEcIp8FnNPG
 k7LuIqMCtd+dEPONOydEVLEjx/2hjztn/Jzh1nLch+eY/Vo9nCcmx61IoF4jvTUIyiScy561L7lSY
 yAvOlENBuxuAnUe6EBSInGfluAY5vTCKDAsoD2NnkzVwKZVhmleyNpbSyh1Gmptj3RvPlg6nfeVtC
 oj9li7BBJ1tJhWDmq60wkOHxFV0J0FxXmdJmUksSCuGBLyiSuYVGyJ3vKUfPxZn3rj5aoOQJFitYc
 3aZPGrTidu5ugheBLm75NwFsXrmItwmcyDzEvQ0Xsyqy104/UlnlrK5cpsEFEM/2f21da9CPn9Un1
 gL36i4yZZ6VSKf/t+Jx820hF/LjfkzwimZkEx9Ea/yJnbteq/rBjLqB953b7Y3Ekj7TaPQ9Bx1LAN
 sdsWP02WG15tiMmYvEw7t5kcylmnpKevTk0/6cpUI=;
Received: from [2a00:23c4:8baf:5f00:e007:7058:31bc:5be9]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeuaj-0000uO-Bt; Sat, 09 Sep 2023 10:49:29 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sat,  9 Sep 2023 10:48:23 +0100
Message-Id: <20230909094827.33871-17-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:e007:7058:31bc:5be9
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 16/20] mac_via: implement ADB_STATE_IDLE state if shift
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
---
 hw/misc/mac_via.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 208216aed3..398e8d1967 100644
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


