Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 366C68870B4
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Mar 2024 17:15:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnhYB-00013b-Ts; Fri, 22 Mar 2024 12:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnhXz-0000tR-Vh
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:15:14 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnhXt-00010Z-J8
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:15:10 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4147e907143so2761105e9.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 09:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711124103; x=1711728903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s1qPut0NhGBzfRg42Qh5UyiazOmzOKukv5I7c5rLwvg=;
 b=U98C/UpGj16i86taOLtDRIcrC8XqykHnLc2wfpXIMBJKs//mduCarDZYTLmc6TnQwf
 7pWrdsU8Jl6xpncwU2Lcl7ILGkTndflU6pQVuVZHrU2qHy4xLl+uWSG38lDdG5NV3ipV
 y+AQ2qnyUOouQjyMvq1JvRVmfKbKroxFOXVY45LRlUMLf59aPm0UWhf49AELXHm4cUJI
 V0uJauzqETm4YYppxdrAjvH2mOYEqi72A0/GkjKMavs/5QyKu37MGN6FbSOil3klUcul
 6iBvrpWwMbUeeMFjW3zgl27MdivxReWXVOwD480ROdQ1m6j/tSjQ9T5vY2hECl8qkSA8
 NpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711124103; x=1711728903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s1qPut0NhGBzfRg42Qh5UyiazOmzOKukv5I7c5rLwvg=;
 b=Q1f8Y7iDZhAyXTBHpJvAkzhYZOWJ8s7+p3xNBwun1eorzOkkiy6QC+LVw4SqTBUYga
 qdEHVu1m4BxnZGCrUg7QmrOMsWjHui2NDVyG4vBuJMbjsjVY3Q5Vlsvy1FP/SB4rjvXj
 iJjy6Zz0RckP6QqHgjdQGk/dOjq/Thmo0TLhjD4yK9MIFPuGcjK/PQoY8A+OxPueBoqb
 TrAqxR5Lxb/LWMRxqc6ansiiE9u1wpndIdORUW9fhU0YF7MtflytNs2B1eQ2nX4GfhbF
 OEYqQcYSkecnEhw8XCRNxWHliNdXZ0ngBdy7puewoVQVheLq0Z3vSbPJcuMI0LV+WCCE
 4NkA==
X-Gm-Message-State: AOJu0Yyy+aI/q0BWqkpZMtocHzjQmvFM0z7FGgAhST6/KxfS/w8ClA0D
 STU3YzWJlGy9iXS4MhbRcf957hYszTL8Ph7xPfSV4ljYE9EmQmYvQ49czx721Rv3GS+/T0Eah+8
 T
X-Google-Smtp-Source: AGHT+IHlt+ox/CID64UUSwzrMDTeHUJbOcdvrgQZGJkSECtfnfLaNH6boam/8ucRh2a5UcSqVNTFgQ==
X-Received: by 2002:a05:6000:51:b0:33e:a1e3:87b3 with SMTP id
 k17-20020a056000005100b0033ea1e387b3mr1779324wrx.41.1711124103530; 
 Fri, 22 Mar 2024 09:15:03 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.178.251])
 by smtp.gmail.com with ESMTPSA id
 b7-20020a056000054700b0033e7b05edf3sm2383822wrf.44.2024.03.22.09.15.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 22 Mar 2024 09:15:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH-for-9.1 v2 3/3] exec: Rename NEED_CPU_H -> COMPILING_PER_TARGET
Date: Fri, 22 Mar 2024 17:14:39 +0100
Message-ID: <20240322161439.6448-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240322161439.6448-1-philmd@linaro.org>
References: <20240322161439.6448-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

'NEED_CPU_H' guard target-specific code; it is defined by meson
altogether with the 'CONFIG_TARGET' definition. Rename NEED_CPU_H
as COMPILING_PER_TARGET to clarify its meaning.

Mechanical change running:

 $ sed -i s/NEED_CPU_H/COMPILING_PER_TARGET/g $(git grep -l NEED_CPU_H)

then manually add a /* COMPILING_PER_TARGET */ comment
after the '#endif' when the block is large.

Inspired-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build                | 4 ++--
 include/exec/cpu-defs.h    | 2 +-
 include/exec/helper-head.h | 4 ++--
 include/exec/memop.h       | 4 ++--
 include/exec/memory.h      | 4 ++--
 include/exec/tswap.h       | 4 ++--
 include/gdbstub/helpers.h  | 2 +-
 include/hw/core/cpu.h      | 4 ++--
 include/qemu/osdep.h       | 2 +-
 include/sysemu/hvf.h       | 8 ++++----
 include/sysemu/kvm.h       | 6 +++---
 include/sysemu/nvmm.h      | 4 ++--
 include/sysemu/whpx.h      | 4 ++--
 include/sysemu/xen.h       | 4 ++--
 target/arm/kvm-consts.h    | 4 ++--
 scripts/analyze-inclusions | 6 +++---
 16 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/meson.build b/meson.build
index b375248a76..f13ad52f5f 100644
--- a/meson.build
+++ b/meson.build
@@ -3637,7 +3637,7 @@ foreach d, list : target_modules
         if target.endswith('-softmmu')
           config_target = config_target_mak[target]
           target_inc = [include_directories('target' / config_target['TARGET_BASE_ARCH'])]
-          c_args = ['-DNEED_CPU_H',
+          c_args = ['-DCOMPILING_PER_TARGET',
                     '-DCONFIG_TARGET="@0@-config-target.h"'.format(target),
                     '-DCONFIG_DEVICES="@0@-config-devices.h"'.format(target)]
           target_module_ss = module_ss.apply(config_target, strict: false)
@@ -3820,7 +3820,7 @@ foreach target : target_dirs
   target_base_arch = config_target['TARGET_BASE_ARCH']
   arch_srcs = [config_target_h[target]]
   arch_deps = []
-  c_args = ['-DNEED_CPU_H',
+  c_args = ['-DCOMPILING_PER_TARGET',
             '-DCONFIG_TARGET="@0@-config-target.h"'.format(target),
             '-DCONFIG_DEVICES="@0@-config-devices.h"'.format(target)]
   link_args = emulator_link_args
diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 3915438b83..0dbef3010c 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -19,7 +19,7 @@
 #ifndef CPU_DEFS_H
 #define CPU_DEFS_H
 
-#ifndef NEED_CPU_H
+#ifndef COMPILING_PER_TARGET
 #error cpu.h included from common code
 #endif
 
diff --git a/include/exec/helper-head.h b/include/exec/helper-head.h
index 28ceab0a46..5ef467a79d 100644
--- a/include/exec/helper-head.h
+++ b/include/exec/helper-head.h
@@ -43,7 +43,7 @@
 #define dh_ctype_noreturn G_NORETURN void
 #define dh_ctype(t) dh_ctype_##t
 
-#ifdef NEED_CPU_H
+#ifdef COMPILING_PER_TARGET
 # ifdef TARGET_LONG_BITS
 #  if TARGET_LONG_BITS == 32
 #   define dh_alias_tl i32
@@ -54,7 +54,7 @@
 #  endif
 # endif
 # define dh_ctype_tl target_ulong
-#endif
+#endif /* COMPILING_PER_TARGET */
 
 /* We can't use glue() here because it falls foul of C preprocessor
    recursive expansion rules.  */
diff --git a/include/exec/memop.h b/include/exec/memop.h
index a86dc6743a..06417ff361 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -35,7 +35,7 @@ typedef enum MemOp {
     MO_LE    = 0,
     MO_BE    = MO_BSWAP,
 #endif
-#ifdef NEED_CPU_H
+#ifdef COMPILING_PER_TARGET
 #if TARGET_BIG_ENDIAN
     MO_TE    = MO_BE,
 #else
@@ -135,7 +135,7 @@ typedef enum MemOp {
     MO_BESL  = MO_BE | MO_SL,
     MO_BESQ  = MO_BE | MO_SQ,
 
-#ifdef NEED_CPU_H
+#ifdef COMPILING_PER_TARGET
     MO_TEUW  = MO_TE | MO_UW,
     MO_TEUL  = MO_TE | MO_UL,
     MO_TEUQ  = MO_TE | MO_UQ,
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 8626a355b3..bb51e90fe1 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -3087,7 +3087,7 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
 MemTxResult address_space_set(AddressSpace *as, hwaddr addr,
                               uint8_t c, hwaddr len, MemTxAttrs attrs);
 
-#ifdef NEED_CPU_H
+#ifdef COMPILING_PER_TARGET
 /* enum device_endian to MemOp.  */
 static inline MemOp devend_memop(enum device_endian end)
 {
@@ -3105,7 +3105,7 @@ static inline MemOp devend_memop(enum device_endian end)
     return (end == non_host_endianness) ? MO_BSWAP : 0;
 #endif
 }
-#endif
+#endif /* COMPILING_PER_TARGET */
 
 /*
  * Inhibit technologies that require discarding of pages in RAM blocks, e.g.,
diff --git a/include/exec/tswap.h b/include/exec/tswap.h
index 68944a880b..5089cd6a4c 100644
--- a/include/exec/tswap.h
+++ b/include/exec/tswap.h
@@ -15,11 +15,11 @@
  * If we're in target-specific code, we can hard-code the swapping
  * condition, otherwise we have to do (slower) run-time checks.
  */
-#ifdef NEED_CPU_H
+#ifdef COMPILING_PER_TARGET
 #define target_needs_bswap()  (HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN)
 #else
 #define target_needs_bswap()  (target_words_bigendian() != HOST_BIG_ENDIAN)
-#endif
+#endif /* COMPILING_PER_TARGET */
 
 static inline uint16_t tswap16(uint16_t s)
 {
diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
index 53e88d807c..6277a858a1 100644
--- a/include/gdbstub/helpers.h
+++ b/include/gdbstub/helpers.h
@@ -12,7 +12,7 @@
 #ifndef _GDBSTUB_HELPERS_H_
 #define _GDBSTUB_HELPERS_H_
 
-#ifndef NEED_CPU_H
+#ifndef COMPILING_PER_TARGET
 #error "gdbstub helpers should only be included by target specific code"
 #endif
 
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index ec14f74ce5..7f037b158e 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1182,7 +1182,7 @@ bool target_words_bigendian(void);
 
 const char *target_name(void);
 
-#ifdef NEED_CPU_H
+#ifdef COMPILING_PER_TARGET
 
 #ifndef CONFIG_USER_ONLY
 
@@ -1197,7 +1197,7 @@ extern const VMStateDescription vmstate_cpu_common;
 }
 #endif /* !CONFIG_USER_ONLY */
 
-#endif /* NEED_CPU_H */
+#endif /* COMPILING_PER_TARGET */
 
 #define UNASSIGNED_CPU_INDEX -1
 #define UNASSIGNED_CLUSTER_INDEX -1
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index c7053cdc2b..f61edcfdc2 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -32,7 +32,7 @@
 #endif
 
 #include "config-host.h"
-#ifdef NEED_CPU_H
+#ifdef COMPILING_PER_TARGET
 #include CONFIG_TARGET
 #else
 #include "exec/poison.h"
diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index 4a7c6af3a5..730f927f03 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -16,7 +16,7 @@
 #include "qemu/accel.h"
 #include "qom/object.h"
 
-#ifdef NEED_CPU_H
+#ifdef COMPILING_PER_TARGET
 #include "cpu.h"
 
 #ifdef CONFIG_HVF
@@ -26,7 +26,7 @@ extern bool hvf_allowed;
 #define hvf_enabled() 0
 #endif /* !CONFIG_HVF */
 
-#endif /* NEED_CPU_H */
+#endif /* COMPILING_PER_TARGET */
 
 #define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
 
@@ -34,7 +34,7 @@ typedef struct HVFState HVFState;
 DECLARE_INSTANCE_CHECKER(HVFState, HVF_STATE,
                          TYPE_HVF_ACCEL)
 
-#ifdef NEED_CPU_H
+#ifdef COMPILING_PER_TARGET
 struct hvf_sw_breakpoint {
     vaddr pc;
     vaddr saved_insn;
@@ -66,6 +66,6 @@ void hvf_arch_update_guest_debug(CPUState *cpu);
  * Return whether the guest supports debugging.
  */
 bool hvf_arch_supports_guest_debug(void);
-#endif /* NEED_CPU_H */
+#endif /* COMPILING_PER_TARGET */
 
 #endif
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index fad9a7e8ff..c618a59ba6 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -20,7 +20,7 @@
 #include "qemu/accel.h"
 #include "qom/object.h"
 
-#ifdef NEED_CPU_H
+#ifdef COMPILING_PER_TARGET
 # ifdef CONFIG_KVM
 #  include <linux/kvm.h>
 #  define CONFIG_KVM_IS_POSSIBLE
@@ -210,7 +210,7 @@ bool kvm_arm_supports_user_irq(void);
 int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
 int kvm_on_sigbus(int code, void *addr);
 
-#ifdef NEED_CPU_H
+#ifdef COMPILING_PER_TARGET
 #include "cpu.h"
 
 void kvm_flush_coalesced_mmio_buffer(void);
@@ -435,7 +435,7 @@ void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
 int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
                                        hwaddr *phys_addr);
 
-#endif /* NEED_CPU_H */
+#endif /* COMPILING_PER_TARGET */
 
 void kvm_cpu_synchronize_state(CPUState *cpu);
 
diff --git a/include/sysemu/nvmm.h b/include/sysemu/nvmm.h
index be7bc9a62d..6971ddb3a5 100644
--- a/include/sysemu/nvmm.h
+++ b/include/sysemu/nvmm.h
@@ -12,7 +12,7 @@
 #ifndef QEMU_NVMM_H
 #define QEMU_NVMM_H
 
-#ifdef NEED_CPU_H
+#ifdef COMPILING_PER_TARGET
 
 #ifdef CONFIG_NVMM
 
@@ -24,6 +24,6 @@ int nvmm_enabled(void);
 
 #endif /* CONFIG_NVMM */
 
-#endif /* NEED_CPU_H */
+#endif /* COMPILING_PER_TARGET */
 
 #endif /* QEMU_NVMM_H */
diff --git a/include/sysemu/whpx.h b/include/sysemu/whpx.h
index 781ca5b2b6..00ff409b68 100644
--- a/include/sysemu/whpx.h
+++ b/include/sysemu/whpx.h
@@ -15,7 +15,7 @@
 #ifndef QEMU_WHPX_H
 #define QEMU_WHPX_H
 
-#ifdef NEED_CPU_H
+#ifdef COMPILING_PER_TARGET
 
 #ifdef CONFIG_WHPX
 
@@ -29,6 +29,6 @@ bool whpx_apic_in_platform(void);
 
 #endif /* CONFIG_WHPX */
 
-#endif /* NEED_CPU_H */
+#endif /* COMPILING_PER_TARGET */
 
 #endif /* QEMU_WHPX_H */
diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
index a9f591f26d..754ec2e6cb 100644
--- a/include/sysemu/xen.h
+++ b/include/sysemu/xen.h
@@ -16,13 +16,13 @@
 
 #include "exec/cpu-common.h"
 
-#ifdef NEED_CPU_H
+#ifdef COMPILING_PER_TARGET
 # ifdef CONFIG_XEN
 #  define CONFIG_XEN_IS_POSSIBLE
 # endif
 #else
 # define CONFIG_XEN_IS_POSSIBLE
-#endif
+#endif /* COMPILING_PER_TARGET */
 
 #ifdef CONFIG_XEN_IS_POSSIBLE
 
diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
index 7c6adc14f6..c44d23dbe7 100644
--- a/target/arm/kvm-consts.h
+++ b/target/arm/kvm-consts.h
@@ -14,13 +14,13 @@
 #ifndef ARM_KVM_CONSTS_H
 #define ARM_KVM_CONSTS_H
 
-#ifdef NEED_CPU_H
+#ifdef COMPILING_PER_TARGET
 #ifdef CONFIG_KVM
 #include <linux/kvm.h>
 #include <linux/psci.h>
 #define MISMATCH_CHECK(X, Y) QEMU_BUILD_BUG_ON(X != Y)
 #endif
-#endif
+#endif /* COMPILING_PER_TARGET */
 
 #ifndef MISMATCH_CHECK
 #define MISMATCH_CHECK(X, Y) QEMU_BUILD_BUG_ON(0)
diff --git a/scripts/analyze-inclusions b/scripts/analyze-inclusions
index 45c821de32..b6280f25c8 100644
--- a/scripts/analyze-inclusions
+++ b/scripts/analyze-inclusions
@@ -92,7 +92,7 @@ echo trace/generated-tracers.h:
 analyze -include ../include/qemu/osdep.h trace/generated-tracers.h
 
 echo target/i386/cpu.h:
-analyze -DNEED_CPU_H -I../target/i386 -Ii386-softmmu -include ../include/qemu/osdep.h ../target/i386/cpu.h
+analyze -DCOMPILING_PER_TARGET -I../target/i386 -Ii386-softmmu -include ../include/qemu/osdep.h ../target/i386/cpu.h
 
-echo hw/hw.h + NEED_CPU_H:
-analyze -DNEED_CPU_H -I../target/i386 -Ii386-softmmu -include ../include/qemu/osdep.h ../include/hw/hw.h
+echo hw/hw.h + COMPILING_PER_TARGET:
+analyze -DCOMPILING_PER_TARGET -I../target/i386 -Ii386-softmmu -include ../include/qemu/osdep.h ../include/hw/hw.h
-- 
2.41.0


