Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A5B7F2411
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 03:36:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Gbo-0002OF-HT; Mon, 20 Nov 2023 21:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1r5Gbl-0002Ni-Si
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 21:35:25 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1r5Gbj-0004Gx-1K
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 21:35:25 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxXOpmF1xlGm07AA--.24795S3;
 Tue, 21 Nov 2023 10:35:18 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxH91iF1xlngpIAA--.29634S3; 
 Tue, 21 Nov 2023 10:35:17 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 1/1] tcg/loongarch64: Fix tcg_out_mov() Aborted
Date: Tue, 21 Nov 2023 10:22:19 +0800
Message-Id: <20231121022219.384628-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231121022219.384628-1-gaosong@loongson.cn>
References: <20231121022219.384628-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxH91iF1xlngpIAA--.29634S3
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
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

On LoongArch host,  we got an Aborted from tcg_out_mov().

qemu-x86_64 configure with '--enable-debug'.

> (gdb) b /home1/gaosong/code/qemu/tcg/loongarch64/tcg-target.c.inc:312
> Breakpoint 1 at 0x2576f0: file /home1/gaosong/code/qemu/tcg/loongarch64/tcg-target.c.inc, line 312.
> (gdb) run hello
[...]
> Thread 1 "qemu-x86_64" hit Breakpoint 1, tcg_out_mov (s=0xaaaae91760 <tcg_init_ctx>, type=TCG_TYPE_V128, ret=TCG_REG_V2,
>     arg=TCG_REG_V0) at /home1/gaosong/code/qemu/tcg/loongarch64/tcg-target.c.inc:312
> 312           g_assert_not_reached();
> (gdb) bt
> #0  tcg_out_mov (s=0xaaaae91760 <tcg_init_ctx>, type=TCG_TYPE_V128, ret=TCG_REG_V2, arg=TCG_REG_V0)
>     at /home1/gaosong/code/qemu/tcg/loongarch64/tcg-target.c.inc:312
> #1  0x000000aaaad0fee0 in tcg_reg_alloc_mov (s=0xaaaae91760 <tcg_init_ctx>, op=0xaaaaf67c20) at ../tcg/tcg.c:4632
> #2  0x000000aaaad142f4 in tcg_gen_code (s=0xaaaae91760 <tcg_init_ctx>, tb=0xffe8030340 <code_gen_buffer+197328>,
>     pc_start=4346094) at ../tcg/tcg.c:6135
[...]
> (gdb) c
> Continuing.
> **
> ERROR:/home1/gaosong/code/qemu/tcg/loongarch64/tcg-target.c.inc:312:tcg_out_mov: code should not be reached
> Bail out! ERROR:/home1/gaosong/code/qemu/tcg/loongarch64/tcg-target.c.inc:312:tcg_out_mov: code should not be reached
>
> Thread 1 "qemu-x86_64" received signal SIGABRT, Aborted.
> 0x000000fff7b1c390 in raise () from /lib64/libc.so.6
> (gdb) q

Fixes: 16288ded94 ("tcg/loongarch64: Lower basic tcg vec ops to LSX")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20231120065916.374045-1-gaosong@loongson.cn>
---
 tcg/loongarch64/tcg-target.c.inc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index a588fb3085..bab0a173a3 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -308,6 +308,9 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
          */
         tcg_out_opc_or(s, ret, arg, TCG_REG_ZERO);
         break;
+    case TCG_TYPE_V128:
+        tcg_out_opc_vori_b(s, ret, arg, 0);
+        break;
     default:
         g_assert_not_reached();
     }
-- 
2.25.1


