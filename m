Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5311B9109BA
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jun 2024 17:23:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKJcb-00065r-9g; Thu, 20 Jun 2024 11:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKJcZ-00063Y-6X
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:22:43 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKJcV-00081d-41
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:22:42 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52bc27cfb14so1407221e87.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 08:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718896957; x=1719501757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aTqVMPQXWo8mkGU1ZZQCTroEdUrbxvLcJ6ei12/57OI=;
 b=d5uksvkY3FBaCKVQz4bZ0+EHZEK+yup7oPLybmPtY8AfpExGc4lfiJCw6jhQ7ChbRk
 +fpwnJPRI3tudfvZtnZnen7hrZRSR+tjkbTEKS4kzJ0ogR8IgSbznrZO5I5R5oA3ZGs/
 xZWO8TLp3bxJgDF0AFJ4QI6xLCWCbYNQFaHECGP42+kwSKJtGSGPtPpN3cFEyLwLvQRy
 oF/XJYyc+z+PJ3UsPpvcJhmRBL1uYZglEH1B7UDG8yHpSKm+PVs0mBxwkoLLydb7EKSo
 fRkKzelUFTrtBlR9JBiq7UO8oas218dacl+1X+xTtmR5P6HPlnTvhkXzfOF7o1CHCL41
 Ri1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718896957; x=1719501757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aTqVMPQXWo8mkGU1ZZQCTroEdUrbxvLcJ6ei12/57OI=;
 b=V4xfOuyYSQwxryRIIK5uMMXjjhBCFMQUjT4KEu2Lt8cQeieVtcK9ps+KK8II/Qr+Lp
 iVmZvz0yzk5PqtiAdgBTtc5jOOSW/Nx8qpGE3Ne/kAK7UJ4an/tC0R4XL6aICELvk9+e
 Vl/1Pg5H0uHO5yPbEWaaQaAUyCMBGfHOikVm1EE45NT8sb66lkleb0rYTiHeRGsmHBHZ
 UjhAbXWP39W8DgE/SUqNIdSaB7H/g6B1hLsB6gGFsPAEDNO0aJvTa8N83bcUatyvJHlu
 PPo5JUmn4/9NC+cA6NUVO2vM+jLlDy/hA4HGu8NZxScJJNpAuZcAqx94kaX0+TVuLqru
 3w2A==
X-Gm-Message-State: AOJu0YzKofaMvpTyO8Q5EkObvGcgdziKqOZbRHcooHonIthF4I8vicCi
 XNIRLsZHR64IwaBht+HQYcg3DPwseSQ5YYGvLtfRO6TO2mNbmzaHXmjgB10LmpQ=
X-Google-Smtp-Source: AGHT+IF6+wEHSuI7S/SNc8KgBe4bVoRR9T1WyMx8dtnAy/pGDd8PXI3gNYJwem0B1HteMfPE9Z02lA==
X-Received: by 2002:a05:6512:3994:b0:52c:cb8d:637d with SMTP id
 2adb3069b0e04-52ccb8d6426mr5442380e87.5.1718896957381; 
 Thu, 20 Jun 2024 08:22:37 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f756ee325sm552818766b.90.2024.06.20.08.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 08:22:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0C60D5FA0A;
 Thu, 20 Jun 2024 16:22:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jamie Iles <quic_jiles@quicinc.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-arm@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marco Liebel <mliebel@qti.qualcomm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Nicholas Piggin <npiggin@gmail.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 10/12] contrib/plugins: add Instructions Per Second (IPS)
 example for cost modeling
Date: Thu, 20 Jun 2024 16:22:18 +0100
Message-Id: <20240620152220.2192768-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240620152220.2192768-1-alex.bennee@linaro.org>
References: <20240620152220.2192768-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x133.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

This plugin uses the new time control interface to make decisions
about the state of time during the emulation. The algorithm is
currently very simple. The user specifies an ips rate which applies
per core. If the core runs ahead of its allocated execution time the
plugin sleeps for a bit to let real time catch up. Either way time is
updated for the emulation as a function of total executed instructions
with some adjustments for cores that idle.

Examples
--------

Slow down execution of /bin/true:
$ num_insn=$(./build/qemu-x86_64 -plugin ./build/tests/plugin/libinsn.so -d plugin /bin/true |& grep total | sed -e 's/.*: //')
$ time ./build/qemu-x86_64 -plugin ./build/contrib/plugins/libips.so,ips=$(($num_insn/4)) /bin/true
real 4.000s

Boot a Linux kernel simulating a 250MHz cpu:
$ /build/qemu-system-x86_64 -kernel /boot/vmlinuz-6.1.0-21-amd64 -append "console=ttyS0" -plugin ./build/contrib/plugins/libips.so,ips=$((250*1000*1000)) -smp 1 -m 512
check time until kernel panic on serial0

Tested in system mode by booting a full debian system, and using:
$ sysbench cpu run
Performance decrease linearly with the given number of ips.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240530220610.1245424-7-pierrick.bouvier@linaro.org>

---
v2
  - more explicit Instructions Per Second (IPS)!
---
 contrib/plugins/ips.c    | 164 +++++++++++++++++++++++++++++++++++++++
 contrib/plugins/Makefile |   1 +
 2 files changed, 165 insertions(+)
 create mode 100644 contrib/plugins/ips.c

diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
new file mode 100644
index 0000000000..29fa556d0f
--- /dev/null
+++ b/contrib/plugins/ips.c
@@ -0,0 +1,164 @@
+/*
+ * Instructions Per Second (IPS) rate limiting plugin.
+ *
+ * This plugin can be used to restrict the execution of a system to a
+ * particular number of Instructions Per Second (IPS). This controls
+ * time as seen by the guest so while wall-clock time may be longer
+ * from the guests point of view time will pass at the normal rate.
+ *
+ * This uses the new plugin API which allows the plugin to control
+ * system time.
+ *
+ * Copyright (c) 2023 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdio.h>
+#include <glib.h>
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+/* how many times do we update time per sec */
+#define NUM_TIME_UPDATE_PER_SEC 10
+#define NSEC_IN_ONE_SEC (1000 * 1000 * 1000)
+
+static GMutex global_state_lock;
+
+static uint64_t max_insn_per_second = 1000 * 1000 * 1000; /* ips per core, per second */
+static uint64_t max_insn_per_quantum; /* trap every N instructions */
+static int64_t virtual_time_ns; /* last set virtual time */
+
+static const void *time_handle;
+
+typedef struct {
+    uint64_t total_insn;
+    uint64_t quantum_insn; /* insn in last quantum */
+    int64_t last_quantum_time; /* time when last quantum started */
+} vCPUTime;
+
+struct qemu_plugin_scoreboard *vcpus;
+
+/* return epoch time in ns */
+static int64_t now_ns(void)
+{
+    return g_get_real_time() * 1000;
+}
+
+static uint64_t num_insn_during(int64_t elapsed_ns)
+{
+    double num_secs = elapsed_ns / (double) NSEC_IN_ONE_SEC;
+    return num_secs * (double) max_insn_per_second;
+}
+
+static int64_t time_for_insn(uint64_t num_insn)
+{
+    double num_secs = (double) num_insn / (double) max_insn_per_second;
+    return num_secs * (double) NSEC_IN_ONE_SEC;
+}
+
+static void update_system_time(vCPUTime *vcpu)
+{
+    int64_t elapsed_ns = now_ns() - vcpu->last_quantum_time;
+    uint64_t max_insn = num_insn_during(elapsed_ns);
+
+    if (vcpu->quantum_insn >= max_insn) {
+        /* this vcpu ran faster than expected, so it has to sleep */
+        uint64_t insn_advance = vcpu->quantum_insn - max_insn;
+        uint64_t time_advance_ns = time_for_insn(insn_advance);
+        int64_t sleep_us = time_advance_ns / 1000;
+        g_usleep(sleep_us);
+    }
+
+    vcpu->total_insn += vcpu->quantum_insn;
+    vcpu->quantum_insn = 0;
+    vcpu->last_quantum_time = now_ns();
+
+    /* based on total number of instructions, what should be the new time? */
+    int64_t new_virtual_time = time_for_insn(vcpu->total_insn);
+
+    g_mutex_lock(&global_state_lock);
+
+    /* Time only moves forward. Another vcpu might have updated it already. */
+    if (new_virtual_time > virtual_time_ns) {
+        qemu_plugin_update_ns(time_handle, new_virtual_time);
+        virtual_time_ns = new_virtual_time;
+    }
+
+    g_mutex_unlock(&global_state_lock);
+}
+
+static void vcpu_init(qemu_plugin_id_t id, unsigned int cpu_index)
+{
+    vCPUTime *vcpu = qemu_plugin_scoreboard_find(vcpus, cpu_index);
+    vcpu->total_insn = 0;
+    vcpu->quantum_insn = 0;
+    vcpu->last_quantum_time = now_ns();
+}
+
+static void vcpu_exit(qemu_plugin_id_t id, unsigned int cpu_index)
+{
+    vCPUTime *vcpu = qemu_plugin_scoreboard_find(vcpus, cpu_index);
+    update_system_time(vcpu);
+}
+
+static void every_quantum_insn(unsigned int cpu_index, void *udata)
+{
+    vCPUTime *vcpu = qemu_plugin_scoreboard_find(vcpus, cpu_index);
+    g_assert(vcpu->quantum_insn >= max_insn_per_quantum);
+    update_system_time(vcpu);
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    size_t n_insns = qemu_plugin_tb_n_insns(tb);
+    qemu_plugin_u64 quantum_insn =
+        qemu_plugin_scoreboard_u64_in_struct(vcpus, vCPUTime, quantum_insn);
+    /* count (and eventually trap) once per tb */
+    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+        tb, QEMU_PLUGIN_INLINE_ADD_U64, quantum_insn, n_insns);
+    qemu_plugin_register_vcpu_tb_exec_cond_cb(
+        tb, every_quantum_insn,
+        QEMU_PLUGIN_CB_NO_REGS, QEMU_PLUGIN_COND_GE,
+        quantum_insn, max_insn_per_quantum, NULL);
+}
+
+static void plugin_exit(qemu_plugin_id_t id, void *udata)
+{
+    qemu_plugin_scoreboard_free(vcpus);
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info, int argc,
+                                           char **argv)
+{
+    for (int i = 0; i < argc; i++) {
+        char *opt = argv[i];
+        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
+        if (g_strcmp0(tokens[0], "ips") == 0) {
+            max_insn_per_second = g_ascii_strtoull(tokens[1], NULL, 10);
+            if (!max_insn_per_second && errno) {
+                fprintf(stderr, "%s: couldn't parse %s (%s)\n",
+                        __func__, tokens[1], g_strerror(errno));
+                return -1;
+            }
+        } else {
+            fprintf(stderr, "option parsing failed: %s\n", opt);
+            return -1;
+        }
+    }
+
+    vcpus = qemu_plugin_scoreboard_new(sizeof(vCPUTime));
+    max_insn_per_quantum = max_insn_per_second / NUM_TIME_UPDATE_PER_SEC;
+
+    time_handle = qemu_plugin_request_time_control();
+    g_assert(time_handle);
+
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
+    qemu_plugin_register_vcpu_exit_cb(id, vcpu_exit);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+
+    return 0;
+}
diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index 0b64d2c1e3..449ead1130 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -27,6 +27,7 @@ endif
 NAMES += hwprofile
 NAMES += cache
 NAMES += drcov
+NAMES += ips
 
 ifeq ($(CONFIG_WIN32),y)
 SO_SUFFIX := .dll
-- 
2.39.2


