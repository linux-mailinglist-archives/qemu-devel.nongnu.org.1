Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C740832B69
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:42:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQq35-0005xQ-2z; Fri, 19 Jan 2024 09:40:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2z-0005tE-Ex
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:41 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2w-0003vI-BD
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZOKCnodekcL5jtYtIT72SfARPKQf/ff0v9m3k4jhn4c=; b=pQXf67VX6mcrwQMcXQ6+JxqdnP
 AVBj+8WBEyy7WI/FlkXQW6fCPkSCIDQheGb/NvwX93YlVT0A3logYQi7hjs9OmFykKtOjwS3eYx8+
 2j7yqcPZNjVlEsNKaArGQwW0Fy15frzwPpVUugwtpGWQ9kcLgBaZ2BcpFh6i8akXJWM8=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	richard.henderson@linaro.org,
	philmd@linaro.org
Subject: [RFC PATCH 25/34] accel/tcg: [CPUTLB] Use tcg_ctx->mo_te instead of
 MO_TE
Date: Fri, 19 Jan 2024 15:40:15 +0100
Message-ID: <20240119144024.14289-26-anjo@rev.ng>
In-Reply-To: <20240119144024.14289-1-anjo@rev.ng>
References: <20240119144024.14289-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Makes *_code() memory access functions target independent.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 accel/tcg/cputlb.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index a75a52d141..bfbbfd0fdb 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2988,19 +2988,22 @@ uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr)
 
 uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr)
 {
-    MemOpIdx oi = make_memop_idx(MO_TEUW, cpu_mmu_index(env, true));
+    MemOpIdx oi = make_memop_idx(tcg_ctx->mo_te | MO_UW,
+                                 cpu_mmu_index(env, true));
     return do_ld2_mmu(env_cpu(env), addr, oi, 0, MMU_INST_FETCH);
 }
 
 uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr)
 {
-    MemOpIdx oi = make_memop_idx(MO_TEUL, cpu_mmu_index(env, true));
+    MemOpIdx oi = make_memop_idx(tcg_ctx->mo_te | MO_UL,
+                                 cpu_mmu_index(env, true));
     return do_ld4_mmu(env_cpu(env), addr, oi, 0, MMU_INST_FETCH);
 }
 
 uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
 {
-    MemOpIdx oi = make_memop_idx(MO_TEUQ, cpu_mmu_index(env, true));
+    MemOpIdx oi = make_memop_idx(tcg_ctx->mo_te | MO_UQ,
+                                 cpu_mmu_index(env, true));
     return do_ld8_mmu(env_cpu(env), addr, oi, 0, MMU_INST_FETCH);
 }
 
-- 
2.43.0


