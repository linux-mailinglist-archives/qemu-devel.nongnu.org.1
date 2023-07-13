Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33825752B97
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 22:25:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK2qs-0000HC-9d; Thu, 13 Jul 2023 16:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK2qf-0000GZ-1Y
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 16:23:37 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK2qd-0000B8-AP
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 16:23:36 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6b8decf09e1so994030a34.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 13:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689279812; x=1691871812;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ESU/jseMQ0JI7/+Izfwhp1xSSJZvw2rvtkO0jzEFJTY=;
 b=Zrfiwx7VDTxHWgEtU1gXT9yfYTjBnzHozaO5T8nK1GSmITNN1X4bAdVYDchlfIuEgA
 qJIwR0OZ2IMbsipeXkbgqsyk/O+tJVu52oWzhF4FSWCEcKMF+CIM7Uy2KpWAf1DZHDvU
 2NqeTXJXJuvXVM9puZjoKfuFm9KX7tdYvAX9KufsWTt8gtBPH0Y3GHcAiLgVJMW7ym2M
 E4H8bknUJGbej2vd8vGSKlU7r5inyrHzlf1cscyK04P1gurSY+FCVowxMsS/alJwB4j5
 lENLSPMktEyB0KY30oY5TSPqZj9Y0c35zi2Ej6tZQYLOZTkIHvXl9nIrW2F/QGvn9ggS
 8c/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689279812; x=1691871812;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ESU/jseMQ0JI7/+Izfwhp1xSSJZvw2rvtkO0jzEFJTY=;
 b=jwiNEctdjIltsPN0RYvAFqfFY8e88cpM9M5ghapk4j+Hobn6SAtRNacBApqj8MzHAd
 cucAG9+Dk0lko4C06GWeT1HrGCkLbD7e8Ai49/C7V5UKRd7YbBevmG4TuVpOuLCOCMU2
 fnj5qZFmp3TK6j3JirDdg5CcFe74huGpham7hkdKfGzDem4kVwxNQ/rwWo9ZLJhjHsn9
 z591qNRMXCeYY151yQubHJ2wxZUI5FuGKOn5o3dgHniioHxAhSz+glkS2DYS0vPjpkOO
 Lc0f32heiSu2qu283fzjjMwEs0Jzh/jwBL/NshVPyeM1Nr91bTJI98KeOSArKYMJJ2b7
 uQZA==
X-Gm-Message-State: ABy/qLZ6XXRb8HRtQDD8473jQSnYEDgKOpCoLMsqu50l1HnMcOXCX89h
 fxksBHag9Il4EqTvCzcaTMXvP/QXI+vp7Pr7km/aBw==
X-Google-Smtp-Source: APBJJlGSbvkvST1E+Tcr0YqOwzvSKkTAqAxh5rzQQTYS6mVzW0IwAwTlUWEAePilFwqfOsQFL5TqFQ==
X-Received: by 2002:a05:6830:1384:b0:6b9:3bfd:1477 with SMTP id
 d4-20020a056830138400b006b93bfd1477mr2657672otq.38.1689279812566; 
 Thu, 13 Jul 2023 13:23:32 -0700 (PDT)
Received: from stoup.. ([172.58.109.82]) by smtp.gmail.com with ESMTPSA id
 r16-20020a9d7cd0000000b006b9a98b9659sm1117918otn.19.2023.07.13.13.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 13:23:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PATCH for-8.1] tcg: Use HAVE_CMPXCHG128 instead of CONFIG_CMPXCHG128
Date: Thu, 13 Jul 2023 21:23:27 +0100
Message-Id: <20230713202327.12662-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

We adjust CONFIG_ATOMIC128 and CONFIG_CMPXCHG128 with
CONFIG_ATOMIC128_OPT in atomic128.h.  It is difficult
to tell when those changes have been applied with the
ifdef we must use with CONFIG_CMPXCHG128.  So instead
use HAVE_CMPXCHG128, which triggers -Werror-undef when
the proper header has not been included.

Improves tcg_gen_atomic_cmpxchg_i128 for s390x host, which
requires CONFIG_ATOMIC128_OPT.  Without this we fall back
to EXCP_ATOMIC to single-step 128-bit atomics, which is
slow enough to cause some tests to time out.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Thomas, this issue does not quite match the one you bisected, but
other than the cmpxchg, I don't see any see any qemu_{ld,st}_i128
being used in BootLinuxS390X.test_s390_ccw_virtio_tcg.

As far as I can see, this wasn't broken by the addition of
CONFIG_ATOMIC128_OPT, rather that fix didn't go far enough.

Anyway, test_s390_ccw_virtio_tcg now passes in 159s on our host.


r~
---
 accel/tcg/tcg-runtime.h            | 2 +-
 include/exec/helper-proto-common.h | 2 ++
 accel/tcg/cputlb.c                 | 2 +-
 accel/tcg/user-exec.c              | 2 +-
 tcg/tcg-op-ldst.c                  | 2 +-
 accel/tcg/atomic_common.c.inc      | 2 +-
 6 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 39e68007f9..186899a2c7 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -58,7 +58,7 @@ DEF_HELPER_FLAGS_5(atomic_cmpxchgq_be, TCG_CALL_NO_WG,
 DEF_HELPER_FLAGS_5(atomic_cmpxchgq_le, TCG_CALL_NO_WG,
                    i64, env, i64, i64, i64, i32)
 #endif
-#ifdef CONFIG_CMPXCHG128
+#if HAVE_CMPXCHG128
 DEF_HELPER_FLAGS_5(atomic_cmpxchgo_be, TCG_CALL_NO_WG,
                    i128, env, i64, i128, i128, i32)
 DEF_HELPER_FLAGS_5(atomic_cmpxchgo_le, TCG_CALL_NO_WG,
diff --git a/include/exec/helper-proto-common.h b/include/exec/helper-proto-common.h
index 4d4b022668..8b67170a22 100644
--- a/include/exec/helper-proto-common.h
+++ b/include/exec/helper-proto-common.h
@@ -7,6 +7,8 @@
 #ifndef HELPER_PROTO_COMMON_H
 #define HELPER_PROTO_COMMON_H
 
+#include "qemu/atomic128.h"  /* for HAVE_CMPXCHG128 */
+
 #define HELPER_H "accel/tcg/tcg-runtime.h"
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index c2b81ec569..e0079c9a9d 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -3105,7 +3105,7 @@ void cpu_st16_mmu(CPUArchState *env, target_ulong addr, Int128 val,
 #include "atomic_template.h"
 #endif
 
-#if defined(CONFIG_ATOMIC128) || defined(CONFIG_CMPXCHG128)
+#if defined(CONFIG_ATOMIC128) || HAVE_CMPXCHG128
 #define DATA_SIZE 16
 #include "atomic_template.h"
 #endif
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index d95b875a6a..e7225e10e9 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -1385,7 +1385,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
 #include "atomic_template.h"
 #endif
 
-#if defined(CONFIG_ATOMIC128) || defined(CONFIG_CMPXCHG128)
+#if defined(CONFIG_ATOMIC128) || HAVE_CMPXCHG128
 #define DATA_SIZE 16
 #include "atomic_template.h"
 #endif
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 0fcc1618e5..d54c305598 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -778,7 +778,7 @@ typedef void (*gen_atomic_op_i64)(TCGv_i64, TCGv_env, TCGv_i64,
 #else
 # define WITH_ATOMIC64(X)
 #endif
-#ifdef CONFIG_CMPXCHG128
+#if HAVE_CMPXCHG128
 # define WITH_ATOMIC128(X) X,
 #else
 # define WITH_ATOMIC128(X)
diff --git a/accel/tcg/atomic_common.c.inc b/accel/tcg/atomic_common.c.inc
index ee222fd7e7..95a5c5ff12 100644
--- a/accel/tcg/atomic_common.c.inc
+++ b/accel/tcg/atomic_common.c.inc
@@ -41,7 +41,7 @@ CMPXCHG_HELPER(cmpxchgq_be, uint64_t)
 CMPXCHG_HELPER(cmpxchgq_le, uint64_t)
 #endif
 
-#ifdef CONFIG_CMPXCHG128
+#if HAVE_CMPXCHG128
 CMPXCHG_HELPER(cmpxchgo_be, Int128)
 CMPXCHG_HELPER(cmpxchgo_le, Int128)
 #endif
-- 
2.34.1


