Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFE87D28B4
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 04:47:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qukyc-0000Nk-S7; Sun, 22 Oct 2023 22:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qukyb-0000NT-4v
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 22:47:33 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qukyJ-00069K-Sf
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 22:47:32 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxpPCu3jVlNtczAA--.35473S3;
 Mon, 23 Oct 2023 10:47:10 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxL92q3jVltr8uAA--.35828S3; 
 Mon, 23 Oct 2023 10:47:08 +0800 (CST)
Subject: Re: [PATCH v1 0/6] linux-user/loongarch64: Add LSX/LASX sigcontext
From: gaosong <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@redhat.com, maobibo@loongson.cn,
 laurent@vivier.eu, deller@gmx.de, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20231010033701.385725-1-gaosong@loongson.cn>
Message-ID: <701f6866-0e52-e4f9-89b7-201a2feed321@loongson.cn>
Date: Mon, 23 Oct 2023 10:47:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20231010033701.385725-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxL92q3jVltr8uAA--.35828S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3GFWUWw4DZw4xKryUGr1DCFX_yoW3ZryDpF
 W3CF17ur4rJr45WF1DJa10y3W3tFn5CF4UCr97J340krWa93sY9ay7WFW8AFy5AryDWFya
 vr1DJws09F1Ut3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
 wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
 0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280
 aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
 xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
 x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r
 1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
 7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
 WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j8
 yCJUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-3.339, SPF_HELO_NONE=0.001,
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

Ping !

ÔÚ 2023/10/10 ÉÏÎç11:36, Song Gao Ð´µÀ:
> Hi, All.
>
> This series adds save/restore sigcontext.
>
> We use extctx_flags to choces which sigcontext need save/restore.
>
> The extctx_flags default value is EXTCTX_FLAGS_FPU, we need
> save/restore fpu context.
>
> After a LSX/LASX instruction is execed, extctx_flags value change to
> EXTCTX_FLAGS_LSX/LASX, we always need save/restore lsx/lasx context.
>
>
> The test_signal.c is a simple test.
>
> The default vreg len is 64. After execed a LSX instruction, the vreg len is
> 128, and then we exec a FPU instruction, the vreg len is also 128. After
> execed a LASX instruction, the vreg len is 256, and then we exec a FPU
> instruction, the vreg len is also 256.
>
> test_signal.c:
>
> #include <unistd.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <errno.h>
> #include <signal.h>
> #include <asm/ucontext.h>
> #include <setjmp.h>
> #include <stdint.h>
> #include <string.h>
>
> static sigjmp_buf jmpbuf;
>
> struct _ctx_layout {
>          struct sctx_info *addr;
>          unsigned int size;
> };
>
> struct extctx_layout {
>          unsigned long size;
>          unsigned int flags;
>          struct _ctx_layout fpu;
>          struct _ctx_layout lsx;
>          struct _ctx_layout lasx;
>          struct _ctx_layout end;
> };
> static int parse_extcontext(struct sigcontext *sc, struct extctx_layout *extctx)
> {
>      uint32_t magic, size;
>      struct sctx_info *info = (struct sctx_info *)&sc->sc_extcontext;
>
>      while(1) {
>          magic = (uint32_t)info->magic;
>          size =  (uint32_t)info->size;
>
>          printf("magic is %lx\n", magic);
>          printf("size is %lx\n", size);
>          switch (magic) {
>          case 0: /* END*/
>              return 0;
>          case FPU_CTX_MAGIC:
>              if (size < (sizeof(struct sctx_info) +
>                          sizeof(struct fpu_context))) {
>                  return -1;
>              }
>              extctx->fpu.addr = info;
>              break;
>          case LSX_CTX_MAGIC:
>              if (size < (sizeof(struct sctx_info) +
>                          sizeof(struct lsx_context))) {
>                  return -1;
>              }
>              extctx->lsx.addr = info;
>              break;
>          case LASX_CTX_MAGIC:
>              if (size < (sizeof(struct sctx_info) +
>                          sizeof(struct lasx_context))) {
>                  return -1;
>              }
>              extctx->lasx.addr = info;
>              break;
>          default:
>              return -1;
>          }
>          info = (struct sctx_info *)((char *)info +size);
>      }
>      return 0;
> }
>
> static int n = 0;
>
> static void do_signal(int sig, siginfo_t *info, void *ucontext)
> {
>      int i;
>      struct ucontext *uc = (struct ucontext *)ucontext;
>      struct extctx_layout extctx;
>
>      memset(&extctx, 0, sizeof(struct extctx_layout));
>
>      printf("pc        : %016lx\n", uc->uc_mcontext.sc_pc);
>
>      parse_extcontext(&uc->uc_mcontext, &extctx);
>
>      if (n < 5) {
>          printf("extctx.lasx.addr is %lx\n", extctx.lasx.addr);
>          printf("extctx.lsx.addr  is %lx\n", extctx.lsx.addr);
>          printf("extctx.fpu.addr  is %lx\n", extctx.fpu.addr);
>
>          if (extctx.lasx.addr) {
>              struct sctx_info *info = extctx.lasx.addr;
>              struct lasx_context *lasx_ctx = (struct lasx_context *)((char *)info +
>                                              sizeof(struct sctx_info));
>              printf("vl        : %016lx\n", 256);
>          } else if (extctx.lsx.addr) {
>              struct sctx_info *info = extctx.lsx.addr;
>              struct lsx_context *lsx_ctx = (struct lsx_context *)((char *)info +
>                                            sizeof(struct sctx_info));
>              printf("vl        : %016lx\n", 128);
>          } else if (extctx.fpu.addr) {
>              struct sctx_info *info = extctx.fpu.addr;
>              struct fpu_context *fpu_ctx = (struct fpu_context *)((char *)info +
>                                            sizeof(struct sctx_info));
>              printf("vl        : %016lx\n", 64);
>          }
>      }
>      n++;
>
>      printf("n is -------------- %d\n", n);
>      if (n == 1) {
>          // vaddwev.w.hu    $vr27, $vr22, $vr29
>          asm volatile(".word 0x702ef6db");
>          printf("After execed LSX instructons  vaddwev.w.hu\n");
>      }
>
>      if (n == 2) {
>          // 0101395e        fadd.d          $fs6, $ft2, $ft6
>          asm volatile(".word 0x0101395e");
>          printf("After execed FPU instructions fadd\n");
>      }
>
>      if (n == 3) {
>          // xvextrins.d     $xr13, $xr15, 0x59
>          asm volatile(".word 0x778165ed");
>          printf("After execed LASX instructions xvextrins.d\n");
>      }
>
>      if (n == 4) {
>          // 0101395e        fadd.d          $fs6, $ft2, $ft6
>          asm volatile(".word 0x0101395e");
>          printf("After execed FPU instructions fadd\n");
>      }
>
>      if (n == 5) {
>          exit(0);
>      }
>
>      siglongjmp(jmpbuf, 1);
> }
>
> static int setup_signal(int sig, void (*fn) (int, siginfo_t *, void *))
> {
>      struct sigaction my_act;
>      int ret;
>
>      my_act.sa_sigaction = fn;
>      my_act.sa_flags = SA_SIGINFO;
>      sigemptyset(&my_act.sa_mask);
>
>      ret = sigaction(sig, &my_act, NULL);
>      if (ret != 0) {
>          printf("FAIL: signal %d\n", sig);
>          return SIG_ERR;
>      }
> }
>
> int main()
> {
>      setup_signal(SIGSEGV, do_signal);
>
>      sigsetjmp(jmpbuf, 1);
>
>      int result = 0;
>      void *addr = 0x00012;
>      result = *(int *)addr;
>
>      return 0;
> }
>
>
> On 3A5000 machine:
>
> [root@archlinux LASX]# ./test_signal
> pc        : 0000000120000b44
> magic is 46505501
> size is 120
> magic is 0
> size is 0
> extctx.lasx.addr is 0
> extctx.lsx.addr  is 0
> extctx.fpu.addr  is 7ffffbdd2120
> vl        : 0000000000000040
> n is -------------- 1
> After execed LSX instructons  vaddwev.w.hu
> pc        : 0000000120000b44
> magic is 53580001
> size is 220
> magic is 0
> size is 0
> extctx.lasx.addr is 0
> extctx.lsx.addr  is 7ffffbdd2020
> extctx.fpu.addr  is 0
> vl        : 0000000000000080
> n is -------------- 2
> After execed FPU instructions fadd
> pc        : 0000000120000b44
> magic is 53580001
> size is 220
> magic is 0
> size is 0
> extctx.lasx.addr is 0
> extctx.lsx.addr  is 7ffffbdd2020
> extctx.fpu.addr  is 0
> vl        : 0000000000000080
> n is -------------- 3
> After execed LASX instructions xvextrins.d
> pc        : 0000000120000b44
> magic is 41535801
> size is 430
> magic is 0
> size is 0
> extctx.lasx.addr is 7ffffbdd1e10
> extctx.lsx.addr  is 0
> extctx.fpu.addr  is 0
> vl        : 0000000000000100
> n is -------------- 4
> After execed FPU instructions fadd
> pc        : 0000000120000b44
> magic is 41535801
> size is 430
> magic is 0
> size is 0
> extctx.lasx.addr is 7ffffbdd1e10
> extctx.lsx.addr  is 0
> extctx.fpu.addr  is 0
> vl        : 0000000000000100
> n is -------------- 5
>
> QEMU user-mode on X86:
>
> root@loongson-KVM:~/work/code/qemu# ./build/qemu-loongarch64 test_signal
> pc        : 0000000120000b44
> magic is 46505501
> size is 120
> magic is 0
> size is 0
> extctx.lasx.addr is 0
> extctx.lsx.addr  is 0
> extctx.fpu.addr  is 7fd92279f110
> vl        : 0000000000000040
> n is -------------- 1
> After exec LSX instructons  vaddwev.w.hu
> pc        : 0000000120000b44
> magic is 53580001
> size is 220
> magic is 0
> size is 0
> extctx.lasx.addr is 0
> extctx.lsx.addr  is 7fd92279f010
> extctx.fpu.addr  is 0
> vl        : 0000000000000080
> n is -------------- 2
> After execed FPU instructions fadd
> pc        : 0000000120000b44
> magic is 53580001
> size is 220
> magic is 0
> size is 0
> extctx.lasx.addr is 0
> extctx.lsx.addr  is 7fd92279f010
> extctx.fpu.addr  is 0
> vl        : 0000000000000080
> n is -------------- 3
> After execed LASX instructions xvextrins.d
> pc        : 0000000120000b44
> magic is 41535801
> size is 430
> magic is 0
> size is 0
> extctx.lasx.addr is 7fd92279ee00
> extctx.lsx.addr  is 0
> extctx.fpu.addr  is 0
> vl        : 0000000000000100
> n is -------------- 4
> After execed FPU instructions fadd
> pc        : 0000000120000b44
> magic is 41535801
> size is 430
> magic is 0
> size is 0
> extctx.lasx.addr is 7fd92279ee00
> extctx.lsx.addr  is 0
> extctx.fpu.addr  is 0
> vl        : 0000000000000100
> n is -------------- 5
>
>
> Please review, thanks.
>
> Song Gao (6):
>    target/loongarch: Add env->extctx_flags for user-mode setup extcontext
>    target/loongarch: Add set_vec_extctx to set LSX/LASX instructions
>      extctx_flags
>    linux-user/loongarch64: Fix setup_extcontext alloc wrong fpu_context
>      size
>    linux-user/loongarch64: setup_sigframe() set 'end' context size 0
>    linux-user/loongarch64: Add LSX sigcontext save/restore
>    linux-user/loongarch64: Add LASX sigcontext save/restore
>
>   linux-user/loongarch64/signal.c             | 168 +++++++++++++++++---
>   target/loongarch/cpu.c                      |   2 +
>   target/loongarch/cpu.h                      |   2 +
>   target/loongarch/insn_trans/trans_vec.c.inc |  12 ++
>   target/loongarch/internals.h                |   4 +
>   target/loongarch/translate.c                |   3 +
>   target/loongarch/translate.h                |   1 +
>   7 files changed, 170 insertions(+), 22 deletions(-)
>


