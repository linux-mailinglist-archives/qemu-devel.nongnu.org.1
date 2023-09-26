Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD667AE73A
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 09:59:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql2xs-0005E3-2o; Tue, 26 Sep 2023 03:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1ql2xn-0005D9-EQ
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 03:58:35 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1ql2xh-0006Wt-Hv
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 03:58:33 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cxh+gfjxJl25MsAA--.49662S3;
 Tue, 26 Sep 2023 15:58:23 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxvdwdjxJl4HYSAA--.37865S2; 
 Tue, 26 Sep 2023 15:58:21 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, c@jia.je, philmd@redhat.com, git@xen0n.name,
 yangxiaojuan@loongson.cn, maobibo@loongson.cn,
 gaosong <gaosong@loongson.cn>
Subject: [PATCH 1/1] tcg/loongarch64: Fix buid error
Date: Tue, 26 Sep 2023 15:58:19 +0800
Message-Id: <20230926075819.3602537-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxvdwdjxJl4HYSAA--.37865S2
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

From: gaosong <gaosong@loongson.cn>

Fix:

  In file included from ../tcg/tcg.c:735:
  /home1/gaosong/bugfix/qemu/tcg/loongarch64/tcg-target.c.inc: In function ‘tcg_out_vec_op’:
  /home1/gaosong/bugfix/qemu/tcg/loongarch64/tcg-target.c.inc:1855:9: error: a label can only be part of a statement and a declaration is not a statement
           TCGCond cond = args[3];
           ^~~~~~~

Signed-off-by: gaosong <gaosong@loongson.cn>
---
 tcg/loongarch64/tcg-target.c.inc | 68 ++++++++++++++++----------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index b701df50db..8f7091002b 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1852,43 +1852,45 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out_opc_vnor_v(s, a0, a1, a1);
         break;
     case INDEX_op_cmp_vec:
-        TCGCond cond = args[3];
-        if (const_args[2]) {
-            /*
-             * cmp_vec dest, src, value
-             * Try vseqi/vslei/vslti
-             */
-            int64_t value = sextract64(a2, 0, 8 << vece);
-            if ((cond == TCG_COND_EQ || cond == TCG_COND_LE || \
-                 cond == TCG_COND_LT) && (-0x10 <= value && value <= 0x0f)) {
-                tcg_out32(s, encode_vdvjsk5_insn(cmp_vec_imm_insn[cond][vece], \
-                                                 a0, a1, value));
-                break;
-            } else if ((cond == TCG_COND_LEU || cond == TCG_COND_LTU) &&
-                (0x00 <= value && value <= 0x1f)) {
-                tcg_out32(s, encode_vdvjuk5_insn(cmp_vec_imm_insn[cond][vece], \
-                                                 a0, a1, value));
-                break;
-            }
+        {
+            TCGCond cond = args[3];
+            if (const_args[2]) {
+                /*
+                 * cmp_vec dest, src, value
+                 * Try vseqi/vslei/vslti
+                 */
+                int64_t value = sextract64(a2, 0, 8 << vece);
+                if ((cond == TCG_COND_EQ || cond == TCG_COND_LE || \
+                     cond == TCG_COND_LT) && (-0x10 <= value && value <= 0x0f)) {
+                    tcg_out32(s, encode_vdvjsk5_insn(cmp_vec_imm_insn[cond][vece], \
+                                                     a0, a1, value));
+                    break;
+                } else if ((cond == TCG_COND_LEU || cond == TCG_COND_LTU) &&
+                    (0x00 <= value && value <= 0x1f)) {
+                    tcg_out32(s, encode_vdvjuk5_insn(cmp_vec_imm_insn[cond][vece], \
+                                                     a0, a1, value));
+                    break;
+                }
 
-            /*
-             * Fallback to:
-             * dupi_vec temp, a2
-             * cmp_vec a0, a1, temp, cond
-             */
-            tcg_out_dupi_vec(s, type, vece, temp_vec, a2);
-            a2 = temp_vec;
-        }
+                /*
+                 * Fallback to:
+                 * dupi_vec temp, a2
+                 * cmp_vec a0, a1, temp, cond
+                 */
+                tcg_out_dupi_vec(s, type, vece, temp_vec, a2);
+                a2 = temp_vec;
+            }
 
-        insn = cmp_vec_insn[cond][vece];
-        if (insn == 0) {
-            TCGArg t;
-            t = a1, a1 = a2, a2 = t;
-            cond = tcg_swap_cond(cond);
             insn = cmp_vec_insn[cond][vece];
-            tcg_debug_assert(insn != 0);
+            if (insn == 0) {
+                TCGArg t;
+                t = a1, a1 = a2, a2 = t;
+                cond = tcg_swap_cond(cond);
+                insn = cmp_vec_insn[cond][vece];
+                tcg_debug_assert(insn != 0);
+            }
+            tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
         }
-        tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
         break;
     case INDEX_op_add_vec:
         tcg_out_addsub_vec(s, vece, a0, a1, a2, const_args[2], true);
-- 
2.39.3


