Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87ABC7D788F
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:29:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnHj-0001U8-OS; Wed, 25 Oct 2023 19:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHe-0001Sv-1A
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHa-0004bP-Rs
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698276446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n7poVav8AnLnfIwgHDhLVAVWEcF3/QAlzS8jmAYwRHY=;
 b=LvNM5Lw0D7P6uai5c43ZTQQ4RKjCkxI4F6u+mswTS/bX2WAox//ALpFdSmHM9Su7xEEgAp
 JJojNqY4a2Ejm6urqwsE95a/v+VcnwYSZJa3+oqg6kElGt9p/ixsMbZs/GbFKQnvYNXm+S
 vaVGF3eAWoDA/sS3SJ3vLQN6Ls8VxZg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-JSUPPpVfPPakOh5aSznZtg-1; Wed, 25 Oct 2023 19:27:24 -0400
X-MC-Unique: JSUPPpVfPPakOh5aSznZtg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-778964b7c8bso43503585a.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276443; x=1698881243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n7poVav8AnLnfIwgHDhLVAVWEcF3/QAlzS8jmAYwRHY=;
 b=v+WKbcLUaHx03tOWkXIgwtFG/RmrdrmE3NII7xR5PYOVkuYvVbWoS6HErmpqCp00zn
 1HyGPuX28XMQcmh86ehTUZzo0IKjTityLynbiAx6qJDbWqxnauxKICVONY5PhW8x1Izh
 hSdacxbvmLKI7xkBaDVRqpteyS65jLWWw/y1sjcajrjoRtrOK2lm3HdsnZJfj4+V8XNp
 CFKSgoFUs1nPRP1Iul89riOdgQDJgPAJCDLo7rHYvPhxISHZCKmPOJQ/y6QOzlE+0GAI
 xF3SqikHiVQo/3N1e1RPNCLKWehbx4/DjMWd0DXRAWgerhYBdXqMIwP34qfXmkqfSSUX
 gVYQ==
X-Gm-Message-State: AOJu0YxKzyGH+6iX0erpRBGU94JTG5RYKyLyeny9MZM8eBup8G9Ook4+
 jejnPXiOXhNKA4obZEViXvR/9cZ1U3P959bh1rb655MfbWFM5NntuQMa+tj6nc5Gu73QuMaf8yf
 MFAiZg2/HU/1D00Kc4HpOeN/glb8rvMsadb/hftmQmub+9rg8ZteGSptAgJX9tkHJLqB9B+zY/A
 o=
X-Received: by 2002:a05:620a:44cd:b0:773:e380:b364 with SMTP id
 y13-20020a05620a44cd00b00773e380b364mr19063606qkp.69.1698276443437; 
 Wed, 25 Oct 2023 16:27:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLqemz2Ihngm0baN9mSCb2T+TNEbCDn07xA2UhMByShn6K60ID2Vz3sDIaa1ljRLzXIaHFAQ==
X-Received: by 2002:a05:620a:44cd:b0:773:e380:b364 with SMTP id
 y13-20020a05620a44cd00b00773e380b364mr19063591qkp.69.1698276442990; 
 Wed, 25 Oct 2023 16:27:22 -0700 (PDT)
Received: from [172.19.0.201] ([192.80.84.35])
 by smtp.gmail.com with ESMTPSA id
 z16-20020a05620a08d000b00765aa3ffa07sm4559305qkz.98.2023.10.25.16.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:27:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 02/24] target/i386: implement SHA instructions
Date: Thu, 26 Oct 2023 01:26:55 +0200
Message-ID: <20231025232718.89428-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025232718.89428-1-pbonzini@redhat.com>
References: <20231025232718.89428-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The implementation was validated with OpenSSL and with the test vectors in
https://github.com/rust-lang/stdarch/blob/master/crates/core_arch/src/x86/sha.rs.

The instructions provide a ~25% improvement on hashing a 64 MiB file:
runtime goes down from 1.8 seconds to 1.4 seconds; instruction count on
the host goes down from 5.8 billion to 4.8 billion with slightly better
IPC too.  Good job Intel. ;)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c                    |   2 +-
 target/i386/ops_sse.h                | 128 +++++++++++++++++++++++++++
 target/i386/tcg/decode-new.c.inc     |  11 +++
 target/i386/tcg/decode-new.h         |   1 +
 target/i386/tcg/emit.c.inc           |  54 +++++++++++
 target/i386/tcg/ops_sse_header.h.inc |  14 +++
 6 files changed, 209 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index bdca901dfaa..070c02000fe 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -714,7 +714,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
           CPUID_7_0_EBX_PCOMMIT | CPUID_7_0_EBX_CLFLUSHOPT |            \
           CPUID_7_0_EBX_CLWB | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_FSGSBASE | \
           CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_RDSEED | \
-          CPUID_7_0_EBX_KERNEL_FEATURES)
+          CPUID_7_0_EBX_SHA_NI | CPUID_7_0_EBX_KERNEL_FEATURES)
           /* missing:
           CPUID_7_0_EBX_HLE
           CPUID_7_0_EBX_INVPCID, CPUID_7_0_EBX_RTM */
diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 33908c0691f..6a465a35fdb 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -2527,6 +2527,134 @@ SSE_HELPER_FMAP(helper_fma4ps,  ZMM_S, 2 << SHIFT, float32_muladd)
 SSE_HELPER_FMAP(helper_fma4pd,  ZMM_D, 1 << SHIFT, float64_muladd)
 #endif
 
+#if SHIFT == 1
+#define SSE_HELPER_SHA1RNDS4(name, F, K) \
+    void name(Reg *d, Reg *a, Reg *b)                                       \
+    {                                                                       \
+        uint32_t A, B, C, D, E, t, i;                                       \
+                                                                            \
+        A = a->L(3);                                                        \
+        B = a->L(2);                                                        \
+        C = a->L(1);                                                        \
+        D = a->L(0);                                                        \
+        E = 0;                                                              \
+                                                                            \
+        for (i = 0; i <= 3; i++) {                                          \
+            t = F(B, C, D) + rol32(A, 5) + b->L(3 - i) + E + K;             \
+            E = D;                                                          \
+            D = C;                                                          \
+            C = rol32(B, 30);                                               \
+            B = A;                                                          \
+            A = t;                                                          \
+        }                                                                   \
+                                                                            \
+        d->L(3) = A;                                                        \
+        d->L(2) = B;                                                        \
+        d->L(1) = C;                                                        \
+        d->L(0) = D;                                                        \
+    }
+
+#define SHA1_F0(b, c, d) (((b) & (c)) ^ (~(b) & (d)))
+#define SHA1_F1(b, c, d) ((b) ^ (c) ^ (d))
+#define SHA1_F2(b, c, d) (((b) & (c)) ^ ((b) & (d)) ^ ((c) & (d)))
+
+SSE_HELPER_SHA1RNDS4(helper_sha1rnds4_f0, SHA1_F0, 0x5A827999)
+SSE_HELPER_SHA1RNDS4(helper_sha1rnds4_f1, SHA1_F1, 0x6ED9EBA1)
+SSE_HELPER_SHA1RNDS4(helper_sha1rnds4_f2, SHA1_F2, 0x8F1BBCDC)
+SSE_HELPER_SHA1RNDS4(helper_sha1rnds4_f3, SHA1_F1, 0xCA62C1D6)
+
+void helper_sha1nexte(Reg *d, Reg *a, Reg *b)
+{
+    d->L(3) = b->L(3) + rol32(a->L(3), 30);
+    d->L(2) = b->L(2);
+    d->L(1) = b->L(1);
+    d->L(0) = b->L(0);
+}
+
+void helper_sha1msg1(Reg *d, Reg *a, Reg *b)
+{
+    /* These could be overwritten by the first two assignments, save them.  */
+    uint32_t b3 = b->L(3);
+    uint32_t b2 = b->L(2);
+
+    d->L(3) = a->L(3) ^ a->L(1);
+    d->L(2) = a->L(2) ^ a->L(0);
+    d->L(1) = a->L(1) ^ b3;
+    d->L(0) = a->L(0) ^ b2;
+}
+
+void helper_sha1msg2(Reg *d, Reg *a, Reg *b)
+{
+    d->L(3) = rol32(a->L(3) ^ b->L(2), 1);
+    d->L(2) = rol32(a->L(2) ^ b->L(1), 1);
+    d->L(1) = rol32(a->L(1) ^ b->L(0), 1);
+    d->L(0) = rol32(a->L(0) ^ d->L(3), 1);
+}
+
+#define SHA256_CH(e, f, g)  (((e) & (f)) ^ (~(e) & (g)))
+#define SHA256_MAJ(a, b, c) (((a) & (b)) ^ ((a) & (c)) ^ ((b) & (c)))
+
+#define SHA256_RNDS0(w) (ror32((w), 2) ^ ror32((w), 13) ^ ror32((w), 22))
+#define SHA256_RNDS1(w) (ror32((w), 6) ^ ror32((w), 11) ^ ror32((w), 25))
+#define SHA256_MSGS0(w) (ror32((w), 7) ^ ror32((w), 18) ^ ((w) >> 3))
+#define SHA256_MSGS1(w) (ror32((w), 17) ^ ror32((w), 19) ^ ((w) >> 10))
+
+void helper_sha256rnds2(Reg *d, Reg *a, Reg *b, uint32_t wk0, uint32_t wk1)
+{
+    uint32_t t, AA, EE;
+
+    uint32_t A = b->L(3);
+    uint32_t B = b->L(2);
+    uint32_t C = a->L(3);
+    uint32_t D = a->L(2);
+    uint32_t E = b->L(1);
+    uint32_t F = b->L(0);
+    uint32_t G = a->L(1);
+    uint32_t H = a->L(0);
+
+    /* Even round */
+    t = SHA256_CH(E, F, G) + SHA256_RNDS1(E) + wk0 + H;
+    AA = t + SHA256_MAJ(A, B, C) + SHA256_RNDS0(A);
+    EE = t + D;
+
+    /* These will be B and F at the end of the odd round */
+    d->L(2) = AA;
+    d->L(0) = EE;
+
+    D = C, C = B, B = A, A = AA;
+    H = G, G = F, F = E, E = EE;
+
+    /* Odd round */
+    t = SHA256_CH(E, F, G) + SHA256_RNDS1(E) + wk1 + H;
+    AA = t + SHA256_MAJ(A, B, C) + SHA256_RNDS0(A);
+    EE = t + D;
+
+    d->L(3) = AA;
+    d->L(1) = EE;
+}
+
+void helper_sha256msg1(Reg *d, Reg *a, Reg *b)
+{
+    /* b->L(0) could be overwritten by the first assignment, save it.  */
+    uint32_t b0 = b->L(0);
+
+    d->L(0) = a->L(0) + SHA256_MSGS0(a->L(1));
+    d->L(1) = a->L(1) + SHA256_MSGS0(a->L(2));
+    d->L(2) = a->L(2) + SHA256_MSGS0(a->L(3));
+    d->L(3) = a->L(3) + SHA256_MSGS0(b0);
+}
+
+void helper_sha256msg2(Reg *d, Reg *a, Reg *b)
+{
+    /* Earlier assignments cannot overwrite any of the two operands.  */
+    d->L(0) = a->L(0) + SHA256_MSGS1(b->L(2));
+    d->L(1) = a->L(1) + SHA256_MSGS1(b->L(3));
+    /* Yes, this reuses the previously computed values.  */
+    d->L(2) = a->L(2) + SHA256_MSGS1(d->L(0));
+    d->L(3) = a->L(3) + SHA256_MSGS1(d->L(1));
+}
+#endif
+
 #undef SSE_HELPER_S
 
 #undef LANE_WIDTH
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 7d76f152758..ec5d260b7ea 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -460,6 +460,13 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
     [0xbe] = X86_OP_ENTRY3(VFNMSUB231Px, V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
     [0xbf] = X86_OP_ENTRY3(VFNMSUB231Sx, V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
 
+    [0xc8] = X86_OP_ENTRY2(SHA1NEXTE,   V,dq, W,dq, cpuid(SHA_NI)),
+    [0xc9] = X86_OP_ENTRY2(SHA1MSG1,    V,dq, W,dq, cpuid(SHA_NI)),
+    [0xca] = X86_OP_ENTRY2(SHA1MSG2,    V,dq, W,dq, cpuid(SHA_NI)),
+    [0xcb] = X86_OP_ENTRY2(SHA256RNDS2, V,dq, W,dq, cpuid(SHA_NI)),
+    [0xcc] = X86_OP_ENTRY2(SHA256MSG1,  V,dq, W,dq, cpuid(SHA_NI)),
+    [0xcd] = X86_OP_ENTRY2(SHA256MSG2,  V,dq, W,dq, cpuid(SHA_NI)),
+
     [0xdb] = X86_OP_ENTRY3(VAESIMC,     V,dq, None,None, W,dq, vex4 cpuid(AES) p_66),
     [0xdc] = X86_OP_ENTRY3(VAESENC,     V,x,  H,x,       W,x,  vex4 cpuid(AES) p_66),
     [0xdd] = X86_OP_ENTRY3(VAESENCLAST, V,x,  H,x,       W,x,  vex4 cpuid(AES) p_66),
@@ -609,6 +616,8 @@ static const X86OpEntry opcodes_0F3A[256] = {
     [0x4b] = X86_OP_ENTRY4(VBLENDVPD, V,x,  H,x,  W,x,   vex6 cpuid(AVX) p_66),
     [0x4c] = X86_OP_ENTRY4(VPBLENDVB, V,x,  H,x,  W,x,   vex6 cpuid(AVX) p_66 avx2_256),
 
+    [0xcc] = X86_OP_ENTRY3(SHA1RNDS4,  V,dq, W,dq, I,b,  cpuid(SHA_NI)),
+
     [0xdf] = X86_OP_ENTRY3(VAESKEYGEN, V,dq, W,dq, I,b,  vex4 cpuid(AES) p_66),
 
     [0xF0] = X86_OP_ENTRY3(RORX, G,y, E,y, I,b, vex13 cpuid(BMI2) p_f2),
@@ -1456,6 +1465,8 @@ static bool has_cpuid_feature(DisasContext *s, X86CPUIDFeature cpuid)
         return (s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_BMI2);
     case X86_FEAT_AVX2:
         return (s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_AVX2);
+    case X86_FEAT_SHA_NI:
+        return (s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_SHA_NI);
     }
     g_assert_not_reached();
 }
diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index a542ec16813..9be8a6e65fd 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -108,6 +108,7 @@ typedef enum X86CPUIDFeature {
     X86_FEAT_FMA,
     X86_FEAT_MOVBE,
     X86_FEAT_PCLMULQDQ,
+    X86_FEAT_SHA_NI,
     X86_FEAT_SSE,
     X86_FEAT_SSE2,
     X86_FEAT_SSE3,
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 88793ba988d..16085a19d7a 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1800,6 +1800,60 @@ static void gen_SARX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     tcg_gen_sar_tl(s->T0, s->T0, s->T1);
 }
 
+static void gen_SHA1NEXTE(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_helper_sha1nexte(OP_PTR0, OP_PTR1, OP_PTR2);
+}
+
+static void gen_SHA1MSG1(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_helper_sha1msg1(OP_PTR0, OP_PTR1, OP_PTR2);
+}
+
+static void gen_SHA1MSG2(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_helper_sha1msg2(OP_PTR0, OP_PTR1, OP_PTR2);
+}
+
+static void gen_SHA1RNDS4(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    switch(decode->immediate & 3) {
+    case 0:
+        gen_helper_sha1rnds4_f0(OP_PTR0, OP_PTR0, OP_PTR1);
+        break;
+    case 1:
+        gen_helper_sha1rnds4_f1(OP_PTR0, OP_PTR0, OP_PTR1);
+        break;
+    case 2:
+        gen_helper_sha1rnds4_f2(OP_PTR0, OP_PTR0, OP_PTR1);
+        break;
+    case 3:
+        gen_helper_sha1rnds4_f3(OP_PTR0, OP_PTR0, OP_PTR1);
+        break;
+    }
+}
+
+static void gen_SHA256MSG1(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_helper_sha256msg1(OP_PTR0, OP_PTR1, OP_PTR2);
+}
+
+static void gen_SHA256MSG2(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_helper_sha256msg2(OP_PTR0, OP_PTR1, OP_PTR2);
+}
+
+static void gen_SHA256RNDS2(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    TCGv_i32 wk0 = tcg_temp_new_i32();
+    TCGv_i32 wk1 = tcg_temp_new_i32();
+
+    tcg_gen_ld_i32(wk0, tcg_env, ZMM_OFFSET(0) + offsetof(ZMMReg, ZMM_L(0)));
+    tcg_gen_ld_i32(wk1, tcg_env, ZMM_OFFSET(0) + offsetof(ZMMReg, ZMM_L(1)));
+
+    gen_helper_sha256rnds2(OP_PTR0, OP_PTR1, OP_PTR2, wk0, wk1);
+}
+
 static void gen_SHLX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
diff --git a/target/i386/tcg/ops_sse_header.h.inc b/target/i386/tcg/ops_sse_header.h.inc
index 8a7b2f4e2f6..d92c6faf6d6 100644
--- a/target/i386/tcg/ops_sse_header.h.inc
+++ b/target/i386/tcg/ops_sse_header.h.inc
@@ -399,6 +399,20 @@ DEF_HELPER_3(vpermq_ymm, void, Reg, Reg, i32)
 #endif
 #endif
 
+/* SHA helpers */
+#if SHIFT == 1
+DEF_HELPER_3(sha1rnds4_f0, void, Reg, Reg, Reg)
+DEF_HELPER_3(sha1rnds4_f1, void, Reg, Reg, Reg)
+DEF_HELPER_3(sha1rnds4_f2, void, Reg, Reg, Reg)
+DEF_HELPER_3(sha1rnds4_f3, void, Reg, Reg, Reg)
+DEF_HELPER_3(sha1nexte, void, Reg, Reg, Reg)
+DEF_HELPER_3(sha1msg1, void, Reg, Reg, Reg)
+DEF_HELPER_3(sha1msg2, void, Reg, Reg, Reg)
+DEF_HELPER_5(sha256rnds2, void, Reg, Reg, Reg, i32, i32)
+DEF_HELPER_3(sha256msg1, void, Reg, Reg, Reg)
+DEF_HELPER_3(sha256msg2, void, Reg, Reg, Reg)
+#endif
+
 #undef SHIFT
 #undef Reg
 #undef SUFFIX
-- 
2.41.0


