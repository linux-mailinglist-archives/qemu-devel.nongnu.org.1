Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E117B70E4
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 20:32:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnkB0-00087g-Hc; Tue, 03 Oct 2023 14:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAt-000869-QV
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:15 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAr-0001gz-U5
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:15 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-69101022969so969511b3a.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 11:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696357872; x=1696962672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nl5bSvinzi/NL70KSvl04+OPB0c89FFjcDMoM7uppFI=;
 b=cVRaEPyKFETaGwy0DuTVM5w8uJ3gM7ixFypp2IufexG9vM8+TRyvzUrzeIZrgysRR8
 wTwn3ThrGQwJJBui95yIPNF8RY2aMWL2j4JA43osYTTiVXBxovK/LvWvvsh+Xz0zRwaH
 YHXx6O6p0PDzFKtgBMG9IN0dakNzG9J8FR5PTCaJXDHwx5ZYr+FmJx7edd/ir95RMcNg
 Fo2gKy0lu2rFDSlvhJi7nZvGtr/0NRTJNjtPXFu3PVpd9++oR0B+cx2IUna1tx98AFCC
 KNiaViB1vMTgNWh8zXoDdDFCqduq1jDerLXQmuShFNPsvIV3Eqai5vUAKnmsHCaWlALU
 ZRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696357872; x=1696962672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nl5bSvinzi/NL70KSvl04+OPB0c89FFjcDMoM7uppFI=;
 b=UwEZ716qeqdrJvAeo8MQ/G7I+K7xLnOSbnVSJwpOiVNK0suBue/AtSXcAith6jVxjG
 2zh0QuvrP3jRGmpReW4iiKrZp9fiLMqkUH7OvsMo3+bFKoyM+slkJQpTNld7h/sTmQYO
 5ncKPITIsSZajSo7erXYEx5XAiHtiOW+28z2JCyXOqtyTZ0fALQovwEsUK6+9O2jmWER
 n4BL/N2LmYrAp4x9RKWSKG1xmiCEy9e5fN/jLplEWMxzCr92fKvS0NoAnFx5lh4yGcuh
 pCzsemNCU0cauGIE56JU8IpSMxNPDrVEJMq7pC6MWcUjpaYmq6BWPsoL985EULVmEiO9
 7l6A==
X-Gm-Message-State: AOJu0Yxyc5l33ELeFo2CZDVs73kp/pXwfFbwOS7iDN5e4bXhjmSEQYvO
 rLxJOXqBrSj61BUFn16rHEBoVTcWCYpA2DtSIBg=
X-Google-Smtp-Source: AGHT+IGbp2asf3fUD2DO9MzAGzg/CErlqY5pDehfC2y3eI1IsFduUFDLcztIbtYkSGShEnec01G/gA==
X-Received: by 2002:a05:6a21:328a:b0:14d:7b6:cf2f with SMTP id
 yt10-20020a056a21328a00b0014d07b6cf2fmr263862pzb.47.1696357872372; 
 Tue, 03 Oct 2023 11:31:12 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g7-20020a170902934700b001b7cbc5871csm1920432plp.53.2023.10.03.11.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 11:31:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: fei2.wu@intel.com, "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v17 13/16] disas: Allow monitor_disas to read from ram_addr_t
Date: Tue,  3 Oct 2023 11:30:55 -0700
Message-Id: <20231003183058.1639121-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003183058.1639121-1-richard.henderson@linaro.org>
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_OTHER_BAD_TLD=1.998, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>

Introduce a MonitorDisasSpace to replace the current is_physical
boolean argument to monitor_disas.  Generate an error if we attempt
to read past the end of a single RAMBlock.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Fei Wu <fei2.wu@intel.com>
[rth: Split out of a larger patch; validate the RAMBlock size]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/disas/disas.h     |  8 +++++++-
 disas/disas-mon.c         | 32 ++++++++++++++++++++++++++++++--
 monitor/hmp-cmds-target.c | 27 ++++++++++++++++-----------
 3 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/include/disas/disas.h b/include/disas/disas.h
index 176775eff7..cd99b0ccd0 100644
--- a/include/disas/disas.h
+++ b/include/disas/disas.h
@@ -5,8 +5,14 @@
 void disas(FILE *out, const void *code, size_t size);
 void target_disas(FILE *out, CPUState *cpu, uint64_t code, size_t size);
 
+typedef enum {
+    MON_DISAS_GVA, /* virtual */
+    MON_DISAS_GPA, /* physical */
+    MON_DISAS_GRA, /* ram_addr_t */
+} MonitorDisasSpace;
+
 void monitor_disas(Monitor *mon, CPUState *cpu, uint64_t pc,
-                   int nb_insn, bool is_physical);
+                   int nb_insn, MonitorDisasSpace space);
 
 char *plugin_disas(CPUState *cpu, uint64_t addr, size_t size);
 
diff --git a/disas/disas-mon.c b/disas/disas-mon.c
index 48ac492c6c..d486f64c92 100644
--- a/disas/disas-mon.c
+++ b/disas/disas-mon.c
@@ -23,9 +23,27 @@ physical_read_memory(bfd_vma memaddr, bfd_byte *myaddr, int length,
     return res == MEMTX_OK ? 0 : EIO;
 }
 
+static int
+ram_addr_read_memory(bfd_vma memaddr, bfd_byte *myaddr, int length,
+                     struct disassemble_info *info)
+{
+    hwaddr hw_length;
+    void *p;
+
+    RCU_READ_LOCK_GUARD();
+
+    hw_length = length;
+    p = qemu_ram_ptr_length(NULL, memaddr, &hw_length, false);
+    if (hw_length < length) {
+        return EIO;
+    }
+    memcpy(myaddr, p, length);
+    return 0;
+}
+
 /* Disassembler for the monitor.  */
 void monitor_disas(Monitor *mon, CPUState *cpu, uint64_t pc,
-                   int nb_insn, bool is_physical)
+                   int nb_insn, MonitorDisasSpace space)
 {
     int count, i;
     CPUDebug s;
@@ -35,8 +53,18 @@ void monitor_disas(Monitor *mon, CPUState *cpu, uint64_t pc,
     s.info.fprintf_func = disas_gstring_printf;
     s.info.stream = (FILE *)ds;  /* abuse this slot */
 
-    if (is_physical) {
+    switch (space) {
+    case MON_DISAS_GVA:
+        /* target_read_memory set in disas_initialize_debug_target */
+        break;
+    case MON_DISAS_GPA:
         s.info.read_memory_func = physical_read_memory;
+        break;
+    case MON_DISAS_GRA:
+        s.info.read_memory_func = ram_addr_read_memory;
+        break;
+    default:
+        g_assert_not_reached();
     }
     s.info.buffer_vma = pc;
 
diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index d9fbcac08d..476cf68e81 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -120,21 +120,20 @@ void hmp_info_registers(Monitor *mon, const QDict *qdict)
 }
 
 static void memory_dump(Monitor *mon, int count, int format, int wsize,
-                        hwaddr addr, int is_physical)
+                        hwaddr addr, MonitorDisasSpace space)
 {
     int l, line_size, i, max_digits, len;
     uint8_t buf[16];
     uint64_t v;
     CPUState *cs = mon_get_cpu(mon);
 
-    if (!cs && (format == 'i' || !is_physical)) {
+    if (space == MON_DISAS_GVA || format == 'i') {
         monitor_printf(mon, "Can not dump without CPU\n");
         return;
     }
 
     if (format == 'i') {
-        monitor_disas(mon, cs, addr, count, is_physical);
-        return;
+        monitor_disas(mon, cs, addr, count, space);
     }
 
     len = wsize * count;
@@ -163,15 +162,21 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
     }
 
     while (len > 0) {
-        if (is_physical) {
-            monitor_printf(mon, HWADDR_FMT_plx ":", addr);
-        } else {
+        switch (space) {
+        case MON_DISAS_GVA:
             monitor_printf(mon, TARGET_FMT_lx ":", (target_ulong)addr);
+            break;
+        case MON_DISAS_GPA:
+            monitor_printf(mon, HWADDR_FMT_plx ":", addr);
+            break;
+        default:
+            g_assert_not_reached();
         }
         l = len;
-        if (l > line_size)
+        if (l > line_size) {
             l = line_size;
-        if (is_physical) {
+        }
+        if (space == MON_DISAS_GPA) {
             AddressSpace *as = cs ? cs->as : &address_space_memory;
             MemTxResult r = address_space_read(as, addr,
                                                MEMTXATTRS_UNSPECIFIED, buf, l);
@@ -235,7 +240,7 @@ void hmp_memory_dump(Monitor *mon, const QDict *qdict)
     int size = qdict_get_int(qdict, "size");
     target_long addr = qdict_get_int(qdict, "addr");
 
-    memory_dump(mon, count, format, size, addr, 0);
+    memory_dump(mon, count, format, size, addr, MON_DISAS_GVA);
 }
 
 void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
@@ -245,7 +250,7 @@ void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
     int size = qdict_get_int(qdict, "size");
     hwaddr addr = qdict_get_int(qdict, "addr");
 
-    memory_dump(mon, count, format, size, addr, 1);
+    memory_dump(mon, count, format, size, addr, MON_DISAS_GPA);
 }
 
 void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp)
-- 
2.34.1


