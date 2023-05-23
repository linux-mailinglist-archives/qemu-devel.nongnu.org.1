Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A25370DA4E
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:21:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1P8W-00081U-81; Tue, 23 May 2023 06:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P8T-0007xX-Qv; Tue, 23 May 2023 06:20:57 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P8R-0003BS-O4; Tue, 23 May 2023 06:20:57 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 247527D41;
 Tue, 23 May 2023 13:20:17 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 5C60972A8;
 Tue, 23 May 2023 13:20:16 +0300 (MSK)
Received: (nullmailer pid 86094 invoked by uid 1000);
 Tue, 23 May 2023 10:20:14 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Xinyu Li <lixinyu20s@ict.ac.cn>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.3 42/45] target/i386: fix avx2 instructions vzeroall and
 vpermdq
Date: Tue, 23 May 2023 13:17:19 +0300
Message-Id: <20230523102014.85954-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.3-20230523131604@cover.tls.msk.ru>
References: <qemu-stable-7.2.3-20230523131604@cover.tls.msk.ru>
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

From: Xinyu Li <lixinyu20s@ict.ac.cn>

vzeroall: xmm_regs should be used instead of xmm_t0
vpermdq: bit 3 and 7 of imm should be considered

Signed-off-by: Xinyu Li <lixinyu20s@ict.ac.cn>
Message-Id: <20230510145222.586487-1-lixinyu20s@ict.ac.cn>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 056d649007bc9fdae9f1d576e77c1316e9a34468)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 3cbc36a59d..44c1e70093 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -2493,6 +2493,14 @@ void helper_vpermdq_ymm(Reg *d, Reg *v, Reg *s, uint32_t order)
     d->Q(1) = r1;
     d->Q(2) = r2;
     d->Q(3) = r3;
+    if (order & 0x8) {
+        d->Q(0) = 0;
+        d->Q(1) = 0;
+    }
+    if (order & 0x80) {
+        d->Q(2) = 0;
+        d->Q(3) = 0;
+    }
 }
 
 void helper_vpermq_ymm(Reg *d, Reg *s, uint32_t order)
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 7296f3952c..5d31fce65d 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -2288,7 +2288,7 @@ static void gen_VZEROALL(DisasContext *s, CPUX86State *env, X86DecodedInsn *deco
 {
     TCGv_ptr ptr = tcg_temp_new_ptr();
 
-    tcg_gen_addi_ptr(ptr, cpu_env, offsetof(CPUX86State, xmm_t0));
+    tcg_gen_addi_ptr(ptr, cpu_env, offsetof(CPUX86State, xmm_regs));
     gen_helper_memset(ptr, ptr, tcg_constant_i32(0),
                       tcg_constant_ptr(CPU_NB_REGS * sizeof(ZMMReg)));
     tcg_temp_free_ptr(ptr);
-- 
2.39.2


