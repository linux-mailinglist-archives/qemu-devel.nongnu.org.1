Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4FFA9D4B4
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Apr 2025 23:58:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R1M-0007iC-1r; Fri, 25 Apr 2025 17:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R16-0007al-8u
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:28 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R12-0000aP-1X
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:27 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7369ce5d323so2257999b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618122; x=1746222922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hbFkhzXwarjvflQJmjm5fZX4JKTkrvAAsBglTX13RRA=;
 b=USXig2CLej8ZQ/EOIqnaG8lAp7Z1b2luRVC+SXRirxv3KNXPa5LIdoPF/TD1RyK048
 9dbk2IMtR2Tic8BqzdfHTj22mwKvlZBJ7vE0jszorD5fRsh/jfqwHLGD04CrH2ZlJCHO
 VOBNNG+W8ofKb1VWePN4IqMcp/+2JMBqlmUhuhDbvoxXj3utJBaluLksXwQA8pK64G1D
 NmP5JCnWBEcQmegeSJEa0sRAnLSo1wvl9cW6FSFBzP9WgOclwGy2yZpR+3TXE9byWVQ9
 Jicnp+mO+84IGI4EJVxXKEqDnVloXwTJlgs28kn3dhi/Kk3JK5t1QbhNH7ZZIfhUqkMk
 XCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618122; x=1746222922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hbFkhzXwarjvflQJmjm5fZX4JKTkrvAAsBglTX13RRA=;
 b=HTlhc/l4w7A8Qz6Y46q5sxyHjR2EbGfqQlwi+Vhji/exPVCAWuXWlJpSsSa1BjyLEb
 WKKosq+RV2vjRaqhY0+Iv2VnN97i+/LnwrRaOcUER7ITaOim5kUp+/IgEk4uW9OT29eU
 8UhNiEqJWXqk1vCLIjFthTdVLZPAijYR7nkQzUWuFDTNTqoPK8oH5IHfnwREtgi28/3o
 /fK3/LH4NRlXThR6Z/q4HMwYxyjrvy/QcytTB30MSpDZwhopvpX/T6Ji0M6yf8g0FG4f
 U35mCXBEKXfU5dCUqZSuZafDI5Xg4FxpncsevBWyKJlWP+Jp9Nhc6Dpy3prqdFe97o/N
 r2Dg==
X-Gm-Message-State: AOJu0Yx0J2Wdy8drTIc5PouXMilZ4Ccf5t9fII1EMgeD6/GgK1vvvzm1
 hkiOIhXB5OFXBV8SmzwIscH/reeBk4JPRoFiei4j2MY/O44eLYQwHxH7PwUb8G08PIQGWcbMh/w
 G
X-Gm-Gg: ASbGncuP28NFeVGw8iDUVvjAy1waAbMl0UsfH/uiVtENWVm1Itbuxjh7kKkz72hI1oF
 93h78S1jwPictTezRUy8vopv80JVOVr+F6/pZPg7O/vBI7hd3lqFDIHMHNIRq/8UXxiRRjm5U6t
 K288NOMMtFpVmkZVIS6Uj9wgmwHde+Vq9gcxovXVIW5P7ooRfqokb71FBsqigS1on9g5Ho0jDMd
 NmPVeLwcXtgeDUUT6nw+bd2P3lrsUjjpQK5i4yUh0fDVDUtZWwSGvN9Qm4Y3CMWUYL1Rz5iiyBF
 aObaAIitOwTVK+tfkMCpCD+J61cbLeurnWAk1/COTP1sCqfefwSyPYipSyS6OiXVxhBSeRlgcko
 =
X-Google-Smtp-Source: AGHT+IHKuQU+yRUIH8I5PVuY7KTAYG5iD4LYy5QW2ELJphCpDue6e4FJ1hR/XabA4qCMHOXljASL0Q==
X-Received: by 2002:a05:6a00:2e22:b0:736:339b:8296 with SMTP id
 d2e1a72fcca58-73fd896a1b8mr5045356b3a.18.1745618122439; 
 Fri, 25 Apr 2025 14:55:22 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259414b0sm3664392b3a.48.2025.04.25.14.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:55:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 037/159] tcg: Convert not to TCGOutOpUnary
Date: Fri, 25 Apr 2025 14:52:51 -0700
Message-ID: <20250425215454.886111-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-has.h     |  2 --
 tcg/arm/tcg-target-has.h         |  1 -
 tcg/i386/tcg-target-has.h        |  2 --
 tcg/loongarch64/tcg-target-has.h |  2 --
 tcg/mips/tcg-target-has.h        |  2 --
 tcg/ppc/tcg-target-has.h         |  2 --
 tcg/riscv/tcg-target-has.h       |  2 --
 tcg/s390x/tcg-target-has.h       |  2 --
 tcg/sparc64/tcg-target-has.h     |  2 --
 tcg/tcg-has.h                    |  1 -
 tcg/tci/tcg-target-has.h         |  2 --
 tcg/optimize.c                   |  4 ++--
 tcg/tcg-op.c                     | 10 ++++++----
 tcg/tcg.c                        |  8 ++++----
 tcg/tci.c                        |  2 --
 tcg/aarch64/tcg-target.c.inc     | 17 ++++++++++-------
 tcg/arm/tcg-target.c.inc         | 15 ++++++++++-----
 tcg/i386/tcg-target.c.inc        | 17 +++++++++++------
 tcg/loongarch64/tcg-target.c.inc | 17 ++++++++++-------
 tcg/mips/tcg-target.c.inc        | 20 ++++++++++----------
 tcg/ppc/tcg-target.c.inc         | 17 ++++++++++-------
 tcg/riscv/tcg-target.c.inc       | 17 ++++++++++-------
 tcg/s390x/tcg-target.c.inc       | 25 ++++++++++++++++---------
 tcg/sparc64/tcg-target.c.inc     | 20 ++++++++++----------
 tcg/tci/tcg-target.c.inc         | 13 ++++++++++---
 25 files changed, 119 insertions(+), 103 deletions(-)

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 240fcac2cc..7f18727686 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -17,7 +17,6 @@
 #define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
@@ -38,7 +37,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index e80711ee40..e766c6d628 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -26,7 +26,6 @@ extern bool use_neon_instructions;
 /* optional instructions */
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          use_armv7_instructions
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index b27f853dcd..3d36fe58f2 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -30,7 +30,6 @@
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        have_popcnt
@@ -51,7 +50,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        have_popcnt
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 7860432489..ffacb41e80 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -24,7 +24,6 @@
 #define TCG_TARGET_HAS_mulsh_i32        1
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        0
@@ -41,7 +40,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        0
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 987f83f761..9d8e0fb8df 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -41,7 +41,6 @@ extern bool use_mips32r2_instructions;
 /* optional instructions */
 #define TCG_TARGET_HAS_div_i32          1
 #define TCG_TARGET_HAS_rem_i32          1
-#define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_mulu2_i32        (!use_mips32r6_instructions)
 #define TCG_TARGET_HAS_muls2_i32        (!use_mips32r6_instructions)
 #define TCG_TARGET_HAS_muluh_i32        1
@@ -56,7 +55,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          1
-#define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_add2_i64         0
 #define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_mulu2_i64        (!use_mips32r6_instructions)
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 6be6d7f994..7ebcb49a19 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -22,7 +22,6 @@
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          have_isa_3_00
 #define TCG_TARGET_HAS_ctpop_i32        have_isa_2_06
@@ -44,7 +43,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          have_isa_3_00
 #define TCG_TARGET_HAS_ctpop_i64        have_isa_2_06
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index 0fcf940a8a..e3018717ea 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -24,7 +24,6 @@
 #define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_bswap16_i32      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap32_i32      (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_clz_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctz_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctpop_i32        (cpuinfo & CPUINFO_ZBB)
@@ -40,7 +39,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap32_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap64_i64      (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_clz_i64          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctz_i64          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctpop_i64        (cpuinfo & CPUINFO_ZBB)
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 374db3cf9d..e5c132cf12 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -33,7 +33,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_rot_i32        1
 #define TCG_TARGET_HAS_bswap16_i32    1
 #define TCG_TARGET_HAS_bswap32_i32    1
-#define TCG_TARGET_HAS_not_i32        HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_clz_i32        0
 #define TCG_TARGET_HAS_ctz_i32        0
 #define TCG_TARGET_HAS_ctpop_i32      1
@@ -53,7 +52,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_bswap16_i64    1
 #define TCG_TARGET_HAS_bswap32_i64    1
 #define TCG_TARGET_HAS_bswap64_i64    1
-#define TCG_TARGET_HAS_not_i64        HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_clz_i64        1
 #define TCG_TARGET_HAS_ctz_i64        0
 #define TCG_TARGET_HAS_ctpop_i64      1
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index 35ae536879..df87249df2 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -19,7 +19,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_rot_i32          0
 #define TCG_TARGET_HAS_bswap16_i32      0
 #define TCG_TARGET_HAS_bswap32_i32      0
-#define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_clz_i32          0
 #define TCG_TARGET_HAS_ctz_i32          0
 #define TCG_TARGET_HAS_ctpop_i32        0
@@ -40,7 +39,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_bswap16_i64      0
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
-#define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_clz_i64          0
 #define TCG_TARGET_HAS_ctz_i64          0
 #define TCG_TARGET_HAS_ctpop_i64        0
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 7de13ef383..a84ed1313a 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -19,7 +19,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      0
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
-#define TCG_TARGET_HAS_not_i64          0
 #define TCG_TARGET_HAS_clz_i64          0
 #define TCG_TARGET_HAS_ctz_i64          0
 #define TCG_TARGET_HAS_ctpop_i64        0
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 13c9dc3dfa..f147da5c0e 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -15,7 +15,6 @@
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        1
-#define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_negsetcond_i32   0
 #define TCG_TARGET_HAS_muls2_i32        1
@@ -34,7 +33,6 @@
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        1
-#define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_negsetcond_i64   0
 #define TCG_TARGET_HAS_muls2_i64        1
diff --git a/tcg/optimize.c b/tcg/optimize.c
index eb360e2b63..b4a675ea37 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1104,11 +1104,11 @@ static bool fold_to_not(OptContext *ctx, TCGOp *op, int idx)
     switch (ctx->type) {
     case TCG_TYPE_I32:
         not_op = INDEX_op_not_i32;
-        have_not = TCG_TARGET_HAS_not_i32;
+        have_not = tcg_op_supported(INDEX_op_not_i32, TCG_TYPE_I32, 0);
         break;
     case TCG_TYPE_I64:
         not_op = INDEX_op_not_i64;
-        have_not = TCG_TARGET_HAS_not_i64;
+        have_not = tcg_op_supported(INDEX_op_not_i64, TCG_TYPE_I64, 0);
         break;
     case TCG_TYPE_V64:
     case TCG_TYPE_V128:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index cb2eb9ae52..e0f8ab28b8 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -461,7 +461,8 @@ void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     /* Some cases can be optimized here.  */
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
-    } else if (arg2 == -1 && TCG_TARGET_HAS_not_i32) {
+    } else if (arg2 == -1 &&
+               tcg_op_supported(INDEX_op_not_i32, TCG_TYPE_I32, 0)) {
         /* Don't recurse with tcg_gen_not_i32.  */
         tcg_gen_op2_i32(INDEX_op_not_i32, ret, arg1);
     } else {
@@ -471,7 +472,7 @@ void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
-    if (TCG_TARGET_HAS_not_i32) {
+    if (tcg_op_supported(INDEX_op_not_i32, TCG_TYPE_I32, 0)) {
         tcg_gen_op2_i32(INDEX_op_not_i32, ret, arg);
     } else {
         tcg_gen_xori_i32(ret, arg, -1);
@@ -1762,7 +1763,8 @@ void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     /* Some cases can be optimized here.  */
     if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
-    } else if (arg2 == -1 && TCG_TARGET_HAS_not_i64) {
+    } else if (arg2 == -1 &&
+               tcg_op_supported(INDEX_op_not_i64, TCG_TYPE_I64, 0)) {
         /* Don't recurse with tcg_gen_not_i64.  */
         tcg_gen_op2_i64(INDEX_op_not_i64, ret, arg1);
     } else {
@@ -2252,7 +2254,7 @@ void tcg_gen_not_i64(TCGv_i64 ret, TCGv_i64 arg)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_not_i32(TCGV_LOW(ret), TCGV_LOW(arg));
         tcg_gen_not_i32(TCGV_HIGH(ret), TCGV_HIGH(arg));
-    } else if (TCG_TARGET_HAS_not_i64) {
+    } else if (tcg_op_supported(INDEX_op_not_i64, TCG_TYPE_I64, 0)) {
         tcg_gen_op2_i64(INDEX_op_not_i64, ret, arg);
     } else {
         tcg_gen_xori_i64(ret, arg, -1);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 92d185558f..acd666d30b 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1024,6 +1024,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
     OUTOP(INDEX_op_neg, TCGOutOpUnary, outop_neg),
     OUTOP(INDEX_op_nor, TCGOutOpBinary, outop_nor),
+    OUTOP(INDEX_op_not_i32, TCGOutOpUnary, outop_not),
+    OUTOP(INDEX_op_not_i64, TCGOutOpUnary, outop_not),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
     OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
@@ -2287,8 +2289,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_bswap16_i32;
     case INDEX_op_bswap32_i32:
         return TCG_TARGET_HAS_bswap32_i32;
-    case INDEX_op_not_i32:
-        return TCG_TARGET_HAS_not_i32;
     case INDEX_op_clz_i32:
         return TCG_TARGET_HAS_clz_i32;
     case INDEX_op_ctz_i32:
@@ -2350,8 +2350,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_bswap32_i64;
     case INDEX_op_bswap64_i64:
         return TCG_TARGET_HAS_bswap64_i64;
-    case INDEX_op_not_i64:
-        return TCG_TARGET_HAS_not_i64;
     case INDEX_op_clz_i64:
         return TCG_TARGET_HAS_clz_i64;
     case INDEX_op_ctz_i64:
@@ -5476,6 +5474,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         break;
 
     case INDEX_op_neg:
+    case INDEX_op_not_i32:
+    case INDEX_op_not_i64:
         {
             const TCGOutOpUnary *out =
                 container_of(all_outop[op->opc], TCGOutOpUnary, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index c736691e9f..25ad37fcd5 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -695,12 +695,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             regs[r0] = bswap32(regs[r1]);
             break;
 #endif
-#if TCG_TARGET_HAS_not_i32 || TCG_TARGET_HAS_not_i64
         CASE_32_64(not)
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = ~regs[r1];
             break;
-#endif
 #if TCG_TARGET_REG_BITS == 64
             /* Load/store operations (64 bit). */
 
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index cf7a3f2632..97b444bc17 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2245,6 +2245,16 @@ static const TCGOutOpUnary outop_neg = {
     .out_rr = tgen_neg,
 };
 
+static void tgen_not(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tgen_orc(s, type, a0, TCG_REG_XZR, a1);
+}
+
+static const TCGOutOpUnary outop_not = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_not,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2312,11 +2322,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_ldst(s, I3312_STRX, a0, a1, a2, 3);
         break;
 
-    case INDEX_op_not_i64:
-    case INDEX_op_not_i32:
-        tcg_out_insn(s, 3510, ORN, ext, a0, TCG_REG_XZR, a1);
-        break;
-
     case INDEX_op_mul_i64:
     case INDEX_op_mul_i32:
         tcg_out_insn(s, 3509, MADD, ext, a0, a1, a2, TCG_REG_XZR);
@@ -2996,8 +3001,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap16_i64:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 5ea4488606..2477b1c4ab 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1961,6 +1961,16 @@ static const TCGOutOpUnary outop_neg = {
     .out_rr = tgen_neg,
 };
 
+static void tgen_not(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_dat_reg(s, COND_AL, ARITH_MVN, a0, 0, a1, SHIFT_IMM_LSL(0));
+}
+
+static const TCGOutOpUnary outop_not = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_not,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2050,10 +2060,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         tcg_out_mov_reg(s, COND_AL, args[0], a0);
         break;
-    case INDEX_op_not_i32:
-        tcg_out_dat_reg(s, COND_AL,
-                        ARITH_MVN, args[0], 0, args[1], SHIFT_IMM_LSL(0));
-        break;
     case INDEX_op_mul_i32:
         tcg_out_mul32(s, COND_AL, args[0], args[1], args[2]);
         break;
@@ -2233,7 +2239,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_not_i32:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
     case INDEX_op_extract_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 082aa982fb..24fef09c9e 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2712,6 +2712,17 @@ static const TCGOutOpUnary outop_neg = {
     .out_rr = tgen_neg,
 };
 
+static void tgen_not(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NOT, a0);
+}
+
+static const TCGOutOpUnary outop_not = {
+    .base.static_constraint = C_O1_I1(r, 0),
+    .out_rr = tgen_not,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2911,10 +2922,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(not):
-        tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NOT, a0);
-        break;
-
     case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, a0, -1, a1, a2, TCG_TYPE_I32);
         break;
@@ -3727,8 +3734,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
     case INDEX_op_extrh_i64_i32:
         return C_O1_I1(r, 0);
 
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 31ec7262e0..c24882b6ba 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1419,6 +1419,16 @@ static const TCGOutOpUnary outop_neg = {
     .out_rr = tgen_neg,
 };
 
+static void tgen_not(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tgen_nor(s, type, a0, a1, TCG_REG_ZERO);
+}
+
+static const TCGOutOpUnary outop_not = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_not,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1454,11 +1464,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_srai_d(s, a0, a1, 32);
         break;
 
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
-        tcg_out_opc_nor(s, a0, a1, TCG_REG_ZERO);
-        break;
-
     case INDEX_op_extract_i32:
         if (a2 == 0 && args[3] <= 12) {
             tcg_out_opc_andi(s, a0, a1, (1 << args[3]) - 1);
@@ -2275,8 +2280,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
     case INDEX_op_ext_i32_i64:
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
     case INDEX_op_extract_i32:
     case INDEX_op_extract_i64:
     case INDEX_op_sextract_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 0fda255a7b..4942855189 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1793,6 +1793,16 @@ static const TCGOutOpUnary outop_neg = {
     .out_rr = tgen_neg,
 };
 
+static void tgen_not(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tgen_nor(s, type, a0, TCG_REG_ZERO, a1);
+}
+
+static const TCGOutOpUnary outop_not = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_not,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1985,14 +1995,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_reg(s, OPC_MFHI, a1, 0, 0);
         break;
 
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
-        i1 = OPC_NOR;
-        goto do_unary;
-    do_unary:
-        tcg_out_opc_reg(s, i1, a0, TCG_REG_ZERO, a1);
-        break;
-
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap16_i64:
         tcg_out_bswap16(s, a0, a1, a2);
@@ -2199,7 +2201,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_not_i32:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
     case INDEX_op_extract_i32:
@@ -2211,7 +2212,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_not_i64:
     case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index da45436a5a..38cbe5223b 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3062,6 +3062,16 @@ static const TCGOutOpUnary outop_neg = {
     .out_rr = tgen_neg,
 };
 
+static void tgen_not(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tgen_nor(s, type, a0, a1, a1);
+}
+
+static const TCGOutOpUnary outop_not = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_not,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -3234,11 +3244,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_brcond2(s, args, const_args);
         break;
 
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
-        tcg_out32(s, NOR | SAB(args[1], args[0], args[1]));
-        break;
-
     case INDEX_op_shl_i64:
         if (const_args[2]) {
             /* Limit immediate shift count lest we create an illegal insn.  */
@@ -4124,7 +4129,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
     case INDEX_op_ctpop_i32:
-    case INDEX_op_not_i32:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
     case INDEX_op_extract_i32:
@@ -4137,7 +4141,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
     case INDEX_op_ctpop_i64:
-    case INDEX_op_not_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_bswap16_i64:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 4e16c44aa5..5e9e14815d 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2087,6 +2087,16 @@ static const TCGOutOpUnary outop_neg = {
     .out_rr = tgen_neg,
 };
 
+static void tgen_not(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tgen_xori(s, type, a0, a1, -1);
+}
+
+static const TCGOutOpUnary outop_not = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_not,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2150,11 +2160,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, OPC_SD, a0, a1, a2);
         break;
 
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
-        tcg_out_opc_imm(s, OPC_XORI, a0, a1, -1);
-        break;
-
     case INDEX_op_mul_i32:
         tcg_out_opc_reg(s, OPC_MULW, a0, a1, a2);
         break;
@@ -2662,7 +2667,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_not_i32:
     case INDEX_op_ld8u_i64:
     case INDEX_op_ld8s_i64:
     case INDEX_op_ld16u_i64:
@@ -2670,7 +2674,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_not_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 08e65834d7..98bf3ee19e 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2387,6 +2387,22 @@ static const TCGOutOpUnary outop_neg = {
     .out_rr = tgen_neg,
 };
 
+static void tgen_not(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tgen_nor(s, type, a0, a1, a1);
+}
+
+static TCGConstraintSetIndex cset_not(TCGType type, unsigned flags)
+{
+    return HAVE_FACILITY(MISC_INSN_EXT3) ? C_O1_I1(r, r) : C_NotImplemented;
+}
+
+static const TCGOutOpUnary outop_not = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_not,
+    .out_rr = tgen_not,
+};
+
 
 # define OP_32_64(x) \
         case glue(glue(INDEX_op_,x),_i32): \
@@ -2444,10 +2460,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_not_i32:
-        tcg_out_insn(s, RRFa, NORK, args[0], args[1], args[1]);
-        break;
-
     case INDEX_op_mul_i32:
         a0 = args[0], a1 = args[1], a2 = (int32_t)args[2];
         if (const_args[2]) {
@@ -2635,9 +2647,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I64, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_not_i64:
-        tcg_out_insn(s, RRFa, NOGRK, args[0], args[1], args[1]);
-        break;
     case INDEX_op_bswap64_i64:
         tcg_out_insn(s, RRE, LRVGR, args[0], args[1]);
         break;
@@ -3331,8 +3340,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extract_i32:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index a3926ea1c3..5819dc44fe 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1413,6 +1413,16 @@ static const TCGOutOpUnary outop_neg = {
     .out_rr = tgen_neg,
 };
 
+static void tgen_not(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+     tgen_orc(s, type, a0, TCG_REG_G0, a1);
+}
+
+static const TCGOutOpUnary outop_not = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_not,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1483,10 +1493,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         c = ARITH_UMUL;
         goto gen_arith;
 
-    OP_32_64(not):
-	c = ARITH_ORN;
-	goto gen_arith1;
-
     case INDEX_op_div_i32:
         tcg_out_div32(s, a0, a1, a2, c2, 0);
         break;
@@ -1600,10 +1606,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_arithc(s, a0, a1, a2, c2, c);
         break;
 
-    gen_arith1:
-	tcg_out_arithc(s, a0, TCG_REG_G0, a1, const_args[1], c);
-	break;
-
     case INDEX_op_mb:
         tcg_out_mb(s, a0);
         break;
@@ -1646,8 +1648,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extract_i64:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index c42f9dff11..d3da498098 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -55,8 +55,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_bswap16_i32:
@@ -739,6 +737,16 @@ static const TCGOutOpUnary outop_neg = {
     .out_rr = tgen_neg,
 };
 
+static void tgen_not(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_op_rr(s, glue(INDEX_op_not_i,TCG_TARGET_REG_BITS), a0, a1);
+}
+
+static const TCGOutOpUnary outop_not = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_not,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -812,7 +820,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_op_rl(s, opc, TCG_REG_TMP, arg_label(args[3]));
         break;
 
-    CASE_32_64(not)      /* Optional (TCG_TARGET_HAS_not_*). */
     CASE_32_64(ctpop)    /* Optional (TCG_TARGET_HAS_ctpop_*). */
     case INDEX_op_bswap32_i32: /* Optional (TCG_TARGET_HAS_bswap32_i32). */
     case INDEX_op_bswap64_i64: /* Optional (TCG_TARGET_HAS_bswap64_i64). */
-- 
2.43.0


