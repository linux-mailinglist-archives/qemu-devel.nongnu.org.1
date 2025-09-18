Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE2FB37D26
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Aug 2025 10:11:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urBEN-0000qk-Os; Wed, 27 Aug 2025 04:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1urBE7-0000cX-AL
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 04:09:53 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1urBE0-0004Bz-1y
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 04:09:51 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxHvA7va5od7ADAA--.7362S3;
 Wed, 27 Aug 2025 16:09:31 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxXME4va5oWKVrAA--.18662S9;
 Wed, 27 Aug 2025 16:09:30 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 07/12] target/loongarch: Add debug parameter with
 loongarch_page_table_walker()
Date: Wed, 27 Aug 2025 16:09:22 +0800
Message-Id: <20250827080927.1644016-8-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250827080927.1644016-1-maobibo@loongson.cn>
References: <20250827080927.1644016-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxXME4va5oWKVrAA--.18662S9
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add debug parameter with function loongarch_page_table_walker(),
in debug mode it is only to get physical address. And It used in
future HW PTW usage, bit dirty and access will be updated in HW
PTW mode.

Also function loongarch_page_table_walker() is renamed as
loongarch_ptw() for short.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu_helper.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 2e07049425..5488d2d871 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -106,9 +106,8 @@ TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
     return TLBRET_MATCH;
 }
 
-static TLBRet loongarch_page_table_walker(CPULoongArchState *env,
-                                          MMUContext *context,
-                                          int access_type, int mmu_idx)
+static TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
+                            int access_type, int mmu_idx, int debug)
 {
     CPUState *cs = env_cpu(env);
     target_ulong index, phys;
@@ -184,7 +183,7 @@ static TLBRet loongarch_map_address(CPULoongArchState *env,
          * legal mapping, even if the mapping is not yet in TLB. return 0 if
          * there is a valid map, else none zero.
          */
-        return loongarch_page_table_walker(env, context, access_type, mmu_idx);
+        return loongarch_ptw(env, context, access_type, mmu_idx, is_debug);
     }
 
     return TLBRET_NOMATCH;
-- 
2.39.3


