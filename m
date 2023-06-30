Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C287F74365F
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:02:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF942-0003O0-7S; Fri, 30 Jun 2023 04:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qF93x-0003Ho-9N
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:01:05 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qF93u-00006d-Tn
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:01:04 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxxvBTi55kdTQEAA--.6755S3;
 Fri, 30 Jun 2023 15:59:15 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxjiNIi55kExQTAA--.24469S14; 
 Fri, 30 Jun 2023 15:59:15 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 12/46] target/loongarch: Implement xvabsd
Date: Fri, 30 Jun 2023 15:58:30 +0800
Message-Id: <20230630075904.45940-13-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230630075904.45940-1-gaosong@loongson.cn>
References: <20230630075904.45940-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxjiNIi55kExQTAA--.24469S14
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
- XVABSD.{B/H/W/D}[U].

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     | 9 +++++++++
 target/loongarch/insn_trans/trans_lasx.c.inc | 9 +++++++++
 target/loongarch/insns.decode                | 9 +++++++++
 target/loongarch/vec.h                       | 2 ++
 target/loongarch/vec_helper.c                | 2 --
 5 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 8296aafa98..d0b1de39b8 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1842,6 +1842,15 @@ INSN_LASX(xvavgr_hu,         vvv)
 INSN_LASX(xvavgr_wu,         vvv)
 INSN_LASX(xvavgr_du,         vvv)
 
+INSN_LASX(xvabsd_b,          vvv)
+INSN_LASX(xvabsd_h,          vvv)
+INSN_LASX(xvabsd_w,          vvv)
+INSN_LASX(xvabsd_d,          vvv)
+INSN_LASX(xvabsd_bu,         vvv)
+INSN_LASX(xvabsd_hu,         vvv)
+INSN_LASX(xvabsd_wu,         vvv)
+INSN_LASX(xvabsd_du,         vvv)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index ac4cade845..bd8ba6c7b6 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -157,6 +157,15 @@ TRANS(xvavgr_hu, gvec_vvv, 32, MO_16, do_vavgr_u)
 TRANS(xvavgr_wu, gvec_vvv, 32, MO_32, do_vavgr_u)
 TRANS(xvavgr_du, gvec_vvv, 32, MO_64, do_vavgr_u)
 
+TRANS(xvabsd_b, gvec_vvv, 32, MO_8, do_vabsd_s)
+TRANS(xvabsd_h, gvec_vvv, 32, MO_16, do_vabsd_s)
+TRANS(xvabsd_w, gvec_vvv, 32, MO_32, do_vabsd_s)
+TRANS(xvabsd_d, gvec_vvv, 32, MO_64, do_vabsd_s)
+TRANS(xvabsd_bu, gvec_vvv, 32, MO_8, do_vabsd_u)
+TRANS(xvabsd_hu, gvec_vvv, 32, MO_16, do_vabsd_u)
+TRANS(xvabsd_wu, gvec_vvv, 32, MO_32, do_vabsd_u)
+TRANS(xvabsd_du, gvec_vvv, 32, MO_64, do_vabsd_u)
+
 TRANS(xvreplgr2vr_b, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, gvec_dup, 32, MO_32)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index a2cb39750d..c086ee9b22 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1423,6 +1423,15 @@ xvavgr_hu        0111 01000110 10101 ..... ..... .....    @vvv
 xvavgr_wu        0111 01000110 10110 ..... ..... .....    @vvv
 xvavgr_du        0111 01000110 10111 ..... ..... .....    @vvv
 
+xvabsd_b         0111 01000110 00000 ..... ..... .....    @vvv
+xvabsd_h         0111 01000110 00001 ..... ..... .....    @vvv
+xvabsd_w         0111 01000110 00010 ..... ..... .....    @vvv
+xvabsd_d         0111 01000110 00011 ..... ..... .....    @vvv
+xvabsd_bu        0111 01000110 00100 ..... ..... .....    @vvv
+xvabsd_hu        0111 01000110 00101 ..... ..... .....    @vvv
+xvabsd_wu        0111 01000110 00110 ..... ..... .....    @vvv
+xvabsd_du        0111 01000110 00111 ..... ..... .....    @vvv
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index 361bf87896..ef2897fc10 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -53,4 +53,6 @@
 #define DO_VAVG(a, b)  ((a >> 1) + (b >> 1) + (a & b & 1))
 #define DO_VAVGR(a, b) ((a >> 1) + (b >> 1) + ((a | b) & 1))
 
+#define DO_VABSD(a, b)  ((a > b) ? (a - b) : (b - a))
+
 #endif /* LOONGARCH_VEC_H */
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 56997455de..99a1601d4e 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -372,8 +372,6 @@ DO_3OP(vavgr_hu, 16, UH, DO_VAVGR)
 DO_3OP(vavgr_wu, 32, UW, DO_VAVGR)
 DO_3OP(vavgr_du, 64, UD, DO_VAVGR)
 
-#define DO_VABSD(a, b)  ((a > b) ? (a -b) : (b-a))
-
 DO_3OP(vabsd_b, 8, B, DO_VABSD)
 DO_3OP(vabsd_h, 16, H, DO_VABSD)
 DO_3OP(vabsd_w, 32, W, DO_VABSD)
-- 
2.39.1


