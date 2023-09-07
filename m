Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 258C17970A9
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 10:12:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeA5A-0003v7-NU; Thu, 07 Sep 2023 04:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qeA4t-0003ub-5f
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:09:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qeA4p-0003L3-12
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:09:26 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxVugvhflkQzQhAA--.31073S3;
 Thu, 07 Sep 2023 16:09:19 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxviMthflkXE1wAA--.31585S4; 
 Thu, 07 Sep 2023 16:09:18 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH v5 02/57] target/loongarch: Implement gvec_*_vl functions
Date: Thu,  7 Sep 2023 16:08:21 +0800
Message-Id: <20230907080916.3974502-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230907080916.3974502-1-gaosong@loongson.cn>
References: <20230907080916.3974502-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxviMthflkXE1wAA--.31585S4
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

Using gvec_*_vl functions hides oprsz. We can use gvec_v* for oprsz 16.
and gvec_v* for oprsz 32.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/insn_trans/trans_vec.c.inc | 68 +++++++++++++--------
 1 file changed, 44 insertions(+), 24 deletions(-)

diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index aed5bac5bc..aeeb2df41c 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -76,34 +76,58 @@ static bool gen_cv(DisasContext *ctx, arg_cv *a,
     return true;
 }
 
+static bool gvec_vvv_vl(DisasContext *ctx, arg_vvv *a,
+                        uint32_t oprsz, MemOp mop,
+                        void (*func)(unsigned, uint32_t, uint32_t,
+                                     uint32_t, uint32_t, uint32_t))
+{
+    uint32_t vd_ofs = vec_full_offset(a->vd);
+    uint32_t vj_ofs = vec_full_offset(a->vj);
+    uint32_t vk_ofs = vec_full_offset(a->vk);
+
+    func(mop, vd_ofs, vj_ofs, vk_ofs, oprsz, ctx->vl / 8);
+    return true;
+}
+
 static bool gvec_vvv(DisasContext *ctx, arg_vvv *a, MemOp mop,
                      void (*func)(unsigned, uint32_t, uint32_t,
                                   uint32_t, uint32_t, uint32_t))
 {
-    uint32_t vd_ofs, vj_ofs, vk_ofs;
-
     CHECK_SXE;
+    return gvec_vvv_vl(ctx, a, 16, mop, func);
+}
 
-    vd_ofs = vec_full_offset(a->vd);
-    vj_ofs = vec_full_offset(a->vj);
-    vk_ofs = vec_full_offset(a->vk);
 
-    func(mop, vd_ofs, vj_ofs, vk_ofs, 16, ctx->vl/8);
+static bool gvec_vv_vl(DisasContext *ctx, arg_vv *a,
+                       uint32_t oprsz, MemOp mop,
+                       void (*func)(unsigned, uint32_t, uint32_t,
+                                    uint32_t, uint32_t))
+{
+    uint32_t vd_ofs = vec_full_offset(a->vd);
+    uint32_t vj_ofs = vec_full_offset(a->vj);
+
+    func(mop, vd_ofs, vj_ofs, oprsz, ctx->vl / 8);
     return true;
 }
 
+
 static bool gvec_vv(DisasContext *ctx, arg_vv *a, MemOp mop,
                     void (*func)(unsigned, uint32_t, uint32_t,
                                  uint32_t, uint32_t))
 {
-    uint32_t vd_ofs, vj_ofs;
-
     CHECK_SXE;
+    return gvec_vv_vl(ctx, a, 16, mop, func);
+}
 
-    vd_ofs = vec_full_offset(a->vd);
-    vj_ofs = vec_full_offset(a->vj);
+static bool gvec_vv_i_vl(DisasContext *ctx, arg_vv_i *a,
+                         uint32_t oprsz, MemOp mop,
+                         void (*func)(unsigned, uint32_t, uint32_t,
+                                      int64_t, uint32_t, uint32_t))
+{
+    uint32_t vd_ofs = vec_full_offset(a->vd);
+    uint32_t vj_ofs = vec_full_offset(a->vj);
 
-    func(mop, vd_ofs, vj_ofs, 16, ctx->vl/8);
+    func(mop, vd_ofs, vj_ofs, a->imm, oprsz, ctx->vl / 8);
     return true;
 }
 
@@ -111,28 +135,24 @@ static bool gvec_vv_i(DisasContext *ctx, arg_vv_i *a, MemOp mop,
                       void (*func)(unsigned, uint32_t, uint32_t,
                                    int64_t, uint32_t, uint32_t))
 {
-    uint32_t vd_ofs, vj_ofs;
-
     CHECK_SXE;
+    return gvec_vv_i_vl(ctx, a, 16, mop, func);
+}
 
-    vd_ofs = vec_full_offset(a->vd);
-    vj_ofs = vec_full_offset(a->vj);
+static bool gvec_subi_vl(DisasContext *ctx, arg_vv_i *a,
+                         uint32_t oprsz, MemOp mop)
+{
+    uint32_t vd_ofs = vec_full_offset(a->vd);
+    uint32_t vj_ofs = vec_full_offset(a->vj);
 
-    func(mop, vd_ofs, vj_ofs, a->imm , 16, ctx->vl/8);
+    tcg_gen_gvec_addi(mop, vd_ofs, vj_ofs, -a->imm, oprsz, ctx->vl / 8);
     return true;
 }
 
 static bool gvec_subi(DisasContext *ctx, arg_vv_i *a, MemOp mop)
 {
-    uint32_t vd_ofs, vj_ofs;
-
     CHECK_SXE;
-
-    vd_ofs = vec_full_offset(a->vd);
-    vj_ofs = vec_full_offset(a->vj);
-
-    tcg_gen_gvec_addi(mop, vd_ofs, vj_ofs, -a->imm, 16, ctx->vl/8);
-    return true;
+    return gvec_subi_vl(ctx, a, 16, mop);
 }
 
 TRANS(vadd_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_add)
-- 
2.39.1


