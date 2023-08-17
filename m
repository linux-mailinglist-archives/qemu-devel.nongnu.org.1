Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3D977F552
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 13:33:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWbEb-0001jU-3C; Thu, 17 Aug 2023 07:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tugy@chinatelecom.cn>)
 id 1qWbEY-0001jB-Un
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 07:32:10 -0400
Received: from smtpnm6-02.21cn.com ([182.42.154.78] helo=chinatelecom.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tugy@chinatelecom.cn>) id 1qWbEU-0004v7-Ri
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 07:32:10 -0400
HMM_SOURCE_IP: 192.168.139.44:35588.1307217768
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-36.111.64.85 (unknown [192.168.139.44])
 by chinatelecom.cn (HERMES) with SMTP id A95B51237AAD0;
 Thu, 17 Aug 2023 19:24:06 +0800 (CST)
X-189-SAVE-TO-SEND: +tugy@chinatelecom.cn
Received: from  ([36.111.64.85])
 by gateway-ssl-dep-56d86dc765-g96c8 with ESMTP id
 d2e754c77194406099d22ac2c52969a6 for kraxel@redhat.com; 
 Thu, 17 Aug 2023 19:24:07 CST
X-Transaction-ID: d2e754c77194406099d22ac2c52969a6
X-Real-From: tugy@chinatelecom.cn
X-Receive-IP: 36.111.64.85
X-MEDUSA-Status: 0
From: tugy@chinatelecom.cn
To: kraxel@redhat.com,
	marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,
	tugy@chinatelecom.cn,
	dengpc12@chinatelecom.cn
Subject: [PATCH 2/2] ui/vdagent: Unregister input handler of mouse during
 finalization
Date: Thu, 17 Aug 2023 19:23:56 +0800
Message-Id: <febb712a419d37d2e2b244794f28efdf8aa5177c.1692268800.git.tugy@chinatelecom.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1692268800.git.tugy@chinatelecom.cn>
References: <cover.1692268800.git.tugy@chinatelecom.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=182.42.154.78; envelope-from=tugy@chinatelecom.cn;
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
index 386dc5abe0..4c9b3b7ba8 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -924,6 +924,9 @@ static void vdagent_chr_fini(Object *obj)
 {
     VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(obj);
 
+    if (vd->mouse_hs) {
+        qemu_input_handler_unregister(vd->mouse_hs);
+    }
     migrate_del_blocker(vd->migration_blocker);
     buffer_free(&vd->outbuf);
     error_free(vd->migration_blocker);
-- 
2.27.0


