Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1FEBAF726
	for <lists+qemu-devel@lfdr.de>; Wed, 01 Oct 2025 09:39:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rIw-0005P8-Ig; Wed, 01 Oct 2025 03:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v3rIe-0005Kv-Pr
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:30:57 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v3rIT-0003Oz-Li
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=NOR49bwJX2s9a0uvnvxCDCmxkcsC4Tc1+xtqicc/AMw=; b=D8Gep2bTRI/I3Qt
 KcyAO38m0MjmHpuXv0xOu82Ou/cN1GQMgblRg1YRO5RxWdrb2VfiXqeosFsF+oqtez5Tvm2BGO3wU
 dwssT2u5DCE3SS1LRBbxa2xKLvgqUYWT/ldFio//sXoSGExfc4ZJKeN8n8DMO+W4/WABr6/zWnolr
 Lk=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org,
 richard.henderson@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
Subject: [PATCH v2 01/33] target/riscv: Use 32 bits for misa extensions
Date: Wed,  1 Oct 2025 09:32:34 +0200
Message-ID: <20251001073306.28573-2-anjo@rev.ng>
In-Reply-To: <20251001073306.28573-1-anjo@rev.ng>
References: <20251001073306.28573-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

uint32_t is already in use in most places storing misa extensions such
as CPUArchState::misa_exts, RISCVCPUProfile::misa_exts,
RISCVImpliedExtsRule::implied_misa_exts.  Additionally. the field is
already migrated as uint32_t.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 4a862da615..f05e06bb70 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -50,7 +50,7 @@ typedef struct CPUArchState CPURISCVState;
  */
 #define RISCV_UW2_ALWAYS_STORE_AMO 1
 
-#define RV(x) ((target_ulong)1 << (x - 'A'))
+#define RV(x) BIT(x - 'A')
 
 /*
  * Update misa_bits[], misa_ext_info_arr[] and misa_ext_cfgs[]
@@ -582,7 +582,7 @@ struct RISCVCPUClass {
     RISCVCPUDef *def;
 };
 
-static inline int riscv_has_ext(CPURISCVState *env, target_ulong ext)
+static inline int riscv_has_ext(CPURISCVState *env, uint32_t ext)
 {
     return (env->misa_ext & ext) != 0;
 }
-- 
2.51.0


