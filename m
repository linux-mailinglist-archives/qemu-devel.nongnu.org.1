Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B897B01E52
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Jul 2025 15:51:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaE9x-0006tD-Mt; Fri, 11 Jul 2025 09:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <unisono@quyllur.org>)
 id 1uaE5B-0005z8-G1
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:46:34 -0400
Received: from quyllur.org ([185.247.226.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <unisono@quyllur.org>)
 id 1uaE59-00015r-2G
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:46:33 -0400
Received: from quyllur.org (localhost [127.0.0.1])
 by quyllur.org (OpenSMTPD) with ESMTP id f0efa498;
 Fri, 11 Jul 2025 16:46:12 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=quyllur.org; h=from:to:cc
 :subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding; s=dkimselector; bh=nje6mZl1xdPP6G2+Z
 opLvxMtWPM=; b=zo+YxXD0wV6a95dEZs3wEsXOvUCJtyaaEolegY5+GC7cmDE/K
 zEFyjyWm1BzKR3plPyWZg3TBDLV//Gm5gss0Yhp35UZyDqqVg2cyCs5qRqvC9VTV
 mWJrBW1est60tbFH9PM2KwzNCowuW34PN4MtWQ1LiW+4lB4TqCe3GFVLJU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=quyllur.org; h=from:to:cc
 :subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding; q=dns; s=dkimselector; b=HJEjyyDiuuL
 0McHUHPxi+PJHudtEMdS7DwTcoQSz2m96GzX6M5qbelYVoSNM3fZgFjfJmJN7zlG
 Qe1wuAHXY7hhOdqNuHePPkMN9tXkniL/laqRwx2Tsejq8DF6JqurB1lMkNMwc4Rs
 59RSfKrzZkoGBX1xuFo0n0LVQS+cqD9k=
Received: from Rizin (<unknown> [194.127.199.111])
 by quyllur.org (OpenSMTPD) with ESMTPSA id 2627d41f
 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO); 
 Fri, 11 Jul 2025 16:46:02 +0300 (EEST)
From: unisono@quyllur.org
To: alex.bennee@linaro.org
Cc: atar4qemu@gmail.com, laurent@vivier.eu, mark.cave-ayland@ilande.co.uk,
 philmd@linaro.org, qemu-devel@nongnu.org, Rot127 <unisono@quyllur.org>
Subject: [PATCH 2/3] Adds the GDB register XML files for Sparc32.
Date: Fri, 11 Jul 2025 08:45:37 -0500
Message-ID: <20250711134538.57520-1-unisono@quyllur.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <87h5zltojx.fsf@draig.linaro.org>
References: <87h5zltojx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.247.226.42; envelope-from=unisono@quyllur.org;
 helo=quyllur.org
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SORTED_RECIPS=2.499, SPF_HELO_PASS=-0.001,
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

From: Rot127 <unisono@quyllur.org>

Commit 2/3

Signed-off-by: Rot127 <unisono@quyllur.org>
---
 configs/targets/sparc-linux-user.mak |  1 +
 configs/targets/sparc-softmmu.mak    |  1 +
 gdb-xml/sparc32-core.xml             | 84 ++++++++++++++++++++++++++++
 target/sparc/cpu.c                   |  1 +
 4 files changed, 87 insertions(+)
 create mode 100644 gdb-xml/sparc32-core.xml

diff --git a/configs/targets/sparc-linux-user.mak b/configs/targets/sparc-linux-user.mak
index 4ff4b7287d..4908ed7282 100644
--- a/configs/targets/sparc-linux-user.mak
+++ b/configs/targets/sparc-linux-user.mak
@@ -2,4 +2,5 @@ TARGET_ARCH=sparc
 TARGET_SYSTBL_ABI=common,32
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
+TARGET_XML_FILES=gdb-xml/sparc32-core.xml
 TARGET_LONG_BITS=32
diff --git a/configs/targets/sparc-softmmu.mak b/configs/targets/sparc-softmmu.mak
index 57801faf1f..140d8462fa 100644
--- a/configs/targets/sparc-softmmu.mak
+++ b/configs/targets/sparc-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=sparc
 TARGET_BIG_ENDIAN=y
+TARGET_XML_FILES=gdb-xml/sparc32-core.xml
 TARGET_LONG_BITS=32
diff --git a/gdb-xml/sparc32-core.xml b/gdb-xml/sparc32-core.xml
new file mode 100644
index 0000000000..61964a79d1
--- /dev/null
+++ b/gdb-xml/sparc32-core.xml
@@ -0,0 +1,84 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2013-2025 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.sparc.core">
+  <reg name="g0" bitsize="32" type="uint32" regnum="0"/>
+  <reg name="g1" bitsize="32" type="uint32" regnum="1"/>
+  <reg name="g2" bitsize="32" type="uint32" regnum="2"/>
+  <reg name="g3" bitsize="32" type="uint32" regnum="3"/>
+  <reg name="g4" bitsize="32" type="uint32" regnum="4"/>
+  <reg name="g5" bitsize="32" type="uint32" regnum="5"/>
+  <reg name="g6" bitsize="32" type="uint32" regnum="6"/>
+  <reg name="g7" bitsize="32" type="uint32" regnum="7"/>
+  <reg name="o0" bitsize="32" type="uint32" regnum="8"/>
+  <reg name="o1" bitsize="32" type="uint32" regnum="9"/>
+  <reg name="o2" bitsize="32" type="uint32" regnum="10"/>
+  <reg name="o3" bitsize="32" type="uint32" regnum="11"/>
+  <reg name="o4" bitsize="32" type="uint32" regnum="12"/>
+  <reg name="o5" bitsize="32" type="uint32" regnum="13"/>
+  <reg name="sp" bitsize="32" type="uint32" regnum="14"/>
+  <reg name="o7" bitsize="32" type="uint32" regnum="15"/>
+  <reg name="l0" bitsize="32" type="uint32" regnum="16"/>
+  <reg name="l1" bitsize="32" type="uint32" regnum="17"/>
+  <reg name="l2" bitsize="32" type="uint32" regnum="18"/>
+  <reg name="l3" bitsize="32" type="uint32" regnum="19"/>
+  <reg name="l4" bitsize="32" type="uint32" regnum="20"/>
+  <reg name="l5" bitsize="32" type="uint32" regnum="21"/>
+  <reg name="l6" bitsize="32" type="uint32" regnum="22"/>
+  <reg name="l7" bitsize="32" type="uint32" regnum="23"/>
+  <reg name="i0" bitsize="32" type="uint32" regnum="24"/>
+  <reg name="i1" bitsize="32" type="uint32" regnum="25"/>
+  <reg name="i2" bitsize="32" type="uint32" regnum="26"/>
+  <reg name="i3" bitsize="32" type="uint32" regnum="27"/>
+  <reg name="i4" bitsize="32" type="uint32" regnum="28"/>
+  <reg name="i5" bitsize="32" type="uint32" regnum="29"/>
+  <reg name="fp" bitsize="32" type="uint32" regnum="30"/>
+  <reg name="i7" bitsize="32" type="uint32" regnum="31"/>
+
+  <reg name="f0" bitsize="32" type="ieee_single" regnum="32"/>
+  <reg name="f1" bitsize="32" type="ieee_single" regnum="33"/>
+  <reg name="f2" bitsize="32" type="ieee_single" regnum="34"/>
+  <reg name="f3" bitsize="32" type="ieee_single" regnum="35"/>
+  <reg name="f4" bitsize="32" type="ieee_single" regnum="36"/>
+  <reg name="f5" bitsize="32" type="ieee_single" regnum="37"/>
+  <reg name="f6" bitsize="32" type="ieee_single" regnum="38"/>
+  <reg name="f7" bitsize="32" type="ieee_single" regnum="39"/>
+  <reg name="f8" bitsize="32" type="ieee_single" regnum="40"/>
+  <reg name="f9" bitsize="32" type="ieee_single" regnum="41"/>
+  <reg name="f10" bitsize="32" type="ieee_single" regnum="42"/>
+  <reg name="f11" bitsize="32" type="ieee_single" regnum="43"/>
+  <reg name="f12" bitsize="32" type="ieee_single" regnum="44"/>
+  <reg name="f13" bitsize="32" type="ieee_single" regnum="45"/>
+  <reg name="f14" bitsize="32" type="ieee_single" regnum="46"/>
+  <reg name="f15" bitsize="32" type="ieee_single" regnum="47"/>
+  <reg name="f16" bitsize="32" type="ieee_single" regnum="48"/>
+  <reg name="f17" bitsize="32" type="ieee_single" regnum="49"/>
+  <reg name="f18" bitsize="32" type="ieee_single" regnum="50"/>
+  <reg name="f19" bitsize="32" type="ieee_single" regnum="51"/>
+  <reg name="f20" bitsize="32" type="ieee_single" regnum="52"/>
+  <reg name="f21" bitsize="32" type="ieee_single" regnum="53"/>
+  <reg name="f22" bitsize="32" type="ieee_single" regnum="54"/>
+  <reg name="f23" bitsize="32" type="ieee_single" regnum="55"/>
+  <reg name="f24" bitsize="32" type="ieee_single" regnum="56"/>
+  <reg name="f25" bitsize="32" type="ieee_single" regnum="57"/>
+  <reg name="f26" bitsize="32" type="ieee_single" regnum="58"/>
+  <reg name="f27" bitsize="32" type="ieee_single" regnum="59"/>
+  <reg name="f28" bitsize="32" type="ieee_single" regnum="60"/>
+  <reg name="f29" bitsize="32" type="ieee_single" regnum="61"/>
+  <reg name="f30" bitsize="32" type="ieee_single" regnum="62"/>
+  <reg name="f31" bitsize="32" type="ieee_single" regnum="63"/>
+
+  <reg name="y" bitsize="32" type="uint32" regnum="64"/>
+  <reg name="psr" bitsize="32" type="uint32" regnum="65"/>
+  <reg name="wim" bitsize="32" type="uint32" regnum="66"/>
+  <reg name="tbr" bitsize="32" type="uint32" regnum="67"/>
+  <reg name="pc" bitsize="32" type="code_ptr" regnum="68"/>
+  <reg name="npc" bitsize="32" type="code_ptr" regnum="69"/>
+  <reg name="fsr" bitsize="32" type="uint32" regnum="70"/>
+  <reg name="csr" bitsize="32" type="uint32" regnum="71"/>
+</feature>
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 245caf2de0..6d52be9263 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1093,6 +1093,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, const void *data)
     cc->gdb_core_xml_file = "sparc64-core.xml";
     cc->gdb_num_core_regs = 86;
 #else
+    cc->gdb_core_xml_file = "sparc32-core.xml";
     cc->gdb_num_core_regs = 72;
 #endif
     cc->tcg_ops = &sparc_tcg_ops;
-- 
2.50.0


