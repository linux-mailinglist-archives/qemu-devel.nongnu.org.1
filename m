Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CCE7886FE
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 14:19:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZVlO-00018G-Ek; Fri, 25 Aug 2023 08:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1qZVlL-000178-NB; Fri, 25 Aug 2023 08:18:03 -0400
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1qZVlH-0003rS-6N; Fri, 25 Aug 2023 08:18:03 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R861e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=15; SR=0;
 TI=SMTPD_---0VqXSP.6_1692965863; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0VqXSP.6_1692965863) by smtp.aliyun-inc.com;
 Fri, 25 Aug 2023 20:17:44 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com, palmer@dabbelt.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 richard.henderson@linaro.org, pbonzini@redhat.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org,
 ajones@ventanamicro.com
Subject: [RFC PATCH 3/3] softmmu/vl: Add qemu_cpu_opts QemuOptsList
Date: Fri, 25 Aug 2023 20:16:51 +0800
Message-Id: <20230825121651.1534-4-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20230825121651.1534-1-zhiwei_liu@linux.alibaba.com>
References: <20230825121651.1534-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
X-Spam_score_int: -98
X-Spam_score: -9.9
X-Spam_bar: ---------
X-Spam_report: (-9.9 / 5.0 requ) BAYES_00=-1.9, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

This make the cpu works the similar way like the -device option.

For device option,
"""
./qemu-system-riscv64 -device e1000,help
e1000 options:
  acpi-index=<uint32>    -  (default: 0)
  addr=<int32>           - Slot and optional function number, example: 06.0 or 06 (default: -1)
  autonegotiation=<bool> - on/off (default: true)
  bootindex=<int32>
  extra_mac_registers=<bool> - on/off (default: true)
  failover_pair_id=<str>
"""

After this patch, the cpu can output its configurations,
"""
./qemu-system-riscv64 -cpu rv64,help
Enable extension:
	rv64imafdch_zicbom_zicboz_zicsr_zifencei_zihintpause_zawrs_zfa_zba_zbb_zbc_zbs_sstc_svadu
"""

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 cpu.c                 |  2 +-
 include/hw/core/cpu.h | 11 +++++++++++
 softmmu/vl.c          | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/cpu.c b/cpu.c
index 03a313cd72..712bd02684 100644
--- a/cpu.c
+++ b/cpu.c
@@ -257,7 +257,7 @@ void cpu_exec_initfn(CPUState *cpu)
 #endif
 }
 
-static const char *cpu_type_by_name(const char *cpu_model)
+const char *cpu_type_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
     const char *cpu_type;
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index fdcbe87352..49d41afdfa 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -657,6 +657,17 @@ CPUState *cpu_create(const char *typename);
  */
 const char *parse_cpu_option(const char *cpu_option);
 
+/**
+ * cpu_type_by_name:
+ * @cpu_model: The -cpu command line model name.
+ *
+ * Looks up type name by the -cpu command line model name
+ *
+ * Returns: type name of CPU or prints error and terminates process
+ *          if an error occurred.
+ */
+const char *cpu_type_by_name(const char *cpu_model);
+
 /**
  * cpu_has_work:
  * @cpu: The vCPU to check.
diff --git a/softmmu/vl.c b/softmmu/vl.c
index b0b96f67fa..bc30f3954d 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -218,6 +218,15 @@ static struct {
     { .driver = "virtio-vga-gl",        .flag = &default_vga       },
 };
 
+static QemuOptsList qemu_cpu_opts = {
+    .name = "cpu",
+    .implied_opt_name = "cpu_model",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_cpu_opts.head),
+    .desc = {
+        { /* end of list */ }
+    },
+};
+
 static QemuOptsList qemu_rtc_opts = {
     .name = "rtc",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_rtc_opts.head),
@@ -1140,6 +1149,21 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
     return 0;
 }
 
+static int cpu_help_func(void *opaque, QemuOpts *opts, Error **errp)
+{
+    const char *cpu_model, *cpu_type;
+    cpu_model = qemu_opt_get(opts, "cpu_model");
+    if (!cpu_model) {
+        return 1;
+    }
+    if (!qemu_opt_has_help_opt(opts)) {
+        return 0;
+    }
+    cpu_type = cpu_type_by_name(cpu_model);
+    list_cpu_props((CPUState *)object_new(cpu_type));
+    return 1;
+}
+
 static int device_help_func(void *opaque, QemuOpts *opts, Error **errp)
 {
     return qdev_device_help(opts);
@@ -2467,6 +2491,11 @@ static void qemu_process_help_options(void)
         exit(0);
     }
 
+    if (qemu_opts_foreach(qemu_find_opts("cpu"),
+                          cpu_help_func, NULL, NULL)) {
+        exit(0);
+    }
+
     if (qemu_opts_foreach(qemu_find_opts("device"),
                           device_help_func, NULL, NULL)) {
         exit(0);
@@ -2680,6 +2709,7 @@ void qemu_init(int argc, char **argv)
     qemu_add_drive_opts(&bdrv_runtime_opts);
     qemu_add_opts(&qemu_chardev_opts);
     qemu_add_opts(&qemu_device_opts);
+    qemu_add_opts(&qemu_cpu_opts);
     qemu_add_opts(&qemu_netdev_opts);
     qemu_add_opts(&qemu_nic_opts);
     qemu_add_opts(&qemu_net_opts);
@@ -2756,6 +2786,11 @@ void qemu_init(int argc, char **argv)
             case QEMU_OPTION_cpu:
                 /* hw initialization will check this */
                 cpu_option = optarg;
+                opts = qemu_opts_parse_noisily(qemu_find_opts("cpu"),
+                                               optarg, true);
+                if (!opts) {
+                    exit(1);
+                }
                 break;
             case QEMU_OPTION_hda:
             case QEMU_OPTION_hdb:
-- 
2.17.1


