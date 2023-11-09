Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F28A87E6B76
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:48:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15MM-0006DC-3T; Thu, 09 Nov 2023 08:46:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15M2-00063b-2p; Thu, 09 Nov 2023 08:45:54 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15Lz-0001fa-7p; Thu, 09 Nov 2023 08:45:53 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3746231B12;
 Thu,  9 Nov 2023 16:43:13 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4763D344B8;
 Thu,  9 Nov 2023 16:43:05 +0300 (MSK)
Received: (nullmailer pid 1461839 invoked by uid 1000);
 Thu, 09 Nov 2023 13:43:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.3 26/55] target/arm: Correctly propagate stage 1 BTI
 guarded bit in a two-stage walk
Date: Thu,  9 Nov 2023 16:42:30 +0300
Message-Id: <20231109134300.1461632-26-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
References: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
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

In a two-stage translation, the result of the BTI guarded bit should
be the guarded bit from the first stage of translation, as there is
no BTI guard information in stage two.  Our code tried to do this,
but got it wrong, because we currently have two fields where the GP
bit information might live (ARMCacheAttrs::guarded and
CPUTLBEntryFull::extra::arm::guarded), and we were storing the GP bit
in the latter during the stage 1 walk but trying to copy the former
in combine_cacheattrs().

Remove the duplicated storage, and always use the field in
CPUTLBEntryFull; correctly propagate the stage 1 value to the output
in get_phys_addr_twostage().

Note for stable backports: in v8.0 and earlier the field is named
result->f.guarded, not result->f.extra.arm.guarded.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1950
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20231031173723.26582-1-peter.maydell@linaro.org
(cherry picked from commit 4c09abeae8704970ff03bf2196973f6bf08ab6f9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: replace f.extra.arm.guarded -> f.guarded due to v8.1.0-1179-ga81fef4b64)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 0f01bc32a8..784f1e0fab 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1180,7 +1180,6 @@ typedef struct ARMCacheAttrs {
     unsigned int attrs:8;
     unsigned int shareability:2; /* as in the SH field of the VMSAv8-64 PTEs */
     bool is_s2_format:1;
-    bool guarded:1;              /* guarded bit of the v8-64 PTE */
 } ARMCacheAttrs;
 
 /* Fields that are valid upon success. */
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 8f94100c61..3195d5d401 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2979,7 +2979,6 @@ static ARMCacheAttrs combine_cacheattrs(uint64_t hcr,
 
     assert(!s1.is_s2_format);
     ret.is_s2_format = false;
-    ret.guarded = s1.guarded;
 
     if (s1.attrs == 0xf0) {
         tagged = true;
@@ -3119,7 +3118,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     int s1_prot, s1_lgpgsz;
     bool is_secure = ptw->in_secure;
     ARMSecuritySpace in_space = ptw->in_space;
-    bool ret, ipa_secure;
+    bool ret, ipa_secure, s1_guarded;
     ARMCacheAttrs cacheattrs1;
     ARMSecuritySpace ipa_space;
     uint64_t hcr;
@@ -3147,6 +3146,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
      */
     s1_prot = result->f.prot;
     s1_lgpgsz = result->f.lg_page_size;
+    s1_guarded = result->f.guarded;
     cacheattrs1 = result->cacheattrs;
     memset(result, 0, sizeof(*result));
 
@@ -3197,6 +3197,9 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     result->cacheattrs = combine_cacheattrs(hcr, cacheattrs1,
                                             result->cacheattrs);
 
+    /* No BTI GP information in stage 2, we just use the S1 value */
+    result->f.guarded = s1_guarded;
+
     /*
      * Check if IPA translates to secure or non-secure PA space.
      * Note that VSTCR overrides VTCR and {N}SW overrides {N}SA.
-- 
2.39.2


