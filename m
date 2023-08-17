Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA2177F8C6
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 16:23:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWdtg-0003tm-KT; Thu, 17 Aug 2023 10:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tugy@chinatelecom.cn>)
 id 1qWdte-0003t9-Vd
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 10:22:46 -0400
Received: from smtpnm6-06.21cn.com ([182.42.144.170] helo=chinatelecom.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tugy@chinatelecom.cn>) id 1qWdtb-0004kB-7u
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 10:22:46 -0400
HMM_SOURCE_IP: 192.168.138.117:19873.1524632281
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-182.148.58.152 (unknown [192.168.138.117])
 by chinatelecom.cn (HERMES) with SMTP id 85F9DE821D;
 Thu, 17 Aug 2023 22:14:01 +0800 (CST)
X-189-SAVE-TO-SEND: +tugy@chinatelecom.cn
Received: from  ([182.148.58.152])
 by gateway-ssl-dep-56d86dc765-7s8sf with ESMTP id
 56cf0b8c26b54df5809d00c89f1c2bb2 for kraxel@redhat.com; 
 Thu, 17 Aug 2023 22:14:02 CST
X-Transaction-ID: 56cf0b8c26b54df5809d00c89f1c2bb2
X-Real-From: tugy@chinatelecom.cn
X-Receive-IP: 182.148.58.152
X-MEDUSA-Status: 0
From: tugy@chinatelecom.cn
To: kraxel@redhat.com,
	marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,
	tugy@chinatelecom.cn,
	dengpc12@chinatelecom.cn
Subject: [PATCH v1 2/2] ui/vdagent: Unregister input handler of mouse during
 finalization
Date: Thu, 17 Aug 2023 22:12:53 +0800
Message-Id: <e7f5e172abf797d454e00a4bbe53af83e4aa4497.1692281173.git.tugy@chinatelecom.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1692281173.git.tugy@chinatelecom.cn>
References: <cover.1692281173.git.tugy@chinatelecom.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=182.42.144.170; envelope-from=tugy@chinatelecom.cn;
 helo=chinatelecom.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

From: Guoyi Tu <tugy@chinatelecom.cn>

Input handler resource should be released when
VDAgentChardev object finalize

Signed-off-by: Guoyi Tu <tugy@chinatelecom.cn>
Signed-off-by: dengpengcheng <dengpc12@chinatelecom.cn>
---
 ui/vdagent.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/vdagent.c b/ui/vdagent.c
index 4b9a1fb7c5..00d36a8677 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -926,6 +926,9 @@ static void vdagent_chr_fini(Object *obj)
 
     migrate_del_blocker(vd->migration_blocker);
     vdagent_disconnect(vd);
+    if (vd->mouse_hs) {
+        qemu_input_handler_unregister(vd->mouse_hs);
+    }
     buffer_free(&vd->outbuf);
     error_free(vd->migration_blocker);
 }
-- 
2.27.0


