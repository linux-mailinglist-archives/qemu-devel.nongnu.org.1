Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB797E7395
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 22:27:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1CXK-0006TD-Rc; Thu, 09 Nov 2023 16:26:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1r1CXI-0006Sl-UZ
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 16:26:00 -0500
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1r1CXF-0000oZ-3A
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 16:26:00 -0500
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5842a94feb2so739929eaf.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 13:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699565155; x=1700169955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RN1OktxY7fx8Hcg6EEIfuGrZ0wh19RMJx2gow6DkuU4=;
 b=I0Uon1wC2YlwfS/EWe1vQ92AS9vA5/SszTlpW1yjHiyuF2K8e9RyQysXASnLBdQu7C
 nI5t+GHiyLFr6QN7EEjvWwffcWICLU9hu9VmJA/E80A3y3ntvNzEGOZSBl0qIVNVS66y
 n//dw/tpanoorNQPRoPGI1UFf3wGNCMQN4vhgxzIVIyydyC9ufv22X+3KmvJ3f2NpDRZ
 TmqKw4TyhXay++rxP6vv0E6idvZrrijQxJMsuXV1ocLDuv7jvtBOA1jbumP9cLOHiP6Y
 x96+WD4kYQMlwn6RpPpBjHa5HYHQ4KPHUJjc3QnPCaui8SOoTsbQHwr4iR8NCRanLHuE
 WSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699565155; x=1700169955;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RN1OktxY7fx8Hcg6EEIfuGrZ0wh19RMJx2gow6DkuU4=;
 b=NmAYYAI+lFAt5a9Ql0t2h1s2CTE3XBfEh9E7VN5uwb/MceQgrmm7LKkR0PtW0s/xU/
 1BcimjrYZS82NJx8c7uFWPCqoKbOUT18LA5kedeaLmQYkANI2WVKCfchWDtZZwNQUH5y
 drpacYQy+pnJGDdHDKY4ft/wTBG+1ozr2xHdNdFuhkqdW/fOlZ4reBFH3Da0EPtNapPQ
 h/EIGpXWohTWEEBALjbRHNut3lQRkUS9HBnpsP1/RDfl5/dleLgXohfwBsKf/JFfw5Gs
 es3BfPaOtOtsKIPiPUVndrlQAtpPVKyu4bsY4QfvFSVTYuyta1TDIGBpL5ikYV/cVSZc
 Wrzw==
X-Gm-Message-State: AOJu0Yx70nCFjmiv5sMFB+avpDg4+LCnDqbxbeFGJIsq7tH3wUwXMCBM
 HNeYummJJmoj1uc5F4T0EWutWpTp96/sJg==
X-Google-Smtp-Source: AGHT+IHKpprnV+eDOxxOjUKT4IhAibfo91Aq+ZyVC/dq7fWqXy3nvWiQ9V+Z5PY46pCvYMT1HVM2lg==
X-Received: by 2002:a4a:e490:0:b0:581:e089:9e5c with SMTP id
 s16-20020a4ae490000000b00581e0899e5cmr5973099oov.6.1699565154474; 
 Thu, 09 Nov 2023 13:25:54 -0800 (PST)
Received: from taylor-ubuntu.austin.rr.com (cpe-68-203-8-61.austin.res.rr.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 l14-20020a0568301d6e00b006ce1f9c62a1sm2335054oti.39.2023.11.09.13.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 13:25:53 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [RFC PATCH] Hexagon (target/hexagon) Make generators object oriented
Date: Thu,  9 Nov 2023 14:25:49 -0700
Message-Id: <20231109212549.356168-1-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oo1-xc31.google.com
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

RFC - This patch handles gen_tcg_funcs.py.  I'd like to get comments
on the general approach before working on the other Python scripts.

The generators are generally a bunch of Python if-then-else
statements based on the regtype and regid.  Encapsulate regtype/regid
into a class hierarchy.  Clients lookup the register and invoke
methods.

This has several advantages for making the code easier to read,
understand, and maintain
- The class name makes it more clear what the operand does
- All the methods for a given type of operand are together
- Don't need as many calls to hex_common.bad_register
- We can remove the functions in hex_common that use regtype/regid
  (e.g., is_read)

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/gen_tcg_funcs.py | 568 +++-----------------------------
 target/hexagon/hex_common.py    | 467 ++++++++++++++++++++++++++
 2 files changed, 509 insertions(+), 526 deletions(-)

diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs.py
index f5246cee6d..f7a0c59397 100755
--- a/target/hexagon/gen_tcg_funcs.py
+++ b/target/hexagon/gen_tcg_funcs.py
@@ -23,454 +23,6 @@
 import hex_common
 
 
-##
-## Helpers for gen_tcg_func
-##
-def gen_decl_ea_tcg(f, tag):
-    f.write("    TCGv EA G_GNUC_UNUSED = tcg_temp_new();\n")
-
-
-def genptr_decl_pair_writable(f, tag, regtype, regid, regno):
-    regN = f"{regtype}{regid}N"
-    if regtype == "R":
-        f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-    elif regtype == "C":
-        f.write(f"    const int {regN} = insn->regno[{regno}] + HEX_REG_SA0;\n")
-    else:
-        hex_common.bad_register(regtype, regid)
-    f.write(f"    TCGv_i64 {regtype}{regid}V = " f"get_result_gpr_pair(ctx, {regN});\n")
-
-
-def genptr_decl_writable(f, tag, regtype, regid, regno):
-    regN = f"{regtype}{regid}N"
-    if regtype == "R":
-        f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-        f.write(f"    TCGv {regtype}{regid}V = get_result_gpr(ctx, {regN});\n")
-    elif regtype == "C":
-        f.write(f"    const int {regN} = insn->regno[{regno}] + HEX_REG_SA0;\n")
-        f.write(f"    TCGv {regtype}{regid}V = get_result_gpr(ctx, {regN});\n")
-    elif regtype == "P":
-        f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-        f.write(f"    TCGv {regtype}{regid}V = tcg_temp_new();\n")
-    else:
-        hex_common.bad_register(regtype, regid)
-
-
-def genptr_decl(f, tag, regtype, regid, regno):
-    regN = f"{regtype}{regid}N"
-    if regtype == "R":
-        if regid in {"ss", "tt"}:
-            f.write(f"    TCGv_i64 {regtype}{regid}V = tcg_temp_new_i64();\n")
-            f.write(f"    const int {regN} = insn->regno[{regno}];\n")
-        elif regid in {"dd", "ee", "xx", "yy"}:
-            genptr_decl_pair_writable(f, tag, regtype, regid, regno)
-        elif regid in {"s", "t", "u", "v"}:
-            f.write(
-                f"    TCGv {regtype}{regid}V = " f"hex_gpr[insn->regno[{regno}]];\n"
-            )
-        elif regid in {"d", "e", "x", "y"}:
-            genptr_decl_writable(f, tag, regtype, regid, regno)
-        else:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "P":
-        if regid in {"s", "t", "u", "v"}:
-            f.write(
-                f"    TCGv {regtype}{regid}V = " f"hex_pred[insn->regno[{regno}]];\n"
-            )
-        elif regid in {"d", "e", "x"}:
-            genptr_decl_writable(f, tag, regtype, regid, regno)
-        else:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "C":
-        if regid == "ss":
-            f.write(f"    TCGv_i64 {regtype}{regid}V = " f"tcg_temp_new_i64();\n")
-            f.write(f"    const int {regN} = insn->regno[{regno}] + " "HEX_REG_SA0;\n")
-        elif regid == "dd":
-            genptr_decl_pair_writable(f, tag, regtype, regid, regno)
-        elif regid == "s":
-            f.write(f"    TCGv {regtype}{regid}V = tcg_temp_new();\n")
-            f.write(
-                f"    const int {regtype}{regid}N = insn->regno[{regno}] + "
-                "HEX_REG_SA0;\n"
-            )
-        elif regid == "d":
-            genptr_decl_writable(f, tag, regtype, regid, regno)
-        else:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "M":
-        if regid == "u":
-            f.write(f"    const int {regtype}{regid}N = " f"insn->regno[{regno}];\n")
-            f.write(
-                f"    TCGv {regtype}{regid}V = hex_gpr[{regtype}{regid}N + "
-                "HEX_REG_M0];\n"
-            )
-        else:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "V":
-        if regid in {"dd"}:
-            f.write(f"    const int {regtype}{regid}N = " f"insn->regno[{regno}];\n")
-            f.write(f"    const intptr_t {regtype}{regid}V_off =\n")
-            if hex_common.is_tmp_result(tag):
-                f.write(
-                    f"        ctx_tmp_vreg_off(ctx, {regtype}{regid}N, 2, " "true);\n"
-                )
-            else:
-                f.write(f"        ctx_future_vreg_off(ctx, {regtype}{regid}N,")
-                f.write(" 2, true);\n")
-            if not hex_common.skip_qemu_helper(tag):
-                f.write(f"    TCGv_ptr {regtype}{regid}V = " "tcg_temp_new_ptr();\n")
-                f.write(
-                    f"    tcg_gen_addi_ptr({regtype}{regid}V, tcg_env, "
-                    f"{regtype}{regid}V_off);\n"
-                )
-        elif regid in {"uu", "vv", "xx"}:
-            f.write(f"    const int {regtype}{regid}N = " f"insn->regno[{regno}];\n")
-            f.write(f"    const intptr_t {regtype}{regid}V_off =\n")
-            f.write(f"        offsetof(CPUHexagonState, {regtype}{regid}V);\n")
-            if not hex_common.skip_qemu_helper(tag):
-                f.write(f"    TCGv_ptr {regtype}{regid}V = " "tcg_temp_new_ptr();\n")
-                f.write(
-                    f"    tcg_gen_addi_ptr({regtype}{regid}V, tcg_env, "
-                    f"{regtype}{regid}V_off);\n"
-                )
-        elif regid in {"s", "u", "v", "w"}:
-            f.write(f"    const int {regtype}{regid}N = " f"insn->regno[{regno}];\n")
-            f.write(f"    const intptr_t {regtype}{regid}V_off =\n")
-            f.write(f"        vreg_src_off(ctx, {regtype}{regid}N);\n")
-            if not hex_common.skip_qemu_helper(tag):
-                f.write(f"    TCGv_ptr {regtype}{regid}V = " "tcg_temp_new_ptr();\n")
-        elif regid in {"d", "x", "y"}:
-            f.write(f"    const int {regtype}{regid}N = " f"insn->regno[{regno}];\n")
-            f.write(f"    const intptr_t {regtype}{regid}V_off =\n")
-            if regid == "y":
-                f.write("        offsetof(CPUHexagonState, vtmp);\n")
-            elif hex_common.is_tmp_result(tag):
-                f.write(
-                    f"        ctx_tmp_vreg_off(ctx, {regtype}{regid}N, 1, " "true);\n"
-                )
-            else:
-                f.write(f"        ctx_future_vreg_off(ctx, {regtype}{regid}N,")
-                f.write(" 1, true);\n")
-
-            if not hex_common.skip_qemu_helper(tag):
-                f.write(f"    TCGv_ptr {regtype}{regid}V = " "tcg_temp_new_ptr();\n")
-                f.write(
-                    f"    tcg_gen_addi_ptr({regtype}{regid}V, tcg_env, "
-                    f"{regtype}{regid}V_off);\n"
-                )
-        else:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "Q":
-        if regid in {"d", "e", "x"}:
-            f.write(f"    const int {regtype}{regid}N = " f"insn->regno[{regno}];\n")
-            f.write(f"    const intptr_t {regtype}{regid}V_off =\n")
-            f.write(f"        get_result_qreg(ctx, {regtype}{regid}N);\n")
-            if not hex_common.skip_qemu_helper(tag):
-                f.write(f"    TCGv_ptr {regtype}{regid}V = " "tcg_temp_new_ptr();\n")
-                f.write(
-                    f"    tcg_gen_addi_ptr({regtype}{regid}V, tcg_env, "
-                    f"{regtype}{regid}V_off);\n"
-                )
-        elif regid in {"s", "t", "u", "v"}:
-            f.write(f"    const int {regtype}{regid}N = " f"insn->regno[{regno}];\n")
-            f.write(f"    const intptr_t {regtype}{regid}V_off =\n")
-            f.write(
-                f"        offsetof(CPUHexagonState, " f"QRegs[{regtype}{regid}N]);\n"
-            )
-            if not hex_common.skip_qemu_helper(tag):
-                f.write(f"    TCGv_ptr {regtype}{regid}V = " "tcg_temp_new_ptr();\n")
-        else:
-            hex_common.bad_register(regtype, regid)
-    else:
-        hex_common.bad_register(regtype, regid)
-
-
-def genptr_decl_new(f, tag, regtype, regid, regno):
-    if regtype == "N":
-        if regid in {"s", "t"}:
-            f.write(
-                f"    TCGv {regtype}{regid}N = "
-                f"get_result_gpr(ctx, insn->regno[{regno}]);\n"
-            )
-        else:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "P":
-        if regid in {"t", "u", "v"}:
-            f.write(
-                f"    TCGv {regtype}{regid}N = "
-                f"ctx->new_pred_value[insn->regno[{regno}]];\n"
-            )
-        else:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "O":
-        if regid == "s":
-            f.write(
-                f"    const intptr_t {regtype}{regid}N_num = "
-                f"insn->regno[{regno}];\n"
-            )
-            if hex_common.skip_qemu_helper(tag):
-                f.write(f"    const intptr_t {regtype}{regid}N_off =\n")
-                f.write("         ctx_future_vreg_off(ctx, " f"{regtype}{regid}N_num,")
-                f.write(" 1, true);\n")
-            else:
-                f.write(
-                    f"    TCGv {regtype}{regid}N = "
-                    f"tcg_constant_tl({regtype}{regid}N_num);\n"
-                )
-        else:
-            hex_common.bad_register(regtype, regid)
-    else:
-        hex_common.bad_register(regtype, regid)
-
-
-def genptr_decl_opn(f, tag, regtype, regid, i):
-    if hex_common.is_pair(regid):
-        genptr_decl(f, tag, regtype, regid, i)
-    elif hex_common.is_single(regid):
-        if hex_common.is_old_val(regtype, regid, tag):
-            genptr_decl(f, tag, regtype, regid, i)
-        elif hex_common.is_new_val(regtype, regid, tag):
-            genptr_decl_new(f, tag, regtype, regid, i)
-        else:
-            hex_common.bad_register(regtype, regid)
-    else:
-        hex_common.bad_register(regtype, regid)
-
-
-def genptr_decl_imm(f, immlett):
-    if immlett.isupper():
-        i = 1
-    else:
-        i = 0
-    f.write(f"    int {hex_common.imm_name(immlett)} = insn->immed[{i}];\n")
-
-
-def genptr_src_read(f, tag, regtype, regid):
-    if regtype == "R":
-        if regid in {"ss", "tt", "xx", "yy"}:
-            f.write(
-                f"    tcg_gen_concat_i32_i64({regtype}{regid}V, "
-                f"hex_gpr[{regtype}{regid}N],\n"
-            )
-            f.write(
-                f"                                 hex_gpr[{regtype}"
-                f"{regid}N + 1]);\n"
-            )
-        elif regid in {"x", "y"}:
-            ## For read/write registers, we need to get the original value into
-            ## the result TCGv.  For conditional instructions, this is done in
-            ## gen_start_packet.  For unconditional instructions, we do it here.
-            if "A_CONDEXEC" not in hex_common.attribdict[tag]:
-                f.write(
-                    f"    tcg_gen_mov_tl({regtype}{regid}V, "
-                    f"hex_gpr[{regtype}{regid}N]);\n"
-                )
-        elif regid not in {"s", "t", "u", "v"}:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "P":
-        if regid == "x":
-            f.write(
-                f"    tcg_gen_mov_tl({regtype}{regid}V, "
-                f"hex_pred[{regtype}{regid}N]);\n"
-            )
-        elif regid not in {"s", "t", "u", "v"}:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "C":
-        if regid == "ss":
-            f.write(
-                f"    gen_read_ctrl_reg_pair(ctx, {regtype}{regid}N, "
-                f"{regtype}{regid}V);\n"
-            )
-        elif regid == "s":
-            f.write(
-                f"    gen_read_ctrl_reg(ctx, {regtype}{regid}N, "
-                f"{regtype}{regid}V);\n"
-            )
-        else:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "M":
-        if regid != "u":
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "V":
-        if regid in {"uu", "vv", "xx"}:
-            f.write(f"    tcg_gen_gvec_mov(MO_64, {regtype}{regid}V_off,\n")
-            f.write(f"        vreg_src_off(ctx, {regtype}{regid}N),\n")
-            f.write("        sizeof(MMVector), sizeof(MMVector));\n")
-            f.write("    tcg_gen_gvec_mov(MO_64,\n")
-            f.write(f"        {regtype}{regid}V_off + sizeof(MMVector),\n")
-            f.write(f"        vreg_src_off(ctx, {regtype}{regid}N ^ 1),\n")
-            f.write("        sizeof(MMVector), sizeof(MMVector));\n")
-        elif regid in {"s", "u", "v", "w"}:
-            if not hex_common.skip_qemu_helper(tag):
-                f.write(
-                    f"    tcg_gen_addi_ptr({regtype}{regid}V, tcg_env, "
-                    f"{regtype}{regid}V_off);\n"
-                )
-        elif regid in {"x", "y"}:
-            f.write(f"    tcg_gen_gvec_mov(MO_64, {regtype}{regid}V_off,\n")
-            f.write(f"        vreg_src_off(ctx, {regtype}{regid}N),\n")
-            f.write("        sizeof(MMVector), sizeof(MMVector));\n")
-        else:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "Q":
-        if regid in {"s", "t", "u", "v"}:
-            if not hex_common.skip_qemu_helper(tag):
-                f.write(
-                    f"    tcg_gen_addi_ptr({regtype}{regid}V, tcg_env, "
-                    f"{regtype}{regid}V_off);\n"
-                )
-        elif regid in {"x"}:
-            f.write(f"    tcg_gen_gvec_mov(MO_64, {regtype}{regid}V_off,\n")
-            f.write(
-                f"        offsetof(CPUHexagonState, " f"QRegs[{regtype}{regid}N]),\n"
-            )
-            f.write("        sizeof(MMQReg), sizeof(MMQReg));\n")
-        else:
-            hex_common.bad_register(regtype, regid)
-    else:
-        hex_common.bad_register(regtype, regid)
-
-
-def genptr_src_read_new(f, regtype, regid):
-    if regtype == "N":
-        if regid not in {"s", "t"}:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "P":
-        if regid not in {"t", "u", "v"}:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "O":
-        if regid != "s":
-            hex_common.bad_register(regtype, regid)
-    else:
-        hex_common.bad_register(regtype, regid)
-
-
-def genptr_src_read_opn(f, regtype, regid, tag):
-    if hex_common.is_pair(regid):
-        genptr_src_read(f, tag, regtype, regid)
-    elif hex_common.is_single(regid):
-        if hex_common.is_old_val(regtype, regid, tag):
-            genptr_src_read(f, tag, regtype, regid)
-        elif hex_common.is_new_val(regtype, regid, tag):
-            genptr_src_read_new(f, regtype, regid)
-        else:
-            hex_common.bad_register(regtype, regid)
-    else:
-        hex_common.bad_register(regtype, regid)
-
-
-def gen_helper_call_opn(f, tag, regtype, regid, i):
-    if i > 0:
-        f.write(", ")
-    if hex_common.is_pair(regid):
-        f.write(f"{regtype}{regid}V")
-    elif hex_common.is_single(regid):
-        if hex_common.is_old_val(regtype, regid, tag):
-            f.write(f"{regtype}{regid}V")
-        elif hex_common.is_new_val(regtype, regid, tag):
-            f.write(f"{regtype}{regid}N")
-        else:
-            hex_common.bad_register(regtype, regid)
-    else:
-        hex_common.bad_register(regtype, regid)
-
-
-def gen_helper_decl_imm(f, immlett):
-    f.write(
-        f"    TCGv tcgv_{hex_common.imm_name(immlett)} = "
-        f"tcg_constant_tl({hex_common.imm_name(immlett)});\n"
-    )
-
-
-def gen_helper_call_imm(f, immlett):
-    f.write(f", tcgv_{hex_common.imm_name(immlett)}")
-
-
-def genptr_dst_write_pair(f, tag, regtype, regid):
-    f.write(f"    gen_log_reg_write_pair(ctx, {regtype}{regid}N, "
-            f"{regtype}{regid}V);\n")
-
-
-def genptr_dst_write(f, tag, regtype, regid):
-    if regtype == "R":
-        if regid in {"dd", "xx", "yy"}:
-            genptr_dst_write_pair(f, tag, regtype, regid)
-        elif regid in {"d", "e", "x", "y"}:
-            f.write(
-                f"    gen_log_reg_write(ctx, {regtype}{regid}N, "
-                f"{regtype}{regid}V);\n"
-            )
-        else:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "P":
-        if regid in {"d", "e", "x"}:
-            f.write(
-                f"    gen_log_pred_write(ctx, {regtype}{regid}N, "
-                f"{regtype}{regid}V);\n"
-            )
-        else:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "C":
-        if regid == "dd":
-            f.write(
-                f"    gen_write_ctrl_reg_pair(ctx, {regtype}{regid}N, "
-                f"{regtype}{regid}V);\n"
-            )
-        elif regid == "d":
-            f.write(
-                f"    gen_write_ctrl_reg(ctx, {regtype}{regid}N, "
-                f"{regtype}{regid}V);\n"
-            )
-        else:
-            hex_common.bad_register(regtype, regid)
-    else:
-        hex_common.bad_register(regtype, regid)
-
-
-def genptr_dst_write_ext(f, tag, regtype, regid, newv="EXT_DFL"):
-    if regtype == "V":
-        if regid in {"xx"}:
-            f.write(
-                f"    gen_log_vreg_write_pair(ctx, {regtype}{regid}V_off, "
-                f"{regtype}{regid}N, {newv});\n"
-            )
-        elif regid in {"y"}:
-            f.write(
-                f"    gen_log_vreg_write(ctx, {regtype}{regid}V_off, "
-                f"{regtype}{regid}N, {newv});\n"
-            )
-        elif regid not in {"dd", "d", "x"}:
-            hex_common.bad_register(regtype, regid)
-    elif regtype == "Q":
-        if regid not in {"d", "e", "x"}:
-            hex_common.bad_register(regtype, regid)
-    else:
-        hex_common.bad_register(regtype, regid)
-
-
-def genptr_dst_write_opn(f, regtype, regid, tag):
-    if hex_common.is_pair(regid):
-        if hex_common.is_hvx_reg(regtype):
-            if hex_common.is_tmp_result(tag):
-                genptr_dst_write_ext(f, tag, regtype, regid, "EXT_TMP")
-            else:
-                genptr_dst_write_ext(f, tag, regtype, regid)
-        else:
-            genptr_dst_write(f, tag, regtype, regid)
-    elif hex_common.is_single(regid):
-        if hex_common.is_hvx_reg(regtype):
-            if hex_common.is_new_result(tag):
-                genptr_dst_write_ext(f, tag, regtype, regid, "EXT_NEW")
-            elif hex_common.is_tmp_result(tag):
-                genptr_dst_write_ext(f, tag, regtype, regid, "EXT_TMP")
-            else:
-                genptr_dst_write_ext(f, tag, regtype, regid, "EXT_DFL")
-        else:
-            genptr_dst_write(f, tag, regtype, regid)
-    else:
-        hex_common.bad_register(regtype, regid)
-
-
 ##
 ## Generate the TCG code to call the helper
 ##     For A2_add: Rd32=add(Rs32,Rt32), { RdV=RsV+RtV;}
@@ -496,44 +48,27 @@ def gen_tcg_func(f, tag, regs, imms):
     f.write(f"static void generate_{tag}(DisasContext *ctx)\n")
     f.write("{\n")
 
-    f.write("    Insn *insn __attribute__((unused)) = ctx->insn;\n")
+    f.write("    Insn *insn G_GNUC_UNUSED = ctx->insn;\n")
 
     if hex_common.need_ea(tag):
-        gen_decl_ea_tcg(f, tag)
-    i = 0
+        f.write("    TCGv EA G_GNUC_UNUSED = tcg_temp_new();\n")
+
     ## Declare all the operands (regs and immediates)
+    i = 0
     for regtype, regid in regs:
-        genptr_decl_opn(f, tag, regtype, regid, i)
+        reg = hex_common.get_register(tag, regtype, regid)
+        reg.genptr_decl(f, tag, i)
         i += 1
     for immlett, bits, immshift in imms:
-        genptr_decl_imm(f, immlett)
-
-    if "A_PRIV" in hex_common.attribdict[tag]:
-        f.write("    fCHECKFORPRIV();\n")
-    if "A_GUEST" in hex_common.attribdict[tag]:
-        f.write("    fCHECKFORGUEST();\n")
-
-    ## Read all the inputs
-    for regtype, regid in regs:
-        if hex_common.is_read(regid):
-            genptr_src_read_opn(f, regtype, regid, tag)
+        i = 1 if immlett.isupper() else 0
+        f.write(f"    int {hex_common.imm_name(immlett)} = insn->immed[{i}];\n")
 
     if hex_common.is_idef_parser_enabled(tag):
         declared = []
         ## Handle registers
         for regtype, regid in regs:
-            if hex_common.is_pair(regid) or (
-                hex_common.is_single(regid)
-                and hex_common.is_old_val(regtype, regid, tag)
-            ):
-                declared.append(f"{regtype}{regid}V")
-                if regtype == "M":
-                    declared.append(f"{regtype}{regid}N")
-            elif hex_common.is_new_val(regtype, regid, tag):
-                declared.append(f"{regtype}{regid}N")
-            else:
-                hex_common.bad_register(regtype, regid)
-
+            reg = hex_common.get_register(tag, regtype, regid)
+            reg.idef_arg(declared)
         ## Handle immediates
         for immlett, bits, immshift in imms:
             declared.append(hex_common.imm_name(immlett))
@@ -545,76 +80,56 @@ def gen_tcg_func(f, tag, regs, imms):
         f.write(f"    fGEN_TCG_{tag}({hex_common.semdict[tag]});\n")
     else:
         ## Generate the call to the helper
-        for immlett, bits, immshift in imms:
-            gen_helper_decl_imm(f, immlett)
-        if hex_common.need_pkt_has_multi_cof(tag):
-            f.write("    TCGv pkt_has_multi_cof = ")
-            f.write("tcg_constant_tl(ctx->pkt->pkt_has_multi_cof);\n")
-        if hex_common.need_pkt_need_commit(tag):
-            f.write("    TCGv pkt_need_commit = ")
-            f.write("tcg_constant_tl(ctx->need_commit);\n")
-        if hex_common.need_part1(tag):
-            f.write("    TCGv part1 = tcg_constant_tl(insn->part1);\n")
-        if hex_common.need_slot(tag):
-            f.write("    TCGv slotval = gen_slotval(ctx);\n")
-        if hex_common.need_PC(tag):
-            f.write("    TCGv PC = tcg_constant_tl(ctx->pkt->pc);\n")
-        if hex_common.helper_needs_next_PC(tag):
-            f.write("    TCGv next_PC = tcg_constant_tl(ctx->next_PC);\n")
-        f.write(f"    gen_helper_{tag}(")
-        i = 0
+        declared = []
         ## If there is a scalar result, it is the return type
         for regtype, regid in regs:
-            if hex_common.is_written(regid):
-                if hex_common.is_hvx_reg(regtype):
-                    continue
-                gen_helper_call_opn(f, tag, regtype, regid, i)
-                i += 1
-        if i > 0:
-            f.write(", ")
-        f.write("tcg_env")
-        i = 1
+            reg = hex_common.get_register(tag, regtype, regid)
+            if reg.is_written() and not reg.is_hvx_reg():
+                declared.append(reg.regV)
+        declared.append("tcg_env")
+
         ## For conditional instructions, we pass in the destination register
         if "A_CONDEXEC" in hex_common.attribdict[tag]:
             for regtype, regid in regs:
-                if hex_common.is_writeonly(regid) and not hex_common.is_hvx_reg(
-                    regtype
-                ):
-                    gen_helper_call_opn(f, tag, regtype, regid, i)
-                    i += 1
+                reg = hex_common.get_register(tag, regtype, regid)
+                if reg.is_writeonly() and not reg.is_hvx_reg():
+                    declared.append(reg.regV)
+        ## Pass the HVX destination registers
         for regtype, regid in regs:
-            if hex_common.is_written(regid):
-                if not hex_common.is_hvx_reg(regtype):
-                    continue
-                gen_helper_call_opn(f, tag, regtype, regid, i)
-                i += 1
+            reg = hex_common.get_register(tag, regtype, regid)
+            if reg.is_written() and reg.is_hvx_reg():
+                declared.append(reg.regV)
+        ## Pass the source registers
         for regtype, regid in regs:
-            if hex_common.is_read(regid):
-                if hex_common.is_hvx_reg(regtype) and hex_common.is_readwrite(regid):
-                    continue
-                gen_helper_call_opn(f, tag, regtype, regid, i)
-                i += 1
+            reg = hex_common.get_register(tag, regtype, regid)
+            if reg.is_read() and not (reg.is_hvx_reg() and reg.is_readwrite()):
+                declared.append(reg.regV)
+        ## Pass the immediates
         for immlett, bits, immshift in imms:
-            gen_helper_call_imm(f, immlett)
+            declared.append(f"tcg_constant_tl({hex_common.imm_name(immlett)})")
 
+        ## Other stuff the helper might need
         if hex_common.need_pkt_has_multi_cof(tag):
-            f.write(", pkt_has_multi_cof")
+            declared.append("tcg_constant_tl(ctx->pkt->pkt_has_multi_cof)")
         if hex_common.need_pkt_need_commit(tag):
-            f.write(", pkt_need_commit")
+            declared.append("tcg_constant_tl(ctx->need_commit)")
         if hex_common.need_PC(tag):
-            f.write(", PC")
+            declared.append("tcg_constant_tl(ctx->pkt->pc)")
         if hex_common.helper_needs_next_PC(tag):
-            f.write(", next_PC")
+            declared.append("tcg_constant_tl(ctx->next_PC)")
         if hex_common.need_slot(tag):
-            f.write(", slotval")
+            declared.append("gen_slotval(ctx)")
         if hex_common.need_part1(tag):
-            f.write(", part1")
-        f.write(");\n")
+            declared.append("tcg_constant_tl(insn->part1)")
+
+        arguments = ", ".join(declared)
+        f.write(f"    gen_helper_{tag}({arguments});\n")
 
     ## Write all the outputs
     for regtype, regid in regs:
         if hex_common.is_written(regid):
-            genptr_dst_write_opn(f, regtype, regid, tag)
+            reg = hex_common.registers[f"{regtype}{regid}"]
+            reg.genptr_dst_write(f, tag)
 
     f.write("}\n\n")
 
@@ -632,6 +147,7 @@ def main():
     hex_common.read_overrides_file(sys.argv[3])
     hex_common.read_overrides_file(sys.argv[4])
     hex_common.calculate_attribs()
+    hex_common.init_registers()
     ## Whether or not idef-parser is enabled is
     ## determined by the number of arguments to
     ## this script:
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 0da65d6dd6..13ee55b6b2 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -26,6 +26,8 @@
 attribdict = {}  # tag -> attributes
 macros = {}  # macro -> macro information...
 attribinfo = {}  # Register information and misc
+registers = {}  # register -> register functions
+new_registers = {}
 tags = []  # list of all tags
 overrides = {}  # tags with helper overrides
 idef_parser_enabled = {}  # tags enabled for idef-parser
@@ -350,3 +352,468 @@ def read_idef_parser_enabled_file(name):
     with open(name, "r") as idef_parser_enabled_file:
         lines = idef_parser_enabled_file.read().strip().split("\n")
         idef_parser_enabled = set(lines)
+
+
+def hvx_newv(tag):
+    if is_new_result(tag):
+        return "EXT_NEW"
+    elif is_tmp_result(tag):
+        return "EXT_TMP"
+    else:
+        return "EXT_DFL"
+
+class Register:
+    def __init__(self, regtype, regid):
+        self.regtype = regtype
+        self.regid = regid
+        self.regN = f"{regtype}{regid}N"
+        self.regV = f"{regtype}{regid}V"
+    def is_scalar_reg(self):
+        return True
+    def is_hvx_reg(self):
+        return False
+    def idef_arg(self, declared):
+        declared.append(self.regV)
+
+class Dest(Register):
+    def is_written(self):
+        return True
+    def is_writeonly(self):
+        return True
+    def is_read(self):
+        return False
+    def is_readwrite(self):
+        return False
+
+class Source(Register):
+    def is_written(self):
+        return False
+    def is_writeonly(self):
+        return False
+    def is_read(self):
+        return True
+    def is_readwrite(self):
+        return False
+
+class ReadWrite(Register):
+    def is_written(self):
+        return True
+    def is_writeonly(self):
+        return False
+    def is_read(self):
+        return True
+    def is_readwrite(self):
+        return True
+
+class GprDest(Dest):
+    def genptr_decl(self, f, tag, regno):
+        f.write(f"    const int {self.regN} = insn->regno[{regno}];\n")
+        f.write(f"    TCGv {self.regV} = get_result_gpr(ctx, {self.regN});\n")
+    def genptr_dst_write(self, f, tag):
+        f.write(f"    gen_log_reg_write(ctx, {self.regN}, {self.regV});\n")
+
+class GprSource(Source):
+    def genptr_decl(self, f, tag, regno):
+        f.write(f"    const int {self.regN} = insn->regno[{regno}];\n")
+        f.write(f"    TCGv {self.regV} = hex_gpr[{self.regN}];\n")
+
+class GprNewSource(Source):
+    def genptr_decl(self, f, tag, regno):
+        self.regV = self.regN
+        f.write(
+            f"    TCGv {self.regV} = "
+            f"get_result_gpr(ctx, insn->regno[{regno}]);\n"
+        )
+
+class GprReadWrite(ReadWrite):
+    def genptr_decl(self, f, tag, regno):
+        f.write(f"    const int {self.regN} = insn->regno[{regno}];\n")
+        f.write(f"    TCGv {self.regV} = get_result_gpr(ctx, {self.regN});\n")
+        ## For read/write registers, we need to get the original value into
+        ## the result TCGv.  For conditional instructions, this is done in
+        ## gen_start_packet.  For unconditional instructions, we do it here.
+        if "A_CONDEXEC" not in attribdict[tag]:
+            f.write(f"    tcg_gen_mov_tl({self.regV}, hex_gpr[{self.regN}]);\n")
+    def genptr_dst_write(self, f, tag):
+        f.write(f"    gen_log_reg_write(ctx, {self.regN}, {self.regV});\n")
+
+class ControlDest(Dest):
+    def genptr_decl(self, f, tag, regno):
+        f.write(
+            f"    const int {self.regN} = "
+            f"insn->regno[{regno}]  + HEX_REG_SA0;\n"
+        )
+        f.write(f"    TCGv {self.regV} = get_result_gpr(ctx, {self.regN});\n")
+    def genptr_dst_write(self, f, tag):
+        f.write(f"    gen_write_ctrl_reg(ctx, {self.regN}, {self.regV});\n")
+
+class ControlSource(Source):
+    def genptr_decl(self, f, tag, regno):
+        f.write(
+            f"    const int {self.regN} = "
+            f"insn->regno[{regno}] + HEX_REG_SA0;\n"
+        )
+        f.write(f"    TCGv {self.regV} = tcg_temp_new();\n")
+        f.write(f"    gen_read_ctrl_reg(ctx, {self.regN}, {self.regV});\n")
+
+class ModifierSource(Source):
+    def genptr_decl(self, f, tag, regno):
+        f.write(f"    const int {self.regN} = insn->regno[{regno}];\n")
+        f.write(f"    TCGv {self.regV} = hex_gpr[{self.regN} + HEX_REG_M0];\n")
+    def idef_arg(self, declared):
+        declared.append(self.regV)
+        declared.append(self.regN)
+
+class PredDest(Dest):
+    def genptr_decl(self, f, tag, regno):
+        f.write(f"    const int {self.regN} = insn->regno[{regno}];\n")
+        f.write(f"    TCGv {self.regV} = tcg_temp_new();\n")
+    def genptr_dst_write(self, f, tag):
+        f.write(f"    gen_log_pred_write(ctx, {self.regN}, {self.regV});\n")
+
+class PredSource(Source):
+    def genptr_decl(self, f, tag, regno):
+        f.write(f"    const int {self.regN} = insn->regno[{regno}];\n")
+        f.write(f"    TCGv {self.regV} = hex_pred[{self.regN}];\n")
+
+class PredNewSource(Source):
+    def genptr_decl(self, f, tag, regno):
+        self.regV = self.regN
+        f.write(
+            f"    TCGv {self.regV} = "
+            f"get_result_pred(ctx, insn->regno[{regno}]);\n"
+        )
+
+class PredReadWrite(ReadWrite):
+    def genptr_decl(self, f, tag, regno):
+        f.write(f"    const int {self.regN} = insn->regno[{regno}];\n")
+        f.write(f"    TCGv {self.regV} = tcg_temp_new();\n")
+        f.write(f"    tcg_gen_mov_tl({self.regV}, hex_pred[{self.regN}]);\n")
+    def genptr_dst_write(self, f, tag):
+        f.write(f"    gen_log_pred_write(ctx, {self.regN}, {self.regV});\n")
+
+class PairDest(Dest):
+    def genptr_decl(self, f, tag, regno):
+        f.write(f"    const int {self.regN} = insn->regno[{regno}];\n")
+        f.write(
+            f"    TCGv_i64 {self.regV} = "
+            f"get_result_gpr_pair(ctx, {self.regN});\n"
+        )
+    def genptr_dst_write(self, f, tag):
+        f.write(f"    gen_log_reg_write_pair(ctx, {self.regN}, {self.regV});\n")
+
+class PairSource(Source):
+    def genptr_decl(self, f, tag, regno):
+        f.write(f"    const int {self.regN} = insn->regno[{regno}];\n")
+        f.write(f"    TCGv_i64 {self.regV} = tcg_temp_new_i64();\n")
+        f.write(f"    tcg_gen_concat_i32_i64({self.regV},\n")
+        f.write(f"        hex_gpr[{self.regN}],\n")
+        f.write(f"        hex_gpr[{self.regN} + 1]);\n")
+
+class PairReadWrite(ReadWrite):
+    def genptr_decl(self, f, tag, regno):
+        f.write(f"    const int {self.regN} = insn->regno[{regno}];\n")
+        f.write(
+            f"    TCGv_i64 {self.regV} = "
+            f"get_result_gpr_pair(ctx, {self.regN});\n"
+        )
+        f.write(f"    tcg_gen_concat_i32_i64({self.regV},\n")
+        f.write(f"        hex_gpr[{self.regN}],\n")
+        f.write(f"        hex_gpr[{self.regN} + 1]);\n")
+    def genptr_dst_write(self, f, tag):
+        f.write(f"    gen_log_reg_write_pair(ctx, {self.regN}, {self.regV});\n")
+
+class ControlPairDest(Dest):
+    def genptr_decl(self, f, tag, regno):
+        f.write(
+            f"    const int {self.regN} = "
+            f"insn->regno[{regno}] + HEX_REG_SA0;\n"
+        )
+        f.write(
+            f"    TCGv_i64 {self.regV} = "
+            f"get_result_gpr_pair(ctx, {self.regN});\n"
+        )
+    def genptr_dst_write(self, f, tag):
+        f.write(
+            f"    gen_write_ctrl_reg_pair(ctx, {self.regN}, {self.regV});\n"
+        )
+
+class ControlPairSource(Source):
+    def genptr_decl(self, f, tag, regno):
+        f.write(
+            f"    const int {self.regN} = "
+            f"insn->regno[{regno}] + HEX_REG_SA0;\n"
+        )
+        f.write(f"    TCGv_i64 {self.regV} = tcg_temp_new_i64();\n")
+        f.write(f"    gen_read_ctrl_reg_pair(ctx, {self.regN}, {self.regV});\n")
+
+class HvxDest(Dest):
+    def is_scalar_reg(self):
+        return False
+    def is_hvx_reg(self):
+        return True
+
+class HvxSource(Source):
+    def is_scalar_reg(self):
+        return False
+    def is_hvx_reg(self):
+        return True
+
+class HvxReadWrite(ReadWrite):
+    def is_scalar_reg(self):
+        return False
+    def is_hvx_reg(self):
+        return True
+
+class VRegDest(HvxDest):
+    def genptr_decl(self, f, tag, regno):
+        f.write(f"    const int {self.regN} = " f"insn->regno[{regno}];\n")
+        f.write(f"    const intptr_t {self.regV}_off =\n")
+        if is_tmp_result(tag):
+            f.write(f"        ctx_tmp_vreg_off(ctx, {self.regN}, 1, true);\n")
+        else:
+            f.write(
+                f"        ctx_future_vreg_off(ctx, {self.regN}, 1, true);\n"
+            )
+        if not skip_qemu_helper(tag):
+            f.write(f"    TCGv_ptr {self.regV} = " "tcg_temp_new_ptr();\n")
+            f.write(
+                f"    tcg_gen_addi_ptr({self.regV}, tcg_env, "
+                f"{self.regV}_off);\n"
+            )
+    def genptr_dst_write(self, f, tag):
+        pass
+
+class VRegSource(HvxSource):
+    def genptr_decl(self, f, tag, regno):
+        f.write(f"    const int {self.regN} = insn->regno[{regno}];\n")
+        f.write(f"    const intptr_t {self.regV}_off =\n")
+        f.write(f"        vreg_src_off(ctx, {self.regN});\n")
+        if not skip_qemu_helper(tag):
+            f.write(f"    TCGv_ptr {self.regV} = " "tcg_temp_new_ptr();\n")
+            f.write(
+                f"    tcg_gen_addi_ptr({self.regV}, tcg_env, "
+                f"{self.regV}_off);\n"
+            )
+
+class VRegNewSource(HvxSource):
+    def genptr_decl(self, f, tag, regno):
+        f.write(f"    const intptr_t {self.regN}_num = insn->regno[{regno}];\n")
+        if skip_qemu_helper(tag):
+            f.write(f"    const intptr_t {self.regN}_off =\n")
+            f.write(
+                f"         ctx_future_vreg_off(ctx, {self.regN}_num, "
+                f"1, true);\n"
+            )
+        else:
+            f.write(
+                f"    TCGv {self.regN} = tcg_constant_tl({self.regN}_num);\n"
+            )
+
+class VRegReadWrite(HvxReadWrite):
+    def genptr_decl(self, f, tag, regno):
+        f.write(f"    const int {self.regN} = " f"insn->regno[{regno}];\n")
+        f.write(f"    const intptr_t {self.regV}_off =\n")
+        if is_tmp_result(tag):
+            f.write(f"        ctx_tmp_vreg_off(ctx, {self.regN}, 1, true);\n")
+        else:
+            f.write(
+                f"        ctx_future_vreg_off(ctx, {self.regN}, 1, true);\n"
+            )
+        if not skip_qemu_helper(tag):
+            f.write(f"    TCGv_ptr {self.regV} = " "tcg_temp_new_ptr();\n")
+            f.write(
+                f"    tcg_gen_addi_ptr({self.regV}, tcg_env, "
+                f"{self.regV}_off);\n"
+            )
+        f.write(f"    tcg_gen_gvec_mov(MO_64, {self.regV}_off,\n")
+        f.write(f"        vreg_src_off(ctx, {self.regN}),\n")
+        f.write("        sizeof(MMVector), sizeof(MMVector));\n")
+    def genptr_dst_write(self, f, tag):
+        pass
+
+class VRegTmp(HvxReadWrite):
+    def genptr_decl(self, f, tag, regno):
+        f.write(f"    const int {self.regN} = " f"insn->regno[{regno}];\n")
+        f.write(f"    const intptr_t {self.regV}_off =\n")
+        f.write("        offsetof(CPUHexagonState, vtmp);\n")
+        if not skip_qemu_helper(tag):
+            f.write(f"    TCGv_ptr {self.regV} = " "tcg_temp_new_ptr();\n")
+            f.write(
+                f"    tcg_gen_addi_ptr({self.regV}, tcg_env, "
+                f"{self.regV}_off);\n"
+            )
+        f.write(f"    tcg_gen_gvec_mov(MO_64, {self.regV}_off,\n")
+        f.write(f"        vreg_src_off(ctx, {self.regN}),\n")
+        f.write(f"        sizeof(MMVector), sizeof(MMVector));\n")
+    def genptr_dst_write(self, f, tag):
+        f.write(
+            f"    gen_log_vreg_write(ctx, {self.regV}_off, {self.regN}, "
+            f"{hvx_newv(tag)});\n"
+        )
+
+class VRegPairDest(HvxDest):
+    def genptr_decl(self, f, tag, regno):
+        f.write(f"    const int {self.regN} =  insn->regno[{regno}];\n")
+        f.write(f"    const intptr_t {self.regV}_off =\n")
+        if is_tmp_result(tag):
+            f.write(
+                f"        ctx_tmp_vreg_off(ctx, {self.regN}, 2, " "true);\n"
+            )
+        else:
+            f.write(
+                f"        ctx_future_vreg_off(ctx, {self.regN}, 2, true);\n"
+            )
+        if not skip_qemu_helper(tag):
+            f.write(f"    TCGv_ptr {self.regV} = tcg_temp_new_ptr();\n")
+            f.write(
+                f"    tcg_gen_addi_ptr({self.regV}, tcg_env, "
+                f"{self.regV}_off);\n"
+            )
+    def genptr_dst_write(self, f, tag):
+        pass
+
+class VRegPairSource(HvxSource):
+    def genptr_decl(self, f, tag, regno):
+        f.write(f"    const int {self.regN} = insn->regno[{regno}];\n")
+        f.write(f"    const intptr_t {self.regV}_off =\n")
+        f.write(f"        offsetof(CPUHexagonState, {self.regV});\n")
+        if not skip_qemu_helper(tag):
+            f.write(f"    TCGv_ptr {self.regV} = " "tcg_temp_new_ptr();\n")
+            f.write(
+                f"    tcg_gen_addi_ptr({self.regV}, tcg_env, "
+                f"{self.regV}_off);\n"
+            )
+        f.write(f"    tcg_gen_gvec_mov(MO_64, {self.regV}_off,\n")
+        f.write(f"        vreg_src_off(ctx, {self.regN}),\n")
+        f.write("        sizeof(MMVector), sizeof(MMVector));\n")
+        f.write("    tcg_gen_gvec_mov(MO_64,\n")
+        f.write(f"        {self.regV}_off + sizeof(MMVector),\n")
+        f.write(f"        vreg_src_off(ctx, {self.regN} ^ 1),\n")
+        f.write("        sizeof(MMVector), sizeof(MMVector));\n")
+
+class VRegPairReadWrite(HvxReadWrite):
+    def genptr_decl(self, f, tag, regno):
+        f.write(f"    const int {self.regN} = insn->regno[{regno}];\n")
+        f.write(f"    const intptr_t {self.regV}_off =\n")
+        f.write(f"        offsetof(CPUHexagonState, {self.regV});\n")
+        if not skip_qemu_helper(tag):
+            f.write(f"    TCGv_ptr {self.regV} = " "tcg_temp_new_ptr();\n")
+            f.write(
+                f"    tcg_gen_addi_ptr({self.regV}, tcg_env, "
+                f"{self.regV}_off);\n"
+            )
+        f.write(f"    tcg_gen_gvec_mov(MO_64, {self.regV}_off,\n")
+        f.write(f"        vreg_src_off(ctx, {self.regN}),\n")
+        f.write("        sizeof(MMVector), sizeof(MMVector));\n")
+        f.write("    tcg_gen_gvec_mov(MO_64,\n")
+        f.write(f"        {self.regV}_off + sizeof(MMVector),\n")
+        f.write(f"        vreg_src_off(ctx, {self.regN} ^ 1),\n")
+        f.write("        sizeof(MMVector), sizeof(MMVector));\n")
+    def genptr_dst_write(self, f, tag):
+        f.write(
+            f"    gen_log_vreg_write_pair(ctx, {self.regV}_off, {self.regN}, "
+            f"{hvx_newv(tag)});\n"
+        )
+
+class QRegDest(HvxDest):
+    def genptr_decl(self, f, tag, regno):
+        f.write(f"    const int {self.regN} = insn->regno[{regno}];\n")
+        f.write(f"    const intptr_t {self.regV}_off =\n")
+        f.write(f"        get_result_qreg(ctx, {self.regN});\n")
+        if not skip_qemu_helper(tag):
+            f.write(f"    TCGv_ptr {self.regV} = " "tcg_temp_new_ptr();\n")
+            f.write(
+                f"    tcg_gen_addi_ptr({self.regV}, tcg_env, "
+                f"{self.regV}_off);\n"
+            )
+    def genptr_dst_write(self, f, tag):
+        pass
+
+class QRegSource(HvxSource):
+    def genptr_decl(self, f, tag, regno):
+        f.write(f"    const int {self.regN} = insn->regno[{regno}];\n")
+        f.write(f"    const intptr_t {self.regV}_off =\n")
+        f.write(f"        offsetof(CPUHexagonState, QRegs[{self.regN}]);\n")
+        if not skip_qemu_helper(tag):
+            f.write(f"    TCGv_ptr {self.regV} = " "tcg_temp_new_ptr();\n")
+            f.write(
+                f"    tcg_gen_addi_ptr({self.regV}, tcg_env, "
+                f"{self.regV}_off);\n"
+            )
+
+class QRegReadWrite(HvxReadWrite):
+    def genptr_decl(self, f, tag, regno):
+        f.write(f"    const int {self.regN} = insn->regno[{regno}];\n")
+        f.write(f"    const intptr_t {self.regV}_off =\n")
+        f.write(f"        get_result_qreg(ctx, {self.regN});\n")
+        if not skip_qemu_helper(tag):
+            f.write(f"    TCGv_ptr {self.regV} = " "tcg_temp_new_ptr();\n")
+            f.write(
+                f"    tcg_gen_addi_ptr({self.regV}, tcg_env, "
+                f"{self.regV}_off);\n"
+            )
+        f.write(f"    tcg_gen_gvec_mov(MO_64, {self.regV}_off,\n")
+        f.write(f"        offsetof(CPUHexagonState, QRegs[{self.regN}]),\n")
+        f.write("        sizeof(MMQReg), sizeof(MMQReg));\n")
+    def genptr_dst_write(self, f, tag):
+        pass
+
+def init_registers():
+    registers["Rd"] = GprDest("R", "d")
+    registers["Re"] = GprDest("R", "e")
+    registers["Rs"] = GprSource("R", "s")
+    registers["Rt"] = GprSource("R", "t")
+    registers["Ru"] = GprSource("R", "u")
+    registers["Rv"] = GprSource("R", "v")
+    registers["Rx"] = GprReadWrite("R", "x")
+    registers["Ry"] = GprReadWrite("R", "y")
+    registers["Cd"] = ControlDest("C", "d")
+    registers["Cs"] = ControlSource("C", "s")
+    registers["Mu"] = ModifierSource("M", "u")
+    registers["Pd"] = PredDest("P", "d")
+    registers["Pe"] = PredDest("P", "e")
+    registers["Ps"] = PredSource("P", "s")
+    registers["Pt"] = PredSource("P", "t")
+    registers["Pu"] = PredSource("P", "u")
+    registers["Pv"] = PredSource("P", "v")
+    registers["Px"] = PredReadWrite("P", "x")
+    registers["Rdd"] = PairDest("R", "dd")
+    registers["Ree"] = PairDest("R", "ee")
+    registers["Rss"] = PairSource("R", "ss")
+    registers["Rtt"] = PairSource("R", "tt")
+    registers["Rxx"] = PairReadWrite("R", "xx")
+    registers["Ryy"] = PairReadWrite("R", "yy")
+    registers["Cdd"] = ControlPairDest("C", "dd")
+    registers["Css"] = ControlPairSource("C", "ss")
+    registers["Vd"] = VRegDest("V", "d")
+    registers["Vs"] = VRegSource("V", "s")
+    registers["Vu"] = VRegSource("V", "u")
+    registers["Vv"] = VRegSource("V", "v")
+    registers["Vw"] = VRegSource("V", "w")
+    registers["Vx"] = VRegReadWrite("V", "x")
+    registers["Vy"] = VRegTmp("V", "y")
+    registers["Vdd"] = VRegPairDest("V", "dd")
+    registers["Vuu"] = VRegPairSource("V", "uu")
+    registers["Vvv"] = VRegPairSource("V", "vv")
+    registers["Vxx"] = VRegPairReadWrite("V", "xx")
+    registers["Qd"] = QRegDest("Q", "d")
+    registers["Qe"] = QRegDest("Q", "e")
+    registers["Qs"] = QRegSource("Q", "s")
+    registers["Qt"] = QRegSource("Q", "t")
+    registers["Qu"] = QRegSource("Q", "u")
+    registers["Qv"] = QRegSource("Q", "v")
+    registers["Qx"] = QRegReadWrite("Q", "x")
+
+    new_registers["Ns"] = GprNewSource("N", "s")
+    new_registers["Nt"] = GprNewSource("N", "t")
+    new_registers["Pt"] = PredNewSource("P", "t")
+    new_registers["Pu"] = PredNewSource("P", "u")
+    new_registers["Pv"] = PredNewSource("P", "v")
+    new_registers["Os"] = VRegNewSource("O", "s")
+
+def get_register(tag, regtype, regid):
+    if is_old_val(regtype, regid, tag):
+        return registers[f"{regtype}{regid}"]
+    else:
+        return new_registers[f"{regtype}{regid}"]
-- 
2.34.1


