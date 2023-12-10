Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C325D80BD7C
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 23:08:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCRxU-0004yK-U0; Sun, 10 Dec 2023 17:07:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rCRxT-0004xy-3y
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 17:07:31 -0500
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rCRxQ-0004Za-Cp
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 17:07:30 -0500
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-59067ccb090so2333981eaf.1
 for <qemu-devel@nongnu.org>; Sun, 10 Dec 2023 14:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702246046; x=1702850846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QA02i5fuxl3bQmduiNjk8N/f7TxobiZKIdgKHb3cQRg=;
 b=F0EkFxZYPWkWJZ1G4St4x3NQ3l2re5EeCyjYApst7zh06/F+CdMTLP+KIjPaX97BQF
 R0f0mArmKges8bv3QwMjW6XPk3lE9ffuLlNmQ0sgilLgy+aN/6tuybbDY1KD1FdWRTqr
 +NL4Xi0ha8P9Paqlii6G871H47frJzY6+cTIemr2FF1AVW9uYN2FJ2Lp61F+I/Ko80+u
 6EfIW6EVG4G7bbEslq846/KBMGFFc1EOyZV7VDpa97FqGnXFjtkOYOLjxpENh81ym24z
 VCS40Uo+Cg8wVX5XBT0kAWFswWLmRAhE6XPXZzAzFW0qHXiqHa1SfYT+pWSEUxw0wESH
 KCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702246046; x=1702850846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QA02i5fuxl3bQmduiNjk8N/f7TxobiZKIdgKHb3cQRg=;
 b=hJCuDIauuxTvGGBBqElBJjIeU5t2Acf4oIs+vSi9l1t7A767uc1r8HIyCXdzKU3wfl
 Toh9YAwcXBwGQ2WgS8X4Bm9MnqJyyvEayBee74fFqIa1VLWY+ev5uf7V4yKH8Dy9MdfE
 vpoi19uphxYf5OQg8Bk6Cr9JIJp9AmOivUkcqBRSRhb72EmihQ6mHJVwaryWDoBCE9Sx
 apHrKJn4BipU4mW2opFGBlH6Y08vFo1gsODIpcwLfvQfcjLUKfEL6GeoycUbllkCIPcj
 aEIYKdse3wdxdRTuMUBHY+YFvkMMeBZqlu3Pu/kwNU6TThLgocoFflsBHxe7vHWy8gW4
 QIAw==
X-Gm-Message-State: AOJu0Yw17eAFXte4rOk81WNs8CgD2EOkieOixui3hmqzzswOHKCkjojE
 NY72a+INFmd2XAZlROd/jkPak8wHwyqa4Q==
X-Google-Smtp-Source: AGHT+IHdXP0exQjNZZLgrz7gUz44s0dcZSdaxuI5AHiEKLV82rlXxAuA3+xxfhbdiTyyuQVwEgERPQ==
X-Received: by 2002:a4a:3519:0:b0:590:749a:aedc with SMTP id
 l25-20020a4a3519000000b00590749aaedcmr2334360ooa.16.1702246046411; 
 Sun, 10 Dec 2023 14:07:26 -0800 (PST)
Received: from taylor-ubuntu.austin.rr.com (068-203-008-061.res.spectrum.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 q23-20020a4a6c17000000b0058e200a9065sm1588173ooc.29.2023.12.10.14.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Dec 2023 14:07:25 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 7/9] Hexagon (target/hexagon) Make generators object
 oriented - gen_analyze_funcs
Date: Sun, 10 Dec 2023 15:07:10 -0700
Message-Id: <20231210220712.491494-8-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231210220712.491494-1-ltaylorsimpson@gmail.com>
References: <20231210220712.491494-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This patch conflicts with
https://lists.gnu.org/archive/html/qemu-devel/2023-11/msg00729.html
If that series goes in first, we'll rework this patch and vice versa.

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/gen_analyze_funcs.py | 163 +---------------------------
 target/hexagon/hex_common.py        | 151 ++++++++++++++++++++++++++
 2 files changed, 157 insertions(+), 157 deletions(-)

diff --git a/target/hexagon/gen_analyze_funcs.py b/target/hexagon/gen_analyze_funcs.py
index c3b521abef..a9af666cef 100755
--- a/target/hexagon/gen_analyze_funcs.py
+++ b/target/hexagon/gen_analyze_funcs.py
@@ -23,162 +23,6 @@
 import hex_common
 
 
-##
-## Helpers for gen_analyze_func
-##
-def is_predicated(tag):
-    return "A_CONDEXEC" in hex_common.attribdict[tag]
-
-
-def analyze_opn_old(f, tag, regtype, regid, regno):
-    regN = f"{regtype}{regid}N"
-    predicated = "true" if is_predicated(tag) else "false"
-    if regtype == "R":
-        if regid in {"ss", "tt"}:
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(f"    ctx_log_reg_read_pair(ctx, {regN});\n")
-        elif regid in {"dd", "ee", "xx", "yy"}:
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(f"    ctx_log_reg_write_pair(ctx, {regN}, {predicated});\n")
-        elif regid in {"s", "t", "u", "v"}:
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(f"    ctx_log_reg_read(ctx, {regN});\n")
-        elif regid in {"d", "e", "x", "y"}:
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(f"    ctx_log_reg_write(ctx, {regN}, {predicated});\n")
-        else:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "P":
-        if regid in {"s", "t", "u", "v"}:
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(f"    ctx_log_pred_read(ctx, {regN});\n")
-        elif regid in {"d", "e", "x"}:
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(f"    ctx_log_pred_write(ctx, {regN});\n")
-        else:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "C":
-        if regid == "ss":
-            f.write(
-                f"    const int {regN} = insn->regno[{regno}] "
-                "+ HEX_REG_SA0;\n"
-            )
-            f.write(f"    ctx_log_reg_read_pair(ctx, {regN});\n")
-        elif regid == "dd":
-            f.write(f"    const int {regN} = insn->regno[{regno}] " "+ HEX_REG_SA0;\n")
-            f.write(f"    ctx_log_reg_write_pair(ctx, {regN}, {predicated});\n")
-        elif regid == "s":
-            f.write(
-                f"    const int {regN} = insn->regno[{regno}] "
-                "+ HEX_REG_SA0;\n"
-            )
-            f.write(f"    ctx_log_reg_read(ctx, {regN});\n")
-        elif regid == "d":
-            f.write(f"    const int {regN} = insn->regno[{regno}] " "+ HEX_REG_SA0;\n")
-            f.write(f"    ctx_log_reg_write(ctx, {regN}, {predicated});\n")
-        else:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "M":
-        if regid == "u":
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(f"    ctx_log_reg_read(ctx, {regN});\n")
-        else:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "V":
-        newv = "EXT_DFL"
-        if hex_common.is_new_result(tag):
-            newv = "EXT_NEW"
-        elif hex_common.is_tmp_result(tag):
-            newv = "EXT_TMP"
-        if regid in {"dd", "xx"}:
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(
-                f"    ctx_log_vreg_write_pair(ctx, {regN}, {newv}, " f"{predicated});\n"
-            )
-        elif regid in {"uu", "vv"}:
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(f"    ctx_log_vreg_read_pair(ctx, {regN});\n")
-        elif regid in {"s", "u", "v", "w"}:
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(f"    ctx_log_vreg_read(ctx, {regN});\n")
-        elif regid in {"d", "x", "y"}:
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(f"    ctx_log_vreg_write(ctx, {regN}, {newv}, " f"{predicated});\n")
-        else:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "Q":
-        if regid in {"d", "e", "x"}:
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(f"    ctx_log_qreg_write(ctx, {regN});\n")
-        elif regid in {"s", "t", "u", "v"}:
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(f"    ctx_log_qreg_read(ctx, {regN});\n")
-        else:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "G":
-        if regid in {"dd"}:
-            f.write(f"//    const int {regN} = insn->regno[{regno}];\n")
-        elif regid in {"d"}:
-            f.write(f"//    const int {regN} = insn->regno[{regno}];\n")
-        elif regid in {"ss"}:
-            f.write(f"//    const int {regN} = insn->regno[{regno}];\n")
-        elif regid in {"s"}:
-            f.write(f"//    const int {regN} = insn->regno[{regno}];\n")
-        else:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "S":
-        if regid in {"dd"}:
-            f.write(f"//    const int {regN} = insn->regno[{regno}];\n")
-        elif regid in {"d"}:
-            f.write(f"//    const int {regN} = insn->regno[{regno}];\n")
-        elif regid in {"ss"}:
-            f.write(f"//    const int {regN} = insn->regno[{regno}];\n")
-        elif regid in {"s"}:
-            f.write(f"//    const int {regN} = insn->regno[{regno}];\n")
-        else:
-            hex_common.bad_register(regtype, regid)
-    else:
-        hex_common.bad_register(regtype, regid)
-
-
-def analyze_opn_new(f, tag, regtype, regid, regno):
-    regN = f"{regtype}{regid}N"
-    if regtype == "N":
-        if regid in {"s", "t"}:
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(f"    ctx_log_reg_read(ctx, {regN});\n")
-        else:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "P":
-        if regid in {"t", "u", "v"}:
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(f"    ctx_log_pred_read(ctx, {regN});\n")
-        else:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "O":
-        if regid == "s":
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-            f.write(f"    ctx_log_vreg_read(ctx, {regN});\n")
-        else:
-            hex_common.bad_register(regtype, regid)
-    else:
-        hex_common.bad_register(regtype, regid)
-
-
-def analyze_opn(f, tag, regtype, regid, i):
-    if hex_common.is_pair(regid):
-        analyze_opn_old(f, tag, regtype, regid, i)
-    elif hex_common.is_single(regid):
-        if hex_common.is_old_val(regtype, regid, tag):
-            analyze_opn_old(f, tag, regtype, regid, i)
-        elif hex_common.is_new_val(regtype, regid, tag):
-            analyze_opn_new(f, tag, regtype, regid, i)
-        else:
-            hex_common.bad_register(regtype, regid)
-    else:
-        hex_common.bad_register(regtype, regid)
-
-
 ##
 ## Generate the code to analyze the instruction
 ##     For A2_add: Rd32=add(Rs32,Rt32), { RdV=RsV+RtV;}
@@ -203,7 +47,11 @@ def gen_analyze_func(f, tag, regs, imms):
     i = 0
     ## Analyze all the registers
     for regtype, regid in regs:
-        analyze_opn(f, tag, regtype, regid, i)
+        reg = hex_common.get_register(tag, regtype, regid)
+        if reg.is_written():
+            reg.analyze_write(f, tag, i)
+        else:
+            reg.analyze_read(f, i)
         i += 1
 
     has_generated_helper = not hex_common.skip_qemu_helper(
@@ -236,6 +84,7 @@ def main():
     if is_idef_parser_enabled:
         hex_common.read_idef_parser_enabled_file(sys.argv[5])
     hex_common.calculate_attribs()
+    hex_common.init_registers()
     tagregs = hex_common.get_tagregs()
     tagimms = hex_common.get_tagimms()
 
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index fc9ce4e2b0..4565dd1953 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -486,6 +486,12 @@ def log_write(self, f, tag):
         f.write(code_fmt(f"""\
             gen_log_reg_write(ctx, {self.reg_num}, {self.reg_tcg()});
         """))
+    def analyze_write(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        predicated = "true" if is_predicated(tag) else "false"
+        f.write(code_fmt(f"""\
+            ctx_log_reg_write(ctx, {self.reg_num}, {predicated});
+        """))
 
 class GprSource(Register, Single, OldSource):
     def decl_tcg(self, f, tag, regno):
@@ -493,12 +499,22 @@ def decl_tcg(self, f, tag, regno):
         f.write(code_fmt(f"""\
             TCGv {self.reg_tcg()} = hex_gpr[{self.reg_num}];
         """))
+    def analyze_read(self, f, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            ctx_log_reg_read(ctx, {self.reg_num});
+        """))
 
 class GprNewSource(Register, Single, NewSource):
     def decl_tcg(self, f, tag, regno):
         f.write(code_fmt(f"""\
             TCGv {self.reg_tcg()} = get_result_gpr(ctx, insn->regno[{regno}]);
         """))
+    def analyze_read(self, f, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            ctx_log_reg_read(ctx, {self.reg_num});
+        """))
 
 class GprReadWrite(Register, Single, ReadWrite):
     def decl_tcg(self, f, tag, regno):
@@ -517,6 +533,12 @@ def log_write(self, f, tag):
         f.write(code_fmt(f"""\
             gen_log_reg_write(ctx, {self.reg_num}, {self.reg_tcg()});
         """))
+    def analyze_write(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        predicated = "true" if is_predicated(tag) else "false"
+        f.write(code_fmt(f"""\
+            ctx_log_reg_write(ctx, {self.reg_num}, {predicated});
+        """))
 
 class ControlDest(Register, Single, Dest):
     def decl_reg_num(self, f, regno):
@@ -532,6 +554,12 @@ def log_write(self, f, tag):
         f.write(code_fmt(f"""\
             gen_write_ctrl_reg(ctx, {self.reg_num}, {self.reg_tcg()});
         """))
+    def analyze_write(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        predicated = "true" if is_predicated(tag) else "false"
+        f.write(code_fmt(f"""\
+            ctx_log_reg_write(ctx, {self.reg_num}, {predicated});
+        """))
 
 class ControlSource(Register, Single, OldSource):
     def decl_reg_num(self, f, regno):
@@ -544,6 +572,11 @@ def decl_tcg(self, f, tag, regno):
             TCGv {self.reg_tcg()} = tcg_temp_new();
             gen_read_ctrl_reg(ctx, {self.reg_num}, {self.reg_tcg()});
         """))
+    def analyze_read(self, f, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            ctx_log_reg_read(ctx, {self.reg_num});
+        """))
 
 class ModifierSource(Register, Single, OldSource):
     def decl_reg_num(self, f, regno):
@@ -560,6 +593,11 @@ def decl_tcg(self, f, tag, regno):
     def idef_arg(self, declared):
         declared.append(self.reg_tcg())
         declared.append("CS")
+    def analyze_read(self, f, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            ctx_log_reg_read(ctx, {self.reg_num});
+        """))
 
 class PredDest(Register, Single, Dest):
     def decl_tcg(self, f, tag, regno):
@@ -571,6 +609,11 @@ def log_write(self, f, tag):
         f.write(code_fmt(f"""\
             gen_log_pred_write(ctx, {self.reg_num}, {self.reg_tcg()});
         """))
+    def analyze_write(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            ctx_log_pred_write(ctx, {self.reg_num});
+        """))
 
 class PredSource(Register, Single, OldSource):
     def decl_tcg(self, f, tag, regno):
@@ -578,12 +621,22 @@ def decl_tcg(self, f, tag, regno):
         f.write(code_fmt(f"""\
             TCGv {self.reg_tcg()} = hex_pred[{self.reg_num}];
         """))
+    def analyze_read(self, f, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            ctx_log_pred_read(ctx, {self.reg_num});
+        """))
 
 class PredNewSource(Register, Single, NewSource):
     def decl_tcg(self, f, tag, regno):
         f.write(code_fmt(f"""\
             TCGv {self.reg_tcg()} = get_result_pred(ctx, insn->regno[{regno}]);
         """))
+    def analyze_read(self, f, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            ctx_log_pred_read(ctx, {self.reg_num});
+        """))
 
 class PredReadWrite(Register, Single, ReadWrite):
     def decl_tcg(self, f, tag, regno):
@@ -596,6 +649,11 @@ def log_write(self, f, tag):
         f.write(code_fmt(f"""\
             gen_log_pred_write(ctx, {self.reg_num}, {self.reg_tcg()});
         """))
+    def analyze_write(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            ctx_log_pred_write(ctx, {self.reg_num});
+        """))
 
 class PairDest(Register, Pair, Dest):
     def decl_tcg(self, f, tag, regno):
@@ -608,6 +666,12 @@ def log_write(self, f, tag):
         f.write(code_fmt(f"""\
             gen_log_reg_write_pair(ctx, {self.reg_num}, {self.reg_tcg()});
         """))
+    def analyze_write(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        predicated = "true" if is_predicated(tag) else "false"
+        f.write(code_fmt(f"""\
+            ctx_log_reg_write_pair(ctx, {self.reg_num}, {predicated});
+        """))
 
 class PairSource(Register, Pair, OldSource):
     def decl_tcg(self, f, tag, regno):
@@ -618,6 +682,11 @@ def decl_tcg(self, f, tag, regno):
                                     hex_gpr[{self.reg_num}],
                                     hex_gpr[{self.reg_num} + 1]);
         """))
+    def analyze_read(self, f, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            ctx_log_reg_read_pair(ctx, {self.reg_num});
+        """))
 
 class PairReadWrite(Register, Pair, ReadWrite):
     def decl_tcg(self, f, tag, regno):
@@ -633,6 +702,12 @@ def log_write(self, f, tag):
         f.write(code_fmt(f"""\
             gen_log_reg_write_pair(ctx, {self.reg_num}, {self.reg_tcg()});
         """))
+    def analyze_write(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        predicated = "true" if is_predicated(tag) else "false"
+        f.write(code_fmt(f"""\
+            ctx_log_reg_write_pair(ctx, {self.reg_num}, {predicated});
+        """))
 
 class ControlPairDest(Register, Pair, Dest):
     def decl_reg_num(self, f, regno):
@@ -649,6 +724,12 @@ def log_write(self, f, tag):
         f.write(code_fmt(f"""\
             gen_write_ctrl_reg_pair(ctx, {self.reg_num}, {self.reg_tcg()});
         """))
+    def analyze_write(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        predicated = "true" if is_predicated(tag) else "false"
+        f.write(code_fmt(f"""\
+            ctx_log_reg_write_pair(ctx, {self.reg_num}, {predicated});
+        """))
 
 class ControlPairSource(Register, Pair, OldSource):
     def decl_reg_num(self, f, regno):
@@ -661,6 +742,11 @@ def decl_tcg(self, f, tag, regno):
             TCGv_i64 {self.reg_tcg()} = tcg_temp_new_i64();
             gen_read_ctrl_reg_pair(ctx, {self.reg_num}, {self.reg_tcg()});
         """))
+    def analyze_read(self, f, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            ctx_log_reg_read_pair(ctx, {self.reg_num});
+        """))
 
 class VRegDest(Register, Hvx, Dest):
     def decl_tcg(self, f, tag, regno):
@@ -680,6 +766,13 @@ def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
             /* {self.reg_tcg()} is *(MMVector *)({self.helper_arg_name()}) */
         """))
+    def analyze_write(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        newv = hvx_newv(tag)
+        predicated = "true" if is_predicated(tag) else "false"
+        f.write(code_fmt(f"""\
+            ctx_log_vreg_write(ctx, {self.reg_num}, {newv}, {predicated});
+        """))
 
 class VRegSource(Register, Hvx, OldSource):
     def decl_tcg(self, f, tag, regno):
@@ -696,6 +789,11 @@ def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
             /* {self.reg_tcg()} is *(MMVector *)({self.helper_arg_name()}) */
         """))
+    def analyze_read(self, f, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            ctx_log_vreg_read(ctx, {self.reg_num});
+        """))
 
 class VRegNewSource(Register, Hvx, NewSource):
     def decl_tcg(self, f, tag, regno):
@@ -709,6 +807,11 @@ def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
             /* {self.reg_tcg()} is *(MMVector *)({self.helper_arg_name()}) */
         """))
+    def analyze_read(self, f, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            ctx_log_vreg_read(ctx, {self.reg_num});
+        """))
 
 class VRegReadWrite(Register, Hvx, ReadWrite):
     def decl_tcg(self, f, tag, regno):
@@ -731,6 +834,13 @@ def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
             /* {self.reg_tcg()} is *(MMVector *)({self.helper_arg_name()}) */
         """))
+    def analyze_write(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        newv = hvx_newv(tag)
+        predicated = "true" if is_predicated(tag) else "false"
+        f.write(code_fmt(f"""\
+            ctx_log_vreg_write(ctx, {self.reg_num}, {newv}, {predicated});
+        """))
 
 class VRegTmp(Register, Hvx, ReadWrite):
     def decl_tcg(self, f, tag, regno):
@@ -755,6 +865,13 @@ def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
             /* {self.reg_tcg()} is *(MMVector *)({self.helper_arg_name()}) */
         """))
+    def analyze_write(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        newv = hvx_newv(tag)
+        predicated = "true" if is_predicated(tag) else "false"
+        f.write(code_fmt(f"""\
+            ctx_log_vreg_write(ctx, {self.reg_num}, {newv}, {predicated});
+        """))
 
 class VRegPairDest(Register, Hvx, Dest):
     def decl_tcg(self, f, tag, regno):
@@ -774,6 +891,13 @@ def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
             /* {self.reg_tcg()} is *(MMVectorPair *)({self.helper_arg_name()}) */
         """))
+    def analyze_write(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        newv = hvx_newv(tag)
+        predicated = "true" if is_predicated(tag) else "false"
+        f.write(code_fmt(f"""\
+            ctx_log_vreg_write_pair(ctx, {self.reg_num}, {newv}, {predicated});
+        """))
 
 class VRegPairSource(Register, Hvx, OldSource):
     def decl_tcg(self, f, tag, regno):
@@ -797,6 +921,11 @@ def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
             /* {self.reg_tcg()} is *(MMVectorPair *)({self.helper_arg_name()}) */
         """))
+    def analyze_read(self, f, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            ctx_log_vreg_read_pair(ctx, {self.reg_num});
+        """))
 
 class VRegPairReadWrite(Register, Hvx, ReadWrite):
     def decl_tcg(self, f, tag, regno):
@@ -825,6 +954,13 @@ def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
             /* {self.reg_tcg()} is *(MMVectorPair *)({self.helper_arg_name()}) */
         """))
+    def analyze_write(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        newv = hvx_newv(tag)
+        predicated = "true" if is_predicated(tag) else "false"
+        f.write(code_fmt(f"""\
+            ctx_log_vreg_write_pair(ctx, {self.reg_num}, {newv}, {predicated});
+        """))
 
 class QRegDest(Register, Hvx, Dest):
     def decl_tcg(self, f, tag, regno):
@@ -844,6 +980,11 @@ def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
             /* {self.reg_tcg()} is *(MMQReg *)({self.helper_arg_name()}) */
         """))
+    def analyze_write(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            ctx_log_qreg_write(ctx, {self.reg_num});
+        """))
 
 class QRegSource(Register, Hvx, OldSource):
     def decl_tcg(self, f, tag, regno):
@@ -861,6 +1002,11 @@ def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
             /* {self.reg_tcg()} is *(MMQReg *)({self.helper_arg_name()}) */
         """))
+    def analyze_read(self, f, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            ctx_log_qreg_read(ctx, {self.reg_num});
+        """))
 
 class QRegReadWrite(Register, Hvx, ReadWrite):
     def decl_tcg(self, f, tag, regno):
@@ -883,6 +1029,11 @@ def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
             /* {self.reg_tcg()} is *(MMQReg *)({self.helper_arg_name()}) */
         """))
+    def analyze_write(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            ctx_log_qreg_write(ctx, {self.reg_num});
+        """))
 
 def init_registers():
     regs = {
-- 
2.34.1


