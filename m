Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 264A378EAD2
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:46:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbfB3-0003NM-N4; Thu, 31 Aug 2023 06:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfB0-0003I3-8r
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:27 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfAx-00042O-Gf
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:25 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso467404f8f.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693478722; x=1694083522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0tfdVnStaNkhnripPGAZual0o+sSnkMAkUnDX0QV/9I=;
 b=PIVcoiQxTGhllsoBJP9FcXQa+Kklav2aZqa8f/BAI3REWgi9iL8jfYR2cZXpaTL3FJ
 ypaVlememSRkq/hW+ZY+/vBg2ma715g9qL4PmAEfmkeAdfUUS+RPt/eT8mzb2DI7mbPu
 nX3MUk492DxqPAK9MVeVP1ThHqEgl1q+1hkqv/eQicM+BEmpcyVUiAYNFGcxLd1Wds7B
 joTh5U+YUKZAcllTM4T4jdCaJoPZCdu71k1gbk2JqtvgmAuvEIkI+PNBBFWzNc9v7Ujy
 zKmMuQU/il9bC0f7mYcMf30saU3qknb5ho/7/+QXCyQyLK2h5woZs4sUTSsXNCTLBDbv
 8p3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693478722; x=1694083522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0tfdVnStaNkhnripPGAZual0o+sSnkMAkUnDX0QV/9I=;
 b=IQ1M9Vgq2O8rPsStlYUYgqiPYf3Kbmds/4gz0S2JsYXf3r6MR5CrdBT29rQmuMdUUp
 8HCCNbzEwJK3x9M8bQuJNUpZrJ8tnVzzgYfIbtfHAnKdSn0u/UVnQROtkdvUyZTxeV4g
 0JoUaZTcH9B9RZeOBS1v6ENjgharUFKPQ2TDX+A8S6Ey9lnU4Sl5QBpV/p5uMB24u0Ob
 441TMHstjVXQ1MAh/omY2peT45j+49+EyJgetn6qZAyJK/Q1t/1h3l8O0zBHtW74dsTo
 U1rw03x74oU5Q7xO3CdhPfAevtcJ83BplHBex4jBE2r5A+w+RE4BLlv/4wyr8tWYME71
 OFsw==
X-Gm-Message-State: AOJu0Yxa/jasu8bmUTsTEogNm1s6u5bXL8KXq2aZI33yYbMUm6Dl1AD0
 5i4Pfmpy2DKsvHxFQrr8Jqy720FwX3okc5VkMVY=
X-Google-Smtp-Source: AGHT+IE6xAaGOeeEqaVsjaYcLY2r+Ef+yhdHYfljzQjiFamkIN8GZaRYr+WesPCwNrnKDYPz1Z+wTg==
X-Received: by 2002:a5d:568f:0:b0:31a:d3fd:221b with SMTP id
 f15-20020a5d568f000000b0031ad3fd221bmr3478186wrv.20.1693478721761; 
 Thu, 31 Aug 2023 03:45:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l5-20020adfe585000000b0031c71693449sm1785524wrm.1.2023.08.31.03.45.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 03:45:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/24] target/arm: Support more GM blocksizes
Date: Thu, 31 Aug 2023 11:44:58 +0100
Message-Id: <20230831104519.3520658-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831104519.3520658-1-peter.maydell@linaro.org>
References: <20230831104519.3520658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Support all of the easy GM block sizes.
Use direct memory operations, since the pointers are aligned.

While BS=2 (16 bytes, 1 tag) is a legal setting, that requires
an atomic store of one nibble.  This is not difficult, but there
is also no point in supporting it until required.

Note that cortex-a710 sets GM blocksize to match its cacheline
size of 64 bytes.  I expect many implementations will also
match the cacheline, which makes 16 bytes very unlikely.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230811214031.171020-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c            | 18 +++++++++---
 target/arm/tcg/mte_helper.c | 56 +++++++++++++++++++++++++++++++------
 2 files changed, 62 insertions(+), 12 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d906d2b1caa..fe73fd8af75 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2056,16 +2056,26 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
                                        ID_PFR1, VIRTUALIZATION, 0);
     }
 
+    if (cpu_isar_feature(aa64_mte, cpu)) {
+        /*
+         * The architectural range of GM blocksize is 2-6, however qemu
+         * doesn't support blocksize of 2 (see HELPER(ldgm)).
+         */
+        if (tcg_enabled()) {
+            assert(cpu->gm_blocksize >= 3 && cpu->gm_blocksize <= 6);
+        }
+
 #ifndef CONFIG_USER_ONLY
-    if (cpu->tag_memory == NULL && cpu_isar_feature(aa64_mte, cpu)) {
         /*
          * Disable the MTE feature bits if we do not have tag-memory
          * provided by the machine.
          */
-        cpu->isar.id_aa64pfr1 =
-            FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 0);
-    }
+        if (cpu->tag_memory == NULL) {
+            cpu->isar.id_aa64pfr1 =
+                FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 0);
+        }
 #endif
+    }
 
     if (tcg_enabled()) {
         /*
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 3640c6e57f5..b23d11563ab 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -428,6 +428,8 @@ uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr)
     int gm_bs = env_archcpu(env)->gm_blocksize;
     int gm_bs_bytes = 4 << gm_bs;
     void *tag_mem;
+    uint64_t ret;
+    int shift;
 
     ptr = QEMU_ALIGN_DOWN(ptr, gm_bs_bytes);
 
@@ -443,16 +445,41 @@ uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr)
 
     /*
      * The ordering of elements within the word corresponds to
-     * a little-endian operation.
+     * a little-endian operation.  Computation of shift comes from
+     *
+     *     index = address<LOG2_TAG_GRANULE+3:LOG2_TAG_GRANULE>
+     *     data<index*4+3:index*4> = tag
+     *
+     * Because of the alignment of ptr above, BS=6 has shift=0.
+     * All memory operations are aligned.  Defer support for BS=2,
+     * requiring insertion or extraction of a nibble, until we
+     * support a cpu that requires it.
      */
     switch (gm_bs) {
+    case 3:
+        /* 32 bytes -> 2 tags -> 8 result bits */
+        ret = *(uint8_t *)tag_mem;
+        break;
+    case 4:
+        /* 64 bytes -> 4 tags -> 16 result bits */
+        ret = cpu_to_le16(*(uint16_t *)tag_mem);
+        break;
+    case 5:
+        /* 128 bytes -> 8 tags -> 32 result bits */
+        ret = cpu_to_le32(*(uint32_t *)tag_mem);
+        break;
     case 6:
         /* 256 bytes -> 16 tags -> 64 result bits */
-        return ldq_le_p(tag_mem);
+        return cpu_to_le64(*(uint64_t *)tag_mem);
     default:
-        /* cpu configured with unsupported gm blocksize. */
+        /*
+         * CPU configured with unsupported/invalid gm blocksize.
+         * This is detected early in arm_cpu_realizefn.
+         */
         g_assert_not_reached();
     }
+    shift = extract64(ptr, LOG2_TAG_GRANULE, 4) * 4;
+    return ret << shift;
 }
 
 void HELPER(stgm)(CPUARMState *env, uint64_t ptr, uint64_t val)
@@ -462,6 +489,7 @@ void HELPER(stgm)(CPUARMState *env, uint64_t ptr, uint64_t val)
     int gm_bs = env_archcpu(env)->gm_blocksize;
     int gm_bs_bytes = 4 << gm_bs;
     void *tag_mem;
+    int shift;
 
     ptr = QEMU_ALIGN_DOWN(ptr, gm_bs_bytes);
 
@@ -478,13 +506,25 @@ void HELPER(stgm)(CPUARMState *env, uint64_t ptr, uint64_t val)
         return;
     }
 
-    /*
-     * The ordering of elements within the word corresponds to
-     * a little-endian operation.
-     */
+    /* See LDGM for comments on BS and on shift.  */
+    shift = extract64(ptr, LOG2_TAG_GRANULE, 4) * 4;
+    val >>= shift;
     switch (gm_bs) {
+    case 3:
+        /* 32 bytes -> 2 tags -> 8 result bits */
+        *(uint8_t *)tag_mem = val;
+        break;
+    case 4:
+        /* 64 bytes -> 4 tags -> 16 result bits */
+        *(uint16_t *)tag_mem = cpu_to_le16(val);
+        break;
+    case 5:
+        /* 128 bytes -> 8 tags -> 32 result bits */
+        *(uint32_t *)tag_mem = cpu_to_le32(val);
+        break;
     case 6:
-        stq_le_p(tag_mem, val);
+        /* 256 bytes -> 16 tags -> 64 result bits */
+        *(uint64_t *)tag_mem = cpu_to_le64(val);
         break;
     default:
         /* cpu configured with unsupported gm blocksize. */
-- 
2.34.1


