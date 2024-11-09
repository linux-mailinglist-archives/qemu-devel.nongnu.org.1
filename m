Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0EB9C2D31
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Nov 2024 13:42:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kOx-0005DS-0M; Sat, 09 Nov 2024 07:17:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kNv-0004St-3K; Sat, 09 Nov 2024 07:16:13 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kNt-00055M-FQ; Sat, 09 Nov 2024 07:16:10 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 65AFEA1635;
 Sat,  9 Nov 2024 15:08:07 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 2C2E0167FBC;
 Sat,  9 Nov 2024 15:09:02 +0300 (MSK)
Received: (nullmailer pid 3296163 invoked by uid 1000);
 Sat, 09 Nov 2024 12:09:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.2 12/58] target/i386: Use probe_access_full_mmu in
 ptw_translate
Date: Sat,  9 Nov 2024 15:08:13 +0300
Message-Id: <20241109120901.3295995-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
References: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

The probe_access_full_mmu function was designed for this purpose,
and does not report the memory operation event to plugins.

Cc: qemu-stable@nongnu.org
Fixes: 6d03226b422 ("plugins: force slow path when plugins instrument memory ops")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241013184733.1423747-3-richard.henderson@linaro.org>
(cherry picked from commit 115ade42d50144c15b74368d32dc734ea277d853)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 8cb0d80177..8b046ee4be 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -62,12 +62,11 @@ typedef struct PTETranslate {
 
 static bool ptw_translate(PTETranslate *inout, hwaddr addr, uint64_t ra)
 {
-    CPUTLBEntryFull *full;
     int flags;
 
     inout->gaddr = addr;
-    flags = probe_access_full(inout->env, addr, 0, MMU_DATA_STORE,
-                              inout->ptw_idx, true, &inout->haddr, &full, ra);
+    flags = probe_access_full_mmu(inout->env, addr, 0, MMU_DATA_STORE,
+                                  inout->ptw_idx, &inout->haddr, NULL);
 
     if (unlikely(flags & TLB_INVALID_MASK)) {
         TranslateFault *err = inout->err;
@@ -440,9 +439,8 @@ do_check_protect_pse36:
         CPUTLBEntryFull *full;
         int flags, nested_page_size;
 
-        flags = probe_access_full(env, paddr, 0, access_type,
-                                  MMU_NESTED_IDX, true,
-                                  &pte_trans.haddr, &full, 0);
+        flags = probe_access_full_mmu(env, paddr, 0, access_type,
+                                      MMU_NESTED_IDX, &pte_trans.haddr, &full);
         if (unlikely(flags & TLB_INVALID_MASK)) {
             *err = (TranslateFault){
                 .error_code = env->error_code,
-- 
2.39.5


