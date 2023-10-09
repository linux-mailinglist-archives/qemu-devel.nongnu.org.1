Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE247BD621
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:03:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmA0-0002IU-03; Mon, 09 Oct 2023 05:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qpm9i-0002DZ-Cb
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:02:32 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qpm9e-00060g-96
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:02:25 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxyOiWwSNllT0wAA--.56768S3;
 Mon, 09 Oct 2023 17:02:14 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dx_y+TwSNlDW4cAA--.59991S5; 
 Mon, 09 Oct 2023 17:02:13 +0800 (CST)
From: xianglai li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Bibo Mao <maobibo@loongson.cn>,
 Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>
Subject: [PATCH RFC v4 3/9] target/loongarch: Supplement vcpu env initial when
 vcpu reset
Date: Mon,  9 Oct 2023 17:01:31 +0800
Message-Id: <9374877045c45abee710d476d46dd028f17cd84c.1696841645.git.lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1696841645.git.lixianglai@loongson.cn>
References: <cover.1696841645.git.lixianglai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx_y+TwSNlDW4cAA--.59991S5
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
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

From: Tianrui Zhao <zhaotianrui@loongson.cn>

Supplement vcpu env initial when vcpu reset, including
init vcpu CSR_CPUID,CSR_TID to cpu->cpu_index. The two
regs will be used in kvm_get/set_csr_ioctl.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>
Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
Signed-off-by: xianglai li <lixianglai@loongson.cn>
---
 target/loongarch/cpu.c | 2 ++
 target/loongarch/cpu.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 2bea7ca5d5..0d763d8a65 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -524,10 +524,12 @@ static void loongarch_cpu_reset_hold(Object *obj)
 
     env->CSR_ESTAT = env->CSR_ESTAT & (~MAKE_64BIT_MASK(0, 2));
     env->CSR_RVACFG = FIELD_DP64(env->CSR_RVACFG, CSR_RVACFG, RBITS, 0);
+    env->CSR_CPUID = cs->cpu_index;
     env->CSR_TCFG = FIELD_DP64(env->CSR_TCFG, CSR_TCFG, EN, 0);
     env->CSR_LLBCTL = FIELD_DP64(env->CSR_LLBCTL, CSR_LLBCTL, KLO, 0);
     env->CSR_TLBRERA = FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 0);
     env->CSR_MERRCTL = FIELD_DP64(env->CSR_MERRCTL, CSR_MERRCTL, ISMERR, 0);
+    env->CSR_TID = cs->cpu_index;
 
     env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, TLB_TYPE, 2);
     env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, MTLB_ENTRY, 63);
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 40e70a8119..e6a99c83ab 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -318,6 +318,7 @@ typedef struct CPUArchState {
     uint64_t CSR_PWCH;
     uint64_t CSR_STLBPS;
     uint64_t CSR_RVACFG;
+    uint64_t CSR_CPUID;
     uint64_t CSR_PRCFG1;
     uint64_t CSR_PRCFG2;
     uint64_t CSR_PRCFG3;
@@ -349,7 +350,6 @@ typedef struct CPUArchState {
     uint64_t CSR_DBG;
     uint64_t CSR_DERA;
     uint64_t CSR_DSAVE;
-    uint64_t CSR_CPUID;
 
 #ifndef CONFIG_USER_ONLY
     LoongArchTLB  tlb[LOONGARCH_TLB_MAX];
-- 
2.39.1


