Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10808BCF64F
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Oct 2025 16:06:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7a8G-0006QZ-OG; Sat, 11 Oct 2025 09:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7l-0006Hl-9d
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:59:05 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7W-0004lW-US
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:59:04 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 0062CC0185;
 Sat, 11 Oct 2025 16:58:19 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uvMPBZ1FEOs0-ydRg3cVa; Sat, 11 Oct 2025 16:58:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191098;
 bh=Pr3uaR7nVBEcKHlMi3k1Ky1Na2jMyU9B8ylURYPa8/g=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=u9hYk32YGI8AsZJjTct8evSqCDIz8VT1OBUPLGrKgPJHl3pxlvGslOZCGE/0eTfZJ
 qu1UgMtf9gWi6Wkt5Yd2kSzE+0gDVVHxT16R7XUiDgXf91qo5Jo+736BIJvOx0oJHA
 LUrwdhVCjfK41kUgTzTUPNeK0Gs70KES9sIQtFBo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH 22/33] qapi/rocker.json: docs: width=70 and two spaces between
 sentences
Date: Sat, 11 Oct 2025 16:57:23 +0300
Message-ID: <20251011135754.294521-43-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011135754.294521-1-vsementsov@yandex-team.ru>
References: <20251011135754.294521-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 qapi/rocker.json | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/qapi/rocker.json b/qapi/rocker.json
index 5d2dbd2603..0b211d787e 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -102,11 +102,16 @@
 #
 # .. qmp-example::
 #
-#     -> { "execute": "query-rocker-ports", "arguments": { "name": "sw1" } }
-#     <- { "return": [ {"duplex": "full", "enabled": true, "name": "sw1.1",
-#                       "autoneg": "off", "link-up": true, "speed": 10000},
-#                      {"duplex": "full", "enabled": true, "name": "sw1.2",
-#                       "autoneg": "off", "link-up": true, "speed": 10000}
+#     -> { "execute": "query-rocker-ports", "arguments": { "name":
+#     "sw1" } }
+#     <- { "return": [ {"duplex": "full", "enabled": true, "name":
+#     "sw1.1",
+#                       "autoneg": "off", "link-up": true, "speed":
+#     10000},
+#                      {"duplex": "full", "enabled": true, "name":
+#     "sw1.2",
+#                       "autoneg": "off", "link-up": true, "speed":
+#     10000}
 #        ]}
 ##
 { 'command': 'query-rocker-ports',
@@ -246,7 +251,8 @@
 #
 #     -> { "execute": "query-rocker-of-dpa-flows",
 #          "arguments": { "name": "sw1" } }
-#     <- { "return": [ {"key": {"in-pport": 0, "priority": 1, "tbl-id": 0},
+#     <- { "return": [ {"key": { "in-pport": 0, "priority": 1,
+#                                "tbl-id": 0},
 #                       "hits": 138,
 #                       "cookie": 0,
 #                       "action": {"goto-tbl": 10},
-- 
2.48.1


