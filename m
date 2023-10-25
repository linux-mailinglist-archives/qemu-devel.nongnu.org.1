Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E337D66D1
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:31:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvaCl-00054i-IF; Wed, 25 Oct 2023 05:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qvaCj-00051c-1N
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:29:33 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qvaCc-0001dV-Ap
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:29:32 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxXOrt3zhlE4A0AA--.9537S3;
 Wed, 25 Oct 2023 17:29:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxK9zp3zhlpuExAA--.39806S7; 
 Wed, 25 Oct 2023 17:29:16 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org,
 alex.bennee@linaro.org, maobibo@loongson.cn
Subject: [risu PATCH 5/5] loongarch: Add block 'clean' and clean_lsx_result()
Date: Wed, 25 Oct 2023 17:29:15 +0800
Message-Id: <20231025092915.902814-6-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231025092915.902814-1-gaosong@loongson.cn>
References: <20231025092915.902814-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxK9zp3zhlpuExAA--.39806S7
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

The result of the LSX instruction is in the low 128 bits
of the vreg register. We use clean_lsx_result() to clean up
the high 128 bits of the vreg register.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 loongarch64.risu       | 2121 ++++++++++++++++++++++++++--------------
 risugen                |    2 +-
 risugen_loongarch64.pm |   20 +
 3 files changed, 1405 insertions(+), 738 deletions(-)

diff --git a/loongarch64.risu b/loongarch64.risu
index 596de90..531470d 100644
--- a/loongarch64.risu
+++ b/loongarch64.risu
@@ -64,26 +64,26 @@ mulw_d_wu LA64 0000 00000001 11111 rk:5 rj:5 rd:5 \
 #div.{w[u]/d[u]} rd,rj,rk
 # div.w{u}, mod.w[u]  rk, rj, need in [0x0 ~0x7FFFFFFF]
 # use function set_reg_w($reg)
-div_w LA64 0000 00000010 00000 rk:5 rj:5 rd:5 \
-    !constraints { $rk != 2 && $rj != 2 && $rd != 2; } \
-    !memory { set_reg_w($rj); set_reg_w($rk); }
-div_wu LA64 0000 00000010 00010 rk:5 rj:5 rd:5 \
-    !constraints { $rk != 2 && $rj != 2 && $rd != 2; } \
-    !memory { set_reg_w($rj); set_reg_w($rk); }
-div_d LA64 0000 00000010 00100 rk:5 rj:5 rd:5 \
-    !constraints { $rk != 2 && $rj != 2 && $rd != 2; }
-div_du LA64 0000 00000010 00110 rk:5 rj:5 rd:5 \
-    !constraints { $rk != 2 && $rj != 2 && $rd != 2; }
-mod_w LA64 0000 00000010 00001 rk:5 rj:5 rd:5 \
-    !constraints { $rk != 2 && $rj != 2 && $rd != 2; } \
-    !memory { set_reg_w($rj); set_reg_w($rk); }
-mod_wu LA64 0000 00000010 00011 rk:5 rj:5 rd:5 \
-    !constraints { $rk != 2 && $rj != 2 && $rd != 2; } \
-    !memory { set_reg_w($rj); set_reg_w($rk); }
-mod_d LA64 0000 00000010 00101 rk:5 rj:5 rd:5 \
-    !constraints { $rk != 2 && $rj != 2 && $rd != 2; }
-mod_du LA64 0000 00000010 00111 rk:5 rj:5 rd:5 \
-    !constraints { $rk != 2 && $rj != 2 && $rd != 2; }
+#div_w LA64 0000 00000010 00000 rk:5 rj:5 rd:5 \
+#    !constraints { $rk != 2 && $rj != 2 && $rd != 2; } \
+#    !memory { set_reg_w($rj); set_reg_w($rk); }
+#div_wu LA64 0000 00000010 00010 rk:5 rj:5 rd:5 \
+#    !constraints { $rk != 2 && $rj != 2 && $rd != 2; } \
+#    !memory { set_reg_w($rj); set_reg_w($rk); }
+#div_d LA64 0000 00000010 00100 rk:5 rj:5 rd:5 \
+#    !constraints { $rk != 2 && $rj != 2 && $rd != 2; }
+#div_du LA64 0000 00000010 00110 rk:5 rj:5 rd:5 \
+#    !constraints { $rk != 2 && $rj != 2 && $rd != 2; }
+#mod_w LA64 0000 00000010 00001 rk:5 rj:5 rd:5 \
+#    !constraints { $rk != 2 && $rj != 2 && $rd != 2; } \
+#    !memory { set_reg_w($rj); set_reg_w($rk); }
+#mod_wu LA64 0000 00000010 00011 rk:5 rj:5 rd:5 \
+#    !constraints { $rk != 2 && $rj != 2 && $rd != 2; } \
+#    !memory { set_reg_w($rj); set_reg_w($rk); }
+#mod_d LA64 0000 00000010 00101 rk:5 rj:5 rd:5 \
+#    !constraints { $rk != 2 && $rj != 2 && $rd != 2; }
+#mod_du LA64 0000 00000010 00111 rk:5 rj:5 rd:5 \
+#    !constraints { $rk != 2 && $rj != 2 && $rd != 2; }
 
 alsl_w LA64 0000 00000000 010 sa2:2 rk:5 rj:5 rd:5 \
     !constraints { $rk != 2 && $rj != 2 && $rd != 2; }
@@ -615,665 +615,1248 @@ fstx_d LA64 0011 10000011 11000 rk:5 rj:5 fd:5 \
 # LSX instructions
 #
 
-vadd_b LSX 0111 00000000 10100 vk:5 vj:5 vd:5
-vadd_h LSX 0111 00000000 10101 vk:5 vj:5 vd:5
-vadd_w LSX 0111 00000000 10110 vk:5 vj:5 vd:5
-vadd_d LSX 0111 00000000 10111 vk:5 vj:5 vd:5
-vadd_q LSX 0111 00010010 11010 vk:5 vj:5 vd:5
-vsub_b LSX 0111 00000000 11000 vk:5 vj:5 vd:5
-vsub_h LSX 0111 00000000 11001 vk:5 vj:5 vd:5
-vsub_w LSX 0111 00000000 11010 vk:5 vj:5 vd:5
-vsub_d LSX 0111 00000000 11011 vk:5 vj:5 vd:5
-vsub_q LSX 0111 00010010 11011 vk:5 vj:5 vd:5
-
-vaddi_bu LSX 0111 00101000 10100 imm:5 vj:5 vd:5
-vaddi_hu LSX 0111 00101000 10101 imm:5 vj:5 vd:5
-vaddi_wu LSX 0111 00101000 10110 imm:5 vj:5 vd:5
-vaddi_du LSX 0111 00101000 10111 imm:5 vj:5 vd:5
-vsubi_bu LSX 0111 00101000 11000 imm:5 vj:5 vd:5
-vsubi_hu LSX 0111 00101000 11001 imm:5 vj:5 vd:5
-vsubi_wu LSX 0111 00101000 11010 imm:5 vj:5 vd:5
-vsubi_du LSX 0111 00101000 11011 imm:5 vj:5 vd:5
-
-vneg_b LSX 0111 00101001 11000 01100 vj:5 vd:5
-vneg_h LSX 0111 00101001 11000 01101 vj:5 vd:5
-vneg_w LSX 0111 00101001 11000 01110 vj:5 vd:5
-vneg_d LSX 0111 00101001 11000 01111 vj:5 vd:5
-
-vsadd_b LSX 0111 00000100 01100 vk:5 vj:5 vd:5
-vsadd_h LSX 0111 00000100 01101 vk:5 vj:5 vd:5
-vsadd_w LSX 0111 00000100 01110 vk:5 vj:5 vd:5
-vsadd_d LSX 0111 00000100 01111 vk:5 vj:5 vd:5
-vsadd_bu LSX 0111 00000100 10100 vk:5 vj:5 vd:5
-vsadd_hu LSX 0111 00000100 10101 vk:5 vj:5 vd:5
-vsadd_wu LSX 0111 00000100 10110 vk:5 vj:5 vd:5
-vsadd_du LSX 0111 00000100 10111 vk:5 vj:5 vd:5
-
-vssub_b LSX 0111 00000100 10000 vk:5 vj:5 vd:5
-vssub_h LSX 0111 00000100 10001 vk:5 vj:5 vd:5
-vssub_w LSX 0111 00000100 10010 vk:5 vj:5 vd:5
-vssub_d LSX 0111 00000100 10011 vk:5 vj:5 vd:5
-vssub_bu LSX 0111 00000100 11000 vk:5 vj:5 vd:5
-vssub_hu LSX 0111 00000100 11001 vk:5 vj:5 vd:5
-vssub_wu LSX 0111 00000100 11010 vk:5 vj:5 vd:5
-vssub_du LSX 0111 00000100 11011 vk:5 vj:5 vd:5
-
-vhaddw_h_b LSX 0111 00000101 01000 vk:5 vj:5 vd:5
-vhaddw_w_h LSX 0111 00000101 01001 vk:5 vj:5 vd:5
-vhaddw_d_w LSX 0111 00000101 01010 vk:5 vj:5 vd:5
-vhaddw_q_d LSX 0111 00000101 01011 vk:5 vj:5 vd:5
-vhaddw_hu_bu LSX 0111 00000101 10000 vk:5 vj:5 vd:5
-vhaddw_wu_hu LSX 0111 00000101 10001 vk:5 vj:5 vd:5
-vhaddw_du_wu LSX 0111 00000101 10010 vk:5 vj:5 vd:5
-vhaddw_qu_du LSX 0111 00000101 10011 vk:5 vj:5 vd:5
-
-vhsubw_h_b LSX 0111 00000101 01100 vk:5 vj:5 vd:5
-vhsubw_w_h LSX 0111 00000101 01101 vk:5 vj:5 vd:5
-vhsubw_d_w LSX 0111 00000101 01110 vk:5 vj:5 vd:5
-vhsubw_q_d LSX 0111 00000101 01111 vk:5 vj:5 vd:5
-vhsubw_hu_bu LSX 0111 00000101 10100 vk:5 vj:5 vd:5
-vhsubw_wu_hu LSX 0111 00000101 10101 vk:5 vj:5 vd:5
-vhsubw_du_wu LSX 0111 00000101 10110 vk:5 vj:5 vd:5
-vhsubw_qu_du LSX 0111 00000101 10111 vk:5 vj:5 vd:5
-
-vaddwev_h_b LSX 0111 00000001 11100 vk:5 vj:5 vd:5
-vaddwev_w_h LSX 0111 00000001 11101 vk:5 vj:5 vd:5
-vaddwev_d_w LSX 0111 00000001 11110 vk:5 vj:5 vd:5
-vaddwev_q_d LSX 0111 00000001 11111 vk:5 vj:5 vd:5
-vaddwod_h_b LSX 0111 00000010 00100 vk:5 vj:5 vd:5
-vaddwod_w_h LSX 0111 00000010 00101 vk:5 vj:5 vd:5
-vaddwod_d_w LSX 0111 00000010 00110 vk:5 vj:5 vd:5
-vaddwod_q_d LSX 0111 00000010 00111 vk:5 vj:5 vd:5
-
-vsubwev_h_b LSX 0111 00000010 00000 vk:5 vj:5 vd:5
-vsubwev_w_h LSX 0111 00000010 00001 vk:5 vj:5 vd:5
-vsubwev_d_w LSX 0111 00000010 00010 vk:5 vj:5 vd:5
-vsubwev_q_d LSX 0111 00000010 00011 vk:5 vj:5 vd:5
-vsubwod_h_b LSX 0111 00000010 01000 vk:5 vj:5 vd:5
-vsubwod_w_h LSX 0111 00000010 01001 vk:5 vj:5 vd:5
-vsubwod_d_w LSX 0111 00000010 01010 vk:5 vj:5 vd:5
-vsubwod_q_d LSX 0111 00000010 01011 vk:5 vj:5 vd:5
-
-vaddwev_h_bu LSX 0111 00000010 11100 vk:5 vj:5 vd:5
-vaddwev_w_hu LSX 0111 00000010 11101 vk:5 vj:5 vd:5
-vaddwev_d_wu LSX 0111 00000010 11110 vk:5 vj:5 vd:5
-vaddwev_q_du LSX 0111 00000010 11111 vk:5 vj:5 vd:5
-vaddwod_h_bu LSX 0111 00000011 00100 vk:5 vj:5 vd:5
-vaddwod_w_hu LSX 0111 00000011 00101 vk:5 vj:5 vd:5
-vaddwod_d_wu LSX 0111 00000011 00110 vk:5 vj:5 vd:5
-vaddwod_q_du LSX 0111 00000011 00111 vk:5 vj:5 vd:5
-
-vsubwev_h_bu LSX 0111 00000011 00000 vk:5 vj:5 vd:5
-vsubwev_w_hu LSX 0111 00000011 00001 vk:5 vj:5 vd:5
-vsubwev_d_wu LSX 0111 00000011 00010 vk:5 vj:5 vd:5
-vsubwev_q_du LSX 0111 00000011 00011 vk:5 vj:5 vd:5
-vsubwod_h_bu LSX 0111 00000011 01000 vk:5 vj:5 vd:5
-vsubwod_w_hu LSX 0111 00000011 01001 vk:5 vj:5 vd:5
-vsubwod_d_wu LSX 0111 00000011 01010 vk:5 vj:5 vd:5
-vsubwod_q_du LSX 0111 00000011 01011 vk:5 vj:5 vd:5
-
-vaddwev_h_bu_b LSX 0111 00000011 11100 vk:5 vj:5 vd:5
-vaddwev_w_hu_h LSX 0111 00000011 11101 vk:5 vj:5 vd:5
-vaddwev_d_wu_w LSX 0111 00000011 11110 vk:5 vj:5 vd:5
-vaddwev_q_du_d LSX 0111 00000011 11111 vk:5 vj:5 vd:5
-vaddwod_h_bu_b LSX 0111 00000100 00000 vk:5 vj:5 vd:5
-vaddwod_w_hu_h LSX 0111 00000100 00001 vk:5 vj:5 vd:5
-vaddwod_d_wu_w LSX 0111 00000100 00010 vk:5 vj:5 vd:5
-vaddwod_q_du_d LSX 0111 00000100 00011 vk:5 vj:5 vd:5
-
-vavg_b LSX 0111 00000110 01000 vk:5 vj:5 vd:5
-vavg_h LSX 0111 00000110 01001 vk:5 vj:5 vd:5
-vavg_w LSX 0111 00000110 01010 vk:5 vj:5 vd:5
-vavg_d LSX 0111 00000110 01011 vk:5 vj:5 vd:5
-vavg_bu LSX 0111 00000110 01100 vk:5 vj:5 vd:5
-vavg_hu LSX 0111 00000110 01101 vk:5 vj:5 vd:5
-vavg_wu LSX 0111 00000110 01110 vk:5 vj:5 vd:5
-vavg_du LSX 0111 00000110 01111 vk:5 vj:5 vd:5
-vavgr_b LSX 0111 00000110 10000 vk:5 vj:5 vd:5
-vavgr_h LSX 0111 00000110 10001 vk:5 vj:5 vd:5
-vavgr_w LSX 0111 00000110 10010 vk:5 vj:5 vd:5
-vavgr_d LSX 0111 00000110 10011 vk:5 vj:5 vd:5
-vavgr_bu LSX 0111 00000110 10100 vk:5 vj:5 vd:5
-vavgr_hu LSX 0111 00000110 10101 vk:5 vj:5 vd:5
-vavgr_wu LSX 0111 00000110 10110 vk:5 vj:5 vd:5
-vavgr_du LSX 0111 00000110 10111 vk:5 vj:5 vd:5
-
-vabsd_b LSX 0111 00000110 00000 vk:5 vj:5 vd:5
-vabsd_h LSX 0111 00000110 00001 vk:5 vj:5 vd:5
-vabsd_w LSX 0111 00000110 00010 vk:5 vj:5 vd:5
-vabsd_d LSX 0111 00000110 00011 vk:5 vj:5 vd:5
-vabsd_bu LSX 0111 00000110 00100 vk:5 vj:5 vd:5
-vabsd_hu LSX 0111 00000110 00101 vk:5 vj:5 vd:5
-vabsd_wu LSX 0111 00000110 00110 vk:5 vj:5 vd:5
-vabsd_du LSX 0111 00000110 00111 vk:5 vj:5 vd:5
-
-vadda_b LSX 0111 00000101 11000 vk:5 vj:5 vd:5
-vadda_h LSX 0111 00000101 11001 vk:5 vj:5 vd:5
-vadda_w LSX 0111 00000101 11010 vk:5 vj:5 vd:5
-vadda_d LSX 0111 00000101 11011 vk:5 vj:5 vd:5
-
-vmax_b LSX 0111 00000111 00000 vk:5 vj:5 vd:5
-vmax_h LSX 0111 00000111 00001 vk:5 vj:5 vd:5
-vmax_w LSX 0111 00000111 00010 vk:5 vj:5 vd:5
-vmax_d LSX 0111 00000111 00011 vk:5 vj:5 vd:5
+vadd_b LSX 0111 00000000 10100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vadd_h LSX 0111 00000000 10101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vadd_w LSX 0111 00000000 10110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vadd_d LSX 0111 00000000 10111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vadd_q LSX 0111 00010010 11010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsub_b LSX 0111 00000000 11000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsub_h LSX 0111 00000000 11001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsub_w LSX 0111 00000000 11010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsub_d LSX 0111 00000000 11011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsub_q LSX 0111 00010010 11011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vaddi_bu LSX 0111 00101000 10100 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vaddi_hu LSX 0111 00101000 10101 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vaddi_wu LSX 0111 00101000 10110 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vaddi_du LSX 0111 00101000 10111 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsubi_bu LSX 0111 00101000 11000 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsubi_hu LSX 0111 00101000 11001 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsubi_wu LSX 0111 00101000 11010 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsubi_du LSX 0111 00101000 11011 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vneg_b LSX 0111 00101001 11000 01100 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vneg_h LSX 0111 00101001 11000 01101 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vneg_w LSX 0111 00101001 11000 01110 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vneg_d LSX 0111 00101001 11000 01111 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vsadd_b LSX 0111 00000100 01100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsadd_h LSX 0111 00000100 01101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsadd_w LSX 0111 00000100 01110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsadd_d LSX 0111 00000100 01111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsadd_bu LSX 0111 00000100 10100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsadd_hu LSX 0111 00000100 10101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsadd_wu LSX 0111 00000100 10110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsadd_du LSX 0111 00000100 10111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vssub_b LSX 0111 00000100 10000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssub_h LSX 0111 00000100 10001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssub_w LSX 0111 00000100 10010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssub_d LSX 0111 00000100 10011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssub_bu LSX 0111 00000100 11000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssub_hu LSX 0111 00000100 11001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssub_wu LSX 0111 00000100 11010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssub_du LSX 0111 00000100 11011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vhaddw_h_b LSX 0111 00000101 01000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vhaddw_w_h LSX 0111 00000101 01001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vhaddw_d_w LSX 0111 00000101 01010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vhaddw_q_d LSX 0111 00000101 01011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vhaddw_hu_bu LSX 0111 00000101 10000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vhaddw_wu_hu LSX 0111 00000101 10001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vhaddw_du_wu LSX 0111 00000101 10010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vhaddw_qu_du LSX 0111 00000101 10011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vhsubw_h_b LSX 0111 00000101 01100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vhsubw_w_h LSX 0111 00000101 01101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vhsubw_d_w LSX 0111 00000101 01110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vhsubw_q_d LSX 0111 00000101 01111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vhsubw_hu_bu LSX 0111 00000101 10100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vhsubw_wu_hu LSX 0111 00000101 10101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vhsubw_du_wu LSX 0111 00000101 10110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vhsubw_qu_du LSX 0111 00000101 10111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vaddwev_h_b LSX 0111 00000001 11100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vaddwev_w_h LSX 0111 00000001 11101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vaddwev_d_w LSX 0111 00000001 11110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vaddwev_q_d LSX 0111 00000001 11111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vaddwod_h_b LSX 0111 00000010 00100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vaddwod_w_h LSX 0111 00000010 00101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vaddwod_d_w LSX 0111 00000010 00110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vaddwod_q_d LSX 0111 00000010 00111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vsubwev_h_b LSX 0111 00000010 00000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsubwev_w_h LSX 0111 00000010 00001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsubwev_d_w LSX 0111 00000010 00010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsubwev_q_d LSX 0111 00000010 00011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsubwod_h_b LSX 0111 00000010 01000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsubwod_w_h LSX 0111 00000010 01001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsubwod_d_w LSX 0111 00000010 01010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsubwod_q_d LSX 0111 00000010 01011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vaddwev_h_bu LSX 0111 00000010 11100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vaddwev_w_hu LSX 0111 00000010 11101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vaddwev_d_wu LSX 0111 00000010 11110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vaddwev_q_du LSX 0111 00000010 11111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vaddwod_h_bu LSX 0111 00000011 00100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vaddwod_w_hu LSX 0111 00000011 00101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vaddwod_d_wu LSX 0111 00000011 00110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vaddwod_q_du LSX 0111 00000011 00111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vsubwev_h_bu LSX 0111 00000011 00000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsubwev_w_hu LSX 0111 00000011 00001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsubwev_d_wu LSX 0111 00000011 00010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsubwev_q_du LSX 0111 00000011 00011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsubwod_h_bu LSX 0111 00000011 01000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsubwod_w_hu LSX 0111 00000011 01001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsubwod_d_wu LSX 0111 00000011 01010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsubwod_q_du LSX 0111 00000011 01011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vaddwev_h_bu_b LSX 0111 00000011 11100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vaddwev_w_hu_h LSX 0111 00000011 11101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vaddwev_d_wu_w LSX 0111 00000011 11110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vaddwev_q_du_d LSX 0111 00000011 11111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vaddwod_h_bu_b LSX 0111 00000100 00000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vaddwod_w_hu_h LSX 0111 00000100 00001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vaddwod_d_wu_w LSX 0111 00000100 00010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vaddwod_q_du_d LSX 0111 00000100 00011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vavg_b LSX 0111 00000110 01000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vavg_h LSX 0111 00000110 01001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vavg_w LSX 0111 00000110 01010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vavg_d LSX 0111 00000110 01011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vavg_bu LSX 0111 00000110 01100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vavg_hu LSX 0111 00000110 01101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vavg_wu LSX 0111 00000110 01110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vavg_du LSX 0111 00000110 01111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vavgr_b LSX 0111 00000110 10000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vavgr_h LSX 0111 00000110 10001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vavgr_w LSX 0111 00000110 10010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vavgr_d LSX 0111 00000110 10011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vavgr_bu LSX 0111 00000110 10100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vavgr_hu LSX 0111 00000110 10101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vavgr_wu LSX 0111 00000110 10110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vavgr_du LSX 0111 00000110 10111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vabsd_b LSX 0111 00000110 00000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vabsd_h LSX 0111 00000110 00001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vabsd_w LSX 0111 00000110 00010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vabsd_d LSX 0111 00000110 00011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vabsd_bu LSX 0111 00000110 00100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vabsd_hu LSX 0111 00000110 00101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vabsd_wu LSX 0111 00000110 00110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vabsd_du LSX 0111 00000110 00111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vadda_b LSX 0111 00000101 11000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vadda_h LSX 0111 00000101 11001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vadda_w LSX 0111 00000101 11010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vadda_d LSX 0111 00000101 11011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vmax_b LSX 0111 00000111 00000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmax_h LSX 0111 00000111 00001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmax_w LSX 0111 00000111 00010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmax_d LSX 0111 00000111 00011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
 
 vmaxi_b LSX 0111 00101001 00000 imm:5 vj:5 vd:5 \
-    !constraints { $imm = sextract($imm, 5);}
+    !constraints { $imm = sextract($imm, 5);} \
+    !clean { clean_lsx_result($vd); }
 vmaxi_h LSX 0111 00101001 00001 imm:5 vj:5 vd:5 \
-    !constraints { $imm = sextract($imm, 5);}
+    !constraints { $imm = sextract($imm, 5);} \
+    !clean { clean_lsx_result($vd); }
 vmaxi_w LSX 0111 00101001 00010 imm:5 vj:5 vd:5 \
-    !constraints { $imm = sextract($imm, 5);}
+    !constraints { $imm = sextract($imm, 5);} \
+    !clean { clean_lsx_result($vd); }
 vmaxi_d LSX 0111 00101001 00011 imm:5 vj:5 vd:5 \
-    !constraints { $imm = sextract($imm, 5);}
-
-vmax_bu LSX 0111 00000111 01000 vk:5 vj:5 vd:5
-vmax_hu LSX 0111 00000111 01001 vk:5 vj:5 vd:5
-vmax_wu LSX 0111 00000111 01010 vk:5 vj:5 vd:5
-vmax_du LSX 0111 00000111 01011 vk:5 vj:5 vd:5
-vmaxi_bu LSX 0111 00101001 01000 imm:5 vj:5 vd:5
-vmaxi_hu LSX 0111 00101001 01001 imm:5 vj:5 vd:5
-vmaxi_wu LSX 0111 00101001 01010 imm:5 vj:5 vd:5
-vmaxi_du LSX 0111 00101001 01011 imm:5 vj:5 vd:5
-
-vmin_b LSX 0111 00000111 00100 vk:5 vj:5 vd:5
-vmin_h LSX 0111 00000111 00101 vk:5 vj:5 vd:5
-vmin_w LSX 0111 00000111 00110 vk:5 vj:5 vd:5
-vmin_d LSX 0111 00000111 00111 vk:5 vj:5 vd:5
+    !constraints { $imm = sextract($imm, 5);} \
+    !clean { clean_lsx_result($vd); }
+
+vmax_bu LSX 0111 00000111 01000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmax_hu LSX 0111 00000111 01001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmax_wu LSX 0111 00000111 01010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmax_du LSX 0111 00000111 01011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmaxi_bu LSX 0111 00101001 01000 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmaxi_hu LSX 0111 00101001 01001 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmaxi_wu LSX 0111 00101001 01010 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmaxi_du LSX 0111 00101001 01011 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vmin_b LSX 0111 00000111 00100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmin_h LSX 0111 00000111 00101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmin_w LSX 0111 00000111 00110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmin_d LSX 0111 00000111 00111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
 vmini_b LSX 0111 00101001 00100 imm:5 vj:5 vd:5 \
-    !constraints { $imm = sextract($imm, 5);}
+    !constraints { $imm = sextract($imm, 5);} \
+    !clean { clean_lsx_result($vd); }
 vmini_h LSX 0111 00101001 00101 imm:5 vj:5 vd:5 \
-    !constraints { $imm = sextract($imm, 5);}
+    !constraints { $imm = sextract($imm, 5);} \
+    !clean { clean_lsx_result($vd); }
 vmini_w LSX 0111 00101001 00110 imm:5 vj:5 vd:5 \
-    !constraints { $imm = sextract($imm, 5);}
+    !constraints { $imm = sextract($imm, 5);} \
+    !clean { clean_lsx_result($vd); }
 vmini_d LSX 0111 00101001 00111 imm:5 vj:5 vd:5 \
-    !constraints { $imm = sextract($imm, 5);}
-
-vmin_bu LSX 0111 00000111 01100 vk:5 vj:5 vd:5
-vmin_hu LSX 0111 00000111 01101 vk:5 vj:5 vd:5
-vmin_wu LSX 0111 00000111 01110 vk:5 vj:5 vd:5
-vmin_du LSX 0111 00000111 01111 vk:5 vj:5 vd:5
-vmini_bu LSX 0111 00101001 01100 imm:5 vj:5 vd:5
-vmini_hu LSX 0111 00101001 01101 imm:5 vj:5 vd:5
-vmini_wu LSX 0111 00101001 01110 imm:5 vj:5 vd:5
-vmini_du LSX 0111 00101001 01111 imm:5 vj:5 vd:5
-
-vmul_b LSX 0111 00001000 01000 vk:5 vj:5 vd:5
-vmul_h LSX 0111 00001000 01001 vk:5 vj:5 vd:5
-vmul_w LSX 0111 00001000 01010 vk:5 vj:5 vd:5
-vmul_d LSX 0111 00001000 01011 vk:5 vj:5 vd:5
-vmuh_b LSX 0111 00001000 01100 vk:5 vj:5 vd:5
-vmuh_h LSX 0111 00001000 01101 vk:5 vj:5 vd:5
-vmuh_w LSX 0111 00001000 01110 vk:5 vj:5 vd:5
-vmuh_d LSX 0111 00001000 01111 vk:5 vj:5 vd:5
-vmuh_bu LSX 0111 00001000 10000 vk:5 vj:5 vd:5
-vmuh_hu LSX 0111 00001000 10001 vk:5 vj:5 vd:5
-vmuh_wu LSX 0111 00001000 10010 vk:5 vj:5 vd:5
-vmuh_du LSX 0111 00001000 10011 vk:5 vj:5 vd:5
-
-vmulwev_h_b LSX 0111 00001001 00000 vk:5 vj:5 vd:5
-vmulwev_w_h LSX 0111 00001001 00001 vk:5 vj:5 vd:5
-vmulwev_d_w LSX 0111 00001001 00010 vk:5 vj:5 vd:5
-vmulwev_q_d LSX 0111 00001001 00011 vk:5 vj:5 vd:5
-vmulwod_h_b LSX 0111 00001001 00100 vk:5 vj:5 vd:5
-vmulwod_w_h LSX 0111 00001001 00101 vk:5 vj:5 vd:5
-vmulwod_d_w LSX 0111 00001001 00110 vk:5 vj:5 vd:5
-vmulwod_q_d LSX 0111 00001001 00111 vk:5 vj:5 vd:5
-vmulwev_h_bu LSX 0111 00001001 10000 vk:5 vj:5 vd:5
-vmulwev_w_hu LSX 0111 00001001 10001 vk:5 vj:5 vd:5
-vmulwev_d_wu LSX 0111 00001001 10010 vk:5 vj:5 vd:5
-vmulwev_q_du LSX 0111 00001001 10011 vk:5 vj:5 vd:5
-vmulwod_h_bu LSX 0111 00001001 10100 vk:5 vj:5 vd:5
-vmulwod_w_hu LSX 0111 00001001 10101 vk:5 vj:5 vd:5
-vmulwod_d_wu LSX 0111 00001001 10110 vk:5 vj:5 vd:5
-vmulwod_q_du LSX 0111 00001001 10111 vk:5 vj:5 vd:5
-vmulwev_h_bu_b LSX 0111 00001010 00000 vk:5 vj:5 vd:5
-vmulwev_w_hu_h LSX 0111 00001010 00001 vk:5 vj:5 vd:5
-vmulwev_d_wu_w LSX 0111 00001010 00010 vk:5 vj:5 vd:5
-vmulwev_q_du_d LSX 0111 00001010 00011 vk:5 vj:5 vd:5
-vmulwod_h_bu_b LSX 0111 00001010 00100 vk:5 vj:5 vd:5
-vmulwod_w_hu_h LSX 0111 00001010 00101 vk:5 vj:5 vd:5
-vmulwod_d_wu_w LSX 0111 00001010 00110 vk:5 vj:5 vd:5
-vmulwod_q_du_d LSX 0111 00001010 00111 vk:5 vj:5 vd:5
-
-vmadd_b LSX 0111 00001010 10000 vk:5 vj:5 vd:5
-vmadd_h LSX 0111 00001010 10001 vk:5 vj:5 vd:5
-vmadd_w LSX 0111 00001010 10010 vk:5 vj:5 vd:5
-vmadd_d LSX 0111 00001010 10011 vk:5 vj:5 vd:5
-vmsub_b LSX 0111 00001010 10100 vk:5 vj:5 vd:5
-vmsub_h LSX 0111 00001010 10101 vk:5 vj:5 vd:5
-vmsub_w LSX 0111 00001010 10110 vk:5 vj:5 vd:5
-vmsub_d LSX 0111 00001010 10111 vk:5 vj:5 vd:5
-
-vmaddwev_h_b LSX 0111 00001010 11000 vk:5 vj:5 vd:5
-vmaddwev_w_h LSX 0111 00001010 11001 vk:5 vj:5 vd:5
-vmaddwev_d_w LSX 0111 00001010 11010 vk:5 vj:5 vd:5
-vmaddwev_q_d LSX 0111 00001010 11011 vk:5 vj:5 vd:5
-vmaddwod_h_b LSX 0111 00001010 11100 vk:5 vj:5 vd:5
-vmaddwod_w_h LSX 0111 00001010 11101 vk:5 vj:5 vd:5
-vmaddwod_d_w LSX 0111 00001010 11110 vk:5 vj:5 vd:5
-vmaddwod_q_d LSX 0111 00001010 11111 vk:5 vj:5 vd:5
-vmaddwev_h_bu LSX 0111 00001011 01000 vk:5 vj:5 vd:5
-vmaddwev_w_hu LSX 0111 00001011 01001 vk:5 vj:5 vd:5
-vmaddwev_d_wu LSX 0111 00001011 01010 vk:5 vj:5 vd:5
-vmaddwev_q_du LSX 0111 00001011 01011 vk:5 vj:5 vd:5
-vmaddwod_h_bu LSX 0111 00001011 01100 vk:5 vj:5 vd:5
-vmaddwod_w_hu LSX 0111 00001011 01101 vk:5 vj:5 vd:5
-vmaddwod_d_wu LSX 0111 00001011 01110 vk:5 vj:5 vd:5
-vmaddwod_q_du LSX 0111 00001011 01111 vk:5 vj:5 vd:5
-vmaddwev_h_bu_b LSX 0111 00001011 11000 vk:5 vj:5 vd:5
-vmaddwev_w_hu_h LSX 0111 00001011 11001 vk:5 vj:5 vd:5
-vmaddwev_d_wu_w LSX 0111 00001011 11010 vk:5 vj:5 vd:5
-vmaddwev_q_du_d LSX 0111 00001011 11011 vk:5 vj:5 vd:5
-vmaddwod_h_bu_b LSX 0111 00001011 11100 vk:5 vj:5 vd:5
-vmaddwod_w_hu_h LSX 0111 00001011 11101 vk:5 vj:5 vd:5
-vmaddwod_d_wu_w LSX 0111 00001011 11110 vk:5 vj:5 vd:5
-vmaddwod_q_du_d LSX 0111 00001011 11111 vk:5 vj:5 vd:5
-
-vdiv_b LSX 0111 00001110 00000 vk:5 vj:5 vd:5
-vdiv_h LSX 0111 00001110 00001 vk:5 vj:5 vd:5
-vdiv_w LSX 0111 00001110 00010 vk:5 vj:5 vd:5
-vdiv_d LSX 0111 00001110 00011 vk:5 vj:5 vd:5
-vdiv_bu LSX 0111 00001110 01000 vk:5 vj:5 vd:5
-vdiv_hu LSX 0111 00001110 01001 vk:5 vj:5 vd:5
-vdiv_wu LSX 0111 00001110 01010 vk:5 vj:5 vd:5
-vdiv_du LSX 0111 00001110 01011 vk:5 vj:5 vd:5
-vmod_b LSX 0111 00001110 00100 vk:5 vj:5 vd:5
-vmod_h LSX 0111 00001110 00101 vk:5 vj:5 vd:5
-vmod_w LSX 0111 00001110 00110 vk:5 vj:5 vd:5
-vmod_d LSX 0111 00001110 00111 vk:5 vj:5 vd:5
-vmod_bu LSX 0111 00001110 01100 vk:5 vj:5 vd:5
-vmod_hu LSX 0111 00001110 01101 vk:5 vj:5 vd:5
-vmod_wu LSX 0111 00001110 01110 vk:5 vj:5 vd:5
-vmod_du LSX 0111 00001110 01111 vk:5 vj:5 vd:5
-
-vsat_b LSX 0111 00110010 01000 01 imm:3 vj:5 vd:5
-vsat_h LSX 0111 00110010 01000 1  imm:4 vj:5 vd:5
-vsat_w LSX 0111 00110010 01001    imm:5 vj:5 vd:5
-vsat_d LSX 0111 00110010 0101     imm:6 vj:5 vd:5
-vsat_bu LSX 0111 00110010 10000 01 imm:3 vj:5 vd:5
-vsat_hu LSX 0111 00110010 10000 1  imm:4 vj:5 vd:5
-vsat_wu LSX 0111 00110010 10001    imm:5 vj:5 vd:5
-vsat_du LSX 0111 00110010 1001     imm:6 vj:5 vd:5
-
-vexth_h_b LSX 0111 00101001 11101 11000 vj:5 vd:5
-vexth_w_h LSX 0111 00101001 11101 11001 vj:5 vd:5
-vexth_d_w LSX 0111 00101001 11101 11010 vj:5 vd:5
-vexth_q_d LSX 0111 00101001 11101 11011 vj:5 vd:5
-vexth_hu_bu LSX 0111 00101001 11101 11100 vj:5 vd:5
-vexth_wu_hu LSX 0111 00101001 11101 11101 vj:5 vd:5
-vexth_du_wu LSX 0111 00101001 11101 11110 vj:5 vd:5
-vexth_qu_du LSX 0111 00101001 11101 11111 vj:5 vd:5
-
-vsigncov_b LSX 0111 00010010 11100 vk:5 vj:5 vd:5
-vsigncov_h LSX 0111 00010010 11101 vk:5 vj:5 vd:5
-vsigncov_w LSX 0111 00010010 11110 vk:5 vj:5 vd:5
-vsigncov_d LSX 0111 00010010 11111 vk:5 vj:5 vd:5
-
-vmskltz_b LSX 0111 00101001 11000 10000 vj:5 vd:5
-vmskltz_h LSX 0111 00101001 11000 10001 vj:5 vd:5
-vmskltz_w LSX 0111 00101001 11000 10010 vj:5 vd:5
-vmskltz_d LSX 0111 00101001 11000 10011 vj:5 vd:5
-vmskgez_b LSX 0111 00101001 11000 10100 vj:5 vd:5
-vmsknz_b LSX 0111 00101001 11000 11000 vj:5 vd:5
-
-vand_v LSX 0111 00010010 01100 vk:5 vj:5 vd:5
-vor_v LSX 0111 00010010 01101 vk:5 vj:5 vd:5
-vxor_v LSX 0111 00010010 01110 vk:5 vj:5 vd:5
-vnor_v LSX 0111 00010010 01111 vk:5 vj:5 vd:5
-vandn_v LSX 0111 00010010 10000 vk:5 vj:5 vd:5
-vorn_v LSX 0111 00010010 10001 vk:5 vj:5 vd:5
-
-vandi_b LSX 0111 00111101 00 imm:8 vj:5 vd:5
-vori_b LSX 0111 00111101 01 imm:8 vj:5 vd:5
-vxori_b LSX 0111 00111101 10 imm:8 vj:5 vd:5
-vnori_b LSX 0111 00111101 11 imm:8 vj:5 vd:5
-
-vsll_b LSX 0111 00001110 10000 vk:5 vj:5 vd:5
-vsll_h LSX 0111 00001110 10001 vk:5 vj:5 vd:5
-vsll_w LSX 0111 00001110 10010 vk:5 vj:5 vd:5
-vsll_d LSX 0111 00001110 10011 vk:5 vj:5 vd:5
-vslli_b LSX 0111 00110010 11000 01 imm:3 vj:5 vd:5
-vslli_h LSX 0111 00110010 11000 1  imm:4 vj:5 vd:5
-vslli_w LSX 0111 00110010 11001    imm:5 vj:5 vd:5
-vslli_d LSX 0111 00110010 1101     imm:6 vj:5 vd:5
-
-vsrl_b LSX 0111 00001110 10100 vk:5 vj:5 vd:5
-vsrl_h LSX 0111 00001110 10101 vk:5 vj:5 vd:5
-vsrl_w LSX 0111 00001110 10110 vk:5 vj:5 vd:5
-vsrl_d LSX 0111 00001110 10111 vk:5 vj:5 vd:5
-vsrli_b LSX 0111 00110011 00000 01 imm:3 vj:5 vd:5
-vsrli_h LSX 0111 00110011 00000 1  imm:4 vj:5 vd:5
-vsrli_w LSX 0111 00110011 00001    imm:5 vj:5 vd:5
-vsrli_d LSX 0111 00110011 0001     imm:6 vj:5 vd:5
-
-vsra_b LSX 0111 00001110 11000 vk:5 vj:5 vd:5
-vsra_h LSX 0111 00001110 11001 vk:5 vj:5 vd:5
-vsra_w LSX 0111 00001110 11010 vk:5 vj:5 vd:5
-vsra_d LSX 0111 00001110 11011 vk:5 vj:5 vd:5
-vsrai_b LSX 0111 00110011 01000 01 imm:3 vj:5 vd:5
-vsrai_h LSX 0111 00110011 01000 1  imm:4 vj:5 vd:5
-vsrai_w LSX 0111 00110011 01001    imm:5 vj:5 vd:5
-vsrai_d LSX 0111 00110011 0101     imm:6 vj:5 vd:5
-
-vrotr_b LSX 0111 00001110 11100 vk:5 vj:5 vd:5
-vrotr_h LSX 0111 00001110 11101 vk:5 vj:5 vd:5
-vrotr_w LSX 0111 00001110 11110 vk:5 vj:5 vd:5
-vrotr_d LSX 0111 00001110 11111 vk:5 vj:5 vd:5
-vrotri_b LSX 0111 00101010 00000 01 imm:3 vj:5 vd:5
-vrotri_h LSX 0111 00101010 00000 1  imm:4 vj:5 vd:5
-vrotri_w LSX 0111 00101010 00001    imm:5 vj:5 vd:5
-vrotri_d LSX 0111 00101010 0001     imm:6 vj:5 vd:5
-
-vsllwil_h_b LSX 0111 00110000 10000 01 imm:3 vj:5 vd:5
-vsllwil_w_h LSX 0111 00110000 10000 1  imm:4 vj:5 vd:5
-vsllwil_d_w LSX 0111 00110000 10001    imm:5 vj:5 vd:5
-vextl_q_d LSX 0111 00110000 10010 00000 vj:5 vd:5
-vsllwil_hu_bu LSX 0111 00110000 11000 01 imm:3 vj:5 vd:5
-vsllwil_wu_hu LSX 0111 00110000 11000 1  imm:4 vj:5 vd:5
-vsllwil_du_wu LSX 0111 00110000 11001    imm:5 vj:5 vd:5
-vextl_qu_du LSX 0111 00110000 11010 00000 vj:5 vd:5
-
-vsrlr_b LSX 0111 00001111 00000 vk:5 vj:5 vd:5
-vsrlr_h LSX 0111 00001111 00001 vk:5 vj:5 vd:5
-vsrlr_w LSX 0111 00001111 00010 vk:5 vj:5 vd:5
-vsrlr_d LSX 0111 00001111 00011 vk:5 vj:5 vd:5
-vsrlri_b LSX 0111 00101010 01000 01 imm:3 vj:5 vd:5
-vsrlri_h LSX 0111 00101010 01000 1  imm:4 vj:5 vd:5
-vsrlri_w LSX 0111 00101010 01001    imm:5 vj:5 vd:5
-vsrlri_d LSX 0111 00101010 0101     imm:6 vj:5 vd:5
-
-vsrar_b LSX 0111 00001111 00100 vk:5 vj:5 vd:5
-vsrar_h LSX 0111 00001111 00101 vk:5 vj:5 vd:5
-vsrar_w LSX 0111 00001111 00110 vk:5 vj:5 vd:5
-vsrar_d LSX 0111 00001111 00111 vk:5 vj:5 vd:5
-vsrari_b LSX 0111 00101010 10000 01 imm:3 vj:5 vd:5
-vsrari_h LSX 0111 00101010 10000 1  imm:4 vj:5 vd:5
-vsrari_w LSX 0111 00101010 10001    imm:5 vj:5 vd:5
-vsrari_d LSX 0111 00101010 1001     imm:6 vj:5 vd:5
-
-vsrln_b_h LSX 0111 00001111 01001 vk:5 vj:5 vd:5
-vsrln_h_w LSX 0111 00001111 01010 vk:5 vj:5 vd:5
-vsrln_w_d LSX 0111 00001111 01011 vk:5 vj:5 vd:5
-vsran_b_h LSX 0111 00001111 01101 vk:5 vj:5 vd:5
-vsran_h_w LSX 0111 00001111 01110 vk:5 vj:5 vd:5
-vsran_w_d LSX 0111 00001111 01111 vk:5 vj:5 vd:5
-
-vsrlni_b_h LSX 0111 00110100 00000 1 imm:4 vj:5 vd:5
-vsrlni_h_w LSX 0111 00110100 00001   imm:5 vj:5 vd:5
-vsrlni_w_d LSX 0111 00110100 0001    imm:6 vj:5 vd:5
-vsrlni_d_q LSX 0111 00110100 001     imm:7 vj:5 vd:5
-vsrani_b_h LSX 0111 00110101 10000 1 imm:4 vj:5 vd:5
-vsrani_h_w LSX 0111 00110101 10001   imm:5 vj:5 vd:5
-vsrani_w_d LSX 0111 00110101 1001    imm:6 vj:5 vd:5
-vsrani_d_q LSX 0111 00110101 101     imm:7 vj:5 vd:5
-
-vsrlrn_b_h LSX 0111 00001111 10001 vk:5 vj:5 vd:5
-vsrlrn_h_w LSX 0111 00001111 10010 vk:5 vj:5 vd:5
-vsrlrn_w_d LSX 0111 00001111 10011 vk:5 vj:5 vd:5
-vsrarn_b_h LSX 0111 00001111 10101 vk:5 vj:5 vd:5
-vsrarn_h_w LSX 0111 00001111 10110 vk:5 vj:5 vd:5
-vsrarn_w_d LSX 0111 00001111 10111 vk:5 vj:5 vd:5
-
-vsrlrni_b_h LSX 0111 00110100 01000 1 imm:4 vj:5 vd:5
-vsrlrni_h_w LSX 0111 00110100 01001   imm:5 vj:5 vd:5
-vsrlrni_w_d LSX 0111 00110100 0101    imm:6 vj:5 vd:5
-vsrlrni_d_q LSX 0111 00110100 011     imm:7 vj:5 vd:5
-vsrarni_b_h LSX 0111 00110101 11000 1 imm:4 vj:5 vd:5
-vsrarni_h_w LSX 0111 00110101 11001   imm:5 vj:5 vd:5
-vsrarni_w_d LSX 0111 00110101 1101    imm:6 vj:5 vd:5
-vsrarni_d_q LSX 0111 00110101 111     imm:7 vj:5 vd:5
-
-vssrln_b_h LSX 0111 00001111 11001 vk:5 vj:5 vd:5
-vssrln_h_w LSX 0111 00001111 11010 vk:5 vj:5 vd:5
-vssrln_w_d LSX 0111 00001111 11011 vk:5 vj:5 vd:5
-vssran_b_h LSX 0111 00001111 11101 vk:5 vj:5 vd:5
-vssran_h_w LSX 0111 00001111 11110 vk:5 vj:5 vd:5
-vssran_w_d LSX 0111 00001111 11111 vk:5 vj:5 vd:5
-vssrln_bu_h LSX 0111 00010000 01001 vk:5 vj:5 vd:5
-vssrln_hu_w LSX 0111 00010000 01010 vk:5 vj:5 vd:5
-vssrln_wu_d LSX 0111 00010000 01011 vk:5 vj:5 vd:5
-vssran_bu_h LSX 0111 00010000 01101 vk:5 vj:5 vd:5
-vssran_hu_w LSX 0111 00010000 01110 vk:5 vj:5 vd:5
-vssran_wu_d LSX 0111 00010000 01111 vk:5 vj:5 vd:5
-
-vssrlni_b_h LSX 0111 00110100 10000 1 imm:4 vj:5 vd:5
-vssrlni_h_w LSX 0111 00110100 10001   imm:5 vj:5 vd:5
-vssrlni_w_d LSX 0111 00110100 1001    imm:6 vj:5 vd:5
-vssrlni_d_q LSX 0111 00110100 101     imm:7 vj:5 vd:5
-vssrani_b_h LSX 0111 00110110 00000 1 imm:4 vj:5 vd:5
-vssrani_h_w LSX 0111 00110110 00001   imm:5 vj:5 vd:5
-vssrani_w_d LSX 0111 00110110 0001    imm:6 vj:5 vd:5
-vssrani_d_q LSX 0111 00110110 001     imm:7 vj:5 vd:5
-vssrlni_bu_h LSX 0111 00110100 11000 1 imm:4 vj:5 vd:5
-vssrlni_hu_w LSX 0111 00110100 11001   imm:5 vj:5 vd:5
-vssrlni_wu_d LSX 0111 00110100 1101    imm:6 vj:5 vd:5
-vssrlni_du_q LSX 0111 00110100 111     imm:7 vj:5 vd:5
-vssrani_bu_h LSX 0111 00110110 01000 1 imm:4 vj:5 vd:5
-vssrani_hu_w LSX 0111 00110110 01001   imm:5 vj:5 vd:5
-vssrani_wu_d LSX 0111 00110110 0101    imm:6 vj:5 vd:5
-vssrani_du_q LSX 0111 00110110 011     imm:7 vj:5 vd:5
-
-vssrlrn_b_h LSX 0111 00010000 00001 vk:5 vj:5 vd:5
-vssrlrn_h_w LSX 0111 00010000 00010 vk:5 vj:5 vd:5
-vssrlrn_w_d LSX 0111 00010000 00011 vk:5 vj:5 vd:5
-vssrarn_b_h LSX 0111 00010000 00101 vk:5 vj:5 vd:5
-vssrarn_h_w LSX 0111 00010000 00110 vk:5 vj:5 vd:5
-vssrarn_w_d LSX 0111 00010000 00111 vk:5 vj:5 vd:5
-vssrlrn_bu_h LSX 0111 00010000 10001 vk:5 vj:5 vd:5
-vssrlrn_hu_w LSX 0111 00010000 10010 vk:5 vj:5 vd:5
-vssrlrn_wu_d LSX 0111 00010000 10011 vk:5 vj:5 vd:5
-vssrarn_bu_h LSX 0111 00010000 10101 vk:5 vj:5 vd:5
-vssrarn_hu_w LSX 0111 00010000 10110 vk:5 vj:5 vd:5
-vssrarn_wu_d LSX 0111 00010000 10111 vk:5 vj:5 vd:5
-
-vssrlrni_b_h LSX 0111 00110101 00000 1 imm:4 vj:5 vd:5
-vssrlrni_h_w LSX 0111 00110101 00001   imm:5 vj:5 vd:5
-vssrlrni_w_d LSX 0111 00110101 0001    imm:6 vj:5 vd:5
-vssrlrni_d_q LSX 0111 00110101 001     imm:7 vj:5 vd:5
-vssrarni_b_h LSX 0111 00110110 10000 1 imm:4 vj:5 vd:5
-vssrarni_h_w LSX 0111 00110110 10001   imm:5 vj:5 vd:5
-vssrarni_w_d LSX 0111 00110110 1001    imm:6 vj:5 vd:5
-vssrarni_d_q LSX 0111 00110110 101     imm:7 vj:5 vd:5
-vssrlrni_hu_w LSX 0111 00110101 01001   imm:5 vj:5 vd:5
-vssrlrni_wu_d LSX 0111 00110101 0101    imm:6 vj:5 vd:5
-vssrlrni_du_q LSX 0111 00110101 011     imm:7 vj:5 vd:5
-vssrarni_bu_h LSX 0111 00110110 11000 1 imm:4 vj:5 vd:5
-vssrarni_hu_w LSX 0111 00110110 11001   imm:5 vj:5 vd:5
-vssrarni_wu_d LSX 0111 00110110 1101    imm:6 vj:5 vd:5
-vssrarni_du_q LSX 0111 00110110 111     imm:7 vj:5 vd:5
-
-vclo_b LSX 0111 00101001 11000 00000 vj:5 vd:5
-vclo_h LSX 0111 00101001 11000 00001 vj:5 vd:5
-vclo_w LSX 0111 00101001 11000 00010 vj:5 vd:5
-vclo_d LSX 0111 00101001 11000 00011 vj:5 vd:5
-vclz_b LSX 0111 00101001 11000 00100 vj:5 vd:5
-vclz_h LSX 0111 00101001 11000 00101 vj:5 vd:5
-vclz_w LSX 0111 00101001 11000 00110 vj:5 vd:5
-vclz_d LSX 0111 00101001 11000 00111 vj:5 vd:5
-
-vpcnt_b LSX 0111 00101001 11000 01000 vj:5 vd:5
-vpcnt_h LSX 0111 00101001 11000 01001 vj:5 vd:5
-vpcnt_w LSX 0111 00101001 11000 01010 vj:5 vd:5
-vpcnt_d LSX 0111 00101001 11000 01011 vj:5 vd:5
-
-vbitclr_b LSX 0111 00010000 11000 vk:5 vj:5 vd:5
-vbitclr_h LSX 0111 00010000 11001 vk:5 vj:5 vd:5
-vbitclr_w LSX 0111 00010000 11010 vk:5 vj:5 vd:5
-vbitclr_d LSX 0111 00010000 11011 vk:5 vj:5 vd:5
-vbitclri_b LSX 0111 00110001 00000 01 imm:3 vj:5 vd:5
-vbitclri_h LSX 0111 00110001 00000 1  imm:4 vj:5 vd:5
-vbitclri_w LSX 0111 00110001 00001    imm:5 vj:5 vd:5
-vbitclri_d LSX 0111 00110001 0001     imm:6 vj:5 vd:5
-vbitset_b LSX 0111 00010000 11100 vk:5 vj:5 vd:5
-vbitset_h LSX 0111 00010000 11101 vk:5 vj:5 vd:5
-vbitset_w LSX 0111 00010000 11110 vk:5 vj:5 vd:5
-vbitset_d LSX 0111 00010000 11111 vk:5 vj:5 vd:5
-vbitseti_b LSX 0111 00110001 01000 01 imm:3 vj:5 vd:5
-vbitseti_h LSX 0111 00110001 01000 1  imm:4 vj:5 vd:5
-vbitseti_w LSX 0111 00110001 01001    imm:5 vj:5 vd:5
-vbitseti_d LSX 0111 00110001 0101     imm:6 vj:5 vd:5
-vbitrev_b LSX 0111 00010001 00000 vk:5 vj:5 vd:5
-vbitrev_h LSX 0111 00010001 00001 vk:5 vj:5 vd:5
-vbitrev_w LSX 0111 00010001 00010 vk:5 vj:5 vd:5
-vbitrev_d LSX 0111 00010001 00011 vk:5 vj:5 vd:5
-vbitrevi_b LSX 0111 00110001 10000 01 imm:3 vj:5 vd:5
-vbitrevi_h LSX 0111 00110001 10000 1  imm:4 vj:5 vd:5
-vbitrevi_w LSX 0111 00110001 10001    imm:5 vj:5 vd:5
-vbitrevi_d LSX 0111 00110001 1001     imm:6 vj:5 vd:5
-
-vfrstp_b LSX 0111 00010010 10110 vk:5 vj:5 vd:5
-vfrstp_h LSX 0111 00010010 10111 vk:5 vj:5 vd:5
-vfrstpi_b LSX 0111 00101001 10100 imm:5 vj:5 vd:5
-vfrstpi_h LSX 0111 00101001 10101 imm:5 vj:5 vd:5
-
-vfadd_s LSX 0111 00010011 00001 vk:5 vj:5 vd:5
-vfadd_d LSX 0111 00010011 00010 vk:5 vj:5 vd:5
-vfsub_s LSX 0111 00010011 00101 vk:5 vj:5 vd:5
-vfsub_d LSX 0111 00010011 00110 vk:5 vj:5 vd:5
-vfmul_s LSX 0111 00010011 10001 vk:5 vj:5 vd:5
-vfmul_d LSX 0111 00010011 10010 vk:5 vj:5 vd:5
-vfdiv_s LSX 0111 00010011 10101 vk:5 vj:5 vd:5
-vfdiv_d LSX 0111 00010011 10110 vk:5 vj:5 vd:5
-
-vfmadd_s LSX 0000 10010001 va:5 vk:5 vj:5 vd:5
-vfmadd_d LSX 0000 10010010 va:5 vk:5 vj:5 vd:5
-vfmsub_s LSX 0000 10010101 va:5 vk:5 vj:5 vd:5
-vfmsub_d LSX 0000 10010110 va:5 vk:5 vj:5 vd:5
-vfnmadd_s LSX 0000 10011001 va:5 vk:5 vj:5 vd:5
-vfnmadd_d LSX 0000 10011010 va:5 vk:5 vj:5 vd:5
-vfnmsub_s LSX 0000 10011101 va:5 vk:5 vj:5 vd:5
-vfnmsub_d LSX 0000 10011110 va:5 vk:5 vj:5 vd:5
-
-vfmax_s LSX 0111 00010011 11001 vk:5 vj:5 vd:5
-vfmax_d LSX 0111 00010011 11010 vk:5 vj:5 vd:5
-vfmin_s LSX 0111 00010011 11101 vk:5 vj:5 vd:5
-vfmin_d LSX 0111 00010011 11110 vk:5 vj:5 vd:5
-
-vfmaxa_s LSX 0111 00010100 00001 vk:5 vj:5 vd:5
-vfmaxa_d LSX 0111 00010100 00010 vk:5 vj:5 vd:5
-vfmina_s LSX 0111 00010100 00101 vk:5 vj:5 vd:5
-vfmina_d LSX 0111 00010100 00110 vk:5 vj:5 vd:5
-
-vflogb_s LSX 0111 00101001 11001 10001 vj:5 vd:5
-vflogb_d LSX 0111 00101001 11001 10010 vj:5 vd:5
-
-vfclass_s LSX 0111 00101001 11001 10101 vj:5 vd:5
-vfclass_d LSX 0111 00101001 11001 10110 vj:5 vd:5
-
-vfsqrt_s LSX 0111 00101001 11001 11001 vj:5 vd:5
-vfsqrt_d LSX 0111 00101001 11001 11010 vj:5 vd:5
-vfrecip_s LSX 0111 00101001 11001 11101 vj:5 vd:5
-vfrecip_d LSX 0111 00101001 11001 11110 vj:5 vd:5
-vfrsqrt_s LSX 0111 00101001 11010 00001 vj:5 vd:5
-vfrsqrt_d LSX 0111 00101001 11010 00010 vj:5 vd:5
-
-vfcvtl_s_h LSX 0111 00101001 11011 11010 vj:5 vd:5
-vfcvth_s_h LSX 0111 00101001 11011 11011 vj:5 vd:5
-vfcvtl_d_s LSX 0111 00101001 11011 11100 vj:5 vd:5
-vfcvth_d_s LSX 0111 00101001 11011 11101 vj:5 vd:5
-vfcvt_h_s LSX 0111 00010100 01100 vk:5 vj:5 vd:5
-vfcvt_s_d LSX 0111 00010100 01101 vk:5 vj:5 vd:5
-
-vfrint_s LSX 0111 00101001 11010 01101 vj:5 vd:5
-vfrint_d LSX 0111 00101001 11010 01110 vj:5 vd:5
-vfrintrm_s LSX 0111 00101001 11010 10001 vj:5 vd:5
-vfrintrm_d LSX 0111 00101001 11010 10010 vj:5 vd:5
-vfrintrp_s LSX 0111 00101001 11010 10101 vj:5 vd:5
-vfrintrp_d LSX 0111 00101001 11010 10110 vj:5 vd:5
-vfrintrz_s LSX 0111 00101001 11010 11001 vj:5 vd:5
-vfrintrz_d LSX 0111 00101001 11010 11010 vj:5 vd:5
-vfrintrne_s LSX 0111 00101001 11010 11101 vj:5 vd:5
-vfrintrne_d LSX 0111 00101001 11010 11110 vj:5 vd:5
-
-vftint_w_s LSX 0111 00101001 11100 01100 vj:5 vd:5
-vftint_l_d LSX 0111 00101001 11100 01101 vj:5 vd:5
-vftintrm_w_s LSX 0111 00101001 11100 01110 vj:5 vd:5
-vftintrm_l_d LSX 0111 00101001 11100 01111 vj:5 vd:5
-vftintrp_w_s LSX 0111 00101001 11100 10000 vj:5 vd:5
-vftintrp_l_d LSX 0111 00101001 11100 10001 vj:5 vd:5
-vftintrz_w_s LSX 0111 00101001 11100 10010 vj:5 vd:5
-vftintrz_l_d LSX 0111 00101001 11100 10011 vj:5 vd:5
-vftintrne_w_s LSX 0111 00101001 11100 10100 vj:5 vd:5
-vftintrne_l_d LSX 0111 00101001 11100 10101 vj:5 vd:5
-vftint_wu_s LSX 0111 00101001 11100 10110 vj:5 vd:5
-vftint_lu_d LSX 0111 00101001 11100 10111 vj:5 vd:5
-vftintrz_wu_s LSX 0111 00101001 11100 11100 vj:5 vd:5
-vftintrz_lu_d LSX 0111 00101001 11100 11101 vj:5 vd:5
-vftint_w_d LSX 0111 00010100 10011 vk:5 vj:5 vd:5
-vftintrm_w_d LSX 0111 00010100 10100 vk:5 vj:5 vd:5
-vftintrp_w_d LSX 0111 00010100 10101 vk:5 vj:5 vd:5
-vftintrz_w_d LSX 0111 00010100 10110 vk:5 vj:5 vd:5
-vftintrne_w_d LSX 0111 00010100 10111 vk:5 vj:5 vd:5
-vftintl_l_s LSX 0111 00101001 11101 00000 vj:5 vd:5
-vftinth_l_s LSX 0111 00101001 11101 00001 vj:5 vd:5
-vftintrml_l_s LSX 0111 00101001 11101 00010 vj:5 vd:5
-vftintrmh_l_s LSX 0111 00101001 11101 00011 vj:5 vd:5
-vftintrpl_l_s LSX 0111 00101001 11101 00100 vj:5 vd:5
-vftintrph_l_s LSX 0111 00101001 11101 00101 vj:5 vd:5
-vftintrzl_l_s LSX 0111 00101001 11101 00110 vj:5 vd:5
-vftintrzh_l_s LSX 0111 00101001 11101 00111 vj:5 vd:5
-vftintrnel_l_s LSX 0111 00101001 11101 01000 vj:5 vd:5
-vftintrneh_l_s LSX 0111 00101001 11101 01001 vj:5 vd:5
-
-vffint_s_w LSX 0111 00101001 11100 00000 vj:5 vd:5
-vffint_s_wu LSX 0111 00101001 11100 00001 vj:5 vd:5
-vffint_d_l LSX 0111 00101001 11100 00010 vj:5 vd:5
-vffint_d_lu LSX 0111 00101001 11100 00011 vj:5 vd:5
-vffintl_d_w LSX 0111 00101001 11100 00100 vj:5 vd:5
-vffinth_d_w LSX 0111 00101001 11100 00101 vj:5 vd:5
-vffint_s_l LSX 0111 00010100 10000 vk:5 vj:5 vd:5
-
-vseq_b LSX 0111 00000000 00000 vk:5 vj:5 vd:5
-vseq_h LSX 0111 00000000 00001 vk:5 vj:5 vd:5
-vseq_w LSX 0111 00000000 00010 vk:5 vj:5 vd:5
-vseq_d LSX 0111 00000000 00011 vk:5 vj:5 vd:5
-vseqi_b LSX 0111 00101000 00000 imm:5 vj:5 vd:5
-vseqi_h LSX 0111 00101000 00001 imm:5 vj:5 vd:5
-vseqi_w LSX 0111 00101000 00010 imm:5 vj:5 vd:5
-vseqi_d LSX 0111 00101000 00011 imm:5 vj:5 vd:5
-
-vsle_b LSX 0111 00000000 00100 vk:5 vj:5 vd:5
-vsle_h LSX 0111 00000000 00101 vk:5 vj:5 vd:5
-vsle_w LSX 0111 00000000 00110 vk:5 vj:5 vd:5
-vsle_d LSX 0111 00000000 00111 vk:5 vj:5 vd:5
-vslei_b LSX 0111 00101000 00100 imm:5 vj:5 vd:5
-vslei_h LSX 0111 00101000 00101 imm:5 vj:5 vd:5
-vslei_w LSX 0111 00101000 00110 imm:5 vj:5 vd:5
-vslei_d LSX 0111 00101000 00111 imm:5 vj:5 vd:5
-vsle_bu LSX 0111 00000000 01000 vk:5 vj:5 vd:5
-vsle_hu LSX 0111 00000000 01001 vk:5 vj:5 vd:5
-vsle_wu LSX 0111 00000000 01010 vk:5 vj:5 vd:5
-vsle_du LSX 0111 00000000 01011 vk:5 vj:5 vd:5
-vslei_bu LSX 0111 00101000 01000 imm:5 vj:5 vd:5
-vslei_hu LSX 0111 00101000 01000 imm:5 vj:5 vd:5
-vslei_wu LSX 0111 00101000 01010 imm:5 vj:5 vd:5
-vslei_du LSX 0111 00101000 01010 imm:5 vj:5 vd:5
-
-vslt_b LSX 0111 00000000 01100 vk:5 vj:5 vd:5
-vslt_h LSX 0111 00000000 01101 vk:5 vj:5 vd:5
-vslt_w LSX 0111 00000000 01110 vk:5 vj:5 vd:5
-vslt_d LSX 0111 00000000 01111 vk:5 vj:5 vd:5
-vslti_b LSX 0111 00101000 01100 imm:5 vj:5 vd:5
-vslti_h LSX 0111 00101000 01101 imm:5 vj:5 vd:5
-vslti_w LSX 0111 00101000 01110 imm:5 vj:5 vd:5
-vslti_d LSX 0111 00101000 01111 imm:5 vj:5 vd:5
-vslt_bu LSX 0111 00000000 10000 vk:5 vj:5 vd:5
-vslt_hu LSX 0111 00000000 10001 vk:5 vj:5 vd:5
-vslt_wu LSX 0111 00000000 10010 vk:5 vj:5 vd:5
-vslt_du LSX 0111 00000000 10011 vk:5 vj:5 vd:5
-vslti_bu LSX 0111 00101000 10000 imm:5 vj:5 vd:5
-vslti_hu LSX 0111 00101000 10001 imm:5 vj:5 vd:5
-vslti_wu LSX 0111 00101000 10010 imm:5 vj:5 vd:5
-vslti_du LSX 0111 00101000 10011 imm:5 vj:5 vd:5
+    !constraints { $imm = sextract($imm, 5);} \
+    !clean { clean_lsx_result($vd); }
+
+vmin_bu LSX 0111 00000111 01100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmin_hu LSX 0111 00000111 01101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmin_wu LSX 0111 00000111 01110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmin_du LSX 0111 00000111 01111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmini_bu LSX 0111 00101001 01100 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmini_hu LSX 0111 00101001 01101 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmini_wu LSX 0111 00101001 01110 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmini_du LSX 0111 00101001 01111 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vmul_b LSX 0111 00001000 01000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmul_h LSX 0111 00001000 01001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmul_w LSX 0111 00001000 01010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmul_d LSX 0111 00001000 01011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmuh_b LSX 0111 00001000 01100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmuh_h LSX 0111 00001000 01101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmuh_w LSX 0111 00001000 01110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmuh_d LSX 0111 00001000 01111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmuh_bu LSX 0111 00001000 10000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmuh_hu LSX 0111 00001000 10001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmuh_wu LSX 0111 00001000 10010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmuh_du LSX 0111 00001000 10011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vmulwev_h_b LSX 0111 00001001 00000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmulwev_w_h LSX 0111 00001001 00001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmulwev_d_w LSX 0111 00001001 00010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmulwev_q_d LSX 0111 00001001 00011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmulwod_h_b LSX 0111 00001001 00100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmulwod_w_h LSX 0111 00001001 00101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmulwod_d_w LSX 0111 00001001 00110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmulwod_q_d LSX 0111 00001001 00111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmulwev_h_bu LSX 0111 00001001 10000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmulwev_w_hu LSX 0111 00001001 10001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmulwev_d_wu LSX 0111 00001001 10010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmulwev_q_du LSX 0111 00001001 10011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmulwod_h_bu LSX 0111 00001001 10100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmulwod_w_hu LSX 0111 00001001 10101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmulwod_d_wu LSX 0111 00001001 10110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmulwod_q_du LSX 0111 00001001 10111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmulwev_h_bu_b LSX 0111 00001010 00000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmulwev_w_hu_h LSX 0111 00001010 00001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmulwev_d_wu_w LSX 0111 00001010 00010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmulwev_q_du_d LSX 0111 00001010 00011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmulwod_h_bu_b LSX 0111 00001010 00100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmulwod_w_hu_h LSX 0111 00001010 00101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmulwod_d_wu_w LSX 0111 00001010 00110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmulwod_q_du_d LSX 0111 00001010 00111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vmadd_b LSX 0111 00001010 10000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmadd_h LSX 0111 00001010 10001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmadd_w LSX 0111 00001010 10010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmadd_d LSX 0111 00001010 10011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmsub_b LSX 0111 00001010 10100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmsub_h LSX 0111 00001010 10101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmsub_w LSX 0111 00001010 10110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmsub_d LSX 0111 00001010 10111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vmaddwev_h_b LSX 0111 00001010 11000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmaddwev_w_h LSX 0111 00001010 11001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmaddwev_d_w LSX 0111 00001010 11010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmaddwev_q_d LSX 0111 00001010 11011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmaddwod_h_b LSX 0111 00001010 11100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmaddwod_w_h LSX 0111 00001010 11101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmaddwod_d_w LSX 0111 00001010 11110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmaddwod_q_d LSX 0111 00001010 11111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmaddwev_h_bu LSX 0111 00001011 01000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmaddwev_w_hu LSX 0111 00001011 01001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmaddwev_d_wu LSX 0111 00001011 01010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmaddwev_q_du LSX 0111 00001011 01011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmaddwod_h_bu LSX 0111 00001011 01100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmaddwod_w_hu LSX 0111 00001011 01101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmaddwod_d_wu LSX 0111 00001011 01110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmaddwod_q_du LSX 0111 00001011 01111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmaddwev_h_bu_b LSX 0111 00001011 11000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmaddwev_w_hu_h LSX 0111 00001011 11001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmaddwev_d_wu_w LSX 0111 00001011 11010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmaddwev_q_du_d LSX 0111 00001011 11011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmaddwod_h_bu_b LSX 0111 00001011 11100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmaddwod_w_hu_h LSX 0111 00001011 11101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmaddwod_d_wu_w LSX 0111 00001011 11110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmaddwod_q_du_d LSX 0111 00001011 11111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vdiv_b LSX 0111 00001110 00000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vdiv_h LSX 0111 00001110 00001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vdiv_w LSX 0111 00001110 00010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vdiv_d LSX 0111 00001110 00011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vdiv_bu LSX 0111 00001110 01000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vdiv_hu LSX 0111 00001110 01001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vdiv_wu LSX 0111 00001110 01010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vdiv_du LSX 0111 00001110 01011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmod_b LSX 0111 00001110 00100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmod_h LSX 0111 00001110 00101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmod_w LSX 0111 00001110 00110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmod_d LSX 0111 00001110 00111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmod_bu LSX 0111 00001110 01100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmod_hu LSX 0111 00001110 01101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmod_wu LSX 0111 00001110 01110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmod_du LSX 0111 00001110 01111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vsat_b LSX 0111 00110010 01000 01 imm:3 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsat_h LSX 0111 00110010 01000 1  imm:4 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsat_w LSX 0111 00110010 01001    imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsat_d LSX 0111 00110010 0101     imm:6 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsat_bu LSX 0111 00110010 10000 01 imm:3 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsat_hu LSX 0111 00110010 10000 1  imm:4 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsat_wu LSX 0111 00110010 10001    imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsat_du LSX 0111 00110010 1001     imm:6 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vexth_h_b LSX 0111 00101001 11101 11000 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vexth_w_h LSX 0111 00101001 11101 11001 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vexth_d_w LSX 0111 00101001 11101 11010 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vexth_q_d LSX 0111 00101001 11101 11011 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vexth_hu_bu LSX 0111 00101001 11101 11100 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vexth_wu_hu LSX 0111 00101001 11101 11101 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vexth_du_wu LSX 0111 00101001 11101 11110 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vexth_qu_du LSX 0111 00101001 11101 11111 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vsigncov_b LSX 0111 00010010 11100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsigncov_h LSX 0111 00010010 11101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsigncov_w LSX 0111 00010010 11110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsigncov_d LSX 0111 00010010 11111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vmskltz_b LSX 0111 00101001 11000 10000 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmskltz_h LSX 0111 00101001 11000 10001 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmskltz_w LSX 0111 00101001 11000 10010 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmskltz_d LSX 0111 00101001 11000 10011 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmskgez_b LSX 0111 00101001 11000 10100 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vmsknz_b LSX 0111 00101001 11000 11000 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vand_v LSX 0111 00010010 01100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vor_v LSX 0111 00010010 01101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vxor_v LSX 0111 00010010 01110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vnor_v LSX 0111 00010010 01111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vandn_v LSX 0111 00010010 10000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vorn_v LSX 0111 00010010 10001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vandi_b LSX 0111 00111101 00 imm:8 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vori_b LSX 0111 00111101 01 imm:8 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vxori_b LSX 0111 00111101 10 imm:8 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vnori_b LSX 0111 00111101 11 imm:8 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vsll_b LSX 0111 00001110 10000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsll_h LSX 0111 00001110 10001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsll_w LSX 0111 00001110 10010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsll_d LSX 0111 00001110 10011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vslli_b LSX 0111 00110010 11000 01 imm:3 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vslli_h LSX 0111 00110010 11000 1  imm:4 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vslli_w LSX 0111 00110010 11001    imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vslli_d LSX 0111 00110010 1101     imm:6 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vsrl_b LSX 0111 00001110 10100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrl_h LSX 0111 00001110 10101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrl_w LSX 0111 00001110 10110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrl_d LSX 0111 00001110 10111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrli_b LSX 0111 00110011 00000 01 imm:3 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrli_h LSX 0111 00110011 00000 1  imm:4 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrli_w LSX 0111 00110011 00001    imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrli_d LSX 0111 00110011 0001     imm:6 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vsra_b LSX 0111 00001110 11000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsra_h LSX 0111 00001110 11001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsra_w LSX 0111 00001110 11010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsra_d LSX 0111 00001110 11011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrai_b LSX 0111 00110011 01000 01 imm:3 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrai_h LSX 0111 00110011 01000 1  imm:4 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrai_w LSX 0111 00110011 01001    imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrai_d LSX 0111 00110011 0101     imm:6 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vrotr_b LSX 0111 00001110 11100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vrotr_h LSX 0111 00001110 11101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vrotr_w LSX 0111 00001110 11110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vrotr_d LSX 0111 00001110 11111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vrotri_b LSX 0111 00101010 00000 01 imm:3 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vrotri_h LSX 0111 00101010 00000 1  imm:4 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vrotri_w LSX 0111 00101010 00001    imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vrotri_d LSX 0111 00101010 0001     imm:6 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vsllwil_h_b LSX 0111 00110000 10000 01 imm:3 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsllwil_w_h LSX 0111 00110000 10000 1  imm:4 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsllwil_d_w LSX 0111 00110000 10001    imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vextl_q_d LSX 0111 00110000 10010 00000 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsllwil_hu_bu LSX 0111 00110000 11000 01 imm:3 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsllwil_wu_hu LSX 0111 00110000 11000 1  imm:4 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsllwil_du_wu LSX 0111 00110000 11001    imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vextl_qu_du LSX 0111 00110000 11010 00000 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vsrlr_b LSX 0111 00001111 00000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrlr_h LSX 0111 00001111 00001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrlr_w LSX 0111 00001111 00010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrlr_d LSX 0111 00001111 00011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrlri_b LSX 0111 00101010 01000 01 imm:3 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrlri_h LSX 0111 00101010 01000 1  imm:4 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrlri_w LSX 0111 00101010 01001    imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrlri_d LSX 0111 00101010 0101     imm:6 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vsrar_b LSX 0111 00001111 00100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrar_h LSX 0111 00001111 00101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrar_w LSX 0111 00001111 00110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrar_d LSX 0111 00001111 00111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrari_b LSX 0111 00101010 10000 01 imm:3 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrari_h LSX 0111 00101010 10000 1  imm:4 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrari_w LSX 0111 00101010 10001    imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrari_d LSX 0111 00101010 1001     imm:6 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vsrln_b_h LSX 0111 00001111 01001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrln_h_w LSX 0111 00001111 01010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrln_w_d LSX 0111 00001111 01011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsran_b_h LSX 0111 00001111 01101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsran_h_w LSX 0111 00001111 01110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsran_w_d LSX 0111 00001111 01111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vsrlni_b_h LSX 0111 00110100 00000 1 imm:4 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrlni_h_w LSX 0111 00110100 00001   imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrlni_w_d LSX 0111 00110100 0001    imm:6 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrlni_d_q LSX 0111 00110100 001     imm:7 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrani_b_h LSX 0111 00110101 10000 1 imm:4 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrani_h_w LSX 0111 00110101 10001   imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrani_w_d LSX 0111 00110101 1001    imm:6 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrani_d_q LSX 0111 00110101 101     imm:7 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vsrlrn_b_h LSX 0111 00001111 10001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrlrn_h_w LSX 0111 00001111 10010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrlrn_w_d LSX 0111 00001111 10011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrarn_b_h LSX 0111 00001111 10101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrarn_h_w LSX 0111 00001111 10110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrarn_w_d LSX 0111 00001111 10111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vsrlrni_b_h LSX 0111 00110100 01000 1 imm:4 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrlrni_h_w LSX 0111 00110100 01001   imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrlrni_w_d LSX 0111 00110100 0101    imm:6 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrlrni_d_q LSX 0111 00110100 011     imm:7 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrarni_b_h LSX 0111 00110101 11000 1 imm:4 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrarni_h_w LSX 0111 00110101 11001   imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrarni_w_d LSX 0111 00110101 1101    imm:6 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsrarni_d_q LSX 0111 00110101 111     imm:7 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vssrln_b_h LSX 0111 00001111 11001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrln_h_w LSX 0111 00001111 11010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrln_w_d LSX 0111 00001111 11011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssran_b_h LSX 0111 00001111 11101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssran_h_w LSX 0111 00001111 11110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssran_w_d LSX 0111 00001111 11111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrln_bu_h LSX 0111 00010000 01001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrln_hu_w LSX 0111 00010000 01010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrln_wu_d LSX 0111 00010000 01011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssran_bu_h LSX 0111 00010000 01101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssran_hu_w LSX 0111 00010000 01110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssran_wu_d LSX 0111 00010000 01111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vssrlni_b_h LSX 0111 00110100 10000 1 imm:4 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrlni_h_w LSX 0111 00110100 10001   imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrlni_w_d LSX 0111 00110100 1001    imm:6 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrlni_d_q LSX 0111 00110100 101     imm:7 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrani_b_h LSX 0111 00110110 00000 1 imm:4 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrani_h_w LSX 0111 00110110 00001   imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrani_w_d LSX 0111 00110110 0001    imm:6 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrani_d_q LSX 0111 00110110 001     imm:7 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrlni_bu_h LSX 0111 00110100 11000 1 imm:4 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrlni_hu_w LSX 0111 00110100 11001   imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrlni_wu_d LSX 0111 00110100 1101    imm:6 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrlni_du_q LSX 0111 00110100 111     imm:7 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrani_bu_h LSX 0111 00110110 01000 1 imm:4 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrani_hu_w LSX 0111 00110110 01001   imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrani_wu_d LSX 0111 00110110 0101    imm:6 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrani_du_q LSX 0111 00110110 011     imm:7 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vssrlrn_b_h LSX 0111 00010000 00001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrlrn_h_w LSX 0111 00010000 00010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrlrn_w_d LSX 0111 00010000 00011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrarn_b_h LSX 0111 00010000 00101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrarn_h_w LSX 0111 00010000 00110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrarn_w_d LSX 0111 00010000 00111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrlrn_bu_h LSX 0111 00010000 10001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrlrn_hu_w LSX 0111 00010000 10010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrlrn_wu_d LSX 0111 00010000 10011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrarn_bu_h LSX 0111 00010000 10101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrarn_hu_w LSX 0111 00010000 10110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrarn_wu_d LSX 0111 00010000 10111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vssrlrni_b_h LSX 0111 00110101 00000 1 imm:4 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrlrni_h_w LSX 0111 00110101 00001   imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrlrni_w_d LSX 0111 00110101 0001    imm:6 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrlrni_d_q LSX 0111 00110101 001     imm:7 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrarni_b_h LSX 0111 00110110 10000 1 imm:4 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrarni_h_w LSX 0111 00110110 10001   imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrarni_w_d LSX 0111 00110110 1001    imm:6 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrarni_d_q LSX 0111 00110110 101     imm:7 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrlrni_hu_w LSX 0111 00110101 01001   imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrlrni_wu_d LSX 0111 00110101 0101    imm:6 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrlrni_du_q LSX 0111 00110101 011     imm:7 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrarni_bu_h LSX 0111 00110110 11000 1 imm:4 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrarni_hu_w LSX 0111 00110110 11001   imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrarni_wu_d LSX 0111 00110110 1101    imm:6 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vssrarni_du_q LSX 0111 00110110 111     imm:7 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vclo_b LSX 0111 00101001 11000 00000 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vclo_h LSX 0111 00101001 11000 00001 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vclo_w LSX 0111 00101001 11000 00010 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vclo_d LSX 0111 00101001 11000 00011 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vclz_b LSX 0111 00101001 11000 00100 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vclz_h LSX 0111 00101001 11000 00101 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vclz_w LSX 0111 00101001 11000 00110 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vclz_d LSX 0111 00101001 11000 00111 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vpcnt_b LSX 0111 00101001 11000 01000 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vpcnt_h LSX 0111 00101001 11000 01001 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vpcnt_w LSX 0111 00101001 11000 01010 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vpcnt_d LSX 0111 00101001 11000 01011 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vbitclr_b LSX 0111 00010000 11000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vbitclr_h LSX 0111 00010000 11001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vbitclr_w LSX 0111 00010000 11010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vbitclr_d LSX 0111 00010000 11011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vbitclri_b LSX 0111 00110001 00000 01 imm:3 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vbitclri_h LSX 0111 00110001 00000 1  imm:4 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vbitclri_w LSX 0111 00110001 00001    imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vbitclri_d LSX 0111 00110001 0001     imm:6 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vbitset_b LSX 0111 00010000 11100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vbitset_h LSX 0111 00010000 11101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vbitset_w LSX 0111 00010000 11110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vbitset_d LSX 0111 00010000 11111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vbitseti_b LSX 0111 00110001 01000 01 imm:3 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vbitseti_h LSX 0111 00110001 01000 1  imm:4 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vbitseti_w LSX 0111 00110001 01001    imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vbitseti_d LSX 0111 00110001 0101     imm:6 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vbitrev_b LSX 0111 00010001 00000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vbitrev_h LSX 0111 00010001 00001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vbitrev_w LSX 0111 00010001 00010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vbitrev_d LSX 0111 00010001 00011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vbitrevi_b LSX 0111 00110001 10000 01 imm:3 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vbitrevi_h LSX 0111 00110001 10000 1  imm:4 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vbitrevi_w LSX 0111 00110001 10001    imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vbitrevi_d LSX 0111 00110001 1001     imm:6 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vfrstp_b LSX 0111 00010010 10110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfrstp_h LSX 0111 00010010 10111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfrstpi_b LSX 0111 00101001 10100 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfrstpi_h LSX 0111 00101001 10101 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vfadd_s LSX 0111 00010011 00001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfadd_d LSX 0111 00010011 00010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfsub_s LSX 0111 00010011 00101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfsub_d LSX 0111 00010011 00110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfmul_s LSX 0111 00010011 10001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfmul_d LSX 0111 00010011 10010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfdiv_s LSX 0111 00010011 10101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfdiv_d LSX 0111 00010011 10110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vfmadd_s LSX 0000 10010001 va:5 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfmadd_d LSX 0000 10010010 va:5 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfmsub_s LSX 0000 10010101 va:5 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfmsub_d LSX 0000 10010110 va:5 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfnmadd_s LSX 0000 10011001 va:5 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfnmadd_d LSX 0000 10011010 va:5 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfnmsub_s LSX 0000 10011101 va:5 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfnmsub_d LSX 0000 10011110 va:5 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vfmax_s LSX 0111 00010011 11001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfmax_d LSX 0111 00010011 11010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfmin_s LSX 0111 00010011 11101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfmin_d LSX 0111 00010011 11110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vfmaxa_s LSX 0111 00010100 00001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfmaxa_d LSX 0111 00010100 00010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfmina_s LSX 0111 00010100 00101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfmina_d LSX 0111 00010100 00110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vflogb_s LSX 0111 00101001 11001 10001 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vflogb_d LSX 0111 00101001 11001 10010 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vfclass_s LSX 0111 00101001 11001 10101 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfclass_d LSX 0111 00101001 11001 10110 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vfsqrt_s LSX 0111 00101001 11001 11001 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfsqrt_d LSX 0111 00101001 11001 11010 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfrecip_s LSX 0111 00101001 11001 11101 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfrecip_d LSX 0111 00101001 11001 11110 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfrsqrt_s LSX 0111 00101001 11010 00001 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfrsqrt_d LSX 0111 00101001 11010 00010 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vfcvtl_s_h LSX 0111 00101001 11011 11010 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfcvth_s_h LSX 0111 00101001 11011 11011 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfcvtl_d_s LSX 0111 00101001 11011 11100 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfcvth_d_s LSX 0111 00101001 11011 11101 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfcvt_h_s LSX 0111 00010100 01100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfcvt_s_d LSX 0111 00010100 01101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vfrint_s LSX 0111 00101001 11010 01101 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfrint_d LSX 0111 00101001 11010 01110 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfrintrm_s LSX 0111 00101001 11010 10001 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfrintrm_d LSX 0111 00101001 11010 10010 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfrintrp_s LSX 0111 00101001 11010 10101 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfrintrp_d LSX 0111 00101001 11010 10110 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfrintrz_s LSX 0111 00101001 11010 11001 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfrintrz_d LSX 0111 00101001 11010 11010 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfrintrne_s LSX 0111 00101001 11010 11101 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vfrintrne_d LSX 0111 00101001 11010 11110 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vftint_w_s LSX 0111 00101001 11100 01100 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vftint_l_d LSX 0111 00101001 11100 01101 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vftintrm_w_s LSX 0111 00101001 11100 01110 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vftintrm_l_d LSX 0111 00101001 11100 01111 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vftintrp_w_s LSX 0111 00101001 11100 10000 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vftintrp_l_d LSX 0111 00101001 11100 10001 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vftintrz_w_s LSX 0111 00101001 11100 10010 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vftintrz_l_d LSX 0111 00101001 11100 10011 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vftintrne_w_s LSX 0111 00101001 11100 10100 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vftintrne_l_d LSX 0111 00101001 11100 10101 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vftint_wu_s LSX 0111 00101001 11100 10110 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vftint_lu_d LSX 0111 00101001 11100 10111 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vftintrz_wu_s LSX 0111 00101001 11100 11100 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vftintrz_lu_d LSX 0111 00101001 11100 11101 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vftint_w_d LSX 0111 00010100 10011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vftintrm_w_d LSX 0111 00010100 10100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vftintrp_w_d LSX 0111 00010100 10101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vftintrz_w_d LSX 0111 00010100 10110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vftintrne_w_d LSX 0111 00010100 10111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vftintl_l_s LSX 0111 00101001 11101 00000 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vftinth_l_s LSX 0111 00101001 11101 00001 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vftintrml_l_s LSX 0111 00101001 11101 00010 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vftintrmh_l_s LSX 0111 00101001 11101 00011 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vftintrpl_l_s LSX 0111 00101001 11101 00100 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vftintrph_l_s LSX 0111 00101001 11101 00101 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vftintrzl_l_s LSX 0111 00101001 11101 00110 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vftintrzh_l_s LSX 0111 00101001 11101 00111 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vftintrnel_l_s LSX 0111 00101001 11101 01000 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vftintrneh_l_s LSX 0111 00101001 11101 01001 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vffint_s_w LSX 0111 00101001 11100 00000 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vffint_s_wu LSX 0111 00101001 11100 00001 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vffint_d_l LSX 0111 00101001 11100 00010 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vffint_d_lu LSX 0111 00101001 11100 00011 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vffintl_d_w LSX 0111 00101001 11100 00100 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vffinth_d_w LSX 0111 00101001 11100 00101 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vffint_s_l LSX 0111 00010100 10000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vseq_b LSX 0111 00000000 00000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vseq_h LSX 0111 00000000 00001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vseq_w LSX 0111 00000000 00010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vseq_d LSX 0111 00000000 00011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vseqi_b LSX 0111 00101000 00000 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vseqi_h LSX 0111 00101000 00001 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vseqi_w LSX 0111 00101000 00010 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vseqi_d LSX 0111 00101000 00011 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vsle_b LSX 0111 00000000 00100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsle_h LSX 0111 00000000 00101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsle_w LSX 0111 00000000 00110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsle_d LSX 0111 00000000 00111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vslei_b LSX 0111 00101000 00100 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vslei_h LSX 0111 00101000 00101 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vslei_w LSX 0111 00101000 00110 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vslei_d LSX 0111 00101000 00111 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsle_bu LSX 0111 00000000 01000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsle_hu LSX 0111 00000000 01001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsle_wu LSX 0111 00000000 01010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vsle_du LSX 0111 00000000 01011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vslei_bu LSX 0111 00101000 01000 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vslei_hu LSX 0111 00101000 01000 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vslei_wu LSX 0111 00101000 01010 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vslei_du LSX 0111 00101000 01010 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vslt_b LSX 0111 00000000 01100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vslt_h LSX 0111 00000000 01101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vslt_w LSX 0111 00000000 01110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vslt_d LSX 0111 00000000 01111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vslti_b LSX 0111 00101000 01100 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vslti_h LSX 0111 00101000 01101 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vslti_w LSX 0111 00101000 01110 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vslti_d LSX 0111 00101000 01111 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vslt_bu LSX 0111 00000000 10000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vslt_hu LSX 0111 00000000 10001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vslt_wu LSX 0111 00000000 10010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vslt_du LSX 0111 00000000 10011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vslti_bu LSX 0111 00101000 10000 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vslti_hu LSX 0111 00101000 10001 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vslti_wu LSX 0111 00101000 10010 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vslti_du LSX 0111 00101000 10011 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
 
 vfcmp_cond_s LSX 0000 11000101 cond:5 vk:5 vj:5 vd:5 \
-    !constraints { $cond > 0 && $cond < 0x12; }
+    !constraints { $cond > 0 && $cond < 0x12; } \
+    !clean { clean_lsx_result($vd); }
 vfcmp_cond_d LSX 0000 11000110 cond:5 vk:5 vj:5 vd:5 \
-    !constraints { $cond > 0 && $cond < 0x12; }
+    !constraints { $cond > 0 && $cond < 0x12; } \
+    !clean { clean_lsx_result($vd); }
 
-vbitsel_v LSX 0000 11010001 va:5 vk:5 vj:5 vd:5
+vbitsel_v LSX 0000 11010001 va:5 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
 
-vbitseli_b LSX 0111 00111100 01 imm:8 vj:5 vd:5
+vbitseli_b LSX 0111 00111100 01 imm:8 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
 
 vseteqz_v LSX 0111 00101001 11001 00110 vj:5 00 cd:3
 vsetnez_v LSX 0111 00101001 11001 00111 vj:5 00 cd:3
@@ -1287,13 +1870,17 @@ vsetallnez_w LSX 0111 00101001 11001 01110 vj:5 00 cd:3
 vsetallnez_d LSX 0111 00101001 11001 01111 vj:5 00 cd:3
 
 vinsgr2vr_b LSX 0111 00101110 10111 0    imm:4 rj:5 vd:5 \
-    !constraints { $rj != 2 && $rj != 0; }
+    !constraints { $rj != 2 && $rj != 0; } \
+    !clean { clean_lsx_result($vd); }
 vinsgr2vr_h LSX 0111 00101110 10111 10   imm:3 rj:5 vd:5 \
-    !constraints { $rj != 2 && $rj != 0; }
+    !constraints { $rj != 2 && $rj != 0; } \
+    !clean { clean_lsx_result($vd); }
 vinsgr2vr_w LSX 0111 00101110 10111 110  imm:2 rj:5 vd:5 \
-    !constraints { $rj != 2 && $rj != 0; }
+    !constraints { $rj != 2 && $rj != 0; } \
+    !clean { clean_lsx_result($vd); }
 vinsgr2vr_d LSX 0111 00101110 10111 1110 imm:1 rj:5 vd:5 \
-    !constraints { $rj != 2 && $rj != 0; }
+    !constraints { $rj != 2 && $rj != 0; } \
+    !clean { clean_lsx_result($vd); }
 vpickve2gr_b LSX 0111 00101110 11111 0    imm:4 vj:5 rd:5 \
     !constraints { $rd != 2 && $rd != 0; }
 vpickve2gr_h LSX 0111 00101110 11111 10   imm:3 vj:5 rd:5 \
@@ -1312,111 +1899,171 @@ vpickve2gr_du LSX 0111 00101111 00111 1110 imm:1 vj:5 rd:5 \
     !constraints { $rd != 2 && $rd != 0; }
 
 vreplgr2vr_b LSX 0111 00101001 11110 00000 rj:5 vd:5 \
-    !constraints { $rj != 2 && $rj != 0; }
+    !constraints { $rj != 2 && $rj != 0; } \
+    !clean { clean_lsx_result($vd); }
 vreplgr2vr_h LSX 0111 00101001 11110 00001 rj:5 vd:5 \
-    !constraints { $rj != 2 && $rj != 0; }
+    !constraints { $rj != 2 && $rj != 0; } \
+    !clean { clean_lsx_result($vd); }
 vreplgr2vr_w LSX 0111 00101001 11110 00010 rj:5 vd:5 \
-    !constraints { $rj != 2 && $rj != 0; }
+    !constraints { $rj != 2 && $rj != 0; } \
+    !clean { clean_lsx_result($vd); }
 vreplgr2vr_d LSX 0111 00101001 11110 00011 rj:5 vd:5 \
-    !constraints { $rj != 2 && $rj != 0; }
+    !constraints { $rj != 2 && $rj != 0; } \
+    !clean { clean_lsx_result($vd); }
 
 vreplve_b LSX 0111 00010010 00100 rk:5 vj:5 vd:5 \
-    !constraints { $rk != 2 && $rk != 0; }
+    !constraints { $rk != 2 && $rk != 0; } \
+    !clean { clean_lsx_result($vd); }
 vreplve_h LSX 0111 00010010 00101 rk:5 vj:5 vd:5 \
-    !constraints { $rk != 2 && $rk != 0; }
+    !constraints { $rk != 2 && $rk != 0; } \
+    !clean { clean_lsx_result($vd); }
 vreplve_w LSX 0111 00010010 00110 rk:5 vj:5 vd:5 \
-    !constraints { $rk != 2 && $rk != 0; }
+    !constraints { $rk != 2 && $rk != 0; } \
+    !clean { clean_lsx_result($vd); }
 vreplve_d LSX 0111 00010010 00111 rk:5 vj:5 vd:5 \
-    !constraints { $rk != 2 && $rk != 0; }
-
-vreplvei_b LSX 0111 00101111 01111 0    imm:4 vj:5 vd:5
-vreplvei_h LSX 0111 00101111 01111 10   imm:3 vj:5 vd:5
-vreplvei_w LSX 0111 00101111 01111 110  imm:2 vj:5 vd:5
-vreplvei_d LSX 0111 00101111 01111 1110 imm:1 vj:5 vd:5
-
-vbsll_v LSX 0111 00101000 11100 imm:5 vj:5 vd:5
-vbsrl_v LSX 0111 00101000 11101 imm:5 vj:5 vd:5
-
-vpackev_b LSX 0111 00010001 01100 vk:5 vj:5 vd:5
-vpackev_h LSX 0111 00010001 01101 vk:5 vj:5 vd:5
-vpackev_w LSX 0111 00010001 01110 vk:5 vj:5 vd:5
-vpackev_d LSX 0111 00010001 01111 vk:5 vj:5 vd:5
-vpackod_b LSX 0111 00010001 10000 vk:5 vj:5 vd:5
-vpackod_h LSX 0111 00010001 10001 vk:5 vj:5 vd:5
-vpackod_w LSX 0111 00010001 10010 vk:5 vj:5 vd:5
-vpackod_d LSX 0111 00010001 10011 vk:5 vj:5 vd:5
-
-vpickev_b LSX 0111 00010001 11100 vk:5 vj:5 vd:5
-vpickev_h LSX 0111 00010001 11101 vk:5 vj:5 vd:5
-vpickev_w LSX 0111 00010001 11110 vk:5 vj:5 vd:5
-vpickev_d LSX 0111 00010001 11111 vk:5 vj:5 vd:5
-vpickod_b LSX 0111 00010010 00000 vk:5 vj:5 vd:5
-vpickod_h LSX 0111 00010010 00001 vk:5 vj:5 vd:5
-vpickod_w LSX 0111 00010010 00010 vk:5 vj:5 vd:5
-vpickod_d LSX 0111 00010010 00011 vk:5 vj:5 vd:5
-
-vilvl_b LSX 0111 00010001 10100 vk:5 vj:5 vd:5
-vilvl_h LSX 0111 00010001 10101 vk:5 vj:5 vd:5
-vilvl_w LSX 0111 00010001 10110 vk:5 vj:5 vd:5
-vilvl_d LSX 0111 00010001 10111 vk:5 vj:5 vd:5
-vilvh_b LSX 0111 00010001 11000 vk:5 vj:5 vd:5
-vilvh_h LSX 0111 00010001 11001 vk:5 vj:5 vd:5
-vilvh_w LSX 0111 00010001 11010 vk:5 vj:5 vd:5
-vilvh_d LSX 0111 00010001 11011 vk:5 vj:5 vd:5
-
-vshuf4i_b LSX 0111 00111001 00 imm:8 vj:5 vd:5
-vshuf4i_h LSX 0111 00111001 01 imm:8 vj:5 vd:5
-vshuf4i_w LSX 0111 00111001 10 imm:8 vj:5 vd:5
-vshuf4i_d LSX 0111 00111001 11 imm:8 vj:5 vd:5
-
-vpermi_w LSX 0111 00111110 01 imm:8 vj:5 vd:5
-
-vextrins_d LSX 0111 00111000 00 imm:8 vj:5 vd:5
-vextrins_w LSX 0111 00111000 01 imm:8 vj:5 vd:5
-vextrins_h LSX 0111 00111000 10 imm:8 vj:5 vd:5
-vextrins_b LSX 0111 00111000 11 imm:8 vj:5 vd:5
+    !constraints { $rk != 2 && $rk != 0; } \
+    !clean { clean_lsx_result($vd); }
+
+vreplvei_b LSX 0111 00101111 01111 0    imm:4 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vreplvei_h LSX 0111 00101111 01111 10   imm:3 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vreplvei_w LSX 0111 00101111 01111 110  imm:2 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vreplvei_d LSX 0111 00101111 01111 1110 imm:1 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vbsll_v LSX 0111 00101000 11100 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vbsrl_v LSX 0111 00101000 11101 imm:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vpackev_b LSX 0111 00010001 01100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vpackev_h LSX 0111 00010001 01101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vpackev_w LSX 0111 00010001 01110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vpackev_d LSX 0111 00010001 01111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vpackod_b LSX 0111 00010001 10000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vpackod_h LSX 0111 00010001 10001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vpackod_w LSX 0111 00010001 10010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vpackod_d LSX 0111 00010001 10011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vpickev_b LSX 0111 00010001 11100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vpickev_h LSX 0111 00010001 11101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vpickev_w LSX 0111 00010001 11110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vpickev_d LSX 0111 00010001 11111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vpickod_b LSX 0111 00010010 00000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vpickod_h LSX 0111 00010010 00001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vpickod_w LSX 0111 00010010 00010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vpickod_d LSX 0111 00010010 00011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vilvl_b LSX 0111 00010001 10100 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vilvl_h LSX 0111 00010001 10101 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vilvl_w LSX 0111 00010001 10110 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vilvl_d LSX 0111 00010001 10111 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vilvh_b LSX 0111 00010001 11000 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vilvh_h LSX 0111 00010001 11001 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vilvh_w LSX 0111 00010001 11010 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vilvh_d LSX 0111 00010001 11011 vk:5 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vshuf4i_b LSX 0111 00111001 00 imm:8 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vshuf4i_h LSX 0111 00111001 01 imm:8 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vshuf4i_w LSX 0111 00111001 10 imm:8 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vshuf4i_d LSX 0111 00111001 11 imm:8 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vpermi_w LSX 0111 00111110 01 imm:8 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+
+vextrins_d LSX 0111 00111000 00 imm:8 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vextrins_w LSX 0111 00111000 01 imm:8 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vextrins_h LSX 0111 00111000 10 imm:8 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
+vextrins_b LSX 0111 00111000 11 imm:8 vj:5 vd:5 \
+    !clean { clean_lsx_result($vd); }
 
 vld LSX 0010 110000 si12:12 rj:5 vd:5 \
     !constraints { $rj != 0 && $rj != 2; } \
-    !memory { reg_plus_imm($rj, sextract($si12, 12)); }
+    !memory { reg_plus_imm($rj, sextract($si12, 12)); } \
+    !clean { clean_lsx_result($vd); }
 vst LSX 0010 110001 si12:12 rj:5 vd:5 \
     !constraints { $rj != 0 && $rj != 2; } \
-    !memory { reg_plus_imm($rj, sextract($si12, 12)); }
+    !memory { reg_plus_imm($rj, sextract($si12, 12)); } \
+    !clean { clean_lsx_result($vd); }
 vldx LSX 0011 10000100 00000 rk:5 rj:5 vd:5 \
     !constraints { $rj != 0 && $rj != $rk && $rk != 2 && $rj != 2; } \
-    !memory { reg_plus_reg($rj, $rk); }
+    !memory { reg_plus_reg($rj, $rk); } \
+    !clean { clean_lsx_result($vd); }
 vstx LSX 0011 10000100 01000 rk:5 rj:5 vd:5 \
     !constraints { $rj != 0 && $rj != $rk && $rk != 2 && $rj != 2; } \
-    !memory { reg_plus_reg($rj, $rk); }
+    !memory { reg_plus_reg($rj, $rk); } \
+    !clean { clean_lsx_result($vd); }
 
 vldrepl_d LSX 0011 00000001 0 si9:9 rj:5 vd:5 \
     !constraints { $rj != 0 && $rj != 2; } \
-    !memory { reg_plus_imm($rj, sextract($si9, 9) * 8); }
+    !memory { reg_plus_imm($rj, sextract($si9, 9) * 8); } \
+    !clean { clean_lsx_result($vd); }
 vldrepl_w LSX 0011 00000010   si10:10 rj:5 vd:5 \
     !constraints { $rj != 0 && $rj != 2; } \
-    !memory { reg_plus_imm($rj, sextract($si10, 10) * 4); }
+    !memory { reg_plus_imm($rj, sextract($si10, 10) * 4); } \
+    !clean { clean_lsx_result($vd); }
 vldrepl_h LSX 0011 0000010    si11:11 rj:5 vd:5 \
     !constraints { $rj != 0 && $rj != 2; } \
-    !memory { reg_plus_imm($rj, sextract($si11, 11) * 2); }
+    !memory { reg_plus_imm($rj, sextract($si11, 11) * 2); } \
+    !clean { clean_lsx_result($vd); }
 vldrepl_b LSX 0011 000010     si12:12 rj:5 vd:5 \
     !constraints { $rj != 0 && $rj != 2; } \
-    !memory { reg_plus_imm($rj, sextract($si12, 12)); }
+    !memory { reg_plus_imm($rj, sextract($si12, 12)); } \
+    !clean { clean_lsx_result($vd); }
 
 vstelm_d LSX 0011 00010001 0 si1:1 si8:8 rj:5 vd:5 \
     !constraints { $rj != 0 && $rj != 2; } \
-    !memory { reg_plus_imm($rj, sextract($si8, 8) * 8); }
+    !memory { reg_plus_imm($rj, sextract($si8, 8) * 8); } \
+    !clean { clean_lsx_result($vd); }
 vstelm_w LSX 0011 00010010   si2:2 si8:8 rj:5 vd:5 \
     !constraints { $rj != 0 && $rj != 2; } \
-    !memory { reg_plus_imm($rj, sextract($si8, 8) * 4); }
+    !memory { reg_plus_imm($rj, sextract($si8, 8) * 4); } \
+    !clean { clean_lsx_result($vd); }
 vstelm_h LSX 0011 0001010    si3:3 si8:8 rj:5 vd:5 \
     !constraints { $rj != 0 && $rj != 2; } \
-    !memory { reg_plus_imm($rj, sextract($si8, 8) * 2); }
+    !memory { reg_plus_imm($rj, sextract($si8, 8) * 2); } \
+    !clean { clean_lsx_result($vd); }
 vstelm_b LSX 0011 000110     si4:4 si8:8 rj:5 vd:5 \
     !constraints { $rj != 0 && $rj != 2; } \
-    !memory { reg_plus_imm($rj, sextract($si8, 8)); }
+    !memory { reg_plus_imm($rj, sextract($si8, 8)); } \
+    !clean { clean_lsx_result($vd); }
 
 vldi LSX 0111 00111110 00 si13:13 vd:5 \
-    !constraints { $si13 >= 0 && $si13 <= 12; }
+    !constraints { $si13 >= 0 && $si13 <= 12; } \
+    !clean { clean_lsx_result($vd); }
 
 #
 # LASX instructions
diff --git a/risugen b/risugen
index fa94a39..8a67fdf 100755
--- a/risugen
+++ b/risugen
@@ -43,7 +43,7 @@ my @pattern_re = ();            # include pattern
 my @not_pattern_re = ();        # exclude pattern
 
 # Valid block names (keys in blocks hash)
-my %valid_blockname = ( constraints => 1, memory => 1, safefloat =>1 );
+my %valid_blockname = ( constraints => 1, memory => 1, safefloat =>1, clean => 1 );
 
 sub parse_risu_directive($$@)
 {
diff --git a/risugen_loongarch64.pm b/risugen_loongarch64.pm
index b3f901d..97f00f3 100644
--- a/risugen_loongarch64.pm
+++ b/risugen_loongarch64.pm
@@ -81,6 +81,18 @@ sub nanbox_s($)
     return $fpreg;
 }
 
+sub clean_lsx_result($)
+{
+    my ($vreg) = @_;
+
+    # xvinsgr2vr.d vd, r0, 2;
+    insn32(0x76ebe000 | 2 << 10 | $vreg);
+    # xvinsgr2vr.d vd, r0, 3;
+    insn32(0x76ebe000 | 3 << 10 | $vreg);
+
+    return $vreg;
+}
+
 sub align($)
 {
     my ($a) = @_;
@@ -405,6 +417,7 @@ sub gen_one_insn($$)
         my $constraint = $rec->{blocks}{"constraints"};
         my $memblock = $rec->{blocks}{"memory"};
         my $safefloat = $rec->{blocks}{"safefloat"};
+        my $clean = $rec->{blocks}{"clean"};
 
         $insn &= ~$fixedbitmask;
         $insn |= $fixedbits;
@@ -448,6 +461,13 @@ sub gen_one_insn($$)
             $resultreg = eval_with_fields($insnname, $insn, $rec, "safefloat", $safefloat);
         }
 
+        if (defined $clean) {
+            # LSX insns only care about low 128 bit,
+            # so we use clean_lsx_result() make sure that high 128bit is 0x0;
+            my $cleanreg;
+            $cleanreg = eval_with_fields($insnname, $insn, $rec, "clean", $clean);
+        }
+
         if (defined $memblock) {
             # Clean up following a memory access instruction:
             # we need to turn the (possibly written-back) basereg
-- 
2.25.1


