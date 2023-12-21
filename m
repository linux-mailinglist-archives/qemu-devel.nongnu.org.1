Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF0C81B870
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 14:46:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGJN8-0006tP-QH; Thu, 21 Dec 2023 08:45:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guoguangyao18@mails.ucas.ac.cn>)
 id 1rGFVk-0004RV-Ab
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 04:38:37 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <guoguangyao18@mails.ucas.ac.cn>)
 id 1rGFVg-0007Kx-Ln
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 04:38:36 -0500
Received: from nano.. (unknown [123.125.11.122])
 by APP-01 (Coremail) with SMTP id qwCowABXWTF_BoRldMqGAw--.30538S2;
 Thu, 21 Dec 2023 17:34:02 +0800 (CST)
From: guoguangyao <guoguangyao18@mails.ucas.ac.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	pbonzini@redhat.com,
	eduardo@habkost.net
Subject: [PATCH] Signed-off-by: guoguangyao <guoguangyao18@mails.ucas.ac.cn>
Date: Thu, 21 Dec 2023 17:38:05 +0800
Message-Id: <20231221093805.309502-1-guoguangyao18@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowABXWTF_BoRldMqGAw--.30538S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw4UKw13ZF1fJryrAry8AFb_yoWDtrb_CF
 1rKFs3Wr4Yvr1jvF109F15Xr1kAayxtrn2yFsrKay8GFyjkw1DGa1kW3WxZr4xCF4fJrnx
 A3ZxuF1SvrnF9jkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb2kYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28I
 cVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx
 0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF
 04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
 18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
 r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
 1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
 x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8m9aPUUUUU==
X-Originating-IP: [123.125.11.122]
X-CM-SenderInfo: 5jxrw35dqj5trrryqzpdlo2hpxfd2hldfou0/
Received-SPF: pass client-ip=159.226.251.21;
 envelope-from=guoguangyao18@mails.ucas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 21 Dec 2023 08:45:53 -0500
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

target/i386: Eip error in x86_64-softmmu

When closing PCREL, qemu-system-x86_64 run into error.
Eip modification here leads to the result.

Fixes: b5e0d5d22fbf("target/i386: Fix 32-bit wrapping of pc/eip computation")

 Changes to be committed:
	modified:   target/i386/tcg/translate.c
---
 target/i386/tcg/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 037bc47e7c..3dc7781a41 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -566,9 +566,9 @@ static void gen_update_eip_next(DisasContext *s)
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


