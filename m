Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C76A2060F
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Jan 2025 09:23:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgYD-0005TY-Op; Tue, 28 Jan 2025 03:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgXx-0004Nq-Uk; Tue, 28 Jan 2025 03:02:10 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgXv-0001xJ-0S; Tue, 28 Jan 2025 03:02:09 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B0B25E1B54;
 Tue, 28 Jan 2025 10:57:08 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2C8AE1A6307;
 Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id F2A025209F; Tue, 28 Jan 2025 10:57:33 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.3 13/58] tests/9p: fix Rreaddir response name
Date: Mon, 27 Jan 2025 23:24:59 +0300
Message-Id: <20250127202547.3723716-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
References: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

All 9p response types are prefixed with an "R", therefore fix
"READDIR" -> "RREADDIR" in function rmessage_name().

Fixes: 4829469fd9ff ("tests/virtio-9p: added readdir test")
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <daad7af58b403aaa2487c566032beca36664b30e.1732465720.git.qemu_oss@crudebyte.com>
(cherry picked from commit abf0f092c1dd33b9ffa986c6924addc0a9c1d0b8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/libqos/virtio-9p-client.c b/tests/qtest/libqos/virtio-9p-client.c
index b8adc8d4b9..c61632fcd3 100644
--- a/tests/qtest/libqos/virtio-9p-client.c
+++ b/tests/qtest/libqos/virtio-9p-client.c
@@ -238,7 +238,7 @@ static const char *rmessage_name(uint8_t id)
         id == P9_RLINK ? "RLINK" :
         id == P9_RUNLINKAT ? "RUNLINKAT" :
         id == P9_RFLUSH ? "RFLUSH" :
-        id == P9_RREADDIR ? "READDIR" :
+        id == P9_RREADDIR ? "RREADDIR" :
         "<unknown>";
 }
 
-- 
2.39.5


