Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84821761B1C
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:13:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOIkn-00050l-M7; Tue, 25 Jul 2023 10:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIkd-0003tr-5Y; Tue, 25 Jul 2023 10:11:00 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIka-0007cg-Gi; Tue, 25 Jul 2023 10:10:58 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 54A651616E;
 Tue, 25 Jul 2023 17:10:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id F204919507;
 Tue, 25 Jul 2023 17:10:12 +0300 (MSK)
Received: (nullmailer pid 3372605 invoked by uid 1000);
 Tue, 25 Jul 2023 14:10:11 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Song Gao <gaosong@loongson.cn>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.5 12/14] target/loongarch: Fix the CSRRD CPUID
 instruction on big endian hosts
Date: Tue, 25 Jul 2023 17:10:06 +0300
Message-Id: <20230725141009.3372529-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.5-20230725170615@cover.tls.msk.ru>
References: <qemu-stable-7.2.5-20230725170615@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The test in tests/avocado/machine_loongarch.py is currently failing
on big endian hosts like s390x. By comparing the traces between running
the QEMU_EFI.fd bios on a s390x and on a x86 host, it's quickly obvious
that the CSRRD instruction for the CPUID is behaving differently. And
indeed: The code currently does a long read (i.e. 64 bit) from the
address that points to the CPUState->cpu_index field (with tcg_gen_ld_tl()
in the trans_csrrd() function). But this cpu_index field is only an "int"
(i.e. 32 bit). While this dirty pointer magic works on little endian hosts,
it of course fails on big endian hosts. Fix it by using a proper helper
function instead.

Message-Id: <20230720175307.854460-1-thuth@redhat.com>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit c34ad459926f6c600a55fe6782a27edfa405d60b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index e15c633b0b..6fc583f3e8 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -317,6 +317,7 @@ typedef struct CPUArchState {
     uint64_t CSR_DBG;
     uint64_t CSR_DERA;
     uint64_t CSR_DSAVE;
+    uint64_t CSR_CPUID;
 
 #ifndef CONFIG_USER_ONLY
     LoongArchTLB  tlb[LOONGARCH_TLB_MAX];
diff --git a/target/loongarch/csr_helper.c b/target/loongarch/csr_helper.c
index 7e02787895..b778e6952d 100644
--- a/target/loongarch/csr_helper.c
+++ b/target/loongarch/csr_helper.c
@@ -36,6 +36,15 @@ target_ulong helper_csrrd_pgd(CPULoongArchState *env)
     return v;
 }
 
+target_ulong helper_csrrd_cpuid(CPULoongArchState *env)
+{
+    LoongArchCPU *lac = env_archcpu(env);
+
+    env->CSR_CPUID = CPU(lac)->cpu_index;
+
+    return env->CSR_CPUID;
+}
+
 target_ulong helper_csrrd_tval(CPULoongArchState *env)
 {
     LoongArchCPU *cpu = env_archcpu(env);
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 9c01823a26..f47b0f2d05 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -98,6 +98,7 @@ DEF_HELPER_1(rdtime_d, i64, env)
 #ifndef CONFIG_USER_ONLY
 /* CSRs helper */
 DEF_HELPER_1(csrrd_pgd, i64, env)
+DEF_HELPER_1(csrrd_cpuid, i64, env)
 DEF_HELPER_1(csrrd_tval, i64, env)
 DEF_HELPER_2(csrwr_estat, i64, env, tl)
 DEF_HELPER_2(csrwr_asid, i64, env, tl)
diff --git a/target/loongarch/insn_trans/trans_privileged.c.inc b/target/loongarch/insn_trans/trans_privileged.c.inc
index 40f82becb0..e3d92c7a22 100644
--- a/target/loongarch/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/insn_trans/trans_privileged.c.inc
@@ -99,13 +99,7 @@ static const CSRInfo csr_info[] = {
     CSR_OFF(PWCH),
     CSR_OFF(STLBPS),
     CSR_OFF(RVACFG),
-    [LOONGARCH_CSR_CPUID] = {
-        .offset = (int)offsetof(CPUState, cpu_index)
-                  - (int)offsetof(LoongArchCPU, env),
-        .flags = CSRFL_READONLY,
-        .readfn = NULL,
-        .writefn = NULL
-    },
+    CSR_OFF_FUNCS(CPUID, CSRFL_READONLY, gen_helper_csrrd_cpuid, NULL),
     CSR_OFF_FLAGS(PRCFG1, CSRFL_READONLY),
     CSR_OFF_FLAGS(PRCFG2, CSRFL_READONLY),
     CSR_OFF_FLAGS(PRCFG3, CSRFL_READONLY),
-- 
2.39.2


