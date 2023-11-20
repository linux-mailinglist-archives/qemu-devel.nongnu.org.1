Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 367CC7F0AD5
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 04:16:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4ukh-0003M2-Pl; Sun, 19 Nov 2023 22:15:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhouzongmin@kylinos.cn>)
 id 1r4ukc-0003Lr-Q7
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 22:15:06 -0500
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhouzongmin@kylinos.cn>)
 id 1r4ukY-000131-GK
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 22:15:06 -0500
X-UUID: f07d96c7d1504f0a8612e4b653e94105-20231120
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32, REQID:bb247b21-153d-4cf6-8eba-e1ac0bdd0575, IP:5,
 U
 RL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:15
X-CID-INFO: VERSION:1.1.32, REQID:bb247b21-153d-4cf6-8eba-e1ac0bdd0575, IP:5,
 URL
 :0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:15
X-CID-META: VersionHash:5f78ec9, CLOUDID:6f45d672-1bd3-4f48-b671-ada88705968c,
 B
 ulkID:231120111436TUHAXQCD,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|102,
 TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
 OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: f07d96c7d1504f0a8612e4b653e94105-20231120
X-User: zhouzongmin@kylinos.cn
Received: from thinkpadx13gen2i.. [(116.128.244.169)] by mailgw
 (envelope-from <zhouzongmin@kylinos.cn>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 196459290; Mon, 20 Nov 2023 11:14:34 +0800
From: Zongmin Zhou <zhouzongmin@kylinos.cn>
To: peterx@redhat.com
Cc: berrange@redhat.com, farosas@suse.de, leobras@redhat.com,
 qemu-devel@nongnu.org, quintela@redhat.com,
 Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: [PATCH v3] migration: free 'saddr' since be no longer used
Date: Mon, 20 Nov 2023 11:14:28 +0800
Message-Id: <20231120031428.908295-1-zhouzongmin@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZVdw_XMJ4mKMFejd@x1n>
References: <ZVdw_XMJ4mKMFejd@x1n>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=zhouzongmin@kylinos.cn; helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Since socket_parse() will allocate memory for 'saddr',and its value
will pass to 'addr' that allocated by migrate_uri_parse(),
then 'saddr' will no longer used,need to free.
But due to 'saddr->u' is shallow copying the contents of the union,
the members of this union containing allocated strings,and will be used after that.
So just free 'saddr' itself without doing a deep free on the contents of the SocketAddress.

Fixes: 72a8192e225c ("migration: convert migration 'uri' into 'MigrateAddress'")
Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
---
 migration/migration.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 28a34c9068..1832dad618 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -462,7 +462,6 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
 {
     g_autoptr(MigrationChannel) val = g_new0(MigrationChannel, 1);
     g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
-    SocketAddress *saddr = NULL;
     InetSocketAddress *isock = &addr->u.rdma;
     strList **tail = &addr->u.exec.args;
 
@@ -487,12 +486,14 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
                 strstart(uri, "vsock:", NULL) ||
                 strstart(uri, "fd:", NULL)) {
         addr->transport = MIGRATION_ADDRESS_TYPE_SOCKET;
-        saddr = socket_parse(uri, errp);
+        SocketAddress *saddr = socket_parse(uri, errp);
         if (!saddr) {
             return false;
         }
         addr->u.socket.type = saddr->type;
         addr->u.socket.u = saddr->u;
+        /* Don't free the objects inside; their ownership moved to "addr" */
+        g_free(saddr);
     } else if (strstart(uri, "file:", NULL)) {
         addr->transport = MIGRATION_ADDRESS_TYPE_FILE;
         addr->u.file.filename = g_strdup(uri + strlen("file:"));
-- 
2.34.1


