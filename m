Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD99D7440C5
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 19:04:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFHWD-00086v-L2; Fri, 30 Jun 2023 13:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1qFHW6-00086W-Bb
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 13:02:42 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1qFHW1-00089I-73
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 13:02:42 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4fb73ba3b5dso3495787e87.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 10:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1688144554; x=1690736554;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5+JhkRU6bWU2CST1rO5Lc7Ggk6TpmxkViuVB7d+UyFE=;
 b=Bzk2c/DOjfEnP8cRjkx1ryy/xr2vfvHdeRRLXFr72iSeptk2FFd/3Y8DgWRzzrHIDD
 m1H4x6gqiei1+lQucTzaNrlPIRket9TvgeF+u/clHyEe9m11LZ99+z3H5FZSFlYMSuMC
 luVtLCeQZErInERfyykIk+su4l31bCel2dKE5IzMcZmymNr3boPx7ZjVfcYcwgu3rp8U
 jv4UWOED5aPGKsxiKHi6iaZgbbZ7tKTru69aSWXG/MfUXBRvCwOOC2Bc412/tFnbQiQp
 BKLUGcBgpEyMzWJuDvuYKHp6SMeIzPW2zFf+j8v3qdoJA3g5zaMBcbPUOFfySwvGeXT5
 f6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688144554; x=1690736554;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5+JhkRU6bWU2CST1rO5Lc7Ggk6TpmxkViuVB7d+UyFE=;
 b=XuLUqGaPe8e/LcXdfsimO7lnU0DsSNXjmDk8e08YESPbxTykV3KxYAwnFh5m3Y7ool
 Zqxkt8qAEXWYwpY0LWys/Ri6n3nZ9H3ZFmDf3k8G/XZqZZc1Pn1akOeReypWD6Ke2USV
 Pi3mebvxPH7Oh59tz/8dvSxp3/x+xisDOmbSWpWq2td9CMVI58gTFKfJcVdIMfEi04Ew
 EIUlph/6wt/ltdjjPendE2ij9GZ50ON7aHICbHkcwEIfYOFoxDEVvV1B5gj5s6zHzPQY
 U1ExFjz3rWt9LAwYKqRloyz+liru+AYmNIjwsZgn25R0RW96A5cr9ej4srlYeqjbJ840
 ikKg==
X-Gm-Message-State: ABy/qLYmEcRjmvbowRVNi8+gUFbSyCPTwPzPSp3brfyOUwlPmZLzO6sv
 wovBOfP1LgKUo1e6vz55Sz762A==
X-Google-Smtp-Source: APBJJlGf5QSPJSEwpsE602Cdx/PYifW/tEsoYVA2KhgeJ0EGgCeLCMqgnYCXvP47T2EX8aD7kzh/iQ==
X-Received: by 2002:a19:9148:0:b0:4f8:5e49:c610 with SMTP id
 y8-20020a199148000000b004f85e49c610mr2307873lfj.35.1688144553980; 
 Fri, 30 Jun 2023 10:02:33 -0700 (PDT)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at.
 [62.178.148.172]) by smtp.gmail.com with ESMTPSA id
 ec10-20020a170906b6ca00b009893650453fsm8350009ejb.173.2023.06.30.10.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 10:02:33 -0700 (PDT)
From: Christoph Muellner <christoph.muellner@vrull.eu>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>, Jeff Law <jeffreyalaw@gmail.com>,
 Tsukasa OI <research_trasio@irq.a4lg.com>, liweiwei@iscas.ac.cn,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Rob Bradford <rbradford@rivosinc.com>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 Alistair Francis <Alistair.Francis@wdc.com>
Subject: [PATCH v6] riscv: Add support for the Zfa extension
Date: Fri, 30 Jun 2023 19:02:29 +0200
Message-ID: <20230630170230.1043454-1-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Christoph Müllner <christoph.muellner@vrull.eu>

This patch introduces the RISC-V Zfa extension, which introduces
additional floating-point instructions:
* fli (load-immediate) with pre-defined immediates
* fminm/fmaxm (like fmin/fmax but with different NaN behaviour)
* fround/froundmx (round to integer)
* fcvtmod.w.d (Modular Convert-to-Integer)
* fmv* to access high bits of float register bigger than XLEN
* Quiet comparison instructions (fleq/fltq)

Zfa defines its instructions in combination with the following extensions:
* single-precision floating-point (F)
* double-precision floating-point (D)
* quad-precision floating-point (Q)
* half-precision floating-point (Zfh)

Since QEMU does not support the RISC-V quad-precision floating-point
ISA extension (Q), this patch does not include the instructions that
depend on this extension. All other instructions are included in this
patch.

The Zfa specification can be found here:
  https://github.com/riscv/riscv-isa-manual/blob/master/src/zfa.tex
The Zfa specifciation is frozen and is in public review since May 3, 2023:
  https://groups.google.com/a/groups.riscv.org/g/isa-dev/c/SED4ntBkabg

The patch also includes a TCG test for the fcvtmod.w.d instruction.
The test cases test for correct results and flag behaviour.
Note, that the Zfa specification requires fcvtmod's flag behaviour
to be identical to a fcvt with the same operands (which is also
tested).

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>

---

This patch depends on float64_to_int64_modulo(), which is provided
by a patchset from Richard Henderson:
  https://lists.nongnu.org/archive/html/qemu-devel/2023-05/msg07022.html

Changes in v6:
* Address issues in trans_fmvp_d_x() and trans_fmvh_x_d()

Changes in v5:
* Merge all three commits
* Address issues reported by Richard

Changes in v4:
* Rebase and resolve conflicts
* Fix whitespace issue (thanks Rob)
* Add patch to implemnt fcvtmod.w.d using float64_to_int64_modulo()
* Add (demo) test for fcvtmod.w.d

Changes in v3:
* Add disassembler support
* Enable Zfa by default
* Remove forgotten comments in the decoder
* Fix fli translation code (use movi instead of ld)
* Tested against SPEC CPU2017 fprate
* Use floatN_[min|max] for f[min|max]m.* instructions

Changes in v2:
* Remove calls to mark_fs_dirty() in comparison trans functions
* Rewrite fround(nx) using float*_round_to_int()
* Move fli* to translation unit and fix NaN-boxing of NaN values
* Reimplement FCVTMOD.W.D
* Add use of second register in trans_fmvp_d_x()

 disas/riscv.c                             | 151 +++++++
 target/riscv/cpu.c                        |   8 +
 target/riscv/cpu_cfg.h                    |   1 +
 target/riscv/fpu_helper.c                 | 154 +++++++
 target/riscv/helper.h                     |  19 +
 target/riscv/insn32.decode                |  26 ++
 target/riscv/insn_trans/trans_rvzfa.c.inc | 521 ++++++++++++++++++++++
 target/riscv/translate.c                  |   1 +
 tests/tcg/riscv64/Makefile.target         |   6 +
 tests/tcg/riscv64/test-fcvtmod.c          | 345 ++++++++++++++
 10 files changed, 1232 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvzfa.c.inc
 create mode 100644 tests/tcg/riscv64/test-fcvtmod.c

diff --git a/disas/riscv.c b/disas/riscv.c
index 5005364aba..d8ae1e53a3 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -170,6 +170,7 @@ typedef enum {
     rv_codec_zcmp_cm_pushpop,
     rv_codec_zcmp_cm_mv,
     rv_codec_zcmt_jt,
+    rv_codec_fli,
 } rv_codec;
 
 typedef enum {
@@ -964,6 +965,39 @@ typedef enum {
     rv_op_cm_jalt = 788,
     rv_op_czero_eqz = 789,
     rv_op_czero_nez = 790,
+    rv_op_fli_s = 791,
+    rv_op_fli_d = 792,
+    rv_op_fli_q = 793,
+    rv_op_fli_h = 794,
+    rv_op_fminm_s = 795,
+    rv_op_fmaxm_s = 796,
+    rv_op_fminm_d = 797,
+    rv_op_fmaxm_d = 798,
+    rv_op_fminm_q = 799,
+    rv_op_fmaxm_q = 800,
+    rv_op_fminm_h = 801,
+    rv_op_fmaxm_h = 802,
+    rv_op_fround_s = 803,
+    rv_op_froundnx_s = 804,
+    rv_op_fround_d = 805,
+    rv_op_froundnx_d = 806,
+    rv_op_fround_q = 807,
+    rv_op_froundnx_q = 808,
+    rv_op_fround_h = 809,
+    rv_op_froundnx_h = 810,
+    rv_op_fcvtmod_w_d = 811,
+    rv_op_fmvh_x_d = 812,
+    rv_op_fmvp_d_x = 813,
+    rv_op_fmvh_x_q = 814,
+    rv_op_fmvp_q_x = 815,
+    rv_op_fleq_s = 816,
+    rv_op_fltq_s = 817,
+    rv_op_fleq_d = 818,
+    rv_op_fltq_d = 819,
+    rv_op_fleq_q = 820,
+    rv_op_fltq_q = 821,
+    rv_op_fleq_h = 822,
+    rv_op_fltq_h = 823,
 } rv_op;
 
 /* structures */
@@ -1034,6 +1068,24 @@ static const char rv_vreg_name_sym[32][4] = {
     "v24", "v25", "v26", "v27", "v28", "v29", "v30", "v31"
 };
 
+/* The FLI.[HSDQ] numeric constants (0.0 for symbolic constants).
+ * The constants use the hex floating-point literal representation
+ * that is printed when using the printf %a format specifier,
+ * which matches the output that is generated by the disassembler.
+ */
+static const char rv_fli_name_const[32][9] =
+{
+    "0x1p+0", "min", "0x1p-16", "0x1p-15",
+    "0x1p-8", "0x1p-7", "0x1p-4", "0x1p-3",
+    "0x1p-2", "0x1.4p-2", "0x1.8p-2", "0x1.cp-2",
+    "0x1p-1", "0x1.4p-1", "0x1.8p-1", "0x1.cp-1",
+    "0x1p+0", "0x1.4p+0", "0x1.8p+0", "0x1.cp+0",
+    "0x1p+1", "0x1.4p+1", "0x1.8p+1", "0x1p+2",
+    "0x1p+3", "0x1p+4", "0x1p+7", "0x1p+8",
+    "0x1p+15", "0x1p+16", "inf", "nan"
+};
+
+
 /* instruction formats */
 
 #define rv_fmt_none                   "O\t"
@@ -1045,6 +1097,7 @@ static const char rv_vreg_name_sym[32][4] = {
 #define rv_fmt_rd_offset              "O\t0,o"
 #define rv_fmt_rd_rs1_rs2             "O\t0,1,2"
 #define rv_fmt_frd_rs1                "O\t3,1"
+#define rv_fmt_frd_rs1_rs2            "O\t3,1,2"
 #define rv_fmt_frd_frs1               "O\t3,4"
 #define rv_fmt_rd_frs1                "O\t0,4"
 #define rv_fmt_rd_frs1_frs2           "O\t0,4,5"
@@ -1106,6 +1159,7 @@ static const char rv_vreg_name_sym[32][4] = {
 #define rv_fmt_push_rlist             "O\tx,-i"
 #define rv_fmt_pop_rlist              "O\tx,i"
 #define rv_fmt_zcmt_index             "O\ti"
+#define rv_fmt_fli                    "O\t3,h"
 
 /* pseudo-instruction constraints */
 
@@ -2168,6 +2222,39 @@ const rv_opcode_data opcode_data[] = {
     { "cm.jalt", rv_codec_zcmt_jt, rv_fmt_zcmt_index, NULL, 0 },
     { "czero.eqz", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
     { "czero.nez", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
+    { "fli.s", rv_codec_fli, rv_fmt_fli, NULL, 0, 0, 0 },
+    { "fli.d", rv_codec_fli, rv_fmt_fli, NULL, 0, 0, 0 },
+    { "fli.q", rv_codec_fli, rv_fmt_fli, NULL, 0, 0, 0 },
+    { "fli.h", rv_codec_fli, rv_fmt_fli, NULL, 0, 0, 0 },
+    { "fminm.s", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },
+    { "fmaxm.s", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },
+    { "fminm.d", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },
+    { "fmaxm.d", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },
+    { "fminm.q", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },
+    { "fmaxm.q", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },
+    { "fminm.h", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },
+    { "fmaxm.h", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },
+    { "fround.s", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
+    { "froundnx.s", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
+    { "fround.d", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
+    { "froundnx.d", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
+    { "fround.q", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
+    { "froundnx.q", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
+    { "fround.h", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
+    { "froundnx.h", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
+    { "fcvtmod.w.d", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },
+    { "fmvh.x.d", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0, 0 },
+    { "fmvp.d.x", rv_codec_r, rv_fmt_frd_rs1_rs2, NULL, 0, 0, 0 },
+    { "fmvh.x.q", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0, 0 },
+    { "fmvp.q.x", rv_codec_r, rv_fmt_frd_rs1_rs2, NULL, 0, 0, 0 },
+    { "fleq.s", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },
+    { "fltq.s", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },
+    { "fleq.d", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },
+    { "fltq.d", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },
+    { "fleq.q", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },
+    { "fltq.q", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },
+    { "fleq.h", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },
+    { "fltq.h", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -3105,36 +3192,60 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 switch ((inst >> 12) & 0b111) {
                 case 0: op = rv_op_fmin_s; break;
                 case 1: op = rv_op_fmax_s; break;
+                case 2: op = rv_op_fminm_s; break;
+                case 3: op = rv_op_fmaxm_s; break;
                 }
                 break;
             case 21:
                 switch ((inst >> 12) & 0b111) {
                 case 0: op = rv_op_fmin_d; break;
                 case 1: op = rv_op_fmax_d; break;
+                case 2: op = rv_op_fminm_d; break;
+                case 3: op = rv_op_fmaxm_d; break;
+                }
+                break;
+            case 22:
+                switch (((inst >> 12) & 0b111)) {
+                case 2: op = rv_op_fminm_h; break;
+                case 3: op = rv_op_fmaxm_h; break;
                 }
                 break;
             case 23:
                 switch ((inst >> 12) & 0b111) {
                 case 0: op = rv_op_fmin_q; break;
                 case 1: op = rv_op_fmax_q; break;
+                case 2: op = rv_op_fminm_q; break;
+                case 3: op = rv_op_fmaxm_q; break;
                 }
                 break;
             case 32:
                 switch ((inst >> 20) & 0b11111) {
                 case 1: op = rv_op_fcvt_s_d; break;
                 case 3: op = rv_op_fcvt_s_q; break;
+                case 4: op = rv_op_fround_s; break;
+                case 5: op = rv_op_froundnx_s; break;
                 }
                 break;
             case 33:
                 switch ((inst >> 20) & 0b11111) {
                 case 0: op = rv_op_fcvt_d_s; break;
                 case 3: op = rv_op_fcvt_d_q; break;
+                case 4: op = rv_op_fround_d; break;
+                case 5: op = rv_op_froundnx_d; break;
+                }
+                break;
+            case 34:
+                switch (((inst >> 20) & 0b11111)) {
+                case 4: op = rv_op_fround_h; break;
+                case 5: op = rv_op_froundnx_h; break;
                 }
                 break;
             case 35:
                 switch ((inst >> 20) & 0b11111) {
                 case 0: op = rv_op_fcvt_q_s; break;
                 case 1: op = rv_op_fcvt_q_d; break;
+                case 4: op = rv_op_fround_q; break;
+                case 5: op = rv_op_froundnx_q; break;
                 }
                 break;
             case 44:
@@ -3157,6 +3268,8 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 0: op = rv_op_fle_s; break;
                 case 1: op = rv_op_flt_s; break;
                 case 2: op = rv_op_feq_s; break;
+                case 4: op = rv_op_fleq_s; break;
+                case 5: op = rv_op_fltq_s; break;
                 }
                 break;
             case 81:
@@ -3164,6 +3277,14 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 0: op = rv_op_fle_d; break;
                 case 1: op = rv_op_flt_d; break;
                 case 2: op = rv_op_feq_d; break;
+                case 4: op = rv_op_fleq_d; break;
+                case 5: op = rv_op_fltq_d; break;
+                }
+                break;
+            case 82:
+                switch (((inst >> 12) & 0b111)) {
+                case 4: op = rv_op_fleq_h; break;
+                case 5: op = rv_op_fltq_h; break;
                 }
                 break;
             case 83:
@@ -3171,6 +3292,18 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 0: op = rv_op_fle_q; break;
                 case 1: op = rv_op_flt_q; break;
                 case 2: op = rv_op_feq_q; break;
+                case 4: op = rv_op_fleq_q; break;
+                case 5: op = rv_op_fltq_q; break;
+                }
+                break;
+            case 89:
+		switch (((inst >> 12) & 0b111)) {
+                case 0: op = rv_op_fmvp_d_x; break;
+                }
+                break;
+            case 91:
+		switch (((inst >> 12) & 0b111)) {
+                case 0: op = rv_op_fmvp_q_x; break;
                 }
                 break;
             case 96:
@@ -3187,6 +3320,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 1: op = rv_op_fcvt_wu_d; break;
                 case 2: op = rv_op_fcvt_l_d; break;
                 case 3: op = rv_op_fcvt_lu_d; break;
+                case 8: op = rv_op_fcvtmod_w_d; break;
                 }
                 break;
             case 99:
@@ -3233,6 +3367,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                         ((inst >> 12) & 0b00000111)) {
                 case 0: op = rv_op_fmv_x_d; break;
                 case 1: op = rv_op_fclass_d; break;
+                case 8: op = rv_op_fmvh_x_d; break;
                 }
                 break;
             case 115:
@@ -3240,24 +3375,33 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                         ((inst >> 12) & 0b00000111)) {
                 case 0: op = rv_op_fmv_x_q; break;
                 case 1: op = rv_op_fclass_q; break;
+                case 8: op = rv_op_fmvh_x_q; break;
                 }
                 break;
             case 120:
                 switch (((inst >> 17) & 0b11111000) |
                         ((inst >> 12) & 0b00000111)) {
                 case 0: op = rv_op_fmv_s_x; break;
+                case 8: op = rv_op_fli_s; break;
                 }
                 break;
             case 121:
                 switch (((inst >> 17) & 0b11111000) |
                         ((inst >> 12) & 0b00000111)) {
                 case 0: op = rv_op_fmv_d_x; break;
+                case 8: op = rv_op_fli_d; break;
+                }
+                break;
+            case 122:
+                switch (((inst >> 17) & 0b11111000) | ((inst >> 12) & 0b00000111)) {
+                case 8: op = rv_op_fli_h; break;
                 }
                 break;
             case 123:
                 switch (((inst >> 17) & 0b11111000) |
                         ((inst >> 12) & 0b00000111)) {
                 case 0: op = rv_op_fmv_q_x; break;
+                case 8: op = rv_op_fli_q; break;
                 }
                 break;
             }
@@ -4496,6 +4640,10 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa)
         break;
     case rv_codec_zcmt_jt:
         dec->imm = operand_tbl_index(inst);
+	break;
+    case rv_codec_fli:
+        dec->rd = operand_rd(inst);
+        dec->imm = operand_rs1(inst);
         break;
     };
 }
@@ -4869,6 +5017,9 @@ static void format_inst(char *buf, size_t buflen, size_t tab, rv_decode *dec)
             append(buf, tmp, buflen);
             break;
         }
+        case 'h':
+            append(buf, rv_fli_name_const[dec->imm], buflen);
+            break;
         default:
             break;
         }
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 881bddf393..f2e03dc3fc 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -83,6 +83,7 @@ static const struct isa_ext_data isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zifencei, PRIV_VERSION_1_10_0, ext_ifencei),
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
     ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
+    ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
     ISA_EXT_DATA_ENTRY(zfh, PRIV_VERSION_1_11_0, ext_zfh),
     ISA_EXT_DATA_ENTRY(zfhmin, PRIV_VERSION_1_11_0, ext_zfhmin),
     ISA_EXT_DATA_ENTRY(zfinx, PRIV_VERSION_1_12_0, ext_zfinx),
@@ -412,6 +413,7 @@ static void rv64_thead_c906_cpu_init(Object *obj)
     set_misa(env, MXL_RV64, RVG | RVC | RVS | RVU);
     env->priv_ver = PRIV_VERSION_1_11_0;
 
+    cpu->cfg.ext_zfa = true;
     cpu->cfg.ext_zfh = true;
     cpu->cfg.mmu = true;
     cpu->cfg.ext_xtheadba = true;
@@ -1050,6 +1052,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.ext_zfa && !riscv_has_ext(env, RVF)) {
+        error_setg(errp, "Zfa extension requires F extension");
+        return;
+    }
+
     if (cpu->cfg.ext_zfh) {
         cpu->cfg.ext_zfhmin = true;
     }
@@ -1600,6 +1607,7 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
     DEFINE_PROP_BOOL("Zihintpause", RISCVCPU, cfg.ext_zihintpause, true),
     DEFINE_PROP_BOOL("Zawrs", RISCVCPU, cfg.ext_zawrs, true),
+    DEFINE_PROP_BOOL("Zfa", RISCVCPU, cfg.ext_zfa, true),
     DEFINE_PROP_BOOL("Zfh", RISCVCPU, cfg.ext_zfh, false),
     DEFINE_PROP_BOOL("Zfhmin", RISCVCPU, cfg.ext_zfhmin, false),
     DEFINE_PROP_BOOL("Zve32f", RISCVCPU, cfg.ext_zve32f, false),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index c4a627d335..08ca65f5bd 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -75,6 +75,7 @@ struct RISCVCPUConfig {
     bool ext_svpbmt;
     bool ext_zdinx;
     bool ext_zawrs;
+    bool ext_zfa;
     bool ext_zfh;
     bool ext_zfhmin;
     bool ext_zfinx;
diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index 5dd14d8390..71465c3373 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -252,6 +252,14 @@ uint64_t helper_fmin_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
                          float32_minimum_number(frs1, frs2, &env->fp_status));
 }
 
+uint64_t helper_fminm_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    float32 frs1 = check_nanbox_s(env, rs1);
+    float32 frs2 = check_nanbox_s(env, rs2);
+    float32 ret = float32_min(frs1, frs2, &env->fp_status);
+    return nanbox_s(env, ret);
+}
+
 uint64_t helper_fmax_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
@@ -261,6 +269,14 @@ uint64_t helper_fmax_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
                          float32_maximum_number(frs1, frs2, &env->fp_status));
 }
 
+uint64_t helper_fmaxm_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    float32 frs1 = check_nanbox_s(env, rs1);
+    float32 frs2 = check_nanbox_s(env, rs2);
+    float32 ret = float32_max(frs1, frs2, &env->fp_status);
+    return nanbox_s(env, ret);
+}
+
 uint64_t helper_fsqrt_s(CPURISCVState *env, uint64_t rs1)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
@@ -274,6 +290,13 @@ target_ulong helper_fle_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
     return float32_le(frs1, frs2, &env->fp_status);
 }
 
+target_ulong helper_fleq_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    float32 frs1 = check_nanbox_s(env, rs1);
+    float32 frs2 = check_nanbox_s(env, rs2);
+    return float32_le_quiet(frs1, frs2, &env->fp_status);
+}
+
 target_ulong helper_flt_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
@@ -281,6 +304,13 @@ target_ulong helper_flt_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
     return float32_lt(frs1, frs2, &env->fp_status);
 }
 
+target_ulong helper_fltq_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    float32 frs1 = check_nanbox_s(env, rs1);
+    float32 frs2 = check_nanbox_s(env, rs2);
+    return float32_lt_quiet(frs1, frs2, &env->fp_status);
+}
+
 target_ulong helper_feq_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
@@ -338,6 +368,30 @@ target_ulong helper_fclass_s(CPURISCVState *env, uint64_t rs1)
     return fclass_s(frs1);
 }
 
+uint64_t helper_fround_s(CPURISCVState *env, uint64_t rs1)
+{
+    float_status *fs = &env->fp_status;
+    uint16_t nx_old = get_float_exception_flags(fs) & float_flag_inexact;
+    float32 frs1 = check_nanbox_s(env, rs1);
+
+    frs1 = float32_round_to_int(frs1, fs);
+
+    /* Restore the original NX flag. */
+    uint16_t flags = get_float_exception_flags(fs);
+    flags &= ~float_flag_inexact;
+    flags |= nx_old;
+    set_float_exception_flags(flags, fs);
+
+    return nanbox_s(env, frs1);
+}
+
+uint64_t helper_froundnx_s(CPURISCVState *env, uint64_t rs1)
+{
+    float32 frs1 = check_nanbox_s(env, rs1);
+    frs1 = float32_round_to_int(frs1, &env->fp_status);
+    return nanbox_s(env, frs1);
+}
+
 uint64_t helper_fadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
     return float64_add(frs1, frs2, &env->fp_status);
@@ -365,6 +419,11 @@ uint64_t helper_fmin_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
            float64_minimum_number(frs1, frs2, &env->fp_status);
 }
 
+uint64_t helper_fminm_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    return float64_min(frs1, frs2, &env->fp_status);
+}
+
 uint64_t helper_fmax_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
     return env->priv_ver < PRIV_VERSION_1_11_0 ?
@@ -372,6 +431,11 @@ uint64_t helper_fmax_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
            float64_maximum_number(frs1, frs2, &env->fp_status);
 }
 
+uint64_t helper_fmaxm_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    return float64_max(frs1, frs2, &env->fp_status);
+}
+
 uint64_t helper_fcvt_s_d(CPURISCVState *env, uint64_t rs1)
 {
     return nanbox_s(env, float64_to_float32(rs1, &env->fp_status));
@@ -393,11 +457,21 @@ target_ulong helper_fle_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
     return float64_le(frs1, frs2, &env->fp_status);
 }
 
+target_ulong helper_fleq_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    return float64_le_quiet(frs1, frs2, &env->fp_status);
+}
+
 target_ulong helper_flt_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
     return float64_lt(frs1, frs2, &env->fp_status);
 }
 
+target_ulong helper_fltq_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    return float64_lt_quiet(frs1, frs2, &env->fp_status);
+}
+
 target_ulong helper_feq_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
     return float64_eq_quiet(frs1, frs2, &env->fp_status);
@@ -408,6 +482,11 @@ target_ulong helper_fcvt_w_d(CPURISCVState *env, uint64_t frs1)
     return float64_to_int32(frs1, &env->fp_status);
 }
 
+uint64_t helper_fcvtmod_w_d(CPURISCVState *env, uint64_t value)
+{
+    return float64_to_int32_modulo(value, float_round_to_zero, &env->fp_status);
+}
+
 target_ulong helper_fcvt_wu_d(CPURISCVState *env, uint64_t frs1)
 {
     return (int32_t)float64_to_uint32(frs1, &env->fp_status);
@@ -448,6 +527,27 @@ target_ulong helper_fclass_d(uint64_t frs1)
     return fclass_d(frs1);
 }
 
+uint64_t helper_fround_d(CPURISCVState *env, uint64_t frs1)
+{
+    float_status *fs = &env->fp_status;
+    uint16_t nx_old = get_float_exception_flags(fs) & float_flag_inexact;
+
+    frs1 = float64_round_to_int(frs1, fs);
+
+    /* Restore the original NX flag. */
+    uint16_t flags = get_float_exception_flags(fs);
+    flags &= ~float_flag_inexact;
+    flags |= nx_old;
+    set_float_exception_flags(flags, fs);
+
+    return frs1;
+}
+
+uint64_t helper_froundnx_d(CPURISCVState *env, uint64_t frs1)
+{
+    return float64_round_to_int(frs1, &env->fp_status);
+}
+
 uint64_t helper_fadd_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
@@ -485,6 +585,14 @@ uint64_t helper_fmin_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
                          float16_minimum_number(frs1, frs2, &env->fp_status));
 }
 
+uint64_t helper_fminm_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    float16 frs1 = check_nanbox_h(env, rs1);
+    float16 frs2 = check_nanbox_h(env, rs2);
+    float16 ret = float16_min(frs1, frs2, &env->fp_status);
+    return nanbox_h(env, ret);
+}
+
 uint64_t helper_fmax_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
@@ -494,6 +602,14 @@ uint64_t helper_fmax_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
                          float16_maximum_number(frs1, frs2, &env->fp_status));
 }
 
+uint64_t helper_fmaxm_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    float16 frs1 = check_nanbox_h(env, rs1);
+    float16 frs2 = check_nanbox_h(env, rs2);
+    float16 ret = float16_max(frs1, frs2, &env->fp_status);
+    return nanbox_h(env, ret);
+}
+
 uint64_t helper_fsqrt_h(CPURISCVState *env, uint64_t rs1)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
@@ -507,6 +623,13 @@ target_ulong helper_fle_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
     return float16_le(frs1, frs2, &env->fp_status);
 }
 
+target_ulong helper_fleq_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    float16 frs1 = check_nanbox_h(env, rs1);
+    float16 frs2 = check_nanbox_h(env, rs2);
+    return float16_le_quiet(frs1, frs2, &env->fp_status);
+}
+
 target_ulong helper_flt_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
@@ -514,6 +637,13 @@ target_ulong helper_flt_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
     return float16_lt(frs1, frs2, &env->fp_status);
 }
 
+target_ulong helper_fltq_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    float16 frs1 = check_nanbox_h(env, rs1);
+    float16 frs2 = check_nanbox_h(env, rs2);
+    return float16_lt_quiet(frs1, frs2, &env->fp_status);
+}
+
 target_ulong helper_feq_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
@@ -527,6 +657,30 @@ target_ulong helper_fclass_h(CPURISCVState *env, uint64_t rs1)
     return fclass_h(frs1);
 }
 
+uint64_t helper_fround_h(CPURISCVState *env, uint64_t rs1)
+{
+    float_status *fs = &env->fp_status;
+    uint16_t nx_old = get_float_exception_flags(fs) & float_flag_inexact;
+    float16 frs1 = check_nanbox_h(env, rs1);
+
+    frs1 = float16_round_to_int(frs1, fs);
+
+    /* Restore the original NX flag. */
+    uint16_t flags = get_float_exception_flags(fs);
+    flags &= ~float_flag_inexact;
+    flags |= nx_old;
+    set_float_exception_flags(flags, fs);
+
+    return nanbox_h(env, frs1);
+}
+
+uint64_t helper_froundnx_h(CPURISCVState *env, uint64_t rs1)
+{
+    float16 frs1 = check_nanbox_s(env, rs1);
+    frs1 = float16_round_to_int(frs1, &env->fp_status);
+    return nanbox_h(env, frs1);
+}
+
 target_ulong helper_fcvt_w_h(CPURISCVState *env, uint64_t rs1)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 98e97810fd..46a86c2ff1 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -25,10 +25,14 @@ DEF_HELPER_FLAGS_3(fsub_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(fmul_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(fdiv_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(fmin_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(fminm_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(fmax_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(fmaxm_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_2(fsqrt_s, TCG_CALL_NO_RWG, i64, env, i64)
 DEF_HELPER_FLAGS_3(fle_s, TCG_CALL_NO_RWG, tl, env, i64, i64)
+DEF_HELPER_FLAGS_3(fleq_s, TCG_CALL_NO_RWG, tl, env, i64, i64)
 DEF_HELPER_FLAGS_3(flt_s, TCG_CALL_NO_RWG, tl, env, i64, i64)
+DEF_HELPER_FLAGS_3(fltq_s, TCG_CALL_NO_RWG, tl, env, i64, i64)
 DEF_HELPER_FLAGS_3(feq_s, TCG_CALL_NO_RWG, tl, env, i64, i64)
 DEF_HELPER_FLAGS_2(fcvt_w_s, TCG_CALL_NO_RWG, tl, env, i64)
 DEF_HELPER_FLAGS_2(fcvt_wu_s, TCG_CALL_NO_RWG, tl, env, i64)
@@ -39,6 +43,8 @@ DEF_HELPER_FLAGS_2(fcvt_s_wu, TCG_CALL_NO_RWG, i64, env, tl)
 DEF_HELPER_FLAGS_2(fcvt_s_l, TCG_CALL_NO_RWG, i64, env, tl)
 DEF_HELPER_FLAGS_2(fcvt_s_lu, TCG_CALL_NO_RWG, i64, env, tl)
 DEF_HELPER_FLAGS_2(fclass_s, TCG_CALL_NO_RWG_SE, tl, env, i64)
+DEF_HELPER_FLAGS_2(fround_s, TCG_CALL_NO_RWG_SE, i64, env, i64)
+DEF_HELPER_FLAGS_2(froundnx_s, TCG_CALL_NO_RWG_SE, i64, env, i64)
 
 /* Floating Point - Double Precision */
 DEF_HELPER_FLAGS_3(fadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
@@ -46,14 +52,19 @@ DEF_HELPER_FLAGS_3(fsub_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(fmul_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(fdiv_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(fmin_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(fminm_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(fmax_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(fmaxm_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_2(fcvt_s_d, TCG_CALL_NO_RWG, i64, env, i64)
 DEF_HELPER_FLAGS_2(fcvt_d_s, TCG_CALL_NO_RWG, i64, env, i64)
 DEF_HELPER_FLAGS_2(fsqrt_d, TCG_CALL_NO_RWG, i64, env, i64)
 DEF_HELPER_FLAGS_3(fle_d, TCG_CALL_NO_RWG, tl, env, i64, i64)
+DEF_HELPER_FLAGS_3(fleq_d, TCG_CALL_NO_RWG, tl, env, i64, i64)
 DEF_HELPER_FLAGS_3(flt_d, TCG_CALL_NO_RWG, tl, env, i64, i64)
+DEF_HELPER_FLAGS_3(fltq_d, TCG_CALL_NO_RWG, tl, env, i64, i64)
 DEF_HELPER_FLAGS_3(feq_d, TCG_CALL_NO_RWG, tl, env, i64, i64)
 DEF_HELPER_FLAGS_2(fcvt_w_d, TCG_CALL_NO_RWG, tl, env, i64)
+DEF_HELPER_FLAGS_2(fcvtmod_w_d, TCG_CALL_NO_RWG, i64, env, i64)
 DEF_HELPER_FLAGS_2(fcvt_wu_d, TCG_CALL_NO_RWG, tl, env, i64)
 DEF_HELPER_FLAGS_2(fcvt_l_d, TCG_CALL_NO_RWG, tl, env, i64)
 DEF_HELPER_FLAGS_2(fcvt_lu_d, TCG_CALL_NO_RWG, tl, env, i64)
@@ -62,6 +73,8 @@ DEF_HELPER_FLAGS_2(fcvt_d_wu, TCG_CALL_NO_RWG, i64, env, tl)
 DEF_HELPER_FLAGS_2(fcvt_d_l, TCG_CALL_NO_RWG, i64, env, tl)
 DEF_HELPER_FLAGS_2(fcvt_d_lu, TCG_CALL_NO_RWG, i64, env, tl)
 DEF_HELPER_FLAGS_1(fclass_d, TCG_CALL_NO_RWG_SE, tl, i64)
+DEF_HELPER_FLAGS_2(fround_d, TCG_CALL_NO_RWG_SE, i64, env, i64)
+DEF_HELPER_FLAGS_2(froundnx_d, TCG_CALL_NO_RWG_SE, i64, env, i64)
 
 /* Bitmanip */
 DEF_HELPER_FLAGS_2(clmul, TCG_CALL_NO_RWG_SE, tl, tl, tl)
@@ -78,10 +91,14 @@ DEF_HELPER_FLAGS_3(fsub_h, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(fmul_h, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(fdiv_h, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(fmin_h, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(fminm_h, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(fmax_h, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(fmaxm_h, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_2(fsqrt_h, TCG_CALL_NO_RWG, i64, env, i64)
 DEF_HELPER_FLAGS_3(fle_h, TCG_CALL_NO_RWG, tl, env, i64, i64)
+DEF_HELPER_FLAGS_3(fleq_h, TCG_CALL_NO_RWG, tl, env, i64, i64)
 DEF_HELPER_FLAGS_3(flt_h, TCG_CALL_NO_RWG, tl, env, i64, i64)
+DEF_HELPER_FLAGS_3(fltq_h, TCG_CALL_NO_RWG, tl, env, i64, i64)
 DEF_HELPER_FLAGS_3(feq_h, TCG_CALL_NO_RWG, tl, env, i64, i64)
 DEF_HELPER_FLAGS_2(fcvt_s_h, TCG_CALL_NO_RWG, i64, env, i64)
 DEF_HELPER_FLAGS_2(fcvt_h_s, TCG_CALL_NO_RWG, i64, env, i64)
@@ -96,6 +113,8 @@ DEF_HELPER_FLAGS_2(fcvt_h_wu, TCG_CALL_NO_RWG, i64, env, tl)
 DEF_HELPER_FLAGS_2(fcvt_h_l, TCG_CALL_NO_RWG, i64, env, tl)
 DEF_HELPER_FLAGS_2(fcvt_h_lu, TCG_CALL_NO_RWG, i64, env, tl)
 DEF_HELPER_FLAGS_2(fclass_h, TCG_CALL_NO_RWG_SE, tl, env, i64)
+DEF_HELPER_FLAGS_2(fround_h, TCG_CALL_NO_RWG_SE, i64, env, i64)
+DEF_HELPER_FLAGS_2(froundnx_h, TCG_CALL_NO_RWG_SE, i64, env, i64)
 
 /* Cache-block operations */
 DEF_HELPER_2(cbo_clean_flush, void, env, tl)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 73d5d1b045..facf730c2a 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -821,6 +821,32 @@ binvi      01101. ........... 001 ..... 0010011 @sh
 bset       0010100 .......... 001 ..... 0110011 @r
 bseti      00101. ........... 001 ..... 0010011 @sh
 
+# *** Zfa Standard Extension ***
+fli_s       1111000 00001 ..... 000 ..... 1010011 @r2
+fli_d       1111001 00001 ..... 000 ..... 1010011 @r2
+fli_h       1111010 00001 ..... 000 ..... 1010011 @r2
+fminm_s     0010100 ..... ..... 010 ..... 1010011 @r
+fmaxm_s     0010100 ..... ..... 011 ..... 1010011 @r
+fminm_d     0010101 ..... ..... 010 ..... 1010011 @r
+fmaxm_d     0010101 ..... ..... 011 ..... 1010011 @r
+fminm_h     0010110 ..... ..... 010 ..... 1010011 @r
+fmaxm_h     0010110 ..... ..... 011 ..... 1010011 @r
+fround_s    0100000 00100 ..... ... ..... 1010011 @r2_rm
+froundnx_s  0100000 00101 ..... ... ..... 1010011 @r2_rm
+fround_d    0100001 00100 ..... ... ..... 1010011 @r2_rm
+froundnx_d  0100001 00101 ..... ... ..... 1010011 @r2_rm
+fround_h    0100010 00100 ..... ... ..... 1010011 @r2_rm
+froundnx_h  0100010 00101 ..... ... ..... 1010011 @r2_rm
+fcvtmod_w_d 1100001 01000 ..... 001 ..... 1010011 @r2
+fmvh_x_d    1110001 00001 ..... 000 ..... 1010011 @r2
+fmvp_d_x    1011001 ..... ..... 000 ..... 1010011 @r
+fleq_s      1010000 ..... ..... 100 ..... 1010011 @r
+fltq_s      1010000 ..... ..... 101 ..... 1010011 @r
+fleq_d      1010001 ..... ..... 100 ..... 1010011 @r
+fltq_d      1010001 ..... ..... 101 ..... 1010011 @r
+fleq_h      1010010 ..... ..... 100 ..... 1010011 @r
+fltq_h      1010010 ..... ..... 101 ..... 1010011 @r
+
 # *** RV32 Zfh Extension ***
 flh        ............   ..... 001 ..... 0000111 @i
 fsh        .......  ..... ..... 001 ..... 0100111 @s
diff --git a/target/riscv/insn_trans/trans_rvzfa.c.inc b/target/riscv/insn_trans/trans_rvzfa.c.inc
new file mode 100644
index 0000000000..1b76c904f4
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvzfa.c.inc
@@ -0,0 +1,521 @@
+/*
+ * RISC-V translation routines for the Zfa Standard Extension.
+ *
+ * Copyright (c) 2023 Christoph Müllner, christoph.muellner@vrull.eu
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define REQUIRE_ZFA(ctx) do {     \
+    if (!ctx->cfg_ptr->ext_zfa) { \
+        return false;             \
+    }                             \
+} while (0)
+
+#define REQUIRE_ZFH(ctx) do {     \
+    if (!ctx->cfg_ptr->ext_zfh) { \
+        return false;             \
+    }                             \
+} while (0)
+
+static bool trans_fli_s(DisasContext *ctx, arg_fli_s *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZFA(ctx);
+    REQUIRE_EXT(ctx, RVF);
+
+    /* Values below are NaN-boxed to avoid a gen_nanbox_s(). */
+    static const uint64_t fli_s_table[] = {
+        0xffffffffbf800000,  /* -1.0 */
+        0xffffffff00800000,  /* minimum positive normal */
+        0xffffffff37800000,  /* 1.0 * 2^-16 */
+        0xffffffff38000000,  /* 1.0 * 2^-15 */
+        0xffffffff3b800000,  /* 1.0 * 2^-8  */
+        0xffffffff3c000000,  /* 1.0 * 2^-7  */
+        0xffffffff3d800000,  /* 1.0 * 2^-4  */
+        0xffffffff3e000000,  /* 1.0 * 2^-3  */
+        0xffffffff3e800000,  /* 0.25 */
+        0xffffffff3ea00000,  /* 0.3125 */
+        0xffffffff3ec00000,  /* 0.375 */
+        0xffffffff3ee00000,  /* 0.4375 */
+        0xffffffff3f000000,  /* 0.5 */
+        0xffffffff3f200000,  /* 0.625 */
+        0xffffffff3f400000,  /* 0.75 */
+        0xffffffff3f600000,  /* 0.875 */
+        0xffffffff3f800000,  /* 1.0 */
+        0xffffffff3fa00000,  /* 1.25 */
+        0xffffffff3fc00000,  /* 1.5 */
+        0xffffffff3fe00000,  /* 1.75 */
+        0xffffffff40000000,  /* 2.0 */
+        0xffffffff40200000,  /* 2.5 */
+        0xffffffff40400000,  /* 3 */
+        0xffffffff40800000,  /* 4 */
+        0xffffffff41000000,  /* 8 */
+        0xffffffff41800000,  /* 16 */
+        0xffffffff43000000,  /* 2^7 */
+        0xffffffff43800000,  /* 2^8 */
+        0xffffffff47000000,  /* 2^15 */
+        0xffffffff47800000,  /* 2^16 */
+        0xffffffff7f800000,  /* +inf */
+        0xffffffff7fc00000,  /* Canonical NaN */
+    };
+
+    TCGv_i64 dest = dest_fpr(ctx, a->rd);
+    tcg_gen_movi_i64(dest, fli_s_table[a->rs1]);
+    gen_set_fpr_hs(ctx, a->rd, dest);
+
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+static bool trans_fli_d(DisasContext *ctx, arg_fli_d *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZFA(ctx);
+    REQUIRE_EXT(ctx, RVD);
+
+    static const uint64_t fli_d_table[] = {
+        0xbff0000000000000,  /* -1.0 */
+        0x0010000000000000,  /* minimum positive normal */
+        0x3ef0000000000000,  /* 1.0 * 2^-16 */
+        0x3f00000000000000,  /* 1.0 * 2^-15 */
+        0x3f70000000000000,  /* 1.0 * 2^-8  */
+        0x3f80000000000000,  /* 1.0 * 2^-7  */
+        0x3fb0000000000000,  /* 1.0 * 2^-4  */
+        0x3fc0000000000000,  /* 1.0 * 2^-3  */
+        0x3fd0000000000000,  /* 0.25 */
+        0x3fd4000000000000,  /* 0.3125 */
+        0x3fd8000000000000,  /* 0.375 */
+        0x3fdc000000000000,  /* 0.4375 */
+        0x3fe0000000000000,  /* 0.5 */
+        0x3fe4000000000000,  /* 0.625 */
+        0x3fe8000000000000,  /* 0.75 */
+        0x3fec000000000000,  /* 0.875 */
+        0x3ff0000000000000,  /* 1.0 */
+        0x3ff4000000000000,  /* 1.25 */
+        0x3ff8000000000000,  /* 1.5 */
+        0x3ffc000000000000,  /* 1.75 */
+        0x4000000000000000,  /* 2.0 */
+        0x4004000000000000,  /* 2.5 */
+        0x4008000000000000,  /* 3 */
+        0x4010000000000000,  /* 4 */
+        0x4020000000000000,  /* 8 */
+        0x4030000000000000,  /* 16 */
+        0x4060000000000000,  /* 2^7 */
+        0x4070000000000000,  /* 2^8 */
+        0x40e0000000000000,  /* 2^15 */
+        0x40f0000000000000,  /* 2^16 */
+        0x7ff0000000000000,  /* +inf */
+        0x7ff8000000000000,  /* Canonical NaN */
+    };
+
+    TCGv_i64 dest = dest_fpr(ctx, a->rd);
+    tcg_gen_movi_i64(dest, fli_d_table[a->rs1]);
+    gen_set_fpr_d(ctx, a->rd, dest);
+
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+static bool trans_fli_h(DisasContext *ctx, arg_fli_h *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZFA(ctx);
+    REQUIRE_ZFH(ctx);
+
+    /* Values below are NaN-boxed to avoid a gen_nanbox_h(). */
+    static const uint64_t fli_h_table[] = {
+        0xffffffffffffbc00,  /* -1.0 */
+        0xffffffffffff0400,  /* minimum positive normal */
+        0xffffffffffff0100,  /* 1.0 * 2^-16 */
+        0xffffffffffff0200,  /* 1.0 * 2^-15 */
+        0xffffffffffff1c00,  /* 1.0 * 2^-8  */
+        0xffffffffffff2000,  /* 1.0 * 2^-7  */
+        0xffffffffffff2c00,  /* 1.0 * 2^-4  */
+        0xffffffffffff3000,  /* 1.0 * 2^-3  */
+        0xffffffffffff3400,  /* 0.25 */
+        0xffffffffffff3500,  /* 0.3125 */
+        0xffffffffffff3600,  /* 0.375 */
+        0xffffffffffff3700,  /* 0.4375 */
+        0xffffffffffff3800,  /* 0.5 */
+        0xffffffffffff3900,  /* 0.625 */
+        0xffffffffffff3a00,  /* 0.75 */
+        0xffffffffffff3b00,  /* 0.875 */
+        0xffffffffffff3c00,  /* 1.0 */
+        0xffffffffffff3d00,  /* 1.25 */
+        0xffffffffffff3e00,  /* 1.5 */
+        0xffffffffffff3f00,  /* 1.75 */
+        0xffffffffffff4000,  /* 2.0 */
+        0xffffffffffff4100,  /* 2.5 */
+        0xffffffffffff4200,  /* 3 */
+        0xffffffffffff4400,  /* 4 */
+        0xffffffffffff4800,  /* 8 */
+        0xffffffffffff4c00,  /* 16 */
+        0xffffffffffff5800,  /* 2^7 */
+        0xffffffffffff5c00,  /* 2^8 */
+        0xffffffffffff7800,  /* 2^15 */
+        0xffffffffffff7c00,  /* 2^16 */
+        0xffffffffffff7c00,  /* +inf */
+        0xffffffffffff7e00,  /* Canonical NaN */
+    };
+
+    TCGv_i64 dest = dest_fpr(ctx, a->rd);
+    tcg_gen_movi_i64(dest, fli_h_table[a->rs1]);
+    gen_set_fpr_hs(ctx, a->rd, dest);
+
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+static bool trans_fminm_s(DisasContext *ctx, arg_fminm_s *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZFA(ctx);
+    REQUIRE_EXT(ctx, RVF);
+
+    TCGv_i64 dest = dest_fpr(ctx, a->rd);
+    TCGv_i64 src1 = get_fpr_hs(ctx, a->rs1);
+    TCGv_i64 src2 = get_fpr_hs(ctx, a->rs2);
+
+    gen_helper_fminm_s(dest, cpu_env, src1, src2);
+    gen_set_fpr_hs(ctx, a->rd, dest);
+
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+static bool trans_fmaxm_s(DisasContext *ctx, arg_fmaxm_s *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZFA(ctx);
+    REQUIRE_EXT(ctx, RVF);
+
+    TCGv_i64 dest = dest_fpr(ctx, a->rd);
+    TCGv_i64 src1 = get_fpr_hs(ctx, a->rs1);
+    TCGv_i64 src2 = get_fpr_hs(ctx, a->rs2);
+
+    gen_helper_fmaxm_s(dest, cpu_env, src1, src2);
+    gen_set_fpr_hs(ctx, a->rd, dest);
+
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+static bool trans_fminm_d(DisasContext *ctx, arg_fminm_d *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZFA(ctx);
+    REQUIRE_EXT(ctx, RVD);
+
+    TCGv_i64 dest = dest_fpr(ctx, a->rd);
+    TCGv_i64 src1 = get_fpr_d(ctx, a->rs1);
+    TCGv_i64 src2 = get_fpr_d(ctx, a->rs2);
+
+    gen_helper_fminm_d(dest, cpu_env, src1, src2);
+    gen_set_fpr_d(ctx, a->rd, dest);
+
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+static bool trans_fmaxm_d(DisasContext *ctx, arg_fmaxm_d *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZFA(ctx);
+    REQUIRE_EXT(ctx, RVD);
+
+    TCGv_i64 dest = dest_fpr(ctx, a->rd);
+    TCGv_i64 src1 = get_fpr_d(ctx, a->rs1);
+    TCGv_i64 src2 = get_fpr_d(ctx, a->rs2);
+
+    gen_helper_fmaxm_d(dest, cpu_env, src1, src2);
+    gen_set_fpr_d(ctx, a->rd, dest);
+
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+static bool trans_fminm_h(DisasContext *ctx, arg_fminm_h *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZFA(ctx);
+    REQUIRE_ZFH(ctx);
+
+    TCGv_i64 dest = dest_fpr(ctx, a->rd);
+    TCGv_i64 src1 = get_fpr_hs(ctx, a->rs1);
+    TCGv_i64 src2 = get_fpr_hs(ctx, a->rs2);
+
+    gen_helper_fminm_h(dest, cpu_env, src1, src2);
+    gen_set_fpr_hs(ctx, a->rd, dest);
+
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+static bool trans_fmaxm_h(DisasContext *ctx, arg_fmaxm_h *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZFA(ctx);
+    REQUIRE_ZFH(ctx);
+
+    TCGv_i64 dest = dest_fpr(ctx, a->rd);
+    TCGv_i64 src1 = get_fpr_hs(ctx, a->rs1);
+    TCGv_i64 src2 = get_fpr_hs(ctx, a->rs2);
+
+    gen_helper_fmaxm_h(dest, cpu_env, src1, src2);
+    gen_set_fpr_hs(ctx, a->rd, dest);
+
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+static bool trans_fround_s(DisasContext *ctx, arg_fround_s *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZFA(ctx);
+    REQUIRE_EXT(ctx, RVF);
+
+    TCGv_i64 dest = dest_fpr(ctx, a->rd);
+    TCGv_i64 src1 = get_fpr_hs(ctx, a->rs1);
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fround_s(dest, cpu_env, src1);
+    gen_set_fpr_hs(ctx, a->rd, dest);
+
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+static bool trans_froundnx_s(DisasContext *ctx, arg_froundnx_s *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZFA(ctx);
+    REQUIRE_EXT(ctx, RVF);
+
+    TCGv_i64 dest = dest_fpr(ctx, a->rd);
+    TCGv_i64 src1 = get_fpr_hs(ctx, a->rs1);
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_froundnx_s(dest, cpu_env, src1);
+    gen_set_fpr_hs(ctx, a->rd, dest);
+
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+static bool trans_fround_d(DisasContext *ctx, arg_fround_d *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZFA(ctx);
+    REQUIRE_EXT(ctx, RVD);
+
+    TCGv_i64 dest = dest_fpr(ctx, a->rd);
+    TCGv_i64 src1 = get_fpr_d(ctx, a->rs1);
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fround_d(dest, cpu_env, src1);
+    gen_set_fpr_hs(ctx, a->rd, dest);
+
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+static bool trans_froundnx_d(DisasContext *ctx, arg_froundnx_d *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZFA(ctx);
+    REQUIRE_EXT(ctx, RVD);
+
+    TCGv_i64 dest = dest_fpr(ctx, a->rd);
+    TCGv_i64 src1 = get_fpr_d(ctx, a->rs1);
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_froundnx_d(dest, cpu_env, src1);
+    gen_set_fpr_hs(ctx, a->rd, dest);
+
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+static bool trans_fround_h(DisasContext *ctx, arg_fround_h *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZFA(ctx);
+    REQUIRE_ZFH(ctx);
+
+    TCGv_i64 dest = dest_fpr(ctx, a->rd);
+    TCGv_i64 src1 = get_fpr_hs(ctx, a->rs1);
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fround_h(dest, cpu_env, src1);
+    gen_set_fpr_hs(ctx, a->rd, dest);
+
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+static bool trans_froundnx_h(DisasContext *ctx, arg_froundnx_h *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZFA(ctx);
+    REQUIRE_ZFH(ctx);
+
+    TCGv_i64 dest = dest_fpr(ctx, a->rd);
+    TCGv_i64 src1 = get_fpr_hs(ctx, a->rs1);
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_froundnx_h(dest, cpu_env, src1);
+    gen_set_fpr_hs(ctx, a->rd, dest);
+
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+bool trans_fcvtmod_w_d(DisasContext *ctx, arg_fcvtmod_w_d *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZFA(ctx);
+    REQUIRE_EXT(ctx, RVD);
+
+    TCGv dst = dest_gpr(ctx, a->rd);
+    TCGv_i64 src1 = get_fpr_d(ctx, a->rs1);
+    TCGv_i64 t1 = tcg_temp_new_i64();
+
+    /* Rounding mode is RTZ. */
+    gen_set_rm(ctx, RISCV_FRM_RTZ);
+    gen_helper_fcvtmod_w_d(t1, cpu_env, src1);
+    tcg_gen_trunc_i64_tl(dst, t1);
+    gen_set_gpr(ctx, a->rd, dst);
+
+    return true;
+}
+
+bool trans_fmvh_x_d(DisasContext *ctx, arg_fmvh_x_d *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZFA(ctx);
+    REQUIRE_EXT(ctx, RVD);
+    REQUIRE_32BIT(ctx);
+
+    TCGv dst = dest_gpr(ctx, a->rd);
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    tcg_gen_sari_i64(dst, cpu_fpr[a->rs1], 32);
+    tcg_gen_trunc_i64_tl(dst, t1);
+    gen_set_gpr(ctx, a->rd, dst);
+    return true;
+}
+
+bool trans_fmvp_d_x(DisasContext *ctx, arg_fmvp_d_x *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZFA(ctx);
+    REQUIRE_EXT(ctx, RVD);
+    REQUIRE_32BIT(ctx);
+
+    TCGv src1 = get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);
+    tcg_gen_concat_tl_i64(cpu_fpr[a->rd], src1, src2);
+
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+bool trans_fleq_s(DisasContext *ctx, arg_fleq_s *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZFA(ctx);
+    REQUIRE_EXT(ctx, RVF);
+
+    TCGv dest = dest_gpr(ctx, a->rd);
+    TCGv_i64 src1 = get_fpr_hs(ctx, a->rs1);
+    TCGv_i64 src2 = get_fpr_hs(ctx, a->rs2);
+
+    gen_helper_fleq_s(dest, cpu_env, src1, src2);
+    gen_set_gpr(ctx, a->rd, dest);
+    return true;
+}
+
+bool trans_fltq_s(DisasContext *ctx, arg_fltq_s *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZFA(ctx);
+    REQUIRE_EXT(ctx, RVF);
+
+    TCGv dest = dest_gpr(ctx, a->rd);
+    TCGv_i64 src1 = get_fpr_hs(ctx, a->rs1);
+    TCGv_i64 src2 = get_fpr_hs(ctx, a->rs2);
+
+    gen_helper_fltq_s(dest, cpu_env, src1, src2);
+    gen_set_gpr(ctx, a->rd, dest);
+    return true;
+}
+
+bool trans_fleq_d(DisasContext *ctx, arg_fleq_d *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZFA(ctx);
+    REQUIRE_EXT(ctx, RVD);
+
+    TCGv dest = dest_gpr(ctx, a->rd);
+    TCGv_i64 src1 = get_fpr_hs(ctx, a->rs1);
+    TCGv_i64 src2 = get_fpr_hs(ctx, a->rs2);
+
+    gen_helper_fltq_s(dest, cpu_env, src1, src2);
+    gen_set_gpr(ctx, a->rd, dest);
+    return true;
+}
+
+bool trans_fltq_d(DisasContext *ctx, arg_fltq_d *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZFA(ctx);
+    REQUIRE_EXT(ctx, RVD);
+
+    TCGv dest = dest_gpr(ctx, a->rd);
+    TCGv_i64 src1 = get_fpr_hs(ctx, a->rs1);
+    TCGv_i64 src2 = get_fpr_hs(ctx, a->rs2);
+
+    gen_helper_fltq_s(dest, cpu_env, src1, src2);
+    gen_set_gpr(ctx, a->rd, dest);
+    return true;
+}
+
+bool trans_fleq_h(DisasContext *ctx, arg_fleq_h *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZFA(ctx);
+    REQUIRE_ZFH(ctx);
+
+    TCGv dest = dest_gpr(ctx, a->rd);
+    TCGv_i64 src1 = get_fpr_hs(ctx, a->rs1);
+    TCGv_i64 src2 = get_fpr_hs(ctx, a->rs2);
+
+    gen_helper_fleq_h(dest, cpu_env, src1, src2);
+    gen_set_gpr(ctx, a->rd, dest);
+    return true;
+}
+
+bool trans_fltq_h(DisasContext *ctx, arg_fltq_h *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZFA(ctx);
+    REQUIRE_ZFH(ctx);
+
+    TCGv dest = dest_gpr(ctx, a->rd);
+    TCGv_i64 src1 = get_fpr_hs(ctx, a->rs1);
+    TCGv_i64 src2 = get_fpr_hs(ctx, a->rs2);
+
+    gen_helper_fltq_h(dest, cpu_env, src1, src2);
+    gen_set_gpr(ctx, a->rd, dest);
+    return true;
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 8a33da811e..388ea95845 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1104,6 +1104,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_rvzicond.c.inc"
 #include "insn_trans/trans_rvzawrs.c.inc"
 #include "insn_trans/trans_rvzicbo.c.inc"
+#include "insn_trans/trans_rvzfa.c.inc"
 #include "insn_trans/trans_rvzfh.c.inc"
 #include "insn_trans/trans_rvk.c.inc"
 #include "insn_trans/trans_privileged.c.inc"
diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefile.target
index 9973ba3b5f..4016050680 100644
--- a/tests/tcg/riscv64/Makefile.target
+++ b/tests/tcg/riscv64/Makefile.target
@@ -9,3 +9,9 @@ TESTS += noexec
 TESTS += test-noc
 test-noc: LDFLAGS = -nostdlib -static
 run-test-noc: QEMU_OPTS += -cpu rv64,c=false
+
+# Test for fcvtmod
+TESTS += test-fcvtmod
+test-fcvtmod: CFLAGS += -march=rv64imafdc
+test-fcvtmod: LDFLAGS += -static
+run-test-fcvtmod: QEMU_OPTS += -cpu rv64,d=true,Zfa=true
diff --git a/tests/tcg/riscv64/test-fcvtmod.c b/tests/tcg/riscv64/test-fcvtmod.c
new file mode 100644
index 0000000000..f050579974
--- /dev/null
+++ b/tests/tcg/riscv64/test-fcvtmod.c
@@ -0,0 +1,345 @@
+#include <stdio.h>
+#include <stddef.h>
+#include <stdint.h>
+
+#define FFLAG_NX_SHIFT 0 /* inexact */
+#define FFLAG_UF_SHIFT 1 /* underflow */
+#define FFLAG_OF_SHIFT 2 /* overflow */
+#define FFLAG_DZ_SHIFT 3 /* divide by zero */
+#define FFLAG_NV_SHIFT 4 /* invalid operation */
+
+#define FFLAG_NV (1UL << FFLAG_NV_SHIFT)
+#define FFLAG_DZ (1UL << FFLAG_DZ_SHIFT)
+#define FFLAG_OF (1UL << FFLAG_OF_SHIFT)
+#define FFLAG_UF (1UL << FFLAG_UF_SHIFT)
+#define FFLAG_NX (1UL << FFLAG_NX_SHIFT)
+
+typedef struct fp64_fcvt_fcvtmod_testcase {
+    const char* name;
+    union {
+        uint64_t inp_lu;
+        double inp_lf;
+    };
+    uint64_t exp_fcvt;
+    uint8_t exp_fcvt_fflags;
+    uint64_t exp_fcvtmod;
+    uint8_t exp_fcvtmod_fflags;
+} fp64_fcvt_fcvtmod_testcase_t;
+
+void print_fflags(uint8_t fflags)
+{
+    int set = 0;
+
+    if (fflags == 0) {
+        printf("-");
+        return;
+    }
+
+    if (fflags & FFLAG_NV) {
+        printf("%sFFLAG_NV", set ? " | " : "");
+        set = 1;
+    }
+    if (fflags & FFLAG_DZ) {
+        printf("%sFFLAG_DZ", set ? " | " : "");
+        set = 1;
+    }
+    if (fflags & FFLAG_OF) {
+        printf("%sFFLAG_OF", set ? " | " : "");
+        set = 1;
+    }
+    if (fflags & FFLAG_UF) {
+        printf("%sFFLAG_UF", set ? " | " : "");
+        set = 1;
+    }
+    if (fflags & FFLAG_NX) {
+        printf("%sFFLAG_NX", set ? " | " : "");
+        set = 1;
+    }
+}
+
+/* Clear all FP flags. */
+static inline void clear_fflags()
+{
+    __asm__ __volatile__("fsflags zero");
+}
+
+/* Read all FP flags. */
+static inline uint8_t get_fflags()
+{
+    uint64_t v;
+    __asm__ __volatile__("frflags %0" : "=r"(v));
+    return (uint8_t)v;
+}
+
+/* Move input value (without conversations) into an FP register. */
+static inline double do_fmv_d_x(uint64_t inp)
+{
+    double fpr;
+    __asm__ __volatile__("fmv.d.x %0, %1" : "=f"(fpr) : "r"(inp));
+    return fpr;
+}
+
+static inline uint64_t do_fcvt_w_d(uint64_t inp, uint8_t *fflags)
+{
+    uint64_t ret;
+    double fpr = do_fmv_d_x(inp);
+
+    clear_fflags();
+
+    __asm__ __volatile__("fcvt.w.d %0, %1, rtz" : "=r"(ret) : "f"(fpr));
+
+    *fflags = get_fflags();
+
+    return ret;
+}
+
+static inline uint64_t do_fcvtmod_w_d(uint64_t inp, uint8_t *fflags)
+{
+    uint64_t ret;
+    double fpr = do_fmv_d_x(inp);
+
+    clear_fflags();
+
+    /* fcvtmod.w.d rd, rs1, rtz = 1100001 01000 rs1 001 rd 1010011 */
+    asm(".insn r  0x53, 0x1, 0x61, %0, %1, f8" : "=r"(ret) : "f"(fpr));
+
+    *fflags = get_fflags();
+
+    return ret;
+}
+
+static const fp64_fcvt_fcvtmod_testcase_t tests[] = {
+    /* Zero (exp=0, frac=0) */
+    { .name = "+0.0",
+      .inp_lf = 0x0p0,
+      .exp_fcvt = 0x0000000000000000,
+      .exp_fcvt_fflags = 0,
+      .exp_fcvtmod = 0x0000000000000000,
+      .exp_fcvtmod_fflags = 0 },
+    { .name = "-0.0",
+      .inp_lf = -0x0p0,
+      .exp_fcvt = 0x0000000000000000,
+      .exp_fcvt_fflags = 0,
+      .exp_fcvtmod = 0x0000000000000000,
+      .exp_fcvtmod_fflags = 0 },
+
+    /* Subnormal: exp=0 frac!=0 */
+    { .name = "Subnormal frac=1",
+      .inp_lu = 0x0000000000000001,
+      .exp_fcvt = 0x0000000000000000,
+      .exp_fcvt_fflags = FFLAG_NX,
+      .exp_fcvtmod = 0,
+      .exp_fcvtmod_fflags = FFLAG_NX },
+    { .name = "Subnormal frac=0xf..f",
+      .inp_lu = 0x0000ffffffffffff,
+      .exp_fcvt = 0x0000000000000000,
+      .exp_fcvt_fflags = FFLAG_NX,
+      .exp_fcvtmod = 0,
+      .exp_fcvtmod_fflags = FFLAG_NX },
+    { .name = "Neg subnormal frac=1",
+      .inp_lu = 0x0000000000000001,
+      .exp_fcvt = 0x0000000000000000,
+      .exp_fcvt_fflags = FFLAG_NX,
+      .exp_fcvtmod = 0,
+      .exp_fcvtmod_fflags = FFLAG_NX },
+    { .name = "Neg subnormal frac=0xf..f",
+      .inp_lu = 0x8000ffffffffffff,
+      .exp_fcvt = 0x0000000000000000,
+      .exp_fcvt_fflags = FFLAG_NX,
+      .exp_fcvtmod = 0,
+      .exp_fcvtmod_fflags = FFLAG_NX },
+
+    /* Infinity: exp=0x7ff, frac=0 */
+    { .name = "+INF",
+      .inp_lu = 0x7ff0000000000000,
+      .exp_fcvt = 0x000000007fffffff, /* int32 max */
+      .exp_fcvt_fflags = FFLAG_NV,
+      .exp_fcvtmod = 0,
+      .exp_fcvtmod_fflags = FFLAG_NV },
+    { .name = "-INF",
+      .inp_lu = 0xfff0000000000000,
+      .exp_fcvt = 0xffffffff80000000, /* int32 min */
+      .exp_fcvt_fflags = FFLAG_NV,
+      .exp_fcvtmod = 0,
+      .exp_fcvtmod_fflags = FFLAG_NV },
+
+    /* NaN: exp=7ff, frac!=0 */
+    { .name = "canonical NaN",
+      .inp_lu = 0x7ff8000000000000,
+      .exp_fcvt = 0x000000007fffffff, /* int32 max */
+      .exp_fcvt_fflags = FFLAG_NV,
+      .exp_fcvtmod = 0,
+      .exp_fcvtmod_fflags = FFLAG_NV },
+    { .name = "non-canonical NaN",
+      .inp_lu = 0x7ff8000000100000,
+      .exp_fcvt = 0x000000007fffffff, /* int32 min */
+      .exp_fcvt_fflags = FFLAG_NV,
+      .exp_fcvtmod = 0,
+      .exp_fcvtmod_fflags = FFLAG_NV },
+
+    /* Normal numbers: exp!=0, exp!=7ff */
+    { .name = "+smallest normal value",
+      .inp_lu = 0x0010000000000000,
+      .exp_fcvt = 0,
+      .exp_fcvt_fflags = FFLAG_NX,
+      .exp_fcvtmod = 0,
+      .exp_fcvtmod_fflags = FFLAG_NX },
+    { .name = "-smallest normal value",
+      .inp_lu = 0x8010000000000000,
+      .exp_fcvt = 0,
+      .exp_fcvt_fflags = FFLAG_NX,
+      .exp_fcvtmod = 0,
+      .exp_fcvtmod_fflags = FFLAG_NX },
+
+    { .name = "+0.5",
+      .inp_lf = 0x1p-1,
+      .exp_fcvt = 0,
+      .exp_fcvt_fflags = FFLAG_NX,
+      .exp_fcvtmod = 0,
+      .exp_fcvtmod_fflags = FFLAG_NX },
+    { .name = "-0.5",
+      .inp_lf = -0x1p-1,
+      .exp_fcvt = 0,
+      .exp_fcvt_fflags = FFLAG_NX,
+      .exp_fcvtmod = 0,
+      .exp_fcvtmod_fflags = FFLAG_NX },
+
+    { .name = "+value just below 1.0",
+      .inp_lu = 0x3fefffffffffffff,
+      .exp_fcvt = 0,
+      .exp_fcvt_fflags = FFLAG_NX,
+      .exp_fcvtmod = 0,
+      .exp_fcvtmod_fflags = FFLAG_NX },
+    { .name = "-value just above -1.0",
+      .inp_lu = 0xbfefffffffffffff,
+      .exp_fcvt = 0,
+      .exp_fcvt_fflags = FFLAG_NX,
+      .exp_fcvtmod = 0,
+      .exp_fcvtmod_fflags = FFLAG_NX },
+
+    { .name = "+1.0",
+      .inp_lf = 0x1p0,
+      .exp_fcvt = 0x0000000000000001,
+      .exp_fcvt_fflags = 0,
+      .exp_fcvtmod = 0x0000000000000001,
+      .exp_fcvtmod_fflags = 0 },
+    { .name = "-1.0",
+      .inp_lf = -0x1p0,
+      .exp_fcvt = 0xffffffffffffffff,
+      .exp_fcvt_fflags = 0,
+      .exp_fcvtmod = 0xffffffffffffffff,
+      .exp_fcvtmod_fflags = 0 },
+
+    { .name = "+1.5",
+      .inp_lu = 0x3ff8000000000000,
+      .exp_fcvt = 1,
+      .exp_fcvt_fflags = FFLAG_NX,
+      .exp_fcvtmod = 1,
+      .exp_fcvtmod_fflags = FFLAG_NX },
+    { .name = "-1.5",
+      .inp_lu = 0xbff8000000000000,
+      .exp_fcvt = 0xffffffffffffffff,
+      .exp_fcvt_fflags = FFLAG_NX,
+      .exp_fcvtmod = 0xffffffffffffffff,
+      .exp_fcvtmod_fflags = FFLAG_NX },
+
+    { .name = "+max int32 (2147483647)",
+      .inp_lu = 0x41dfffffffc00000,
+      .exp_fcvt = 0x000000007fffffff,
+      .exp_fcvt_fflags = 0,
+      .exp_fcvtmod = 0x000000007fffffff,
+      .exp_fcvtmod_fflags = 0 },
+    { .name = "+max int32 +1 (2147483648)",
+      .inp_lf = 0x1p31,
+      .exp_fcvt = 0x000000007fffffff,
+      .exp_fcvt_fflags = FFLAG_NV,
+      .exp_fcvtmod = (uint64_t)-2147483648l, /* int32 min */
+      .exp_fcvtmod_fflags = FFLAG_NV },
+    { .name = "+max int32 +2 (2147483649)",
+      .inp_lu = 0x41e0000000200000,
+      .exp_fcvt = 0x000000007fffffff,
+      .exp_fcvt_fflags = FFLAG_NV,
+      .exp_fcvtmod = (uint64_t)-2147483647l, /* int32 min +1 */
+      .exp_fcvtmod_fflags = FFLAG_NV },
+
+    { .name = "-max int32 (-2147483648)",
+      .inp_lf = -0x1p31,
+      .exp_fcvt = 0xffffffff80000000,
+      .exp_fcvt_fflags = 0,
+      .exp_fcvtmod = 0xffffffff80000000,
+      .exp_fcvtmod_fflags = 0 },
+    { .name = "-max int32 -1 (-2147483649)",
+      .inp_lf = -0x1.00000002p+31,
+      .exp_fcvt = 0xffffffff80000000,
+      .exp_fcvt_fflags = FFLAG_NV,
+      .exp_fcvtmod = 2147483647, /* int32 max */
+      .exp_fcvtmod_fflags = FFLAG_NV },
+    { .name = "-max int32 -2 (-2147483650)",
+      .inp_lf = -0x1.00000004p+31,
+      .exp_fcvt = 0xffffffff80000000,
+      .exp_fcvt_fflags = FFLAG_NV,
+      .exp_fcvtmod = 2147483646, /* int32 max -1 */
+      .exp_fcvtmod_fflags = FFLAG_NV },
+};
+
+int run_fcvtmod_tests()
+{
+    uint64_t act_fcvt;
+    uint8_t act_fcvt_fflags;
+    uint64_t act_fcvtmod;
+    uint8_t act_fcvtmod_fflags;
+
+    for (size_t i = 0; i < sizeof(tests)/sizeof(tests[0]); i++) {
+        const fp64_fcvt_fcvtmod_testcase_t *t = &tests[i];
+
+        act_fcvt = do_fcvt_w_d(t->inp_lu, &act_fcvt_fflags);
+        int fcvt_correct = act_fcvt == t->exp_fcvt &&
+                    act_fcvt_fflags == t->exp_fcvt_fflags;
+        act_fcvtmod = do_fcvtmod_w_d(t->inp_lu, &act_fcvtmod_fflags);
+        int fcvtmod_correct = act_fcvtmod == t->exp_fcvtmod &&
+                       act_fcvtmod_fflags == t->exp_fcvtmod_fflags;
+
+        if (fcvt_correct && fcvtmod_correct) {
+            continue;
+        }
+
+        printf("Test %zu (%s) failed!\n", i, t->name);
+
+        double fpr = do_fmv_d_x(t->inp_lu);
+        printf("inp_lu: 0x%016lx == %lf\n", t->inp_lu, fpr);
+        printf("inp_lf: %lf\n", t->inp_lf);
+
+        uint32_t sign = (t->inp_lu >> 63);
+        uint32_t exp = (uint32_t)(t->inp_lu >> 52) & 0x7ff;
+        uint64_t frac = t->inp_lu & 0xfffffffffffffull; /* significand */
+        int true_exp = exp - 1023;
+        int shift = true_exp - 52;
+        uint64_t true_frac = frac | 1ull << 52;
+
+        printf("sign=%d, exp=0x%03x, frac=0x%012lx\n", sign, exp, frac);
+        printf("true_exp=%d, shift=%d, true_frac=0x%016lx\n", true_exp, shift, true_frac);
+
+        if (!fcvt_correct) {
+            printf("act_fcvt: 0x%016lx == %li\n", act_fcvt, act_fcvt);
+            printf("exp_fcvt: 0x%016lx == %li\n", t->exp_fcvt, t->exp_fcvt);
+            printf("act_fcvt_fflags: "); print_fflags(act_fcvt_fflags); printf("\n");
+            printf("exp_fcvt_fflags: "); print_fflags(t->exp_fcvt_fflags); printf("\n");
+        }
+
+        if (!fcvtmod_correct) {
+            printf("act_fcvtmod: 0x%016lx == %li\n", act_fcvtmod, act_fcvtmod);
+            printf("exp_fcvtmod: 0x%016lx == %li\n", t->exp_fcvtmod, t->exp_fcvtmod);
+            printf("act_fcvtmod_fflags: "); print_fflags(act_fcvtmod_fflags); printf("\n");
+            printf("exp_fcvtmod_fflags: "); print_fflags(t->exp_fcvtmod_fflags); printf("\n");
+        }
+
+        return 1;
+    }
+
+    return 0;
+}
+
+int main()
+{
+    return run_fcvtmod_tests();
+}
-- 
2.41.0


