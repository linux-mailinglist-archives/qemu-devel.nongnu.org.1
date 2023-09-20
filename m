Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D6B7A735A
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 08:56:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qir4y-00082i-5d; Wed, 20 Sep 2023 02:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qir4U-0007rV-8B
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 02:52:28 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qir4N-00044l-6K
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 02:52:26 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxLOuWlgpluy8qAA--.10102S3;
 Wed, 20 Sep 2023 14:52:06 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dxzdx7lgplhVYMAA--.24315S33; 
 Wed, 20 Sep 2023 14:52:06 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 31/57] target/loongarch: Implement xvsigncov
Date: Wed, 20 Sep 2023 14:51:13 +0800
Message-Id: <20230920065139.1403868-32-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230920065139.1403868-1-gaosong@loongson.cn>
References: <20230920065139.1403868-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxzdx7lgplhVYMAA--.24315S33
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
- XVSIGNCOV.{B/H/W/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230914022645.1151356-32-gaosong@loongson.cn>
---
 target/loongarch/insns.decode               | 5 +++++
 target/loongarch/disas.c                    | 5 +++++
 target/loongarch/insn_trans/trans_vec.c.inc | 4 ++++
 3 files changed, 14 insertions(+)

diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index db1a6689f0..7bbda1a142 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1593,6 +1593,11 @@ vext2xv_wu_hu    0111 01101001 11110 01101 ..... .....    @vv
 vext2xv_du_hu    0111 01101001 11110 01110 ..... .....    @vv
 vext2xv_du_wu    0111 01101001 11110 01111 ..... .....    @vv
 
+xvsigncov_b      0111 01010010 11100 ..... ..... .....    @vvv
+xvsigncov_h      0111 01010010 11101 ..... ..... .....    @vvv
+xvsigncov_w      0111 01010010 11110 ..... ..... .....    @vvv
+xvsigncov_d      0111 01010010 11111 ..... ..... .....    @vvv
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 714b97e238..1f01ec99d5 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2010,6 +2010,11 @@ INSN_LASX(vext2xv_wu_hu,     vv)
 INSN_LASX(vext2xv_du_hu,     vv)
 INSN_LASX(vext2xv_du_wu,     vv)
 
+INSN_LASX(xvsigncov_b,       vvv)
+INSN_LASX(xvsigncov_h,       vvv)
+INSN_LASX(xvsigncov_w,       vvv)
+INSN_LASX(xvsigncov_d,       vvv)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index 8f21f6b1c4..492bbcd4e9 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -3412,6 +3412,10 @@ TRANS(vsigncov_b, LSX, gvec_vvv, MO_8, do_vsigncov)
 TRANS(vsigncov_h, LSX, gvec_vvv, MO_16, do_vsigncov)
 TRANS(vsigncov_w, LSX, gvec_vvv, MO_32, do_vsigncov)
 TRANS(vsigncov_d, LSX, gvec_vvv, MO_64, do_vsigncov)
+TRANS(xvsigncov_b, LASX, gvec_xxx, MO_8, do_vsigncov)
+TRANS(xvsigncov_h, LASX, gvec_xxx, MO_16, do_vsigncov)
+TRANS(xvsigncov_w, LASX, gvec_xxx, MO_32, do_vsigncov)
+TRANS(xvsigncov_d, LASX, gvec_xxx, MO_64, do_vsigncov)
 
 TRANS(vmskltz_b, LSX, gen_vv, gen_helper_vmskltz_b)
 TRANS(vmskltz_h, LSX, gen_vv, gen_helper_vmskltz_h)
-- 
2.39.1


