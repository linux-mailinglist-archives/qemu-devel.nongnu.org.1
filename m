Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D034D753566
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 10:47:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKES4-0003Cx-4w; Fri, 14 Jul 2023 04:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qKERa-0001Vl-FM
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:46:32 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qKERW-0004nM-L7
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:46:30 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxBfFdC7FkR84EAA--.13132S3;
 Fri, 14 Jul 2023 16:46:21 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxzyNYC7FkFOotAA--.22026S10; 
 Fri, 14 Jul 2023 16:46:21 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v3 08/47] target/loongarch: Implement xvsadd/xvssub
Date: Fri, 14 Jul 2023 16:45:36 +0800
Message-Id: <20230714084615.2448038-9-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230714084615.2448038-1-gaosong@loongson.cn>
References: <20230714084615.2448038-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxzyNYC7FkFOotAA--.22026S10
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

This patch includes:
- XVSADD.{B/H/W/D}[U];
- XVSSUB.{B/H/W/D}[U].

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/disas.c                     | 17 +++++++++++++++++
 target/loongarch/insn_trans/trans_lasx.c.inc | 17 +++++++++++++++++
 target/loongarch/insns.decode                | 18 ++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 4e26d49acc..0fd88a56c1 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1748,6 +1748,23 @@ INSN_LASX(xvneg_h,           vv)
 INSN_LASX(xvneg_w,           vv)
 INSN_LASX(xvneg_d,           vv)
 
+INSN_LASX(xvsadd_b,          vvv)
+INSN_LASX(xvsadd_h,          vvv)
+INSN_LASX(xvsadd_w,          vvv)
+INSN_LASX(xvsadd_d,          vvv)
+INSN_LASX(xvsadd_bu,         vvv)
+INSN_LASX(xvsadd_hu,         vvv)
+INSN_LASX(xvsadd_wu,         vvv)
+INSN_LASX(xvsadd_du,         vvv)
+INSN_LASX(xvssub_b,          vvv)
+INSN_LASX(xvssub_h,          vvv)
+INSN_LASX(xvssub_w,          vvv)
+INSN_LASX(xvssub_d,          vvv)
+INSN_LASX(xvssub_bu,         vvv)
+INSN_LASX(xvssub_hu,         vvv)
+INSN_LASX(xvssub_wu,         vvv)
+INSN_LASX(xvssub_du,         vvv)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 0c7d2bbffd..275c6172b4 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -61,6 +61,23 @@ TRANS(xvneg_h, gvec_vv, 32, MO_16, tcg_gen_gvec_neg)
 TRANS(xvneg_w, gvec_vv, 32, MO_32, tcg_gen_gvec_neg)
 TRANS(xvneg_d, gvec_vv, 32, MO_64, tcg_gen_gvec_neg)
 
+TRANS(xvsadd_b, gvec_vvv, 32, MO_8, tcg_gen_gvec_ssadd)
+TRANS(xvsadd_h, gvec_vvv, 32, MO_16, tcg_gen_gvec_ssadd)
+TRANS(xvsadd_w, gvec_vvv, 32, MO_32, tcg_gen_gvec_ssadd)
+TRANS(xvsadd_d, gvec_vvv, 32, MO_64, tcg_gen_gvec_ssadd)
+TRANS(xvsadd_bu, gvec_vvv, 32, MO_8, tcg_gen_gvec_usadd)
+TRANS(xvsadd_hu, gvec_vvv, 32, MO_16, tcg_gen_gvec_usadd)
+TRANS(xvsadd_wu, gvec_vvv, 32, MO_32, tcg_gen_gvec_usadd)
+TRANS(xvsadd_du, gvec_vvv, 32, MO_64, tcg_gen_gvec_usadd)
+TRANS(xvssub_b, gvec_vvv, 32, MO_8, tcg_gen_gvec_sssub)
+TRANS(xvssub_h, gvec_vvv, 32, MO_16, tcg_gen_gvec_sssub)
+TRANS(xvssub_w, gvec_vvv, 32, MO_32, tcg_gen_gvec_sssub)
+TRANS(xvssub_d, gvec_vvv, 32, MO_64, tcg_gen_gvec_sssub)
+TRANS(xvssub_bu, gvec_vvv, 32, MO_8, tcg_gen_gvec_ussub)
+TRANS(xvssub_hu, gvec_vvv, 32, MO_16, tcg_gen_gvec_ussub)
+TRANS(xvssub_wu, gvec_vvv, 32, MO_32, tcg_gen_gvec_ussub)
+TRANS(xvssub_du, gvec_vvv, 32, MO_64, tcg_gen_gvec_ussub)
+
 TRANS(xvreplgr2vr_b, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, gvec_dup, 32, MO_32)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 759172628f..32f857ff7c 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1325,6 +1325,24 @@ xvneg_h          0111 01101001 11000 01101 ..... .....    @vv
 xvneg_w          0111 01101001 11000 01110 ..... .....    @vv
 xvneg_d          0111 01101001 11000 01111 ..... .....    @vv
 
+xvsadd_b         0111 01000100 01100 ..... ..... .....    @vvv
+xvsadd_h         0111 01000100 01101 ..... ..... .....    @vvv
+xvsadd_w         0111 01000100 01110 ..... ..... .....    @vvv
+xvsadd_d         0111 01000100 01111 ..... ..... .....    @vvv
+xvsadd_bu        0111 01000100 10100 ..... ..... .....    @vvv
+xvsadd_hu        0111 01000100 10101 ..... ..... .....    @vvv
+xvsadd_wu        0111 01000100 10110 ..... ..... .....    @vvv
+xvsadd_du        0111 01000100 10111 ..... ..... .....    @vvv
+
+xvssub_b         0111 01000100 10000 ..... ..... .....    @vvv
+xvssub_h         0111 01000100 10001 ..... ..... .....    @vvv
+xvssub_w         0111 01000100 10010 ..... ..... .....    @vvv
+xvssub_d         0111 01000100 10011 ..... ..... .....    @vvv
+xvssub_bu        0111 01000100 11000 ..... ..... .....    @vvv
+xvssub_hu        0111 01000100 11001 ..... ..... .....    @vvv
+xvssub_wu        0111 01000100 11010 ..... ..... .....    @vvv
+xvssub_du        0111 01000100 11011 ..... ..... .....    @vvv
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
-- 
2.39.1


