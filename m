Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B1E925538
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jul 2024 10:20:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvDj-0008LQ-TZ; Wed, 03 Jul 2024 04:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1sOvDc-0008JP-SQ; Wed, 03 Jul 2024 04:20:01 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1sOvDX-0001Xi-DR; Wed, 03 Jul 2024 04:20:00 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 4B56BC0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1719994789;
 bh=INeM/Er9EHF9LdRPSOJiNxiKpfj7U6PC2Iz+tSuk6iE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=bYK0ilHob3T3AvjLIM5agLK9EpJ9ixd2jIp4J7STBYJvLka4rEYVmIUFFxQXzLV/D
 Il9Uw0irBNkk6XbcECnlrVqQ1uwI+MSFHJztDWl4rdavvDM6cNr3nHVdEQEHCxQ1d9
 r3kZss9HBGnoUif5iQnFS+CtNnCuOwnuRRsdP0mizt7ya04pR3lsY2So92rGLUl/HF
 yOcNqBjAytRsov2DUOpRiiXqBPaiWX9grjXsvYy9DmgQogFwCc9heajoTt52/OMg/0
 Gde4MbqnnuOIRbY1hMxsC9ejLSNkXlTX/7RgzxDo//HuUZWVHIYJTUKC9ht/NinXpD
 2O4r5ifwGkPUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1719994789;
 bh=INeM/Er9EHF9LdRPSOJiNxiKpfj7U6PC2Iz+tSuk6iE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=THADbNyU1lF5U3RdPJQR8l5I7Gvz1sbD6j64q45dMrUgfad9c6xFMI0W8a2KhWIz6
 5+dF7ytAKi6RTfBoZ57qg9HKKJHPLs5ApWY8cXi3bU06c1IoGEWoDZafm2QiQj7YbH
 qV9n2YreJns/p2sMsVp3tYCMrU1merTLcZzU1sZJU+UViAM1Mkamjdr1EHxoYj2ZGj
 LSVD3WT9S1ywFJX/dXDBolbW9xteKEln3DmX5XsDf1DLlYLeXHdv6Mg36v7ZS+LWrq
 v0V7MKhJl5Do1tphd2O5wlesjthEypPGeEJuzWC6xb5/Ws5czSgWv+d6OyoyUU1Xcf
 BN+wJ/HuC5jZA==
From: Ivan Klokov <ivan.klokov@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <bmeng.cn@gmail.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <thuth@redhat.com>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>, Ivan Klokov <ivan.klokov@syntacore.com>
Subject: [RFC PATCH v4 1/2] target/riscv: Add RISC-V CSR qtest support
Date: Wed, 3 Jul 2024 11:19:38 +0300
Message-ID: <20240703081939.498641-2-ivan.klokov@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703081939.498641-1-ivan.klokov@syntacore.com>
References: <20240703081939.498641-1-ivan.klokov@syntacore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-06.corp.yadro.com (172.17.10.110) To
 S-Exch-01.corp.yadro.com (10.78.5.241)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=ivan.klokov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

The RISC-V architecture supports the creation of custom
CSR-mapped devices. It would be convenient to test them in the same way
as MMIO-mapped devices. To do this, a new call has been added
to read/write CSR registers.

Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>
---
 target/riscv/cpu.c     | 17 ++++++++++++++
 target/riscv/cpu.h     |  3 +++
 target/riscv/csr.c     | 53 +++++++++++++++++++++++++++++++++++++++++-
 tests/qtest/libqtest.c | 27 +++++++++++++++++++++
 tests/qtest/libqtest.h | 14 +++++++++++
 5 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 69a08e8c2c..7c15860414 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1149,6 +1149,18 @@ void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     }
 }
 
+#ifndef CONFIG_USER_ONLY
+static void riscv_cpu_register_csr_qtest_callback(void)
+{
+    static gsize reinit_done;
+    if (g_once_init_enter(&reinit_done)) {
+        qtest_set_command_cb(csr_qtest_callback);
+
+        g_once_init_leave(&reinit_done, 1);
+    }
+}
+#endif
+
 static void riscv_cpu_realize(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -1175,6 +1187,11 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
 
     riscv_cpu_register_gdb_regs_for_features(cs);
 
+#ifndef CONFIG_USER_ONLY
+    /* register callback for csr qtests */
+    riscv_cpu_register_csr_qtest_callback();
+#endif
+
 #ifndef CONFIG_USER_ONLY
     if (cpu->cfg.debug) {
         riscv_trigger_realize(&cpu->env);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 6fe0d712b4..6d4bbec53c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -32,6 +32,8 @@
 #include "cpu_cfg.h"
 #include "qapi/qapi-types-common.h"
 #include "cpu-qom.h"
+#include "qemu/cutils.h"
+#include "sysemu/qtest.h"
 
 typedef struct CPUArchState CPURISCVState;
 
@@ -813,6 +815,7 @@ bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
 
 /* CSR function table */
 extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
+bool csr_qtest_callback(CharBackend *chr, gchar **words);
 
 extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 58ef7079dc..f4f5128c9c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -29,7 +29,7 @@
 #include "sysemu/cpu-timers.h"
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
-
+#include "tests/qtest/libqtest.h"
 
 /* CSR function table public API */
 void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops)
@@ -4549,6 +4549,57 @@ static RISCVException write_jvt(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+#if !defined(CONFIG_USER_ONLY)
+static uint64_t csr_call(char *cmd, uint64_t cpu_num, int csrno,
+                                uint64_t *val)
+{
+    RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(cpu_num));
+    CPURISCVState *env = &cpu->env;
+
+    int ret = RISCV_EXCP_NONE;
+    if (strcmp(cmd, "get_csr") == 0) {
+        ret = riscv_csrrw(env, csrno, (target_ulong *)val, 0, 0);
+
+    } else if (strcmp(cmd, "set_csr") == 0) {
+        ret = riscv_csrrw(env, csrno, NULL, *(target_ulong *)val, MAKE_64BIT_MASK(0, TARGET_LONG_BITS));
+    }
+
+    if (ret == RISCV_EXCP_NONE) {
+        ret = 0;
+    } else {
+        g_assert_not_reached();
+    }
+
+    return ret;
+}
+
+bool csr_qtest_callback(CharBackend *chr, gchar **words)
+{
+    if (strcmp(words[0], "csr") == 0) {
+
+        uint64_t res, cpu;
+
+        uint64_t val;
+        int rc, csr;
+
+        rc = qemu_strtou64(words[2], NULL, 0, &cpu);
+        g_assert(rc == 0);
+        rc = qemu_strtoi(words[3], NULL, 0, &csr);
+        g_assert(rc == 0);
+        rc = qemu_strtou64(words[4], NULL, 0, &val);
+        g_assert(rc == 0);
+        res = csr_call(words[1], cpu, csr, &val);
+
+        qtest_send_prefix(chr);
+        qtest_sendf(chr, "OK %"PRIx64" "TARGET_FMT_lx"\n", res, (target_ulong)val);
+
+        return true;
+    }
+
+    return false;
+}
+#endif
+
 /*
  * Control and Status Register function table
  * riscv_csr_operations::predicate() must be provided for an implemented CSR
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index c7f6897d78..f8c3ff15a9 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1205,6 +1205,33 @@ uint64_t qtest_rtas_call(QTestState *s, const char *name,
     return 0;
 }
 
+static void qtest_rsp_csr(QTestState *s, uint64_t *val)
+{
+    gchar **args;
+    uint64_t ret;
+    int rc;
+
+    args = qtest_rsp_args(s, 3);
+
+    rc = qemu_strtou64(args[1], NULL, 16, &ret);
+    g_assert(rc == 0);
+    rc = qemu_strtou64(args[2], NULL, 16, val);
+    g_assert(rc == 0);
+
+    g_strfreev(args);
+}
+
+uint64_t qtest_csr_call(QTestState *s, const char *name,
+                         uint64_t cpu, int csr,
+                         uint64_t *val)
+{
+    qtest_sendf(s, "csr %s 0x%"PRIx64" %d 0x%"PRIx64"\n",
+                    name, cpu, csr, *val);
+
+    qtest_rsp_csr(s, val);
+    return 0;
+}
+
 void qtest_add_func(const char *str, void (*fn)(void))
 {
     gchar *path = g_strdup_printf("/%s/%s", qtest_get_arch(), str);
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index c261b7e0b3..7b547e5e2c 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -577,6 +577,20 @@ uint64_t qtest_rtas_call(QTestState *s, const char *name,
                          uint32_t nargs, uint64_t args,
                          uint32_t nret, uint64_t ret);
 
+/**
+ * qtest_csr_call:
+ * @s: #QTestState instance to operate on.
+ * @name: name of the command to call.
+ * @cpu: hart number.
+ * @csr: CSR number.
+ * @val: Value for reading/writing.
+ *
+ * Call an RISC-V CSR read/write function
+ */
+uint64_t qtest_csr_call(QTestState *s, const char *name,
+                         uint64_t cpu, int csr,
+                         unsigned long *val);
+
 /**
  * qtest_bufread:
  * @s: #QTestState instance to operate on.
-- 
2.34.1


