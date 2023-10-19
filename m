Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2937CF5A8
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:49:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQYX-0006Y0-C6; Thu, 19 Oct 2023 06:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQYR-0006FS-QW
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:47:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQYP-0006CY-Ft
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697712420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8s7wHI4CkLj7mZOBGLOqYoTTD0JqgSZM75M93R4VQu8=;
 b=Ip3Gs28vTJRixs3Fy+aId2D+PMybIv9OuddQhsqbbTqIg5SGkqb2zGn8XZzIv+r9SwLyt6
 fUAPC3Hv0V7PTDhac6Ubj7cUNVGYMrYDXvHHZmHXCBFnwjbmQS7HQc8jpRnlIYEx1JKLw7
 TZCjjwrkIjQnu8tWtvkd/a+EeJuBLLg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-61wEotYOM9KVxfTlHIbwKA-1; Thu, 19 Oct 2023 06:46:58 -0400
X-MC-Unique: 61wEotYOM9KVxfTlHIbwKA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-997c891a88dso576286066b.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697712416; x=1698317216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8s7wHI4CkLj7mZOBGLOqYoTTD0JqgSZM75M93R4VQu8=;
 b=P6o1VhlSzeNInN6tg3tcoB45UflTjcA0YFB8ip+dcU/XpfjJmWkAGb379Rb66wD7B+
 cQcCN5ng/vy7ZtV46rNralIstdqPRqaz13LU7JMiuQREZ5qiP2dNq8rh8xvY3/4kE2TU
 lJEWoodVVOccCCeibsaQpIvHqdFcLiKSd4hKVuqiM1+VGe+grFUBDrGOzjnuVG/6mP8M
 UW8GInI6wDqjB2KcK1BJ7I/2OPc0sWILwksW3zShxbUfd8PXfGS3tXvRX3Ww/ZhTGlBY
 wWlvps9eXmo31uBZ/VpGammtllbayreNYfHB1CjaWLHIspq31KZ+LH8k+y9lPaiWxmgr
 Sphg==
X-Gm-Message-State: AOJu0Yzz9teD9LEXoSfLgVpDAWbXFhptdF3qpkyYNqvs13Xm9D5BzVBw
 BjRUCiD58QMRdvjuKquSboAo+nCpOaglTP4p1WSVababuSFWlcPwg7Zj8ewfhO3RAc0TtBUNhfz
 4XjKr3CYI1WpQykTKcELs+IwvoZb9IHirqAY8Xk/R7rHZLilRcPuj5Oj3DI34JoSS8LAXWZPhhH
 k=
X-Received: by 2002:a17:906:4fcd:b0:9bf:30e8:5bfb with SMTP id
 i13-20020a1709064fcd00b009bf30e85bfbmr1624019ejw.48.1697712416539; 
 Thu, 19 Oct 2023 03:46:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7h4jYNMM6NtDuhC4D0IVMyKX4+4rJMbV5p2SlkD9I6WdPfXEo4pDpoku8ySkG4R5QOmAPZQ==
X-Received: by 2002:a17:906:4fcd:b0:9bf:30e8:5bfb with SMTP id
 i13-20020a1709064fcd00b009bf30e85bfbmr1624000ejw.48.1697712416055; 
 Thu, 19 Oct 2023 03:46:56 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 25-20020a170906225900b0098f99048053sm3371537ejr.148.2023.10.19.03.46.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 03:46:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/19] target/i386: implement SHA instructions
Date: Thu, 19 Oct 2023 12:46:32 +0200
Message-ID: <20231019104648.389942-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019104648.389942-1-pbonzini@redhat.com>
References: <20231019104648.389942-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 850271e0898..eb2400095f8 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -504,6 +504,13 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
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
@@ -653,6 +660,8 @@ static const X86OpEntry opcodes_0F3A[256] = {
     [0x4b] = X86_OP_ENTRY4(VBLENDVPD, V,x,  H,x,  W,x,   vex6 chk(W0) cpuid(AVX) p_66),
     [0x4c] = X86_OP_ENTRY4(VPBLENDVB, V,x,  H,x,  W,x,   vex6 chk(W0) cpuid(AVX) p_66 avx2_256),
 
+    [0xcc] = X86_OP_ENTRY3(SHA1RNDS4,  V,dq, W,dq, I,b,  cpuid(SHA_NI)),
+
     [0xdf] = X86_OP_ENTRY3(VAESKEYGEN, V,dq, W,dq, I,b,  vex4 cpuid(AES) p_66),
 
     [0xF0] = X86_OP_ENTRY3(RORX, G,y, E,y, I,b, vex13 cpuid(BMI2) p_f2),
@@ -1500,6 +1509,8 @@ static bool has_cpuid_feature(DisasContext *s, X86CPUIDFeature cpuid)
         return (s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_BMI2);
     case X86_FEAT_AVX2:
         return (s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_AVX2);
+    case X86_FEAT_SHA_NI:
+        return (s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_SHA_NI);
     }
     g_assert_not_reached();
 }
diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index ae987dfe0ba..ab21fa6db97 100644
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
index 7c36cf8a6df..82da5488d47 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1796,6 +1796,60 @@ static void gen_SARX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
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


