Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFBD9A1385
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Oct 2024 22:13:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1AM6-0004o6-6s; Wed, 16 Oct 2024 16:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t1AM3-0004nc-Iu; Wed, 16 Oct 2024 16:10:47 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t1AM1-0000g9-Ua; Wed, 16 Oct 2024 16:10:47 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D2CC298F97;
 Wed, 16 Oct 2024 23:10:06 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id BED0C156377;
 Wed, 16 Oct 2024 23:10:26 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.1 37/49] target/m68k: Always return a temporary from
 gen_lea_mode
Date: Wed, 16 Oct 2024 23:09:56 +0300
Message-Id: <20241016201025.256294-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.1-20241016195251@cover.tls.msk.ru>
References: <qemu-stable-9.1.1-20241016195251@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Richard Henderson <richard.henderson@linaro.org>

Returning a raw areg does not preserve the value if the areg
is subsequently modified.  Fixes, e.g. "jsr (sp)", where the
return address is pushed before the branch.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2483
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240813000737.228470-1-richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 352cc9f300d83ea48b8154bfd2ff985fece887d0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 445966fb6a..ad3ce34501 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -720,7 +720,9 @@ static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
         }
         /* fallthru */
     case 2: /* Indirect register */
-        return get_areg(s, reg0);
+        tmp = tcg_temp_new();
+        tcg_gen_mov_i32(tmp, get_areg(s, reg0));
+        return tmp;
     case 4: /* Indirect predecrememnt.  */
         if (opsize == OS_UNSIZED) {
             return NULL_QREG;
@@ -747,20 +749,23 @@ static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
         switch (reg0) {
         case 0: /* Absolute short.  */
             offset = (int16_t)read_im16(env, s);
-            return tcg_constant_i32(offset);
+            break;
         case 1: /* Absolute long.  */
             offset = read_im32(env, s);
-            return tcg_constant_i32(offset);
+            break;
         case 2: /* pc displacement  */
             offset = s->pc;
             offset += (int16_t)read_im16(env, s);
-            return tcg_constant_i32(offset);
+            break;
         case 3: /* pc index+displacement.  */
             return gen_lea_indexed(env, s, NULL_QREG);
         case 4: /* Immediate.  */
         default:
             return NULL_QREG;
         }
+        tmp = tcg_temp_new();
+        tcg_gen_movi_i32(tmp, offset);
+        return tmp;
     }
     /* Should never happen.  */
     return NULL_QREG;
-- 
2.39.5


