Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8265982A425
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:46:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhJR-0004S1-Km; Wed, 10 Jan 2024 17:44:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhJP-0004Rn-K5
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:44:39 -0500
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhJN-0002V3-PL
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:44:39 -0500
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-429c00bf0efso733781cf.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926676; x=1705531476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHALRgn6+R7mnoPisAPyxnrzriWZt0G/V66nE0399oE=;
 b=BlwGvnoNSNq7Ud7H9aO2FbiPhE3viZ1+CdtNj3/3i49OogrWH9BH9sPlRXaFr2+Rr+
 DezhlBHXH3EYYXHL0IKwCmhRVpIV7cBJiPKLiffdaFRe3E1jcttbn5GYcClyXNU89Eaf
 TNXmHumbXgAt7QUaYItNRf3vfV29FCscCEFW/d7E/KUvtmB9Cv5kpoxeTcpnKaWHAY/I
 EAn2vSSX/Zo9oqTvbyQjgpiDHFvaNEaPbRpEMvy1vhx1lUenalBkCnXA/SjgDPi8zYHh
 vF4HMzH7FgxEAqi2w2LBqouYXr4MHZcw2aTMjnIRzXqa3L5MnDslZPA2U3nfuVww4AwK
 AzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926676; x=1705531476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XHALRgn6+R7mnoPisAPyxnrzriWZt0G/V66nE0399oE=;
 b=Ilpz/ZgqCb/xdFw2mhnxr7RokofsoC66KLfjsoZYOzLOUK4mm+DIQNmGkz5DbDB4/u
 5QOmGL98hGH8Rf7SR63cYV/TigF0tQmI+Qu9E4ldqLVw/Yh6ElHUtHOyygKjmjNpSK++
 5cgudcXctaGyZFSL4hTS0TKCZ/wTLaq2ripXaCzXeovQqdcQcXpuMoNCAYXyErKHaEZO
 CQmDKrCWXvjKgx88MHEGxTsj0iqm+8Ngg8apS9pzYixeVcSrClnma7K71m2fz7cylnk8
 9sZ/4/QbJLt83YUMDnzk6zOjfmWhLJ+hvI011KK5zARyGjhjUKyGeDhuUTWPXjPIydyZ
 0jjw==
X-Gm-Message-State: AOJu0YzBDo7VB7UU7YVSl0WDhXB+gj2prM24lXXZgaCtERcSyclBeM6M
 5jid02v4PDx33Zdzy6akHbHqj4w+PUXh8jU78jrh4n49rcZdqej1
X-Google-Smtp-Source: AGHT+IGqwBR2ufQFZs0dLeb4G5GUCLJoGZMrhIxw/nOkCCTai9IV39Ju7YAZit1+nPAHh1P1MvZUqA==
X-Received: by 2002:a05:622a:1a90:b0:429:b349:65a7 with SMTP id
 s16-20020a05622a1a9000b00429b34965a7mr396023qtc.8.1704926676671; 
 Wed, 10 Jan 2024 14:44:36 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:44:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 02/38] tcg: Introduce TCG_TARGET_HAS_tst
Date: Thu, 11 Jan 2024 09:43:32 +1100
Message-Id: <20240110224408.10444-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82c.google.com
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

Define as 0 for all tcg backends.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h     | 2 ++
 tcg/arm/tcg-target.h         | 2 ++
 tcg/i386/tcg-target.h        | 2 ++
 tcg/loongarch64/tcg-target.h | 2 ++
 tcg/mips/tcg-target.h        | 2 ++
 tcg/ppc/tcg-target.h         | 2 ++
 tcg/riscv/tcg-target.h       | 2 ++
 tcg/s390x/tcg-target.h       | 2 ++
 tcg/sparc64/tcg-target.h     | 2 ++
 tcg/tci/tcg-target.h         | 2 ++
 10 files changed, 20 insertions(+)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 33f15a564a..b4ac13be7b 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -138,6 +138,8 @@ typedef enum {
 #define TCG_TARGET_HAS_qemu_ldst_i128   1
 #endif
 
+#define TCG_TARGET_HAS_tst              0
+
 #define TCG_TARGET_HAS_v64              1
 #define TCG_TARGET_HAS_v128             1
 #define TCG_TARGET_HAS_v256             0
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index a712cc80ad..7bf42045a7 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -125,6 +125,8 @@ extern bool use_neon_instructions;
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
+#define TCG_TARGET_HAS_tst              0
+
 #define TCG_TARGET_HAS_v64              use_neon_instructions
 #define TCG_TARGET_HAS_v128             use_neon_instructions
 #define TCG_TARGET_HAS_v256             0
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index fa34deec47..1dd917a680 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -198,6 +198,8 @@ typedef enum {
 #define TCG_TARGET_HAS_qemu_ldst_i128 \
     (TCG_TARGET_REG_BITS == 64 && (cpuinfo & CPUINFO_ATOMIC_VMOVDQA))
 
+#define TCG_TARGET_HAS_tst              0
+
 /* We do not support older SSE systems, only beginning with AVX1.  */
 #define TCG_TARGET_HAS_v64              have_avx1
 #define TCG_TARGET_HAS_v128             have_avx1
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index 9c70ebfefc..fede627bf7 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -169,6 +169,8 @@ typedef enum {
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   (cpuinfo & CPUINFO_LSX)
 
+#define TCG_TARGET_HAS_tst              0
+
 #define TCG_TARGET_HAS_v64              0
 #define TCG_TARGET_HAS_v128             (cpuinfo & CPUINFO_LSX)
 #define TCG_TARGET_HAS_v256             0
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index b98ffae1d0..a996aa171d 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -194,6 +194,8 @@ extern bool use_mips32r2_instructions;
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
+#define TCG_TARGET_HAS_tst              0
+
 #define TCG_TARGET_DEFAULT_MO           0
 #define TCG_TARGET_NEED_LDST_LABELS
 #define TCG_TARGET_NEED_POOL_LABELS
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 5295e4f9ab..60ce49e672 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -143,6 +143,8 @@ typedef enum {
 #define TCG_TARGET_HAS_qemu_ldst_i128   \
     (TCG_TARGET_REG_BITS == 64 && have_isa_2_07)
 
+#define TCG_TARGET_HAS_tst              0
+
 /*
  * While technically Altivec could support V64, it has no 64-bit store
  * instruction and substituting two 32-bit stores makes the generated
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index a4edc3dc74..2c1b680b93 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -158,6 +158,8 @@ extern bool have_zbb;
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
+#define TCG_TARGET_HAS_tst              0
+
 #define TCG_TARGET_DEFAULT_MO (0)
 
 #define TCG_TARGET_NEED_LDST_LABELS
diff --git a/tcg/s390x/tcg-target.h b/tcg/s390x/tcg-target.h
index e69b0d2ddd..53bed8c8d2 100644
--- a/tcg/s390x/tcg-target.h
+++ b/tcg/s390x/tcg-target.h
@@ -138,6 +138,8 @@ extern uint64_t s390_facilities[3];
 
 #define TCG_TARGET_HAS_qemu_ldst_i128 1
 
+#define TCG_TARGET_HAS_tst            0
+
 #define TCG_TARGET_HAS_v64            HAVE_FACILITY(VECTOR)
 #define TCG_TARGET_HAS_v128           HAVE_FACILITY(VECTOR)
 #define TCG_TARGET_HAS_v256           0
diff --git a/tcg/sparc64/tcg-target.h b/tcg/sparc64/tcg-target.h
index f8cf145266..ae2910c4ee 100644
--- a/tcg/sparc64/tcg-target.h
+++ b/tcg/sparc64/tcg-target.h
@@ -149,6 +149,8 @@ extern bool use_vis3_instructions;
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
+#define TCG_TARGET_HAS_tst              0
+
 #define TCG_AREG0 TCG_REG_I0
 
 #define TCG_TARGET_DEFAULT_MO (0)
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 2a13816c8e..609b2f4e4a 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -117,6 +117,8 @@
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
+#define TCG_TARGET_HAS_tst              0
+
 /* Number of registers available. */
 #define TCG_TARGET_NB_REGS 16
 
-- 
2.34.1


