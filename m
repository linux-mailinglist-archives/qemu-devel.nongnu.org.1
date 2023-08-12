Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89923779E5F
	for <lists+qemu-devel@lfdr.de>; Sat, 12 Aug 2023 11:01:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUkUB-0005Wn-8o; Sat, 12 Aug 2023 05:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <herve.poussineau@reactos.org>)
 id 1qUkU5-0005W7-WE; Sat, 12 Aug 2023 05:00:34 -0400
Received: from iserv.reactos.org ([2a01:4f8:1c17:5ae1::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <herve.poussineau@reactos.org>)
 id 1qUkU3-0004mj-B6; Sat, 12 Aug 2023 05:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=reactos.org
 ; s=25047;
 h=Sender:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aWwZ/HfjY03A3XZpcgegvXllE4GSQT8rHlmukAXlFIU=;
 i=herve.poussineau@reactos.org; b=Yl/Xga04SeVPLoZHhANgCl8reGE6twT9CMoQNPQ6rku
 F8pkwt3ceKy2tFHhm55X37ZS0J+LJ0zolrLu6SrclmwxAIi3aqpw6KvENOTTDLX5dEKbiXi4OS3wT
 7JtaMijQsdV2P2MCo7N+8XsvcfiEYEuUegma2IPwh7daB1JcMw0=;
Received: (Authenticated sender: herve.poussineau@reactos.org)
 by iserv.reactos.org with esmtpsa
 (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256) (Exim)
 (envelope-from <herve.poussineau@reactos.org>)
 id 1qUkTw-0089GC-V9; Sat, 12 Aug 2023 09:00:25 +0000
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
To: John Snow <jsnow@redhat.com>,
	qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Subject: [PATCH] hw/block/fdc: do not set SEEK status bit in multi track
 commands
Date: Sat, 12 Aug 2023 10:59:57 +0200
Message-Id: <20230812085957.408208-1-hpoussin@reactos.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f8:1c17:5ae1::1;
 envelope-from=herve.poussineau@reactos.org; helo=iserv.reactos.org
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

I don't understand when SEEK must be set or not, but it seems to fix Minix...

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1522
Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
---
 hw/block/fdc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index d7cc4d3ec19..f627bbaf951 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -1404,7 +1404,6 @@ static int fdctrl_seek_to_next_sect(FDCtrl *fdctrl, FDrive *cur_drv)
             } else {
                 new_head = 0;
                 new_track++;
-                fdctrl->status0 |= FD_SR0_SEEK;
                 if ((cur_drv->flags & FDISK_DBL_SIDES) == 0) {
                     ret = 0;
                 }
-- 
2.40.1


