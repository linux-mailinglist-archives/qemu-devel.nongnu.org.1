Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 397C97D7887
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:28:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnHZ-0001Ry-OF; Wed, 25 Oct 2023 19:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHX-0001Ro-KG
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHS-0004Pq-HG
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698276437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WBLo6IBJO27UTSd/jvnTHbHcz3l71G2c2+pXAQ8h0vg=;
 b=Kbix3dhObI+knbfPkZGmoUgNvTS6D5Vrebxn40WqTiIi5xgQODG/2sVcZoGIG1CV8NFY56
 danGjE6TtvPUI8h58IEYyIqKXjtpa1Ccs71hjx5B1mpWR8r9Fq4AMwajKCD/PwHh5iu6eF
 yVpbgsBfBRog9LJfDTOFB8IF8wG/4oM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-f21YYDfFOIO6VtnV0tfi4Q-1; Wed, 25 Oct 2023 19:27:15 -0400
X-MC-Unique: f21YYDfFOIO6VtnV0tfi4Q-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-778a20a16e3so40016085a.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276433; x=1698881233;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WBLo6IBJO27UTSd/jvnTHbHcz3l71G2c2+pXAQ8h0vg=;
 b=Op4fTbaMvIyzlwIxG8vEtD/fOGuFYcm5zk3p/+U3aUxLjo7t0236D2gFjnF7LHjATW
 7cnhC2/lBKHcWTY4L+YAefmfGWXHY6PWORQHYCnoit0R9cGk+8l+JSEXIyuhgeecSy2A
 Ry3reGRhDO1EhVByCcOnO/ynJ3G/+RKy4gJPjQLpOAyj2qeNwo0P3iSVgqia/gstHQCd
 WdpnDWreCcOvvV7HpkAez258fYCgDBOmcKGi7wL4qYCYuvNjLb9JdwEoFZSEaUskNdLe
 0OodZUoWKI7QofatdCgBaNhm5EnSj3A1Y9OzsDb5KJJM1dElcVhocKrEkseEIqOnDxli
 G2zQ==
X-Gm-Message-State: AOJu0YwBXb9kvNNcUJolj/UIsj5neEXhafRxLtzvJCKUAtyKdwiWf9bG
 maKFukrb8eGcx8+5wL+ckVYLYE/RVq4ATtGC6Ilp9ppek4ffj1fcep6V3U20QKim5XUX4pBHqqc
 cSMDGC/hrhf0R16YMWkEdo3uQtp0LfGd7Lo0OvKmaWGbcbOX5S1rZkugVvC9EPwa7axggf7UsgM
 U=
X-Received: by 2002:a05:620a:4415:b0:774:244c:8b2c with SMTP id
 v21-20020a05620a441500b00774244c8b2cmr20644990qkp.14.1698276431934; 
 Wed, 25 Oct 2023 16:27:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTnB24Oww5dtBQP4BrGCCBNApHoMcV+BtuZlzR4B9tzhT3xr3TT4If+Pqwi8FMG8lfq2RuzA==
X-Received: by 2002:a05:620a:4415:b0:774:244c:8b2c with SMTP id
 v21-20020a05620a441500b00774244c8b2cmr20644946qkp.14.1698276430737; 
 Wed, 25 Oct 2023 16:27:10 -0700 (PDT)
Received: from [172.19.0.201] ([192.80.84.35])
 by smtp.gmail.com with ESMTPSA id
 ay7-20020a05620a178700b007758d87524esm4573766qkb.3.2023.10.25.16.27.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:27:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 00/24] x86, KVM changes for 2023-10-26
Date: Thu, 26 Oct 2023 01:27:07 +0200
Message-ID: <20231025232709.89392-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
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

The following changes since commit a95260486aa7e78d7c7194eba65cf03311ad94ad:

  Merge tag 'pull-tcg-20231023' of https://gitlab.com/rth7680/qemu into staging (2023-10-23 14:45:46 -0700)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 39dd3e1f55a70f568cc9d280f67467aa4e8a63bd:

  kvm: i8254: require KVM_CAP_PIT2 and KVM_CAP_PIT_STATE2 (2023-10-25 19:53:38 +0200)

----------------------------------------------------------------
* target/i386: implement SHA instructions
* target/i386: check CPUID_PAE to determine 36 bit processor address space
* target/i386: improve validation of AVX instructions
* require Linux 4.4 for KVM

----------------------------------------------------------------
Ani Sinha (1):
      target/i386: check CPUID_PAE to determine 36 bit processor address space

Paolo Bonzini (23):
      tests/tcg: fix out-of-bounds access in test-avx
      target/i386: implement SHA instructions
      tests/tcg/i386: initialize more registers in test-avx
      tests/tcg/i386: test-avx: add test cases for SHA new instructions
      target/i386: group common checks in the decoding phase
      target/i386: validate VEX.W for AVX instructions
      kvm: remove unnecessary stub
      kvm: require KVM_CAP_INTERNAL_ERROR_DATA
      kvm: require KVM_CAP_SIGNAL_MSI
      kvm: require KVM_IRQFD for kernel irqchip
      kvm: require KVM_IRQFD for kernel irqchip
      kvm: drop reference to KVM_CAP_PCI_2_3
      kvm: assume that many ioeventfds can be created
      kvm: require KVM_CAP_IOEVENTFD and KVM_CAP_IOEVENTFD_ANY_LENGTH
      kvm: unify listeners for PIO address space
      kvm: i386: move KVM_CAP_IRQ_ROUTING detection to kvm_arch_required_capabilities
      kvm: i386: require KVM_CAP_DEBUGREGS
      kvm: i386: require KVM_CAP_XSAVE
      kvm: i386: require KVM_CAP_SET_VCPU_EVENTS and KVM_CAP_X86_ROBUST_SINGLESTEP
      kvm: i386: require KVM_CAP_MCE
      kvm: i386: require KVM_CAP_ADJUST_CLOCK
      kvm: i386: require KVM_CAP_SET_IDENTITY_MAP_ADDR
      kvm: i8254: require KVM_CAP_PIT2 and KVM_CAP_PIT_STATE2

 accel/kvm/kvm-all.c                  | 231 ++++------------------------------
 accel/stubs/kvm-stub.c               |  14 ---
 hw/i386/kvm/clock.c                  |   4 -
 hw/i386/kvm/i8254.c                  |  38 ++----
 hw/i386/pc.c                         |   6 +-
 hw/intc/arm_gicv3_its_common.c       |   3 +-
 hw/intc/arm_gicv3_its_kvm.c          |   2 +-
 hw/misc/pci-testdev.c                |   3 +-
 hw/s390x/virtio-ccw.c                |   4 -
 hw/virtio/vhost-user.c               |   7 +-
 hw/virtio/virtio-mmio.c              |   4 -
 hw/virtio/virtio-pci.c               |  23 +---
 include/sysemu/kvm.h                 |  37 +-----
 include/sysemu/kvm_int.h             |   5 -
 system/memory.c                      |  16 +--
 target/i386/cpu.c                    |   4 +-
 target/i386/kvm/kvm.c                | 225 +++------------------------------
 target/i386/kvm/kvm_i386.h           |   2 -
 target/i386/ops_sse.h                | 128 +++++++++++++++++++
 target/i386/tcg/decode-new.c.inc     | 232 ++++++++++++++++++++++++++---------
 target/i386/tcg/decode-new.h         |  36 ++++--
 target/i386/tcg/emit.c.inc           |  62 ++++++++--
 target/i386/tcg/ops_sse_header.h.inc |  14 +++
 target/riscv/kvm/kvm-cpu.c           |   2 +-
 tests/tcg/i386/test-avx.c            |  19 ++-
 tests/tcg/i386/test-avx.py           |   3 +-
 26 files changed, 491 insertions(+), 633 deletions(-)
-- 
2.41.0

From 45b5933f7afb055080e915c83663f3a4709a02db Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Oct 2023 00:51:34 +0200
Subject: [PULL 01/24] tests/tcg: fix out-of-bounds access in test-avx
Content-Type: text/plain; charset=UTF-8

This can cause differences between native and QEMU execution, due
to ASLR.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/tcg/i386/test-avx.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/i386/test-avx.c b/tests/tcg/i386/test-avx.c
index c39c0e5bce8..910b0673535 100644
--- a/tests/tcg/i386/test-avx.c
+++ b/tests/tcg/i386/test-avx.c
@@ -236,12 +236,15 @@ v4di val_i64[] = {
 
 v4di deadbeef = {0xa5a5a5a5deadbeefull, 0xa5a5a5a5deadbeefull,
                  0xa5a5a5a5deadbeefull, 0xa5a5a5a5deadbeefull};
-v4di indexq = {0x000000000000001full, 0x000000000000008full,
-               0xffffffffffffffffull, 0xffffffffffffff5full};
-v4di indexd = {0x00000002000000efull, 0xfffffff500000010ull,
-               0x0000000afffffff0ull, 0x000000000000000eull};
+/* &gather_mem[0x10] is 512 bytes from the base; indices must be >=-64, <64
+ * to account for scaling by 8 */
+v4di indexq = {0x000000000000001full, 0x000000000000003dull,
+               0xffffffffffffffffull, 0xffffffffffffffdfull};
+v4di indexd = {0x00000002ffffffcdull, 0xfffffff500000010ull,
+               0x0000003afffffff0ull, 0x000000000000000eull};
 
 v4di gather_mem[0x20];
+_Static_assert(sizeof(gather_mem) == 1024);
 
 void init_f16reg(v4di *r)
 {
-- 
2.41.0


From e582b629f0b50c10137ba47c4ca7fe30b3357e3d Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 10 Oct 2023 10:31:17 +0200
Subject: [PULL 02/24] target/i386: implement SHA instructions
Content-Type: text/plain; charset=UTF-8

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


From 05a0a100a5e37716c11995532c0b249214846462 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Oct 2023 10:07:27 +0200
Subject: [PULL 03/24] tests/tcg/i386: initialize more registers in test-avx
Content-Type: text/plain; charset=UTF-8

Some instructions use YMM0 implicitly, or use YMM9 as a read-modify-write
register destination.  Initialize those registers as well.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/tcg/i386/test-avx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/tcg/i386/test-avx.c b/tests/tcg/i386/test-avx.c
index 910b0673535..230e6d84b84 100644
--- a/tests/tcg/i386/test-avx.c
+++ b/tests/tcg/i386/test-avx.c
@@ -319,6 +319,8 @@ int main(int argc, char *argv[])
     int i;
 
     init_all(&initI);
+    init_intreg(&initI.ymm[0]);
+    init_intreg(&initI.ymm[9]);
     init_intreg(&initI.ymm[10]);
     init_intreg(&initI.ymm[11]);
     init_intreg(&initI.ymm[12]);
@@ -327,6 +329,8 @@ int main(int argc, char *argv[])
     dump_regs(&initI);
 
     init_all(&initF16);
+    init_f16reg(&initF16.ymm[0]);
+    init_f16reg(&initF16.ymm[9]);
     init_f16reg(&initF16.ymm[10]);
     init_f16reg(&initF16.ymm[11]);
     init_f16reg(&initF16.ymm[12]);
@@ -336,6 +340,8 @@ int main(int argc, char *argv[])
     dump_regs(&initF16);
 
     init_all(&initF32);
+    init_f32reg(&initF32.ymm[0]);
+    init_f32reg(&initF32.ymm[9]);
     init_f32reg(&initF32.ymm[10]);
     init_f32reg(&initF32.ymm[11]);
     init_f32reg(&initF32.ymm[12]);
@@ -345,6 +351,8 @@ int main(int argc, char *argv[])
     dump_regs(&initF32);
 
     init_all(&initF64);
+    init_f64reg(&initF64.ymm[0]);
+    init_f64reg(&initF64.ymm[9]);
     init_f64reg(&initF64.ymm[10]);
     init_f64reg(&initF64.ymm[11]);
     init_f64reg(&initF64.ymm[12]);
-- 
2.41.0


From 48adb240498de5f628631ba7c713a4ccd0cda358 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 10 Oct 2023 10:35:45 +0200
Subject: [PULL 04/24] tests/tcg/i386: test-avx: add test cases for SHA new
 instructions
Content-Type: text/plain; charset=UTF-8

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/tcg/i386/test-avx.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/i386/test-avx.py b/tests/tcg/i386/test-avx.py
index 641a2ef69eb..6063fb2d11d 100755
--- a/tests/tcg/i386/test-avx.py
+++ b/tests/tcg/i386/test-avx.py
@@ -9,7 +9,7 @@
 archs = [
     "SSE", "SSE2", "SSE3", "SSSE3", "SSE4_1", "SSE4_2",
     "AES", "AVX", "AVX2", "AES+AVX", "VAES+AVX",
-    "F16C", "FMA",
+    "F16C", "FMA", "SHA",
 ]
 
 ignore = set(["FISTTP",
@@ -43,6 +43,7 @@
     'vPS[LR][AL][WDQ]': 0x3f,
     'vPS[RL]LDQ': 0x1f,
     'vROUND[PS][SD]': 0x7,
+    'SHA1RNDS4': 0x03,
     'vSHUFPD': 0x0f,
     'vSHUFPS': 0xff,
     'vAESKEYGENASSIST': 0xff,
-- 
2.41.0


From 183e6679e39fb5bcc17dbebaf668c1e83d8e57ee Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 9 Oct 2023 17:43:12 +0200
Subject: [PULL 05/24] target/i386: group common checks in the decoding phase
Content-Type: text/plain; charset=UTF-8

In preparation for adding more similar checks, move the VEX.L=0 check
and several X86_SPECIAL_* checks to a new field, where each bit represent
a common check on unused bits, or a restriction on the processor mode.

Likewise, many SVM intercepts can be checked during the decoding phase,
the main exception being the selective CR0 write, MSR and IOIO intercepts.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 85 ++++++++++++++++++++++++--------
 target/i386/tcg/decode-new.h     | 29 ++++++++---
 target/i386/tcg/emit.c.inc       |  8 ---
 3 files changed, 85 insertions(+), 37 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index ec5d260b7ea..25c1dae55a4 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -90,8 +90,6 @@
     X86_OP_ENTRY3(op, None, None, None, None, None, None, ## __VA_ARGS__)
 
 #define cpuid(feat) .cpuid = X86_FEAT_##feat,
-#define i64 .special = X86_SPECIAL_i64,
-#define o64 .special = X86_SPECIAL_o64,
 #define xchg .special = X86_SPECIAL_Locked,
 #define mmx .special = X86_SPECIAL_MMX,
 #define zext0 .special = X86_SPECIAL_ZExtOp0,
@@ -114,6 +112,9 @@
 #define vex12 .vex_class = 12,
 #define vex13 .vex_class = 13,
 
+#define chk(a) .check = X86_CHECK_##a,
+#define svm(a) .intercept = SVM_EXIT_##a,
+
 #define avx2_256 .vex_special = X86_VEX_AVX2_256,
 
 #define P_00          1
@@ -161,8 +162,8 @@ static void decode_group15(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
     };
 
     static const X86OpEntry group15_mem[8] = {
-        [2] = X86_OP_ENTRYr(LDMXCSR,    E,d, vex5),
-        [3] = X86_OP_ENTRYw(STMXCSR,    E,d, vex5),
+        [2] = X86_OP_ENTRYr(LDMXCSR,    E,d, vex5 chk(VEX128)),
+        [3] = X86_OP_ENTRYw(STMXCSR,    E,d, vex5 chk(VEX128)),
     };
 
     uint8_t modrm = get_modrm(s, env);
@@ -1590,6 +1591,12 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
     if (s->flags & HF_EM_MASK) {
         goto illegal;
     }
+
+    if (e->check & X86_CHECK_VEX128) {
+        if (s->vex_l) {
+            goto illegal;
+        }
+    }
     return true;
 
 nm_exception:
@@ -1775,6 +1782,25 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
         goto illegal_op;
     }
 
+    /* Checks that result in #UD come first.  */
+    if (decode.e.check) {
+        if (decode.e.check & X86_CHECK_i64) {
+            if (CODE64(s)) {
+                goto illegal_op;
+            }
+        }
+        if (decode.e.check & X86_CHECK_o64) {
+            if (!CODE64(s)) {
+                goto illegal_op;
+            }
+        }
+        if (decode.e.check & X86_CHECK_prot) {
+            if (!PE(s) || VM86(s)) {
+                goto illegal_op;
+            }
+        }
+    }
+
     switch (decode.e.special) {
     case X86_SPECIAL_None:
         break;
@@ -1785,23 +1811,6 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
         }
         break;
 
-    case X86_SPECIAL_ProtMode:
-        if (!PE(s) || VM86(s)) {
-            goto illegal_op;
-        }
-        break;
-
-    case X86_SPECIAL_i64:
-        if (CODE64(s)) {
-            goto illegal_op;
-        }
-        break;
-    case X86_SPECIAL_o64:
-        if (!CODE64(s)) {
-            goto illegal_op;
-        }
-        break;
-
     case X86_SPECIAL_ZExtOp0:
         assert(decode.op[0].unit == X86_OP_INT);
         if (!decode.op[0].has_ea) {
@@ -1831,6 +1840,37 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
     if (!validate_vex(s, &decode)) {
         return;
     }
+
+    /*
+     * Checks that result in #GP or VMEXIT come second.  Intercepts are
+     * generally checked after non-memory exceptions (i.e. before all
+     * exceptions if there is no memory operand).  Exceptions are
+     * vm86 checks (INTn, IRET, PUSHF/POPF), RSM and XSETBV (!).
+     *
+     * RSM and XSETBV will be handled in the gen_* functions
+     * instead of using chk().
+     */
+    if (decode.e.check & X86_CHECK_cpl0) {
+        if (CPL(s) != 0) {
+            goto gp_fault;
+        }
+    }
+    if (decode.e.intercept && unlikely(GUEST(s))) {
+        gen_helper_svm_check_intercept(tcg_env,
+                                       tcg_constant_i32(decode.e.intercept));
+    }
+    if (decode.e.check) {
+        if ((decode.e.check & X86_CHECK_vm86_iopl) && VM86(s)) {
+            if (IOPL(s) < 3) {
+                goto gp_fault;
+            }
+        } else if (decode.e.check & X86_CHECK_cpl_iopl) {
+            if (IOPL(s) < CPL(s)) {
+                goto gp_fault;
+            }
+        }
+    }
+
     if (decode.e.special == X86_SPECIAL_MMX &&
         !(s->prefix & (PREFIX_REPZ | PREFIX_REPNZ | PREFIX_DATA))) {
         gen_helper_enter_mmx(tcg_env);
@@ -1857,6 +1897,9 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
         gen_writeback(s, &decode, 0, s->T0);
     }
     return;
+ gp_fault:
+    gen_exception_gpf(s);
+    return;
  illegal_op:
     gen_illegal_opcode(s);
     return;
diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 9be8a6e65fd..bbc9aea940d 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -131,15 +131,30 @@ typedef enum X86OpUnit {
     X86_OP_MMX,     /* address in either s->ptrX or s->A0 depending on has_ea */
 } X86OpUnit;
 
+typedef enum X86InsnCheck {
+    /* Illegal or exclusive to 64-bit mode */
+    X86_CHECK_i64 = 1,
+    X86_CHECK_o64 = 2,
+
+    /* Fault outside protected mode */
+    X86_CHECK_prot = 4,
+
+    /* Privileged instruction checks */
+    X86_CHECK_cpl0 = 8,
+    X86_CHECK_vm86_iopl = 16,
+    X86_CHECK_cpl_iopl = 32,
+    X86_CHECK_iopl = X86_CHECK_cpl_iopl | X86_CHECK_vm86_iopl,
+
+    /* Fault if VEX.L=1 */
+    X86_CHECK_VEX128 = 64,
+} X86InsnCheck;
+
 typedef enum X86InsnSpecial {
     X86_SPECIAL_None,
 
     /* Always locked if it has a memory operand (XCHG) */
     X86_SPECIAL_Locked,
 
-    /* Fault outside protected mode */
-    X86_SPECIAL_ProtMode,
-
     /*
      * Register operand 0/2 is zero extended to 32 bits.  Rd/Mb or Rd/Mw
      * in the manual.
@@ -158,10 +173,6 @@ typedef enum X86InsnSpecial {
      * become P/P/Q/N, and size "x" becomes "q".
      */
     X86_SPECIAL_MMX,
-
-    /* Illegal or exclusive to 64-bit mode */
-    X86_SPECIAL_i64,
-    X86_SPECIAL_o64,
 } X86InsnSpecial;
 
 /*
@@ -224,7 +235,9 @@ struct X86OpEntry {
     X86CPUIDFeature cpuid:8;
     unsigned     vex_class:8;
     X86VEXSpecial vex_special:8;
-    uint16_t     valid_prefix:16;
+    unsigned     valid_prefix:16;
+    unsigned     check:16;
+    unsigned     intercept:8;
     bool         is_decode:1;
 };
 
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 16085a19d7a..82da5488d47 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1236,10 +1236,6 @@ static void gen_INSERTQ_r(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
 
 static void gen_LDMXCSR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
-    if (s->vex_l) {
-        gen_illegal_opcode(s);
-        return;
-    }
     tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T1);
     gen_helper_ldmxcsr(tcg_env, s->tmp2_i32);
 }
@@ -1886,10 +1882,6 @@ static void gen_VAESKEYGEN(DisasContext *s, CPUX86State *env, X86DecodedInsn *de
 
 static void gen_STMXCSR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
-    if (s->vex_l) {
-        gen_illegal_opcode(s);
-        return;
-    }
     gen_helper_update_mxcsr(tcg_env);
     tcg_gen_ld32u_tl(s->T0, tcg_env, offsetof(CPUX86State, mxcsr));
 }
-- 
2.41.0


From e000687f1266d031528758271d0b16e288394ede Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 9 Oct 2023 18:16:27 +0200
Subject: [PULL 06/24] target/i386: validate VEX.W for AVX instructions
Content-Type: text/plain; charset=UTF-8

Instructions in VEX exception class 6 generally look at the value of
VEX.W.  Note that the manual places some instructions incorrectly in
class 4, for example VPERMQ which has no non-VEX encoding and no legacy
SSE analogue.  AMD does a mess of its own, as documented in the comment
that this patch adds.

Most of them are checked for VEX.W=0, and are listed in the manual
(though with an omission) in table 2-16; VPERMQ and VPERMPD check for
VEX.W=1, which is only listed in the instruction description.  Others,
such as VPSRLV, VPSLLV and the FMA3 instructions, use VEX.W to switch
between a 32-bit and 64-bit operation.

Fix more of the class 4/class 6 mismatches, and implement the check for
VEX.W in TCG.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 142 ++++++++++++++++++++++---------
 target/i386/tcg/decode-new.h     |   6 ++
 2 files changed, 107 insertions(+), 41 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 25c1dae55a4..2bdbb1bba0f 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -23,7 +23,11 @@
  * The decoder is mostly based on tables copied from the Intel SDM.  As
  * a result, most operand load and writeback is done entirely in common
  * table-driven code using the same operand type (X86_TYPE_*) and
- * size (X86_SIZE_*) codes used in the manual.
+ * size (X86_SIZE_*) codes used in the manual.  There are a few differences
+ * though.
+ *
+ * Vector operands
+ * ---------------
  *
  * The main difference is that the V, U and W types are extended to
  * cover MMX as well; if an instruction is like
@@ -43,6 +47,50 @@
  * There are a couple cases in which instructions (e.g. MOVD) write the
  * whole XMM or MM register but are established incorrectly in the manual
  * as "d" or "q".  These have to be fixed for the decoder to work correctly.
+ *
+ * VEX exception classes
+ * ---------------------
+ *
+ * Speaking about imprecisions in the manual, the decoder treats all
+ * exception-class 4 instructions as having an optional VEX prefix, and
+ * all exception-class 6 instructions as having a mandatory VEX prefix.
+ * This is true except for a dozen instructions; these are in exception
+ * class 4 but do not ignore the VEX.W bit (which does not even exist
+ * without a VEX prefix).  These instructions are mostly listed in Intel's
+ * table 2-16, but with a few exceptions.
+ *
+ * The AMD manual has more precise subclasses for exceptions, and unlike Intel
+ * they list the VEX.W requirements in the exception classes as well (except
+ * when they don't).  AMD describes class 6 as "AVX Mixed Memory Argument"
+ * without defining what a mixed memory argument is, but still use 4 as the
+ * primary exception class... except when they don't.
+ *
+ * The summary is:
+ *                       Intel     AMD         VEX.W           note
+ * -------------------------------------------------------------------
+ * vpblendd              4         4J          0
+ * vpblendvb             4         4E-X        0               (*)
+ * vpbroadcastq          6         6D          0               (+)
+ * vpermd/vpermps        4         4H          0               (§)
+ * vpermq/vpermpd        4         4H-1        1               (§)
+ * vpermilpd/vpermilps   4         6E          0               (^)
+ * vpmaskmovd            6         4K          significant     (^)
+ * vpsllv                4         4K          significant
+ * vpsrav                4         4J          0
+ * vpsrlv                4         4K          significant
+ * vtestps/vtestpd       4         4G          0
+ *
+ *    (*)  AMD lists VPBLENDVB as related to SSE4.1 PBLENDVB, which may
+ *         explain why it is considered exception class 4.  However,
+ *         Intel says that VEX-only instructions should be in class 6...
+ *
+ *    (+)  Not found in Intel's table 2-16
+ *
+ *    (§)  4H and 4H-1 do not mention VEX.W requirements, which are
+ *         however present in the description of the instruction
+ *
+ *    (^)  these are the two cases in which Intel and AMD disagree on the
+ *         primary exception class
  */
 
 #define X86_OP_NONE { 0 },
@@ -338,11 +386,11 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
     [0x07] = X86_OP_ENTRY3(PHSUBSW,   V,x,  H,x,   W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
 
     [0x10] = X86_OP_ENTRY2(PBLENDVB,  V,x,         W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
-    [0x13] = X86_OP_ENTRY2(VCVTPH2PS, V,x,         W,xh, vex11 cpuid(F16C) p_66),
+    [0x13] = X86_OP_ENTRY2(VCVTPH2PS, V,x,         W,xh, vex11 chk(W0) cpuid(F16C) p_66),
     [0x14] = X86_OP_ENTRY2(BLENDVPS,  V,x,         W,x,  vex4 cpuid(SSE41) p_66),
     [0x15] = X86_OP_ENTRY2(BLENDVPD,  V,x,         W,x,  vex4 cpuid(SSE41) p_66),
     /* Listed incorrectly as type 4 */
-    [0x16] = X86_OP_ENTRY3(VPERMD,    V,qq, H,qq,      W,qq,  vex6 cpuid(AVX2) p_66),
+    [0x16] = X86_OP_ENTRY3(VPERMD,    V,qq, H,qq,      W,qq,  vex6 chk(W0) cpuid(AVX2) p_66), /* vpermps */
     [0x17] = X86_OP_ENTRY3(VPTEST,    None,None, V,x,  W,x,   vex4 cpuid(SSE41) p_66),
 
     /*
@@ -363,14 +411,14 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
     [0x33] = X86_OP_ENTRY3(VPMOVZXWD, V,x,  None,None, W,q,   vex5 cpuid(SSE41) avx_movx avx2_256 p_66),
     [0x34] = X86_OP_ENTRY3(VPMOVZXWQ, V,x,  None,None, W,d,   vex5 cpuid(SSE41) avx_movx avx2_256 p_66),
     [0x35] = X86_OP_ENTRY3(VPMOVZXDQ, V,x,  None,None, W,q,   vex5 cpuid(SSE41) avx_movx avx2_256 p_66),
-    [0x36] = X86_OP_ENTRY3(VPERMD,    V,qq, H,qq,      W,qq,  vex6 cpuid(AVX2) p_66),
+    [0x36] = X86_OP_ENTRY3(VPERMD,    V,qq, H,qq,      W,qq,  vex6 chk(W0) cpuid(AVX2) p_66),
     [0x37] = X86_OP_ENTRY3(PCMPGTQ,   V,x,  H,x,       W,x,   vex4 cpuid(SSE42) avx2_256 p_66),
 
     [0x40] = X86_OP_ENTRY3(PMULLD,      V,x,  H,x,       W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
     [0x41] = X86_OP_ENTRY3(VPHMINPOSUW, V,dq, None,None, W,dq, vex4 cpuid(SSE41) p_66),
     /* Listed incorrectly as type 4 */
     [0x45] = X86_OP_ENTRY3(VPSRLV,      V,x,  H,x,       W,x,  vex6 cpuid(AVX2) p_66),
-    [0x46] = X86_OP_ENTRY3(VPSRAV,      V,x,  H,x,       W,x,  vex6 cpuid(AVX2) p_66),
+    [0x46] = X86_OP_ENTRY3(VPSRAV,      V,x,  H,x,       W,x,  vex6 chk(W0) cpuid(AVX2) p_66),
     [0x47] = X86_OP_ENTRY3(VPSLLV,      V,x,  H,x,       W,x,  vex6 cpuid(AVX2) p_66),
 
     [0x90] = X86_OP_ENTRY3(VPGATHERD, V,x,  H,x,  M,d,  vex12 cpuid(AVX2) p_66), /* vpgatherdd/q */
@@ -392,14 +440,15 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
     [0x09] = X86_OP_ENTRY3(PSIGNW,    V,x,        H,x,  W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
     [0x0a] = X86_OP_ENTRY3(PSIGND,    V,x,        H,x,  W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
     [0x0b] = X86_OP_ENTRY3(PMULHRSW,  V,x,        H,x,  W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
-    [0x0c] = X86_OP_ENTRY3(VPERMILPS, V,x,        H,x,  W,x,  vex4 cpuid(AVX) p_00_66),
-    [0x0d] = X86_OP_ENTRY3(VPERMILPD, V,x,        H,x,  W,x,  vex4 cpuid(AVX) p_66),
-    [0x0e] = X86_OP_ENTRY3(VTESTPS,   None,None,  V,x,  W,x,  vex4 cpuid(AVX) p_66),
-    [0x0f] = X86_OP_ENTRY3(VTESTPD,   None,None,  V,x,  W,x,  vex4 cpuid(AVX) p_66),
+    /* Listed incorrectly as type 4 */
+    [0x0c] = X86_OP_ENTRY3(VPERMILPS, V,x,        H,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_00_66),
+    [0x0d] = X86_OP_ENTRY3(VPERMILPD, V,x,        H,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_66),
+    [0x0e] = X86_OP_ENTRY3(VTESTPS,   None,None,  V,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_66),
+    [0x0f] = X86_OP_ENTRY3(VTESTPD,   None,None,  V,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_66),
 
-    [0x18] = X86_OP_ENTRY3(VPBROADCASTD,   V,x,  None,None, W,d,  vex6 cpuid(AVX) p_66), /* vbroadcastss */
-    [0x19] = X86_OP_ENTRY3(VPBROADCASTQ,   V,qq, None,None, W,q,  vex6 cpuid(AVX) p_66), /* vbroadcastsd */
-    [0x1a] = X86_OP_ENTRY3(VBROADCASTx128, V,qq, None,None, WM,dq,vex6 cpuid(AVX) p_66),
+    [0x18] = X86_OP_ENTRY3(VPBROADCASTD,   V,x,  None,None, W,d,  vex6 chk(W0) cpuid(AVX) p_66), /* vbroadcastss */
+    [0x19] = X86_OP_ENTRY3(VPBROADCASTQ,   V,qq, None,None, W,q,  vex6 chk(W0) cpuid(AVX) p_66), /* vbroadcastsd */
+    [0x1a] = X86_OP_ENTRY3(VBROADCASTx128, V,qq, None,None, WM,dq,vex6 chk(W0) cpuid(AVX) p_66),
     [0x1c] = X86_OP_ENTRY3(PABSB,          V,x,  None,None, W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
     [0x1d] = X86_OP_ENTRY3(PABSW,          V,x,  None,None, W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
     [0x1e] = X86_OP_ENTRY3(PABSD,          V,x,  None,None, W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
@@ -408,11 +457,11 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
     [0x29] = X86_OP_ENTRY3(PCMPEQQ,       V,x, H,x,       W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
     [0x2a] = X86_OP_ENTRY3(MOVDQ,         V,x, None,None, WM,x, vex1 cpuid(SSE41) avx2_256 p_66), /* movntdqa */
     [0x2b] = X86_OP_ENTRY3(VPACKUSDW,     V,x, H,x,       W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
-    [0x2c] = X86_OP_ENTRY3(VMASKMOVPS,    V,x, H,x,       WM,x, vex6 cpuid(AVX) p_66),
-    [0x2d] = X86_OP_ENTRY3(VMASKMOVPD,    V,x, H,x,       WM,x, vex6 cpuid(AVX) p_66),
+    [0x2c] = X86_OP_ENTRY3(VMASKMOVPS,    V,x, H,x,       WM,x, vex6 chk(W0) cpuid(AVX) p_66),
+    [0x2d] = X86_OP_ENTRY3(VMASKMOVPD,    V,x, H,x,       WM,x, vex6 chk(W0) cpuid(AVX) p_66),
     /* Incorrectly listed as Mx,Hx,Vx in the manual */
-    [0x2e] = X86_OP_ENTRY3(VMASKMOVPS_st, M,x, V,x,       H,x,  vex6 cpuid(AVX) p_66),
-    [0x2f] = X86_OP_ENTRY3(VMASKMOVPD_st, M,x, V,x,       H,x,  vex6 cpuid(AVX) p_66),
+    [0x2e] = X86_OP_ENTRY3(VMASKMOVPS_st, M,x, V,x,       H,x,  vex6 chk(W0) cpuid(AVX) p_66),
+    [0x2f] = X86_OP_ENTRY3(VMASKMOVPD_st, M,x, V,x,       H,x,  vex6 chk(W0) cpuid(AVX) p_66),
 
     [0x38] = X86_OP_ENTRY3(PMINSB,        V,x,  H,x, W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
     [0x39] = X86_OP_ENTRY3(PMINSD,        V,x,  H,x, W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
@@ -423,12 +472,13 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
     [0x3e] = X86_OP_ENTRY3(PMAXUW,        V,x,  H,x, W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
     [0x3f] = X86_OP_ENTRY3(PMAXUD,        V,x,  H,x, W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
 
-    [0x58] = X86_OP_ENTRY3(VPBROADCASTD,   V,x,  None,None, W,d,  vex6 cpuid(AVX2) p_66),
-    [0x59] = X86_OP_ENTRY3(VPBROADCASTQ,   V,x,  None,None, W,q,  vex6 cpuid(AVX2) p_66),
-    [0x5a] = X86_OP_ENTRY3(VBROADCASTx128, V,qq, None,None, WM,dq,vex6 cpuid(AVX2) p_66),
+    /* VPBROADCASTQ not listed as W0 in table 2-16 */
+    [0x58] = X86_OP_ENTRY3(VPBROADCASTD,   V,x,  None,None, W,d,  vex6 chk(W0) cpuid(AVX2) p_66),
+    [0x59] = X86_OP_ENTRY3(VPBROADCASTQ,   V,x,  None,None, W,q,  vex6 chk(W0) cpuid(AVX2) p_66),
+    [0x5a] = X86_OP_ENTRY3(VBROADCASTx128, V,qq, None,None, WM,dq,vex6 chk(W0) cpuid(AVX2) p_66),
 
-    [0x78] = X86_OP_ENTRY3(VPBROADCASTB,   V,x,  None,None, W,b,  vex6 cpuid(AVX2) p_66),
-    [0x79] = X86_OP_ENTRY3(VPBROADCASTW,   V,x,  None,None, W,w,  vex6 cpuid(AVX2) p_66),
+    [0x78] = X86_OP_ENTRY3(VPBROADCASTB,   V,x,  None,None, W,b,  vex6 chk(W0) cpuid(AVX2) p_66),
+    [0x79] = X86_OP_ENTRY3(VPBROADCASTW,   V,x,  None,None, W,w,  vex6 chk(W0) cpuid(AVX2) p_66),
 
     [0x8c] = X86_OP_ENTRY3(VPMASKMOV,    V,x,  H,x, WM,x, vex6 cpuid(AVX2) p_66),
     [0x8e] = X86_OP_ENTRY3(VPMASKMOV_st, M,x,  V,x, H,x,  vex6 cpuid(AVX2) p_66),
@@ -562,18 +612,18 @@ static const X86OpEntry opcodes_0F3A[256] = {
      * Also the "qq" instructions are sometimes omitted by Table 2-17, but are VEX256
      * only.
      */
-    [0x00] = X86_OP_ENTRY3(VPERMQ,      V,qq, W,qq, I,b,  vex6 cpuid(AVX2) p_66),
-    [0x01] = X86_OP_ENTRY3(VPERMQ,      V,qq, W,qq, I,b,  vex6 cpuid(AVX2) p_66), /* VPERMPD */
-    [0x02] = X86_OP_ENTRY4(VBLENDPS,    V,x,  H,x,  W,x,  vex6 cpuid(AVX2) p_66), /* VPBLENDD */
-    [0x04] = X86_OP_ENTRY3(VPERMILPS_i, V,x,  W,x,  I,b,  vex6 cpuid(AVX) p_66),
-    [0x05] = X86_OP_ENTRY3(VPERMILPD_i, V,x,  W,x,  I,b,  vex6 cpuid(AVX) p_66),
-    [0x06] = X86_OP_ENTRY4(VPERM2x128,  V,qq, H,qq, W,qq, vex6 cpuid(AVX) p_66),
+    [0x00] = X86_OP_ENTRY3(VPERMQ,      V,qq, W,qq, I,b,  vex6 chk(W1) cpuid(AVX2) p_66),
+    [0x01] = X86_OP_ENTRY3(VPERMQ,      V,qq, W,qq, I,b,  vex6 chk(W1) cpuid(AVX2) p_66), /* VPERMPD */
+    [0x02] = X86_OP_ENTRY4(VBLENDPS,    V,x,  H,x,  W,x,  vex6 chk(W0) cpuid(AVX2) p_66), /* VPBLENDD */
+    [0x04] = X86_OP_ENTRY3(VPERMILPS_i, V,x,  W,x,  I,b,  vex6 chk(W0) cpuid(AVX) p_66),
+    [0x05] = X86_OP_ENTRY3(VPERMILPD_i, V,x,  W,x,  I,b,  vex6 chk(W0) cpuid(AVX) p_66),
+    [0x06] = X86_OP_ENTRY4(VPERM2x128,  V,qq, H,qq, W,qq, vex6 chk(W0) cpuid(AVX) p_66),
 
     [0x14] = X86_OP_ENTRY3(PEXTRB,     E,b,  V,dq, I,b,  vex5 cpuid(SSE41) zext0 p_66),
     [0x15] = X86_OP_ENTRY3(PEXTRW,     E,w,  V,dq, I,b,  vex5 cpuid(SSE41) zext0 p_66),
     [0x16] = X86_OP_ENTRY3(PEXTR,      E,y,  V,dq, I,b,  vex5 cpuid(SSE41) p_66),
     [0x17] = X86_OP_ENTRY3(VEXTRACTPS, E,d,  V,dq, I,b,  vex5 cpuid(SSE41) p_66),
-    [0x1d] = X86_OP_ENTRY3(VCVTPS2PH,  W,xh, V,x,  I,b,  vex11 cpuid(F16C) p_66),
+    [0x1d] = X86_OP_ENTRY3(VCVTPS2PH,  W,xh, V,x,  I,b,  vex11 chk(W0) cpuid(F16C) p_66),
 
     [0x20] = X86_OP_ENTRY4(PINSRB,     V,dq, H,dq, E,b,  vex5 cpuid(SSE41) zext2 p_66),
     [0x21] = X86_OP_GROUP0(VINSERTPS),
@@ -583,7 +633,7 @@ static const X86OpEntry opcodes_0F3A[256] = {
     [0x41] = X86_OP_ENTRY4(VDDPD,      V,dq, H,dq, W,dq, vex2 cpuid(SSE41) p_66),
     [0x42] = X86_OP_ENTRY4(VMPSADBW,   V,x,  H,x,  W,x,  vex2 cpuid(SSE41) avx2_256 p_66),
     [0x44] = X86_OP_ENTRY4(PCLMULQDQ,  V,dq, H,dq, W,dq, vex4 cpuid(PCLMULQDQ) p_66),
-    [0x46] = X86_OP_ENTRY4(VPERM2x128, V,qq, H,qq, W,qq, vex6 cpuid(AVX2) p_66),
+    [0x46] = X86_OP_ENTRY4(VPERM2x128, V,qq, H,qq, W,qq, vex6 chk(W0) cpuid(AVX2) p_66),
 
     [0x60] = X86_OP_ENTRY4(PCMPESTRM,  None,None, V,dq, W,dq, vex4_unal cpuid(SSE42) p_66),
     [0x61] = X86_OP_ENTRY4(PCMPESTRI,  None,None, V,dq, W,dq, vex4_unal cpuid(SSE42) p_66),
@@ -606,16 +656,16 @@ static const X86OpEntry opcodes_0F3A[256] = {
     [0x0e] = X86_OP_ENTRY4(VPBLENDW,   V,x,  H,x,  W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
     [0x0f] = X86_OP_ENTRY4(PALIGNR,    V,x,  H,x,  W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
 
-    [0x18] = X86_OP_ENTRY4(VINSERTx128,  V,qq, H,qq, W,qq, vex6 cpuid(AVX) p_66),
-    [0x19] = X86_OP_ENTRY3(VEXTRACTx128, W,dq, V,qq, I,b,  vex6 cpuid(AVX) p_66),
+    [0x18] = X86_OP_ENTRY4(VINSERTx128,  V,qq, H,qq, W,qq, vex6 chk(W0) cpuid(AVX) p_66),
+    [0x19] = X86_OP_ENTRY3(VEXTRACTx128, W,dq, V,qq, I,b,  vex6 chk(W0) cpuid(AVX) p_66),
 
-    [0x38] = X86_OP_ENTRY4(VINSERTx128,  V,qq, H,qq, W,qq, vex6 cpuid(AVX2) p_66),
-    [0x39] = X86_OP_ENTRY3(VEXTRACTx128, W,dq, V,qq, I,b,  vex6 cpuid(AVX2) p_66),
+    [0x38] = X86_OP_ENTRY4(VINSERTx128,  V,qq, H,qq, W,qq, vex6 chk(W0) cpuid(AVX2) p_66),
+    [0x39] = X86_OP_ENTRY3(VEXTRACTx128, W,dq, V,qq, I,b,  vex6 chk(W0) cpuid(AVX2) p_66),
 
     /* Listed incorrectly as type 4 */
-    [0x4a] = X86_OP_ENTRY4(VBLENDVPS, V,x,  H,x,  W,x,   vex6 cpuid(AVX) p_66),
-    [0x4b] = X86_OP_ENTRY4(VBLENDVPD, V,x,  H,x,  W,x,   vex6 cpuid(AVX) p_66),
-    [0x4c] = X86_OP_ENTRY4(VPBLENDVB, V,x,  H,x,  W,x,   vex6 cpuid(AVX) p_66 avx2_256),
+    [0x4a] = X86_OP_ENTRY4(VBLENDVPS, V,x,  H,x,  W,x,   vex6 chk(W0) cpuid(AVX) p_66),
+    [0x4b] = X86_OP_ENTRY4(VBLENDVPD, V,x,  H,x,  W,x,   vex6 chk(W0) cpuid(AVX) p_66),
+    [0x4c] = X86_OP_ENTRY4(VPBLENDVB, V,x,  H,x,  W,x,   vex6 chk(W0) cpuid(AVX) p_66 avx2_256),
 
     [0xcc] = X86_OP_ENTRY3(SHA1RNDS4,  V,dq, W,dq, I,b,  cpuid(SHA_NI)),
 
@@ -1505,8 +1555,6 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
         }
     }
 
-    /* TODO: instructions that require VEX.W=0 (Table 2-16) */
-
     switch (e->vex_class) {
     case 0:
         if (s->prefix & PREFIX_VEX) {
@@ -1592,9 +1640,21 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
         goto illegal;
     }
 
-    if (e->check & X86_CHECK_VEX128) {
-        if (s->vex_l) {
-            goto illegal;
+    if (e->check) {
+        if (e->check & X86_CHECK_VEX128) {
+            if (s->vex_l) {
+                goto illegal;
+            }
+        }
+        if (e->check & X86_CHECK_W0) {
+            if (s->vex_w) {
+                goto illegal;
+            }
+        }
+        if (e->check & X86_CHECK_W1) {
+            if (!s->vex_w) {
+                goto illegal;
+            }
         }
     }
     return true;
diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index bbc9aea940d..e6c904a3192 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -147,6 +147,12 @@ typedef enum X86InsnCheck {
 
     /* Fault if VEX.L=1 */
     X86_CHECK_VEX128 = 64,
+
+    /* Fault if VEX.W=1 */
+    X86_CHECK_W0 = 128,
+
+    /* Fault if VEX.W=0 */
+    X86_CHECK_W1 = 256,
 } X86InsnCheck;
 
 typedef enum X86InsnSpecial {
-- 
2.41.0


From d83005424774fcfb85aec76effac169cadb375fd Mon Sep 17 00:00:00 2001
From: Ani Sinha <anisinha@redhat.com>
Date: Tue, 12 Sep 2023 17:36:50 +0530
Subject: [PULL 07/24] target/i386: check CPUID_PAE to determine 36 bit
 processor address space
Content-Type: text/plain; charset=UTF-8

PAE mode in x86 supports 36 bit address space. Check the PAE CPUID on the
guest processor and set phys_bits to 36 if PAE feature is set. This is in
addition to checking the presence of PSE36 CPUID feature for setting 36 bit
phys_bits.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-ID: <20230912120650.371781-1-anisinha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 070c02000fe..fc8484cb5e8 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7377,7 +7377,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
             return;
         }
 
-        if (env->features[FEAT_1_EDX] & CPUID_PSE36) {
+        if (env->features[FEAT_1_EDX] & (CPUID_PSE36 | CPUID_PAE)) {
             cpu->phys_bits = 36;
         } else {
             cpu->phys_bits = 32;
-- 
2.41.0


From cd08948840c029ca537e414e27b575536dff5956 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2023 11:15:09 +0200
Subject: [PULL 08/24] kvm: remove unnecessary stub
Content-Type: text/plain; charset=UTF-8

This function is only invoked from hw/intc/s390_flic_kvm.c, and therefore
only if CONFIG_KVM is defined.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/stubs/kvm-stub.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 51f522e52e8..a323252f8e2 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -92,11 +92,6 @@ void kvm_irqchip_change_notify(void)
 {
 }
 
-int kvm_irqchip_add_adapter_route(KVMState *s, AdapterInfo *adapter)
-{
-    return -ENOSYS;
-}
-
 int kvm_irqchip_add_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
                                        EventNotifier *rn, int virq)
 {
-- 
2.41.0


From aacec9aee11660471ca56afaaafe3f1fdcf431ab Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Oct 2023 13:51:30 +0200
Subject: [PULL 09/24] kvm: require KVM_CAP_INTERNAL_ERROR_DATA
Content-Type: text/plain; charset=UTF-8

This was introduced in KVM in Linux 2.6.33, we can require it unconditionally.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 3f7eafe08cb..8eee5042252 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -111,6 +111,7 @@ static const KVMCapabilityInfo kvm_required_capabilites[] = {
     KVM_CAP_INFO(USER_MEMORY),
     KVM_CAP_INFO(DESTROY_MEMORY_REGION_WORKS),
     KVM_CAP_INFO(JOIN_MEMORY_REGIONS_WORKS),
+    KVM_CAP_INFO(INTERNAL_ERROR_DATA),
     KVM_CAP_LAST_INFO
 };
 
@@ -2794,16 +2795,14 @@ static void kvm_handle_io(uint16_t port, MemTxAttrs attrs, void *data, int direc
 
 static int kvm_handle_internal_error(CPUState *cpu, struct kvm_run *run)
 {
+    int i;
+
     fprintf(stderr, "KVM internal error. Suberror: %d\n",
             run->internal.suberror);
 
-    if (kvm_check_extension(kvm_state, KVM_CAP_INTERNAL_ERROR_DATA)) {
-        int i;
-
-        for (i = 0; i < run->internal.ndata; ++i) {
-            fprintf(stderr, "extra data[%d]: 0x%016"PRIx64"\n",
-                    i, (uint64_t)run->internal.data[i]);
-        }
+    for (i = 0; i < run->internal.ndata; ++i) {
+        fprintf(stderr, "extra data[%d]: 0x%016"PRIx64"\n",
+                i, (uint64_t)run->internal.data[i]);
     }
     if (run->internal.suberror == KVM_INTERNAL_ERROR_EMULATION) {
         fprintf(stderr, "emulation failure\n");
-- 
2.41.0


From cc5e719e2c8086c61bdd9114f42095f8d5b1b0db Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Oct 2023 13:24:33 +0200
Subject: [PULL 10/24] kvm: require KVM_CAP_SIGNAL_MSI
Content-Type: text/plain; charset=UTF-8

This was introduced in KVM in Linux 3.5, we can require it unconditionally
in kvm_irqchip_send_msi().  However, not all architectures have to implement
it so check it only in x86, the only architecture that ever had MSI injection
but not KVM_CAP_SIGNAL_MSI.

ARM uses it to detect the presence of the ITS emulation in the kernel,
introduced in Linux 4.8.  Assume that it's there and possibly fail when
realizing the arm-its-kvm device.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c            | 102 +++------------------------------
 accel/stubs/kvm-stub.c         |   1 -
 hw/intc/arm_gicv3_its_common.c |   3 +-
 include/sysemu/kvm.h           |   9 ---
 include/sysemu/kvm_int.h       |   1 -
 target/i386/kvm/kvm.c          |   1 +
 6 files changed, 9 insertions(+), 108 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 8eee5042252..0c7b0569da4 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -99,7 +99,6 @@ bool kvm_gsi_direct_mapping;
 bool kvm_allowed;
 bool kvm_readonly_mem_allowed;
 bool kvm_vm_attributes_allowed;
-bool kvm_direct_msi_allowed;
 bool kvm_ioeventfd_any_length_allowed;
 bool kvm_msi_use_devid;
 bool kvm_has_guest_debug;
@@ -1848,7 +1847,7 @@ static void clear_gsi(KVMState *s, unsigned int gsi)
 
 void kvm_init_irq_routing(KVMState *s)
 {
-    int gsi_count, i;
+    int gsi_count;
 
     gsi_count = kvm_check_extension(s, KVM_CAP_IRQ_ROUTING) - 1;
     if (gsi_count > 0) {
@@ -1860,12 +1859,6 @@ void kvm_init_irq_routing(KVMState *s)
     s->irq_routes = g_malloc0(sizeof(*s->irq_routes));
     s->nr_allocated_irq_routes = 0;
 
-    if (!kvm_direct_msi_allowed) {
-        for (i = 0; i < KVM_MSI_HASHTAB_SIZE; i++) {
-            QTAILQ_INIT(&s->msi_hashtab[i]);
-        }
-    }
-
     kvm_arch_init_irq_routing(s);
 }
 
@@ -1985,41 +1978,10 @@ void kvm_irqchip_change_notify(void)
     notifier_list_notify(&kvm_irqchip_change_notifiers, NULL);
 }
 
-static unsigned int kvm_hash_msi(uint32_t data)
-{
-    /* This is optimized for IA32 MSI layout. However, no other arch shall
-     * repeat the mistake of not providing a direct MSI injection API. */
-    return data & 0xff;
-}
-
-static void kvm_flush_dynamic_msi_routes(KVMState *s)
-{
-    KVMMSIRoute *route, *next;
-    unsigned int hash;
-
-    for (hash = 0; hash < KVM_MSI_HASHTAB_SIZE; hash++) {
-        QTAILQ_FOREACH_SAFE(route, &s->msi_hashtab[hash], entry, next) {
-            kvm_irqchip_release_virq(s, route->kroute.gsi);
-            QTAILQ_REMOVE(&s->msi_hashtab[hash], route, entry);
-            g_free(route);
-        }
-    }
-}
-
 static int kvm_irqchip_get_virq(KVMState *s)
 {
     int next_virq;
 
-    /*
-     * PIC and IOAPIC share the first 16 GSI numbers, thus the available
-     * GSI numbers are more than the number of IRQ route. Allocating a GSI
-     * number can succeed even though a new route entry cannot be added.
-     * When this happens, flush dynamic MSI entries to free IRQ route entries.
-     */
-    if (!kvm_direct_msi_allowed && s->irq_routes->nr == s->gsi_count) {
-        kvm_flush_dynamic_msi_routes(s);
-    }
-
     /* Return the lowest unused GSI in the bitmap */
     next_virq = find_first_zero_bit(s->used_gsi_bitmap, s->gsi_count);
     if (next_virq >= s->gsi_count) {
@@ -2029,63 +1991,17 @@ static int kvm_irqchip_get_virq(KVMState *s)
     }
 }
 
-static KVMMSIRoute *kvm_lookup_msi_route(KVMState *s, MSIMessage msg)
-{
-    unsigned int hash = kvm_hash_msi(msg.data);
-    KVMMSIRoute *route;
-
-    QTAILQ_FOREACH(route, &s->msi_hashtab[hash], entry) {
-        if (route->kroute.u.msi.address_lo == (uint32_t)msg.address &&
-            route->kroute.u.msi.address_hi == (msg.address >> 32) &&
-            route->kroute.u.msi.data == le32_to_cpu(msg.data)) {
-            return route;
-        }
-    }
-    return NULL;
-}
-
 int kvm_irqchip_send_msi(KVMState *s, MSIMessage msg)
 {
     struct kvm_msi msi;
-    KVMMSIRoute *route;
 
-    if (kvm_direct_msi_allowed) {
-        msi.address_lo = (uint32_t)msg.address;
-        msi.address_hi = msg.address >> 32;
-        msi.data = le32_to_cpu(msg.data);
-        msi.flags = 0;
-        memset(msi.pad, 0, sizeof(msi.pad));
+    msi.address_lo = (uint32_t)msg.address;
+    msi.address_hi = msg.address >> 32;
+    msi.data = le32_to_cpu(msg.data);
+    msi.flags = 0;
+    memset(msi.pad, 0, sizeof(msi.pad));
 
-        return kvm_vm_ioctl(s, KVM_SIGNAL_MSI, &msi);
-    }
-
-    route = kvm_lookup_msi_route(s, msg);
-    if (!route) {
-        int virq;
-
-        virq = kvm_irqchip_get_virq(s);
-        if (virq < 0) {
-            return virq;
-        }
-
-        route = g_new0(KVMMSIRoute, 1);
-        route->kroute.gsi = virq;
-        route->kroute.type = KVM_IRQ_ROUTING_MSI;
-        route->kroute.flags = 0;
-        route->kroute.u.msi.address_lo = (uint32_t)msg.address;
-        route->kroute.u.msi.address_hi = msg.address >> 32;
-        route->kroute.u.msi.data = le32_to_cpu(msg.data);
-
-        kvm_add_routing_entry(s, &route->kroute);
-        kvm_irqchip_commit_routes(s);
-
-        QTAILQ_INSERT_TAIL(&s->msi_hashtab[kvm_hash_msi(msg.data)], route,
-                           entry);
-    }
-
-    assert(route->kroute.type == KVM_IRQ_ROUTING_MSI);
-
-    return kvm_set_irq(s, route->kroute.gsi, 1);
+    return kvm_vm_ioctl(s, KVM_SIGNAL_MSI, &msi);
 }
 
 int kvm_irqchip_add_msi_route(KVMRouteChange *c, int vector, PCIDevice *dev)
@@ -2660,10 +2576,6 @@ static int kvm_init(MachineState *ms)
 
     s->max_nested_state_len = kvm_check_extension(s, KVM_CAP_NESTED_STATE);
 
-#ifdef KVM_CAP_IRQ_ROUTING
-    kvm_direct_msi_allowed = (kvm_check_extension(s, KVM_CAP_SIGNAL_MSI) > 0);
-#endif
-
     s->intx_set_mask = kvm_check_extension(s, KVM_CAP_PCI_2_3);
 
     s->irq_set_ioctl = KVM_IRQ_LINE;
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index a323252f8e2..bce005adad8 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -27,7 +27,6 @@ bool kvm_allowed;
 bool kvm_readonly_mem_allowed;
 bool kvm_ioeventfd_any_length_allowed;
 bool kvm_msi_use_devid;
-bool kvm_direct_msi_allowed;
 
 void kvm_flush_coalesced_mmio_buffer(void)
 {
diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_common.c
index abaf77057e1..fddd6d490c2 100644
--- a/hw/intc/arm_gicv3_its_common.c
+++ b/hw/intc/arm_gicv3_its_common.c
@@ -163,8 +163,7 @@ type_init(gicv3_its_common_register_types)
 const char *its_class_name(void)
 {
     if (kvm_irqchip_in_kernel()) {
-        /* KVM implementation requires this capability */
-        return kvm_direct_msi_enabled() ? "arm-its-kvm" : NULL;
+        return "arm-its-kvm";
     } else {
         /* Software emulation based model */
         return "arm-gicv3-its";
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 97a8a4f201c..93dccf5dd92 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -43,7 +43,6 @@ extern bool kvm_msi_via_irqfd_allowed;
 extern bool kvm_gsi_routing_allowed;
 extern bool kvm_gsi_direct_mapping;
 extern bool kvm_readonly_mem_allowed;
-extern bool kvm_direct_msi_allowed;
 extern bool kvm_ioeventfd_any_length_allowed;
 extern bool kvm_msi_use_devid;
 
@@ -147,13 +146,6 @@ extern bool kvm_msi_use_devid;
  */
 #define kvm_readonly_mem_enabled() (kvm_readonly_mem_allowed)
 
-/**
- * kvm_direct_msi_enabled:
- *
- * Returns: true if KVM allows direct MSI injection.
- */
-#define kvm_direct_msi_enabled() (kvm_direct_msi_allowed)
-
 /**
  * kvm_ioeventfd_any_length_enabled:
  * Returns: true if KVM allows any length io eventfd.
@@ -181,7 +173,6 @@ extern bool kvm_msi_use_devid;
 #define kvm_gsi_routing_allowed() (false)
 #define kvm_gsi_direct_mapping() (false)
 #define kvm_readonly_mem_enabled() (false)
-#define kvm_direct_msi_enabled() (false)
 #define kvm_ioeventfd_any_length_enabled() (false)
 #define kvm_msi_devid_required() (false)
 
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 075939a3c4f..a7dacd12d6c 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -103,7 +103,6 @@ struct KVMState
     int nr_allocated_irq_routes;
     unsigned long *used_gsi_bitmap;
     unsigned int gsi_count;
-    QTAILQ_HEAD(, KVMMSIRoute) msi_hashtab[KVM_MSI_HASHTAB_SIZE];
 #endif
     KVMMemoryListener memory_listener;
     QLIST_HEAD(, KVMParkedVcpu) kvm_parked_vcpus;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e7c054cc160..fb6655254fc 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -91,6 +91,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(SET_TSS_ADDR),
     KVM_CAP_INFO(EXT_CPUID),
     KVM_CAP_INFO(MP_STATE),
+    KVM_CAP_INFO(SIGNAL_MSI),
     KVM_CAP_LAST_INFO
 };
 
-- 
2.41.0


From a788260b2000f1fe826885c06f2a34df1c5b335c Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Oct 2023 13:34:50 +0200
Subject: [PULL 11/24] kvm: require KVM_IRQFD for kernel irqchip
Content-Type: text/plain; charset=UTF-8

KVM_IRQFD was introduced in Linux 2.6.32, and since then it has always been
available on architectures that support an in-kernel interrupt controller.
We can require it unconditionally.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c         | 13 +++++--------
 accel/stubs/kvm-stub.c      |  1 -
 hw/intc/arm_gicv3_its_kvm.c |  2 +-
 include/sysemu/kvm.h        |  6 +++---
 target/riscv/kvm/kvm-cpu.c  |  2 +-
 5 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 0c7b0569da4..be50d47f7b4 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -91,7 +91,6 @@ bool kvm_split_irqchip;
 bool kvm_async_interrupts_allowed;
 bool kvm_halt_in_kernel_allowed;
 bool kvm_eventfds_allowed;
-bool kvm_irqfds_allowed;
 bool kvm_resamplefds_allowed;
 bool kvm_msi_via_irqfd_allowed;
 bool kvm_gsi_routing_allowed;
@@ -2128,10 +2127,6 @@ static int kvm_irqchip_assign_irqfd(KVMState *s, EventNotifier *event,
         }
     }
 
-    if (!kvm_irqfds_enabled()) {
-        return -ENOSYS;
-    }
-
     return kvm_vm_ioctl(s, KVM_IRQFD, &irqfd);
 }
 
@@ -2292,6 +2287,11 @@ static void kvm_irqchip_create(KVMState *s)
         return;
     }
 
+    if (kvm_check_extension(s, KVM_CAP_IRQFD) <= 0) {
+        fprintf(stderr, "kvm: irqfd not implemented\n");
+        exit(1);
+    }
+
     /* First probe and see if there's a arch-specific hook to create the
      * in-kernel irqchip for us */
     ret = kvm_arch_irqchip_create(s);
@@ -2589,9 +2589,6 @@ static int kvm_init(MachineState *ms)
     kvm_eventfds_allowed =
         (kvm_check_extension(s, KVM_CAP_IOEVENTFD) > 0);
 
-    kvm_irqfds_allowed =
-        (kvm_check_extension(s, KVM_CAP_IRQFD) > 0);
-
     kvm_resamplefds_allowed =
         (kvm_check_extension(s, KVM_CAP_IRQFD_RESAMPLE) > 0);
 
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index bce005adad8..19d58f2778f 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -18,7 +18,6 @@ KVMState *kvm_state;
 bool kvm_kernel_irqchip;
 bool kvm_async_interrupts_allowed;
 bool kvm_eventfds_allowed;
-bool kvm_irqfds_allowed;
 bool kvm_resamplefds_allowed;
 bool kvm_msi_via_irqfd_allowed;
 bool kvm_gsi_routing_allowed;
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 61c1cc7bdb8..f7df602cfff 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -123,7 +123,7 @@ static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
 
     kvm_msi_use_devid = true;
     kvm_gsi_direct_mapping = false;
-    kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
+    kvm_msi_via_irqfd_allowed = true;
 }
 
 /**
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 93dccf5dd92..575dee53b39 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -37,7 +37,6 @@ extern bool kvm_split_irqchip;
 extern bool kvm_async_interrupts_allowed;
 extern bool kvm_halt_in_kernel_allowed;
 extern bool kvm_eventfds_allowed;
-extern bool kvm_irqfds_allowed;
 extern bool kvm_resamplefds_allowed;
 extern bool kvm_msi_via_irqfd_allowed;
 extern bool kvm_gsi_routing_allowed;
@@ -102,8 +101,10 @@ extern bool kvm_msi_use_devid;
  * Returns: true if we can use irqfds to inject interrupts into
  * a KVM CPU (ie the kernel supports irqfds and we are running
  * with a configuration where it is meaningful to use them).
+ *
+ * Always available if running with in-kernel irqchip.
  */
-#define kvm_irqfds_enabled() (kvm_irqfds_allowed)
+#define kvm_irqfds_enabled() kvm_irqchip_in_kernel()
 
 /**
  * kvm_resamplefds_enabled:
@@ -167,7 +168,6 @@ extern bool kvm_msi_use_devid;
 #define kvm_async_interrupts_enabled() (false)
 #define kvm_halt_in_kernel() (false)
 #define kvm_eventfds_enabled() (false)
-#define kvm_irqfds_enabled() (false)
 #define kvm_resamplefds_enabled() (false)
 #define kvm_msi_via_irqfd_enabled() (false)
 #define kvm_gsi_routing_allowed() (false)
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 090d6176275..26e68c7ab45 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1420,7 +1420,7 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
         exit(1);
     }
 
-    kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
+    kvm_msi_via_irqfd_allowed = true;
 }
 
 static void kvm_cpu_instance_init(CPUState *cs)
-- 
2.41.0


From f8c0687fe364355ee35896e97fec89b61220340a Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 21 Oct 2023 17:09:46 +0200
Subject: [PULL 12/24] kvm: require KVM_IRQFD for kernel irqchip
Content-Type: text/plain; charset=UTF-8

KVM_IRQFD was introduced in Linux 2.6.32, and since then it has always been
available on architectures that support an in-kernel interrupt controller.
We can require it unconditionally.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 575dee53b39..16d58d2598a 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -167,6 +167,7 @@ extern bool kvm_msi_use_devid;
 #define kvm_irqchip_is_split() (false)
 #define kvm_async_interrupts_enabled() (false)
 #define kvm_halt_in_kernel() (false)
+#define kvm_irqfds_enabled() (false)
 #define kvm_eventfds_enabled() (false)
 #define kvm_resamplefds_enabled() (false)
 #define kvm_msi_via_irqfd_enabled() (false)
-- 
2.41.0


From d19fe67ba86f60cf7b7de9306475fe90f5ac648f Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2023 12:11:34 +0200
Subject: [PULL 13/24] kvm: drop reference to KVM_CAP_PCI_2_3
Content-Type: text/plain; charset=UTF-8

This is a remnant of pre-VFIO device assignment; it is not defined
anymore by Linux and not used by QEMU.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c      | 7 -------
 include/sysemu/kvm.h     | 1 -
 include/sysemu/kvm_int.h | 1 -
 3 files changed, 9 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index be50d47f7b4..50717a0d634 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2576,8 +2576,6 @@ static int kvm_init(MachineState *ms)
 
     s->max_nested_state_len = kvm_check_extension(s, KVM_CAP_NESTED_STATE);
 
-    s->intx_set_mask = kvm_check_extension(s, KVM_CAP_PCI_2_3);
-
     s->irq_set_ioctl = KVM_IRQ_LINE;
     if (kvm_check_extension(s, KVM_CAP_IRQ_INJECT_STATUS)) {
         s->irq_set_ioctl = KVM_IRQ_LINE_STATUS;
@@ -3237,11 +3235,6 @@ int kvm_has_gsi_routing(void)
 #endif
 }
 
-int kvm_has_intx_set_mask(void)
-{
-    return kvm_state->intx_set_mask;
-}
-
 bool kvm_arm_supports_user_irq(void)
 {
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_USER_IRQ);
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 16d58d2598a..bcc9bd96a92 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -216,7 +216,6 @@ int kvm_has_debugregs(void);
 int kvm_max_nested_state_length(void);
 int kvm_has_many_ioeventfds(void);
 int kvm_has_gsi_routing(void);
-int kvm_has_intx_set_mask(void);
 
 /**
  * kvm_arm_supports_user_irq
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index a7dacd12d6c..817238b9582 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -85,7 +85,6 @@ struct KVMState
 #endif
     int max_nested_state_len;
     int many_ioeventfds;
-    int intx_set_mask;
     int kvm_shadow_mem;
     bool kernel_irqchip_allowed;
     bool kernel_irqchip_required;
-- 
2.41.0


From 5d9ec1f4c78ed25720b4fd01ddcddb00db50fa6c Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Oct 2023 14:08:22 +0200
Subject: [PULL 14/24] kvm: assume that many ioeventfds can be created
Content-Type: text/plain; charset=UTF-8

NR_IOBUS_DEVS was increased to 200 in Linux 2.6.34.  By Linux 3.5 it had
increased to 1000 and later ioeventfds were changed to not count against
the limit.  But the earlier limit of 200 would already be enough for
kvm_check_many_ioeventfds() to be true, so remove the check.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c      | 47 ----------------------------------------
 accel/stubs/kvm-stub.c   |  5 -----
 hw/virtio/virtio-pci.c   |  4 ----
 include/sysemu/kvm.h     |  1 -
 include/sysemu/kvm_int.h |  1 -
 5 files changed, 58 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 50717a0d634..05be687be1b 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1253,43 +1253,6 @@ static int kvm_set_ioeventfd_pio(int fd, uint16_t addr, uint16_t val,
 }
 
 
-static int kvm_check_many_ioeventfds(void)
-{
-    /* Userspace can use ioeventfd for io notification.  This requires a host
-     * that supports eventfd(2) and an I/O thread; since eventfd does not
-     * support SIGIO it cannot interrupt the vcpu.
-     *
-     * Older kernels have a 6 device limit on the KVM io bus.  Find out so we
-     * can avoid creating too many ioeventfds.
-     */
-#if defined(CONFIG_EVENTFD)
-    int ioeventfds[7];
-    int i, ret = 0;
-    for (i = 0; i < ARRAY_SIZE(ioeventfds); i++) {
-        ioeventfds[i] = eventfd(0, EFD_CLOEXEC);
-        if (ioeventfds[i] < 0) {
-            break;
-        }
-        ret = kvm_set_ioeventfd_pio(ioeventfds[i], 0, i, true, 2, true);
-        if (ret < 0) {
-            close(ioeventfds[i]);
-            break;
-        }
-    }
-
-    /* Decide whether many devices are supported or not */
-    ret = i == ARRAY_SIZE(ioeventfds);
-
-    while (i-- > 0) {
-        kvm_set_ioeventfd_pio(ioeventfds[i], 0, i, false, 2, true);
-        close(ioeventfds[i]);
-    }
-    return ret;
-#else
-    return 0;
-#endif
-}
-
 static const KVMCapabilityInfo *
 kvm_check_extension_list(KVMState *s, const KVMCapabilityInfo *list)
 {
@@ -2648,8 +2611,6 @@ static int kvm_init(MachineState *ms)
     memory_listener_register(&kvm_coalesced_pio_listener,
                              &address_space_io);
 
-    s->many_ioeventfds = kvm_check_many_ioeventfds();
-
     s->sync_mmu = !!kvm_vm_check_extension(kvm_state, KVM_CAP_SYNC_MMU);
     if (!s->sync_mmu) {
         ret = ram_block_discard_disable(true);
@@ -3218,14 +3179,6 @@ int kvm_max_nested_state_length(void)
     return kvm_state->max_nested_state_len;
 }
 
-int kvm_has_many_ioeventfds(void)
-{
-    if (!kvm_enabled()) {
-        return 0;
-    }
-    return kvm_state->many_ioeventfds;
-}
-
 int kvm_has_gsi_routing(void)
 {
 #ifdef KVM_CAP_IRQ_ROUTING
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 19d58f2778f..b2d8885853f 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -40,11 +40,6 @@ bool kvm_has_sync_mmu(void)
     return false;
 }
 
-int kvm_has_many_ioeventfds(void)
-{
-    return 0;
-}
-
 int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr)
 {
     return 1;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index af1f4bc187c..5f614334ec4 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2114,10 +2114,6 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
     bool pcie_port = pci_bus_is_express(pci_get_bus(pci_dev)) &&
                      !pci_bus_is_root(pci_get_bus(pci_dev));
 
-    if (kvm_enabled() && !kvm_has_many_ioeventfds()) {
-        proxy->flags &= ~VIRTIO_PCI_FLAG_USE_IOEVENTFD;
-    }
-
     /* fd-based ioevents can't be synchronized in record/replay */
     if (replay_mode != REPLAY_MODE_NONE) {
         proxy->flags &= ~VIRTIO_PCI_FLAG_USE_IOEVENTFD;
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index bcc9bd96a92..8c5867ba8a4 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -214,7 +214,6 @@ int kvm_has_vcpu_events(void);
 int kvm_has_robust_singlestep(void);
 int kvm_has_debugregs(void);
 int kvm_max_nested_state_length(void);
-int kvm_has_many_ioeventfds(void);
 int kvm_has_gsi_routing(void);
 
 /**
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 817238b9582..840b905a2e9 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -84,7 +84,6 @@ struct KVMState
     QTAILQ_HEAD(, kvm_sw_breakpoint) kvm_sw_breakpoints;
 #endif
     int max_nested_state_len;
-    int many_ioeventfds;
     int kvm_shadow_mem;
     bool kernel_irqchip_allowed;
     bool kernel_irqchip_required;
-- 
2.41.0


From 126e7f780367b0263d9a112729736d6a0bd6d441 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Oct 2023 14:13:04 +0200
Subject: [PULL 15/24] kvm: require KVM_CAP_IOEVENTFD and
 KVM_CAP_IOEVENTFD_ANY_LENGTH
Content-Type: text/plain; charset=UTF-8

KVM_CAP_IOEVENTFD_ANY_LENGTH was added in Linux 4.4, released in 2016.
Assume that it is present.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c     | 22 ++++++----------------
 accel/stubs/kvm-stub.c  |  2 --
 hw/misc/pci-testdev.c   |  3 +--
 hw/s390x/virtio-ccw.c   |  4 ----
 hw/virtio/vhost-user.c  |  7 +------
 hw/virtio/virtio-mmio.c |  4 ----
 hw/virtio/virtio-pci.c  | 19 ++++---------------
 include/sysemu/kvm.h    | 19 -------------------
 system/memory.c         | 16 ++++++----------
 9 files changed, 18 insertions(+), 78 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 05be687be1b..120051da649 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -90,7 +90,6 @@ bool kvm_kernel_irqchip;
 bool kvm_split_irqchip;
 bool kvm_async_interrupts_allowed;
 bool kvm_halt_in_kernel_allowed;
-bool kvm_eventfds_allowed;
 bool kvm_resamplefds_allowed;
 bool kvm_msi_via_irqfd_allowed;
 bool kvm_gsi_routing_allowed;
@@ -98,7 +97,6 @@ bool kvm_gsi_direct_mapping;
 bool kvm_allowed;
 bool kvm_readonly_mem_allowed;
 bool kvm_vm_attributes_allowed;
-bool kvm_ioeventfd_any_length_allowed;
 bool kvm_msi_use_devid;
 bool kvm_has_guest_debug;
 static int kvm_sstep_flags;
@@ -110,6 +108,8 @@ static const KVMCapabilityInfo kvm_required_capabilites[] = {
     KVM_CAP_INFO(DESTROY_MEMORY_REGION_WORKS),
     KVM_CAP_INFO(JOIN_MEMORY_REGIONS_WORKS),
     KVM_CAP_INFO(INTERNAL_ERROR_DATA),
+    KVM_CAP_INFO(IOEVENTFD),
+    KVM_CAP_INFO(IOEVENTFD_ANY_LENGTH),
     KVM_CAP_LAST_INFO
 };
 
@@ -2547,18 +2547,12 @@ static int kvm_init(MachineState *ms)
     kvm_readonly_mem_allowed =
         (kvm_check_extension(s, KVM_CAP_READONLY_MEM) > 0);
 
-    kvm_eventfds_allowed =
-        (kvm_check_extension(s, KVM_CAP_IOEVENTFD) > 0);
-
     kvm_resamplefds_allowed =
         (kvm_check_extension(s, KVM_CAP_IRQFD_RESAMPLE) > 0);
 
     kvm_vm_attributes_allowed =
         (kvm_check_extension(s, KVM_CAP_VM_ATTRIBUTES) > 0);
 
-    kvm_ioeventfd_any_length_allowed =
-        (kvm_check_extension(s, KVM_CAP_IOEVENTFD_ANY_LENGTH) > 0);
-
 #ifdef KVM_CAP_SET_GUEST_DEBUG
     kvm_has_guest_debug =
         (kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG) > 0);
@@ -2595,19 +2589,15 @@ static int kvm_init(MachineState *ms)
         kvm_irqchip_create(s);
     }
 
-    if (kvm_eventfds_allowed) {
-        s->memory_listener.listener.eventfd_add = kvm_mem_ioeventfd_add;
-        s->memory_listener.listener.eventfd_del = kvm_mem_ioeventfd_del;
-    }
+    s->memory_listener.listener.eventfd_add = kvm_mem_ioeventfd_add;
+    s->memory_listener.listener.eventfd_del = kvm_mem_ioeventfd_del;
     s->memory_listener.listener.coalesced_io_add = kvm_coalesce_mmio_region;
     s->memory_listener.listener.coalesced_io_del = kvm_uncoalesce_mmio_region;
 
     kvm_memory_listener_register(s, &s->memory_listener,
                                  &address_space_memory, 0, "kvm-memory");
-    if (kvm_eventfds_allowed) {
-        memory_listener_register(&kvm_io_listener,
-                                 &address_space_io);
-    }
+    memory_listener_register(&kvm_io_listener,
+                             &address_space_io);
     memory_listener_register(&kvm_coalesced_pio_listener,
                              &address_space_io);
 
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index b2d8885853f..1b37d9a302c 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -17,14 +17,12 @@
 KVMState *kvm_state;
 bool kvm_kernel_irqchip;
 bool kvm_async_interrupts_allowed;
-bool kvm_eventfds_allowed;
 bool kvm_resamplefds_allowed;
 bool kvm_msi_via_irqfd_allowed;
 bool kvm_gsi_routing_allowed;
 bool kvm_gsi_direct_mapping;
 bool kvm_allowed;
 bool kvm_readonly_mem_allowed;
-bool kvm_ioeventfd_any_length_allowed;
 bool kvm_msi_use_devid;
 
 void kvm_flush_coalesced_mmio_buffer(void)
diff --git a/hw/misc/pci-testdev.c b/hw/misc/pci-testdev.c
index 49303134e4c..acedd0f82bc 100644
--- a/hw/misc/pci-testdev.c
+++ b/hw/misc/pci-testdev.c
@@ -245,7 +245,6 @@ static void pci_testdev_realize(PCIDevice *pci_dev, Error **errp)
     uint8_t *pci_conf;
     char *name;
     int r, i;
-    bool fastmmio = kvm_ioeventfd_any_length_enabled();
 
     pci_conf = pci_dev->config;
 
@@ -279,7 +278,7 @@ static void pci_testdev_realize(PCIDevice *pci_dev, Error **errp)
         g_free(name);
         test->hdr->offset = cpu_to_le32(IOTEST_SIZE(i) + i * IOTEST_ACCESS_WIDTH);
         test->match_data = strcmp(IOTEST_TEST(i), "wildcard-eventfd");
-        if (fastmmio && IOTEST_IS_MEM(i) && !test->match_data) {
+        if (IOTEST_IS_MEM(i) && !test->match_data) {
             test->size = 0;
         } else {
             test->size = IOTEST_ACCESS_WIDTH;
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 17c548b84ff..80453718a33 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -768,10 +768,6 @@ static void virtio_ccw_device_realize(VirtioCcwDevice *dev, Error **errp)
         sch->cssid, sch->ssid, sch->schid, sch->devno,
         ccw_dev->devno.valid ? "user-configured" : "auto-configured");
 
-    if (kvm_enabled() && !kvm_eventfds_enabled()) {
-        dev->flags &= ~VIRTIO_CCW_FLAG_USE_IOEVENTFD;
-    }
-
     /* fd-based ioevents can't be synchronized in record/replay */
     if (replay_mode != REPLAY_MODE_NONE) {
         dev->flags &= ~VIRTIO_CCW_FLAG_USE_IOEVENTFD;
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index b8a7b5542d9..7b42ae8aae8 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -264,11 +264,6 @@ struct scrub_regions {
     int fd_idx;
 };
 
-static bool ioeventfd_enabled(void)
-{
-    return !kvm_enabled() || kvm_eventfds_enabled();
-}
-
 static int vhost_user_read_header(struct vhost_dev *dev, VhostUserMsg *msg)
 {
     struct vhost_user *u = dev->opaque;
@@ -1318,7 +1313,7 @@ static int vhost_set_vring_file(struct vhost_dev *dev,
         .hdr.size = sizeof(msg.payload.u64),
     };
 
-    if (ioeventfd_enabled() && file->fd > 0) {
+    if (file->fd > 0) {
         fds[fd_num++] = file->fd;
     } else {
         msg.payload.u64 |= VHOST_USER_VRING_NOFD_MASK;
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index c2c6d854750..22f15e1e02f 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -761,10 +761,6 @@ static void virtio_mmio_realizefn(DeviceState *d, Error **errp)
     qbus_init(&proxy->bus, sizeof(proxy->bus), TYPE_VIRTIO_MMIO_BUS, d, NULL);
     sysbus_init_irq(sbd, &proxy->irq);
 
-    if (!kvm_eventfds_enabled()) {
-        proxy->flags &= ~VIRTIO_IOMMIO_FLAG_USE_IOEVENTFD;
-    }
-
     /* fd-based ioevents can't be synchronized in record/replay */
     if (replay_mode != REPLAY_MODE_NONE) {
         proxy->flags &= ~VIRTIO_IOMMIO_FLAG_USE_IOEVENTFD;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 5f614334ec4..205dbf24fb1 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -332,7 +332,6 @@ static int virtio_pci_ioeventfd_assign(DeviceState *d, EventNotifier *notifier,
     VirtQueue *vq = virtio_get_queue(vdev, n);
     bool legacy = virtio_pci_legacy(proxy);
     bool modern = virtio_pci_modern(proxy);
-    bool fast_mmio = kvm_ioeventfd_any_length_enabled();
     bool modern_pio = proxy->flags & VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY;
     MemoryRegion *modern_mr = &proxy->notify.mr;
     MemoryRegion *modern_notify_mr = &proxy->notify_pio.mr;
@@ -343,13 +342,8 @@ static int virtio_pci_ioeventfd_assign(DeviceState *d, EventNotifier *notifier,
 
     if (assign) {
         if (modern) {
-            if (fast_mmio) {
-                memory_region_add_eventfd(modern_mr, modern_addr, 0,
-                                          false, n, notifier);
-            } else {
-                memory_region_add_eventfd(modern_mr, modern_addr, 2,
-                                          false, n, notifier);
-            }
+            memory_region_add_eventfd(modern_mr, modern_addr, 0,
+                                      false, n, notifier);
             if (modern_pio) {
                 memory_region_add_eventfd(modern_notify_mr, 0, 2,
                                               true, n, notifier);
@@ -361,13 +355,8 @@ static int virtio_pci_ioeventfd_assign(DeviceState *d, EventNotifier *notifier,
         }
     } else {
         if (modern) {
-            if (fast_mmio) {
-                memory_region_del_eventfd(modern_mr, modern_addr, 0,
-                                          false, n, notifier);
-            } else {
-                memory_region_del_eventfd(modern_mr, modern_addr, 2,
-                                          false, n, notifier);
-            }
+            memory_region_del_eventfd(modern_mr, modern_addr, 0,
+                                      false, n, notifier);
             if (modern_pio) {
                 memory_region_del_eventfd(modern_notify_mr, 0, 2,
                                           true, n, notifier);
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 8c5867ba8a4..31c03cc1932 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -36,13 +36,11 @@ extern bool kvm_kernel_irqchip;
 extern bool kvm_split_irqchip;
 extern bool kvm_async_interrupts_allowed;
 extern bool kvm_halt_in_kernel_allowed;
-extern bool kvm_eventfds_allowed;
 extern bool kvm_resamplefds_allowed;
 extern bool kvm_msi_via_irqfd_allowed;
 extern bool kvm_gsi_routing_allowed;
 extern bool kvm_gsi_direct_mapping;
 extern bool kvm_readonly_mem_allowed;
-extern bool kvm_ioeventfd_any_length_allowed;
 extern bool kvm_msi_use_devid;
 
 #define kvm_enabled()           (kvm_allowed)
@@ -86,15 +84,6 @@ extern bool kvm_msi_use_devid;
  */
 #define kvm_halt_in_kernel() (kvm_halt_in_kernel_allowed)
 
-/**
- * kvm_eventfds_enabled:
- *
- * Returns: true if we can use eventfds to receive notifications
- * from a KVM CPU (ie the kernel supports eventds and we are running
- * with a configuration where it is meaningful to use them).
- */
-#define kvm_eventfds_enabled() (kvm_eventfds_allowed)
-
 /**
  * kvm_irqfds_enabled:
  *
@@ -147,12 +136,6 @@ extern bool kvm_msi_use_devid;
  */
 #define kvm_readonly_mem_enabled() (kvm_readonly_mem_allowed)
 
-/**
- * kvm_ioeventfd_any_length_enabled:
- * Returns: true if KVM allows any length io eventfd.
- */
-#define kvm_ioeventfd_any_length_enabled() (kvm_ioeventfd_any_length_allowed)
-
 /**
  * kvm_msi_devid_required:
  * Returns: true if KVM requires a device id to be provided while
@@ -168,13 +151,11 @@ extern bool kvm_msi_use_devid;
 #define kvm_async_interrupts_enabled() (false)
 #define kvm_halt_in_kernel() (false)
 #define kvm_irqfds_enabled() (false)
-#define kvm_eventfds_enabled() (false)
 #define kvm_resamplefds_enabled() (false)
 #define kvm_msi_via_irqfd_enabled() (false)
 #define kvm_gsi_routing_allowed() (false)
 #define kvm_gsi_direct_mapping() (false)
 #define kvm_readonly_mem_enabled() (false)
-#define kvm_ioeventfd_any_length_enabled() (false)
 #define kvm_msi_devid_required() (false)
 
 #endif  /* CONFIG_KVM_IS_POSSIBLE */
diff --git a/system/memory.c b/system/memory.c
index a800fbc9e59..4928f2525de 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1535,7 +1535,12 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
 
     adjust_endianness(mr, &data, op);
 
-    if ((!kvm_eventfds_enabled()) &&
+    /*
+     * FIXME: it's not clear why under KVM the write would be processed
+     * directly, instead of going through eventfd.  This probably should
+     * test "tcg_enabled() || qtest_enabled()", or should just go away.
+     */
+    if (!kvm_enabled() &&
         memory_region_dispatch_write_eventfds(mr, addr, data, size, attrs)) {
         return MEMTX_OK;
     }
@@ -2550,8 +2555,6 @@ void memory_region_clear_flush_coalesced(MemoryRegion *mr)
     }
 }
 
-static bool userspace_eventfd_warning;
-
 void memory_region_add_eventfd(MemoryRegion *mr,
                                hwaddr addr,
                                unsigned size,
@@ -2568,13 +2571,6 @@ void memory_region_add_eventfd(MemoryRegion *mr,
     };
     unsigned i;
 
-    if (kvm_enabled() && (!(kvm_eventfds_enabled() ||
-                            userspace_eventfd_warning))) {
-        userspace_eventfd_warning = true;
-        error_report("Using eventfd without MMIO binding in KVM. "
-                     "Suboptimal performance expected");
-    }
-
     if (size) {
         adjust_endianness(mr, &mrfd.data, size_memop(size) | MO_TE);
     }
-- 
2.41.0


From 2cb81af0b1add4fa4f3582a913e0f8aaf1e77eb8 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Oct 2023 13:47:21 +0200
Subject: [PULL 16/24] kvm: unify listeners for PIO address space
Content-Type: text/plain; charset=UTF-8

Since we now assume that ioeventfds are present, kvm_io_listener is always
registered.  Merge it with kvm_coalesced_pio_listener in a single
listener.  Since PIO space does not have KVM memslots attached to it,
the priority is irrelevant.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 120051da649..b59a48da924 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1105,13 +1105,6 @@ static void kvm_coalesce_pio_del(MemoryListener *listener,
      }
 }
 
-static MemoryListener kvm_coalesced_pio_listener = {
-    .name = "kvm-coalesced-pio",
-    .coalesced_io_add = kvm_coalesce_pio_add,
-    .coalesced_io_del = kvm_coalesce_pio_del,
-    .priority = MEMORY_LISTENER_PRIORITY_MIN,
-};
-
 int kvm_check_extension(KVMState *s, unsigned int extension)
 {
     int ret;
@@ -1768,6 +1761,8 @@ void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
 
 static MemoryListener kvm_io_listener = {
     .name = "kvm-io",
+    .coalesced_io_add = kvm_coalesce_pio_add,
+    .coalesced_io_del = kvm_coalesce_pio_del,
     .eventfd_add = kvm_io_ioeventfd_add,
     .eventfd_del = kvm_io_ioeventfd_del,
     .priority = MEMORY_LISTENER_PRIORITY_DEV_BACKEND,
@@ -2598,8 +2593,6 @@ static int kvm_init(MachineState *ms)
                                  &address_space_memory, 0, "kvm-memory");
     memory_listener_register(&kvm_io_listener,
                              &address_space_io);
-    memory_listener_register(&kvm_coalesced_pio_listener,
-                             &address_space_io);
 
     s->sync_mmu = !!kvm_vm_check_extension(kvm_state, KVM_CAP_SYNC_MMU);
     if (!s->sync_mmu) {
-- 
2.41.0


From 4b2991666c52de1c708226cd0c022869e802aa26 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Oct 2023 14:15:29 +0200
Subject: [PULL 17/24] kvm: i386: move KVM_CAP_IRQ_ROUTING detection to
 kvm_arch_required_capabilities
Content-Type: text/plain; charset=UTF-8

Simple code cleanup.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index fb6655254fc..94b2516c29f 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -92,6 +92,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(EXT_CPUID),
     KVM_CAP_INFO(MP_STATE),
     KVM_CAP_INFO(SIGNAL_MSI),
+    KVM_CAP_INFO(IRQ_ROUTING),
     KVM_CAP_LAST_INFO
 };
 
@@ -2590,11 +2591,6 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         return ret;
     }
 
-    if (!kvm_check_extension(s, KVM_CAP_IRQ_ROUTING)) {
-        error_report("kvm: KVM_CAP_IRQ_ROUTING not supported by KVM");
-        return -ENOTSUP;
-    }
-
     has_xsave = kvm_check_extension(s, KVM_CAP_XSAVE);
     has_xcrs = kvm_check_extension(s, KVM_CAP_XCRS);
     has_pit_state2 = kvm_check_extension(s, KVM_CAP_PIT_STATE2);
-- 
2.41.0


From f57a4dd31154e9c054fe75d4ab27829033720a8d Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Oct 2023 13:15:11 +0200
Subject: [PULL 18/24] kvm: i386: require KVM_CAP_DEBUGREGS
Content-Type: text/plain; charset=UTF-8

This was introduced in KVM in Linux 2.6.35, we can require it unconditionally.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c      | 9 ---------
 include/sysemu/kvm.h     | 1 -
 include/sysemu/kvm_int.h | 1 -
 target/i386/kvm/kvm.c    | 9 +--------
 4 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b59a48da924..aeda902b3e9 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2528,10 +2528,6 @@ static int kvm_init(MachineState *ms)
     s->robust_singlestep =
         kvm_check_extension(s, KVM_CAP_X86_ROBUST_SINGLESTEP);
 
-#ifdef KVM_CAP_DEBUGREGS
-    s->debugregs = kvm_check_extension(s, KVM_CAP_DEBUGREGS);
-#endif
-
     s->max_nested_state_len = kvm_check_extension(s, KVM_CAP_NESTED_STATE);
 
     s->irq_set_ioctl = KVM_IRQ_LINE;
@@ -3152,11 +3148,6 @@ int kvm_has_robust_singlestep(void)
     return kvm_state->robust_singlestep;
 }
 
-int kvm_has_debugregs(void)
-{
-    return kvm_state->debugregs;
-}
-
 int kvm_max_nested_state_length(void)
 {
     return kvm_state->max_nested_state_len;
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 31c03cc1932..02c031d1f29 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -193,7 +193,6 @@ unsigned int kvm_get_free_memslots(void);
 bool kvm_has_sync_mmu(void);
 int kvm_has_vcpu_events(void);
 int kvm_has_robust_singlestep(void);
-int kvm_has_debugregs(void);
 int kvm_max_nested_state_length(void);
 int kvm_has_gsi_routing(void);
 
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 840b905a2e9..151ecc84233 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -79,7 +79,6 @@ struct KVMState
     bool coalesced_flush_in_progress;
     int vcpu_events;
     int robust_singlestep;
-    int debugregs;
 #ifdef KVM_CAP_SET_GUEST_DEBUG
     QTAILQ_HEAD(, kvm_sw_breakpoint) kvm_sw_breakpoints;
 #endif
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 94b2516c29f..b8fb74d7f17 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -93,6 +93,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(MP_STATE),
     KVM_CAP_INFO(SIGNAL_MSI),
     KVM_CAP_INFO(IRQ_ROUTING),
+    KVM_CAP_INFO(DEBUGREGS),
     KVM_CAP_LAST_INFO
 };
 
@@ -4601,10 +4602,6 @@ static int kvm_put_debugregs(X86CPU *cpu)
     struct kvm_debugregs dbgregs;
     int i;
 
-    if (!kvm_has_debugregs()) {
-        return 0;
-    }
-
     memset(&dbgregs, 0, sizeof(dbgregs));
     for (i = 0; i < 4; i++) {
         dbgregs.db[i] = env->dr[i];
@@ -4622,10 +4619,6 @@ static int kvm_get_debugregs(X86CPU *cpu)
     struct kvm_debugregs dbgregs;
     int i, ret;
 
-    if (!kvm_has_debugregs()) {
-        return 0;
-    }
-
     ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_DEBUGREGS, &dbgregs);
     if (ret < 0) {
         return ret;
-- 
2.41.0


From 8bba0a3b768de8d65e91afaff2fa6817e465be21 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Oct 2023 13:18:15 +0200
Subject: [PULL 19/24] kvm: i386: require KVM_CAP_XSAVE
Content-Type: text/plain; charset=UTF-8

This was introduced in KVM in Linux 2.6.36, and could already be used at
the time to save/restore FPU data even on older processor.  We can require
it unconditionally and stop using KVM_GET/SET_FPU.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 70 ++-----------------------------------------
 1 file changed, 2 insertions(+), 68 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index b8fb74d7f17..513a90f6307 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -94,6 +94,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(SIGNAL_MSI),
     KVM_CAP_INFO(IRQ_ROUTING),
     KVM_CAP_INFO(DEBUGREGS),
+    KVM_CAP_INFO(XSAVE),
     KVM_CAP_LAST_INFO
 };
 
@@ -137,7 +138,6 @@ static uint32_t has_architectural_pmu_version;
 static uint32_t num_architectural_pmu_gp_counters;
 static uint32_t num_architectural_pmu_fixed_counters;
 
-static int has_xsave;
 static int has_xsave2;
 static int has_xcrs;
 static int has_pit_state2;
@@ -1714,10 +1714,8 @@ static void kvm_init_xsave(CPUX86State *env)
 {
     if (has_xsave2) {
         env->xsave_buf_len = QEMU_ALIGN_UP(has_xsave2, 4096);
-    } else if (has_xsave) {
-        env->xsave_buf_len = sizeof(struct kvm_xsave);
     } else {
-        return;
+        env->xsave_buf_len = sizeof(struct kvm_xsave);
     }
 
     env->xsave_buf = qemu_memalign(4096, env->xsave_buf_len);
@@ -2592,7 +2590,6 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         return ret;
     }
 
-    has_xsave = kvm_check_extension(s, KVM_CAP_XSAVE);
     has_xcrs = kvm_check_extension(s, KVM_CAP_XCRS);
     has_pit_state2 = kvm_check_extension(s, KVM_CAP_PIT_STATE2);
     has_sregs2 = kvm_check_extension(s, KVM_CAP_SREGS2) > 0;
@@ -2877,40 +2874,11 @@ static int kvm_getput_regs(X86CPU *cpu, int set)
     return ret;
 }
 
-static int kvm_put_fpu(X86CPU *cpu)
-{
-    CPUX86State *env = &cpu->env;
-    struct kvm_fpu fpu;
-    int i;
-
-    memset(&fpu, 0, sizeof fpu);
-    fpu.fsw = env->fpus & ~(7 << 11);
-    fpu.fsw |= (env->fpstt & 7) << 11;
-    fpu.fcw = env->fpuc;
-    fpu.last_opcode = env->fpop;
-    fpu.last_ip = env->fpip;
-    fpu.last_dp = env->fpdp;
-    for (i = 0; i < 8; ++i) {
-        fpu.ftwx |= (!env->fptags[i]) << i;
-    }
-    memcpy(fpu.fpr, env->fpregs, sizeof env->fpregs);
-    for (i = 0; i < CPU_NB_REGS; i++) {
-        stq_p(&fpu.xmm[i][0], env->xmm_regs[i].ZMM_Q(0));
-        stq_p(&fpu.xmm[i][8], env->xmm_regs[i].ZMM_Q(1));
-    }
-    fpu.mxcsr = env->mxcsr;
-
-    return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_FPU, &fpu);
-}
-
 static int kvm_put_xsave(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
     void *xsave = env->xsave_buf;
 
-    if (!has_xsave) {
-        return kvm_put_fpu(cpu);
-    }
     x86_cpu_xsave_all_areas(cpu, xsave, env->xsave_buf_len);
 
     return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_XSAVE, xsave);
@@ -3655,46 +3623,12 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
 }
 
 
-static int kvm_get_fpu(X86CPU *cpu)
-{
-    CPUX86State *env = &cpu->env;
-    struct kvm_fpu fpu;
-    int i, ret;
-
-    ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_FPU, &fpu);
-    if (ret < 0) {
-        return ret;
-    }
-
-    env->fpstt = (fpu.fsw >> 11) & 7;
-    env->fpus = fpu.fsw;
-    env->fpuc = fpu.fcw;
-    env->fpop = fpu.last_opcode;
-    env->fpip = fpu.last_ip;
-    env->fpdp = fpu.last_dp;
-    for (i = 0; i < 8; ++i) {
-        env->fptags[i] = !((fpu.ftwx >> i) & 1);
-    }
-    memcpy(env->fpregs, fpu.fpr, sizeof env->fpregs);
-    for (i = 0; i < CPU_NB_REGS; i++) {
-        env->xmm_regs[i].ZMM_Q(0) = ldq_p(&fpu.xmm[i][0]);
-        env->xmm_regs[i].ZMM_Q(1) = ldq_p(&fpu.xmm[i][8]);
-    }
-    env->mxcsr = fpu.mxcsr;
-
-    return 0;
-}
-
 static int kvm_get_xsave(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
     void *xsave = env->xsave_buf;
     int type, ret;
 
-    if (!has_xsave) {
-        return kvm_get_fpu(cpu);
-    }
-
     type = has_xsave2 ? KVM_GET_XSAVE2 : KVM_GET_XSAVE;
     ret = kvm_vcpu_ioctl(CPU(cpu), type, xsave);
     if (ret < 0) {
-- 
2.41.0


From 1a44a79ddf6474587719eff269fd7bacf98817c8 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Oct 2023 14:16:58 +0200
Subject: [PULL 20/24] kvm: i386: require KVM_CAP_SET_VCPU_EVENTS and
 KVM_CAP_X86_ROBUST_SINGLESTEP
Content-Type: text/plain; charset=UTF-8

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c      |  9 ----
 include/sysemu/kvm.h     |  1 -
 include/sysemu/kvm_int.h |  1 -
 target/i386/kvm/kvm.c    | 92 +---------------------------------------
 4 files changed, 2 insertions(+), 101 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index aeda902b3e9..e39a810a4e9 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2524,10 +2524,6 @@ static int kvm_init(MachineState *ms)
 #ifdef KVM_CAP_VCPU_EVENTS
     s->vcpu_events = kvm_check_extension(s, KVM_CAP_VCPU_EVENTS);
 #endif
-
-    s->robust_singlestep =
-        kvm_check_extension(s, KVM_CAP_X86_ROBUST_SINGLESTEP);
-
     s->max_nested_state_len = kvm_check_extension(s, KVM_CAP_NESTED_STATE);
 
     s->irq_set_ioctl = KVM_IRQ_LINE;
@@ -3143,11 +3139,6 @@ int kvm_has_vcpu_events(void)
     return kvm_state->vcpu_events;
 }
 
-int kvm_has_robust_singlestep(void)
-{
-    return kvm_state->robust_singlestep;
-}
-
 int kvm_max_nested_state_length(void)
 {
     return kvm_state->max_nested_state_len;
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 02c031d1f29..80b69d88f6e 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -192,7 +192,6 @@ unsigned int kvm_get_max_memslots(void);
 unsigned int kvm_get_free_memslots(void);
 bool kvm_has_sync_mmu(void);
 int kvm_has_vcpu_events(void);
-int kvm_has_robust_singlestep(void);
 int kvm_max_nested_state_length(void);
 int kvm_has_gsi_routing(void);
 
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 151ecc84233..fd846394be1 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -78,7 +78,6 @@ struct KVMState
     struct kvm_coalesced_mmio_ring *coalesced_mmio_ring;
     bool coalesced_flush_in_progress;
     int vcpu_events;
-    int robust_singlestep;
 #ifdef KVM_CAP_SET_GUEST_DEBUG
     QTAILQ_HEAD(, kvm_sw_breakpoint) kvm_sw_breakpoints;
 #endif
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 513a90f6307..4a244174a0f 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -95,6 +95,8 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(IRQ_ROUTING),
     KVM_CAP_INFO(DEBUGREGS),
     KVM_CAP_INFO(XSAVE),
+    KVM_CAP_INFO(VCPU_EVENTS),
+    KVM_CAP_INFO(X86_ROBUST_SINGLESTEP),
     KVM_CAP_LAST_INFO
 };
 
@@ -690,15 +692,6 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
     emit_hypervisor_memory_failure(MEMORY_FAILURE_ACTION_IGNORE, false);
 }
 
-static void kvm_reset_exception(CPUX86State *env)
-{
-    env->exception_nr = -1;
-    env->exception_pending = 0;
-    env->exception_injected = 0;
-    env->exception_has_payload = false;
-    env->exception_payload = 0;
-}
-
 static void kvm_queue_exception(CPUX86State *env,
                                 int32_t exception_nr,
                                 uint8_t exception_has_payload,
@@ -731,38 +724,6 @@ static void kvm_queue_exception(CPUX86State *env,
     }
 }
 
-static int kvm_inject_mce_oldstyle(X86CPU *cpu)
-{
-    CPUX86State *env = &cpu->env;
-
-    if (!kvm_has_vcpu_events() && env->exception_nr == EXCP12_MCHK) {
-        unsigned int bank, bank_num = env->mcg_cap & 0xff;
-        struct kvm_x86_mce mce;
-
-        kvm_reset_exception(env);
-
-        /*
-         * There must be at least one bank in use if an MCE is pending.
-         * Find it and use its values for the event injection.
-         */
-        for (bank = 0; bank < bank_num; bank++) {
-            if (env->mce_banks[bank * 4 + 1] & MCI_STATUS_VAL) {
-                break;
-            }
-        }
-        assert(bank < bank_num);
-
-        mce.bank = bank;
-        mce.status = env->mce_banks[bank * 4 + 1];
-        mce.mcg_status = env->mcg_status;
-        mce.addr = env->mce_banks[bank * 4 + 2];
-        mce.misc = env->mce_banks[bank * 4 + 3];
-
-        return kvm_vcpu_ioctl(CPU(cpu), KVM_X86_SET_MCE, &mce);
-    }
-    return 0;
-}
-
 static void cpu_update_state(void *opaque, bool running, RunState state)
 {
     CPUX86State *env = opaque;
@@ -4359,10 +4320,6 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
     CPUX86State *env = &cpu->env;
     struct kvm_vcpu_events events = {};
 
-    if (!kvm_has_vcpu_events()) {
-        return 0;
-    }
-
     events.flags = 0;
 
     if (has_exception_payload) {
@@ -4430,10 +4387,6 @@ static int kvm_get_vcpu_events(X86CPU *cpu)
     struct kvm_vcpu_events events;
     int ret;
 
-    if (!kvm_has_vcpu_events()) {
-        return 0;
-    }
-
     memset(&events, 0, sizeof(events));
     ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_VCPU_EVENTS, &events);
     if (ret < 0) {
@@ -4499,37 +4452,6 @@ static int kvm_get_vcpu_events(X86CPU *cpu)
     return 0;
 }
 
-static int kvm_guest_debug_workarounds(X86CPU *cpu)
-{
-    CPUState *cs = CPU(cpu);
-    CPUX86State *env = &cpu->env;
-    int ret = 0;
-    unsigned long reinject_trap = 0;
-
-    if (!kvm_has_vcpu_events()) {
-        if (env->exception_nr == EXCP01_DB) {
-            reinject_trap = KVM_GUESTDBG_INJECT_DB;
-        } else if (env->exception_injected == EXCP03_INT3) {
-            reinject_trap = KVM_GUESTDBG_INJECT_BP;
-        }
-        kvm_reset_exception(env);
-    }
-
-    /*
-     * Kernels before KVM_CAP_X86_ROBUST_SINGLESTEP overwrote flags.TF
-     * injected via SET_GUEST_DEBUG while updating GP regs. Work around this
-     * by updating the debug state once again if single-stepping is on.
-     * Another reason to call kvm_update_guest_debug here is a pending debug
-     * trap raise by the guest. On kernels without SET_VCPU_EVENTS we have to
-     * reinject them via SET_GUEST_DEBUG.
-     */
-    if (reinject_trap ||
-        (!kvm_has_robust_singlestep() && cs->singlestep_enabled)) {
-        ret = kvm_update_guest_debug(cs, reinject_trap);
-    }
-    return ret;
-}
-
 static int kvm_put_debugregs(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
@@ -4702,11 +4624,6 @@ int kvm_arch_put_registers(CPUState *cpu, int level)
     if (ret < 0) {
         return ret;
     }
-    /* must be before kvm_put_msrs */
-    ret = kvm_inject_mce_oldstyle(x86_cpu);
-    if (ret < 0) {
-        return ret;
-    }
     ret = kvm_put_msrs(x86_cpu, level);
     if (ret < 0) {
         return ret;
@@ -4730,11 +4647,6 @@ int kvm_arch_put_registers(CPUState *cpu, int level)
     if (ret < 0) {
         return ret;
     }
-    /* must be last */
-    ret = kvm_guest_debug_workarounds(x86_cpu);
-    if (ret < 0) {
-        return ret;
-    }
     return 0;
 }
 
-- 
2.41.0


From 86f2438fc231666ad7fdf9560fc8f27eedd69252 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Oct 2023 14:30:44 +0200
Subject: [PULL 21/24] kvm: i386: require KVM_CAP_MCE
Content-Type: text/plain; charset=UTF-8

This was introduced in KVM in Linux 2.6.34, we can require it unconditionally.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 4a244174a0f..42574c2df89 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -97,6 +97,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(XSAVE),
     KVM_CAP_INFO(VCPU_EVENTS),
     KVM_CAP_INFO(X86_ROBUST_SINGLESTEP),
+    KVM_CAP_INFO(MCE),
     KVM_CAP_LAST_INFO
 };
 
@@ -582,14 +583,8 @@ uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
 static int kvm_get_mce_cap_supported(KVMState *s, uint64_t *mce_cap,
                                      int *max_banks)
 {
-    int r;
-
-    r = kvm_check_extension(s, KVM_CAP_MCE);
-    if (r > 0) {
-        *max_banks = r;
-        return kvm_ioctl(s, KVM_X86_GET_MCE_CAP_SUPPORTED, mce_cap);
-    }
-    return -ENOSYS;
+    *max_banks = kvm_check_extension(s, KVM_CAP_MCE);
+    return kvm_ioctl(s, KVM_X86_GET_MCE_CAP_SUPPORTED, mce_cap);
 }
 
 static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
@@ -2116,8 +2111,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
     if (((env->cpuid_version >> 8)&0xF) >= 6
         && (env->features[FEAT_1_EDX] & (CPUID_MCE | CPUID_MCA)) ==
-           (CPUID_MCE | CPUID_MCA)
-        && kvm_check_extension(cs->kvm_state, KVM_CAP_MCE) > 0) {
+           (CPUID_MCE | CPUID_MCA)) {
         uint64_t mcg_cap, unsupported_caps;
         int banks;
         int ret;
-- 
2.41.0


From 700766ba602330a4fc907254a2f45773a6c694fa Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Oct 2023 14:30:44 +0200
Subject: [PULL 22/24] kvm: i386: require KVM_CAP_ADJUST_CLOCK
Content-Type: text/plain; charset=UTF-8

This was introduced in KVM in Linux 2.6.33, we can require it
unconditionally.  KVM_CLOCK_TSC_STABLE was only added in Linux 4.9,
for now do not require it (though it would allow the removal of some
pretty yucky code).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/kvm/clock.c        | 4 ----
 target/i386/kvm/kvm.c      | 6 +-----
 target/i386/kvm/kvm_i386.h | 1 -
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index f25977d3f68..e756b0aa43f 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -333,10 +333,6 @@ void kvmclock_create(bool create_always)
     X86CPU *cpu = X86_CPU(first_cpu);
 
     assert(kvm_enabled());
-    if (!kvm_has_adjust_clock()) {
-        return;
-    }
-
     if (create_always ||
         cpu->env.features[FEAT_KVM] & ((1ULL << KVM_FEATURE_CLOCKSOURCE) |
                                        (1ULL << KVM_FEATURE_CLOCKSOURCE2))) {
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 42574c2df89..d4bf327fa6f 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -98,6 +98,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(VCPU_EVENTS),
     KVM_CAP_INFO(X86_ROBUST_SINGLESTEP),
     KVM_CAP_INFO(MCE),
+    KVM_CAP_INFO(ADJUST_CLOCK),
     KVM_CAP_LAST_INFO
 };
 
@@ -177,11 +178,6 @@ bool kvm_has_adjust_clock_stable(void)
     return (ret & KVM_CLOCK_TSC_STABLE);
 }
 
-bool kvm_has_adjust_clock(void)
-{
-    return kvm_check_extension(kvm_state, KVM_CAP_ADJUST_CLOCK);
-}
-
 bool kvm_has_exception_payload(void)
 {
     return has_exception_payload;
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 55d4e68c342..7e60ea4f23f 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -50,7 +50,6 @@ void kvm_request_xsave_components(X86CPU *cpu, uint64_t mask);
 
 #ifdef CONFIG_KVM
 
-bool kvm_has_adjust_clock(void);
 bool kvm_has_adjust_clock_stable(void);
 bool kvm_has_exception_payload(void);
 void kvm_synchronize_all_tsc(void);
-- 
2.41.0


From 52b04ea49d3c4da73828aaf66dab234301428912 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Oct 2023 14:30:44 +0200
Subject: [PULL 23/24] kvm: i386: require KVM_CAP_SET_IDENTITY_MAP_ADDR
Content-Type: text/plain; charset=UTF-8

This was introduced in KVM in Linux 2.6.32, we can require it unconditionally.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index d4bf327fa6f..e364b842e6d 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -99,6 +99,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(X86_ROBUST_SINGLESTEP),
     KVM_CAP_INFO(MCE),
     KVM_CAP_INFO(ADJUST_CLOCK),
+    KVM_CAP_INFO(SET_IDENTITY_MAP_ADDR),
     KVM_CAP_LAST_INFO
 };
 
@@ -2600,20 +2601,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
      * In order to use vm86 mode, an EPT identity map and a TSS  are needed.
      * Since these must be part of guest physical memory, we need to allocate
      * them, both by setting their start addresses in the kernel and by
-     * creating a corresponding e820 entry. We need 4 pages before the BIOS.
-     *
-     * Older KVM versions may not support setting the identity map base. In
-     * that case we need to stick with the default, i.e. a 256K maximum BIOS
-     * size.
+     * creating a corresponding e820 entry. We need 4 pages before the BIOS,
+     * so this value allows up to 16M BIOSes.
      */
-    if (kvm_check_extension(s, KVM_CAP_SET_IDENTITY_MAP_ADDR)) {
-        /* Allows up to 16M BIOSes. */
-        identity_base = 0xfeffc000;
-
-        ret = kvm_vm_ioctl(s, KVM_SET_IDENTITY_MAP_ADDR, &identity_base);
-        if (ret < 0) {
-            return ret;
-        }
+    identity_base = 0xfeffc000;
+    ret = kvm_vm_ioctl(s, KVM_SET_IDENTITY_MAP_ADDR, &identity_base);
+    if (ret < 0) {
+        return ret;
     }
 
     /* Set TSS base one page after EPT identity map. */
-- 
2.41.0


From 39dd3e1f55a70f568cc9d280f67467aa4e8a63bd Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Oct 2023 14:29:03 +0200
Subject: [PULL 24/24] kvm: i8254: require KVM_CAP_PIT2 and KVM_CAP_PIT_STATE2
Content-Type: text/plain; charset=UTF-8

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/kvm/i8254.c        | 38 ++++++++++++--------------------------
 hw/i386/pc.c               |  6 +-----
 target/i386/kvm/kvm.c      |  7 -------
 target/i386/kvm/kvm_i386.h |  1 -
 4 files changed, 13 insertions(+), 39 deletions(-)

diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index a649b2b7caf..e49b9c4b565 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -97,24 +97,12 @@ static void kvm_pit_get(PITCommonState *pit)
         return;
     }
 
-    if (kvm_has_pit_state2()) {
-        ret = kvm_vm_ioctl(kvm_state, KVM_GET_PIT2, &kpit);
-        if (ret < 0) {
-            fprintf(stderr, "KVM_GET_PIT2 failed: %s\n", strerror(-ret));
-            abort();
-        }
-        pit->channels[0].irq_disabled = kpit.flags & KVM_PIT_FLAGS_HPET_LEGACY;
-    } else {
-        /*
-         * kvm_pit_state2 is superset of kvm_pit_state struct,
-         * so we can use it for KVM_GET_PIT as well.
-         */
-        ret = kvm_vm_ioctl(kvm_state, KVM_GET_PIT, &kpit);
-        if (ret < 0) {
-            fprintf(stderr, "KVM_GET_PIT failed: %s\n", strerror(-ret));
-            abort();
-        }
+    ret = kvm_vm_ioctl(kvm_state, KVM_GET_PIT2, &kpit);
+    if (ret < 0) {
+        fprintf(stderr, "KVM_GET_PIT2 failed: %s\n", strerror(-ret));
+        abort();
     }
+    pit->channels[0].irq_disabled = kpit.flags & KVM_PIT_FLAGS_HPET_LEGACY;
     for (i = 0; i < 3; i++) {
         kchan = &kpit.channels[i];
         sc = &pit->channels[i];
@@ -170,12 +158,9 @@ static void kvm_pit_put(PITCommonState *pit)
         kchan->count_load_time = sc->count_load_time - s->kernel_clock_offset;
     }
 
-    ret = kvm_vm_ioctl(kvm_state,
-                       kvm_has_pit_state2() ? KVM_SET_PIT2 : KVM_SET_PIT,
-                       &kpit);
+    ret = kvm_vm_ioctl(kvm_state, KVM_SET_PIT2, &kpit);
     if (ret < 0) {
-        fprintf(stderr, "%s failed: %s\n",
-                kvm_has_pit_state2() ? "KVM_SET_PIT2" : "KVM_SET_PIT",
+        fprintf(stderr, "KVM_SET_PIT2 failed: %s\n",
                 strerror(-ret));
         abort();
     }
@@ -261,11 +246,12 @@ static void kvm_pit_realizefn(DeviceState *dev, Error **errp)
     };
     int ret;
 
-    if (kvm_check_extension(kvm_state, KVM_CAP_PIT2)) {
-        ret = kvm_vm_ioctl(kvm_state, KVM_CREATE_PIT2, &config);
-    } else {
-        ret = kvm_vm_ioctl(kvm_state, KVM_CREATE_PIT);
+    if (!kvm_check_extension(kvm_state, KVM_CAP_PIT_STATE2) ||
+        !kvm_check_extension(kvm_state, KVM_CAP_PIT2)) {
+        error_setg(errp, "In-kernel PIT not available");
     }
+
+    ret = kvm_vm_ioctl(kvm_state, KVM_CREATE_PIT2, &config);
     if (ret < 0) {
         error_setg(errp, "Create kernel PIC irqchip failed: %s",
                    strerror(-ret));
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 11fed78d178..6031234a73f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1214,12 +1214,8 @@ void pc_basic_device_init(struct PCMachineState *pcms,
 
     /*
      * Check if an HPET shall be created.
-     *
-     * Without KVM_CAP_PIT_STATE2, we cannot switch off the in-kernel PIT
-     * when the HPET wants to take over. Thus we have to disable the latter.
      */
-    if (pcms->hpet_enabled && (!kvm_irqchip_in_kernel() ||
-                               kvm_has_pit_state2())) {
+    if (pcms->hpet_enabled) {
         qemu_irq rtc_irq;
 
         hpet = qdev_try_new(TYPE_HPET);
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e364b842e6d..770e81d56e4 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -145,7 +145,6 @@ static uint32_t num_architectural_pmu_fixed_counters;
 
 static int has_xsave2;
 static int has_xcrs;
-static int has_pit_state2;
 static int has_sregs2;
 static int has_exception_payload;
 static int has_triple_fault_event;
@@ -162,11 +161,6 @@ static KVMMSRHandlers msr_handlers[KVM_MSR_FILTER_MAX_RANGES];
 static RateLimit bus_lock_ratelimit_ctrl;
 static int kvm_get_one_msr(X86CPU *cpu, int index, uint64_t *value);
 
-bool kvm_has_pit_state2(void)
-{
-    return !!has_pit_state2;
-}
-
 bool kvm_has_smm(void)
 {
     return kvm_vm_check_extension(kvm_state, KVM_CAP_X86_SMM);
@@ -2543,7 +2537,6 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     }
 
     has_xcrs = kvm_check_extension(s, KVM_CAP_XCRS);
-    has_pit_state2 = kvm_check_extension(s, KVM_CAP_PIT_STATE2);
     has_sregs2 = kvm_check_extension(s, KVM_CAP_SREGS2) > 0;
 
     hv_vpindex_settable = kvm_check_extension(s, KVM_CAP_HYPERV_VP_INDEX);
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 7e60ea4f23f..30fedcffea3 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -33,7 +33,6 @@
 bool kvm_has_smm(void);
 bool kvm_enable_x2apic(void);
 bool kvm_hv_vpindex_settable(void);
-bool kvm_has_pit_state2(void);
 
 bool kvm_enable_sgx_provisioning(KVMState *s);
 bool kvm_hyperv_expand_features(X86CPU *cpu, Error **errp);
-- 
2.41.0


