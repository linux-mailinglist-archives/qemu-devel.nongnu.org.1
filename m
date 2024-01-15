Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE51982D30E
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 03:10:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPCPC-0003Vg-Q1; Sun, 14 Jan 2024 21:08:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guoguangyao18@mails.ucas.ac.cn>)
 id 1rPCP9-0003VP-3M
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 21:08:47 -0500
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <guoguangyao18@mails.ucas.ac.cn>)
 id 1rPCP6-0001ZD-5h
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 21:08:46 -0500
Received: from nano.loongson.cn (unknown [123.125.11.126])
 by APP-03 (Coremail) with SMTP id rQCowABnbrqSk6Rl5OBrBg--.43262S2;
 Mon, 15 Jan 2024 10:08:30 +0800 (CST)
From: guoguangyao <guoguangyao18@mails.ucas.ac.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, eduardo@habkost.net,
 guoguangyao <guoguangyao18@mails.ucas.ac.cn>
Subject: [PATCH] target/i386: Eip error in x86_64-softmmu
Date: Mon, 15 Jan 2024 10:08:04 +0800
Message-Id: <20240115020804.30272-1-guoguangyao18@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABnbrqSk6Rl5OBrBg--.43262S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw4UKw13ZF4DZr1ftF1DKFg_yoWkWFb_AF
 4fJrs7Wr40vr1jvF10kr15Xr10ya1ftr1vyrsrKay8GF1j9r4DJa1kW3yxZrs7CF4fXr9x
 AwnxuF1a9r1a9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb4kFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
 Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
 1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
 Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JV
 WxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
 0VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
 AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
 c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
 AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
 Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU0_-PUU
 UUU
X-Originating-IP: [123.125.11.126]
X-CM-SenderInfo: 5jxrw35dqj5trrryqzpdlo2hpxfd2hldfou0/
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=guoguangyao18@mails.ucas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When closing PCREL, qemu-system-x86_64 run into error.
Eip modification here leads to the result. Using s->pc
in func gen_update_eip_next() solves the problem.

Fixes: b5e0d5d22fbf("target/i386: Fix 32-bit wrapping of pc/eip computation")

Signed-off-by: guoguangyao <guoguangyao18@mails.ucas.ac.cn>

	modified:   target/i386/tcg/translate.c
---
 target/i386/tcg/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index e1eb82a5c6..6f57d5a8a5 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -567,9 +567,9 @@ static void gen_update_eip_next(DisasContext *s)
     if (tb_cflags(s->base.tb) & CF_PCREL) {
         tcg_gen_addi_tl(cpu_eip, cpu_eip, s->pc - s->pc_save);
     } else if (CODE64(s)) {
-        tcg_gen_movi_tl(cpu_eip, s->base.pc_next);
+        tcg_gen_movi_tl(cpu_eip, s->pc);
     } else {
-        tcg_gen_movi_tl(cpu_eip, (uint32_t)(s->base.pc_next - s->cs_base));
+        tcg_gen_movi_tl(cpu_eip, (uint32_t)(s->pc - s->cs_base));
     }
     s->pc_save = s->pc;
 }
-- 
2.34.1


