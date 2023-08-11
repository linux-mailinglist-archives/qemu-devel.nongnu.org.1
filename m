Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD337799AF
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 23:42:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUZsJ-0003DG-J5; Fri, 11 Aug 2023 17:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUZsF-00039I-Tk
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 17:40:47 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUZsB-00028D-Ct
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 17:40:47 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5656a5c6721so1050535a12.1
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 14:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691790035; x=1692394835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pChxNirlraRYOfgvzNXN92a7ooajSSwt88FFZF1EmHQ=;
 b=I1HvykKHU6sj+hPtBmTJF7eqm3wA4m7TW37lJt8PfiChhxosukmBpCrgPPacArDYBC
 lTbIcRIvGPF1S7ulqKGabJ9Zgg65WzOBAEH/qn5tJ5SOnGOL8sLx7YSCVuSLccxeoehh
 Dd/ed9lPrdj4xrFl1ajUODjsmPnqrJU8kyHEjP42TZlhs/WjblZA65bQYdU5Qo+nl2PI
 99e+hFQnq5YulbVci+gdsDs9tdJGzn8JU0NNFTF9M67aK+6K5MXX2sT1RpmUxW0hLfKt
 /9X9F8qwH6THYmlio0yeCsRreTC0mc6Ho0q871nBFsI8YS1VwvubY9sY6nmIa+L3nE92
 RaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691790035; x=1692394835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pChxNirlraRYOfgvzNXN92a7ooajSSwt88FFZF1EmHQ=;
 b=eqdPMsBA5A+hi2ftNv6RPzUmmjlPkfQXIA5nDhyV8r8LgaAZugURxeB9Y71N4n6LQ7
 hhubM13x7fS1eJ5NlE6HsSvsy87TKs2e55bAYgcu79IQq+0uDm3rOyYHFIOgIePOJ9n4
 hpBtDV5Scezpru2+bGv9c5HooT1QlEUXqfupmnSwGFuN9wFvoTsBTPQPkWgfjiuJjjRW
 I6vN8ZiBYaSLvwuNPzlzXLnYpp2SzE2407UjcDPnRMhvdxmEqGosq3dZ2cxQHsyorXgZ
 Pl3PWXXzmbIO4pb/+N1svm71Mj2ZBKKnaXVqzKB58+5jLknMOg4NEbyCdRTq1D2UPm8Y
 NbXA==
X-Gm-Message-State: AOJu0YzC1RyJ7wIKOj4Dpjt/wEnt3eUV5RX9nSU5JocCrzs3sMFtVBaR
 uuW7uS/pB8B7ksFR4ehMcwH/UtAVQdjaDAdOb1w=
X-Google-Smtp-Source: AGHT+IF2O+dToCNPHQdgTMM2EwiS0fOFjV8Hs7GChJTeOs1ZBIaJKvfbzt3lTFRQKKUFOOTEPWMeVw==
X-Received: by 2002:a17:90a:fee:b0:268:1489:959e with SMTP id
 101-20020a17090a0fee00b002681489959emr2141082pjz.33.1691790035674; 
 Fri, 11 Aug 2023 14:40:35 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 gk18-20020a17090b119200b00263ba6a248bsm5723840pjb.1.2023.08.11.14.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 14:40:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 03/11] target/arm: Support more GM blocksizes
Date: Fri, 11 Aug 2023 14:40:23 -0700
Message-Id: <20230811214031.171020-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811214031.171020-1-richard.henderson@linaro.org>
References: <20230811214031.171020-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Support all of the easy GM block sizes.
Use direct memory operations, since the pointers are aligned.

While BS=2 (16 bytes, 1 tag) is a legal setting, that requires
an atomic store of one nibble.  This is not difficult, but there
is also no point in supporting it until required.

Note that cortex-a710 sets GM blocksize to match its cacheline
size of 64 bytes.  I expect many implementations will also
match the cacheline, which makes 16 bytes very unlikely.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c            | 18 +++++++++---
 target/arm/tcg/mte_helper.c | 56 +++++++++++++++++++++++++++++++------
 2 files changed, 62 insertions(+), 12 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 93c28d50e5..37e8c35677 100644
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
index 3640c6e57f..b23d11563a 100644
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


