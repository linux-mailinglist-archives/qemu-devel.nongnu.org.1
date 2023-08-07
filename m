Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF24771D31
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 11:36:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSwe6-0002S8-2N; Mon, 07 Aug 2023 05:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qSwdt-0002Qv-IV
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:35:17 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qSwdo-0000TN-8C
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:35:12 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bx5fDDutBk1OcRAA--.40349S3;
 Mon, 07 Aug 2023 17:34:59 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxzyPButBkA+dMAA--.23101S2; 
 Mon, 07 Aug 2023 17:34:58 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, laurent@vivier.eu, deller@gmx.de,
 peter.maydell@linaro.org, philmd@linaro.org, alex.bennee@linaro.org,
 maobibo@loongson.cn, yangxiaojuan@loongson.cn
Subject: [PATCH v1 1/1] linux-user/loongarch64: Add LSX context save/restore.
Date: Mon,  7 Aug 2023 17:34:56 +0800
Message-Id: <20230807093456.3438347-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxzyPButBkA+dMAA--.23101S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

The upstream kernel had added vector extensions support
See:
  commit 616500232e632dba8b03981eeccadacf2fbf1c30
  Author: Huacai Chen <chenhuacai@kernel.org>
  Date:   Thu Jun 29 20:58:43 2023

      LoongArch: Add vector extensions support

      Add LoongArch's vector extensions support, which including 128bit LSX
      (i.e., Loongson SIMD eXtension) and 256bit LASX (i.e., Loongson Advanced
      SIMD eXtension).
  ...

This patch adds linux-user LSX context save/restore.

Test code:

  "
   #include <unistd.h>
   #include <stdio.h>
   #include <stdlib.h>
   #include <errno.h>
   #include <signal.h>
   #include <asm/ucontext.h>
   #include <setjmp.h>
   #include <stdint.h>
   #include <string.h>

   static sigjmp_buf jmpbuf;

   struct _ctx_layout {
        struct sctx_info *addr;
        unsigned int size;
   };

   struct extctx_layout {
        unsigned long size;
        unsigned int flags;
        struct _ctx_layout fpu;
        struct _ctx_layout lsx;
        struct _ctx_layout end;
   };

   static int parse_extcontext(struct sigcontext *sc, struct extctx_layout *extctx)
   {
       uint32_t magic, size;
       struct sctx_info *info = (struct sctx_info *)&sc->sc_extcontext;

       while(1) {
           magic = (uint32_t)info->magic;
           size =  (uint32_t)info->size;
           switch (magic) {
           case 0: /* END*/
               return 0;
           case FPU_CTX_MAGIC:
               if (size < (sizeof(struct sctx_info) +
                           sizeof(struct fpu_context))) {
                   return -1;
               }
               extctx->fpu.addr = info;
               break;
           case LSX_CTX_MAGIC:
               if (size < (sizeof(struct sctx_info) +
                           sizeof(struct lsx_context))) {
                   return -1;
               }
               extctx->lsx.addr = info;
               break;
           default:
               return -1;
           }
           info = (struct sctx_info *)((char *)info +size);
       }
       return 0;
   }

   static int n = 0;

   static void do_signal(int sig, siginfo_t *info, void *ucontext)
   {
       printf("--------------do_signal------------%d\n", n);
       printf("sig is %d\n", sig);

       int i;
       struct ucontext *uc = (struct ucontext *)ucontext;
       struct extctx_layout extctx;

       memset(&extctx, 0, sizeof(struct extctx_layout));
       parse_extcontext(&uc->uc_mcontext, &extctx);

       if (n < 3) {
           printf("extctx.lsx.addr  is %lx\n", extctx.lsx.addr);
           printf("extctx.fpu.addr  is %lx\n", extctx.fpu.addr);
           if (extctx.lsx.addr) {
               struct sctx_info *info = extctx.lsx.addr;
               struct lsx_context *lsx_ctx = (struct lsx_context *)((char *)info +
                                             sizeof(struct sctx_info));
               printf("use lsx_context\n");
           } else if (extctx.fpu.addr) {
               struct sctx_info *info = extctx.fpu.addr;
               struct fpu_context *fpu_ctx = (struct fpu_context *)((char *)info +
                                             sizeof(struct sctx_info));
               printf("use fpu_context\n");
           }
       }
       n++;
       if (n == 1) {
           // vaddwev.w.hu    $vr27, $vr22, $vr29
           asm volatile(".word 0x702ef6db");
           printf("exec LSX instructon  vaddwev.w.hu\n");
       }

       if (n == 2) {
           // fadd.d          $fs6, $ft2, $ft6
           asm volatile(".word 0x0101395e");
           printf("exec FPU instruction fadd\n");
       }

       if (n == 3) {
           exit(0);
       }

       siglongjmp(jmpbuf, 1);
   }

   static int setup_signal(int sig, void (*fn) (int, siginfo_t *, void *))
   {
       struct sigaction my_act;
       int ret;

       my_act.sa_sigaction = fn;
       my_act.sa_flags = SA_SIGINFO;
       sigemptyset(&my_act.sa_mask);

       ret = sigaction(sig, &my_act, NULL);
       if (ret != 0) {
           printf("FAIL: signal %d\n", sig);
           return SIG_ERR;
       }
   }

   int main()
   {
       setup_signal(SIGSEGV, do_signal);

       sigsetjmp(jmpbuf, 1);

       int result = 0;
       void *addr = 0x00012;
       result = *(int *)addr;

       return 0;
   }
    "

3A5000:

[root@archlinux LSX]# ./signal-lsx
--------------do_signal------------0
sig is 11
extctx.lsx.addr  is 0
extctx.fpu.addr  is 7ffffb90d470
use fpu_context
exec LSX instructon  vaddwev.w.hu
--------------do_signal------------1
sig is 11
extctx.lsx.addr  is 7ffffb90d370
extctx.fpu.addr  is 0
use lsx_context
exec FPU instruction fadd
--------------do_signal------------2
sig is 11
extctx.lsx.addr  is 7ffffb90d370
extctx.fpu.addr  is 0
use lsx_context

QEMU:

[gaosong@kvm-dev1 qemu]$ ./build/qemu-loongarch64 ~/signal-lsx
--------------do_signal------------0
sig is 11
extctx.lsx.addr  is 0
extctx.fpu.addr  is 40008023d0
use fpu_context
exec LSX instructon  vaddwev.w.hu
--------------do_signal------------1
sig is 11
extctx.lsx.addr  is 40008023d0
extctx.fpu.addr  is 0
use lsx_context
exec FPU instruction fadd
--------------do_signal------------2
sig is 11
extctx.lsx.addr  is 40008023d0
extctx.fpu.addr  is 0
use lsx_context

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 linux-user/loongarch64/signal.c             | 97 +++++++++++++++++----
 target/loongarch/cpu.h                      |  2 +
 target/loongarch/insn_trans/trans_lsx.c.inc | 49 +++++++++++
 target/loongarch/internals.h                |  3 +
 target/loongarch/translate.c                |  7 ++
 target/loongarch/translate.h                |  1 +
 6 files changed, 141 insertions(+), 18 deletions(-)

diff --git a/linux-user/loongarch64/signal.c b/linux-user/loongarch64/signal.c
index bb8efb1172..aff8c817fc 100644
--- a/linux-user/loongarch64/signal.c
+++ b/linux-user/loongarch64/signal.c
@@ -32,6 +32,14 @@ struct target_fpu_context {
     uint32_t fcsr;
 } QEMU_ALIGNED(FPU_CTX_ALIGN);
 
+#define LSX_CTX_MAGIC           0x53580001
+#define LSX_CTX_ALIGN           16
+struct target_lsx_context {
+    uint64_t regs[2 * 32];
+    uint64_t fcc;
+    uint32_t fcsr;
+} QEMU_ALIGNED(LSX_CTX_ALIGN);
+
 #define CONTEXT_INFO_ALIGN      16
 struct target_sctx_info {
     uint32_t magic;
@@ -68,6 +76,7 @@ struct extctx_layout {
     unsigned int size;
     unsigned int flags;
     struct ctx_layout fpu;
+    struct ctx_layout lsx;
     struct ctx_layout end;
 };
 
@@ -89,7 +98,8 @@ static abi_ptr extframe_alloc(struct extctx_layout *extctx,
     return sp;
 }
 
-static abi_ptr setup_extcontext(struct extctx_layout *extctx, abi_ptr sp)
+static abi_ptr setup_extcontext(CPULoongArchState *env,
+                                struct extctx_layout *extctx, abi_ptr sp)
 {
     memset(extctx, 0, sizeof(struct extctx_layout));
 
@@ -98,9 +108,15 @@ static abi_ptr setup_extcontext(struct extctx_layout *extctx, abi_ptr sp)
 
     /* For qemu, there is no lazy fp context switch, so fp always present. */
     extctx->flags = SC_USED_FP;
-    sp = extframe_alloc(extctx, &extctx->fpu,
-                        sizeof(struct target_rt_sigframe), FPU_CTX_ALIGN, sp);
 
+    if (env->extctx_flags & EXTCTX_FLAGS_LSX) {
+        sp = extframe_alloc(extctx, &extctx->lsx,
+                        sizeof(struct target_rt_sigframe), LSX_CTX_ALIGN, sp);
+
+    } else if (env->extctx_flags & EXTCTX_FLAGS_FPU) {
+        sp = extframe_alloc(extctx, &extctx->fpu,
+                        sizeof(struct target_rt_sigframe), FPU_CTX_ALIGN, sp);
+    }
     return sp;
 }
 
@@ -109,7 +125,6 @@ static void setup_sigframe(CPULoongArchState *env,
                            struct extctx_layout *extctx)
 {
     struct target_sctx_info *info;
-    struct target_fpu_context *fpu_ctx;
     int i;
 
     __put_user(extctx->flags, &sc->sc_flags);
@@ -120,18 +135,34 @@ static void setup_sigframe(CPULoongArchState *env,
     }
 
     /*
-     * Set fpu context
+     * Set extctx context
      */
-    info = extctx->fpu.haddr;
-    __put_user(FPU_CTX_MAGIC, &info->magic);
-    __put_user(extctx->fpu.size, &info->size);
+    if (env->extctx_flags & EXTCTX_FLAGS_LSX) {
+        struct target_lsx_context *lsx_ctx;
+        info = extctx->lsx.haddr;
+        __put_user(LSX_CTX_MAGIC, &info->magic);
+        __put_user(extctx->lsx.size, &info->size);
 
-    fpu_ctx = (struct target_fpu_context *)(info + 1);
-    for (i = 0; i < 32; ++i) {
-        __put_user(env->fpr[i].vreg.D(0), &fpu_ctx->regs[i]);
+        lsx_ctx = (struct target_lsx_context *)(info + 1);
+        for (i = 0; i < 32; ++i) {
+            __put_user(env->fpr[i].vreg.UD(0), &lsx_ctx->regs[2 * i]);
+            __put_user(env->fpr[i].vreg.UD(1), &lsx_ctx->regs[2 * i + 1]);
+        }
+        __put_user(read_fcc(env), &lsx_ctx->fcc);
+        __put_user(env->fcsr0, &lsx_ctx->fcsr);
+    } else if (env->extctx_flags & EXTCTX_FLAGS_FPU) {
+        struct target_fpu_context *fpu_ctx;
+        info = extctx->fpu.haddr;
+        __put_user(FPU_CTX_MAGIC, &info->magic);
+        __put_user(extctx->fpu.size, &info->size);
+
+        fpu_ctx = (struct target_fpu_context *)(info + 1);
+        for (i = 0; i < 32; ++i) {
+            __put_user(env->fpr[i].vreg.UD(0), &fpu_ctx->regs[i]);
+        }
+        __put_user(read_fcc(env), &fpu_ctx->fcc);
+        __put_user(env->fcsr0, &fpu_ctx->fcsr);
     }
-    __put_user(read_fcc(env), &fpu_ctx->fcc);
-    __put_user(env->fcsr0, &fpu_ctx->fcsr);
 
     /*
      * Set end context
@@ -168,6 +199,15 @@ static bool parse_extcontext(struct extctx_layout *extctx, abi_ptr frame)
             extctx->fpu.size = size;
             extctx->size += size;
             break;
+        case LSX_CTX_MAGIC:
+            if (size < (sizeof(struct target_sctx_info) +
+                        sizeof(struct target_lsx_context))) {
+                return false;
+            }
+            extctx->lsx.gaddr = frame;
+            extctx->lsx.size = size;
+            extctx->size += size;
+            break;
         default:
             return false;
         }
@@ -187,13 +227,26 @@ static void restore_sigframe(CPULoongArchState *env,
         __get_user(env->gpr[i], &sc->sc_regs[i]);
     }
 
-    if (extctx->fpu.haddr) {
+    if (extctx->lsx.haddr) {
+        struct target_lsx_context *lsx_ctx =
+            extctx->lsx.haddr + sizeof(struct target_sctx_info);
+        uint64_t fcc;
+
+        for (i = 0; i < 32; ++i) {
+            __get_user(env->fpr[i].vreg.UD(0), &lsx_ctx->regs[2 * i]);
+            __get_user(env->fpr[i].vreg.UD(1), &lsx_ctx->regs[2 * i + 1]);
+        }
+        __get_user(fcc, &lsx_ctx->fcc);
+        write_fcc(env, fcc);
+        __get_user(env->fcsr0, &lsx_ctx->fcsr);
+        restore_fp_status(env);
+    } else if (extctx->fpu.haddr) {
         struct target_fpu_context *fpu_ctx =
             extctx->fpu.haddr + sizeof(struct target_sctx_info);
         uint64_t fcc;
 
         for (i = 0; i < 32; ++i) {
-            __get_user(env->fpr[i].vreg.D(0), &fpu_ctx->regs[i]);
+            __get_user(env->fpr[i].vreg.UD(0), &fpu_ctx->regs[i]);
         }
         __get_user(fcc, &fpu_ctx->fcc);
         write_fcc(env, fcc);
@@ -213,7 +266,7 @@ static abi_ptr get_sigframe(struct target_sigaction *ka,
 
     sp = target_sigsp(get_sp_from_cpustate(env), ka);
     sp = ROUND_DOWN(sp, 16);
-    sp = setup_extcontext(extctx, sp);
+    sp = setup_extcontext(env, extctx, sp);
     sp -= sizeof(struct target_rt_sigframe);
 
     assert(QEMU_IS_ALIGNED(sp, 16));
@@ -239,7 +292,12 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
         force_sigsegv(sig);
         return;
     }
-    extctx.fpu.haddr = (void *)frame + (extctx.fpu.gaddr - frame_addr);
+
+    if (env->extctx_flags & EXTCTX_FLAGS_LSX) {
+        extctx.lsx.haddr = (void *)frame + (extctx.lsx.gaddr - frame_addr);
+    } else if (env->extctx_flags & EXTCTX_FLAGS_FPU) {
+        extctx.fpu.haddr = (void *)frame + (extctx.fpu.gaddr - frame_addr);
+    }
     extctx.end.haddr = (void *)frame + (extctx.end.gaddr - frame_addr);
 
     tswap_siginfo(&frame->rs_info, info);
@@ -283,7 +341,10 @@ long do_rt_sigreturn(CPULoongArchState *env)
     if (!frame) {
         goto badframe;
     }
-    if (extctx.fpu.gaddr) {
+
+    if (extctx.lsx.gaddr) {
+        extctx.lsx.haddr = (void *)frame + (extctx.lsx.gaddr - frame_addr);
+    } else if (extctx.fpu.gaddr) {
         extctx.fpu.haddr = (void *)frame + (extctx.fpu.gaddr - frame_addr);
     }
 
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index fa371ca8ba..eeff58bd64 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -288,6 +288,8 @@ typedef struct CPUArchState {
     uint64_t lladdr; /* LL virtual address compared against SC */
     uint64_t llval;
 
+    uint64_t extctx_flags; /* user-mode extcontext flags */
+
     /* LoongArch CSRs */
     uint64_t CSR_CRMD;
     uint64_t CSR_PRMD;
diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
index 68779daff6..b4ef1b3cca 100644
--- a/target/loongarch/insn_trans/trans_lsx.c.inc
+++ b/target/loongarch/insn_trans/trans_lsx.c.inc
@@ -11,8 +11,12 @@
         return true; \
     } \
 } while (0)
+#define SET_LSX_EXTCTX
 #else
 #define CHECK_SXE
+#define SET_LSX_EXTCTX do { \
+    ctx->extctx_flags |= EXTCTX_FLAGS_LSX; \
+} while (0)
 #endif
 
 static bool gen_vvvv(DisasContext *ctx, arg_vvvv *a,
@@ -25,6 +29,7 @@ static bool gen_vvvv(DisasContext *ctx, arg_vvvv *a,
     TCGv_i32 va = tcg_constant_i32(a->va);
 
     CHECK_SXE;
+    SET_LSX_EXTCTX;
     func(cpu_env, vd, vj, vk, va);
     return true;
 }
@@ -37,6 +42,7 @@ static bool gen_vvv(DisasContext *ctx, arg_vvv *a,
     TCGv_i32 vk = tcg_constant_i32(a->vk);
 
     CHECK_SXE;
+    SET_LSX_EXTCTX;
 
     func(cpu_env, vd, vj, vk);
     return true;
@@ -49,6 +55,7 @@ static bool gen_vv(DisasContext *ctx, arg_vv *a,
     TCGv_i32 vj = tcg_constant_i32(a->vj);
 
     CHECK_SXE;
+    SET_LSX_EXTCTX;
     func(cpu_env, vd, vj);
     return true;
 }
@@ -61,6 +68,7 @@ static bool gen_vv_i(DisasContext *ctx, arg_vv_i *a,
     TCGv_i32 imm = tcg_constant_i32(a->imm);
 
     CHECK_SXE;
+    SET_LSX_EXTCTX;
     func(cpu_env, vd, vj, imm);
     return true;
 }
@@ -72,6 +80,7 @@ static bool gen_cv(DisasContext *ctx, arg_cv *a,
     TCGv_i32 cd = tcg_constant_i32(a->cd);
 
     CHECK_SXE;
+    SET_LSX_EXTCTX;
     func(cpu_env, cd, vj);
     return true;
 }
@@ -83,6 +92,7 @@ static bool gvec_vvv(DisasContext *ctx, arg_vvv *a, MemOp mop,
     uint32_t vd_ofs, vj_ofs, vk_ofs;
 
     CHECK_SXE;
+    SET_LSX_EXTCTX;
 
     vd_ofs = vec_full_offset(a->vd);
     vj_ofs = vec_full_offset(a->vj);
@@ -99,6 +109,7 @@ static bool gvec_vv(DisasContext *ctx, arg_vv *a, MemOp mop,
     uint32_t vd_ofs, vj_ofs;
 
     CHECK_SXE;
+    SET_LSX_EXTCTX;
 
     vd_ofs = vec_full_offset(a->vd);
     vj_ofs = vec_full_offset(a->vj);
@@ -114,6 +125,7 @@ static bool gvec_vv_i(DisasContext *ctx, arg_vv_i *a, MemOp mop,
     uint32_t vd_ofs, vj_ofs;
 
     CHECK_SXE;
+    SET_LSX_EXTCTX;
 
     vd_ofs = vec_full_offset(a->vd);
     vj_ofs = vec_full_offset(a->vj);
@@ -127,6 +139,7 @@ static bool gvec_subi(DisasContext *ctx, arg_vv_i *a, MemOp mop)
     uint32_t vd_ofs, vj_ofs;
 
     CHECK_SXE;
+    SET_LSX_EXTCTX;
 
     vd_ofs = vec_full_offset(a->vd);
     vj_ofs = vec_full_offset(a->vj);
@@ -146,6 +159,7 @@ static bool trans_v## NAME ##_q(DisasContext *ctx, arg_vvv *a) \
     TCGv_i64 rh, rl, ah, al, bh, bl;                           \
                                                                \
     CHECK_SXE;                                                 \
+    SET_LSX_EXTCTX;                                            \
                                                                \
     rh = tcg_temp_new_i64();                                   \
     rl = tcg_temp_new_i64();                                   \
@@ -3033,6 +3047,7 @@ static bool trans_vldi(DisasContext *ctx, arg_vldi *a)
     int sel, vece;
     uint64_t value;
     CHECK_SXE;
+    SET_LSX_EXTCTX;
 
     sel = (a->imm >> 12) & 0x1;
 
@@ -3059,6 +3074,7 @@ static bool trans_vandn_v(DisasContext *ctx, arg_vvv *a)
     uint32_t vd_ofs, vj_ofs, vk_ofs;
 
     CHECK_SXE;
+    SET_LSX_EXTCTX;
 
     vd_ofs = vec_full_offset(a->vd);
     vj_ofs = vec_full_offset(a->vj);
@@ -3686,6 +3702,7 @@ static bool do_cmp(DisasContext *ctx, arg_vvv *a, MemOp mop, TCGCond cond)
     uint32_t vd_ofs, vj_ofs, vk_ofs;
 
     CHECK_SXE;
+    SET_LSX_EXTCTX;
 
     vd_ofs = vec_full_offset(a->vd);
     vj_ofs = vec_full_offset(a->vj);
@@ -3732,6 +3749,7 @@ static bool do_## NAME ##_s(DisasContext *ctx, arg_vv_i *a, MemOp mop) \
     uint32_t vd_ofs, vj_ofs;                                           \
                                                                        \
     CHECK_SXE;                                                         \
+    SET_LSX_EXTCTX;                                                    \
                                                                        \
     static const TCGOpcode vecop_list[] = {                            \
         INDEX_op_cmp_vec, 0                                            \
@@ -3781,6 +3799,7 @@ static bool do_## NAME ##_u(DisasContext *ctx, arg_vv_i *a, MemOp mop) \
     uint32_t vd_ofs, vj_ofs;                                           \
                                                                        \
     CHECK_SXE;                                                         \
+    SET_LSX_EXTCTX;                                                    \
                                                                        \
     static const TCGOpcode vecop_list[] = {                            \
         INDEX_op_cmp_vec, 0                                            \
@@ -3875,6 +3894,7 @@ static bool trans_vfcmp_cond_s(DisasContext *ctx, arg_vvv_fcond *a)
     TCGv_i32 vk = tcg_constant_i32(a->vk);
 
     CHECK_SXE;
+    SET_LSX_EXTCTX;
 
     fn = (a->fcond & 1 ? gen_helper_vfcmp_s_s : gen_helper_vfcmp_c_s);
     flags = get_fcmp_flags(a->fcond >> 1);
@@ -3901,6 +3921,7 @@ static bool trans_vfcmp_cond_d(DisasContext *ctx, arg_vvv_fcond *a)
 static bool trans_vbitsel_v(DisasContext *ctx, arg_vvvv *a)
 {
     CHECK_SXE;
+    SET_LSX_EXTCTX;
 
     tcg_gen_gvec_bitsel(MO_64, vec_full_offset(a->vd), vec_full_offset(a->va),
                         vec_full_offset(a->vk), vec_full_offset(a->vj),
@@ -3923,6 +3944,7 @@ static bool trans_vbitseli_b(DisasContext *ctx, arg_vv_i *a)
     };
 
     CHECK_SXE;
+    SET_LSX_EXTCTX;
 
     tcg_gen_gvec_2i(vec_full_offset(a->vd), vec_full_offset(a->vj),
                     16, ctx->vl/8, a->imm, &op);
@@ -3942,6 +3964,7 @@ static bool trans_## NAME (DisasContext *ctx, arg_cv *a)                       \
     get_vreg64(al, a->vj, 0);                                                  \
                                                                                \
     CHECK_SXE;                                                                 \
+    SET_LSX_EXTCTX;                                                            \
     tcg_gen_or_i64(t1, al, ah);                                                \
     tcg_gen_setcondi_i64(COND, t1, t1, 0);                                     \
     tcg_gen_st8_tl(t1, cpu_env, offsetof(CPULoongArchState, cf[a->cd & 0x7])); \
@@ -3965,6 +3988,7 @@ static bool trans_vinsgr2vr_b(DisasContext *ctx, arg_vr_i *a)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
     CHECK_SXE;
+    SET_LSX_EXTCTX;
     tcg_gen_st8_i64(src, cpu_env,
                     offsetof(CPULoongArchState, fpr[a->vd].vreg.B(a->imm)));
     return true;
@@ -3974,6 +3998,7 @@ static bool trans_vinsgr2vr_h(DisasContext *ctx, arg_vr_i *a)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
     CHECK_SXE;
+    SET_LSX_EXTCTX;
     tcg_gen_st16_i64(src, cpu_env,
                     offsetof(CPULoongArchState, fpr[a->vd].vreg.H(a->imm)));
     return true;
@@ -3983,6 +4008,7 @@ static bool trans_vinsgr2vr_w(DisasContext *ctx, arg_vr_i *a)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
     CHECK_SXE;
+    SET_LSX_EXTCTX;
     tcg_gen_st32_i64(src, cpu_env,
                      offsetof(CPULoongArchState, fpr[a->vd].vreg.W(a->imm)));
     return true;
@@ -3992,6 +4018,7 @@ static bool trans_vinsgr2vr_d(DisasContext *ctx, arg_vr_i *a)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
     CHECK_SXE;
+    SET_LSX_EXTCTX;
     tcg_gen_st_i64(src, cpu_env,
                    offsetof(CPULoongArchState, fpr[a->vd].vreg.D(a->imm)));
     return true;
@@ -4001,6 +4028,7 @@ static bool trans_vpickve2gr_b(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
     CHECK_SXE;
+    SET_LSX_EXTCTX;
     tcg_gen_ld8s_i64(dst, cpu_env,
                      offsetof(CPULoongArchState, fpr[a->vj].vreg.B(a->imm)));
     return true;
@@ -4010,6 +4038,7 @@ static bool trans_vpickve2gr_h(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
     CHECK_SXE;
+    SET_LSX_EXTCTX;
     tcg_gen_ld16s_i64(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.H(a->imm)));
     return true;
@@ -4019,6 +4048,7 @@ static bool trans_vpickve2gr_w(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
     CHECK_SXE;
+    SET_LSX_EXTCTX;
     tcg_gen_ld32s_i64(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.W(a->imm)));
     return true;
@@ -4028,6 +4058,7 @@ static bool trans_vpickve2gr_d(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
     CHECK_SXE;
+    SET_LSX_EXTCTX;
     tcg_gen_ld_i64(dst, cpu_env,
                    offsetof(CPULoongArchState, fpr[a->vj].vreg.D(a->imm)));
     return true;
@@ -4037,6 +4068,7 @@ static bool trans_vpickve2gr_bu(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
     CHECK_SXE;
+    SET_LSX_EXTCTX;
     tcg_gen_ld8u_i64(dst, cpu_env,
                      offsetof(CPULoongArchState, fpr[a->vj].vreg.B(a->imm)));
     return true;
@@ -4046,6 +4078,7 @@ static bool trans_vpickve2gr_hu(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
     CHECK_SXE;
+    SET_LSX_EXTCTX;
     tcg_gen_ld16u_i64(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.H(a->imm)));
     return true;
@@ -4055,6 +4088,7 @@ static bool trans_vpickve2gr_wu(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
     CHECK_SXE;
+    SET_LSX_EXTCTX;
     tcg_gen_ld32u_i64(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.W(a->imm)));
     return true;
@@ -4064,6 +4098,7 @@ static bool trans_vpickve2gr_du(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
     CHECK_SXE;
+    SET_LSX_EXTCTX;
     tcg_gen_ld_i64(dst, cpu_env,
                    offsetof(CPULoongArchState, fpr[a->vj].vreg.D(a->imm)));
     return true;
@@ -4073,6 +4108,7 @@ static bool gvec_dup(DisasContext *ctx, arg_vr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
     CHECK_SXE;
+    SET_LSX_EXTCTX;
 
     tcg_gen_gvec_dup_i64(mop, vec_full_offset(a->vd),
                          16, ctx->vl/8, src);
@@ -4087,6 +4123,7 @@ TRANS(vreplgr2vr_d, gvec_dup, MO_64)
 static bool trans_vreplvei_b(DisasContext *ctx, arg_vv_i *a)
 {
     CHECK_SXE;
+    SET_LSX_EXTCTX;
     tcg_gen_gvec_dup_mem(MO_8,vec_full_offset(a->vd),
                          offsetof(CPULoongArchState,
                                   fpr[a->vj].vreg.B((a->imm))),
@@ -4097,6 +4134,7 @@ static bool trans_vreplvei_b(DisasContext *ctx, arg_vv_i *a)
 static bool trans_vreplvei_h(DisasContext *ctx, arg_vv_i *a)
 {
     CHECK_SXE;
+    SET_LSX_EXTCTX;
     tcg_gen_gvec_dup_mem(MO_16, vec_full_offset(a->vd),
                          offsetof(CPULoongArchState,
                                   fpr[a->vj].vreg.H((a->imm))),
@@ -4106,6 +4144,7 @@ static bool trans_vreplvei_h(DisasContext *ctx, arg_vv_i *a)
 static bool trans_vreplvei_w(DisasContext *ctx, arg_vv_i *a)
 {
     CHECK_SXE;
+    SET_LSX_EXTCTX;
     tcg_gen_gvec_dup_mem(MO_32, vec_full_offset(a->vd),
                          offsetof(CPULoongArchState,
                                   fpr[a->vj].vreg.W((a->imm))),
@@ -4115,6 +4154,7 @@ static bool trans_vreplvei_w(DisasContext *ctx, arg_vv_i *a)
 static bool trans_vreplvei_d(DisasContext *ctx, arg_vv_i *a)
 {
     CHECK_SXE;
+    SET_LSX_EXTCTX;
     tcg_gen_gvec_dup_mem(MO_64, vec_full_offset(a->vd),
                          offsetof(CPULoongArchState,
                                   fpr[a->vj].vreg.D((a->imm))),
@@ -4130,6 +4170,7 @@ static bool gen_vreplve(DisasContext *ctx, arg_vvr *a, int vece, int bit,
     TCGv_i64 t2 = tcg_temp_new_i64();
 
     CHECK_SXE;
+    SET_LSX_EXTCTX;
 
     tcg_gen_andi_i64(t0, gpr_src(ctx, a->rk, EXT_NONE), (LSX_LEN/bit) -1);
     tcg_gen_shli_i64(t0, t0, vece);
@@ -4156,6 +4197,7 @@ static bool trans_vbsll_v(DisasContext *ctx, arg_vv_i *a)
     TCGv_i64 desthigh, destlow, high, low;
 
     CHECK_SXE;
+    SET_LSX_EXTCTX;
 
     desthigh = tcg_temp_new_i64();
     destlow = tcg_temp_new_i64();
@@ -4186,6 +4228,7 @@ static bool trans_vbsrl_v(DisasContext *ctx, arg_vv_i *a)
     int ofs;
 
     CHECK_SXE;
+    SET_LSX_EXTCTX;
 
     desthigh = tcg_temp_new_i64();
     destlow = tcg_temp_new_i64();
@@ -4260,6 +4303,7 @@ static bool trans_vld(DisasContext *ctx, arg_vr_i *a)
     TCGv_i128 val;
 
     CHECK_SXE;
+    SET_LSX_EXTCTX;
 
     addr = gpr_src(ctx, a->rj, EXT_NONE);
     val = tcg_temp_new_i128();
@@ -4287,6 +4331,7 @@ static bool trans_vst(DisasContext *ctx, arg_vr_i *a)
     TCGv_i64 ah, al;
 
     CHECK_SXE;
+    SET_LSX_EXTCTX;
 
     addr = gpr_src(ctx, a->rj, EXT_NONE);
     val = tcg_temp_new_i128();
@@ -4314,6 +4359,7 @@ static bool trans_vldx(DisasContext *ctx, arg_vrr *a)
     TCGv_i128 val;
 
     CHECK_SXE;
+    SET_LSX_EXTCTX;
 
     addr = tcg_temp_new();
     src1 = gpr_src(ctx, a->rj, EXT_NONE);
@@ -4338,6 +4384,7 @@ static bool trans_vstx(DisasContext *ctx, arg_vrr *a)
     TCGv_i128 val;
 
     CHECK_SXE;
+    SET_LSX_EXTCTX;
 
     addr = tcg_temp_new();
     src1 = gpr_src(ctx, a->rj, EXT_NONE);
@@ -4362,6 +4409,7 @@ static bool trans_## NAME (DisasContext *ctx, arg_vr_i *a)                \
     TCGv_i64 val;                                                         \
                                                                           \
     CHECK_SXE;                                                            \
+    SET_LSX_EXTCTX;                                                       \
                                                                           \
     addr = gpr_src(ctx, a->rj, EXT_NONE);                                 \
     val = tcg_temp_new_i64();                                             \
@@ -4390,6 +4438,7 @@ static bool trans_## NAME (DisasContext *ctx, arg_vr_ii *a)                  \
     TCGv_i64 val;                                                            \
                                                                              \
     CHECK_SXE;                                                               \
+    SET_LSX_EXTCTX;                                                          \
                                                                              \
     addr = gpr_src(ctx, a->rj, EXT_NONE);                                    \
     val = tcg_temp_new_i64();                                                \
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index 7b0f29c942..c1efe6af31 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -21,6 +21,9 @@
 /* Global bit for huge page */
 #define LOONGARCH_HGLOBAL_SHIFT     12
 
+#define EXTCTX_FLAGS_FPU  0b01
+#define EXTCTX_FLAGS_LSX  0b10
+
 #if  HOST_BIG_ENDIAN
 #define B(x)  B[15 - (x)]
 #define H(x)  H[7 - (x)]
diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index 3146a2d4ac..fc0577847b 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -119,6 +119,11 @@ static void loongarch_tr_init_disas_context(DisasContextBase *dcbase,
         ctx->vl = LSX_LEN;
     }
 
+    if (!(ctx->extctx_flags & EXTCTX_FLAGS_FPU) &&
+        !(ctx->extctx_flags & EXTCTX_FLAGS_LSX)) {
+        ctx->extctx_flags = EXTCTX_FLAGS_FPU;
+    }
+
     ctx->zero = tcg_constant_tl(0);
 }
 
@@ -235,6 +240,8 @@ static void loongarch_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
         generate_exception(ctx, EXCCODE_INE);
     }
 
+    env->extctx_flags |= ctx->extctx_flags;
+
     ctx->base.pc_next += 4;
 }
 
diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
index 7f60090580..8a1dd3a0a2 100644
--- a/target/loongarch/translate.h
+++ b/target/loongarch/translate.h
@@ -28,6 +28,7 @@ typedef enum {
 typedef struct DisasContext {
     DisasContextBase base;
     target_ulong page_start;
+    uint64_t extctx_flags;
     uint32_t opcode;
     uint16_t mem_idx;
     uint16_t plv;
-- 
2.39.1


