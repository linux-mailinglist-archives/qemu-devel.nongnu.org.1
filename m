Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1427370DA47
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:20:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1P4V-0008B1-Cx; Tue, 23 May 2023 06:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P4I-0007NG-Lx; Tue, 23 May 2023 06:16:41 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P4F-00021F-J8; Tue, 23 May 2023 06:16:37 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8976B7D00;
 Tue, 23 May 2023 13:15:52 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id D3DB07290;
 Tue, 23 May 2023 13:15:51 +0300 (MSK)
Received: (nullmailer pid 85532 invoked by uid 1000);
 Tue, 23 May 2023 10:15:48 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Xinyu Li <lixinyu20s@ict.ac.cn>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.1 50/59] target/i386: fix avx2 instructions vzeroall and
 vpermdq
Date: Tue, 23 May 2023 13:15:10 +0300
Message-Id: <20230523101536.85424-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.1-20230523131351@cover.tls.msk.ru>
References: <qemu-stable-8.0.1-20230523131351@cover.tls.msk.ru>
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
index 0bd6bfad8a..fb63af7afa 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -2497,6 +2497,14 @@ void helper_vpermdq_ymm(Reg *d, Reg *v, Reg *s, uint32_t order)
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
index 95fb4f52fa..4fe8dec427 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -2285,7 +2285,7 @@ static void gen_VZEROALL(DisasContext *s, CPUX86State *env, X86DecodedInsn *deco
 {
     TCGv_ptr ptr = tcg_temp_new_ptr();
 
-    tcg_gen_addi_ptr(ptr, cpu_env, offsetof(CPUX86State, xmm_t0));
+    tcg_gen_addi_ptr(ptr, cpu_env, offsetof(CPUX86State, xmm_regs));
     gen_helper_memset(ptr, ptr, tcg_constant_i32(0),
                       tcg_constant_ptr(CPU_NB_REGS * sizeof(ZMMReg)));
 }
-- 
2.39.2


