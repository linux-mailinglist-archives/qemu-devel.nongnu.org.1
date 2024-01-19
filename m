Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DBA832B6B
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:42:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQq38-0005xc-QY; Fri, 19 Jan 2024 09:40:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq30-0005te-QN
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:42 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2x-0003vo-3a
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DjxSXACS9aRGLaDJZ9SJB+xumCZSRJiN3/L86bO4BKU=; b=RBAyfiIAFWWvGSL0C5o+QK7vf+
 1fogDFYTdMEUORyLCl4t/SY2QjDD8jD+PFyOQxD4MmKz4PHCc832oBoLz8g4dMg0ue2f0cHykBiap
 qmBW3uEscbpnlgj19XclHf0mG79AP+p7iaoA49zsMGySlfkH5sL+HV0MviV4bkmeZX7E=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	richard.henderson@linaro.org,
	philmd@linaro.org
Subject: [RFC PATCH 28/34] accel/tcg: Make plugin-gen.c target independent
Date: Fri, 19 Jan 2024 15:40:18 +0100
Message-ID: <20240119144024.14289-29-anjo@rev.ng>
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

Switches computation of offsets into CPUState to use that the offset
between CPUState and CPUArchState is guaranteed to be sizeof(CPUState).

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 accel/tcg/plugin-gen.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index d31c9993ea..ce7635958f 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -43,10 +43,9 @@
  * CPU's index into a TCG temp, since the first callback did it already.
  */
 #include "qemu/osdep.h"
-#include "cpu.h"
 #include "tcg/tcg.h"
 #include "tcg/tcg-temp-internal.h"
-#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-common.h"
 #include "exec/exec-all.h"
 #include "exec/plugin-gen.h"
 #include "exec/translator.h"
@@ -104,8 +103,8 @@ static void gen_empty_udata_cb(void)
     TCGv_ptr udata = tcg_temp_ebb_new_ptr();
 
     tcg_gen_movi_ptr(udata, 0);
-    tcg_gen_ld_i32(cpu_index, tcg_env,
-                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+    tcg_gen_ld_i32(cpu_index, tcg_env, offsetof(CPUState, cpu_index) -
+                                       sizeof(CPUState));
     gen_helper_plugin_vcpu_udata_cb(cpu_index, udata);
 
     tcg_temp_free_ptr(udata);
@@ -138,8 +137,8 @@ static void gen_empty_mem_cb(TCGv_i64 addr, uint32_t info)
 
     tcg_gen_movi_i32(meminfo, info);
     tcg_gen_movi_ptr(udata, 0);
-    tcg_gen_ld_i32(cpu_index, tcg_env,
-                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+    tcg_gen_ld_i32(cpu_index, tcg_env, offsetof(CPUState, cpu_index) -
+                                       sizeof(CPUState));
 
     gen_helper_plugin_vcpu_mem_cb(cpu_index, meminfo, addr, udata);
 
@@ -158,7 +157,7 @@ static void gen_empty_mem_helper(void)
 
     tcg_gen_movi_ptr(ptr, 0);
     tcg_gen_st_ptr(ptr, tcg_env, offsetof(CPUState, plugin_mem_cbs) -
-                                 offsetof(ArchCPU, env));
+                                 sizeof(CPUState));
     tcg_temp_free_ptr(ptr);
 }
 
@@ -582,7 +581,7 @@ void plugin_gen_disable_mem_helpers(void)
         return;
     }
     tcg_gen_st_ptr(tcg_constant_ptr(NULL), tcg_env,
-                   offsetof(CPUState, plugin_mem_cbs) - offsetof(ArchCPU, env));
+                   offsetof(CPUState, plugin_mem_cbs) - sizeof(CPUState));
 }
 
 static void plugin_gen_tb_udata(const struct qemu_plugin_tb *ptb,
-- 
2.43.0


