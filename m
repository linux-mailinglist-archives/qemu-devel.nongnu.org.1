Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5F3710D0E
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 15:15:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2AnY-0004FJ-1t; Thu, 25 May 2023 09:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lienze@kylinos.cn>) id 1q24iz-0003G5-EM
 for qemu-devel@nongnu.org; Thu, 25 May 2023 02:45:28 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lienze@kylinos.cn>) id 1q24is-0008JC-FB
 for qemu-devel@nongnu.org; Thu, 25 May 2023 02:45:25 -0400
X-UUID: 8d6e358314bc4e6081057a960eaab250-20230525
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22, REQID:e8256219-65ac-4bb1-b155-a381c2d77835, IP:15,
 URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:0
X-CID-INFO: VERSION:1.1.22, REQID:e8256219-65ac-4bb1-b155-a381c2d77835, IP:15,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:0
X-CID-META: VersionHash:120426c, CLOUDID:32e44f3c-de1e-4348-bc35-c96f92f1dcbb,
 B
 ulkID:230525144431F9YS1ONR,BulkQuantity:0,Recheck:0,SF:24|17|19|44|102,TC:
 nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
 ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 8d6e358314bc4e6081057a960eaab250-20230525
X-User: lienze@kylinos.cn
Received: from ubuntu.. [(210.12.40.82)] by mailgw
 (envelope-from <lienze@kylinos.cn>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 244428226; Thu, 25 May 2023 14:44:29 +0800
From: Enze Li <lienze@kylinos.cn>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org,
	Enze Li <lienze@kylinos.cn>
Subject: [PATCH] Update copyright dates to 2023
Date: Thu, 25 May 2023 14:43:45 +0800
Message-Id: <20230525064345.1152801-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232; envelope-from=lienze@kylinos.cn;
 helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 25 May 2023 09:14:26 -0400
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

I noticed that in the latest version, the copyright string is still
2022, even though 2023 is halfway through.  This patch fixes that and
fixes the documentation along with it.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 docs/conf.py              | 2 +-
 include/qemu/help-texts.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/conf.py b/docs/conf.py
index c687ff2663..e84a95e71c 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -89,7 +89,7 @@
 
 # General information about the project.
 project = u'QEMU'
-copyright = u'2022, The QEMU Project Developers'
+copyright = u'2023, The QEMU Project Developers'
 author = u'The QEMU Project Developers'
 
 # The version info for the project you're documenting, acts as replacement for
diff --git a/include/qemu/help-texts.h b/include/qemu/help-texts.h
index 4f265fed8d..d0359f82e0 100644
--- a/include/qemu/help-texts.h
+++ b/include/qemu/help-texts.h
@@ -2,7 +2,7 @@
 #define QEMU_HELP_TEXTS_H
 
 /* Copyright string for -version arguments, About dialogs, etc */
-#define QEMU_COPYRIGHT "Copyright (c) 2003-2022 " \
+#define QEMU_COPYRIGHT "Copyright (c) 2003-2023 " \
     "Fabrice Bellard and the QEMU Project developers"
 
 /* Bug reporting information for --help arguments, About dialogs, etc */

base-commit: aa33508196f4e2da04625bee36e1f7be5b9267e7
-- 
2.34.1


