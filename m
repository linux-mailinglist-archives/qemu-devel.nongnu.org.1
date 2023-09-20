Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE7D7A7347
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 08:55:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qir5t-0003w9-8R; Wed, 20 Sep 2023 02:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qir5q-0003t8-LQ
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 02:53:50 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qir5n-0004QI-T1
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 02:53:50 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cxh+iZlgplxS8qAA--.45392S3;
 Wed, 20 Sep 2023 14:52:09 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dxzdx7lgplhVYMAA--.24315S37; 
 Wed, 20 Sep 2023 14:52:09 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 35/57] target/loongarch: Implement xvsll xvsrl xvsra xvrotr
Date: Wed, 20 Sep 2023 14:51:17 +0800
Message-Id: <20230920065139.1403868-36-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230920065139.1403868-1-gaosong@loongson.cn>
References: <20230920065139.1403868-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxzdx7lgplhVYMAA--.24315S37
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

This patch includes:
- XVSLL[I].{B/H/W/D};
- XVSRL[I].{B/H/W/D};
- XVSRA[I].{B/H/W/D};
- XVROTR[I].{B/H/W/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230914022645.1151356-36-gaosong@loongson.cn>
---
 target/loongarch/insns.decode               | 33 +++++++++++++++++++
 target/loongarch/disas.c                    | 36 +++++++++++++++++++++
 target/loongarch/insn_trans/trans_vec.c.inc | 32 ++++++++++++++++++
 3 files changed, 101 insertions(+)

diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index fb28666577..fb7bd9fb34 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1619,6 +1619,39 @@ xvori_b          0111 01111101 01 ........ ..... .....    @vv_ui8
 xvxori_b         0111 01111101 10 ........ ..... .....    @vv_ui8
 xvnori_b         0111 01111101 11 ........ ..... .....    @vv_ui8
 
+xvsll_b          0111 01001110 10000 ..... ..... .....    @vvv
+xvsll_h          0111 01001110 10001 ..... ..... .....    @vvv
+xvsll_w          0111 01001110 10010 ..... ..... .....    @vvv
+xvsll_d          0111 01001110 10011 ..... ..... .....    @vvv
+xvslli_b         0111 01110010 11000 01 ... ..... .....   @vv_ui3
+xvslli_h         0111 01110010 11000 1 .... ..... .....   @vv_ui4
+xvslli_w         0111 01110010 11001 ..... ..... .....    @vv_ui5
+xvslli_d         0111 01110010 1101 ...... ..... .....    @vv_ui6
+xvsrl_b          0111 01001110 10100 ..... ..... .....    @vvv
+xvsrl_h          0111 01001110 10101 ..... ..... .....    @vvv
+xvsrl_w          0111 01001110 10110 ..... ..... .....    @vvv
+xvsrl_d          0111 01001110 10111 ..... ..... .....    @vvv
+xvsrli_b         0111 01110011 00000 01 ... ..... .....   @vv_ui3
+xvsrli_h         0111 01110011 00000 1 .... ..... .....   @vv_ui4
+xvsrli_w         0111 01110011 00001 ..... ..... .....    @vv_ui5
+xvsrli_d         0111 01110011 0001 ...... ..... .....    @vv_ui6
+xvsra_b          0111 01001110 11000 ..... ..... .....    @vvv
+xvsra_h          0111 01001110 11001 ..... ..... .....    @vvv
+xvsra_w          0111 01001110 11010 ..... ..... .....    @vvv
+xvsra_d          0111 01001110 11011 ..... ..... .....    @vvv
+xvsrai_b         0111 01110011 01000 01 ... ..... .....   @vv_ui3
+xvsrai_h         0111 01110011 01000 1 .... ..... .....   @vv_ui4
+xvsrai_w         0111 01110011 01001 ..... ..... .....    @vv_ui5
+xvsrai_d         0111 01110011 0101 ...... ..... .....    @vv_ui6
+xvrotr_b         0111 01001110 11100 ..... ..... .....    @vvv
+xvrotr_h         0111 01001110 11101 ..... ..... .....    @vvv
+xvrotr_w         0111 01001110 11110 ..... ..... .....    @vvv
+xvrotr_d         0111 01001110 11111 ..... ..... .....    @vvv
+xvrotri_b        0111 01101010 00000 01 ... ..... .....   @vv_ui3
+xvrotri_h        0111 01101010 00000 1 .... ..... .....   @vv_ui4
+xvrotri_w        0111 01101010 00001 ..... ..... .....    @vv_ui5
+xvrotri_d        0111 01101010 0001 ...... ..... .....    @vv_ui6
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index e9adc017db..209ae230f4 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2041,6 +2041,42 @@ INSN_LASX(xvori_b,           vv_i)
 INSN_LASX(xvxori_b,          vv_i)
 INSN_LASX(xvnori_b,          vv_i)
 
+INSN_LASX(xvsll_b,           vvv)
+INSN_LASX(xvsll_h,           vvv)
+INSN_LASX(xvsll_w,           vvv)
+INSN_LASX(xvsll_d,           vvv)
+INSN_LASX(xvslli_b,          vv_i)
+INSN_LASX(xvslli_h,          vv_i)
+INSN_LASX(xvslli_w,          vv_i)
+INSN_LASX(xvslli_d,          vv_i)
+
+INSN_LASX(xvsrl_b,           vvv)
+INSN_LASX(xvsrl_h,           vvv)
+INSN_LASX(xvsrl_w,           vvv)
+INSN_LASX(xvsrl_d,           vvv)
+INSN_LASX(xvsrli_b,          vv_i)
+INSN_LASX(xvsrli_h,          vv_i)
+INSN_LASX(xvsrli_w,          vv_i)
+INSN_LASX(xvsrli_d,          vv_i)
+
+INSN_LASX(xvsra_b,           vvv)
+INSN_LASX(xvsra_h,           vvv)
+INSN_LASX(xvsra_w,           vvv)
+INSN_LASX(xvsra_d,           vvv)
+INSN_LASX(xvsrai_b,          vv_i)
+INSN_LASX(xvsrai_h,          vv_i)
+INSN_LASX(xvsrai_w,          vv_i)
+INSN_LASX(xvsrai_d,          vv_i)
+
+INSN_LASX(xvrotr_b,          vvv)
+INSN_LASX(xvrotr_h,          vvv)
+INSN_LASX(xvrotr_w,          vvv)
+INSN_LASX(xvrotr_d,          vvv)
+INSN_LASX(xvrotri_b,         vv_i)
+INSN_LASX(xvrotri_h,         vv_i)
+INSN_LASX(xvrotri_w,         vv_i)
+INSN_LASX(xvrotri_d,         vv_i)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index 5b14d0f894..24743dbc97 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -3649,6 +3649,14 @@ TRANS(vslli_b, LSX, gvec_vv_i, MO_8, tcg_gen_gvec_shli)
 TRANS(vslli_h, LSX, gvec_vv_i, MO_16, tcg_gen_gvec_shli)
 TRANS(vslli_w, LSX, gvec_vv_i, MO_32, tcg_gen_gvec_shli)
 TRANS(vslli_d, LSX, gvec_vv_i, MO_64, tcg_gen_gvec_shli)
+TRANS(xvsll_b, LASX, gvec_xxx, MO_8, tcg_gen_gvec_shlv)
+TRANS(xvsll_h, LASX, gvec_xxx, MO_16, tcg_gen_gvec_shlv)
+TRANS(xvsll_w, LASX, gvec_xxx, MO_32, tcg_gen_gvec_shlv)
+TRANS(xvsll_d, LASX, gvec_xxx, MO_64, tcg_gen_gvec_shlv)
+TRANS(xvslli_b, LASX, gvec_xx_i, MO_8, tcg_gen_gvec_shli)
+TRANS(xvslli_h, LASX, gvec_xx_i, MO_16, tcg_gen_gvec_shli)
+TRANS(xvslli_w, LASX, gvec_xx_i, MO_32, tcg_gen_gvec_shli)
+TRANS(xvslli_d, LASX, gvec_xx_i, MO_64, tcg_gen_gvec_shli)
 
 TRANS(vsrl_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_shrv)
 TRANS(vsrl_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_shrv)
@@ -3658,6 +3666,14 @@ TRANS(vsrli_b, LSX, gvec_vv_i, MO_8, tcg_gen_gvec_shri)
 TRANS(vsrli_h, LSX, gvec_vv_i, MO_16, tcg_gen_gvec_shri)
 TRANS(vsrli_w, LSX, gvec_vv_i, MO_32, tcg_gen_gvec_shri)
 TRANS(vsrli_d, LSX, gvec_vv_i, MO_64, tcg_gen_gvec_shri)
+TRANS(xvsrl_b, LASX, gvec_xxx, MO_8, tcg_gen_gvec_shrv)
+TRANS(xvsrl_h, LASX, gvec_xxx, MO_16, tcg_gen_gvec_shrv)
+TRANS(xvsrl_w, LASX, gvec_xxx, MO_32, tcg_gen_gvec_shrv)
+TRANS(xvsrl_d, LASX, gvec_xxx, MO_64, tcg_gen_gvec_shrv)
+TRANS(xvsrli_b, LASX, gvec_xx_i, MO_8, tcg_gen_gvec_shri)
+TRANS(xvsrli_h, LASX, gvec_xx_i, MO_16, tcg_gen_gvec_shri)
+TRANS(xvsrli_w, LASX, gvec_xx_i, MO_32, tcg_gen_gvec_shri)
+TRANS(xvsrli_d, LASX, gvec_xx_i, MO_64, tcg_gen_gvec_shri)
 
 TRANS(vsra_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_sarv)
 TRANS(vsra_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_sarv)
@@ -3667,6 +3683,14 @@ TRANS(vsrai_b, LSX, gvec_vv_i, MO_8, tcg_gen_gvec_sari)
 TRANS(vsrai_h, LSX, gvec_vv_i, MO_16, tcg_gen_gvec_sari)
 TRANS(vsrai_w, LSX, gvec_vv_i, MO_32, tcg_gen_gvec_sari)
 TRANS(vsrai_d, LSX, gvec_vv_i, MO_64, tcg_gen_gvec_sari)
+TRANS(xvsra_b, LASX, gvec_xxx, MO_8, tcg_gen_gvec_sarv)
+TRANS(xvsra_h, LASX, gvec_xxx, MO_16, tcg_gen_gvec_sarv)
+TRANS(xvsra_w, LASX, gvec_xxx, MO_32, tcg_gen_gvec_sarv)
+TRANS(xvsra_d, LASX, gvec_xxx, MO_64, tcg_gen_gvec_sarv)
+TRANS(xvsrai_b, LASX, gvec_xx_i, MO_8, tcg_gen_gvec_sari)
+TRANS(xvsrai_h, LASX, gvec_xx_i, MO_16, tcg_gen_gvec_sari)
+TRANS(xvsrai_w, LASX, gvec_xx_i, MO_32, tcg_gen_gvec_sari)
+TRANS(xvsrai_d, LASX, gvec_xx_i, MO_64, tcg_gen_gvec_sari)
 
 TRANS(vrotr_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_rotrv)
 TRANS(vrotr_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_rotrv)
@@ -3676,6 +3700,14 @@ TRANS(vrotri_b, LSX, gvec_vv_i, MO_8, tcg_gen_gvec_rotri)
 TRANS(vrotri_h, LSX, gvec_vv_i, MO_16, tcg_gen_gvec_rotri)
 TRANS(vrotri_w, LSX, gvec_vv_i, MO_32, tcg_gen_gvec_rotri)
 TRANS(vrotri_d, LSX, gvec_vv_i, MO_64, tcg_gen_gvec_rotri)
+TRANS(xvrotr_b, LASX, gvec_xxx, MO_8, tcg_gen_gvec_rotrv)
+TRANS(xvrotr_h, LASX, gvec_xxx, MO_16, tcg_gen_gvec_rotrv)
+TRANS(xvrotr_w, LASX, gvec_xxx, MO_32, tcg_gen_gvec_rotrv)
+TRANS(xvrotr_d, LASX, gvec_xxx, MO_64, tcg_gen_gvec_rotrv)
+TRANS(xvrotri_b, LASX, gvec_xx_i, MO_8, tcg_gen_gvec_rotri)
+TRANS(xvrotri_h, LASX, gvec_xx_i, MO_16, tcg_gen_gvec_rotri)
+TRANS(xvrotri_w, LASX, gvec_xx_i, MO_32, tcg_gen_gvec_rotri)
+TRANS(xvrotri_d, LASX, gvec_xx_i, MO_64, tcg_gen_gvec_rotri)
 
 TRANS(vsllwil_h_b, LSX, gen_vv_i, gen_helper_vsllwil_h_b)
 TRANS(vsllwil_w_h, LSX, gen_vv_i, gen_helper_vsllwil_w_h)
-- 
2.39.1


