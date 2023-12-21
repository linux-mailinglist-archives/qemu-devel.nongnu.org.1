Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1876F81B02E
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 09:20:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGEH7-0005TD-Fq; Thu, 21 Dec 2023 03:19:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rGEGx-0005Sg-6d
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 03:19:15 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rGEGv-0007Vz-2T
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 03:19:14 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Ax2uj79INlI1wDAA--.17045S3;
 Thu, 21 Dec 2023 16:19:07 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxG+T49INltGsDAA--.18043S4; 
 Thu, 21 Dec 2023 16:19:06 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 2/2] target/loongarch: Add timer information dump support
Date: Thu, 21 Dec 2023 16:06:11 +0800
Message-Id: <20231221080611.2960977-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231221080611.2960977-1-gaosong@loongson.cn>
References: <20231221080611.2960977-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxG+T49INltGsDAA--.18043S4
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

From: Bibo Mao <maobibo@loongson.cn>

Timer emulation sometimes is problematic especially when vm is running in
kvm mode. This patch adds registers dump support relative with timer
hardware, so that it is easier to find the problems.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20231206081839.2290178-1-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index b26187dfde..07319d6fb9 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -764,6 +764,8 @@ void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     qemu_fprintf(f, "TLBRENTRY=%016" PRIx64 "\n", env->CSR_TLBRENTRY);
     qemu_fprintf(f, "TLBRBADV=%016" PRIx64 "\n", env->CSR_TLBRBADV);
     qemu_fprintf(f, "TLBRERA=%016" PRIx64 "\n", env->CSR_TLBRERA);
+    qemu_fprintf(f, "TCFG=%016" PRIx64 "\n", env->CSR_TCFG);
+    qemu_fprintf(f, "TVAL=%016" PRIx64 "\n", env->CSR_TVAL);
 
     /* fpr */
     if (flags & CPU_DUMP_FPU) {
-- 
2.25.1


