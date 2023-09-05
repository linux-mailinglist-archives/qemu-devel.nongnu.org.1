Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A987922B7
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 14:40:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdVLC-00035a-FJ; Tue, 05 Sep 2023 08:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qdVL8-00035R-Vm
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 08:39:30 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qdVL4-0003Tw-R9
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 08:39:30 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxIvBxIfdkApQfAA--.63020S3;
 Tue, 05 Sep 2023 20:39:13 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxJ81uIfdk7OZsAA--.64018S2; 
 Tue, 05 Sep 2023 20:39:12 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, c@jia.je, philmd@linaro.org,
 maobibo@loongson.cn, yangxiaojuan@loongson.cn
Subject: [PATCH v1 1/1] target/loongarch: Add preldx instruction
Date: Tue,  5 Sep 2023 20:39:10 +0800
Message-Id: <20230905123910.3052023-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxJ81uIfdk7OZsAA--.64018S2
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

Resolve the issue of starting the Loongnix 20.5[1] system failure.

Logs:
    Loading Linux 4.19.0-19-loongson-3 ...
    Loading initial ramdisk ...
    PROGRESS CODE: V02010004 I0
    PROGRESS CODE: V03101019 I0
    Error: unknown opcode. 90000000003a3e6c: 0x382c6d82

[1] http://pkg.loongnix.cn/loongnix/isos/Loongnix-20.5/Loongnix-20.5.cartoon.gui.loongarch64.en.qcow2

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/insns.decode                  | 3 +++
 target/loongarch/disas.c                       | 7 +++++++
 target/loongarch/insn_trans/trans_memory.c.inc | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index c9c3bc2c73..56db653603 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -24,6 +24,7 @@
 &rrr          rd rj rk
 &rr_i         rd rj imm
 &hint_r_i     hint rj imm
+&hint_rr      hint rj rk
 &rrr_sa       rd rj rk sa
 &rr_ms_ls     rd rj ms ls
 &ff           fd fj
@@ -69,6 +70,7 @@
 @rr_i16                     .... .. imm:s16 rj:5 rd:5    &rr_i
 @rr_i16s2         .... ..  ................ rj:5 rd:5    &rr_i imm=%offs16
 @hint_r_i12           .... ...... imm:s12 rj:5 hint:5    &hint_r_i
+@hint_rr         .... ........ ..... rk:5 rj:5 hint:5    &hint_rr
 @rrr_sa2p1        .... ........ ... .. rk:5 rj:5 rd:5    &rrr_sa  sa=%sa2p1
 @rrr_sa2        .... ........ ... sa:2 rk:5 rj:5 rd:5    &rrr_sa
 @rrr_sa3         .... ........ .. sa:3 rk:5 rj:5 rd:5    &rrr_sa
@@ -228,6 +230,7 @@ ldx_bu          0011 10000010 00000 ..... ..... .....    @rrr
 ldx_hu          0011 10000010 01000 ..... ..... .....    @rrr
 ldx_wu          0011 10000010 10000 ..... ..... .....    @rrr
 preld           0010 101011 ............ ..... .....     @hint_r_i12
+preldx          0011 10000010 11000 ..... ..... .....    @hint_rr
 dbar            0011 10000111 00100 ...............      @i15
 ibar            0011 10000111 00101 ...............      @i15
 ldptr_w         0010 0100 .............. ..... .....     @rr_i14s2
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 5c402d944d..d5ea8f7140 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -190,6 +190,12 @@ static void output_hint_r_i(DisasContext *ctx, arg_hint_r_i *a,
     output(ctx, mnemonic, "%d, r%d, %d", a->hint, a->rj, a->imm);
 }
 
+static void output_hint_rr(DisasContext *ctx, arg_hint_rr *a,
+                           const char *mnemonic)
+{
+    output(ctx, mnemonic, "%d, r%d, r%d", a->hint, a->rj, a->rk);
+}
+
 static void output_i(DisasContext *ctx, arg_i *a, const char *mnemonic)
 {
     output(ctx, mnemonic, "%d", a->imm);
@@ -549,6 +555,7 @@ INSN(ld_bu,        rr_i)
 INSN(ld_hu,        rr_i)
 INSN(ld_wu,        rr_i)
 INSN(preld,        hint_r_i)
+INSN(preldx,       hint_rr)
 INSN(fld_s,        fr_i)
 INSN(fst_s,        fr_i)
 INSN(fld_d,        fr_i)
diff --git a/target/loongarch/insn_trans/trans_memory.c.inc b/target/loongarch/insn_trans/trans_memory.c.inc
index d9d062235a..ca7378c79d 100644
--- a/target/loongarch/insn_trans/trans_memory.c.inc
+++ b/target/loongarch/insn_trans/trans_memory.c.inc
@@ -110,6 +110,11 @@ static bool trans_preld(DisasContext *ctx, arg_preld *a)
     return true;
 }
 
+static bool trans_preldx(DisasContext *ctx, arg_preldx * a)
+{
+    return true;
+}
+
 static bool trans_dbar(DisasContext *ctx, arg_dbar * a)
 {
     tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
-- 
2.39.1


