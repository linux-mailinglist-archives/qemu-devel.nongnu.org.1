Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C59D370FFD2
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 23:13:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1vn4-0004ql-0A; Wed, 24 May 2023 17:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vmx-0003yl-99
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:12:55 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vmu-0002Eh-JS
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vam29yBPBh0lOubxJpuNVSNbAJq8rVDtEoBvrF74F0Y=; b=lhrKdiWJaXuQGL3QQ2yQCriUiD
 S5/aUu7uWncWDVMZVxTRN9yH0UVvNlqIMpbXBeol2hgSGIcPh51CZK7rTkKQWkY6ySxnPPwHhP0Qz
 O2XEWOgQimCsPvIq5ZmKbt33L0gpAVegrasRh+YBhIwbESnxbBRvBpQfhf1ELfvwZrMWihM1JewQD
 /r4HCXJkB5YtPxIdYOGSYQrKL9u/4U7KWgaCQKy2MqDKAyKVCsu4kKomSJ3hU6uHiVIFs+Ey9few/
 Z/vcdqJ0Aq9r61wj5JYbICzLWovSJnTETtbUeMOyVJ+/V+TLo1PqcqLSGIES1J9Sqnw0yIN40PL02
 g2eUDkZhKTOfKUVfOI8NwENGNdZo7JpFBli+8/6XoM8hxXUjewThK40AFTVD71LKtKpRC98jwnh5D
 jZ7t0T+fy3zKn/PfplEAfKZ6CYhSuXJULrB5aADPzuCkjtQBVb9V+3k5Bfl1k7rTa1IVc/M0S27Kg
 5WQpYunbGfce6l2wuJPRGmBnyLr9+E4dPRl8Z5uvR3zVzH782uuLAn/a/LScrZyKB1HggzFq8vj5B
 9h/+P317EBtNCf4MY/1hYni3/PdSR2u/Zkk1kNe1wopfsiki9ZVYGths9WnFZ24XmLJ1R8Z3IfpmZ
 oQOu+MQ/gfWMLMFScG3y97IDAPkwIughMrXkZVmdU=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vmg-0005XR-PV; Wed, 24 May 2023 22:12:38 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 24 May 2023 22:10:59 +0100
Message-Id: <20230524211104.686087-26-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 25/30] mac_via: implement ADB_STATE_IDLE state if shift
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

NetBSD switches directly to IDLE state without switching the shift register to
input mode. Duplicate the existing ADB_STATE_IDLE logic in input mode from when
the shift register is in output mode which allows the ADB autopoll handler to
handle the response.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/mac_via.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 564db8337e..c1d2866ec9 100644
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
2.30.2


