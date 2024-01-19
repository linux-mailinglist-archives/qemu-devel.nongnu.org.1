Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E26A832B75
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:42:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQq2l-0005mN-2X; Fri, 19 Jan 2024 09:40:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2d-0005m3-Nn
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:19 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2b-0003TG-Dr
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HGHmcwrFsDedpDfs3+LaapRdnSkQbjFoJJJVWFRxpII=; b=a9ZpVltxm+1/D5ON2xjzmtkekB
 EMaTOu+5+RvJ+5bgNesO0WP54KIIzxLh6VdwdDK+0p0CAuFEDsM5gUcBeO0JaX6S2EqZdv9t5iXom
 Eg2fsWf+3L8fgKTQ0tCIMYRYtBMRjLQ6VodYUXKxnL+oKScTzoQfbv6JOAq/K7xSJDgI=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	richard.henderson@linaro.org,
	philmd@linaro.org
Subject: [RFC PATCH 05/34] target/tricore: [VADDR] Use target_ulong for EA
Date: Fri, 19 Jan 2024 15:39:55 +0100
Message-ID: <20240119144024.14289-6-anjo@rev.ng>
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

Prepares target for typedef'ing abi_ptr to vaddr.  Fixes sign extension
bug that would result from abi_ptr being unsigned in the future.

Necessary to make memory access function signatures target agnostic.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/tricore/op_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 89be1ed648..f57bb39d1f 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -2395,7 +2395,7 @@ static bool cdc_zero(target_ulong *psw)
     return count == 0;
 }
 
-static void save_context_upper(CPUTriCoreState *env, int ea)
+static void save_context_upper(CPUTriCoreState *env, target_ulong ea)
 {
     cpu_stl_data(env, ea, env->PCXI);
     cpu_stl_data(env, ea+4, psw_read(env));
@@ -2415,7 +2415,7 @@ static void save_context_upper(CPUTriCoreState *env, int ea)
     cpu_stl_data(env, ea+60, env->gpr_d[15]);
 }
 
-static void save_context_lower(CPUTriCoreState *env, int ea)
+static void save_context_lower(CPUTriCoreState *env, target_ulong ea)
 {
     cpu_stl_data(env, ea, env->PCXI);
     cpu_stl_data(env, ea+4, env->gpr_a[11]);
@@ -2435,7 +2435,7 @@ static void save_context_lower(CPUTriCoreState *env, int ea)
     cpu_stl_data(env, ea+60, env->gpr_d[7]);
 }
 
-static void restore_context_upper(CPUTriCoreState *env, int ea,
+static void restore_context_upper(CPUTriCoreState *env, target_ulong ea,
                                   target_ulong *new_PCXI, target_ulong *new_PSW)
 {
     *new_PCXI = cpu_ldl_data(env, ea);
@@ -2456,7 +2456,7 @@ static void restore_context_upper(CPUTriCoreState *env, int ea,
     env->gpr_d[15] = cpu_ldl_data(env, ea+60);
 }
 
-static void restore_context_lower(CPUTriCoreState *env, int ea,
+static void restore_context_lower(CPUTriCoreState *env, target_ulong ea,
                                   target_ulong *ra, target_ulong *pcxi)
 {
     *pcxi = cpu_ldl_data(env, ea);
-- 
2.43.0


