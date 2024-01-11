Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7080982AD85
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:32:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNtHV-0002Fn-TH; Thu, 11 Jan 2024 06:31:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rNtGM-0000lz-0j
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:30:18 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rNtGJ-0007YC-MZ
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:30:17 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx6ekA0Z9lnj8EAA--.8459S3;
 Thu, 11 Jan 2024 19:29:04 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx34f80J9l6+4PAA--.41647S12; 
 Thu, 11 Jan 2024 19:29:04 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: 
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 Tianrui Zhao <zhaotianrui@loongson.cn>,
 xianglai li <lixianglai@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL  10/14] target/loongarch: Add loongarch kvm into meson build
Date: Thu, 11 Jan 2024 19:16:05 +0800
Message-Id: <20240111111609.899183-11-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240111111609.899183-1-gaosong@loongson.cn>
References: <20240111111609.899183-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx34f80J9l6+4PAA--.41647S12
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

From: Tianrui Zhao <zhaotianrui@loongson.cn>

Add kvm.c into meson.build to compile it when kvm
is configed. Meanwhile in meson.build, we set the
kvm_targets to loongarch64-softmmu when the cpu is
loongarch. And fix the compiling error when config
is enable-kvm,disable-tcg.

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
Signed-off-by: xianglai li <lixianglai@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240105075804.1228596-10-zhaotianrui@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 meson.build                      | 2 ++
 target/loongarch/kvm/meson.build | 1 +
 target/loongarch/meson.build     | 1 +
 3 files changed, 4 insertions(+)
 create mode 100644 target/loongarch/kvm/meson.build

diff --git a/meson.build b/meson.build
index b0dd87b8f8..2e0c2eaaa7 100644
--- a/meson.build
+++ b/meson.build
@@ -229,6 +229,8 @@ elif cpu in ['riscv32']
   kvm_targets = ['riscv32-softmmu']
 elif cpu in ['riscv64']
   kvm_targets = ['riscv64-softmmu']
+elif cpu in ['loongarch64']
+  kvm_targets = ['loongarch64-softmmu']
 else
   kvm_targets = []
 endif
diff --git a/target/loongarch/kvm/meson.build b/target/loongarch/kvm/meson.build
new file mode 100644
index 0000000000..2266de6ca9
--- /dev/null
+++ b/target/loongarch/kvm/meson.build
@@ -0,0 +1 @@
+loongarch_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'))
diff --git a/target/loongarch/meson.build b/target/loongarch/meson.build
index e84e4c51f4..db310f6022 100644
--- a/target/loongarch/meson.build
+++ b/target/loongarch/meson.build
@@ -18,3 +18,4 @@ subdir('tcg')
 
 target_arch += {'loongarch': loongarch_ss}
 target_system_arch += {'loongarch': loongarch_system_ss}
+subdir('kvm')
-- 
2.25.1


