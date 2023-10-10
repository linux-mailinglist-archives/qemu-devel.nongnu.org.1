Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F177BF19D
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 05:38:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq3Yd-0006Bs-88; Mon, 09 Oct 2023 23:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qq3YZ-00069L-Mx
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 23:37:15 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qq3YT-0005uH-Vp
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 23:37:15 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bx5fDexiRlrIUwAA--.28320S3;
 Tue, 10 Oct 2023 11:37:03 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxP93cxiRl4NgdAA--.64991S2; 
 Tue, 10 Oct 2023 11:37:00 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@redhat.com, laurent@vivier.e,
 maobibo@loongson.cn, yangxiaojuan@loongson.cn, laurent@vivier.eu
Subject: [PATCH v1 0/6] linux-user/loongarch64: Add LSX/LASX sigcontext
Date: Tue, 10 Oct 2023 11:36:55 +0800
Message-Id: <20231010033701.385725-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxP93cxiRl4NgdAA--.64991S2
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

Hi, All.

This series adds save/restore sigcontext. 

We use extctx_flags to choces which sigcontext need save/restore.

The extctx_flags default value is EXTCTX_FLAGS_FPU, we need
save/restore fpu context.

After a LSX/LASX instruction is execed, extctx_flags value change to
EXTCTX_FLAGS_LSX/LASX, we always need save/restore lsx/lasx context.


The test_signal.c is a simple test.

The default vreg len is 64. After execed a LSX instruction, the vreg len is 
128, and then we exec a FPU instruction, the vreg len is also 128. After
execed a LASX instruction, the vreg len is 256, and then we exec a FPU
instruction, the vreg len is also 256.

test_signal.c:

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
        struct _ctx_layout lasx;
        struct _ctx_layout end;
};
static int parse_extcontext(struct sigcontext *sc, struct extctx_layout *extctx)
{
    uint32_t magic, size;
    struct sctx_info *info = (struct sctx_info *)&sc->sc_extcontext;

    while(1) {
        magic = (uint32_t)info->magic;
        size =  (uint32_t)info->size;

        printf("magic is %lx\n", magic);
        printf("size is %lx\n", size);
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
        case LASX_CTX_MAGIC:
            if (size < (sizeof(struct sctx_info) +
                        sizeof(struct lasx_context))) {
                return -1;
            }
            extctx->lasx.addr = info;
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
    int i;
    struct ucontext *uc = (struct ucontext *)ucontext;
    struct extctx_layout extctx;

    memset(&extctx, 0, sizeof(struct extctx_layout));

    printf("pc        : %016lx\n", uc->uc_mcontext.sc_pc);

    parse_extcontext(&uc->uc_mcontext, &extctx);

    if (n < 5) {
        printf("extctx.lasx.addr is %lx\n", extctx.lasx.addr);
        printf("extctx.lsx.addr  is %lx\n", extctx.lsx.addr);
        printf("extctx.fpu.addr  is %lx\n", extctx.fpu.addr);

        if (extctx.lasx.addr) {
            struct sctx_info *info = extctx.lasx.addr;
            struct lasx_context *lasx_ctx = (struct lasx_context *)((char *)info +
                                            sizeof(struct sctx_info));
            printf("vl        : %016lx\n", 256);
        } else if (extctx.lsx.addr) {
            struct sctx_info *info = extctx.lsx.addr;
            struct lsx_context *lsx_ctx = (struct lsx_context *)((char *)info +
                                          sizeof(struct sctx_info));
            printf("vl        : %016lx\n", 128);
        } else if (extctx.fpu.addr) {
            struct sctx_info *info = extctx.fpu.addr;
            struct fpu_context *fpu_ctx = (struct fpu_context *)((char *)info +
                                          sizeof(struct sctx_info));
            printf("vl        : %016lx\n", 64);
        }
    }
    n++;

    printf("n is -------------- %d\n", n);
    if (n == 1) {
        // vaddwev.w.hu    $vr27, $vr22, $vr29
        asm volatile(".word 0x702ef6db");
        printf("After execed LSX instructons  vaddwev.w.hu\n");
    }

    if (n == 2) {
        // 0101395e        fadd.d          $fs6, $ft2, $ft6
        asm volatile(".word 0x0101395e");
        printf("After execed FPU instructions fadd\n");
    }

    if (n == 3) {
        // xvextrins.d     $xr13, $xr15, 0x59
        asm volatile(".word 0x778165ed");
        printf("After execed LASX instructions xvextrins.d\n");
    }

    if (n == 4) {
        // 0101395e        fadd.d          $fs6, $ft2, $ft6
        asm volatile(".word 0x0101395e");
        printf("After execed FPU instructions fadd\n");
    }

    if (n == 5) {
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


On 3A5000 machine:

[root@archlinux LASX]# ./test_signal 
pc        : 0000000120000b44
magic is 46505501
size is 120
magic is 0
size is 0
extctx.lasx.addr is 0
extctx.lsx.addr  is 0
extctx.fpu.addr  is 7ffffbdd2120
vl        : 0000000000000040
n is -------------- 1
After execed LSX instructons  vaddwev.w.hu
pc        : 0000000120000b44
magic is 53580001
size is 220
magic is 0
size is 0
extctx.lasx.addr is 0
extctx.lsx.addr  is 7ffffbdd2020
extctx.fpu.addr  is 0
vl        : 0000000000000080
n is -------------- 2
After execed FPU instructions fadd
pc        : 0000000120000b44
magic is 53580001
size is 220
magic is 0
size is 0
extctx.lasx.addr is 0
extctx.lsx.addr  is 7ffffbdd2020
extctx.fpu.addr  is 0
vl        : 0000000000000080
n is -------------- 3
After execed LASX instructions xvextrins.d
pc        : 0000000120000b44
magic is 41535801
size is 430
magic is 0
size is 0
extctx.lasx.addr is 7ffffbdd1e10
extctx.lsx.addr  is 0
extctx.fpu.addr  is 0
vl        : 0000000000000100
n is -------------- 4
After execed FPU instructions fadd
pc        : 0000000120000b44
magic is 41535801
size is 430
magic is 0
size is 0
extctx.lasx.addr is 7ffffbdd1e10
extctx.lsx.addr  is 0
extctx.fpu.addr  is 0
vl        : 0000000000000100
n is -------------- 5

QEMU user-mode on X86:

root@loongson-KVM:~/work/code/qemu# ./build/qemu-loongarch64 test_signal
pc        : 0000000120000b44
magic is 46505501
size is 120
magic is 0
size is 0
extctx.lasx.addr is 0
extctx.lsx.addr  is 0
extctx.fpu.addr  is 7fd92279f110
vl        : 0000000000000040
n is -------------- 1
After exec LSX instructons  vaddwev.w.hu
pc        : 0000000120000b44
magic is 53580001
size is 220
magic is 0
size is 0
extctx.lasx.addr is 0
extctx.lsx.addr  is 7fd92279f010
extctx.fpu.addr  is 0
vl        : 0000000000000080
n is -------------- 2
After execed FPU instructions fadd
pc        : 0000000120000b44
magic is 53580001
size is 220
magic is 0
size is 0
extctx.lasx.addr is 0
extctx.lsx.addr  is 7fd92279f010
extctx.fpu.addr  is 0
vl        : 0000000000000080
n is -------------- 3
After execed LASX instructions xvextrins.d
pc        : 0000000120000b44
magic is 41535801
size is 430
magic is 0
size is 0
extctx.lasx.addr is 7fd92279ee00
extctx.lsx.addr  is 0
extctx.fpu.addr  is 0
vl        : 0000000000000100
n is -------------- 4
After execed FPU instructions fadd
pc        : 0000000120000b44
magic is 41535801
size is 430
magic is 0
size is 0
extctx.lasx.addr is 7fd92279ee00
extctx.lsx.addr  is 0
extctx.fpu.addr  is 0
vl        : 0000000000000100
n is -------------- 5


Please review, thanks.

Song Gao (6):
  target/loongarch: Add env->extctx_flags for user-mode setup extcontext
  target/loongarch: Add set_vec_extctx to set LSX/LASX instructions
    extctx_flags
  linux-user/loongarch64: Fix setup_extcontext alloc wrong fpu_context
    size
  linux-user/loongarch64: setup_sigframe() set 'end' context size 0
  linux-user/loongarch64: Add LSX sigcontext save/restore
  linux-user/loongarch64: Add LASX sigcontext save/restore

 linux-user/loongarch64/signal.c             | 168 +++++++++++++++++---
 target/loongarch/cpu.c                      |   2 +
 target/loongarch/cpu.h                      |   2 +
 target/loongarch/insn_trans/trans_vec.c.inc |  12 ++
 target/loongarch/internals.h                |   4 +
 target/loongarch/translate.c                |   3 +
 target/loongarch/translate.h                |   1 +
 7 files changed, 170 insertions(+), 22 deletions(-)

-- 
2.25.1


