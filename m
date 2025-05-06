Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8D6AACC15
	for <lists+qemu-devel@lfdr.de>; Tue,  6 May 2025 19:18:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCLux-00050A-VP; Tue, 06 May 2025 13:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stgraber@stgraber.org>)
 id 1uCLR2-0004SB-OT
 for qemu-devel@nongnu.org; Tue, 06 May 2025 12:46:25 -0400
Received: from postfix03.anycast-3.core.dcmtl.stgraber.net
 ([2602:fc62:a:1003:216:3eff:fea3:3fe])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stgraber@stgraber.org>)
 id 1uCLR0-0003r9-8b
 for qemu-devel@nongnu.org; Tue, 06 May 2025 12:46:23 -0400
Received: from dakara.stgraber.net (unknown
 [IPv6:2602:fc62:c:1000:16ac:60ff:fe46:9b07])
 by postfix03.anycast-3.core.dcmtl.stgraber.net (Postfix) with ESMTP id
 E6F4096F5; Tue,  6 May 2025 16:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stgraber.org;
 s=smtpout1; t=1746549978;
 bh=URzd0k7yyaOMVcToNL3qEfqw3/qRoARH942MaRSVM7s=;
 h=From:To:Cc:Subject:Date:From;
 b=pmnHYFWrEQmxmTypMZecH+5SGdQhpK/wNE9MKp6tHODmvrYWugT52KlbsIa60Az3j
 KS3ogBZSKIRKMGfflFa7pKB4mglsCEzVNimymskkOyh5PlAXiRbMuKO3OgJptVhLYc
 PGlNa3y4sZEehyuiXvUa57eR61vZYFdd9ehjLDPI=
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>
Subject: [PATCH] hw/usb/network: Remove hardcoded 0x40 prefix
Date: Tue,  6 May 2025 12:45:53 -0400
Message-ID: <20250506164602.3897164-1-stgraber@stgraber.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2602:fc62:a:1003:216:3eff:fea3:3fe;
 envelope-from=stgraber@stgraber.org;
 helo=postfix03.anycast-3.core.dcmtl.stgraber.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 06 May 2025 13:17:18 -0400
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
Reply-to:  =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>
From:  =?UTF-8?q?St=C3=A9phane=20Graber?= via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

USB NICs have a "40:" prefix hardcoded for all MAC addresses.

This overrides user-provided configuration and leads to an inconsistent
experience.

I couldn't find any documented reason (comment or git commits) for this
behavior. It seems like everyone is just expecting the MAC address to be
fully passed through to the guest, but it isn't.

This is also particularly problematic as the "40:" prefix isn't a
reserved prefix for MAC addresses (IEEE OUI). There are a number of
valid allocations out there which use this prefix, meaning that QEMU may
be causing MAC address conflicts.

Signed-off-by: Stéphane Graber <stgraber@stgraber.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2951
---
 hw/usb/dev-network.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
index 81cc09dcac..1df2454181 100644
--- a/hw/usb/dev-network.c
+++ b/hw/usb/dev-network.c
@@ -1383,7 +1383,7 @@ static void usb_net_realize(USBDevice *dev, Error **errp)
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
     snprintf(s->usbstring_mac, sizeof(s->usbstring_mac),
              "%02x%02x%02x%02x%02x%02x",
-             0x40,
+             s->conf.macaddr.a[0],
              s->conf.macaddr.a[1],
              s->conf.macaddr.a[2],
              s->conf.macaddr.a[3],
-- 
2.47.2


