Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4935BAEC179
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Jun 2025 22:51:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVG1K-0005MU-Bk; Fri, 27 Jun 2025 16:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yodel.eldar@gmail.com>)
 id 1uVG1I-0005LB-Ey
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 16:50:00 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yodel.eldar@gmail.com>)
 id 1uVG1F-0005H6-40
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 16:50:00 -0400
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-74801bc6dc5so2873727b3a.1
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 13:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751057396; x=1751662196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IRA6rRpCVkVHC2ngaHExUsJHfJMtW4xYFGdZQheK8+M=;
 b=DGnWSp23M7xplASN1Cw1NnSf8TSMYvtNlpXhIU+/C1J/kSRYAlAhx74NyYWT7QcYmv
 wBUHchODgaIG7/QbgMPGTAUOI0fkAJ2McDiYUaXzU+XVALAarrZv98AVUBFFuNaeFcJy
 2ImuNnHQ4DRXYXMsoqrTOnIGWytM1nDWHA3EHirJlCiX9OSYF8KEAdyWweWuFGJ3jWNR
 H9Vx+eaXbmIed49mXpcAgWQdZUUSgaZaOEtjE6TySCW8TzwgZH+SczngirrQ/+6ixuD/
 4HKrHcQC41pya0/Kk7Jlhah8DoRYPFfLX8V16JAenUtHzUGBDIFOzBnhy4rFRoeKuDRL
 oSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751057396; x=1751662196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IRA6rRpCVkVHC2ngaHExUsJHfJMtW4xYFGdZQheK8+M=;
 b=GgXxS7JqqRp63CW2NHmtEir+L8/GnXU2p+Gtoeog3TTa+hWE8YLGNL91HA9728Jzti
 XoQyKUEZ1GpWAi8+MOvC+wxXD41ZgNosE3mPJ8+ybu6kf9TnLa6ieb55WZYPCUU20SHV
 FR7WQgpDOeNTlRCQ+zid42qf5A+/jEnsXiDzFCGQx1BpALcMj1VbQI10tJKEWtAJd+0p
 2lnuZAKF1NB6Cflc2MDxjvrB0UGSZKPZ2u92FAp2Jp/ECdugQUAik8AevglPCQU0Tojb
 FviTEdoYruoePrGP0jzyt6v1EVh5vgINBsy3xFYL13Cj4M0s9F1AQf0OR9HDdDavbLqf
 XV+Q==
X-Gm-Message-State: AOJu0Yz1O8fJofWLjnViVmzC1LVyYKqJ/cfi41QEic5hxojwCjE39xpe
 kI06dyNNsGTE+lu6fr41GPZ1G3ae3oY3PMvbmq5Pmd51IwKMO75xeQ27ThoVhsqc
X-Gm-Gg: ASbGncsJQrEbBkrQRRKEgwnBGmW1Cu7UENLsv/+B7Bn6+L7fkyuoWRzD1yRSGv0wIr3
 oBPrCtZ6JoMWg1TqGniiSpRYF29u+zfRevXa+BHhtUh5foQD0EUJjg9HOR5w47OxOCTRpEINetz
 yQ+5lQeXkXrqvhs9KtFvOjK4Lfm7NBpfH7sXeD+AukkdcEuRlOPyHkIcfShpuHRJqXLGuY6+LXF
 yjan54FoL3bDelNt+aD+WmKEELT7UurgwD1jj7xC/qfVzUaixEKx0qc0qTq2PiWJqxiIWRlf5NW
 gn/mboRpV661vGG68gOGWIUlP4sm8wFdAr/6QdxA0w3xxMJsTdf3kG0L+Q==
X-Google-Smtp-Source: AGHT+IHVYeFX+Wqx0Kpi6bQkUKCMLPXJh3wcgy2XKm2oYqSjVd/Ct4BZIOT0DToOYojrTHZg/8hILg==
X-Received: by 2002:a05:6a00:10d5:b0:746:25d1:b712 with SMTP id
 d2e1a72fcca58-74af7ace890mr6132145b3a.7.1751057395618; 
 Fri, 27 Jun 2025 13:49:55 -0700 (PDT)
Received: from darlin ([89.187.185.165]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af557b3bcsm2977538b3a.101.2025.06.27.13.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 13:49:55 -0700 (PDT)
From: Yodel Eldar <yodel.eldar@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org, laurent@vivier.eu,
 Yodel Eldar <yodel.eldar@gmail.com>
Subject: [PATCH 2/2] target/alpha: Add GDB XML feature file
Date: Fri, 27 Jun 2025 15:47:59 -0500
Message-ID: <20250627204817.47595-3-yodel.eldar@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627204817.47595-1-yodel.eldar@gmail.com>
References: <20250627204817.47595-1-yodel.eldar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=yodel.eldar@gmail.com; helo=mail-pf1-x442.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This patch adds the GDB XML feature file that describes Alpha's core
registers.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2569

Signed-off-by: Yodel Eldar <yodel.eldar@gmail.com>
---
 configs/targets/alpha-linux-user.mak |   1 +
 configs/targets/alpha-softmmu.mak    |   1 +
 gdb-xml/alpha-core.xml               | 136 +++++++++++++++++++++++++++
 target/alpha/cpu.c                   |   1 +
 4 files changed, 139 insertions(+)
 create mode 100644 gdb-xml/alpha-core.xml

diff --git a/configs/targets/alpha-linux-user.mak b/configs/targets/alpha-linux-user.mak
index ef8e365b09..aa25766236 100644
--- a/configs/targets/alpha-linux-user.mak
+++ b/configs/targets/alpha-linux-user.mak
@@ -2,3 +2,4 @@ TARGET_ARCH=alpha
 TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_LONG_BITS=64
+TARGET_XML_FILES= gdb-xml/alpha-core.xml
diff --git a/configs/targets/alpha-softmmu.mak b/configs/targets/alpha-softmmu.mak
index 5275076e50..e31f059a52 100644
--- a/configs/targets/alpha-softmmu.mak
+++ b/configs/targets/alpha-softmmu.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=alpha
 TARGET_LONG_BITS=64
+TARGET_XML_FILES= gdb-xml/alpha-core.xml
diff --git a/gdb-xml/alpha-core.xml b/gdb-xml/alpha-core.xml
new file mode 100644
index 0000000000..c9e12f4ffd
--- /dev/null
+++ b/gdb-xml/alpha-core.xml
@@ -0,0 +1,136 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2025 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.alpha.core">
+  <!-- IEEE rounding mode values -->
+  <enum id="dyn_rm_enum" size="8">
+    <!-- Chopped rounding mode -->
+    <evalue name="chop" value="0"/>
+    <!-- Minus infinity -->
+    <evalue name="-inf" value="1"/>
+    <!-- Normal rounding -->
+    <evalue name="norm" value="2"/>
+    <!-- Plus infinity -->
+    <evalue name="+inf" value="3"/>
+  </enum>
+
+  <!-- Floating-Point Control Register Flags -->
+  <flags id="fpcr_flags" size="8">
+    <!-- Denormal Operand Exception Disable -->
+    <field name="DNOD"   start="47" end="47"/>
+    <!-- Denormal Operands to Zero -->
+    <field name="DNZ"    start="48" end="48"/>
+    <!-- Invalid Operation Disable -->
+    <field name="INVD"   start="49" end="49"/>
+    <!-- Division by Zero Disable -->
+    <field name="DZED"   start="50" end="50"/>
+    <!-- Overflow Disable -->
+    <field name="OVFD"   start="51" end="51"/>
+    <!-- Invalid Operation -->
+    <field name="INV"    start="52" end="52"/>
+    <!-- Division by Zero -->
+    <field name="DZE"    start="53" end="53"/>
+    <!-- Overflow -->
+    <field name="OVF"    start="54" end="54"/>
+    <!-- Underflow -->
+    <field name="UNF"    start="55" end="55"/>
+    <!-- Inexact Result -->
+    <field name="INE"    start="56" end="56"/>
+    <!-- Integer Overflow -->
+    <field name="IOV"    start="57" end="57"/>
+    <!-- Dynamic Rounding Mode -->
+    <field name="DYN_RM" start="58" end="59" type="dyn_rm_enum"/>
+    <!-- Underflow to Zero -->
+    <field name="UNDZ"   start="60" end="60"/>
+    <!-- Underflow Disable -->
+    <field name="UNFD"   start="61" end="61"/>
+    <!-- Inexact Disable -->
+    <field name="INED"   start="62" end="62"/>
+    <!-- Summary Bit -->
+    <field name="SUM"    start="63" end="63"/>
+  </flags>
+
+  <!-- Integer Registers -->
+  <reg name="v0"   bitsize="64" type="int64"/>
+  <reg name="t0"   bitsize="64" type="int64"/>
+  <reg name="t1"   bitsize="64" type="int64"/>
+  <reg name="t2"   bitsize="64" type="int64"/>
+  <reg name="t3"   bitsize="64" type="int64"/>
+  <reg name="t4"   bitsize="64" type="int64"/>
+  <reg name="t5"   bitsize="64" type="int64"/>
+  <reg name="t6"   bitsize="64" type="int64"/>
+  <reg name="t7"   bitsize="64" type="int64"/>
+  <reg name="s0"   bitsize="64" type="int64"/>
+  <reg name="s1"   bitsize="64" type="int64"/>
+  <reg name="s2"   bitsize="64" type="int64"/>
+  <reg name="s3"   bitsize="64" type="int64"/>
+  <reg name="s4"   bitsize="64" type="int64"/>
+  <reg name="s5"   bitsize="64" type="int64"/>
+  <reg name="fp"   bitsize="64" type="int64"/>
+  <reg name="a0"   bitsize="64" type="int64"/>
+  <reg name="a1"   bitsize="64" type="int64"/>
+  <reg name="a2"   bitsize="64" type="int64"/>
+  <reg name="a3"   bitsize="64" type="int64"/>
+  <reg name="a4"   bitsize="64" type="int64"/>
+  <reg name="a5"   bitsize="64" type="int64"/>
+  <reg name="t8"   bitsize="64" type="int64"/>
+  <reg name="t9"   bitsize="64" type="int64"/>
+  <reg name="t10"  bitsize="64" type="int64"/>
+  <reg name="t11"  bitsize="64" type="int64"/>
+  <reg name="ra"   bitsize="64" type="int64"/>
+  <reg name="t12"  bitsize="64" type="int64"/>
+  <reg name="at"   bitsize="64" type="int64"/>
+  <reg name="gp"   bitsize="64" type="data_ptr"/>
+  <reg name="sp"   bitsize="64" type="data_ptr"/>
+  <reg name="zero" bitsize="64" type="int64" save-restore="no"/>
+
+  <!-- Floating-Point Registers -->
+  <reg name="f0"  bitsize="64" type="float" group="float"/>
+  <reg name="f1"  bitsize="64" type="float" group="float"/>
+  <reg name="f2"  bitsize="64" type="float" group="float"/>
+  <reg name="f3"  bitsize="64" type="float" group="float"/>
+  <reg name="f4"  bitsize="64" type="float" group="float"/>
+  <reg name="f5"  bitsize="64" type="float" group="float"/>
+  <reg name="f6"  bitsize="64" type="float" group="float"/>
+  <reg name="f7"  bitsize="64" type="float" group="float"/>
+  <reg name="f8"  bitsize="64" type="float" group="float"/>
+  <reg name="f9"  bitsize="64" type="float" group="float"/>
+  <reg name="f10" bitsize="64" type="float" group="float"/>
+  <reg name="f11" bitsize="64" type="float" group="float"/>
+  <reg name="f12" bitsize="64" type="float" group="float"/>
+  <reg name="f13" bitsize="64" type="float" group="float"/>
+  <reg name="f14" bitsize="64" type="float" group="float"/>
+  <reg name="f15" bitsize="64" type="float" group="float"/>
+  <reg name="f16" bitsize="64" type="float" group="float"/>
+  <reg name="f17" bitsize="64" type="float" group="float"/>
+  <reg name="f18" bitsize="64" type="float" group="float"/>
+  <reg name="f19" bitsize="64" type="float" group="float"/>
+  <reg name="f20" bitsize="64" type="float" group="float"/>
+  <reg name="f21" bitsize="64" type="float" group="float"/>
+  <reg name="f22" bitsize="64" type="float" group="float"/>
+  <reg name="f23" bitsize="64" type="float" group="float"/>
+  <reg name="f24" bitsize="64" type="float" group="float"/>
+  <reg name="f25" bitsize="64" type="float" group="float"/>
+  <reg name="f26" bitsize="64" type="float" group="float"/>
+  <reg name="f27" bitsize="64" type="float" group="float"/>
+  <reg name="f28" bitsize="64" type="float" group="float"/>
+  <reg name="f29" bitsize="64" type="float" group="float"/>
+  <reg name="f30" bitsize="64" type="float" group="float"/>
+
+  <!-- Floating-Point Control Register -->
+  <reg name="fpcr" bitsize="64" type="fpcr_flags" group="float"/>
+
+  <!-- Program Counter -->
+  <reg name="pc" bitsize="64" type="code_ptr"/>
+
+  <!-- Reserved Index for Former Virtual Register -->
+  <reg name="" bitsize="64" type="int64" save-restore="no"/>
+
+  <!-- PALcode Memory Slot -->
+  <reg name="unique" bitsize="64" type="int64" group="system"/>
+</feature>
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 2082db45ea..bf1787a69d 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -286,6 +286,7 @@ static void alpha_cpu_class_init(ObjectClass *oc, const void *data)
     cc->get_pc = alpha_cpu_get_pc;
     cc->gdb_read_register = alpha_cpu_gdb_read_register;
     cc->gdb_write_register = alpha_cpu_gdb_write_register;
+    cc->gdb_core_xml_file = "alpha-core.xml";
 #ifndef CONFIG_USER_ONLY
     dc->vmsd = &vmstate_alpha_cpu;
     cc->sysemu_ops = &alpha_sysemu_ops;
-- 
2.50.0


