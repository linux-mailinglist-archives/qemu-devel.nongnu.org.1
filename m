Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 724C17D66CF
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:30:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvaCn-00058G-LE; Wed, 25 Oct 2023 05:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qvaCk-00053J-AP
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:29:34 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qvaCd-0001e0-8i
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:29:34 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxRvHs3zhlD4A0AA--.36946S3;
 Wed, 25 Oct 2023 17:29:16 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxK9zp3zhlpuExAA--.39806S4; 
 Wed, 25 Oct 2023 17:29:14 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org,
 alex.bennee@linaro.org, maobibo@loongson.cn
Subject: [risu PATCH 2/5] loongarch: Add LASX instructions
Date: Wed, 25 Oct 2023 17:29:12 +0800
Message-Id: <20231025092915.902814-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231025092915.902814-1-gaosong@loongson.cn>
References: <20231025092915.902814-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxK9zp3zhlpuExAA--.39806S4
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

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 loongarch64.risu | 815 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 815 insertions(+)

diff --git a/loongarch64.risu b/loongarch64.risu
index 78ccee3..596de90 100644
--- a/loongarch64.risu
+++ b/loongarch64.risu
@@ -1417,3 +1417,818 @@ vstelm_b LSX 0011 000110     si4:4 si8:8 rj:5 vd:5 \
 
 vldi LSX 0111 00111110 00 si13:13 vd:5 \
     !constraints { $si13 >= 0 && $si13 <= 12; }
+
+#
+# LASX instructions
+#
+
+xvadd_b LASX 0111 01000000 10100 vk:5 vj:5 vd:5
+xvadd_h LASX 0111 01000000 10101 vk:5 vj:5 vd:5
+xvadd_w LASX 0111 01000000 10110 vk:5 vj:5 vd:5
+xvadd_d LASX 0111 01000000 10111 vk:5 vj:5 vd:5
+xvadd_q LASX 0111 01010010 11010 vk:5 vj:5 vd:5
+xvsub_b LASX 0111 01000000 11000 vk:5 vj:5 vd:5
+xvsub_h LASX 0111 01000000 11001 vk:5 vj:5 vd:5
+xvsub_w LASX 0111 01000000 11010 vk:5 vj:5 vd:5
+xvsub_d LASX 0111 01000000 11011 vk:5 vj:5 vd:5
+xvsub_q LASX 0111 01010010 11011 vk:5 vj:5 vd:5
+
+xvaddi_bu LASX 0111 01101000 10100 imm:5 vj:5 vd:5
+xvaddi_hu LASX 0111 01101000 10101 imm:5 vj:5 vd:5
+xvaddi_wu LASX 0111 01101000 10110 imm:5 vj:5 vd:5
+xvaddi_du LASX 0111 01101000 10111 imm:5 vj:5 vd:5
+xvsubi_bu LASX 0111 01101000 11000 imm:5 vj:5 vd:5
+xvsubi_hu LASX 0111 01101000 11001 imm:5 vj:5 vd:5
+xvsubi_wu LASX 0111 01101000 11010 imm:5 vj:5 vd:5
+xvsubi_du LASX 0111 01101000 11011 imm:5 vj:5 vd:5
+
+xvneg_b LASX 0111 01101001 11000 01100 vj:5 vd:5
+xvneg_h LASX 0111 01101001 11000 01101 vj:5 vd:5
+xvneg_w LASX 0111 01101001 11000 01110 vj:5 vd:5
+xvneg_d LASX 0111 01101001 11000 01111 vj:5 vd:5
+
+xvsadd_b LASX 0111 01000100 01100 vk:5 vj:5 vd:5
+xvsadd_h LASX 0111 01000100 01101 vk:5 vj:5 vd:5
+xvsadd_w LASX 0111 01000100 01110 vk:5 vj:5 vd:5
+xvsadd_d LASX 0111 01000100 01111 vk:5 vj:5 vd:5
+xvsadd_bu LASX 0111 01000100 10100 vk:5 vj:5 vd:5
+xvsadd_hu LASX 0111 01000100 10101 vk:5 vj:5 vd:5
+xvsadd_wu LASX 0111 01000100 10110 vk:5 vj:5 vd:5
+xvsadd_du LASX 0111 01000100 10111 vk:5 vj:5 vd:5
+
+xvssub_b LASX 0111 01000100 10000 vk:5 vj:5 vd:5
+xvssub_h LASX 0111 01000100 10001 vk:5 vj:5 vd:5
+xvssub_w LASX 0111 01000100 10010 vk:5 vj:5 vd:5
+xvssub_d LASX 0111 01000100 10011 vk:5 vj:5 vd:5
+xvssub_bu LASX 0111 01000100 11000 vk:5 vj:5 vd:5
+xvssub_hu LASX 0111 01000100 11001 vk:5 vj:5 vd:5
+xvssub_wu LASX 0111 01000100 11010 vk:5 vj:5 vd:5
+xvssub_du LASX 0111 01000100 11011 vk:5 vj:5 vd:5
+
+xvhaddw_h_b LASX 0111 01000101 01000 vk:5 vj:5 vd:5
+xvhaddw_w_h LASX 0111 01000101 01001 vk:5 vj:5 vd:5
+xvhaddw_d_w LASX 0111 01000101 01010 vk:5 vj:5 vd:5
+xvhaddw_q_d LASX 0111 01000101 01011 vk:5 vj:5 vd:5
+xvhaddw_hu_bu LASX 0111 01000101 10000 vk:5 vj:5 vd:5
+xvhaddw_wu_hu LASX 0111 01000101 10001 vk:5 vj:5 vd:5
+xvhaddw_du_wu LASX 0111 01000101 10010 vk:5 vj:5 vd:5
+xvhaddw_qu_du LASX 0111 01000101 10011 vk:5 vj:5 vd:5
+
+xvhsubw_h_b LASX 0111 01000101 01100 vk:5 vj:5 vd:5
+xvhsubw_w_h LASX 0111 01000101 01101 vk:5 vj:5 vd:5
+xvhsubw_d_w LASX 0111 01000101 01110 vk:5 vj:5 vd:5
+xvhsubw_q_d LASX 0111 01000101 01111 vk:5 vj:5 vd:5
+xvhsubw_hu_bu LASX 0111 01000101 10100 vk:5 vj:5 vd:5
+xvhsubw_wu_hu LASX 0111 01000101 10101 vk:5 vj:5 vd:5
+xvhsubw_du_wu LASX 0111 01000101 10110 vk:5 vj:5 vd:5
+xvhsubw_qu_du LASX 0111 01000101 10111 vk:5 vj:5 vd:5
+
+xvaddwev_h_b LASX 0111 01000001 11100 vk:5 vj:5 vd:5
+xvaddwev_w_h LASX 0111 01000001 11101 vk:5 vj:5 vd:5
+xvaddwev_d_w LASX 0111 01000001 11110 vk:5 vj:5 vd:5
+xvaddwev_q_d LASX 0111 01000001 11111 vk:5 vj:5 vd:5
+xvaddwod_h_b LASX 0111 01000010 00100 vk:5 vj:5 vd:5
+xvaddwod_w_h LASX 0111 01000010 00101 vk:5 vj:5 vd:5
+xvaddwod_d_w LASX 0111 01000010 00110 vk:5 vj:5 vd:5
+xvaddwod_q_d LASX 0111 01000010 00111 vk:5 vj:5 vd:5
+
+xvsubwev_h_b LASX 0111 01000010 00000 vk:5 vj:5 vd:5
+xvsubwev_w_h LASX 0111 01000010 00001 vk:5 vj:5 vd:5
+xvsubwev_d_w LASX 0111 01000010 00010 vk:5 vj:5 vd:5
+xvsubwev_q_d LASX 0111 01000010 00011 vk:5 vj:5 vd:5
+xvsubwod_h_b LASX 0111 01000010 01000 vk:5 vj:5 vd:5
+xvsubwod_w_h LASX 0111 01000010 01001 vk:5 vj:5 vd:5
+xvsubwod_d_w LASX 0111 01000010 01010 vk:5 vj:5 vd:5
+xvsubwod_q_d LASX 0111 01000010 01011 vk:5 vj:5 vd:5
+
+xvaddwev_h_bu LASX 0111 01000010 11100 vk:5 vj:5 vd:5
+xvaddwev_w_hu LASX 0111 01000010 11101 vk:5 vj:5 vd:5
+xvaddwev_d_wu LASX 0111 01000010 11110 vk:5 vj:5 vd:5
+xvaddwev_q_du LASX 0111 01000010 11111 vk:5 vj:5 vd:5
+xvaddwod_h_bu LASX 0111 01000011 00100 vk:5 vj:5 vd:5
+xvaddwod_w_hu LASX 0111 01000011 00101 vk:5 vj:5 vd:5
+xvaddwod_d_wu LASX 0111 01000011 00110 vk:5 vj:5 vd:5
+xvaddwod_q_du LASX 0111 01000011 00111 vk:5 vj:5 vd:5
+
+xvsubwev_h_bu LASX 0111 01000011 00000 vk:5 vj:5 vd:5
+xvsubwev_w_hu LASX 0111 01000011 00001 vk:5 vj:5 vd:5
+xvsubwev_d_wu LASX 0111 01000011 00010 vk:5 vj:5 vd:5
+xvsubwev_q_du LASX 0111 01000011 00011 vk:5 vj:5 vd:5
+xvsubwod_h_bu LASX 0111 01000011 01000 vk:5 vj:5 vd:5
+xvsubwod_w_hu LASX 0111 01000011 01001 vk:5 vj:5 vd:5
+xvsubwod_d_wu LASX 0111 01000011 01010 vk:5 vj:5 vd:5
+xvsubwod_q_du LASX 0111 01000011 01011 vk:5 vj:5 vd:5
+
+xvaddwev_h_bu_b LASX 0111 01000011 11100 vk:5 vj:5 vd:5
+xvaddwev_w_hu_h LASX 0111 01000011 11101 vk:5 vj:5 vd:5
+xvaddwev_d_wu_w LASX 0111 01000011 11110 vk:5 vj:5 vd:5
+xvaddwev_q_du_d LASX 0111 01000011 11111 vk:5 vj:5 vd:5
+xvaddwod_h_bu_b LASX 0111 01000100 00000 vk:5 vj:5 vd:5
+xvaddwod_w_hu_h LASX 0111 01000100 00001 vk:5 vj:5 vd:5
+xvaddwod_d_wu_w LASX 0111 01000100 00010 vk:5 vj:5 vd:5
+xvaddwod_q_du_d LASX 0111 01000100 00011 vk:5 vj:5 vd:5
+
+xvavg_b LASX 0111 01000110 01000 vk:5 vj:5 vd:5
+xvavg_h LASX 0111 01000110 01001 vk:5 vj:5 vd:5
+xvavg_w LASX 0111 01000110 01010 vk:5 vj:5 vd:5
+xvavg_d LASX 0111 01000110 01011 vk:5 vj:5 vd:5
+xvavg_bu LASX 0111 01000110 01100 vk:5 vj:5 vd:5
+xvavg_hu LASX 0111 01000110 01101 vk:5 vj:5 vd:5
+xvavg_wu LASX 0111 01000110 01110 vk:5 vj:5 vd:5
+xvavg_du LASX 0111 01000110 01111 vk:5 vj:5 vd:5
+xvavgr_b LASX 0111 01000110 10000 vk:5 vj:5 vd:5
+xvavgr_h LASX 0111 01000110 10001 vk:5 vj:5 vd:5
+xvavgr_w LASX 0111 01000110 10010 vk:5 vj:5 vd:5
+xvavgr_d LASX 0111 01000110 10011 vk:5 vj:5 vd:5
+xvavgr_bu LASX 0111 01000110 10100 vk:5 vj:5 vd:5
+xvavgr_hu LASX 0111 01000110 10101 vk:5 vj:5 vd:5
+xvavgr_wu LASX 0111 01000110 10110 vk:5 vj:5 vd:5
+xvavgr_du LASX 0111 01000110 10111 vk:5 vj:5 vd:5
+
+xvabsd_b LASX 0111 01000110 00000 vk:5 vj:5 vd:5
+xvabsd_h LASX 0111 01000110 00001 vk:5 vj:5 vd:5
+xvabsd_w LASX 0111 01000110 00010 vk:5 vj:5 vd:5
+xvabsd_d LASX 0111 01000110 00011 vk:5 vj:5 vd:5
+xvabsd_bu LASX 0111 01000110 00100 vk:5 vj:5 vd:5
+xvabsd_hu LASX 0111 01000110 00101 vk:5 vj:5 vd:5
+xvabsd_wu LASX 0111 01000110 00110 vk:5 vj:5 vd:5
+xvabsd_du LASX 0111 01000110 00111 vk:5 vj:5 vd:5
+
+xvadda_b LASX 0111 01000101 11000 vk:5 vj:5 vd:5
+xvadda_h LASX 0111 01000101 11001 vk:5 vj:5 vd:5
+xvadda_w LASX 0111 01000101 11010 vk:5 vj:5 vd:5
+xvadda_d LASX 0111 01000101 11011 vk:5 vj:5 vd:5
+
+xvmax_b LASX 0111 01000111 00000 vk:5 vj:5 vd:5
+xvmax_h LASX 0111 01000111 00001 vk:5 vj:5 vd:5
+xvmax_w LASX 0111 01000111 00010 vk:5 vj:5 vd:5
+xvmax_d LASX 0111 01000111 00011 vk:5 vj:5 vd:5
+xvmax_bu LASX 0111 01000111 01000 vk:5 vj:5 vd:5
+xvmax_hu LASX 0111 01000111 01001 vk:5 vj:5 vd:5
+xvmax_wu LASX 0111 01000111 01010 vk:5 vj:5 vd:5
+xvmax_du LASX 0111 01000111 01011 vk:5 vj:5 vd:5
+
+xvmaxi_b LASX 0111 01101001 00000 imm:5 vj:5 vd:5 \
+    !constraints { $imm = sextract($imm, 5);}
+xvmaxi_h LASX 0111 01101001 00001 imm:5 vj:5 vd:5 \
+    !constraints { $imm = sextract($imm, 5);}
+xvmaxi_w LASX 0111 01101001 00010 imm:5 vj:5 vd:5 \
+    !constraints { $imm = sextract($imm, 5);}
+xvmaxi_d LASX 0111 01101001 00011 imm:5 vj:5 vd:5 \
+    !constraints { $imm = sextract($imm, 5);}
+xvmaxi_bu LASX  0111 01101001 01000 imm:5 vj:5 vd:5
+xvmaxi_hu LASX  0111 01101001 01001 imm:5 vj:5 vd:5
+xvmaxi_wu LASX  0111 01101001 01010 imm:5 vj:5 vd:5
+xvmaxi_du LASX  0111 01101001 01011 imm:5 vj:5 vd:5
+
+xvmin_b LASX 0111 01000111 00100 vk:5 vj:5 vd:5
+xvmin_h LASX 0111 01000111 00101 vk:5 vj:5 vd:5
+xvmin_w LASX 0111 01000111 00110 vk:5 vj:5 vd:5
+xvmin_d LASX 0111 01000111 00111 vk:5 vj:5 vd:5
+xvmin_bu LASX 0111 01000111 01100 vk:5 vj:5 vd:5
+xvmin_hu LASX 0111 01000111 01101 vk:5 vj:5 vd:5
+xvmin_wu LASX 0111 01000111 01110 vk:5 vj:5 vd:5
+xvmin_du LASX 0111 01000111 01111 vk:5 vj:5 vd:5
+
+xvmini_b LASX 0111 01101001 00100 imm:5 vj:5 vd:5 \
+    !constraints { $imm = sextract($imm, 5);}
+xvmini_h LASX 0111 01101001 00101 imm:5 vj:5 vd:5 \
+    !constraints { $imm = sextract($imm, 5);}
+xvmini_w LASX 0111 01101001 00110 imm:5 vj:5 vd:5 \
+    !constraints { $imm = sextract($imm, 5);}
+xvmini_d LASX 0111 01101001 00111 imm:5 vj:5 vd:5 \
+    !constraints { $imm = sextract($imm, 5);}
+xvmini_bu LASX 0111 01101001 01100 imm:5 vj:5 vd:5
+xvmini_hu LASX 0111 01101001 01101 imm:5 vj:5 vd:5
+xvmini_wu LASX 0111 01101001 01110 imm:5 vj:5 vd:5
+xvmini_du LASX 0111 01101001 01111 imm:5 vj:5 vd:5
+
+xvmul_b LASX 0111 01001000 01000 vk:5 vj:5 vd:5
+xvmul_h LASX 0111 01001000 01001 vk:5 vj:5 vd:5
+xvmul_w LASX 0111 01001000 01010 vk:5 vj:5 vd:5
+xvmul_d LASX 0111 01001000 01011 vk:5 vj:5 vd:5
+xvmuh_b LASX 0111 01001000 01100 vk:5 vj:5 vd:5
+xvmuh_h LASX 0111 01001000 01101 vk:5 vj:5 vd:5
+xvmuh_w LASX 0111 01001000 01110 vk:5 vj:5 vd:5
+xvmuh_d LASX 0111 01001000 01111 vk:5 vj:5 vd:5
+xvmuh_bu LASX 0111 01001000 10000 vk:5 vj:5 vd:5
+xvmuh_hu LASX 0111 01001000 10001 vk:5 vj:5 vd:5
+xvmuh_wu LASX 0111 01001000 10010 vk:5 vj:5 vd:5
+xvmuh_du LASX 0111 01001000 10011 vk:5 vj:5 vd:5
+
+xvmulwev_h_b LASX 0111 01001001 00000 vk:5 vj:5 vd:5
+xvmulwev_w_h LASX 0111 01001001 00001 vk:5 vj:5 vd:5
+xvmulwev_d_w LASX 0111 01001001 00010 vk:5 vj:5 vd:5
+xvmulwev_q_d LASX 0111 01001001 00011 vk:5 vj:5 vd:5
+xvmulwod_h_b LASX 0111 01001001 00100 vk:5 vj:5 vd:5
+xvmulwod_w_h LASX 0111 01001001 00101 vk:5 vj:5 vd:5
+xvmulwod_d_w LASX 0111 01001001 00110 vk:5 vj:5 vd:5
+xvmulwod_q_d LASX 0111 01001001 00111 vk:5 vj:5 vd:5
+xvmulwev_h_bu LASX 0111 01001001 10000 vk:5 vj:5 vd:5
+xvmulwev_w_hu LASX 0111 01001001 10001 vk:5 vj:5 vd:5
+xvmulwev_d_wu LASX 0111 01001001 10010 vk:5 vj:5 vd:5
+xvmulwev_q_du LASX 0111 01001001 10011 vk:5 vj:5 vd:5
+xvmulwod_h_bu LASX 0111 01001001 10100 vk:5 vj:5 vd:5
+xvmulwod_w_hu LASX 0111 01001001 10101 vk:5 vj:5 vd:5
+xvmulwod_d_wu LASX 0111 01001001 10110 vk:5 vj:5 vd:5
+xvmulwod_q_du LASX 0111 01001001 10111 vk:5 vj:5 vd:5
+xvmulwev_h_bu_b LASX 0111 01001010 00000 vk:5 vj:5 vd:5
+xvmulwev_w_hu_h LASX 0111 01001010 00001 vk:5 vj:5 vd:5
+xvmulwev_d_wu_w LASX 0111 01001010 00010 vk:5 vj:5 vd:5
+xvmulwev_q_du_d LASX 0111 01001010 00011 vk:5 vj:5 vd:5
+xvmulwod_h_bu_b LASX 0111 01001010 00100 vk:5 vj:5 vd:5
+xvmulwod_w_hu_h LASX 0111 01001010 00101 vk:5 vj:5 vd:5
+xvmulwod_d_wu_w LASX 0111 01001010 00110 vk:5 vj:5 vd:5
+xvmulwod_q_du_d LASX 0111 01001010 00111 vk:5 vj:5 vd:5
+
+xvmadd_b LASX 0111 01001010 10000 vk:5 vj:5 vd:5
+xvmadd_h LASX 0111 01001010 10001 vk:5 vj:5 vd:5
+xvmadd_w LASX 0111 01001010 10010 vk:5 vj:5 vd:5
+xvmadd_d LASX 0111 01001010 10011 vk:5 vj:5 vd:5
+xvmsub_b LASX 0111 01001010 10100 vk:5 vj:5 vd:5
+xvmsub_h LASX 0111 01001010 10101 vk:5 vj:5 vd:5
+xvmsub_w LASX 0111 01001010 10110 vk:5 vj:5 vd:5
+xvmsub_d LASX 0111 01001010 10111 vk:5 vj:5 vd:5
+
+xvmaddwev_h_b LASX 0111 01001010 11000 vk:5 vj:5 vd:5
+xvmaddwev_w_h LASX 0111 01001010 11001 vk:5 vj:5 vd:5
+xvmaddwev_d_w LASX 0111 01001010 11010 vk:5 vj:5 vd:5
+xvmaddwev_q_d LASX 0111 01001010 11011 vk:5 vj:5 vd:5
+xvmaddwod_h_b LASX 0111 01001010 11100 vk:5 vj:5 vd:5
+xvmaddwod_w_h LASX 0111 01001010 11101 vk:5 vj:5 vd:5
+xvmaddwod_d_w LASX 0111 01001010 11110 vk:5 vj:5 vd:5
+xvmaddwod_q_d LASX 0111 01001010 11111 vk:5 vj:5 vd:5
+xvmaddwev_h_bu LASX 0111 01001011 01000 vk:5 vj:5 vd:5
+xvmaddwev_w_hu LASX 0111 01001011 01001 vk:5 vj:5 vd:5
+xvmaddwev_d_wu LASX 0111 01001011 01010 vk:5 vj:5 vd:5
+xvmaddwev_q_du LASX 0111 01001011 01011 vk:5 vj:5 vd:5
+xvmaddwod_h_bu LASX 0111 01001011 01100 vk:5 vj:5 vd:5
+xvmaddwod_w_hu LASX 0111 01001011 01101 vk:5 vj:5 vd:5
+xvmaddwod_d_wu LASX 0111 01001011 01110 vk:5 vj:5 vd:5
+xvmaddwod_q_du LASX 0111 01001011 01111 vk:5 vj:5 vd:5
+xvmaddwev_h_bu_b LASX 0111 01001011 11000 vk:5 vj:5 vd:5
+xvmaddwev_w_hu_h LASX 0111 01001011 11001 vk:5 vj:5 vd:5
+xvmaddwev_d_wu_w LASX 0111 01001011 11010 vk:5 vj:5 vd:5
+xvmaddwev_q_du_d LASX 0111 01001011 11011 vk:5 vj:5 vd:5
+xvmaddwod_h_bu_b LASX 0111 01001011 11100 vk:5 vj:5 vd:5
+xvmaddwod_w_hu_h LASX 0111 01001011 11101 vk:5 vj:5 vd:5
+xvmaddwod_d_wu_w LASX 0111 01001011 11110 vk:5 vj:5 vd:5
+xvmaddwod_q_du_d LASX 0111 01001011 11111 vk:5 vj:5 vd:5
+
+xvdiv_b LASX 0111 01001110 00000 vk:5 vj:5 vd:5
+xvdiv_h LASX 0111 01001110 00001 vk:5 vj:5 vd:5
+xvdiv_w LASX 0111 01001110 00010 vk:5 vj:5 vd:5
+xvdiv_d LASX 0111 01001110 00011 vk:5 vj:5 vd:5
+xvmod_b LASX 0111 01001110 00100 vk:5 vj:5 vd:5
+xvmod_h LASX 0111 01001110 00101 vk:5 vj:5 vd:5
+xvmod_w LASX 0111 01001110 00110 vk:5 vj:5 vd:5
+xvmod_d LASX 0111 01001110 00111 vk:5 vj:5 vd:5
+xvdiv_bu LASX 0111 01001110 01000 vk:5 vj:5 vd:5
+xvdiv_hu LASX 0111 01001110 01001 vk:5 vj:5 vd:5
+xvdiv_wu LASX 0111 01001110 01010 vk:5 vj:5 vd:5
+xvdiv_du LASX 0111 01001110 01011 vk:5 vj:5 vd:5
+xvmod_bu LASX 0111 01001110 01100 vk:5 vj:5 vd:5
+xvmod_hu LASX 0111 01001110 01101 vk:5 vj:5 vd:5
+xvmod_wu LASX 0111 01001110 01110 vk:5 vj:5 vd:5
+xvmod_du LASX 0111 01001110 01111 vk:5 vj:5 vd:5
+
+xvsat_b LASX 0111 01110010 01000 01 imm:3 vj:5 vd:5
+xvsat_h LASX 0111 01110010 01000 1  imm:4 vj:5 vd:5
+xvsat_w LASX 0111 01110010 01001    imm:5 vj:5 vd:5
+xvsat_d LASX 0111 01110010 0101     imm:6 vj:5 vd:5
+xvsat_bu LASX 0111 01110010 10000 01 imm:3 vj:5 vd:5
+xvsat_hu LASX 0111 01110010 10000 1  imm:4 vj:5 vd:5
+xvsat_wu LASX 0111 01110010 10001    imm:5 vj:5 vd:5
+xvsat_du LASX 0111 01110010 1001     imm:6 vj:5 vd:5
+
+xvexth_h_b LASX 0111 01101001 11101 11000 vj:5 vd:5
+xvexth_w_h LASX 0111 01101001 11101 11001 vj:5 vd:5
+xvexth_d_w LASX 0111 01101001 11101 11010 vj:5 vd:5
+xvexth_q_d LASX 0111 01101001 11101 11011 vj:5 vd:5
+xvexth_hu_bu LASX 0111 01101001 11101 11100 vj:5 vd:5
+xvexth_wu_hu LASX 0111 01101001 11101 11101 vj:5 vd:5
+xvexth_du_wu LASX 0111 01101001 11101 11110 vj:5 vd:5
+xvexth_qu_du LASX 0111 01101001 11101 11111 vj:5 vd:5
+
+vext2xv_h_b LASX 0111 01101001 11110 00100 vj:5 vd:5
+vext2xv_w_b LASX 0111 01101001 11110 00101 vj:5 vd:5
+vext2xv_d_b LASX 0111 01101001 11110 00110 vj:5 vd:5
+vext2xv_w_h LASX 0111 01101001 11110 00111 vj:5 vd:5
+vext2xv_d_h LASX 0111 01101001 11110 01000 vj:5 vd:5
+vext2xv_d_w LASX 0111 01101001 11110 01001 vj:5 vd:5
+vext2xv_hu_bu LASX 0111 01101001 11110 01010 vj:5 vd:5
+vext2xv_wu_bu LASX 0111 01101001 11110 01011 vj:5 vd:5
+vext2xv_du_bu LASX 0111 01101001 11110 01100 vj:5 vd:5
+vext2xv_wu_hu LASX 0111 01101001 11110 01101 vj:5 vd:5
+vext2xv_du_hu LASX 0111 01101001 11110 01110 vj:5 vd:5
+vext2xv_du_wu LASX 0111 01101001 11110 01111 vj:5 vd:5
+
+xvsigncov_b LASX 0111 01010010 11100 vk:5 vj:5 vd:5
+xvsigncov_h LASX 0111 01010010 11101 vk:5 vj:5 vd:5
+xvsigncov_w LASX 0111 01010010 11110 vk:5 vj:5 vd:5
+xvsigncov_d LASX 0111 01010010 11111 vk:5 vj:5 vd:5
+
+xvmskltz_b LASX 0111 01101001 11000 10000 vj:5 vd:5
+xvmskltz_h LASX 0111 01101001 11000 10001 vj:5 vd:5
+xvmskltz_w LASX 0111 01101001 11000 10010 vj:5 vd:5
+xvmskltz_d LASX 0111 01101001 11000 10011 vj:5 vd:5
+xvmskgez_b LASX 0111 01101001 11000 10100 vj:5 vd:5
+xvmsknz_b LASX 0111 01101001 11000 11000 vj:5 vd:5
+
+xvldi LASX 0111 01111110 00 si13:13 vd:5 \
+     !constraints { $si13 >= 0 && $si13 <= 12; }
+
+xvand_v  LASX 0111 01010010 01100 vk:5 vj:5 vd:5
+xvor_v   LASX 0111 01010010 01101 vk:5 vj:5 vd:5
+xvxor_v  LASX 0111 01010010 01110 vk:5 vj:5 vd:5
+xvnor_v  LASX 0111 01010010 01111 vk:5 vj:5 vd:5
+xvandn_v LASX 0111 01010010 10000 vk:5 vj:5 vd:5
+xvorn_v  LASX 0111 01010010 10001 vk:5 vj:5 vd:5
+
+xvandi_b LASX 0111 01111101 00 imm:8 vj:5 vd:5
+xvori_b  LASX 0111 01111101 01 imm:8 vj:5 vd:5
+xvxori_b LASX 0111 01111101 10 imm:8 vj:5 vd:5
+xvnori_b LASX 0111 01111101 11 imm:8 vj:5 vd:5
+
+xvsll_b LASX 0111 01001110 10000 vk:5 vj:5 vd:5
+xvsll_h LASX 0111 01001110 10001 vk:5 vj:5 vd:5
+xvsll_w LASX 0111 01001110 10010 vk:5 vj:5 vd:5
+xvsll_d LASX 0111 01001110 10011 vk:5 vj:5 vd:5
+xvslli_b LASX 0111 01110010 11000 01 imm:3 vj:5 vd:5
+xvslli_h LASX 0111 01110010 11000 1  imm:4 vj:5 vd:5
+xvslli_w LASX 0111 01110010 11001    imm:5 vj:5 vd:5
+xvslli_d LASX 0111 01110010 1101     imm:6 vj:5 vd:5
+xvsrl_b LASX 0111 01001110 10100 vk:5 vj:5 vd:5
+xvsrl_h LASX 0111 01001110 10101 vk:5 vj:5 vd:5
+xvsrl_w LASX 0111 01001110 10110 vk:5 vj:5 vd:5
+xvsrl_d LASX 0111 01001110 10111 vk:5 vj:5 vd:5
+xvsrli_b LASX 0111 01110011 00000 01 imm:3 vj:5 vd:5
+xvsrli_h LASX 0111 01110011 00000 1  imm:4 vj:5 vd:5
+xvsrli_w LASX 0111 01110011 00001    imm:5 vj:5 vd:5
+xvsrli_d LASX 0111 01110011 0001     imm:6 vj:5 vd:5
+xvsra_b LASX 0111 01001110 11000 vk:5 vj:5 vd:5
+xvsra_h LASX 0111 01001110 11001 vk:5 vj:5 vd:5
+xvsra_w LASX 0111 01001110 11010 vk:5 vj:5 vd:5
+xvsra_d LASX 0111 01001110 11011 vk:5 vj:5 vd:5
+xvsrai_b LASX 0111 01110011 01000 01 imm:3 vj:5 vd:5
+xvsrai_h LASX 0111 01110011 01000 1  imm:4 vj:5 vd:5
+xvsrai_w LASX 0111 01110011 01001    imm:5 vj:5 vd:5
+xvsrai_d LASX 0111 01110011 0101     imm:6 vj:5 vd:5
+xvrotr_b LASX 0111 01001110 11100 vk:5 vj:5 vd:5
+xvrotr_h LASX 0111 01001110 11101 vk:5 vj:5 vd:5
+xvrotr_w LASX 0111 01001110 11110 vk:5 vj:5 vd:5
+xvrotr_d LASX 0111 01001110 11111 vk:5 vj:5 vd:5
+xvrotri_b LASX 0111 01101010 00000 01 imm:3 vj:5 vd:5
+xvrotri_h LASX 0111 01101010 00000 1  imm:4 vj:5 vd:5
+xvrotri_w LASX 0111 01101010 00001    imm:5 vj:5 vd:5
+xvrotri_d LASX 0111 01101010 0001     imm:6 vj:5 vd:5
+
+xvsllwil_h_b LASX 0111 01110000 10000 01 imm:3 vj:5 vd:5
+xvsllwil_w_h LASX 0111 01110000 10000 1  imm:4 vj:5 vd:5
+xvsllwil_d_w LASX 0111 01110000 10001    imm:5 vj:5 vd:5
+xvextl_q_d LASX 0111 01110000 10010 00000  vj:5 vd:5
+xvsllwil_hu_bu LASX 0111 01110000 11000 01 imm:3 vj:5 vd:5
+xvsllwil_wu_hu LASX 0111 01110000 11000 1  imm:4 vj:5 vd:5
+xvsllwil_du_wu LASX 0111 01110000 11001    imm:5 vj:5 vd:5
+xvextl_qu_du LASX 0111 01110000 11010 00000  vj:5 vd:5
+
+xvsrlr_b LASX 0111 01001111 00000 vk:5 vj:5 vd:5
+xvsrlr_h LASX 0111 01001111 00001 vk:5 vj:5 vd:5
+xvsrlr_w LASX 0111 01001111 00010 vk:5 vj:5 vd:5
+xvsrlr_d LASX 0111 01001111 00011 vk:5 vj:5 vd:5
+xvsrlri_b LASX 0111 01101010 01000 01 imm:3 vj:5 vd:5
+xvsrlri_h LASX 0111 01101010 01000 1  imm:4 vj:5 vd:5
+xvsrlri_w LASX 0111 01101010 01001    imm:5 vj:5 vd:5
+xvsrlri_d LASX 0111 01101010 0101     imm:6 vj:5 vd:5
+xvsrar_b LASX 0111 01001111 00100 vk:5 vj:5 vd:5
+xvsrar_h LASX 0111 01001111 00101 vk:5 vj:5 vd:5
+xvsrar_w LASX 0111 01001111 00110 vk:5 vj:5 vd:5
+xvsrar_d LASX 0111 01001111 00111 vk:5 vj:5 vd:5
+xvsrari_b LASX 0111 01101010 10000 01 imm:3 vj:5 vd:5
+xvsrari_h LASX 0111 01101010 10000 1  imm:4 vj:5 vd:5
+xvsrari_w LASX 0111 01101010 10001    imm:5 vj:5 vd:5
+xvsrari_d LASX 0111 01101010 1001     imm:6 vj:5 vd:5
+
+xvsrln_b_h LASX 0111 01001111 01001 vk:5 vj:5 vd:5
+xvsrln_h_w LASX 0111 01001111 01010 vk:5 vj:5 vd:5
+xvsrln_w_d LASX 0111 01001111 01011 vk:5 vj:5 vd:5
+xvsran_b_h LASX 0111 01001111 01101 vk:5 vj:5 vd:5
+xvsran_h_w LASX 0111 01001111 01110 vk:5 vj:5 vd:5
+xvsran_w_d LASX 0111 01001111 01111 vk:5 vj:5 vd:5
+
+xvsrlni_b_h LASX 0111 01110100 00000 1 imm:4 vj:5 vd:5
+xvsrlni_h_w LASX 0111 01110100 00001   imm:5 vj:5 vd:5
+xvsrlni_w_d LASX 0111 01110100 0001    imm:6 vj:5 vd:5
+xvsrlni_d_q LASX 0111 01110100 001     imm:7 vj:5 vd:5
+xvsrani_b_h LASX 0111 01110101 10000 1 imm:4 vj:5 vd:5
+xvsrani_h_w LASX 0111 01110101 10001   imm:5 vj:5 vd:5
+xvsrani_w_d LASX 0111 01110101 1001    imm:6 vj:5 vd:5
+xvsrani_d_q LASX 0111 01110101 101     imm:7 vj:5 vd:5
+
+xvsrlrn_b_h LASX 0111 01001111 10001 vk:5 vj:5 vd:5
+xvsrlrn_h_w LASX 0111 01001111 10010 vk:5 vj:5 vd:5
+xvsrlrn_w_d LASX 0111 01001111 10011 vk:5 vj:5 vd:5
+xvsrarn_b_h LASX 0111 01001111 10101 vk:5 vj:5 vd:5
+xvsrarn_h_w LASX 0111 01001111 10110 vk:5 vj:5 vd:5
+xvsrarn_w_d LASX 0111 01001111 10111 vk:5 vj:5 vd:5
+
+xvsrlrni_b_h LASX 0111 01110100 01000 1 imm:4 vj:5 vd:5
+xvsrlrni_h_w LASX 0111 01110100 01001   imm:5 vj:5 vd:5
+xvsrlrni_w_d LASX 0111 01110100 0101    imm:6 vj:5 vd:5
+xvsrlrni_d_q LASX 0111 01110100 011     imm:7 vj:5 vd:5
+xvsrarni_b_h LASX 0111 01110101 11000 1 imm:4 vj:5 vd:5
+xvsrarni_h_w LASX 0111 01110101 11001   imm:5 vj:5 vd:5
+xvsrarni_w_d LASX 0111 01110101 1101    imm:6 vj:5 vd:5
+xvsrarni_d_q LASX 0111 01110101 111     imm:7 vj:5 vd:5
+
+xvssrln_b_h LASX 0111 01001111 11001 vk:5 vj:5 vd:5
+xvssrln_h_w LASX 0111 01001111 11010 vk:5 vj:5 vd:5
+xvssrln_w_d LASX 0111 01001111 11011 vk:5 vj:5 vd:5
+xvssran_b_h LASX 0111 01001111 11101 vk:5 vj:5 vd:5
+xvssran_h_w LASX 0111 01001111 11110 vk:5 vj:5 vd:5
+xvssran_w_d LASX 0111 01001111 11111 vk:5 vj:5 vd:5
+xvssrln_bu_h LASX 0111 01010000 01001 vk:5 vj:5 vd:5
+xvssrln_hu_w LASX 0111 01010000 01010 vk:5 vj:5 vd:5
+xvssrln_wu_d LASX 0111 01010000 01011 vk:5 vj:5 vd:5
+xvssran_bu_h LASX 0111 01010000 01101 vk:5 vj:5 vd:5
+xvssran_hu_w LASX 0111 01010000 01110 vk:5 vj:5 vd:5
+xvssran_wu_d LASX 0111 01010000 01111 vk:5 vj:5 vd:5
+
+xvssrlni_b_h LASX 0111 01110100 10000 1 imm:4 vj:5 vd:5
+xvssrlni_h_w LASX 0111 01110100 10001   imm:5 vj:5 vd:5
+xvssrlni_w_d LASX 0111 01110100 1001    imm:6 vj:5 vd:5
+xvssrlni_d_q LASX 0111 01110100 101     imm:7 vj:5 vd:5
+xvssrani_b_h LASX 0111 01110110 00000 1 imm:4 vj:5 vd:5
+xvssrani_h_w LASX 0111 01110110 00001   imm:5 vj:5 vd:5
+xvssrani_w_d LASX 0111 01110110 0001    imm:6 vj:5 vd:5
+xvssrani_d_q LASX 0111 01110110 001     imm:7 vj:5 vd:5
+xvssrlni_bu_h LASX 0111 01110100 11000 1 imm:4 vj:5 vd:5
+xvssrlni_hu_w LASX 0111 01110100 11001   imm:5 vj:5 vd:5
+xvssrlni_wu_d LASX 0111 01110100 1101    imm:6 vj:5 vd:5
+xvssrlni_du_q LASX 0111 01110100 111     imm:7 vj:5 vd:5
+xvssrani_bu_h LASX 0111 01110110 01000 1 imm:4 vj:5 vd:5
+xvssrani_hu_w LASX 0111 01110110 01001   imm:5 vj:5 vd:5
+xvssrani_wu_d LASX 0111 01110110 0101    imm:6 vj:5 vd:5
+xvssrani_du_q LASX 0111 01110110 011     imm:7 vj:5 vd:5
+
+xvssrlrn_b_h LASX 0111 01010000 00001 vk:5 vj:5 vd:5
+xvssrlrn_h_w LASX 0111 01010000 00010 vk:5 vj:5 vd:5
+xvssrlrn_w_d LASX 0111 01010000 00011 vk:5 vj:5 vd:5
+xvssrarn_b_h LASX 0111 01010000 00101 vk:5 vj:5 vd:5
+xvssrarn_h_w LASX 0111 01010000 00110 vk:5 vj:5 vd:5
+xvssrarn_w_d LASX 0111 01010000 00111 vk:5 vj:5 vd:5
+xvssrlrn_bu_h LASX 0111 01010000 10001 vk:5 vj:5 vd:5
+xvssrlrn_hu_w LASX 0111 01010000 10010 vk:5 vj:5 vd:5
+xvssrlrn_wu_d LASX 0111 01010000 10011 vk:5 vj:5 vd:5
+xvssrarn_bu_h LASX 0111 01010000 10101 vk:5 vj:5 vd:5
+xvssrarn_hu_w LASX 0111 01010000 10110 vk:5 vj:5 vd:5
+xvssrarn_wu_d LASX 0111 01010000 10111 vk:5 vj:5 vd:5
+
+xvssrlrni_b_h LASX 0111 01110101 00000 1 imm:4 vj:5 vd:5
+xvssrlrni_h_w LASX 0111 01110101 00001   imm:5 vj:5 vd:5
+xvssrlrni_w_d LASX 0111 01110101 0001    imm:6 vj:5 vd:5
+xvssrlrni_d_q LASX 0111 01110101 001     imm:7 vj:5 vd:5
+xvssrarni_b_h LASX 0111 01110110 10000 1 imm:4 vj:5 vd:5
+xvssrarni_h_w LASX 0111 01110110 10001   imm:5 vj:5 vd:5
+xvssrarni_w_d LASX 0111 01110110 1001    imm:6 vj:5 vd:5
+xvssrarni_d_q LASX 0111 01110110 101     imm:7 vj:5 vd:5
+xvssrlrni_bu_h LASX 0111 01110101 01000 1 imm:4 vj:5 vd:5
+xvssrlrni_hu_w LASX 0111 01110101 01001   imm:5 vj:5 vd:5
+xvssrlrni_wu_d LASX 0111 01110101 0101    imm:6 vj:5 vd:5
+xvssrlrni_du_q LASX 0111 01110101 011     imm:7 vj:5 vd:5
+xvssrarni_bu_h LASX 0111 01110110 11000 1 imm:4 vj:5 vd:5
+xvssrarni_hu_w LASX 0111 01110110 11001   imm:5 vj:5 vd:5
+xvssrarni_wu_d LASX 0111 01110110 1101    imm:6 vj:5 vd:5
+xvssrarni_du_q LASX 0111 01110110 111     imm:7 vj:5 vd:5
+
+xvclo_b LASX 0111 01101001 11000 00000 vj:5 vd:5
+xvclo_h LASX 0111 01101001 11000 00001 vj:5 vd:5
+xvclo_w LASX 0111 01101001 11000 00010 vj:5 vd:5
+xvclo_d LASX 0111 01101001 11000 00011 vj:5 vd:5
+xvclz_b LASX 0111 01101001 11000 00100 vj:5 vd:5
+xvclz_h LASX 0111 01101001 11000 00101 vj:5 vd:5
+xvclz_w LASX 0111 01101001 11000 00110 vj:5 vd:5
+xvclz_d LASX 0111 01101001 11000 00111 vj:5 vd:5
+
+xvpcnt_b LASX 0111 01101001 11000 01000 vj:5 vd:5
+xvpcnt_h LASX 0111 01101001 11000 01001 vj:5 vd:5
+xvpcnt_w LASX 0111 01101001 11000 01010 vj:5 vd:5
+xvpcnt_d LASX 0111 01101001 11000 01011 vj:5 vd:5
+
+xvbitclr_b LASX 0111 01010000 11000 vk:5 vj:5 vd:5
+xvbitclr_h LASX 0111 01010000 11001 vk:5 vj:5 vd:5
+xvbitclr_w LASX 0111 01010000 11010 vk:5 vj:5 vd:5
+xvbitclr_d LASX 0111 01010000 11011 vk:5 vj:5 vd:5
+xvbitclri_b LASX 0111 01110001 00000 01 imm:3 vj:5 vd:5
+xvbitclri_h LASX 0111 01110001 00000 1  imm:4 vj:5 vd:5
+xvbitclri_w LASX 0111 01110001 00001    imm:5 vj:5 vd:5
+xvbitclri_d LASX 0111 01110001 0001     imm:6 vj:5 vd:5
+
+xvbitset_b LASX 0111 01010000 11100 vk:5 vj:5 vd:5
+xvbitset_h LASX 0111 01010000 11101 vk:5 vj:5 vd:5
+xvbitset_w LASX 0111 01010000 11110 vk:5 vj:5 vd:5
+xvbitset_d LASX 0111 01010000 11111 vk:5 vj:5 vd:5
+xvbitseti_b LASX 0111 01110001 01000 01 imm:3 vj:5 vd:5
+xvbitseti_h LASX 0111 01110001 01000 1  imm:4 vj:5 vd:5
+xvbitseti_w LASX 0111 01110001 01001    imm:5 vj:5 vd:5
+xvbitseti_d LASX 0111 01110001 0101     imm:6 vj:5 vd:5
+
+xvbitrev_b LASX 0111 01010001 00000 vk:5 vj:5 vd:5
+xvbitrev_h LASX 0111 01010001 00001 vk:5 vj:5 vd:5
+xvbitrev_w LASX 0111 01010001 00010 vk:5 vj:5 vd:5
+xvbitrev_d LASX 0111 01010001 00011 vk:5 vj:5 vd:5
+xvbitrevi_b LASX 0111 01110001 10000 01 imm:3 vj:5 vd:5
+xvbitrevi_h LASX 0111 01110001 10000 1  imm:4 vj:5 vd:5
+xvbitrevi_w LASX 0111 01110001 10001    imm:5 vj:5 vd:5
+xvbitrevi_d LASX 0111 01110001 1001     imm:6 vj:5 vd:5
+
+xvfrstp_b LASX 0111 01010010 10110 vk:5 vj:5 vd:5
+xvfrstp_h LASX 0111 01010010 10111 vk:5 vj:5 vd:5
+xvfrstpi_b LASX 0111 01101001 10100 imm:5 vj:5 vd:5
+xvfrstpi_h LASX 0111 01101001 10101 imm:5 vj:5 vd:5
+
+xvfadd_s LASX 0111 01010011 00001 vk:5 vj:5 vd:5
+xvfadd_d LASX 0111 01010011 00010 vk:5 vj:5 vd:5
+xvfsub_s LASX 0111 01010011 00101 vk:5 vj:5 vd:5
+xvfsub_d LASX 0111 01010011 00110 vk:5 vj:5 vd:5
+xvfmul_s LASX 0111 01010011 10001 vk:5 vj:5 vd:5
+xvfmul_d LASX 0111 01010011 10010 vk:5 vj:5 vd:5
+xvfdiv_s LASX 0111 01010011 10101 vk:5 vj:5 vd:5
+xvfdiv_d LASX 0111 01010011 10110 vk:5 vj:5 vd:5
+
+xvfmadd_s LASX 0000 10100001 xa:5 vk:5 vj:5 vd:5
+xvfmadd_d LASX 0000 10100010 xa:5 vk:5 vj:5 vd:5
+xvfmsub_s LASX 0000 10100101 xa:5 vk:5 vj:5 vd:5
+xvfmsub_d LASX 0000 10100110 xa:5 vk:5 vj:5 vd:5
+xvfnmadd_s LASX 0000 10101001 xa:5 vk:5 vj:5 vd:5
+xvfnmadd_d LASX 0000 10101010 xa:5 vk:5 vj:5 vd:5
+xvfnmsub_s LASX 0000 10101101 xa:5 vk:5 vj:5 vd:5
+xvfnmsub_d LASX 0000 10101110 xa:5 vk:5 vj:5 vd:5
+
+xvfmax_s LASX 0111 01010011 11001 vk:5 vj:5 vd:5
+xvfmax_d LASX 0111 01010011 11010 vk:5 vj:5 vd:5
+xvfmin_s LASX 0111 01010011 11101 vk:5 vj:5 vd:5
+xvfmin_d LASX 0111 01010011 11110 vk:5 vj:5 vd:5
+
+xvfmaxa_s LASX 0111 01010100 00001 vk:5 vj:5 vd:5
+xvfmaxa_d LASX 0111 01010100 00010 vk:5 vj:5 vd:5
+xvfmina_s LASX 0111 01010100 00101 vk:5 vj:5 vd:5
+xvfmina_d LASX 0111 01010100 00110 vk:5 vj:5 vd:5
+
+xvflogb_s LASX 0111 01101001 11001 10001 vj:5 vd:5
+xvflogb_d LASX 0111 01101001 11001 10010 vj:5 vd:5
+
+xvfclass_s LASX 0111 01101001 11001 10101 vj:5 vd:5
+xvfclass_d LASX 0111 01101001 11001 10110 vj:5 vd:5
+
+xvfsqrt_s LASX 0111 01101001 11001 11001 vj:5 vd:5
+xvfsqrt_d LASX 0111 01101001 11001 11010 vj:5 vd:5
+xvfrecip_s LASX 0111 01101001 11001 11101 vj:5 vd:5
+xvfrecip_d LASX 0111 01101001 11001 11110 vj:5 vd:5
+xvfrsqrt_s LASX 0111 01101001 11010 00001 vj:5 vd:5
+xvfrsqrt_d LASX 0111 01101001 11010 00010 vj:5 vd:5
+
+xvfcvtl_s_h LASX 0111 01101001 11011 11010 vj:5 vd:5
+xvfcvth_s_h LASX 0111 01101001 11011 11011 vj:5 vd:5
+xvfcvtl_d_s LASX 0111 01101001 11011 11100 vj:5 vd:5
+xvfcvth_d_s LASX 0111 01101001 11011 11101 vj:5 vd:5
+xvfcvt_h_s LASX 0111 01010100 01100 vk:5 vj:5 vd:5
+xvfcvt_s_d LASX 0111 01010100 01101 vk:5 vj:5 vd:5
+
+xvfrintrne_s LASX 0111 01101001 11010 11101 vj:5 vd:5
+xvfrintrne_d LASX 0111 01101001 11010 11110 vj:5 vd:5
+xvfrintrz_s LASX 0111 01101001 11010 11001 vj:5 vd:5
+xvfrintrz_d LASX 0111 01101001 11010 11010 vj:5 vd:5
+xvfrintrp_s LASX 0111 01101001 11010 10101 vj:5 vd:5
+xvfrintrp_d LASX 0111 01101001 11010 10110 vj:5 vd:5
+xvfrintrm_s LASX 0111 01101001 11010 10001 vj:5 vd:5
+xvfrintrm_d LASX 0111 01101001 11010 10010 vj:5 vd:5
+xvfrint_s LASX 0111 01101001 11010 01101 vj:5 vd:5
+xvfrint_d LASX 0111 01101001 11010 01110 vj:5 vd:5
+
+xvftintrne_w_s LASX 0111 01101001 11100 10100 vj:5 vd:5
+xvftintrne_l_d LASX 0111 01101001 11100 10101 vj:5 vd:5
+xvftintrz_w_s LASX 0111 01101001 11100 10010 vj:5 vd:5
+xvftintrz_l_d LASX 0111 01101001 11100 10011 vj:5 vd:5
+xvftintrp_w_s LASX 0111 01101001 11100 10000 vj:5 vd:5
+xvftintrp_l_d LASX 0111 01101001 11100 10001 vj:5 vd:5
+xvftintrm_w_s LASX 0111 01101001 11100 01110 vj:5 vd:5
+xvftintrm_l_d LASX 0111 01101001 11100 01111 vj:5 vd:5
+xvftint_w_s LASX 0111 01101001 11100 01100 vj:5 vd:5
+xvftint_l_d LASX 0111 01101001 11100 01101 vj:5 vd:5
+xvftintrz_wu_s LASX 0111 01101001 11100 11100 vj:5 vd:5
+xvftintrz_lu_d LASX 0111 01101001 11100 11101 vj:5 vd:5
+xvftint_wu_s LASX 0111 01101001 11100 10110 vj:5 vd:5
+xvftint_lu_d LASX 0111 01101001 11100 10111 vj:5 vd:5
+
+xvftintrne_w_d LASX 0111 01010100 10111 vk:5 vj:5 vd:5
+xvftintrz_w_d LASX 0111 01010100 10110 vk:5 vj:5 vd:5
+xvftintrp_w_d LASX 0111 01010100 10101 vk:5 vj:5 vd:5
+xvftintrm_w_d LASX 0111 01010100 10100 vk:5 vj:5 vd:5
+xvftint_w_d LASX 0111 01010100 10011 vk:5 vj:5 vd:5
+
+xvftintrnel_l_s LASX 0111 01101001 11101 01000 vj:5 vd:5
+xvftintrneh_l_s LASX 0111 01101001 11101 01001 vj:5 vd:5
+xvftintrzl_l_s LASX 0111 01101001 11101 00110 vj:5 vd:5
+xvftintrzh_l_s LASX 0111 01101001 11101 00111 vj:5 vd:5
+xvftintrpl_l_s LASX 0111 01101001 11101 00100 vj:5 vd:5
+xvftintrph_l_s LASX 0111 01101001 11101 00101 vj:5 vd:5
+xvftintrml_l_s LASX 0111 01101001 11101 00010 vj:5 vd:5
+xvftintrmh_l_s LASX 0111 01101001 11101 00011 vj:5 vd:5
+xvftintl_l_s LASX 0111 01101001 11101 00000 vj:5 vd:5
+xvftinth_l_s LASX 0111 01101001 11101 00001 vj:5 vd:5
+
+xvffint_s_w LASX 0111 01101001 11100 00000 vj:5 vd:5
+xvffint_d_l LASX 0111 01101001 11100 00010 vj:5 vd:5
+xvffint_s_wu LASX 0111 01101001 11100 00001 vj:5 vd:5
+xvffint_d_lu LASX 0111 01101001 11100 00011 vj:5 vd:5
+xvffintl_d_w LASX 0111 01101001 11100 00100 vj:5 vd:5
+xvffinth_d_w LASX 0111 01101001 11100 00101 vj:5 vd:5
+xvffint_s_l LASX 0111 01010100 10000 vk:5 vj:5 vd:5
+
+xvseq_b LASX 0111 01000000 00000 vk:5 vj:5 vd:5
+xvseq_h LASX 0111 01000000 00001 vk:5 vj:5 vd:5
+xvseq_w LASX 0111 01000000 00010 vk:5 vj:5 vd:5
+xvseq_d LASX 0111 01000000 00011 vk:5 vj:5 vd:5
+xvseqi_b LASX 0111 01101000 00000 si5:5 vj:5 vd:5
+xvseqi_h LASX 0111 01101000 00001 si5:5 vj:5 vd:5
+xvseqi_w LASX 0111 01101000 00010 si5:5 vj:5 vd:5
+xvseqi_d LASX 0111 01101000 00011 si5:5 vj:5 vd:5
+
+xvsle_b LASX 0111 01000000 00100 vk:5 vj:5 vd:5
+xvsle_h LASX 0111 01000000 00101 vk:5 vj:5 vd:5
+xvsle_w LASX 0111 01000000 00110 vk:5 vj:5 vd:5
+xvsle_d LASX 0111 01000000 00111 vk:5 vj:5 vd:5
+xvslei_b LASX 0111 01101000 00100 si5:5 vj:5 vd:5
+xvslei_h LASX 0111 01101000 00101 si5:5 vj:5 vd:5
+xvslei_w LASX 0111 01101000 00110 si5:5 vj:5 vd:5
+xvslei_d LASX 0111 01101000 00111 si5:5 vj:5 vd:5
+xvsle_bu LASX 0111 01000000 01000 vk:5 vj:5 vd:5
+xvsle_hu LASX 0111 01000000 01001 vk:5 vj:5 vd:5
+xvsle_wu LASX 0111 01000000 01010 vk:5 vj:5 vd:5
+xvsle_du LASX 0111 01000000 01011 vk:5 vj:5 vd:5
+xvslei_bu LASX 0111 01101000 01000 imm:5 vj:5 vd:5
+xvslei_hu LASX 0111 01101000 01001 imm:5 vj:5 vd:5
+xvslei_wu LASX 0111 01101000 01010 imm:5 vj:5 vd:5
+xvslei_du LASX 0111 01101000 01011 imm:5 vj:5 vd:5
+
+xvslt_b LASX 0111 01000000 01100 vk:5 vj:5 vd:5
+xvslt_h LASX 0111 01000000 01101 vk:5 vj:5 vd:5
+xvslt_w LASX 0111 01000000 01110 vk:5 vj:5 vd:5
+xvslt_d LASX 0111 01000000 01111 vk:5 vj:5 vd:5
+xvslti_b LASX 0111 01101000 01100 si5:5 vj:5 vd:5
+xvslti_h LASX 0111 01101000 01101 si5:5 vj:5 vd:5
+xvslti_w LASX 0111 01101000 01110 si5:5 vj:5 vd:5
+xvslti_d LASX 0111 01101000 01111 si5:5 vj:5 vd:5
+xvslt_bu LASX 0111 01000000 10000 vk:5 vj:5 vd:5
+xvslt_hu LASX 0111 01000000 10001 vk:5 vj:5 vd:5
+xvslt_wu LASX 0111 01000000 10010 vk:5 vj:5 vd:5
+xvslt_du LASX 0111 01000000 10011 vk:5 vj:5 vd:5
+xvslti_bu LASX 0111 01101000 10000 imm:5 vj:5 vd:5
+xvslti_hu LASX 0111 01101000 10001 imm:5 vj:5 vd:5
+xvslti_wu LASX 0111 01101000 10010 imm:5 vj:5 vd:5
+xvslti_du LASX 0111 01101000 10011 imm:5 vj:5 vd:5
+
+xvfcmp_cond_s LASX 0000 11001001 cond:5 vk:5 vj:5 vd:5 \
+    !constraints { $cond > 0 && $cond < 0x12; }
+xvfcmp_cond_d LASX 0000 11001010 cond:5 vk:5 vj:5 vd:5 \
+    !constraints { $cond > 0 && $cond < 0x12; }
+
+xvbitsel_v LASX 0000 11010010  xa:5 vk:5 vj:5 vd:5
+xvbitseli_b LASX 0111 01111100 01 imm:8 vj:5 vd:5
+
+xvseteqz_v LASX 0111 01101001 11001 00110 vj:5 00 cd:3
+xvsetnez_v LASX 0111 01101001 11001 00111 vj:5 00 cd:3
+xvsetanyeqz_b LASX 0111 01101001 11001 01000 vj:5 00 cd:3
+xvsetanyeqz_h LASX 0111 01101001 11001 01001 vj:5 00 cd:3
+xvsetanyeqz_w LASX 0111 01101001 11001 01010 vj:5 00 cd:3
+xvsetanyeqz_d LASX 0111 01101001 11001 01011 vj:5 00 cd:3
+xvsetallnez_b LASX 0111 01101001 11001 01100 vj:5 00 cd:3
+xvsetallnez_h LASX 0111 01101001 11001 01101 vj:5 00 cd:3
+xvsetallnez_w LASX 0111 01101001 11001 01110 vj:5 00 cd:3
+xvsetallnez_d LASX 0111 01101001 11001 01111 vj:5 00 cd:3
+
+xvinsgr2vr_w LASX 0111 01101110 10111 10  imm:3 rj:5 vd:5 \
+    !constraints { $rj != 2 && $rj != 0; }
+xvinsgr2vr_d LASX 0111 01101110 10111 110 imm:2 rj:5 vd:5 \
+    !constraints { $rj != 2 && $rj != 0; }
+xvpickve2gr_w LASX 0111 01101110 11111 10  imm:3 vj:5 rd:5 \
+    !constraints { $rd != 2 && $rd != 0; }
+xvpickve2gr_d LASX 0111 01101110 11111 110 imm:2 vj:5 rd:5 \
+    !constraints { $rd != 2 && $rd != 0; }
+xvpickve2gr_wu LASX 0111 01101111 00111 10  imm:3 vj:5 rd:5 \
+    !constraints { $rd != 2 && $rd != 0; }
+xvpickve2gr_du LASX 0111 01101111 00111 110 imm:2 vj:5 rd:5 \
+    !constraints { $rd != 2 && $rd != 0; }
+
+xvrepl128vei_b LASX 0111 01101111 01111 0    imm:4 vj:5 vd:5
+xvrepl128vei_h LASX 0111 01101111 01111 10   imm:3 vj:5 vd:5
+xvrepl128vei_w LASX 0111 01101111 01111 110  imm:2 vj:5 vd:5
+xvrepl128vei_d LASX 0111 01101111 01111 1110 imm:1 vj:5 vd:5
+
+xvreplve_b LASX 0111 01010010 00100 rk:5 vj:5 vd:5
+xvreplve_h LASX 0111 01010010 00101 rk:5 vj:5 vd:5
+xvreplve_w LASX 0111 01010010 00110 rk:5 vj:5 vd:5
+xvreplve_d LASX 0111 01010010 00111 rk:5 vj:5 vd:5
+
+xvreplve0_b LASX 0111 01110000 01110 00000 vj:5 vd:5
+xvreplve0_h LASX 0111 01110000 01111 00000 vj:5 vd:5
+xvreplve0_w LASX 0111 01110000 01111 10000 vj:5 vd:5
+xvreplve0_d LASX 0111 01110000 01111 11000 vj:5 vd:5
+xvreplve0_q LASX 0111 01110000 01111 11100 vj:5 vd:5
+
+xvinsve0_w LASX 0111 01101111 11111 10  imm:3 vj:5 vd:5
+xvinsve0_d LASX 0111 01101111 11111 110 imm:2 vj:5 vd:5
+
+xvpickve_w LASX 0111 01110000 00111 10  imm:3 vj:5 vd:5
+xvpickve_d LASX 0111 01110000 00111 110 imm:2 vj:5 vd:5
+
+xvbsll_v LASX 0111 01101000 11100 imm:5 vj:5 vd:5
+xvbsrl_v LASX 0111 01101000 11101 imm:5 vj:5 vd:5
+
+xvpackev_b LASX 0111 01010001 01100 vk:5 vj:5 vd:5
+xvpackev_h LASX 0111 01010001 01101 vk:5 vj:5 vd:5
+xvpackev_w LASX 0111 01010001 01110 vk:5 vj:5 vd:5
+xvpackev_d LASX 0111 01010001 01111 vk:5 vj:5 vd:5
+xvpackod_b LASX 0111 01010001 10000 vk:5 vj:5 vd:5
+xvpackod_h LASX 0111 01010001 10001 vk:5 vj:5 vd:5
+xvpackod_w LASX 0111 01010001 10010 vk:5 vj:5 vd:5
+xvpackod_d LASX 0111 01010001 10011 vk:5 vj:5 vd:5
+
+xvpickev_b LASX 0111 01010001 11100 vk:5 vj:5 vd:5
+xvpickev_h LASX 0111 01010001 11101 vk:5 vj:5 vd:5
+xvpickev_w LASX 0111 01010001 11110 vk:5 vj:5 vd:5
+xvpickev_d LASX 0111 01010001 11111 vk:5 vj:5 vd:5
+xvpickod_b LASX 0111 01010010 00000 vk:5 vj:5 vd:5
+xvpickod_h LASX 0111 01010010 00001 vk:5 vj:5 vd:5
+xvpickod_w LASX 0111 01010010 00010 vk:5 vj:5 vd:5
+xvpickod_d LASX 0111 01010010 00011 vk:5 vj:5 vd:5
+
+xvilvl_b LASX 0111 01010001 10100 vk:5 vj:5 vd:5
+xvilvl_h LASX 0111 01010001 10101 vk:5 vj:5 vd:5
+xvilvl_w LASX 0111 01010001 10110 vk:5 vj:5 vd:5
+xvilvl_d LASX 0111 01010001 10111 vk:5 vj:5 vd:5
+xvilvh_b LASX 0111 01010001 11000 vk:5 vj:5 vd:5
+xvilvh_h LASX 0111 01010001 11001 vk:5 vj:5 vd:5
+xvilvh_w LASX 0111 01010001 11010 vk:5 vj:5 vd:5
+xvilvh_d LASX 0111 01010001 11011 vk:5 vj:5 vd:5
+
+#xvshuf_b LASX 0000 11010110 xa:5 vk:5 vj:5 vd:5
+#xvshuf_h LASX 0111 01010111 10101 vk:5 vj:5 vd:5
+#xvshuf_w LASX 0111 01010111 10110 vk:5 vj:5 vd:5
+#xvshuf_d LASX 0111 01010111 10111 vk:5 vj:5 vd:5
+
+xvperm_w LASX 0111 01010111 11010 vk:5 vj:5 vd:5
+
+xvshuf4i_b LASX 0111 01111001 00 imm:8 vj:5 vd:5
+xvshuf4i_h LASX 0111 01111001 01 imm:8 vj:5 vd:5
+xvshuf4i_w LASX 0111 01111001 10 imm:8 vj:5 vd:5
+xvshuf4i_d LASX 0111 01111001 11 imm:8 vj:5 vd:5
+
+xvpermi_w LASX 0111 01111110 01 imm:8 vj:5 vd:5
+xvpermi_d LASX 0111 01111110 10 imm:8 vj:5 vd:5
+#xvpermi_q LASX 0111 01111110 11 imm:8 vj:5 vd:5
+
+xvextrins_d LASX 0111 01111000 00 imm:8 vj:5 vd:5
+xvextrins_w LASX 0111 01111000 01 imm:8 vj:5 vd:5
+xvextrins_h LASX 0111 01111000 10 imm:8 vj:5 vd:5
+xvextrins_b LASX 0111 01111000 11 imm:8 vj:5 vd:5
+
+xvld LASX 0010 110010 si12:12 rj:5 vd:5 \
+    !constraints { $rj != 0 && $rj != 2; } \
+    !memory { reg_plus_imm($rj, sextract($si12, 12)); }
+xvst LASX 0010 110011 si12:12 rj:5 vd:5 \
+    !constraints { $rj != 0 && $rj != 2; } \
+    !memory { reg_plus_imm($rj, sextract($si12, 12)); }
+xvldx LASX 0011 10000100 10000 rk:5 rj:5 vd:5 \
+    !constraints { $rj != 0 && $rj != $rk && $rk != 2 && $rj != 2; } \
+    !memory { reg_plus_reg($rj, $rk); }
+xvstx LASX 0011 10000100 11000 rk:5 rj:5 vd:5 \
+    !constraints { $rj != 0 && $rj != $rk && $rk != 2 && $rj != 2; } \
+    !memory { reg_plus_reg($rj, $rk); }
+
+xvldrepl_d LASX 0011 00100001 0 si9:9 rj:5 vd:5 \
+    !constraints { $rj != 0 && $rj != 2; } \
+    !memory { reg_plus_imm($rj, sextract($si9, 9) * 8); }
+xvldrepl_w LASX 0011 00100010   si10:10 rj:5 vd:5 \
+    !constraints { $rj != 0 && $rj != 2; } \
+    !memory { reg_plus_imm($rj, sextract($si10, 10) * 4); }
+xvldrepl_h LASX 0011 0010010    si11:11 rj:5 vd:5 \
+    !constraints { $rj != 0 && $rj != 2; } \
+    !memory { reg_plus_imm($rj, sextract($si11, 11) * 2); }
+xvldrepl_b LASX 0011 001010     si12:12 rj:5 vd:5 \
+    !constraints { $rj != 0 && $rj != 2; } \
+    !memory { reg_plus_imm($rj, sextract($si12, 12)); }
+
+xvstelm_d LASX 0011 00110001 si2:2 si8:8 rj:5 vd:5 \
+    !constraints { $rj != 0 && $rj != 2; } \
+    !memory { reg_plus_imm($rj, sextract($si8, 8) * 8); }
+xvstelm_w LASX 0011 0011001  si3:3 si8:8 rj:5 vd:5 \
+    !constraints { $rj != 0 && $rj != 2; } \
+    !memory { reg_plus_imm($rj, sextract($si8, 8) * 4); }
+xvstelm_h LASX 0011 001101   si4:4 si8:8 rj:5 vd:5 \
+    !constraints { $rj != 0 && $rj != 2; } \
+    !memory { reg_plus_imm($rj, sextract($si8, 8) * 2); }
+xvstelm_b LASX 0011 00111    si5:5 si8:8 rj:5 vd:5 \
+    !constraints { $rj != 0 && $rj != 2; } \
+    !memory { reg_plus_imm($rj, sextract($si8, 8) * 2); }
-- 
2.25.1


