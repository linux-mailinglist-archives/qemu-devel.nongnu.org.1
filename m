Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A846754914
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 16:02:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfm2-0001OQ-8W; Sat, 15 Jul 2023 09:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKflb-00018I-D1
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:56:59 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKflZ-0003UC-OK
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:56:59 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fbc244d384so26670805e9.0
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429416; x=1692021416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/qx14gk5I4WzFXUubYo3gGMTlVb0WZhBx/ntAFiHBZ8=;
 b=UKL0sVkPD5MSqpKA1oiDlkuHHXXIAaxMiwtf13zBQfJXzIYKZbTj6fAfHocoKqzs1a
 YWenrtWmrIHZsd8ddf0urAvr11i3iMBf7/M9SKdWUtLUjf716o7wnxjH/TKAcB2o62gq
 0o9lWjLXqaRVuT52Jjw7g7g09s91sSGBynEjIpSLGelOGbqE7No+XIfIcF6Vt7t1svuS
 5egGcuchWQ51tLrF+TsUxd4wFxa/7e9Lz0Gw6u9TmqVIZ3rFYFDGUoBMuqlxtyCsws8s
 3Go2QsqJhHQMLmNCms4NTTQMP/XVWtE4a4Y6/Fvw38g929cazieJ5N599wBXRpLvhiVg
 JhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429416; x=1692021416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/qx14gk5I4WzFXUubYo3gGMTlVb0WZhBx/ntAFiHBZ8=;
 b=HVF/iTdwmSdYOL28P/2FVvp2wcKfNQ6edIvs+2TZplG9/tdO/WbHBYfvnb9gK+lQkg
 uYsQi6/MkEvMEYo5ydIFaYnduspBuXoRQynMHWydx7vb8OlGeOh3Gma6tU74Qr40fW/g
 SAA5afyBpHf2WazFKx0vANGux2ti5+GHSxKV4NmZn912bc56i3XNueI1OHK8EuzubFBR
 MQAsI5z9daSpUkoht7fNQproalE1zX7MHK1xKobLXG4y7piGpqLmHi2Aerb5UieU2VV1
 wEtm2PsWi1vn+Fhu21QaP5/LJrKUPBnO9uxTWubYAuucuZKf48nIwmd0x3xD5ZEDdTNm
 sLXw==
X-Gm-Message-State: ABy/qLZQE8T7jQuF2LIsKQgUGqealmey6SEyzW8CjUteJSS0bvEZetEB
 QbejFU5IR6IqaLoW2nxF26N3C9o4Wi05+NF5MEqgnw==
X-Google-Smtp-Source: APBJJlGKmER7/TI6qjt7vGx6SQj7U7QXYvwS65fJFGyQe8v2otgqBd5ep8+9rlfzdsuto6hxwKGzxA==
X-Received: by 2002:a5d:664d:0:b0:314:3954:7ff6 with SMTP id
 f13-20020a5d664d000000b0031439547ff6mr5781995wrw.56.1689429415852; 
 Sat, 15 Jul 2023 06:56:55 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 r8-20020a056000014800b0030fa3567541sm13866651wrx.48.2023.07.15.06.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:56:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PULL 47/47] tcg: Use HAVE_CMPXCHG128 instead of CONFIG_CMPXCHG128
Date: Sat, 15 Jul 2023 14:53:17 +0100
Message-Id: <20230715135317.7219-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
index df60c7d673..ac38c2bf96 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -1433,7 +1433,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
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


