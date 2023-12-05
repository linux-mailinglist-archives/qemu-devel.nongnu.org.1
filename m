Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEC1804458
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 02:54:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAKci-0002qK-Bv; Mon, 04 Dec 2023 20:53:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rAKcc-0002p5-Pw
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 20:53:15 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rAKcY-0005x5-Ms
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 20:53:14 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3b837d974ecso3198613b6e.2
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 17:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701741189; x=1702345989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24pEnwDt6uLfYfe0FgSUc7UJUxnoPQjRWbNyko2zIi4=;
 b=PAW4omeELo8WCUCjS8tiQFNJ2GsJ7KfNuD3Rvrfvh19JF9BaPM+GTx5/u7TKCGXWnG
 TZo/FL7iNw+NpTfyiZZ3IGXBx/pfO/KwU3zF1deXQJNSRnkIoDmx3TyWOFaijeliB2ez
 1lXB/Z/jwyjeybAGvVszPY1r1wwowHDNazvmo4bZwVvXPYf47Xn4p70FaytONJ0Vx+k+
 YPvDo5T9MJBSmwmyH+k1gK/imhgv1jKOKw87ZgrDu2hlmdMCTnn2u8gR5lYQSCuuO9Fi
 VoPkx0ndkQVL1NkD+snAhr2Pp4xI9IyfkVxpokJbSoGYPd5KS2ta/k57giQileH324AS
 qGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701741189; x=1702345989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=24pEnwDt6uLfYfe0FgSUc7UJUxnoPQjRWbNyko2zIi4=;
 b=nyUTfXW0kW02rjTfGptoZ3FbXx1PRPZvrXYfDX5zX0Mv0REsgmViq1nc8lUcBYMFbH
 NKYD1VU0FsAk82av/Ch38AYPvvFRvSi3dN0ker4vqyWOFY5Vv1ak3BxkKyKiUCDrmyQW
 KQhS9glNCfw/gVBC3JV6uHgyqS2cpKMH4pwP+8xapWylyutcuUiGwAYqghMBycJODqbf
 f8SF7oSemTjv6yLksn5SOSOdGvx9yO+2pkUh1GRQlUbbzMIZTlawdm/OdpkrGiqa/tVL
 Ut360rrPAdYLwRVgFUXPUyItbnUn6bVq7er0Dkg2ETb4xeI5szRUNmftzV/Df++6Is3u
 5Z6w==
X-Gm-Message-State: AOJu0YymIh0i0jCfd5n2C9Yuv/lbeJRPqzW9FiKeS4Ja3DfGeXQ5RouS
 lfkFJK6utbvduhLoEFdJt43ljLWvkvy69g==
X-Google-Smtp-Source: AGHT+IFPSPSNkXiV2boXe3xOeGTksUi9Q1nmbDCRxUKFfFVm6L3xIzuwcM/pXd2Pq74sdAxSkA7PzA==
X-Received: by 2002:a05:6808:1707:b0:3b8:b063:ae01 with SMTP id
 bc7-20020a056808170700b003b8b063ae01mr6608289oib.94.1701741188573; 
 Mon, 04 Dec 2023 17:53:08 -0800 (PST)
Received: from taylor-ubuntu.austin.rr.com (068-203-008-061.res.spectrum.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 c4-20020aca1c04000000b003b8b7063a44sm1064624oic.44.2023.12.04.17.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 17:53:08 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH 2/9] Hexagon (target/hexagon) Make generators object oriented
 - gen_tcg_funcs
Date: Mon,  4 Dec 2023 18:52:56 -0700
Message-Id: <20231205015303.575807-3-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205015303.575807-1-ltaylorsimpson@gmail.com>
References: <20231205015303.575807-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x230.google.com
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

The generators are generally a bunch of Python if-then-else
statements based on the regtype and regid.  Encapsulate regtype/regid
into a class hierarchy.  Clients lookup the register and invoke
methods.

This has several advantages for making the code easier to read,
understand, and maintain
- The class name makes it more clear what the operand does
- All the methods for a given type of operand are together
- Don't need hex_common.bad_register
  If a regtype/regid is missing, the lookup in hex_common.get_register
  will fail
- We can remove the functions in hex_common that use regtype/regid
  (e.g., is_read)

This patch creates the class hierarchy in hex_common and converts
gen_tcg_funcs.py.  The other scripts will be converted in subsequent
patches in this series.

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/gen_tcg_funcs.py | 583 +++-----------------------------
 target/hexagon/hex_common.py    | 542 +++++++++++++++++++++++++++++
 2 files changed, 589 insertions(+), 536 deletions(-)

diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs.py
index 02d93bc5ce..8c2bc03c10 100755
--- a/target/hexagon/gen_tcg_funcs.py
+++ b/target/hexagon/gen_tcg_funcs.py
@@ -23,466 +23,13 @@
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
-            f.write(
-                f"    const int {regN} = insn->regno[{regno}] + HEX_REG_M0;\n"
-            )
-            f.write(
-                f"    TCGv {regtype}{regid}V = hex_gpr[{regN}];\n"
-            )
-            f.write(
-                f"    TCGv CS G_GNUC_UNUSED = "
-                f"hex_gpr[{regN} - HEX_REG_M0 + HEX_REG_CS0];\n"
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
 ##     We produce:
 ##    static void generate_A2_add(DisasContext *ctx)
 ##    {
-##        Insn *insn __attribute__((unused)) = ctx->insn;
+##        Insn *insn G_GNUC_UNUSED = ctx->insn;
 ##        const int RdN = insn->regno[0];
 ##        TCGv RdV = get_result_gpr(ctx, RdN);
 ##        TCGv RsV = hex_gpr[insn->regno[1]];
@@ -501,44 +48,27 @@ def gen_tcg_func(f, tag, regs, imms):
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
+        reg.decl_tcg(f, tag, i)
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
-                    declared.append("CS")
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
@@ -550,76 +80,56 @@ def gen_tcg_func(f, tag, regs, imms):
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
-        ## For conditional instructions, we pass in the destination register
-        if "A_CONDEXEC" in hex_common.attribdict[tag]:
+            reg = hex_common.get_register(tag, regtype, regid)
+            if reg.is_written() and not reg.is_hvx_reg():
+                declared.append(reg.reg_tcg())
+        declared.append("tcg_env")
+
+        ## For predicated instructions, we pass in the destination register
+        if hex_common.is_predicated(tag):
             for regtype, regid in regs:
-                if hex_common.is_writeonly(regid) and not hex_common.is_hvx_reg(
-                    regtype
-                ):
-                    gen_helper_call_opn(f, tag, regtype, regid, i)
-                    i += 1
+                reg = hex_common.get_register(tag, regtype, regid)
+                if reg.is_writeonly() and not reg.is_hvx_reg():
+                    declared.append(reg.reg_tcg())
+        ## Pass the HVX destination registers
         for regtype, regid in regs:
-            if hex_common.is_written(regid):
-                if not hex_common.is_hvx_reg(regtype):
-                    continue
-                gen_helper_call_opn(f, tag, regtype, regid, i)
-                i += 1
+            reg = hex_common.get_register(tag, regtype, regid)
+            if reg.is_written() and reg.is_hvx_reg():
+                declared.append(reg.reg_tcg())
+        ## Pass the source registers
         for regtype, regid in regs:
-            if hex_common.is_read(regid):
-                if hex_common.is_hvx_reg(regtype) and hex_common.is_readwrite(regid):
-                    continue
-                gen_helper_call_opn(f, tag, regtype, regid, i)
-                i += 1
+            reg = hex_common.get_register(tag, regtype, regid)
+            if reg.is_read() and not (reg.is_hvx_reg() and reg.is_readwrite()):
+                declared.append(reg.reg_tcg())
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
-        if hex_common.helper_needs_next_PC(tag):
-            f.write(", next_PC")
+            declared.append("tcg_constant_tl(ctx->pkt->pc)")
+        if hex_common.need_next_PC(tag):
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
-        if hex_common.is_written(regid):
-            genptr_dst_write_opn(f, regtype, regid, tag)
+        reg = hex_common.get_register(tag, regtype, regid)
+        if reg.is_written():
+            reg.log_write(f, tag)
 
     f.write("}\n\n")
 
@@ -637,6 +147,7 @@ def main():
     hex_common.read_overrides_file(sys.argv[3])
     hex_common.read_overrides_file(sys.argv[4])
     hex_common.calculate_attribs()
+    hex_common.init_registers()
     ## Whether or not idef-parser is enabled is
     ## determined by the number of arguments to
     ## this script:
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 0da65d6dd6..2f8963db59 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -20,12 +20,15 @@
 import sys
 import re
 import string
+import textwrap
 
 behdict = {}  # tag ->behavior
 semdict = {}  # tag -> semantics
 attribdict = {}  # tag -> attributes
 macros = {}  # macro -> macro information...
 attribinfo = {}  # Register information and misc
+registers = {}  # register -> register functions
+new_registers = {}
 tags = []  # list of all tags
 overrides = {}  # tags with helper overrides
 idef_parser_enabled = {}  # tags enabled for idef-parser
@@ -276,6 +279,10 @@ def helper_needs_next_PC(tag):
     return "A_CALL" in attribdict[tag]
 
 
+def need_next_PC(tag):
+    return "A_CALL" in attribdict[tag]
+
+
 def need_pkt_has_multi_cof(tag):
     return "A_COF" in attribdict[tag]
 
@@ -350,3 +357,538 @@ def read_idef_parser_enabled_file(name):
     with open(name, "r") as idef_parser_enabled_file:
         lines = idef_parser_enabled_file.read().strip().split("\n")
         idef_parser_enabled = set(lines)
+
+
+def is_predicated(tag):
+    return "A_CONDEXEC" in attribdict[tag]
+
+
+def code_fmt(txt):
+    return textwrap.indent(textwrap.dedent(txt), "    ")
+
+
+def hvx_newv(tag):
+    if "A_CVI_NEW" in attribdict[tag]:
+        return "EXT_NEW"
+    elif "A_CVI_TMP" in attribdict[tag] or "A_CVI_TMP_DST" in attribdict[tag]:
+        return "EXT_TMP"
+    else:
+        return "EXT_DFL"
+
+def vreg_offset_func(tag):
+    if "A_CVI_TMP" in attribdict[tag] or "A_CVI_TMP_DST" in attribdict[tag]:
+        return "ctx_tmp_vreg_off"
+    else:
+        return "ctx_future_vreg_off"
+
+
+class Register:
+    def __init__(self, regtype, regid):
+        self.regtype = regtype
+        self.regid = regid
+        self.reg_num = f"{regtype}{regid}N"
+    def decl_reg_num(self, f, regno):
+        f.write(code_fmt(f"""\
+            const int {self.reg_num} = insn->regno[{regno}];
+        """))
+    def idef_arg(self, declared):
+        declared.append(self.reg_tcg())
+
+#
+# Every register is either Single or Pair or Hvx
+#
+class Scalar:
+    def is_scalar_reg(self):
+        return True
+    def is_hvx_reg(self):
+        return False
+
+class Single(Scalar):
+    pass
+
+class Pair(Scalar):
+    pass
+
+class Hvx:
+    def is_scalar_reg(self):
+        return False
+    def is_hvx_reg(self):
+        return True
+    def hvx_off(self):
+        return f"{self.reg_tcg()}_off"
+
+#
+# Every register is either Dest or OldSource or NewSource or ReadWrite
+#
+class Dest:
+    def reg_tcg(self):
+        return f"{self.regtype}{self.regid}V"
+    def is_written(self):
+        return True
+    def is_writeonly(self):
+        return True
+    def is_read(self):
+        return False
+    def is_readwrite(self):
+        return False
+
+class Source:
+    def is_written(self):
+        return False
+    def is_writeonly(self):
+        return False
+    def is_read(self):
+        return True
+    def is_readwrite(self):
+        return False
+
+class OldSource(Source):
+    def reg_tcg(self):
+        return f"{self.regtype}{self.regid}V"
+
+class NewSource(Source):
+    def reg_tcg(self):
+        return f"{self.regtype}{self.regid}N"
+
+class ReadWrite:
+    def reg_tcg(self):
+        return f"{self.regtype}{self.regid}V"
+    def is_written(self):
+        return True
+    def is_writeonly(self):
+        return False
+    def is_read(self):
+        return True
+    def is_readwrite(self):
+        return True
+
+class GprDest(Register, Single, Dest):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            TCGv {self.reg_tcg()} = get_result_gpr(ctx, {self.reg_num});
+        """))
+    def log_write(self, f, tag):
+        f.write(code_fmt(f"""\
+            gen_log_reg_write(ctx, {self.reg_num}, {self.reg_tcg()});
+        """))
+
+class GprSource(Register, Single, OldSource):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            TCGv {self.reg_tcg()} = hex_gpr[{self.reg_num}];
+        """))
+
+class GprNewSource(Register, Single, NewSource):
+    def decl_tcg(self, f, tag, regno):
+        f.write(code_fmt(f"""\
+            TCGv {self.reg_tcg()} = get_result_gpr(ctx, insn->regno[{regno}]);
+        """))
+
+class GprReadWrite(Register, Single, ReadWrite):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            TCGv {self.reg_tcg()} = get_result_gpr(ctx, {self.reg_num});
+        """))
+        ## For read/write registers, we need to get the original value into
+        ## the result TCGv.  For predicated instructions, this is done in
+        ## gen_start_packet.  For un-predicated instructions, we do it here.
+        if not is_predicated(tag):
+            f.write(code_fmt(f"""\
+                tcg_gen_mov_tl({self.reg_tcg()}, hex_gpr[{self.reg_num}]);
+            """))
+    def log_write(self, f, tag):
+        f.write(code_fmt(f"""\
+            gen_log_reg_write(ctx, {self.reg_num}, {self.reg_tcg()});
+        """))
+
+class ControlDest(Register, Single, Dest):
+    def decl_reg_num(self, f, regno):
+        f.write(code_fmt(f"""\
+            const int {self.reg_num} = insn->regno[{regno}]  + HEX_REG_SA0;
+        """))
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            TCGv {self.reg_tcg()} = get_result_gpr(ctx, {self.reg_num});
+        """))
+    def log_write(self, f, tag):
+        f.write(code_fmt(f"""\
+            gen_write_ctrl_reg(ctx, {self.reg_num}, {self.reg_tcg()});
+        """))
+
+class ControlSource(Register, Single, OldSource):
+    def decl_reg_num(self, f, regno):
+        f.write(code_fmt(f"""\
+            const int {self.reg_num} = insn->regno[{regno}]  + HEX_REG_SA0;
+        """))
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno);
+        f.write(code_fmt(f"""\
+            TCGv {self.reg_tcg()} = tcg_temp_new();
+            gen_read_ctrl_reg(ctx, {self.reg_num}, {self.reg_tcg()});
+        """))
+
+class ModifierSource(Register, Single, OldSource):
+    def decl_reg_num(self, f, regno):
+        f.write(code_fmt(f"""\
+            const int {self.reg_num} = insn->regno[{regno}] + HEX_REG_M0;
+        """))
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            TCGv {self.reg_tcg()} = hex_gpr[{self.reg_num}];
+            TCGv CS G_GNUC_UNUSED =
+                hex_gpr[{self.reg_num} - HEX_REG_M0 + HEX_REG_CS0];
+        """))
+    def idef_arg(self, declared):
+        declared.append(self.reg_tcg())
+        declared.append("CS")
+
+class PredDest(Register, Single, Dest):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            TCGv {self.reg_tcg()} = tcg_temp_new();
+        """))
+    def log_write(self, f, tag):
+        f.write(code_fmt(f"""\
+            gen_log_pred_write(ctx, {self.reg_num}, {self.reg_tcg()});
+        """))
+
+class PredSource(Register, Single, OldSource):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            TCGv {self.reg_tcg()} = hex_pred[{self.reg_num}];
+        """))
+
+class PredNewSource(Register, Single, NewSource):
+    def decl_tcg(self, f, tag, regno):
+        f.write(code_fmt(f"""\
+            TCGv {self.reg_tcg()} = get_result_pred(ctx, insn->regno[{regno}]);
+        """))
+
+class PredReadWrite(Register, Single, ReadWrite):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            TCGv {self.reg_tcg()} = tcg_temp_new();
+            tcg_gen_mov_tl({self.reg_tcg()}, hex_pred[{self.reg_num}]);
+        """))
+    def log_write(self, f, tag):
+        f.write(code_fmt(f"""\
+            gen_log_pred_write(ctx, {self.reg_num}, {self.reg_tcg()});
+        """))
+
+class PairDest(Register, Pair, Dest):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            TCGv_i64 {self.reg_tcg()} =
+                get_result_gpr_pair(ctx, {self.reg_num});
+        """))
+    def log_write(self, f, tag):
+        f.write(code_fmt(f"""\
+            gen_log_reg_write_pair(ctx, {self.reg_num}, {self.reg_tcg()});
+        """))
+
+class PairSource(Register, Pair, OldSource):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            TCGv_i64 {self.reg_tcg()} = tcg_temp_new_i64();
+            tcg_gen_concat_i32_i64({self.reg_tcg()},
+                                    hex_gpr[{self.reg_num}],
+                                    hex_gpr[{self.reg_num} + 1]);
+        """))
+
+class PairReadWrite(Register, Pair, ReadWrite):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            TCGv_i64 {self.reg_tcg()} =
+                get_result_gpr_pair(ctx, {self.reg_num});
+            tcg_gen_concat_i32_i64({self.reg_tcg()},
+                                   hex_gpr[{self.reg_num}],
+                                   hex_gpr[{self.reg_num} + 1]);
+        """))
+    def log_write(self, f, tag):
+        f.write(code_fmt(f"""\
+            gen_log_reg_write_pair(ctx, {self.reg_num}, {self.reg_tcg()});
+        """))
+
+class ControlPairDest(Register, Pair, Dest):
+    def decl_reg_num(self, f, regno):
+        f.write(code_fmt(f"""\
+            const int {self.reg_num} = insn->regno[{regno}] + HEX_REG_SA0;
+        """))
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            TCGv_i64 {self.reg_tcg()} =
+                get_result_gpr_pair(ctx, {self.reg_num});
+        """))
+    def log_write(self, f, tag):
+        f.write(code_fmt(f"""\
+            gen_write_ctrl_reg_pair(ctx, {self.reg_num}, {self.reg_tcg()});
+        """))
+
+class ControlPairSource(Register, Pair, OldSource):
+    def decl_reg_num(self, f, regno):
+        f.write(code_fmt(f"""\
+            const int {self.reg_num} = insn->regno[{regno}] + HEX_REG_SA0;
+        """))
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            TCGv_i64 {self.reg_tcg()} = tcg_temp_new_i64();
+            gen_read_ctrl_reg_pair(ctx, {self.reg_num}, {self.reg_tcg()});
+        """))
+
+class VRegDest(Register, Hvx, Dest):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            const intptr_t {self.hvx_off()} =
+                {vreg_offset_func(tag)}(ctx, {self.reg_num}, 1, true);
+        """))
+        if not skip_qemu_helper(tag):
+            f.write(code_fmt(f"""\
+                TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
+                tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
+            """))
+    def log_write(self, f, tag):
+        pass
+
+class VRegSource(Register, Hvx, OldSource):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            const intptr_t {self.hvx_off()} = vreg_src_off(ctx, {self.reg_num});
+        """))
+        if not skip_qemu_helper(tag):
+            f.write(code_fmt(f"""\
+                TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
+                tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
+            """))
+
+class VRegNewSource(Register, Hvx, NewSource):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        if skip_qemu_helper(tag):
+            f.write(code_fmt(f"""\
+                const intptr_t {self.hvx_off()} =
+                    ctx_future_vreg_off(ctx, {self.reg_num}, 1, true);
+            """))
+
+class VRegReadWrite(Register, Hvx, ReadWrite):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            const intptr_t {self.hvx_off()} =
+                {vreg_offset_func(tag)}(ctx, {self.reg_num}, 1, true);
+            tcg_gen_gvec_mov(MO_64, {self.hvx_off()},
+                             vreg_src_off(ctx, {self.reg_num}),
+                             sizeof(MMVector), sizeof(MMVector));
+        """))
+        if not skip_qemu_helper(tag):
+            f.write(code_fmt(f"""\
+                TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
+                tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
+            """))
+    def log_write(self, f, tag):
+        pass
+
+class VRegTmp(Register, Hvx, ReadWrite):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            const intptr_t {self.hvx_off()} = offsetof(CPUHexagonState, vtmp);
+        """))
+        if not skip_qemu_helper(tag):
+            f.write(code_fmt(f"""\
+                TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
+                tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
+                tcg_gen_gvec_mov(MO_64, {self.hvx_off()},
+                                 vreg_src_off(ctx, {self.reg_num}),
+                                 sizeof(MMVector), sizeof(MMVector));
+            """))
+    def log_write(self, f, tag):
+        f.write(code_fmt(f"""\
+            gen_log_vreg_write(ctx, {self.hvx_off()}, {self.reg_num},
+                               {hvx_newv(tag)});
+        """))
+
+class VRegPairDest(Register, Hvx, Dest):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            const intptr_t {self.hvx_off()} =
+                {vreg_offset_func(tag)}(ctx, {self.reg_num}, 2, true);
+        """))
+        if not skip_qemu_helper(tag):
+            f.write(code_fmt(f"""\
+                TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
+                tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
+            """))
+    def log_write(self, f, tag):
+        pass
+
+class VRegPairSource(Register, Hvx, OldSource):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            const intptr_t {self.hvx_off()} =
+                offsetof(CPUHexagonState, {self.reg_tcg()});
+            tcg_gen_gvec_mov(MO_64, {self.hvx_off()},
+                             vreg_src_off(ctx, {self.reg_num}),
+                             sizeof(MMVector), sizeof(MMVector));
+            tcg_gen_gvec_mov(MO_64, {self.hvx_off()} + sizeof(MMVector),
+                             vreg_src_off(ctx, {self.reg_num} ^ 1),
+                             sizeof(MMVector), sizeof(MMVector));
+        """))
+        if not skip_qemu_helper(tag):
+            f.write(code_fmt(f"""\
+                TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
+                tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
+            """))
+
+class VRegPairReadWrite(Register, Hvx, ReadWrite):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            const intptr_t {self.hvx_off()} =
+                offsetof(CPUHexagonState, {self.reg_tcg()});
+            tcg_gen_gvec_mov(MO_64, {self.hvx_off()},
+                             vreg_src_off(ctx, {self.reg_num}),
+                             sizeof(MMVector), sizeof(MMVector));
+            tcg_gen_gvec_mov(MO_64, {self.hvx_off()} + sizeof(MMVector),
+                             vreg_src_off(ctx, {self.reg_num} ^ 1),
+                             sizeof(MMVector), sizeof(MMVector));
+        """))
+        if not skip_qemu_helper(tag):
+            f.write(code_fmt(f"""\
+                TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
+                tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
+            """))
+    def log_write(self, f, tag):
+        f.write(code_fmt(f"""\
+            gen_log_vreg_write_pair(ctx, {self.hvx_off()}, {self.reg_num},
+                                    {hvx_newv(tag)});
+        """))
+
+class QRegDest(Register, Hvx, Dest):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            const intptr_t {self.hvx_off()} =
+                get_result_qreg(ctx, {self.reg_num});
+        """))
+        if not skip_qemu_helper(tag):
+            f.write(code_fmt(f"""\
+                TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
+                tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
+            """))
+    def log_write(self, f, tag):
+        pass
+
+class QRegSource(Register, Hvx, OldSource):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            const intptr_t {self.hvx_off()} =
+                offsetof(CPUHexagonState, QRegs[{self.reg_num}]);
+        """))
+        if not skip_qemu_helper(tag):
+            f.write(code_fmt(f"""\
+                TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
+                tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
+            """))
+
+class QRegReadWrite(Register, Hvx, ReadWrite):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            const intptr_t {self.hvx_off()} =
+                get_result_qreg(ctx, {self.reg_num});
+            tcg_gen_gvec_mov(MO_64, {self.hvx_off()},
+                             offsetof(CPUHexagonState, QRegs[{self.reg_num}]),
+                             sizeof(MMQReg), sizeof(MMQReg));
+        """))
+        if not skip_qemu_helper(tag):
+            f.write(code_fmt(f"""\
+                TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
+                tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
+            """))
+    def log_write(self, f, tag):
+        pass
+
+def init_registers():
+    regs = {
+        GprDest("R", "d"),
+        GprDest("R", "e"),
+        GprSource("R", "s"),
+        GprSource("R", "t"),
+        GprSource("R", "u"),
+        GprSource("R", "v"),
+        GprReadWrite("R", "x"),
+        GprReadWrite("R", "y"),
+        ControlDest("C", "d"),
+        ControlSource("C", "s"),
+        ModifierSource("M", "u"),
+        PredDest("P", "d"),
+        PredDest("P", "e"),
+        PredSource("P", "s"),
+        PredSource("P", "t"),
+        PredSource("P", "u"),
+        PredSource("P", "v"),
+        PredReadWrite("P", "x"),
+        PairDest("R", "dd"),
+        PairDest("R", "ee"),
+        PairSource("R", "ss"),
+        PairSource("R", "tt"),
+        PairReadWrite("R", "xx"),
+        PairReadWrite("R", "yy"),
+        ControlPairDest("C", "dd"),
+        ControlPairSource("C", "ss"),
+        VRegDest("V", "d"),
+        VRegSource("V", "s"),
+        VRegSource("V", "u"),
+        VRegSource("V", "v"),
+        VRegSource("V", "w"),
+        VRegReadWrite("V", "x"),
+        VRegTmp("V", "y"),
+        VRegPairDest("V", "dd"),
+        VRegPairSource("V", "uu"),
+        VRegPairSource("V", "vv"),
+        VRegPairReadWrite("V", "xx"),
+        QRegDest("Q", "d"),
+        QRegDest("Q", "e"),
+        QRegSource("Q", "s"),
+        QRegSource("Q", "t"),
+        QRegSource("Q", "u"),
+        QRegSource("Q", "v"),
+        QRegReadWrite("Q", "x"),
+    }
+    for reg in regs:
+        registers[f"{reg.regtype}{reg.regid}"] = reg
+
+    new_regs = {
+        GprNewSource("N", "s"),
+        GprNewSource("N", "t"),
+        PredNewSource("P", "t"),
+        PredNewSource("P", "u"),
+        PredNewSource("P", "v"),
+        VRegNewSource("O", "s"),
+    }
+    for reg in new_regs:
+        new_registers[f"{reg.regtype}{reg.regid}"] = reg
+
+def get_register(tag, regtype, regid):
+    if f"{regtype}{regid}V" in semdict[tag]:
+        return registers[f"{regtype}{regid}"]
+    else:
+        return new_registers[f"{regtype}{regid}"]
-- 
2.34.1


