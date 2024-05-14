Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A58B8C50A2
	for <lists+qemu-devel@lfdr.de>; Tue, 14 May 2024 13:08:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6q10-0004ps-DQ; Tue, 14 May 2024 07:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s6q0q-0004ff-FC
 for qemu-devel@nongnu.org; Tue, 14 May 2024 07:08:04 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s6q0l-0006WE-OU
 for qemu-devel@nongnu.org; Tue, 14 May 2024 07:08:03 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bx+ukJRkNm+6MMAA--.18527S3;
 Tue, 14 May 2024 19:07:53 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxMlYIRkNmaVkeAA--.37485S2; 
 Tue, 14 May 2024 19:07:52 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, zhaotianrui@loongson.cn,
 richard.henderson@linaro.org, philmd@linaro.org, peter.maydell@linaro.org
Subject: [PATCH] target/loongarch/kvm: fpu save the vreg registers high 192bit
Date: Tue, 14 May 2024 19:07:52 +0800
Message-Id: <20240514110752.989572-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxMlYIRkNmaVkeAA--.37485S2
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

On kvm side, get_fpu/set_fpu save the vreg registers high 192bits,
but QEMU missing.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/kvm/kvm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index a9f9020071..0b5dbb7ed8 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -436,6 +436,9 @@ static int kvm_loongarch_get_regs_fp(CPUState *cs)
     env->fcsr0 = fpu.fcsr;
     for (i = 0; i < 32; i++) {
         env->fpr[i].vreg.UD[0] = fpu.fpr[i].val64[0];
+        env->fpr[i].vreg.UD[1] = fpu.fpr[i].val64[1];
+        env->fpr[i].vreg.UD[2] = fpu.fpr[i].val64[2];
+        env->fpr[i].vreg.UD[3] = fpu.fpr[i].val64[3];
     }
     for (i = 0; i < 8; i++) {
         env->cf[i] = fpu.fcc & 0xFF;
@@ -455,6 +458,9 @@ static int kvm_loongarch_put_regs_fp(CPUState *cs)
     fpu.fcc = 0;
     for (i = 0; i < 32; i++) {
         fpu.fpr[i].val64[0] = env->fpr[i].vreg.UD[0];
+        fpu.fpr[i].val64[1] = env->fpr[i].vreg.UD[1];
+        fpu.fpr[i].val64[2] = env->fpr[i].vreg.UD[2];
+        fpu.fpr[i].val64[3] = env->fpr[i].vreg.UD[3];
     }
 
     for (i = 0; i < 8; i++) {
-- 
2.25.1


