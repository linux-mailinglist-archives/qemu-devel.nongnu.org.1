Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D849FBCF622
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Oct 2025 16:02:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7a8L-0006RV-MJ; Sat, 11 Oct 2025 09:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7m-0006Ic-UT
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:59:09 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7W-0004lK-LH
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:59:06 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 75183C0186;
 Sat, 11 Oct 2025 16:58:18 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uvMPBZ1FEOs0-Jp0luZXp; Sat, 11 Oct 2025 16:58:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191098;
 bh=IB5WctOaaDS5QjV9UsCfoJSKTXKFLtlmFJsXAiDAbRw=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=J+c+pozX4909M0LTzfphx387wLmsd2IAQNAevdUEYPcyT/uHIGUly56pOOOfqf93q
 1ngEY9y1GyV5vItCPIWpgYC3Z8MRGQ97OHJ6IRuwQsj8YOCd7IGcPyuo1o9O/g4Lp8
 rwcxzDMdndksi8J0xT4uWVNHEEjossHoLjdQwaV8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 21/33] qapi/replay.json: reflow docs to width=70 and two
 spaces between sentences
Date: Sat, 11 Oct 2025 16:57:22 +0300
Message-ID: <20251011135754.294521-42-vsementsov@yandex-team.ru>
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
 qapi/replay.json | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/qapi/replay.json b/qapi/replay.json
index ccf84da68e..0f1398e9b6 100644
--- a/qapi/replay.json
+++ b/qapi/replay.json
@@ -59,7 +59,8 @@
 # .. qmp-example::
 #
 #     -> { "execute": "query-replay" }
-#     <- { "return": { "mode": "play", "filename": "log.rr", "icount": 220414 } }
+#     <- { "return": { "mode": "play", "filename": "log.rr",
+#                      "icount": 220414 } }
 ##
 { 'command': 'query-replay',
   'returns': 'ReplayInfo' }
@@ -80,7 +81,8 @@
 #
 # .. qmp-example::
 #
-#     -> { "execute": "replay-break", "arguments": { "icount": 220414 } }
+#     -> { "execute": "replay-break",
+#          "arguments": { "icount": 220414 } }
 #     <- { "return": {} }
 ##
 { 'command': 'replay-break', 'data': { 'icount': 'int' } }
@@ -116,7 +118,8 @@
 #
 # .. qmp-example::
 #
-#     -> { "execute": "replay-seek", "arguments": { "icount": 220414 } }
+#     -> { "execute": "replay-seek",
+#          "arguments": { "icount": 220414 } }
 #     <- { "return": {} }
 ##
 { 'command': 'replay-seek', 'data': { 'icount': 'int' } }
-- 
2.48.1


