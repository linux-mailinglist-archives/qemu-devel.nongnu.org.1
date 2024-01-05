Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B51824F86
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 09:12:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLfIV-0002pE-FH; Fri, 05 Jan 2024 03:11:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaotianrui@loongson.cn>)
 id 1rLfIR-0002o2-Vu
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 03:11:15 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhaotianrui@loongson.cn>) id 1rLfIQ-0007Fj-0m
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 03:11:15 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxHLueuZdliUECAA--.109S3;
 Fri, 05 Jan 2024 16:11:10 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxO9yQuZdl8xoDAA--.8153S11; 
 Fri, 05 Jan 2024 16:11:09 +0800 (CST)
From: Tianrui Zhao <zhaotianrui@loongson.cn>
To: qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, maobibo@loongson.cn, zhaotianrui@loongson.cn,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, richard.henderson@linaro.org, peter.maydell@linaro.org,
 yangxiaojuan@loongson.cn, xianglai li <lixianglai@loongson.cn>
Subject: [PATCH v4 9/9] target/loongarch: Add loongarch kvm into meson build
Date: Fri,  5 Jan 2024 15:58:04 +0800
Message-Id: <20240105075804.1228596-10-zhaotianrui@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240105075804.1228596-1-zhaotianrui@loongson.cn>
References: <20240105075804.1228596-1-zhaotianrui@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxO9yQuZdl8xoDAA--.8153S11
X-CM-SenderInfo: p2kd03xldq233l6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=zhaotianrui@loongson.cn; helo=mail.loongson.cn
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

Add kvm.c into meson.build to compile it when kvm
is configed. Meanwhile in meson.build, we set the
kvm_targets to loongarch64-softmmu when the cpu is
loongarch. And fix the compiling error when config
is enable-kvm,disable-tcg.

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
Signed-off-by: xianglai li <lixianglai@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build                      | 2 ++
 target/loongarch/kvm/meson.build | 1 +
 target/loongarch/meson.build     | 1 +
 3 files changed, 4 insertions(+)
 create mode 100644 target/loongarch/kvm/meson.build

diff --git a/meson.build b/meson.build
index 445f2b7c2b..0c62b4156d 100644
--- a/meson.build
+++ b/meson.build
@@ -114,6 +114,8 @@ elif cpu in ['riscv32']
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
index 18e8191e2b..7f86caf373 100644
--- a/target/loongarch/meson.build
+++ b/target/loongarch/meson.build
@@ -31,3 +31,4 @@ loongarch_ss.add_all(when: 'CONFIG_TCG', if_true: [loongarch_tcg_ss])
 
 target_arch += {'loongarch': loongarch_ss}
 target_system_arch += {'loongarch': loongarch_system_ss}
+subdir('kvm')
-- 
2.39.1


