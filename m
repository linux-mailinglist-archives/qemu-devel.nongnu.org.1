Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17054BCF6CE
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Oct 2025 16:17:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7aE4-00055Y-BX; Sat, 11 Oct 2025 10:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7aDi-0004Y7-SA
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 10:05:19 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7aDT-0005Ox-C2
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 10:05:13 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id D7F5CC018D;
 Sat, 11 Oct 2025 17:04:48 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id h4NOTl1FrqM0-tE4CLhg4; Sat, 11 Oct 2025 17:04:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191488;
 bh=f2E8t138+1ErXT8tRAi99mF/Qqtq/L1b5hlUxr3dG8M=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=JJga3fkgND4ejCWS5so3eyVqJQA4Szyu3P7WueJpxYbRa//zWsckZ3lhqvSSMq9Xb
 eFbksOoenfFq+N0aHVjHXGwNmrOfvKthrPr0s3maVuht38LPIkrNF7nJXOgDcgQrZi
 3kRoeNmbAf8VoubHIDOL/fercMiuRhP/AgkQXl70=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2 09/33] qapi/dump.json: docs: width=70 and two spaces
 between sentences
Date: Sat, 11 Oct 2025 17:04:15 +0300
Message-ID: <20251011140441.297246-10-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011140441.297246-1-vsementsov@yandex-team.ru>
References: <20251011140441.297246-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 qapi/dump.json | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/qapi/dump.json b/qapi/dump.json
index 726b520870..96265cd925 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -176,9 +176,11 @@
 # .. qmp-example::
 #
 #     <- { "event": "DUMP_COMPLETED",
-#          "data": { "result": { "total": 1090650112, "status": "completed",
+#          "data": { "result": { "total": 1090650112,
+#                                "status": "completed",
 #                                "completed": 1090650112 } },
-#          "timestamp": { "seconds": 1648244171, "microseconds": 950316 } }
+#          "timestamp": { "seconds": 1648244171,
+#                         "microseconds": 950316 } }
 ##
 { 'event': 'DUMP_COMPLETED' ,
   'data': { 'result': 'DumpQueryResult', '*error': 'str' } }
@@ -207,7 +209,8 @@
 #
 #     -> { "execute": "query-dump-guest-memory-capability" }
 #     <- { "return": { "formats":
-#                      ["elf", "kdump-zlib", "kdump-lzo", "kdump-snappy"] } }
+#                      [ "elf", "kdump-zlib", "kdump-lzo",
+#                        "kdump-snappy" ] } }
 ##
 { 'command': 'query-dump-guest-memory-capability',
   'returns': 'DumpGuestMemoryCapability' }
-- 
2.48.1


