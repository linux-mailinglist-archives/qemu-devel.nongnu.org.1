Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6B67A91A9
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 08:13:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjCwH-0003VE-Bi; Thu, 21 Sep 2023 02:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liucong2@kylinos.cn>)
 id 1qjCwA-0003Tu-Bk
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 02:13:18 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liucong2@kylinos.cn>)
 id 1qjCw2-0007Vb-Rh
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 02:13:18 -0400
X-UUID: 8bc080a4bcf14f94a4076a9e48557770-20230921
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31, REQID:22626631-b9af-4a67-ba92-ad2a9dcd1463, IP:15,
 URL:0,TC:0,Content:21,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:27
X-CID-INFO: VERSION:1.1.31, REQID:22626631-b9af-4a67-ba92-ad2a9dcd1463, IP:15,
 UR
 L:0,TC:0,Content:21,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:27
X-CID-META: VersionHash:0ad78a4, CLOUDID:76ce17bf-14cc-44ca-b657-2d2783296e72,
 B
 ulkID:23092114124286UVDP68,BulkQuantity:0,Recheck:0,SF:38|24|17|19|43|102,
 TC:nil,Content:4,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
 ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 8bc080a4bcf14f94a4076a9e48557770-20230921
X-User: liucong2@kylinos.cn
Received: from localhost.localdomain [(111.48.58.12)] by mailgw
 (envelope-from <liucong2@kylinos.cn>) (Generic MTA)
 with ESMTP id 970315594; Thu, 21 Sep 2023 14:12:39 +0800
From: Cong Liu <liucong2@kylinos.cn>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Cc: Cong Liu <liucong2@kylinos.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH] plugins/hotblocks: Fix potential deadlock in plugin_exit()
 function
Date: Thu, 21 Sep 2023 14:12:31 +0800
Message-Id: <20230921061231.60948-1-liucong2@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232; envelope-from=liucong2@kylinos.cn;
 helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

This patch fixes a potential deadlock in the plugin_exit() function of QEMU.
The original code does not release the lock mutex if it is NULL. This patch
adds a check for it being NULL and releases the mutex in that case.

Signed-off-by: Cong Liu <liucong2@kylinos.cn>
---
 contrib/plugins/hotblocks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index 6b74d25fead6..1f713f1904f3 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -70,6 +70,8 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 
         g_list_free(it);
         g_mutex_unlock(&lock);
+    } else {
+        g_mutex_unlock(&lock);
     }
 
     qemu_plugin_outs(report->str);
-- 
2.34.1


