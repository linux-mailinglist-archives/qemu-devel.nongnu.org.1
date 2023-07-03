Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 285C4746285
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 20:34:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGOLa-0007fd-Ad; Mon, 03 Jul 2023 14:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGOLY-0007fK-Uv
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 14:32:24 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGOLW-0000Gn-PB
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 14:32:24 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-4f95bf5c493so7144506e87.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 11:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688409141; x=1691001141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4bG6Uf/f+7A9KUtA1/pgxRjW23AnhFwtnrhoueQYVoE=;
 b=l+2ChdevBjcIfvn9AhtX3fD4MMM0dAvft+4W8xt/IK4/PckfjjtLGAAoJ0BrWC6U8k
 cF3mKMWViAvtpfL5TiuaiI6cBmXyNBhK/2OlymgxnmVJcEpdOESiGEt6gOzvVc50gyjx
 yUZOORyMtmaMAvOcPRXf2uxDShbPHRTiDiSluaihSDxSpV7BVdFooWlso8UGEZqhHKfh
 BaJyW79x1RSSEsxAZNz7Kyq4d268tVsG4FjoEdmWe5GcPNpyyiqHfn4BD6TX6ZpGwwY8
 ZY76TbtQJ/2cyp4GJBhhDEaQ4nKzbGPd7URNiavcN3kOaNn1JUNP1iUDRU6evPtNNzON
 8wXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688409141; x=1691001141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4bG6Uf/f+7A9KUtA1/pgxRjW23AnhFwtnrhoueQYVoE=;
 b=Dd9KNmpF+nZwzRB9UtKII+V6TeM8fbvUZJgUbXXSz+KswmHlijL//1H2UUdqST3m9u
 M/2u28uj+c81xvSpoto3dKTGv/ya+9EHnnQ7FhH9FwxQsHPAX0my8HcbeY4LNJkkw7pC
 AHPfbWFyPSxmDZTe1ykdacX77QopMxUbKVZOyZz2T28KUJjXy01dprcQ5xlD0CJoOOSb
 U/uXA46y80bhNtu6a1u1Qe1A75FaxxtGQKYoaeg20a5DCDynW+MrA1R1Ld3XZ0FqPL4N
 m9TeYdcFbum9xw7YKCkhb+v+dotf3iasn7oBJ9PN7TZenF6QNLCvVt+GmBjBsPRYF2av
 Dszw==
X-Gm-Message-State: ABy/qLbwalzX5+J84SIna0J6gwFmq4vudlsG88t1aWelvnNvl8EIpwms
 S6jSYc0BLHufecavz2M5wJKq+OABHTJ3zO697OxSJA==
X-Google-Smtp-Source: APBJJlGFGnhT5RLkkgDIpKQv7mTdVVQkp+tAdwZuLnSj/7qBhLO+MtKnBrYUv+3qzr+Tvm2xUBibww==
X-Received: by 2002:ac2:4bc6:0:b0:4f8:6627:7983 with SMTP id
 o6-20020ac24bc6000000b004f866277983mr7142126lfq.5.1688409140660; 
 Mon, 03 Jul 2023 11:32:20 -0700 (PDT)
Received: from localhost.localdomain ([176.176.178.91])
 by smtp.gmail.com with ESMTPSA id
 m15-20020a056000180f00b003141e1e0b9asm10439916wrh.61.2023.07.03.11.32.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Jul 2023 11:32:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, kvm@vger.kernel.org,
 qemu-riscv@nongnu.org, Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2 05/16] target/riscv: Move sysemu-specific files to
 target/riscv/sysemu/
Date: Mon,  3 Jul 2023 20:31:34 +0200
Message-Id: <20230703183145.24779-6-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230703183145.24779-1-philmd@linaro.org>
References: <20230703183145.24779-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Move sysemu-specific files to the a new 'sysemu' sub-directory,
adapt meson rules.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h                         |  2 +-
 target/riscv/{ => sysemu}/instmap.h        |  0
 target/riscv/{ => sysemu}/kvm_riscv.h      |  0
 target/riscv/{ => sysemu}/pmp.h            |  0
 target/riscv/{ => sysemu}/pmu.h            |  0
 target/riscv/{ => sysemu}/time_helper.h    |  0
 hw/riscv/virt.c                            |  2 +-
 target/riscv/cpu.c                         |  6 ++---
 target/riscv/cpu_helper.c                  |  4 +--
 target/riscv/csr.c                         |  4 +--
 target/riscv/{ => sysemu}/arch_dump.c      |  0
 target/riscv/sysemu/kvm-stub.c             | 30 ++++++++++++++++++++++
 target/riscv/{ => sysemu}/kvm.c            |  0
 target/riscv/{ => sysemu}/machine.c        |  0
 target/riscv/{ => sysemu}/monitor.c        |  0
 target/riscv/{ => sysemu}/pmp.c            |  0
 target/riscv/{ => sysemu}/pmu.c            |  0
 target/riscv/{ => sysemu}/riscv-qmp-cmds.c |  0
 target/riscv/{ => sysemu}/time_helper.c    |  0
 target/riscv/meson.build                   | 13 +++-------
 target/riscv/sysemu/meson.build            | 11 ++++++++
 21 files changed, 54 insertions(+), 18 deletions(-)
 rename target/riscv/{ => sysemu}/instmap.h (100%)
 rename target/riscv/{ => sysemu}/kvm_riscv.h (100%)
 rename target/riscv/{ => sysemu}/pmp.h (100%)
 rename target/riscv/{ => sysemu}/pmu.h (100%)
 rename target/riscv/{ => sysemu}/time_helper.h (100%)
 rename target/riscv/{ => sysemu}/arch_dump.c (100%)
 create mode 100644 target/riscv/sysemu/kvm-stub.c
 rename target/riscv/{ => sysemu}/kvm.c (100%)
 rename target/riscv/{ => sysemu}/machine.c (100%)
 rename target/riscv/{ => sysemu}/monitor.c (100%)
 rename target/riscv/{ => sysemu}/pmp.c (100%)
 rename target/riscv/{ => sysemu}/pmu.c (100%)
 rename target/riscv/{ => sysemu}/riscv-qmp-cmds.c (100%)
 rename target/riscv/{ => sysemu}/time_helper.c (100%)
 create mode 100644 target/riscv/sysemu/meson.build

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 3081603464..00a4842d84 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -88,7 +88,7 @@ typedef enum {
 #define MAX_RISCV_PMPS (16)
 
 #if !defined(CONFIG_USER_ONLY)
-#include "pmp.h"
+#include "sysemu/pmp.h"
 #include "debug.h"
 #endif
 
diff --git a/target/riscv/instmap.h b/target/riscv/sysemu/instmap.h
similarity index 100%
rename from target/riscv/instmap.h
rename to target/riscv/sysemu/instmap.h
diff --git a/target/riscv/kvm_riscv.h b/target/riscv/sysemu/kvm_riscv.h
similarity index 100%
rename from target/riscv/kvm_riscv.h
rename to target/riscv/sysemu/kvm_riscv.h
diff --git a/target/riscv/pmp.h b/target/riscv/sysemu/pmp.h
similarity index 100%
rename from target/riscv/pmp.h
rename to target/riscv/sysemu/pmp.h
diff --git a/target/riscv/pmu.h b/target/riscv/sysemu/pmu.h
similarity index 100%
rename from target/riscv/pmu.h
rename to target/riscv/sysemu/pmu.h
diff --git a/target/riscv/time_helper.h b/target/riscv/sysemu/time_helper.h
similarity index 100%
rename from target/riscv/time_helper.h
rename to target/riscv/sysemu/time_helper.h
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 8ff4b5fd71..8f6b63ad07 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -30,7 +30,7 @@
 #include "hw/char/serial.h"
 #include "target/riscv/cpu.h"
 #include "hw/core/sysbus-fdt.h"
-#include "target/riscv/pmu.h"
+#include "target/riscv/sysemu/pmu.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/virt.h"
 #include "hw/riscv/boot.h"
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 78ab61c274..cd01af3595 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -24,10 +24,10 @@
 #include "cpu.h"
 #include "cpu_vendorid.h"
 #ifndef CONFIG_USER_ONLY
-#include "pmu.h"
-#include "time_helper.h"
+#include "sysemu/pmu.h"
+#include "sysemu/time_helper.h"
 #include "sysemu/kvm.h"
-#include "kvm_riscv.h"
+#include "sysemu/kvm_riscv.h"
 #endif
 #include "internals.h"
 #include "exec/exec-all.h"
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e8b7f70be3..0adde26321 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -22,9 +22,9 @@
 #include "qemu/main-loop.h"
 #include "cpu.h"
 #include "internals.h"
-#include "pmu.h"
+#include "sysemu/pmu.h"
 #include "exec/exec-all.h"
-#include "instmap.h"
+#include "sysemu/instmap.h"
 #include "tcg/tcg-op.h"
 #include "trace.h"
 #include "semihosting/common-semi.h"
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index e5737dcf58..29151429ee 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -22,8 +22,8 @@
 #include "qemu/timer.h"
 #include "cpu.h"
 #ifndef CONFIG_USER_ONLY
-#include "pmu.h"
-#include "time_helper.h"
+#include "sysemu/pmu.h"
+#include "sysemu/time_helper.h"
 #endif
 #include "qemu/main-loop.h"
 #include "exec/exec-all.h"
diff --git a/target/riscv/arch_dump.c b/target/riscv/sysemu/arch_dump.c
similarity index 100%
rename from target/riscv/arch_dump.c
rename to target/riscv/sysemu/arch_dump.c
diff --git a/target/riscv/sysemu/kvm-stub.c b/target/riscv/sysemu/kvm-stub.c
new file mode 100644
index 0000000000..4e8fc31a21
--- /dev/null
+++ b/target/riscv/sysemu/kvm-stub.c
@@ -0,0 +1,30 @@
+/*
+ * QEMU KVM RISC-V specific function stubs
+ *
+ * Copyright (c) 2020 Huawei Technologies Co., Ltd
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "kvm_riscv.h"
+
+void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
+{
+    abort();
+}
+
+void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level)
+{
+    abort();
+}
diff --git a/target/riscv/kvm.c b/target/riscv/sysemu/kvm.c
similarity index 100%
rename from target/riscv/kvm.c
rename to target/riscv/sysemu/kvm.c
diff --git a/target/riscv/machine.c b/target/riscv/sysemu/machine.c
similarity index 100%
rename from target/riscv/machine.c
rename to target/riscv/sysemu/machine.c
diff --git a/target/riscv/monitor.c b/target/riscv/sysemu/monitor.c
similarity index 100%
rename from target/riscv/monitor.c
rename to target/riscv/sysemu/monitor.c
diff --git a/target/riscv/pmp.c b/target/riscv/sysemu/pmp.c
similarity index 100%
rename from target/riscv/pmp.c
rename to target/riscv/sysemu/pmp.c
diff --git a/target/riscv/pmu.c b/target/riscv/sysemu/pmu.c
similarity index 100%
rename from target/riscv/pmu.c
rename to target/riscv/sysemu/pmu.c
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/sysemu/riscv-qmp-cmds.c
similarity index 100%
rename from target/riscv/riscv-qmp-cmds.c
rename to target/riscv/sysemu/riscv-qmp-cmds.c
diff --git a/target/riscv/time_helper.c b/target/riscv/sysemu/time_helper.c
similarity index 100%
rename from target/riscv/time_helper.c
rename to target/riscv/sysemu/time_helper.c
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index e3ab3df4e5..8967dfaded 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -7,6 +7,8 @@ gen = [
 ]
 
 riscv_ss = ss.source_set()
+riscv_system_ss = ss.source_set()
+
 riscv_ss.add(gen)
 riscv_ss.add(files(
   'cpu.c',
@@ -22,19 +24,12 @@ riscv_ss.add(files(
   'crypto_helper.c',
   'zce_helper.c'
 ))
-riscv_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'))
 
-riscv_system_ss = ss.source_set()
 riscv_system_ss.add(files(
-  'arch_dump.c',
-  'pmp.c',
   'debug.c',
-  'monitor.c',
-  'machine.c',
-  'pmu.c',
-  'time_helper.c',
-  'riscv-qmp-cmds.c',
 ))
 
+subdir('sysemu')
+
 target_arch += {'riscv': riscv_ss}
 target_softmmu_arch += {'riscv': riscv_system_ss}
diff --git a/target/riscv/sysemu/meson.build b/target/riscv/sysemu/meson.build
new file mode 100644
index 0000000000..64de0256a5
--- /dev/null
+++ b/target/riscv/sysemu/meson.build
@@ -0,0 +1,11 @@
+riscv_system_ss.add(files(
+  'arch_dump.c',
+  'machine.c',
+  'monitor.c',
+  'pmp.c',
+  'pmu.c',
+  'riscv-qmp-cmds.c',
+  'time_helper.c',
+))
+
+riscv_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'))
-- 
2.38.1


