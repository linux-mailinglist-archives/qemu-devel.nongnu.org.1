Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D1881969B
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 03:00:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFlrn-0004E5-En; Tue, 19 Dec 2023 20:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaotianrui@loongson.cn>)
 id 1rFlrP-0004AP-E8
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 20:59:02 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhaotianrui@loongson.cn>) id 1rFlrJ-0000UT-Kp
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 20:58:57 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxCulbSoJlhtACAA--.14110S3;
 Wed, 20 Dec 2023 09:58:51 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxIL9OSoJljk8BAA--.8666S11; 
 Wed, 20 Dec 2023 09:58:51 +0800 (CST)
From: Tianrui Zhao <zhaotianrui@loongson.cn>
To: qemu-devel@nongnu.org, gaosong@loongson.cn, philmd@linaro.org,
 richard.henderson@linaro.org, peter.maydell@linaro.org
Cc: maobibo@loongson.cn, zhaotianrui@loongson.cn, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 berrange@redhat.com, thuth@redhat.com, yangxiaojuan@loongson.cn,
 xianglai li <lixianglai@loongson.cn>
Subject: [PATCH v2 9/9] target/loongarch: Add loongarch kvm into meson build
Date: Wed, 20 Dec 2023 09:45:45 +0800
Message-Id: <20231220014545.2889155-10-zhaotianrui@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231220014545.2889155-1-zhaotianrui@loongson.cn>
References: <20231220014545.2889155-1-zhaotianrui@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxIL9OSoJljk8BAA--.8666S11
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
loongarch.

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
Signed-off-by: xianglai li <lixianglai@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build                  | 2 ++
 target/loongarch/meson.build | 1 +
 2 files changed, 3 insertions(+)

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
diff --git a/target/loongarch/meson.build b/target/loongarch/meson.build
index 18e8191e2b..1b21c51e22 100644
--- a/target/loongarch/meson.build
+++ b/target/loongarch/meson.build
@@ -27,6 +27,7 @@ loongarch_system_ss.add(files(
 
 common_ss.add(when: 'CONFIG_LOONGARCH_DIS', if_true: [files('disas.c'), gen])
 
+loongarch_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'))
 loongarch_ss.add_all(when: 'CONFIG_TCG', if_true: [loongarch_tcg_ss])
 
 target_arch += {'loongarch': loongarch_ss}
-- 
2.39.1


