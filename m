Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93065A8A864
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Apr 2025 21:47:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4lyf-0006MR-1a; Tue, 15 Apr 2025 15:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lyI-00051X-7g
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:29:26 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4ly7-0000sl-Sp
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:29:21 -0400
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-af52a624283so6468a12.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745353; x=1745350153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4Fa8YkdSmtviPj160wSTaVn+3JCFqPbzXlYWumjGcHQ=;
 b=af4w0fvZdKBFJZ7S55/vOYCQf6djJsPYjNoxYS7KakqrtJOFeRF7immpY4UMn3yk3v
 +gkblQdMAPl+pRIrLFtPEH+40wE2zmi2iepopbiuU4N+Wlj7FaYNpJAziMShSamXf1vU
 qCJdVt4iSwzQiHCfXsL+ygJTFlaLYwey4n9r5FpXOMY/bNyfx2CIoIh9NmAbN5aWj/sG
 kBmkr0FvZfwwC38TMqtvkctJfEYbDRc8o9qrIGDLrPK1tt+LlNIQMeCm+mNl0ej2TGQd
 Z4ghWot1r0vbpjDPJUH1OEMqxxuvQDKAZokWny7zF4MsgNSdxpeAxPC65GhkDVK6Inp1
 yREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745353; x=1745350153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Fa8YkdSmtviPj160wSTaVn+3JCFqPbzXlYWumjGcHQ=;
 b=dVxvXEApuqd0U/bfcSTrp42lzJAsgUDqMhKtnM1XJnGY3Cf1hz5wbfYOKVCrwZgUCn
 85cWma+28f08MdJKfhKVVS6OmjoLwR4K8156P3PRRH9v4st/I71F9X4sQYBtd2FmsDZa
 m+VkzHMsj4dDooDfXodOZERvhEIB3TtM+TYr1U8ImAboG20tY8fFdGaTqUM9kkj9ueCe
 I/apUP5fGOOvuYLxyY4m4Frfwc4LE4eWgTXNrzF6Vp+axgzDwm3dnjA+1lrQ6MIoCuBo
 Qk7g51mHnSrE5go/M/t8NUT91GSgLzfs4xepBfKOyjrRtsr0JtEjorPsg5vzZ1i0vNZE
 mxcQ==
X-Gm-Message-State: AOJu0YzDq0ouizEes9xqzkDEi8QoOJWNiaZANKx8mG+HSckjGsDp170t
 DUj6l7sPbhpt+0MLWLmc/aZ9IQBBYoNf06b6uKcKZdKAmQBBM8QO0lIV03gxXWSgDT/zc3T18rn
 6
X-Gm-Gg: ASbGncvBNw9pXc4uYZg/IGFlDYkPUzrqAiAi8cc7STSLLrq/5rnuy9U5fEJPjFODb16
 QBlgEIBdCJ4Vrg1od+pUgYYNaiglek1Ix6xPKiGF68iCQo4wmtf0D96bNzSRE5DwKW1L0I11Tko
 dQLnwN5jrHU3uL74c6KyPi8VRRvJDO+F9cOedWa0IDmne2TJV490H24q6F6HPGd+C7rennMoJJ1
 bNOj34/XyapUXzWI5trVJxMbMmz6hgaqjyW1P6gw94aE7Ubua7TJ1eIRxww/vgtQAGdMAIVEdgl
 bL61JrQhV9y8jXKkaQJCuliG8v8kFD3V717vOpV5wIfdPoG47EGzLSQGM5CgFUZzpE+eDL65mkU
 =
X-Google-Smtp-Source: AGHT+IHtW9AE4tEehq/wY9aRx0xadA2jAbnm2KZE0aJzZtsP7MAc8jhWW+6WMitwd8LkL+g4OwNq3g==
X-Received: by 2002:a17:90a:d650:b0:2fa:30e9:2051 with SMTP id
 98e67ed59e1d1-3084f317c89mr6350975a91.5.1744745353074; 
 Tue, 15 Apr 2025 12:29:13 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df06a165sm13534812a91.4.2025.04.15.12.29.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:29:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 066/163] tcg: Convert ctpop to TCGOutOpUnary
Date: Tue, 15 Apr 2025 12:23:37 -0700
Message-ID: <20250415192515.232910-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.215.176;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-f176.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-has.h     |  2 -
 tcg/arm/tcg-target-has.h         |  1 -
 tcg/i386/tcg-target-has.h        |  2 -
 tcg/loongarch64/tcg-target-has.h |  2 -
 tcg/mips/tcg-target-has.h        |  2 -
 tcg/ppc/tcg-target-has.h         |  2 -
 tcg/riscv/tcg-target-has.h       |  2 -
 tcg/s390x/tcg-target-has.h       |  2 -
 tcg/sparc64/tcg-target-has.h     |  2 -
 tcg/tcg-has.h                    |  1 -
 tcg/tci/tcg-target-has.h         |  2 -
 tcg/tcg-op.c                     | 37 ++++++++++--------
 tcg/tcg.c                        |  8 ++--
 tcg/tci.c                        | 19 ++++-----
 tcg/aarch64/tcg-target.c.inc     |  4 ++
 tcg/arm/tcg-target.c.inc         |  4 ++
 tcg/i386/tcg-target.c.inc        | 23 ++++++++---
 tcg/loongarch64/tcg-target.c.inc |  4 ++
 tcg/mips/tcg-target.c.inc        |  4 ++
 tcg/ppc/tcg-target.c.inc         | 26 ++++++++-----
 tcg/riscv/tcg-target.c.inc       | 26 ++++++++-----
 tcg/s390x/tcg-target.c.inc       | 66 +++++++++++++++-----------------
 tcg/sparc64/tcg-target.c.inc     |  4 ++
 tcg/tci/tcg-target.c.inc         | 19 +++++++--
 24 files changed, 151 insertions(+), 113 deletions(-)

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 478d59676e..4f1840f44e 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -15,7 +15,6 @@
 /* optional instructions */
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_add2_i32         1
@@ -28,7 +27,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_ctpop_i64        0
 #define TCG_TARGET_HAS_extract2_i64     1
 #define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 1485a52c21..1cf3911613 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -26,7 +26,6 @@ extern bool use_neon_instructions;
 /* optional instructions */
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_mulu2_i32        1
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index b8a0a5c619..a71f8c7370 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -28,7 +28,6 @@
 /* optional instructions */
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_ctpop_i32        have_popcnt
 #define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_add2_i32         1
@@ -42,7 +41,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_ctpop_i64        have_popcnt
 #define TCG_TARGET_HAS_extract2_i64     1
 #define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index f87d05efc6..33a1cf2326 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -18,7 +18,6 @@
 #define TCG_TARGET_HAS_muls2_i32        0
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 /* 64-bit operations */
@@ -28,7 +27,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_ctpop_i64        0
 #define TCG_TARGET_HAS_add2_i64         0
 #define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_mulu2_i64        0
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index ca33c9b745..470aa16452 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -60,7 +60,6 @@ extern bool use_mips32r2_instructions;
 
 /* optional instructions detected at runtime */
 #define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
@@ -68,7 +67,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_ctpop_i64        0
 #endif
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 2b381b99a2..f071435d98 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -19,7 +19,6 @@
 /* optional instructions */
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_ctpop_i32        have_isa_2_06
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_mulu2_i32        0
@@ -33,7 +32,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_ctpop_i64        have_isa_2_06
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index 385a6736c0..a3b634570b 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -18,7 +18,6 @@
 #define TCG_TARGET_HAS_muls2_i32        0
 #define TCG_TARGET_HAS_bswap16_i32      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap32_i32      (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_ctpop_i32        (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_negsetcond_i64   1
@@ -27,7 +26,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap32_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap64_i64      (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_ctpop_i64        (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
 #define TCG_TARGET_HAS_mulu2_i64        0
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 0794394fea..87f117ce58 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -31,7 +31,6 @@ extern uint64_t s390_facilities[3];
 /* optional instructions */
 #define TCG_TARGET_HAS_bswap16_i32    1
 #define TCG_TARGET_HAS_bswap32_i32    1
-#define TCG_TARGET_HAS_ctpop_i32      1
 #define TCG_TARGET_HAS_extract2_i32   0
 #define TCG_TARGET_HAS_negsetcond_i32 1
 #define TCG_TARGET_HAS_add2_i32       1
@@ -44,7 +43,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_bswap16_i64    1
 #define TCG_TARGET_HAS_bswap32_i64    1
 #define TCG_TARGET_HAS_bswap64_i64    1
-#define TCG_TARGET_HAS_ctpop_i64      1
 #define TCG_TARGET_HAS_extract2_i64   0
 #define TCG_TARGET_HAS_negsetcond_i64 1
 #define TCG_TARGET_HAS_add2_i64       1
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index 56262640ff..40e54e1543 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -16,7 +16,6 @@ extern bool use_vis3_instructions;
 /* optional instructions */
 #define TCG_TARGET_HAS_bswap16_i32      0
 #define TCG_TARGET_HAS_bswap32_i32      0
-#define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_add2_i32         1
@@ -29,7 +28,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_bswap16_i64      0
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
-#define TCG_TARGET_HAS_ctpop_i64        0
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 6bba845944..97f4e83303 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -15,7 +15,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      0
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
-#define TCG_TARGET_HAS_ctpop_i64        0
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_negsetcond_i64   0
 #define TCG_TARGET_HAS_add2_i64         0
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index daa6db4799..774fb149fc 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -10,7 +10,6 @@
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_ctpop_i32        1
 #define TCG_TARGET_HAS_negsetcond_i32   0
 #define TCG_TARGET_HAS_muls2_i32        1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
@@ -21,7 +20,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_ctpop_i64        1
 #define TCG_TARGET_HAS_negsetcond_i64   0
 #define TCG_TARGET_HAS_muls2_i64        1
 #define TCG_TARGET_HAS_add2_i32         1
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7bf7de1213..db0e79059b 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -765,7 +765,8 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_temp_free_i64(t2);
         return;
     }
-    if (TCG_TARGET_HAS_ctpop_i32 || TCG_TARGET_HAS_ctpop_i64) {
+    if (tcg_op_supported(INDEX_op_ctpop_i32, TCG_TYPE_I32, 0) ||
+        tcg_op_supported(INDEX_op_ctpop_i64, TCG_TYPE_I64, 0)) {
         t = tcg_temp_ebb_new_i32();
         tcg_gen_subi_i32(t, arg1, 1);
         tcg_gen_andc_i32(t, t, arg1);
@@ -788,8 +789,9 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
 {
-    if (!tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I32, 0)
-        && TCG_TARGET_HAS_ctpop_i32 && arg2 == 32) {
+    if (arg2 == 32
+        && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I32, 0)
+        && tcg_op_supported(INDEX_op_ctpop_i32, TCG_TYPE_I32, 0)) {
         /* This equivalence has the advantage of not requiring a fixup.  */
         TCGv_i32 t = tcg_temp_ebb_new_i32();
         tcg_gen_subi_i32(t, arg1, 1);
@@ -817,9 +819,9 @@ void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
 
 void tcg_gen_ctpop_i32(TCGv_i32 ret, TCGv_i32 arg1)
 {
-    if (TCG_TARGET_HAS_ctpop_i32) {
+    if (tcg_op_supported(INDEX_op_ctpop_i32, TCG_TYPE_I32, 0)) {
         tcg_gen_op2_i32(INDEX_op_ctpop_i32, ret, arg1);
-    } else if (TCG_TARGET_HAS_ctpop_i64) {
+    } else if (tcg_op_supported(INDEX_op_ctpop_i64, TCG_TYPE_I64, 0)) {
         TCGv_i64 t = tcg_temp_ebb_new_i64();
         tcg_gen_extu_i32_i64(t, arg1);
         tcg_gen_ctpop_i64(t, t);
@@ -2370,7 +2372,7 @@ void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_op3_i64(INDEX_op_ctz, ret, arg1, arg2);
         return;
     }
-    if (TCG_TARGET_HAS_ctpop_i64) {
+    if (tcg_op_supported(INDEX_op_ctpop_i64, TCG_TYPE_I64, 0)) {
         t = tcg_temp_ebb_new_i64();
         tcg_gen_subi_i64(t, arg1, 1);
         tcg_gen_andc_i64(t, t, arg1);
@@ -2404,7 +2406,7 @@ void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
         tcg_temp_free_i32(t32);
     } else if (arg2 == 64
                && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0)
-               && TCG_TARGET_HAS_ctpop_i64) {
+               && tcg_op_supported(INDEX_op_ctpop_i64, TCG_TYPE_I64, 0)) {
         /* This equivalence has the advantage of not requiring a fixup.  */
         TCGv_i64 t = tcg_temp_ebb_new_i64();
         tcg_gen_subi_i64(t, arg1, 1);
@@ -2432,16 +2434,21 @@ void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg)
 
 void tcg_gen_ctpop_i64(TCGv_i64 ret, TCGv_i64 arg1)
 {
-    if (TCG_TARGET_HAS_ctpop_i64) {
-        tcg_gen_op2_i64(INDEX_op_ctpop_i64, ret, arg1);
-    } else if (TCG_TARGET_REG_BITS == 32 && TCG_TARGET_HAS_ctpop_i32) {
-        tcg_gen_ctpop_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1));
-        tcg_gen_ctpop_i32(TCGV_LOW(ret), TCGV_LOW(arg1));
-        tcg_gen_add_i32(TCGV_LOW(ret), TCGV_LOW(ret), TCGV_HIGH(ret));
-        tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
+    if (TCG_TARGET_REG_BITS == 64) {
+        if (tcg_op_supported(INDEX_op_ctpop_i64, TCG_TYPE_I64, 0)) {
+            tcg_gen_op2_i64(INDEX_op_ctpop_i64, ret, arg1);
+            return;
+        }
     } else {
-        gen_helper_ctpop_i64(ret, arg1);
+        if (tcg_op_supported(INDEX_op_ctpop_i32, TCG_TYPE_I32, 0)) {
+            tcg_gen_ctpop_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1));
+            tcg_gen_ctpop_i32(TCGV_LOW(ret), TCGV_LOW(arg1));
+            tcg_gen_add_i32(TCGV_LOW(ret), TCGV_LOW(ret), TCGV_HIGH(ret));
+            tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
+            return;
+        }
     }
+    gen_helper_ctpop_i64(ret, arg1);
 }
 
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 4029b01bee..8344aee6c1 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1027,6 +1027,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_clz, TCGOutOpBinary, outop_clz),
+    OUTOP(INDEX_op_ctpop_i32, TCGOutOpUnary, outop_ctpop),
+    OUTOP(INDEX_op_ctpop_i64, TCGOutOpUnary, outop_ctpop),
     OUTOP(INDEX_op_ctz, TCGOutOpBinary, outop_ctz),
     OUTOP(INDEX_op_divs, TCGOutOpBinary, outop_divs),
     OUTOP(INDEX_op_divu, TCGOutOpBinary, outop_divu),
@@ -2290,8 +2292,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_bswap16_i32;
     case INDEX_op_bswap32_i32:
         return TCG_TARGET_HAS_bswap32_i32;
-    case INDEX_op_ctpop_i32:
-        return TCG_TARGET_HAS_ctpop_i32;
 
     case INDEX_op_brcond2_i32:
     case INDEX_op_setcond2_i32:
@@ -2331,8 +2331,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_bswap32_i64;
     case INDEX_op_bswap64_i64:
         return TCG_TARGET_HAS_bswap64_i64;
-    case INDEX_op_ctpop_i64:
-        return TCG_TARGET_HAS_ctpop_i64;
     case INDEX_op_add2_i64:
         return TCG_TARGET_HAS_add2_i64;
     case INDEX_op_sub2_i64:
@@ -5446,6 +5444,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
+    case INDEX_op_ctpop_i32:
+    case INDEX_op_ctpop_i64:
     case INDEX_op_neg:
     case INDEX_op_not:
         {
diff --git a/tcg/tci.c b/tcg/tci.c
index 550f2014a8..8bcf48b251 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -26,6 +26,8 @@
 #include <ffi.h>
 
 
+#define ctpop_tr    glue(ctpop, TCG_TARGET_REG_BITS)
+
 /*
  * Enable TCI assertions only when debugging TCG (and without NDEBUG defined).
  * Without assertions, the interpreter runs much faster.
@@ -575,6 +577,11 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = ~regs[r1];
             break;
+        case INDEX_op_ctpop_i32:
+        case INDEX_op_ctpop_i64:
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = ctpop_tr(regs[r1]);
+            break;
 
             /* Arithmetic operations (32 bit). */
 
@@ -604,12 +611,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tmp32 = regs[r1];
             regs[r0] = tmp32 ? ctz32(tmp32) : regs[r2];
             break;
-#if TCG_TARGET_HAS_ctpop_i32
-        case INDEX_op_ctpop_i32:
-            tci_args_rr(insn, &r0, &r1);
-            regs[r0] = ctpop32(regs[r1]);
-            break;
-#endif
 
             /* Shift/rotate operations. */
 
@@ -739,12 +740,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] ? ctz64(regs[r1]) : regs[r2];
             break;
-#if TCG_TARGET_HAS_ctpop_i64
-        case INDEX_op_ctpop_i64:
-            tci_args_rr(insn, &r0, &r1);
-            regs[r0] = ctpop64(regs[r1]);
-            break;
-#endif
 #if TCG_TARGET_HAS_mulu2_i64
         case INDEX_op_mulu2_i64:
             tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 8441c5f4bf..0f01fa8c20 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2129,6 +2129,10 @@ static const TCGOutOpBinary outop_clz = {
     .out_rri = tgen_clzi,
 };
 
+static const TCGOutOpUnary outop_ctpop = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_ctz(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index c05f21c82c..e109c65965 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1888,6 +1888,10 @@ static const TCGOutOpBinary outop_clz = {
     .out_rri = tgen_clzi,
 };
 
+static const TCGOutOpUnary outop_ctpop = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_ctz(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index f7d0b93af0..318a30ebe0 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2628,6 +2628,23 @@ static const TCGOutOpBinary outop_clz = {
     .out_rri = tgen_clzi,
 };
 
+static void tgen_ctpop(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tcg_out_modrm(s, OPC_POPCNT + rexw, a0, a1);
+}
+
+static TCGConstraintSetIndex cset_ctpop(TCGType type, unsigned flags)
+{
+    return have_popcnt ? C_O1_I1(r, r) : C_NotImplemented;
+}
+
+static const TCGOutOpUnary outop_ctpop = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_ctpop,
+    .out_rr = tgen_ctpop,
+};
+
 static void tgen_ctz(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -3046,10 +3063,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(ctpop):
-        tcg_out_modrm(s, OPC_POPCNT + rexw, a0, a1);
-        break;
-
     OP_32_64(brcond):
         tcg_out_brcond(s, rexw, a2, a0, a1, const_args[1],
                        arg_label(args[3]), 0);
@@ -3893,8 +3906,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extract_i64:
     case INDEX_op_sextract_i32:
     case INDEX_op_sextract_i64:
-    case INDEX_op_ctpop_i32:
-    case INDEX_op_ctpop_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_extract2_i32:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index ea0a92ece9..41a4f6e2ea 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1321,6 +1321,10 @@ static const TCGOutOpBinary outop_clz = {
     .out_rri = tgen_clzi,
 };
 
+static const TCGOutOpUnary outop_ctpop = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_ctzi(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, tcg_target_long a2)
 {
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index e8720b63ed..a94c965046 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1734,6 +1734,10 @@ static const TCGOutOpBinary outop_clz = {
     .out_rri = tgen_clzi,
 };
 
+static const TCGOutOpUnary outop_ctpop = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static const TCGOutOpBinary outop_ctz = {
     .base.static_constraint = C_NotImplemented,
 };
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 2cdabcf610..ab56c623c7 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2974,6 +2974,23 @@ static const TCGOutOpBinary outop_clz = {
     .out_rri = tgen_clzi,
 };
 
+static void tgen_ctpop(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    uint32_t insn = type == TCG_TYPE_I32 ? CNTPOPW : CNTPOPD;
+    tcg_out32(s, insn | SAB(a1, a0, 0));
+}
+
+static TCGConstraintSetIndex cset_ctpop(TCGType type, unsigned flags)
+{
+    return have_isa_2_06 ? C_O1_I1(r, r) : C_NotImplemented;
+}
+
+static const TCGOutOpUnary outop_ctpop = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_ctpop,
+    .out_rr = tgen_ctpop,
+};
+
 static void tgen_ctz(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -3396,13 +3413,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_mem_long(s, STD, STDX, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_ctpop_i32:
-        tcg_out32(s, CNTPOPW | SAB(args[1], args[0], 0));
-        break;
-    case INDEX_op_ctpop_i64:
-        tcg_out32(s, CNTPOPD | SAB(args[1], args[0], 0));
-        break;
-
     case INDEX_op_brcond_i32:
         tcg_out_brcond(s, args[2], args[0], args[1], const_args[1],
                        arg_label(args[3]), TCG_TYPE_I32);
@@ -4226,7 +4236,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_ctpop_i32:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
     case INDEX_op_extract_i32:
@@ -4238,7 +4247,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_ctpop_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_bswap16_i64:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 1ceb1aeb1c..a5cd18c99e 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2023,6 +2023,23 @@ static const TCGOutOpBinary outop_clz = {
     .out_rri = tgen_clzi,
 };
 
+static void tgen_ctpop(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_CPOPW : OPC_CPOP;
+    tcg_out_opc_imm(s, insn, a0, a1, 0);
+}
+
+static TCGConstraintSetIndex cset_ctpop(TCGType type, unsigned flags)
+{
+    return cpuinfo & CPUINFO_ZBB ? C_O1_I1(r, r) : C_NotImplemented;
+}
+
+static const TCGOutOpUnary outop_ctpop = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_ctpop,
+    .out_rr = tgen_ctpop,
+};
+
 static void tgen_ctz(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2438,13 +2455,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_ctpop_i32:
-        tcg_out_opc_imm(s, OPC_CPOPW, a0, a1, 0);
-        break;
-    case INDEX_op_ctpop_i64:
-        tcg_out_opc_imm(s, OPC_CPOP, a0, a1, 0);
-        break;
-
     case INDEX_op_add2_i32:
         tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
                         const_args[4], const_args[5], false, true);
@@ -2808,8 +2818,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
-    case INDEX_op_ctpop_i32:
-    case INDEX_op_ctpop_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 374136ed14..71adb0964d 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -1514,32 +1514,6 @@ static void tgen_movcond(TCGContext *s, TCGType type, TCGCond c, TCGReg dest,
     tgen_movcond_int(s, type, dest, v3, v3const, v4, cc, inv_cc);
 }
 
-static void tgen_ctpop(TCGContext *s, TCGType type, TCGReg dest, TCGReg src)
-{
-    /* With MIE3, and bit 0 of m4 set, we get the complete result. */
-    if (HAVE_FACILITY(MISC_INSN_EXT3)) {
-        if (type == TCG_TYPE_I32) {
-            tcg_out_ext32u(s, dest, src);
-            src = dest;
-        }
-        tcg_out_insn(s, RRFc, POPCNT, dest, src, 8);
-        return;
-    }
-
-    /* Without MIE3, each byte gets the count of bits for the byte. */
-    tcg_out_insn(s, RRFc, POPCNT, dest, src, 0);
-
-    /* Multiply to sum each byte at the top of the word. */
-    if (type == TCG_TYPE_I32) {
-        tcg_out_insn(s, RIL, MSFI, dest, 0x01010101);
-        tcg_out_sh32(s, RS_SRL, dest, TCG_REG_NONE, 24);
-    } else {
-        tcg_out_movi(s, TCG_TYPE_I64, TCG_TMP0, 0x0101010101010101ull);
-        tcg_out_insn(s, RRE, MSGR, dest, TCG_TMP0);
-        tcg_out_sh64(s, RSY_SRLG, dest, dest, TCG_REG_NONE, 56);
-    }
-}
-
 static void tgen_deposit(TCGContext *s, TCGReg dest, TCGReg src,
                          int ofs, int len, int z)
 {
@@ -2268,6 +2242,37 @@ static const TCGOutOpBinary outop_clz = {
     .out_rri = tgen_clzi,
 };
 
+static void tgen_ctpop(TCGContext *s, TCGType type, TCGReg dest, TCGReg src)
+{
+    /* With MIE3, and bit 0 of m4 set, we get the complete result. */
+    if (HAVE_FACILITY(MISC_INSN_EXT3)) {
+        if (type == TCG_TYPE_I32) {
+            tcg_out_ext32u(s, dest, src);
+            src = dest;
+        }
+        tcg_out_insn(s, RRFc, POPCNT, dest, src, 8);
+        return;
+    }
+
+    /* Without MIE3, each byte gets the count of bits for the byte. */
+    tcg_out_insn(s, RRFc, POPCNT, dest, src, 0);
+
+    /* Multiply to sum each byte at the top of the word. */
+    if (type == TCG_TYPE_I32) {
+        tcg_out_insn(s, RIL, MSFI, dest, 0x01010101);
+        tcg_out_sh32(s, RS_SRL, dest, TCG_REG_NONE, 24);
+    } else {
+        tcg_out_movi(s, TCG_TYPE_I64, TCG_TMP0, 0x0101010101010101ull);
+        tcg_out_insn(s, RRE, MSGR, dest, TCG_TMP0);
+        tcg_out_sh64(s, RSY_SRLG, dest, dest, TCG_REG_NONE, 56);
+    }
+}
+
+static const TCGOutOpUnary outop_ctpop = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_ctpop,
+};
+
 static const TCGOutOpBinary outop_ctz = {
     .base.static_constraint = C_NotImplemented,
 };
@@ -2914,13 +2919,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tgen_sextract(s, args[0], args[1], args[2], args[3]);
         break;
 
-    case INDEX_op_ctpop_i32:
-        tgen_ctpop(s, TCG_TYPE_I32, args[0], args[1]);
-        break;
-    case INDEX_op_ctpop_i64:
-        tgen_ctpop(s, TCG_TYPE_I64, args[0], args[1]);
-        break;
-
     case INDEX_op_mb:
         /* The host memory model is quite strong, we simply need to
            serialize the instruction stream.  */
@@ -3429,8 +3427,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extract_i64:
     case INDEX_op_sextract_i32:
     case INDEX_op_sextract_i64:
-    case INDEX_op_ctpop_i32:
-    case INDEX_op_ctpop_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_qemu_ld_i32:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index a9257b8b93..43ca23f593 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1322,6 +1322,10 @@ static const TCGOutOpBinary outop_clz = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpUnary outop_ctpop = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static const TCGOutOpBinary outop_ctz = {
     .base.static_constraint = C_NotImplemented,
 };
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index d8d45e2c4b..a931369a80 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -66,8 +66,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extract_i64:
     case INDEX_op_sextract_i32:
     case INDEX_op_sextract_i64:
-    case INDEX_op_ctpop_i32:
-    case INDEX_op_ctpop_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
@@ -883,6 +881,22 @@ static const TCGOutOpBinary outop_xor = {
     .out_rrr = tgen_xor,
 };
 
+static void tgen_ctpop(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_op_rr(s, glue(INDEX_op_ctpop_i,TCG_TARGET_REG_BITS), a0, a1);
+}
+
+static TCGConstraintSetIndex cset_ctpop(TCGType type, unsigned flags)
+{
+    return type == TCG_TYPE_REG ? C_O1_I1(r, r) : C_NotImplemented;
+}
+
+static const TCGOutOpUnary outop_ctpop = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_ctpop,
+    .out_rr = tgen_ctpop,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tcg_out_op_rr(s, INDEX_op_neg, a0, a1);
@@ -961,7 +975,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_op_rl(s, opc, TCG_REG_TMP, arg_label(args[3]));
         break;
 
-    CASE_32_64(ctpop)    /* Optional (TCG_TARGET_HAS_ctpop_*). */
     case INDEX_op_bswap32_i32: /* Optional (TCG_TARGET_HAS_bswap32_i32). */
     case INDEX_op_bswap64_i64: /* Optional (TCG_TARGET_HAS_bswap64_i64). */
         tcg_out_op_rr(s, opc, args[0], args[1]);
-- 
2.43.0


