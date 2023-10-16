Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED737CA434
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 11:33:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJxm-0002Z9-9v; Mon, 16 Oct 2023 05:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liucong2@kylinos.cn>)
 id 1qsJxh-0002Ym-VN
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:32:33 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liucong2@kylinos.cn>)
 id 1qsJxd-0000pL-4a
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:32:33 -0400
X-UUID: f47be2910a644cf2b854ad2a185c3e8f-20231016
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32, REQID:ca49480d-6d3c-4898-90b3-7d8ea5e41776, IP:20,
 URL:0,TC:0,Content:0,EDM:-30,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACT
 ION:release,TS:-19
X-CID-INFO: VERSION:1.1.32, REQID:ca49480d-6d3c-4898-90b3-7d8ea5e41776, IP:20,
 UR
 L:0,TC:0,Content:0,EDM:-30,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-19
X-CID-META: VersionHash:5f78ec9, CLOUDID:ae53d8f0-9a6e-4c39-b73e-f2bc08ca3dc5,
 B
 ulkID:231016173150D9G4DJYG,BulkQuantity:0,Recheck:0,SF:17|19|43|66|38|24|1
 02,TC:nil,Content:0,EDM:2,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
 :0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: f47be2910a644cf2b854ad2a185c3e8f-20231016
X-User: liucong2@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
 (envelope-from <liucong2@kylinos.cn>) (Generic MTA)
 with ESMTP id 39791858; Mon, 16 Oct 2023 17:31:48 +0800
From: Cong Liu <liucong2@kylinos.cn>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Cc: Cong Liu <liucong2@kylinos.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH] contrib/plugins: Close file descriptor on connect failure
Date: Mon, 16 Oct 2023 17:31:43 +0800
Message-Id: <20231016093143.222551-1-liucong2@kylinos.cn>
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

This patch closes the file descriptor fd on connect failure to avoid
resource leak.

Signed-off-by: Cong Liu <liucong2@kylinos.cn>
---
 contrib/plugins/lockstep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index f0cb8792c6fa..3c0f2b485181 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -303,6 +303,7 @@ static bool connect_socket(const char *path)
     sockaddr.sun_family = AF_UNIX;
     if (g_strlcpy(sockaddr.sun_path, path, pathlen) >= pathlen) {
         perror("bad path");
+        close(fd);
         return false;
     }
 
-- 
2.34.1


