Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A473A722E05
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 19:57:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6ESI-0006Gb-FJ; Mon, 05 Jun 2023 13:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6ESF-0006Eu-Od
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 13:57:19 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6ESA-0001ZH-Ou
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 13:57:19 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f6ffc2b314so45355475e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 10:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685987833; x=1688579833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wvDqRABIqr3Oo9TcR+X4DZIBBFFduSjhdrasWY6zw2Q=;
 b=HepwZ9DDulBh2zkr79aO0Tj5cCcT6IVbzqZ9EUOV2F/ttVpmjR08GCyR+JbpB3b2bL
 KaYB0FLahSCr/7x7coWdPri3Lm7J7GU0VYodtwJ8K4/XDDSH8lpzOcx1nWFrmFl60kjp
 qsdHtBrUKMKWE4ZDCBzoQgZ7RWiywWPdtkb9ih23/tHXzCsSQczjaCDcV/GNIfM9TsGR
 nBO6MPdgyiClkK8yTOSYHTAIZ8KSiNW/5Qm265OliBWgwsh5Sf3+93qgLAkzHCOKIDhj
 1gTuNJEM4Eu1lwhyHBT/fLwJk9NDZUQXrMmN0+zVPZxSzfqeelmOn0iSkDw2pWFqnN5D
 J1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685987833; x=1688579833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wvDqRABIqr3Oo9TcR+X4DZIBBFFduSjhdrasWY6zw2Q=;
 b=CvDRtRKxpZ6tH6rqYDyewqHs0zyBfwTCIiICn08pO8yFz/9vj9T4/LoC1MaD+foUYs
 fHbAs4/c/GQyp/xa0zTkBPwp9jY+20vHNQ0NeSqIUzUtX8eZK2gnWlfTpPlnXJbZakkX
 sdYE+h9+RqV8lJ+A+nDqXfArvPcGQnGFCUFBm0JlvaGbMUCmyEenGkoCyVMeaTaw5h9B
 M1WYN2hugB4B+S4bIqwkMHAl5rLARMVmkM4tESjMZf8UCb3XK17J0De47NXLycJX4Ghr
 mkT1NA03W/c4xtdirvesnFpjRGNnHb+gRwAheEVm6Yo9NMo52ORskiatOWIuQl+RpdLw
 jgEw==
X-Gm-Message-State: AC+VfDw+Bgzli+xKNYz9uKbxOpg/Nvo2cjt6xiN9wXK/xwbpw4WTCLSg
 iZkb/FWm8QpxoWqxQ3NFx9QgWP+YJUesIbf2BbY=
X-Google-Smtp-Source: ACHHUZ5TNPgK788Faz/XZmECD4joofgP8dXVrBkoJMcjJl4wLqI7SotZS/h05OEY301hv/vAjIzo/g==
X-Received: by 2002:a5d:6248:0:b0:306:2c20:c4fb with SMTP id
 m8-20020a5d6248000000b003062c20c4fbmr6775085wrv.2.1685987833084; 
 Mon, 05 Jun 2023 10:57:13 -0700 (PDT)
Received: from localhost.localdomain ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 e12-20020a5d594c000000b0030ae16132besm10340768wri.12.2023.06.05.10.57.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Jun 2023 10:57:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/5] bulk: Do not declare function prototypes using
 'extern' keyword
Date: Mon,  5 Jun 2023 19:56:46 +0200
Message-Id: <20230605175647.88395-5-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230605175647.88395-1-philmd@linaro.org>
References: <20230605175647.88395-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

By default, C function prototypes declared in headers are visible,
so there is no need to declare them as 'extern' functions.
Remove this redundancy in a single bulk commit; do not modify:

  - meson.build (used to check function availability at runtime)
  - pc-bios/
  - libdecnumber/
  - tests/
  - *.c

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 bsd-user/bsd-file.h            |  6 ++---
 crypto/hmacpriv.h              | 13 +++++------
 hw/xen/xen_pt.h                |  8 +++----
 include/crypto/secret_common.h | 14 +++++-------
 include/exec/page-vary.h       |  4 ++--
 include/hw/misc/aspeed_scu.h   |  2 +-
 include/hw/nvram/npcm7xx_otp.h |  4 ++--
 include/hw/qdev-core.h         |  4 ++--
 include/qemu/crc-ccitt.h       |  4 ++--
 include/qemu/osdep.h           |  4 ++--
 include/qemu/rcu.h             | 14 ++++++------
 include/qemu/sys_membarrier.h  |  4 ++--
 include/qemu/uri.h             |  6 ++---
 include/sysemu/accel-blocker.h | 14 ++++++------
 include/sysemu/os-win32.h      |  4 ++--
 include/user/safe-syscall.h    |  4 ++--
 target/i386/sev.h              |  6 ++---
 target/mips/cpu.h              |  4 ++--
 tcg/tcg-internal.h             |  4 ++--
 include/exec/memory_ldst.h.inc | 42 +++++++++++++++++-----------------
 20 files changed, 79 insertions(+), 86 deletions(-)

diff --git a/bsd-user/bsd-file.h b/bsd-user/bsd-file.h
index 588e0c50d4..3c00dc0056 100644
--- a/bsd-user/bsd-file.h
+++ b/bsd-user/bsd-file.h
@@ -51,10 +51,8 @@ do {                                        \
     unlock_user(p1, arg1, 0);               \
 } while (0)
 
-extern struct iovec *lock_iovec(int type, abi_ulong target_addr, int count,
-        int copy);
-extern void unlock_iovec(struct iovec *vec, abi_ulong target_addr, int count,
-        int copy);
+struct iovec *lock_iovec(int type, abi_ulong target_addr, int count, int copy);
+void unlock_iovec(struct iovec *vec, abi_ulong target_addr, int count, int copy);
 
 int safe_open(const char *path, int flags, mode_t mode);
 int safe_openat(int fd, const char *path, int flags, mode_t mode);
diff --git a/crypto/hmacpriv.h b/crypto/hmacpriv.h
index 4387ca2587..62dfe8257a 100644
--- a/crypto/hmacpriv.h
+++ b/crypto/hmacpriv.h
@@ -28,19 +28,18 @@ struct QCryptoHmacDriver {
     void (*hmac_free)(QCryptoHmac *hmac);
 };
 
-extern void *qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
-                                  const uint8_t *key, size_t nkey,
-                                  Error **errp);
+void *qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
+                           const uint8_t *key, size_t nkey,
+                           Error **errp);
 extern QCryptoHmacDriver qcrypto_hmac_lib_driver;
 
 #ifdef CONFIG_AF_ALG
 
 #include "afalgpriv.h"
 
-extern QCryptoAFAlg *
-qcrypto_afalg_hmac_ctx_new(QCryptoHashAlgorithm alg,
-                           const uint8_t *key, size_t nkey,
-                           Error **errp);
+QCryptoAFAlg *qcrypto_afalg_hmac_ctx_new(QCryptoHashAlgorithm alg,
+                                         const uint8_t *key, size_t nkey,
+                                         Error **errp);
 extern QCryptoHmacDriver qcrypto_hmac_afalg_driver;
 
 #endif
diff --git a/hw/xen/xen_pt.h b/hw/xen/xen_pt.h
index b20744f7c7..31bcfdf705 100644
--- a/hw/xen/xen_pt.h
+++ b/hw/xen/xen_pt.h
@@ -340,11 +340,9 @@ static inline bool xen_pt_has_msix_mapping(XenPCIPassthroughState *s, int bar)
     return s->msix && s->msix->bar_index == bar;
 }
 
-extern void *pci_assign_dev_load_option_rom(PCIDevice *dev,
-                                            int *size,
-                                            unsigned int domain,
-                                            unsigned int bus, unsigned int slot,
-                                            unsigned int function);
+void *pci_assign_dev_load_option_rom(PCIDevice *dev, int *size,
+                                     unsigned int domain, unsigned int bus,
+                                     unsigned int slot, unsigned int function);
 static inline bool is_igd_vga_passthrough(XenHostPCIDevice *dev)
 {
     return (xen_igd_gfx_pt_enabled()
diff --git a/include/crypto/secret_common.h b/include/crypto/secret_common.h
index 42c7ff7af6..a0a22e1abd 100644
--- a/include/crypto/secret_common.h
+++ b/include/crypto/secret_common.h
@@ -48,13 +48,11 @@ struct QCryptoSecretCommonClass {
 };
 
 
-extern int qcrypto_secret_lookup(const char *secretid,
-                                 uint8_t **data,
-                                 size_t *datalen,
-                                 Error **errp);
-extern char *qcrypto_secret_lookup_as_utf8(const char *secretid,
-                                           Error **errp);
-extern char *qcrypto_secret_lookup_as_base64(const char *secretid,
-                                             Error **errp);
+int qcrypto_secret_lookup(const char *secretid,
+                          uint8_t **data,
+                          size_t *datalen,
+                          Error **errp);
+char *qcrypto_secret_lookup_as_utf8(const char *secretid, Error **errp);
+char *qcrypto_secret_lookup_as_base64(const char *secretid, Error **errp);
 
 #endif /* QCRYPTO_SECRET_COMMON_H */
diff --git a/include/exec/page-vary.h b/include/exec/page-vary.h
index ebbe9b169b..54ddde308a 100644
--- a/include/exec/page-vary.h
+++ b/include/exec/page-vary.h
@@ -27,8 +27,8 @@ typedef struct {
 } TargetPageBits;
 
 #ifdef IN_PAGE_VARY
-extern bool set_preferred_target_page_bits_common(int bits);
-extern void finalize_target_page_bits_common(int min);
+bool set_preferred_target_page_bits_common(int bits);
+void finalize_target_page_bits_common(int min);
 #endif
 
 /**
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
index 5c7c04eedf..7cb6018dbc 100644
--- a/include/hw/misc/aspeed_scu.h
+++ b/include/hw/misc/aspeed_scu.h
@@ -51,7 +51,7 @@ struct AspeedSCUState {
 
 #define ASPEED_IS_AST2500(si_rev)     ((((si_rev) >> 24) & 0xff) == 0x04)
 
-extern bool is_supported_silicon_rev(uint32_t silicon_rev);
+bool is_supported_silicon_rev(uint32_t silicon_rev);
 
 
 struct AspeedSCUClass {
diff --git a/include/hw/nvram/npcm7xx_otp.h b/include/hw/nvram/npcm7xx_otp.h
index 156bbd151a..ea4b5d0731 100644
--- a/include/hw/nvram/npcm7xx_otp.h
+++ b/include/hw/nvram/npcm7xx_otp.h
@@ -73,7 +73,7 @@ typedef struct NPCM7xxOTPClass NPCM7xxOTPClass;
  * Each nibble of data is encoded into a byte, so the number of bytes written
  * to the array will be @len * 2.
  */
-extern void npcm7xx_otp_array_write(NPCM7xxOTPState *s, const void *data,
-                                    unsigned int offset, unsigned int len);
+void npcm7xx_otp_array_write(NPCM7xxOTPState *s, const void *data,
+                             unsigned int offset, unsigned int len);
 
 #endif /* NPCM7XX_OTP_H */
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index f1070d6dc7..16c1f6ca9b 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -910,7 +910,7 @@ typedef enum MachineInitPhase {
     PHASE_MACHINE_READY,
 } MachineInitPhase;
 
-extern bool phase_check(MachineInitPhase phase);
-extern void phase_advance(MachineInitPhase phase);
+bool phase_check(MachineInitPhase phase);
+void phase_advance(MachineInitPhase phase);
 
 #endif
diff --git a/include/qemu/crc-ccitt.h b/include/qemu/crc-ccitt.h
index d6eb49146d..8918dafe07 100644
--- a/include/qemu/crc-ccitt.h
+++ b/include/qemu/crc-ccitt.h
@@ -17,8 +17,8 @@
 extern uint16_t const crc_ccitt_table[256];
 extern uint16_t const crc_ccitt_false_table[256];
 
-extern uint16_t crc_ccitt(uint16_t crc, const uint8_t *buffer, size_t len);
-extern uint16_t crc_ccitt_false(uint16_t crc, const uint8_t *buffer, size_t len);
+uint16_t crc_ccitt(uint16_t crc, const uint8_t *buffer, size_t len);
+uint16_t crc_ccitt_false(uint16_t crc, const uint8_t *buffer, size_t len);
 
 static inline uint16_t crc_ccitt_byte(uint16_t crc, const uint8_t c)
 {
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index cc61b00ba9..3210d34ded 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -237,7 +237,7 @@ extern "C" {
  * supports QEMU_ERROR, this will be reported at compile time; otherwise
  * this will be reported at link time due to the missing symbol.
  */
-G_NORETURN extern
+G_NORETURN
 void QEMU_ERROR("code path is reachable")
     qemu_build_not_reached_always(void);
 #if defined(__OPTIMIZE__) && !defined(__NO_INLINE__)
@@ -496,7 +496,7 @@ void qemu_anon_ram_free(void *ptr, size_t size);
  * See MySQL bug #7156 (http://bugs.mysql.com/bug.php?id=7156) for discussion
  * about Solaris missing the madvise() prototype.
  */
-extern int madvise(char *, size_t, int);
+int madvise(char *, size_t, int);
 #endif
 
 #if defined(CONFIG_LINUX)
diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
index 661c1a1468..fea058aa9f 100644
--- a/include/qemu/rcu.h
+++ b/include/qemu/rcu.h
@@ -118,19 +118,19 @@ static inline void rcu_read_unlock(void)
     }
 }
 
-extern void synchronize_rcu(void);
+void synchronize_rcu(void);
 
 /*
  * Reader thread registration.
  */
-extern void rcu_register_thread(void);
-extern void rcu_unregister_thread(void);
+void rcu_register_thread(void);
+void rcu_unregister_thread(void);
 
 /*
  * Support for fork().  fork() support is enabled at startup.
  */
-extern void rcu_enable_atfork(void);
-extern void rcu_disable_atfork(void);
+void rcu_enable_atfork(void);
+void rcu_disable_atfork(void);
 
 struct rcu_head;
 typedef void RCUCBFunc(struct rcu_head *head);
@@ -140,8 +140,8 @@ struct rcu_head {
     RCUCBFunc *func;
 };
 
-extern void call_rcu1(struct rcu_head *head, RCUCBFunc *func);
-extern void drain_call_rcu(void);
+void call_rcu1(struct rcu_head *head, RCUCBFunc *func);
+void drain_call_rcu(void);
 
 /* The operands of the minus operator must have the same type,
  * which must be the one that we specify in the cast.
diff --git a/include/qemu/sys_membarrier.h b/include/qemu/sys_membarrier.h
index b5bfa21d52..e7774891f8 100644
--- a/include/qemu/sys_membarrier.h
+++ b/include/qemu/sys_membarrier.h
@@ -14,8 +14,8 @@
  * side.  The slow side forces processor-level ordering on all other cores
  * through a system call.
  */
-extern void smp_mb_global_init(void);
-extern void smp_mb_global(void);
+void smp_mb_global_init(void);
+void smp_mb_global(void);
 #define smp_mb_placeholder()       barrier()
 #else
 /* Keep it simple, execute a real memory barrier on both sides.  */
diff --git a/include/qemu/uri.h b/include/qemu/uri.h
index 2875c51417..1855b764f2 100644
--- a/include/qemu/uri.h
+++ b/include/qemu/uri.h
@@ -96,8 +96,8 @@ typedef struct QueryParams {
   QueryParam *p;       /* array of parameters */
 } QueryParams;
 
-QueryParams *query_params_new (int init_alloc);
-extern QueryParams *query_params_parse (const char *query);
-extern void query_params_free (QueryParams *ps);
+QueryParams *query_params_new(int init_alloc);
+QueryParams *query_params_parse(const char *query);
+void query_params_free(QueryParams *ps);
 
 #endif /* QEMU_URI_H */
diff --git a/include/sysemu/accel-blocker.h b/include/sysemu/accel-blocker.h
index 0733783bcc..f07f368358 100644
--- a/include/sysemu/accel-blocker.h
+++ b/include/sysemu/accel-blocker.h
@@ -16,7 +16,7 @@
 
 #include "sysemu/cpus.h"
 
-extern void accel_blocker_init(void);
+void accel_blocker_init(void);
 
 /*
  * accel_{cpu_}ioctl_begin/end:
@@ -26,10 +26,10 @@ extern void accel_blocker_init(void);
  * called, preventing new ioctls to run. They will continue only after
  * accel_ioctl_inibith_end().
  */
-extern void accel_ioctl_begin(void);
-extern void accel_ioctl_end(void);
-extern void accel_cpu_ioctl_begin(CPUState *cpu);
-extern void accel_cpu_ioctl_end(CPUState *cpu);
+void accel_ioctl_begin(void);
+void accel_ioctl_end(void);
+void accel_cpu_ioctl_begin(CPUState *cpu);
+void accel_cpu_ioctl_end(CPUState *cpu);
 
 /*
  * accel_ioctl_inhibit_begin: start critical section
@@ -42,7 +42,7 @@ extern void accel_cpu_ioctl_end(CPUState *cpu);
  * This allows the caller to access shared data or perform operations without
  * worrying of concurrent vcpus accesses.
  */
-extern void accel_ioctl_inhibit_begin(void);
+void accel_ioctl_inhibit_begin(void);
 
 /*
  * accel_ioctl_inhibit_end: end critical section started by
@@ -50,6 +50,6 @@ extern void accel_ioctl_inhibit_begin(void);
  *
  * This function allows blocked accel_{cpu_}ioctl_begin() to continue.
  */
-extern void accel_ioctl_inhibit_end(void);
+void accel_ioctl_inhibit_end(void);
 
 #endif /* ACCEL_BLOCKER_H */
diff --git a/include/sysemu/os-win32.h b/include/sysemu/os-win32.h
index 65f6c9ea57..f8e300d302 100644
--- a/include/sysemu/os-win32.h
+++ b/include/sysemu/os-win32.h
@@ -66,8 +66,8 @@ extern "C" {
  * setjmp to _setjmpex instead. However, they are still defined in libmingwex.a,
  * which gets linked automatically.
  */
-extern int __mingw_setjmp(jmp_buf);
-extern void __attribute__((noreturn)) __mingw_longjmp(jmp_buf, int);
+int __mingw_setjmp(jmp_buf);
+void __attribute__((noreturn)) __mingw_longjmp(jmp_buf, int);
 #define setjmp(env) __mingw_setjmp(env)
 #define longjmp(env, val) __mingw_longjmp(env, val)
 #elif defined(_WIN64)
diff --git a/include/user/safe-syscall.h b/include/user/safe-syscall.h
index ddceef12e2..f06393c09e 100644
--- a/include/user/safe-syscall.h
+++ b/include/user/safe-syscall.h
@@ -126,8 +126,8 @@
  */
 
 /* The core part of this function is implemented in assembly */
-extern long safe_syscall_base(int *pending, long number, ...);
-extern long safe_syscall_set_errno_tail(int value);
+long safe_syscall_base(int *pending, long number, ...);
+long safe_syscall_set_errno_tail(int value);
 
 /* These are defined by the safe-syscall.inc.S file */
 extern char safe_syscall_start[];
diff --git a/target/i386/sev.h b/target/i386/sev.h
index 7b1528248a..e7499c95b1 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -46,9 +46,9 @@ bool sev_es_enabled(void);
 #define sev_es_enabled() 0
 #endif
 
-extern uint32_t sev_get_cbit_position(void);
-extern uint32_t sev_get_reduced_phys_bits(void);
-extern bool sev_add_kernel_loader_hashes(SevKernelLoaderContext *ctx, Error **errp);
+uint32_t sev_get_cbit_position(void);
+uint32_t sev_get_reduced_phys_bits(void);
+bool sev_add_kernel_loader_hashes(SevKernelLoaderContext *ctx, Error **errp);
 
 int sev_encrypt_flash(uint8_t *ptr, uint64_t len, Error **errp);
 int sev_inject_launch_secret(const char *hdr, const char *secret,
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 142c55af47..2077cb29be 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1187,8 +1187,8 @@ void mips_cpu_list(void);
 
 #define cpu_list mips_cpu_list
 
-extern void cpu_wrdsp(uint32_t rs, uint32_t mask_num, CPUMIPSState *env);
-extern uint32_t cpu_rddsp(uint32_t mask_num, CPUMIPSState *env);
+void cpu_wrdsp(uint32_t rs, uint32_t mask_num, CPUMIPSState *env);
+uint32_t cpu_rddsp(uint32_t mask_num, CPUMIPSState *env);
 
 /*
  * MMU modes definitions. We carefully match the indices with our
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 67b698bd5c..a8c5d957b0 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -109,8 +109,8 @@ static inline TCGv_i32 TCGV_HIGH(TCGv_i64 t)
     return temp_tcgv_i32(tcgv_i64_temp(t) + !HOST_BIG_ENDIAN);
 }
 #else
-extern TCGv_i32 TCGV_LOW(TCGv_i64) QEMU_ERROR("32-bit code path is reachable");
-extern TCGv_i32 TCGV_HIGH(TCGv_i64) QEMU_ERROR("32-bit code path is reachable");
+TCGv_i32 TCGV_LOW(TCGv_i64) QEMU_ERROR("32-bit code path is reachable");
+TCGv_i32 TCGV_HIGH(TCGv_i64) QEMU_ERROR("32-bit code path is reachable");
 #endif
 
 static inline TCGv_i64 TCGV128_LOW(TCGv_i128 t)
diff --git a/include/exec/memory_ldst.h.inc b/include/exec/memory_ldst.h.inc
index 7c3a641f7e..92ad74e956 100644
--- a/include/exec/memory_ldst.h.inc
+++ b/include/exec/memory_ldst.h.inc
@@ -20,48 +20,48 @@
  */
 
 #ifdef TARGET_ENDIANNESS
-extern uint16_t glue(address_space_lduw, SUFFIX)(ARG1_DECL,
+uint16_t glue(address_space_lduw, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-extern uint32_t glue(address_space_ldl, SUFFIX)(ARG1_DECL,
+uint32_t glue(address_space_ldl, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-extern uint64_t glue(address_space_ldq, SUFFIX)(ARG1_DECL,
+uint64_t glue(address_space_ldq, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-extern void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
+void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
-extern void glue(address_space_stw, SUFFIX)(ARG1_DECL,
+void glue(address_space_stw, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint16_t val, MemTxAttrs attrs, MemTxResult *result);
-extern void glue(address_space_stl, SUFFIX)(ARG1_DECL,
+void glue(address_space_stl, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
-extern void glue(address_space_stq, SUFFIX)(ARG1_DECL,
+void glue(address_space_stq, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
 #else
-extern uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
+uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-extern uint16_t glue(address_space_lduw_le, SUFFIX)(ARG1_DECL,
+uint16_t glue(address_space_lduw_le, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-extern uint16_t glue(address_space_lduw_be, SUFFIX)(ARG1_DECL,
+uint16_t glue(address_space_lduw_be, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-extern uint32_t glue(address_space_ldl_le, SUFFIX)(ARG1_DECL,
+uint32_t glue(address_space_ldl_le, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-extern uint32_t glue(address_space_ldl_be, SUFFIX)(ARG1_DECL,
+uint32_t glue(address_space_ldl_be, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-extern uint64_t glue(address_space_ldq_le, SUFFIX)(ARG1_DECL,
+uint64_t glue(address_space_ldq_le, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-extern uint64_t glue(address_space_ldq_be, SUFFIX)(ARG1_DECL,
+uint64_t glue(address_space_ldq_be, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-extern void glue(address_space_stb, SUFFIX)(ARG1_DECL,
+void glue(address_space_stb, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint8_t val, MemTxAttrs attrs, MemTxResult *result);
-extern void glue(address_space_stw_le, SUFFIX)(ARG1_DECL,
+void glue(address_space_stw_le, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint16_t val, MemTxAttrs attrs, MemTxResult *result);
-extern void glue(address_space_stw_be, SUFFIX)(ARG1_DECL,
+void glue(address_space_stw_be, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint16_t val, MemTxAttrs attrs, MemTxResult *result);
-extern void glue(address_space_stl_le, SUFFIX)(ARG1_DECL,
+void glue(address_space_stl_le, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
-extern void glue(address_space_stl_be, SUFFIX)(ARG1_DECL,
+void glue(address_space_stl_be, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
-extern void glue(address_space_stq_le, SUFFIX)(ARG1_DECL,
+void glue(address_space_stq_le, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
-extern void glue(address_space_stq_be, SUFFIX)(ARG1_DECL,
+void glue(address_space_stq_be, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
 #endif
 
-- 
2.38.1


