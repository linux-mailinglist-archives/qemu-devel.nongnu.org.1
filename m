Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 692B77F0CA3
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 08:14:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4ySN-0003ZR-CV; Mon, 20 Nov 2023 02:12:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1r4ySJ-0003Y8-0S
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 02:12:27 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1r4ySG-0002BM-C2
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 02:12:26 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxqOrOBltlAyg7AA--.15591S3;
 Mon, 20 Nov 2023 15:12:14 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cx7y_MBltluFNHAA--.25125S2; 
 Mon, 20 Nov 2023 15:12:12 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, git@xen0n.name, c@jia.je,
 maobibo@loongson.cn
Subject: [PATCH 1/1] tcg/loongarch64: Fix tcg_out_mov() Aborted
Date: Mon, 20 Nov 2023 14:59:16 +0800
Message-Id: <20231120065916.374045-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx7y_MBltluFNHAA--.25125S2
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

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 tcg/loongarch64/tcg-target.c.inc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index a588fb3085..5f68040230 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -308,6 +308,9 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
          */
         tcg_out_opc_or(s, ret, arg, TCG_REG_ZERO);
         break;
+    case TCG_TYPE_V128:
+        tcg_out_opc_vaddi_du(s, ret, arg, 0);
+        break;
     default:
         g_assert_not_reached();
     }
-- 
2.25.1


