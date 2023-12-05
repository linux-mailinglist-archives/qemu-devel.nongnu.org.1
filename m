Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4AD80445C
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 02:55:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAKcu-0002tS-00; Mon, 04 Dec 2023 20:53:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rAKcj-0002rH-RM
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 20:53:22 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rAKcf-00062b-RC
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 20:53:21 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3b844e3e817so2880912b6e.0
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 17:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701741196; x=1702345996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vU7urSwAfTeA4lekHsW5PsTdoQI6A7TfKeK5Fim2yKU=;
 b=AvrypG26VcnqmKRZkLOdZIQUZBE1evj6GmHVZDo1y9pFlYvYvYC2WiUCNs7zLPOQSj
 FglNdNWCaWfuXGIWltFQMRt5cF+4HDWXTERCl0jWDtV37vG3QuhRoGlC8iAwecvEp+/h
 DQjtC7tVDs/HVQQG8/yw/F3Bv6oLpBnTwW3CZRlOV01vBWL981qafLjQHnnCAJnYlIQT
 WzJ/OHoM1DtGlMo+pC8GGwTlbabomUafKb8I9g0GF2HS4X3ugO36om9+OqXVI6cUPbO9
 Y8/0nRr+VQA/wMFgReKjtiv+AA9IBAq8qVAPP8PJRw57ZtQlQMlhV3VVDff1+ltE7Uyn
 yCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701741196; x=1702345996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vU7urSwAfTeA4lekHsW5PsTdoQI6A7TfKeK5Fim2yKU=;
 b=Phe4gki2l30wF0CTuSH4qXlKeZABLDPyEvdyGvJi7Tq71OwU8H/J0H4e1utBRSA1NC
 9mLtJyp8uGQTZK5TrzwlE22AUGAZ1bxBiAr9iMxck5vnm+J41aiC8LHrosLFcVFQLI40
 NsWBAFVPE5+j861RttMY5sQgof8qbdXQbCNiL1Gz7ROmO0EnCp2j4sJPqcCtPq/vL0V/
 KcLq1UWVl31poQhrVwFMvQldtjyQ359e/5eBVdQI5bKzKhgQ8NLlql/OGf/Pjkqp3gsz
 z/gvJyhdpIw2M27qkIR3RhVUyW5KUg1/TREd92IgcH9W4W3xTTgaEptmiMUEHE/KBF9R
 +++w==
X-Gm-Message-State: AOJu0YxdbW8tyYV46KDoVqTw5LOHemLAIU+0uOAH49KqTo+6Uwzg0hDI
 p24NDkksrHsaGLqJ7pF4kpZ2FctqJWYSiw==
X-Google-Smtp-Source: AGHT+IGpGeB+c6CQucE4HZVEDn2SDN3MNRgTRNMeaHH/ylSgR0BhuC5i17QVXBLuuL3qbzYc1yr8JA==
X-Received: by 2002:a05:6808:1644:b0:3b8:bb04:dab5 with SMTP id
 az4-20020a056808164400b003b8bb04dab5mr2667256oib.52.1701741195711; 
 Mon, 04 Dec 2023 17:53:15 -0800 (PST)
Received: from taylor-ubuntu.austin.rr.com (068-203-008-061.res.spectrum.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 c4-20020aca1c04000000b003b8b7063a44sm1064624oic.44.2023.12.04.17.53.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 17:53:15 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH 7/9] Hexagon (target/hexagon) Make generators object oriented
 - gen_analyze_funcs
Date: Mon,  4 Dec 2023 18:53:01 -0700
Message-Id: <20231205015303.575807-8-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205015303.575807-1-ltaylorsimpson@gmail.com>
References: <20231205015303.575807-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x22c.google.com
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
index 384f377621..e64d114cf3 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -475,6 +475,12 @@ def log_write(self, f, tag):
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
@@ -482,12 +488,22 @@ def decl_tcg(self, f, tag, regno):
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
@@ -506,6 +522,12 @@ def log_write(self, f, tag):
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
@@ -521,6 +543,12 @@ def log_write(self, f, tag):
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
@@ -533,6 +561,11 @@ def decl_tcg(self, f, tag, regno):
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
@@ -549,6 +582,11 @@ def decl_tcg(self, f, tag, regno):
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
@@ -560,6 +598,11 @@ def log_write(self, f, tag):
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
@@ -567,12 +610,22 @@ def decl_tcg(self, f, tag, regno):
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
@@ -585,6 +638,11 @@ def log_write(self, f, tag):
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
@@ -597,6 +655,12 @@ def log_write(self, f, tag):
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
@@ -607,6 +671,11 @@ def decl_tcg(self, f, tag, regno):
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
@@ -622,6 +691,12 @@ def log_write(self, f, tag):
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
@@ -638,6 +713,12 @@ def log_write(self, f, tag):
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
@@ -650,6 +731,11 @@ def decl_tcg(self, f, tag, regno):
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
@@ -669,6 +755,13 @@ def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
             /* {self.reg_tcg()} is *(MMVector *)({self.helper_arg()}) */
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
@@ -685,6 +778,11 @@ def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
             /* {self.reg_tcg()} is *(MMVector *)({self.helper_arg()}) */
         """))
+    def analyze_read(self, f, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            ctx_log_vreg_read(ctx, {self.reg_num});
+        """))
 
 class VRegNewSource(Register, Hvx, NewSource):
     def decl_tcg(self, f, tag, regno):
@@ -698,6 +796,11 @@ def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
             /* {self.reg_tcg()} is *(MMVector *)({self.helper_arg()}) */
         """))
+    def analyze_read(self, f, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            ctx_log_vreg_read(ctx, {self.reg_num});
+        """))
 
 class VRegReadWrite(Register, Hvx, ReadWrite):
     def decl_tcg(self, f, tag, regno):
@@ -720,6 +823,13 @@ def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
             /* {self.reg_tcg()} is *(MMVector *)({self.helper_arg()}) */
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
@@ -744,6 +854,13 @@ def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
             /* {self.reg_tcg()} is *(MMVector *)({self.helper_arg()}) */
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
@@ -763,6 +880,13 @@ def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
             /* {self.reg_tcg()} is *(MMVectorPair *)({self.helper_arg()}) */
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
@@ -786,6 +910,11 @@ def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
             /* {self.reg_tcg()} is *(MMVectorPair *)({self.helper_arg()}) */
         """))
+    def analyze_read(self, f, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            ctx_log_vreg_read_pair(ctx, {self.reg_num});
+        """))
 
 class VRegPairReadWrite(Register, Hvx, ReadWrite):
     def decl_tcg(self, f, tag, regno):
@@ -814,6 +943,13 @@ def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
             /* {self.reg_tcg()} is *(MMVectorPair *)({self.helper_arg()}) */
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
@@ -833,6 +969,11 @@ def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
             /* {self.reg_tcg()} is *(MMQReg *)({self.helper_arg()}) */
         """))
+    def analyze_write(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            ctx_log_qreg_write(ctx, {self.reg_num});
+        """))
 
 class QRegSource(Register, Hvx, OldSource):
     def decl_tcg(self, f, tag, regno):
@@ -850,6 +991,11 @@ def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
             /* {self.reg_tcg()} is *(MMQReg *)({self.helper_arg()}) */
         """))
+    def analyze_read(self, f, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            ctx_log_qreg_read(ctx, {self.reg_num});
+        """))
 
 class QRegReadWrite(Register, Hvx, ReadWrite):
     def decl_tcg(self, f, tag, regno):
@@ -872,6 +1018,11 @@ def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
             /* {self.reg_tcg()} is *(MMQReg *)({self.helper_arg()}) */
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


