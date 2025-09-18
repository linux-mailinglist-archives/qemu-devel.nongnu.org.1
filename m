Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCF3B25C92
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Aug 2025 09:04:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umRyL-0002iO-1M; Thu, 14 Aug 2025 03:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1umRy2-0002g1-Ag
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 03:01:42 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1umRxw-0002mo-06
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 03:01:41 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxOGrMiZ1oaaY_AQ--.59865S3;
 Thu, 14 Aug 2025 15:01:32 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJAxT+a7iZ1o8s1KAA--.21880S9;
 Thu, 14 Aug 2025 15:01:32 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 7/8] target/loongarch: Only flush one TLB entry in
 helper_invtlb_page_asid_or_g()
Date: Thu, 14 Aug 2025 15:01:12 +0800
Message-Id: <20250814070113.351760-8-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250814070113.351760-1-maobibo@loongson.cn>
References: <20250814070113.351760-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxT+a7iZ1o8s1KAA--.21880S9
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

With function helper_invtlb_page_asid_or_g(), one TLB entry in
LoongArch emulated TLB is invalidated. Also invalidate_tlb_entry()
can be called so that only one QEMU TLB entry will be flushed.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/tlb_helper.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index df11ff4995..d83e5fb7f8 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -571,7 +571,6 @@ void helper_invtlb_page_asid_or_g(CPULoongArchState *env,
                                   target_ulong info, target_ulong addr)
 {
     int index, asid = info & 0x3ff;
-    LoongArchTLB *tlb;
     tlb_match func;
     bool ret;
 
@@ -581,9 +580,7 @@ void helper_invtlb_page_asid_or_g(CPULoongArchState *env,
         return;
     }
 
-    tlb = &env->tlb[index];
-    tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
-    tlb_flush(env_cpu(env));
+    invalidate_tlb(env, index);
 }
 
 /*
-- 
2.39.3


