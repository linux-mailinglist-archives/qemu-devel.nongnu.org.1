Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7DA7A9308
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 11:24:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjFuT-0003lT-1s; Thu, 21 Sep 2023 05:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liucong2@kylinos.cn>)
 id 1qjFuL-0003kP-T1
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 05:23:39 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liucong2@kylinos.cn>)
 id 1qjFuC-0002ez-2i
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 05:23:35 -0400
X-UUID: 66aa0a87dfd346bbb0c3fbcc420f172a-20230921
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31, REQID:c8cd7c02-d953-459e-9970-84698d566a20, IP:15,
 URL:0,TC:0,Content:20,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:26
X-CID-INFO: VERSION:1.1.31, REQID:c8cd7c02-d953-459e-9970-84698d566a20, IP:15,
 UR
 L:0,TC:0,Content:20,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:26
X-CID-META: VersionHash:0ad78a4, CLOUDID:e91e1abf-14cc-44ca-b657-2d2783296e72,
 B
 ulkID:230921172319DHNO8PRM,BulkQuantity:0,Recheck:0,SF:38|24|17|19|43|102,
 TC:nil,Content:4,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
 ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 66aa0a87dfd346bbb0c3fbcc420f172a-20230921
X-User: liucong2@kylinos.cn
Received: from localhost.localdomain [(111.48.58.12)] by mailgw
 (envelope-from <liucong2@kylinos.cn>) (Generic MTA)
 with ESMTP id 150126022; Thu, 21 Sep 2023 17:23:18 +0800
From: Cong Liu <liucong2@kylinos.cn>
To: philmd@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Cc: liucong2@kylinos.cn,
	qemu-devel@nongnu.org
Subject: [PATCH v2] plugins/hotblocks: Fix potential deadlock in plugin_exit()
 function
Date: Thu, 21 Sep 2023 17:23:11 +0800
Message-Id: <20230921092311.15578-1-liucong2@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8c11bc64-e22f-6ad9-af3e-e7a690536539@linaro.org>
References: <8c11bc64-e22f-6ad9-af3e-e7a690536539@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 contrib/plugins/hotblocks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index 6b74d25fead6..b99b93ad8dc7 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -69,9 +69,9 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
         }
 
         g_list_free(it);
-        g_mutex_unlock(&lock);
     }
 
+    g_mutex_unlock(&lock);
     qemu_plugin_outs(report->str);
 }
 
-- 
2.34.1


