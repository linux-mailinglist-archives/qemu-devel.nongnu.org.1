Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB98806B40
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 11:03:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAoj5-0001tN-As; Wed, 06 Dec 2023 05:01:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <a_lijiejun@163.com>)
 id 1rAoj2-0001tA-Ll
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 05:01:53 -0500
Received: from m12.mail.163.com ([220.181.12.198])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <a_lijiejun@163.com>) id 1rAoiw-0001w0-Er
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 05:01:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=lucAq
 jcAOxV7OyUhEMHxxl+sriz7SB5m4PKny50BcG4=; b=nph7x0RixW6b0dAp82d4B
 WDOvmKpFDwVwY0zHu81DFnwIq187gDlSaj/hkkjSgaZRtBJD8oLZsZ3VVvKCCzcC
 loPDxAtWZmoXf8Gw1X1dPTKKqjkqLwtK1YYXBonc30mFQLGgAOrqaqPxVneSRo6F
 XRpyYAZcWLL07r4Cf+NhPA=
Received: from test123.sz.office (unknown [121.12.80.215])
 by zwqz-smtp-mta-g5-2 (Coremail) with SMTP id _____wDntoRqRnBlsUI5Ew--.32175S2;
 Wed, 06 Dec 2023 18:01:29 +0800 (CST)
From: lijiejun <a_lijiejun@163.com>
To: quintela@redhat.com,
	peterx@redhat.com,
	farosas@suse.de
Cc: qemu-devel@nongnu.org,
	lijiejun <a_lijiejun@163.com>
Subject: [PATCH] migration: using qapi_free_SocketAddress instead of g_free
Date: Wed,  6 Dec 2023 18:01:11 +0800
Message-Id: <20231206100111.2996016-1-a_lijiejun@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDntoRqRnBlsUI5Ew--.32175S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw4fZw45urW8AFyxJF47urg_yoW3KFg_u3
 y09F4Y9as5GF43Ca1UWw18XrW3Ar4rJF95u343KrsxK34UAasxtr95A3s8X3yUJrsrKr15
 Gw4qqFy3AasrGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRtVyIJUUUUU==
X-Originating-IP: [121.12.80.215]
X-CM-SenderInfo: pdboxyplhm30i6rwjhhfrp/1tbiEBk+FF8YM7C1fAAAsu
Received-SPF: pass client-ip=220.181.12.198; envelope-from=a_lijiejun@163.com;
 helo=m12.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_BL=0.001, RCVD_IN_MSPIKE_L4=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

use unified function qapi_free_SocketAddress to free SocketAddress
object.

Signed-off-by: lijiejun <a_lijiejun@163.com>
---
 migration/migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 3ce04b2aaf..e78d31bbbf 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -493,7 +493,7 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
         addr->u.socket.type = saddr->type;
         addr->u.socket.u = saddr->u;
         /* Don't free the objects inside; their ownership moved to "addr" */
-        g_free(saddr);
+        qapi_free_SocketAddress(saddr);
     } else if (strstart(uri, "file:", NULL)) {
         addr->transport = MIGRATION_ADDRESS_TYPE_FILE;
         addr->u.file.filename = g_strdup(uri + strlen("file:"));
-- 
2.25.1


