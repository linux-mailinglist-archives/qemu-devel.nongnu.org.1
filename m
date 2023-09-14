Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8EE79F7F8
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:28:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgc4l-0003EW-Ih; Wed, 13 Sep 2023 22:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qgc4f-0003Ba-LH
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:27:21 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qgc4d-0004up-8B
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:27:21 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxVuh6bwJlg_gmAA--.40123S3;
 Thu, 14 Sep 2023 10:27:06 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxvdxmbwJlJ+UDAA--.7298S24; 
 Thu, 14 Sep 2023 10:27:05 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH v6 22/57] target/loongarch: Implement xvabsd
Date: Thu, 14 Sep 2023 10:26:10 +0800
Message-Id: <20230914022645.1151356-23-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230914022645.1151356-1-gaosong@loongson.cn>
References: <20230914022645.1151356-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxvdxmbwJlJ+UDAA--.7298S24
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
- XVABSD.{B/H/W/D}[U].

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/insns.decode               | 9 +++++++++
 target/loongarch/disas.c                    | 9 +++++++++
 target/loongarch/insn_trans/trans_vec.c.inc | 8 ++++++++
 3 files changed, 26 insertions(+)

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
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index f9d9583fcc..bbe7ad8322 100644
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
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index 050a96088d..37b842075d 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -1611,6 +1611,14 @@ TRANS(vabsd_bu, LSX, gvec_vvv, MO_8, do_vabsd_u)
 TRANS(vabsd_hu, LSX, gvec_vvv, MO_16, do_vabsd_u)
 TRANS(vabsd_wu, LSX, gvec_vvv, MO_32, do_vabsd_u)
 TRANS(vabsd_du, LSX, gvec_vvv, MO_64, do_vabsd_u)
+TRANS(xvabsd_b, LASX, gvec_xxx, MO_8, do_vabsd_s)
+TRANS(xvabsd_h, LASX, gvec_xxx, MO_16, do_vabsd_s)
+TRANS(xvabsd_w, LASX, gvec_xxx, MO_32, do_vabsd_s)
+TRANS(xvabsd_d, LASX, gvec_xxx, MO_64, do_vabsd_s)
+TRANS(xvabsd_bu, LASX, gvec_xxx, MO_8, do_vabsd_u)
+TRANS(xvabsd_hu, LASX, gvec_xxx, MO_16, do_vabsd_u)
+TRANS(xvabsd_wu, LASX, gvec_xxx, MO_32, do_vabsd_u)
+TRANS(xvabsd_du, LASX, gvec_xxx, MO_64, do_vabsd_u)
 
 static void gen_vadda(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
-- 
2.39.1


