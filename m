Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C19580EBA1
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 13:24:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD1jy-00067i-Nv; Tue, 12 Dec 2023 07:19:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rD1jv-00065Z-7f; Tue, 12 Dec 2023 07:19:55 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rD1jt-0000PP-D7; Tue, 12 Dec 2023 07:19:54 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DC26F3AF03;
 Tue, 12 Dec 2023 15:18:49 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A1EFF3B951;
 Tue, 12 Dec 2023 15:18:32 +0300 (MSK)
Received: (nullmailer pid 1003444 invoked by uid 1000);
 Tue, 12 Dec 2023 12:18:31 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.4 15/31] target/arm: Set IL bit for pauth, SVE access,
 BTI trap syndromes
Date: Tue, 12 Dec 2023 15:18:03 +0300
Message-Id: <20231212121831.1003318-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.4-20231211211211@cover.tls.msk.ru>
References: <qemu-stable-8.1.4-20231211211211@cover.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

The syndrome register value always has an IL field at bit 25, which
is 0 for a trap on a 16 bit instruction, and 1 for a trap on a 32
bit instruction (or for exceptions which aren't traps on a known
instruction, like PC alignment faults). This means that our
syn_*() functions should always either take an is_16bit argument to
determine whether to set the IL bit, or else unconditionally set it.

We missed setting the IL bit for the syndrome for three kinds of trap:
 * an SVE access exception
 * a pointer authentication check failure
 * a BTI (branch target identification) check failure

All of these traps are AArch64 only, and so the instruction causing
the trap is always 64 bit. This means we can unconditionally set
the IL bit in the syn_*() function.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20231120150121.3458408-1-peter.maydell@linaro.org
Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 11a3c4a286d5dc603582ea0a1fca62c2ec0a1aee)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 62254d0e51..63d0f37a1c 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -214,7 +214,7 @@ static inline uint32_t syn_simd_access_trap(int cv, int cond, bool is_16bit)
 
 static inline uint32_t syn_sve_access_trap(void)
 {
-    return EC_SVEACCESSTRAP << ARM_EL_EC_SHIFT;
+    return (EC_SVEACCESSTRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL;
 }
 
 /*
@@ -234,12 +234,12 @@ static inline uint32_t syn_smetrap(SMEExceptionType etype, bool is_16bit)
 
 static inline uint32_t syn_pactrap(void)
 {
-    return EC_PACTRAP << ARM_EL_EC_SHIFT;
+    return (EC_PACTRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL;
 }
 
 static inline uint32_t syn_btitrap(int btype)
 {
-    return (EC_BTITRAP << ARM_EL_EC_SHIFT) | btype;
+    return (EC_BTITRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL | btype;
 }
 
 static inline uint32_t syn_bxjtrap(int cv, int cond, int rm)
-- 
2.39.2


