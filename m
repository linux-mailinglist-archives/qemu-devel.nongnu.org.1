Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B56C08D1241
	for <lists+qemu-devel@lfdr.de>; Tue, 28 May 2024 04:46:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBmp0-0002BE-SG; Mon, 27 May 2024 22:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmoy-00023g-NW
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:44:17 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmow-0003im-Mz
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:44:16 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1f47f07acd3so3097585ad.0
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 19:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716864252; x=1717469052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BYkKX6SyHTy9ybNO6w9asZ98c6YU/EoDeMWCewzI1/4=;
 b=gT5vo1UZ2rPbCpph7NZKxKzaUzrRzIDU9twxPs2JsJlr6BukRag/q7MLy/I/up1PcX
 89Y0P0GdA3x3b3LftE85yysVdCRXlsuQ5F3K+XsdGuezA0lQJ9FjZdmcIUM59FwOS1vw
 QNaBZaCIDcFUBnu6t7GRXtOnWSsMAa282E78jNh5rTOMIN+EZ1opjHen/8bsZPirJatv
 YLhHKwQt+IyNRq45ZKyET6mc4Q2zsIS6WhBT7ergdUmxbmEgb9kbF1jKmyX/6A6egnA4
 hlArhE6xC6a70ZsfHdC5MbPGgi4ydEyebRg9Q/c2kkXU6p/deM+vbG5admpeW6IkiRNt
 cWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716864252; x=1717469052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BYkKX6SyHTy9ybNO6w9asZ98c6YU/EoDeMWCewzI1/4=;
 b=Dz1NqnfefacSycwobHfw0WNmlhl+yEP3PLMcfpudETk2KDFzkvXGnLaXAJQhVBAYX+
 awSn5A6njyG56CZ6Tug8ug9GINULUk+CfXBtAyJfV/mo5H1QzzS+jT7HLDzX9pZZ8JmD
 NcTrPRS76YBefw4aEtSLshER++HprBNRITCe4jPx7vdLB2DVTkGoZUrrIxZ+SCQY5Wmy
 R05cooGeUwdGuaAQ3JAMx3lJJOAs7gSaF2zY32KEy0X894tTK51nbTMUWX0LLYTfSM6X
 2vYc4YU2xxIzg5+0yLGd1A1eSsxi5fKXuTKJTY9t3I162J1wJ4JSFMbHqD3RKkPp4N5I
 mFLg==
X-Gm-Message-State: AOJu0Yz02XvM/MJ+QJ7lBu5zJtup2KNSDsomWd8TwsXgzxtxqR0LK+q8
 epX7PjKMxLS4j1OAMm/aKFJc65ZuYop7zORRRv0sgqWHt2iraY5Y9j+2zQ==
X-Google-Smtp-Source: AGHT+IFBM8C4IoKQ1CwQ0ShAh58PNUrksvc42duqndOs7Xqp9IvicB1cwITkMgsWTKByWO/WcLC+pA==
X-Received: by 2002:a17:902:e5ca:b0:1f4:8e4a:b781 with SMTP id
 d9443c01a7336-1f48e4aba48mr59157565ad.18.1716864252078; 
 Mon, 27 May 2024 19:44:12 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c970ca0sm70733225ad.142.2024.05.27.19.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 19:44:11 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 04/28] target/riscv/kvm: implement SBI debug console (DBCN)
 calls
Date: Tue, 28 May 2024 12:43:04 +1000
Message-ID: <20240528024328.246965-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528024328.246965-1-alistair.francis@wdc.com>
References: <20240528024328.246965-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

SBI defines a Debug Console extension "DBCN" that will, in time, replace
the legacy console putchar and getchar SBI extensions.

The appeal of the DBCN extension is that it allows multiple bytes to be
read/written in the SBI console in a single SBI call.

As far as KVM goes, the DBCN calls are forwarded by an in-kernel KVM
module to userspace. But this will only happens if the KVM module
actually supports this SBI extension and we activate it.

We'll check for DBCN support during init time, checking if get-reg-list
is advertising KVM_RISCV_SBI_EXT_DBCN. In that case, we'll enable it via
kvm_set_one_reg() during kvm_arch_init_vcpu().

Finally, change kvm_riscv_handle_sbi() to handle the incoming calls for
SBI_EXT_DBCN, reading and writing as required.

A simple KVM guest with 'earlycon=sbi', running in an emulated RISC-V
host, takes around 20 seconds to boot without using DBCN. With this
patch we're taking around 14 seconds to boot due to the speed-up in the
terminal output.  There's no change in boot time if the guest isn't
using earlycon.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20240425155012.581366-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/sbi_ecall_interface.h |  17 +++++
 target/riscv/kvm/kvm-cpu.c         | 111 +++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)

diff --git a/target/riscv/sbi_ecall_interface.h b/target/riscv/sbi_ecall_interface.h
index 43899d08f6..7dfe5f72c6 100644
--- a/target/riscv/sbi_ecall_interface.h
+++ b/target/riscv/sbi_ecall_interface.h
@@ -12,6 +12,17 @@
 
 /* clang-format off */
 
+#define SBI_SUCCESS                      0
+#define SBI_ERR_FAILED                  -1
+#define SBI_ERR_NOT_SUPPORTED           -2
+#define SBI_ERR_INVALID_PARAM           -3
+#define SBI_ERR_DENIED                  -4
+#define SBI_ERR_INVALID_ADDRESS         -5
+#define SBI_ERR_ALREADY_AVAILABLE       -6
+#define SBI_ERR_ALREADY_STARTED         -7
+#define SBI_ERR_ALREADY_STOPPED         -8
+#define SBI_ERR_NO_SHMEM                -9
+
 /* SBI Extension IDs */
 #define SBI_EXT_0_1_SET_TIMER           0x0
 #define SBI_EXT_0_1_CONSOLE_PUTCHAR     0x1
@@ -27,6 +38,7 @@
 #define SBI_EXT_IPI                     0x735049
 #define SBI_EXT_RFENCE                  0x52464E43
 #define SBI_EXT_HSM                     0x48534D
+#define SBI_EXT_DBCN                    0x4442434E
 
 /* SBI function IDs for BASE extension */
 #define SBI_EXT_BASE_GET_SPEC_VERSION   0x0
@@ -57,6 +69,11 @@
 #define SBI_EXT_HSM_HART_STOP           0x1
 #define SBI_EXT_HSM_HART_GET_STATUS     0x2
 
+/* SBI function IDs for DBCN extension */
+#define SBI_EXT_DBCN_CONSOLE_WRITE      0x0
+#define SBI_EXT_DBCN_CONSOLE_READ       0x1
+#define SBI_EXT_DBCN_CONSOLE_WRITE_BYTE 0x2
+
 #define SBI_HSM_HART_STATUS_STARTED     0x0
 #define SBI_HSM_HART_STATUS_STOPPED     0x1
 #define SBI_HSM_HART_STATUS_START_PENDING   0x2
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index b8136c7ef8..d2491d84e2 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -409,6 +409,12 @@ static KVMCPUConfig kvm_v_vlenb = {
                    KVM_REG_RISCV_VECTOR_CSR_REG(vlenb)
 };
 
+static KVMCPUConfig kvm_sbi_dbcn = {
+    .name = "sbi_dbcn",
+    .kvm_reg_id = KVM_REG_RISCV | KVM_REG_SIZE_U64 |
+                  KVM_REG_RISCV_SBI_EXT | KVM_RISCV_SBI_EXT_DBCN
+};
+
 static void kvm_riscv_update_cpu_cfg_isa_ext(RISCVCPU *cpu, CPUState *cs)
 {
     CPURISCVState *env = &cpu->env;
@@ -1037,6 +1043,20 @@ static int uint64_cmp(const void *a, const void *b)
     return 0;
 }
 
+static void kvm_riscv_check_sbi_dbcn_support(RISCVCPU *cpu,
+                                             KVMScratchCPU *kvmcpu,
+                                             struct kvm_reg_list *reglist)
+{
+    struct kvm_reg_list *reg_search;
+
+    reg_search = bsearch(&kvm_sbi_dbcn.kvm_reg_id, reglist->reg, reglist->n,
+                         sizeof(uint64_t), uint64_cmp);
+
+    if (reg_search) {
+        kvm_sbi_dbcn.supported = true;
+    }
+}
+
 static void kvm_riscv_read_vlenb(RISCVCPU *cpu, KVMScratchCPU *kvmcpu,
                                  struct kvm_reg_list *reglist)
 {
@@ -1142,6 +1162,8 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
     if (riscv_has_ext(&cpu->env, RVV)) {
         kvm_riscv_read_vlenb(cpu, kvmcpu, reglist);
     }
+
+    kvm_riscv_check_sbi_dbcn_support(cpu, kvmcpu, reglist);
 }
 
 static void riscv_init_kvm_registers(Object *cpu_obj)
@@ -1316,6 +1338,17 @@ static int kvm_vcpu_set_machine_ids(RISCVCPU *cpu, CPUState *cs)
     return ret;
 }
 
+static int kvm_vcpu_enable_sbi_dbcn(RISCVCPU *cpu, CPUState *cs)
+{
+    target_ulong reg = 1;
+
+    if (!kvm_sbi_dbcn.supported) {
+        return 0;
+    }
+
+    return kvm_set_one_reg(cs, kvm_sbi_dbcn.kvm_reg_id, &reg);
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     int ret = 0;
@@ -1333,6 +1366,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
     kvm_riscv_update_cpu_misa_ext(cpu, cs);
     kvm_riscv_update_cpu_cfg_isa_ext(cpu, cs);
 
+    ret = kvm_vcpu_enable_sbi_dbcn(cpu, cs);
+
     return ret;
 }
 
@@ -1390,6 +1425,79 @@ bool kvm_arch_stop_on_emulation_error(CPUState *cs)
     return true;
 }
 
+static void kvm_riscv_handle_sbi_dbcn(CPUState *cs, struct kvm_run *run)
+{
+    g_autofree uint8_t *buf = NULL;
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    target_ulong num_bytes;
+    uint64_t addr;
+    unsigned char ch;
+    int ret;
+
+    switch (run->riscv_sbi.function_id) {
+    case SBI_EXT_DBCN_CONSOLE_READ:
+    case SBI_EXT_DBCN_CONSOLE_WRITE:
+        num_bytes = run->riscv_sbi.args[0];
+
+        if (num_bytes == 0) {
+            run->riscv_sbi.ret[0] = SBI_SUCCESS;
+            run->riscv_sbi.ret[1] = 0;
+            break;
+        }
+
+        addr = run->riscv_sbi.args[1];
+
+        /*
+         * Handle the case where a 32 bit CPU is running in a
+         * 64 bit addressing env.
+         */
+        if (riscv_cpu_mxl(&cpu->env) == MXL_RV32) {
+            addr |= (uint64_t)run->riscv_sbi.args[2] << 32;
+        }
+
+        buf = g_malloc0(num_bytes);
+
+        if (run->riscv_sbi.function_id == SBI_EXT_DBCN_CONSOLE_READ) {
+            ret = qemu_chr_fe_read_all(serial_hd(0)->be, buf, num_bytes);
+            if (ret < 0) {
+                error_report("SBI_EXT_DBCN_CONSOLE_READ: error when "
+                             "reading chardev");
+                exit(1);
+            }
+
+            cpu_physical_memory_write(addr, buf, ret);
+        } else {
+            cpu_physical_memory_read(addr, buf, num_bytes);
+
+            ret = qemu_chr_fe_write_all(serial_hd(0)->be, buf, num_bytes);
+            if (ret < 0) {
+                error_report("SBI_EXT_DBCN_CONSOLE_WRITE: error when "
+                             "writing chardev");
+                exit(1);
+            }
+        }
+
+        run->riscv_sbi.ret[0] = SBI_SUCCESS;
+        run->riscv_sbi.ret[1] = ret;
+        break;
+    case SBI_EXT_DBCN_CONSOLE_WRITE_BYTE:
+        ch = run->riscv_sbi.args[0];
+        ret = qemu_chr_fe_write(serial_hd(0)->be, &ch, sizeof(ch));
+
+        if (ret < 0) {
+            error_report("SBI_EXT_DBCN_CONSOLE_WRITE_BYTE: error when "
+                         "writing chardev");
+            exit(1);
+        }
+
+        run->riscv_sbi.ret[0] = SBI_SUCCESS;
+        run->riscv_sbi.ret[1] = 0;
+        break;
+    default:
+        run->riscv_sbi.ret[0] = SBI_ERR_NOT_SUPPORTED;
+    }
+}
+
 static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
 {
     int ret = 0;
@@ -1408,6 +1516,9 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
         }
         ret = 0;
         break;
+    case SBI_EXT_DBCN:
+        kvm_riscv_handle_sbi_dbcn(cs, run);
+        break;
     default:
         qemu_log_mask(LOG_UNIMP,
                       "%s: un-handled SBI EXIT, specific reasons is %lu\n",
-- 
2.45.1


