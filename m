Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CF57D8CB0
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 03:08:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwBJE-0004Qi-DK; Thu, 26 Oct 2023 21:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <turtwig@utexas.edu>)
 id 1qw9OH-00016L-Vy
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 19:03:50 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <turtwig@utexas.edu>)
 id 1qw9OE-000214-SY
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 19:03:49 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1d542f05b9aso226296fac.1
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 16:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.edu; s=google; t=1698361419; x=1698966219; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=NmwjGbIcZ/ghsW2/DzEo2a2qfsLm/XHOaENBUllfvb8=;
 b=hwUoJXi8G+3RZAVe8zW9DlemEqJwn2w7SLvj56Q22dPgMeBJXQRNKKOn/kWorCavQG
 ZvHe1pG3TXZ1NVfeG3P1MllDjI5txVd9fwq9d2k4CQDgiYvizuvaCHCzBq1v296Oa/HL
 2QIorqUPVICaoPhHUUln0jVPuDpT4152Ir6ICkwaVfHyBDKmgVUyqxH+z+sSWt5+DI7Z
 B4MSIrP+7Cj0pzO9mXcuTECH7gxvLCEHyMs2r32LShymYwJGekmAL1k9oNG7m50Tz4o1
 tTjoqkQN2qDYgbyKmP3MpxGR/1SaIsc94qA4ozFUBrCMAkQoaYRofCO2C2R2lGExmndX
 Nyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698361419; x=1698966219;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NmwjGbIcZ/ghsW2/DzEo2a2qfsLm/XHOaENBUllfvb8=;
 b=tIIcamYGvIVVqaAtu5Dbrq3mQWWNHS1a+ReLis9moj9UCUWyG75J7ndYZs1VhwCnFg
 417DC5xj5h1miVJ90M/fOYMI4/rZfWG3nX4uL3E2NGKrkS1RPlKUxxobpc9US2pop7S/
 aRdXkfM73JtrIhddCfoO8oORRqOyHMIhTTcBNS5VUJWaJNAm/Wg61p6c1XXO3UVzQ5m3
 yFr9BJ+CPJyJQT28ZBxSd1RwZsg4GdPIlNptXXa2k5XcwRXwPs5BtgHVEcjsZQFTd/YL
 4o+dukmeCa4EcWqFUcsiaWnpgww+uRRtjWS8HAovGTjqzHw3D7+Zxw4RYUsuxMAllugn
 nmzw==
X-Gm-Message-State: AOJu0YwSuV4KTv+csX6k902OCxugn1Lo6CbM9G0IBSyDYbG5jpCsR8S8
 WAQbvwAYBQpTk4kpk4CkQiYNlTZIEhRkwrWhRtIXAH60FeJTTEkbwhE=
X-Google-Smtp-Source: AGHT+IFwNkIvE316Yl9mxoyBQ47Ge40FUPNYoaXxgt6Ay2NfnfQynuvADL/i8yQzgFujYyjW5iprIRaUU+i2eScUrPA=
X-Received: by 2002:a05:6870:af44:b0:1e9:8ab9:11ca with SMTP id
 uy4-20020a056870af4400b001e98ab911camr1116241oab.3.1698361419276; Thu, 26 Oct
 2023 16:03:39 -0700 (PDT)
MIME-Version: 1.0
From: Brendan Sweeney <turtwig@utexas.edu>
Date: Thu, 26 Oct 2023 18:03:28 -0500
Message-ID: <CAGPSXwJEdtqW=nx71oufZp64nK6tK=0rytVEcz4F-gfvCOXk2w@mail.gmail.com>
Subject: [PATCH] Support for the RISCV Zalasr extension
To: qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, liweiwei@iscas.ac.cn
Content-Type: multipart/alternative; boundary="00000000000018c2ec0608a695da"
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=turtwig@utexas.edu; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 26 Oct 2023 21:06:43 -0400
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

--00000000000018c2ec0608a695da
Content-Type: text/plain; charset="UTF-8"

From 4af1fca6e5c99578a5b80b834c22b70f6419639f Mon Sep 17 00:00:00 2001
From: Brendan Sweeney <turtwig@utexas.edu>
Date: Thu, 26 Oct 2023 17:01:29 -0500
Subject: [PATCH] Support for the RISCV Zalasr extension

Signed-off-by: Brendan Sweeney <turtwig@utexas.edu>
---
target/riscv/cpu.c | 2 +
target/riscv/cpu_cfg.h | 1 +
target/riscv/insn32.decode | 15 +++
target/riscv/insn_trans/trans_rvzalasr.c.inc | 112 +++++++++++++++++++
target/riscv/translate.c | 1 +
5 files changed, 131 insertions(+)
create mode 100644 target/riscv/insn_trans/trans_rvzalasr.c.inc

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ac4a6c7eec..a0414bd956 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -85,6 +85,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
+ ISA_EXT_DATA_ENTRY(zalasr, PRIV_VERSION_1_12_0, ext_zalasr),
ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
ISA_EXT_DATA_ENTRY(zfbfmin, PRIV_VERSION_1_12_0, ext_zfbfmin),
ISA_EXT_DATA_ENTRY(zfh, PRIV_VERSION_1_11_0, ext_zfh),
@@ -1248,6 +1249,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] =
{
MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
MULTI_EXT_CFG_BOOL("zawrs", ext_zawrs, true),
MULTI_EXT_CFG_BOOL("zfa", ext_zfa, true),
+ MULTI_EXT_CFG_BOOL("zalasr", ext_zalasr, true),
MULTI_EXT_CFG_BOOL("zfh", ext_zfh, false),
MULTI_EXT_CFG_BOOL("zfhmin", ext_zfhmin, false),
MULTI_EXT_CFG_BOOL("zve32f", ext_zve32f, false),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 0e6a0f245c..8e4f9282fd 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -76,6 +76,7 @@ struct RISCVCPUConfig {
bool ext_svpbmt;
bool ext_zdinx;
bool ext_zawrs;
+ bool ext_zalasr;
bool ext_zfa;
bool ext_zfbfmin;
bool ext_zfh;
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 33597fe2bb..ba95cdf964 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -70,6 +70,9 @@
@atom_ld ..... aq:1 rl:1 ..... ........ ..... ....... &atomic rs2=0 %rs1 %rd
@atom_st ..... aq:1 rl:1 ..... ........ ..... ....... &atomic %rs2 %rs1 %rd
+@l_aq ..... . rl:1 ..... ........ ..... ....... &atomic rs2=0 %rs1 %rd aq=1
+@s_rl ..... aq:1 . ..... ........ ..... ....... &atomic %rs2 %rs1 rd=0 rl=1
+
@r4_rm ..... .. ..... ..... ... ..... ....... %rs3 %rs2 %rs1 %rm %rd
@r_rm ....... ..... ..... ... ..... ....... %rs2 %rs1 %rm %rd
@@ -739,6 +742,18 @@ vsetvl 1000000 ..... ..... 111 ..... 1010111 @r
wrs_nto 000000001101 00000 000 00000 1110011
wrs_sto 000000011101 00000 000 00000 1110011
+# *** RV32 Zalasr Standard Extension ***
+lb_aq 00110 1 . 00000 ..... 000 ..... 0101111 @l_aq
+lh_aq 00110 1 . 00000 ..... 001 ..... 0101111 @l_aq
+lw_aq 00110 1 . 00000 ..... 010 ..... 0101111 @l_aq
+sb_rl 00111 . 1 ..... ..... 000 00000 0101111 @s_rl
+sh_rl 00111 . 1 ..... ..... 001 00000 0101111 @s_rl
+sw_rl 00111 . 1 ..... ..... 010 00000 0101111 @s_rl
+
+# *** RV64 Zalasr Standard Extension (in addition to RV32 Zalasr) ***
+ld_aq 00110 1 . 00000 ..... 011 ..... 0101111 @l_aq
+sd_rl 00111 . 1 ..... ..... 011 00000 0101111 @s_rl
+
# *** RV32 Zba Standard Extension ***
sh1add 0010000 .......... 010 ..... 0110011 @r
sh2add 0010000 .......... 100 ..... 0110011 @r
diff --git a/target/riscv/insn_trans/trans_rvzalasr.c.inc
b/target/riscv/insn_trans/trans_rvzalasr.c.inc
new file mode 100644
index 0000000000..cee81ce8b8
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvzalasr.c.inc
@@ -0,0 +1,112 @@
+/*
+ * RISC-V translation routines for the Zzlasr Standard Extension.
+ *
+ * Copyright (c) 2023 Brendan Sweeney, brs@berkeley.edu
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
with
+ * this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define REQUIRE_ZALASR(ctx) do { \
+ if (!ctx->cfg_ptr->ext_zalasr) { \
+ return false; \
+ } \
+} while (0)
+
+static bool gen_l_aq(DisasContext *ctx, arg_atomic *a, MemOp mop)
+{
+ TCGv src1;
+
+ decode_save_opc(ctx);
+ src1 = get_address(ctx, a->rs1, 0);
+ if (a->rl) {
+ tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+ }
+ tcg_gen_qemu_ld_tl(load_val, src1, ctx->mem_idx, mop);
+ if (a->aq) {
+ tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
+ }
+ /* Put data in load_val. */
+ gen_set_gpr(ctx, a->rd, load_val);
+
+ return true;
+}
+
+static bool trans_lb_aq(DisasContext *ctx, arg_lb_aq *a)
+{
+ REQUIRE_ZALASR(ctx);
+ return gen_l_aq(ctx, a, (MO_ALIGN | MO_SB));
+}
+
+static bool trans_lh_aq(DisasContext *ctx, arg_lh_aq *a)
+{
+ REQUIRE_ZALASR(ctx);
+ return gen_l_aq(ctx, a, (MO_ALIGN | MO_TESW));
+}
+
+static bool trans_lw_aq(DisasContext *ctx, arg_lw_aq *a)
+{
+ REQUIRE_ZALASR(ctx);
+ return gen_l_aq(ctx, a, (MO_ALIGN | MO_TESL));
+}
+
+static bool trans_ld_aq(DisasContext *ctx, arg_lw_aq *a)
+{
+ REQUIRE_ZALASR(ctx);
+ REQUIRE_64_OR_128BIT(ctx);
+ return gen_l_aq(ctx, a, (MO_ALIGN | MO_TESQ));
+}
+
+static bool gen_s_rl(DisasContext *ctx, arg_atomic *a, MemOp mop)
+{
+ TCGv src1, src2;
+
+ decode_save_opc(ctx);
+ src1 = get_address(ctx, a->rs1, 0);
+
+ src2 = get_gpr(ctx, a->rs2, EXT_NONE);
+
+ if (a->rl) {
+ tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+ }
+ tcg_gen_qemu_st_i64(src2, src1, ctx->mem_idx, mop);
+ if (a->aq) {
+ tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
+ }
+
+ return true;
+}
+
+static bool trans_sb_rl(DisasContext *ctx, arg_sb_rl *a)
+{
+ REQUIRE_ZALASR(ctx);
+ return gen_s_rl(ctx, a, (MO_ALIGN | MO_SB));
+}
+
+static bool trans_sh_rl(DisasContext *ctx, arg_sh_rl *a)
+{
+ REQUIRE_ZALASR(ctx);
+ return gen_s_rl(ctx, a, (MO_ALIGN | MO_TESW));
+}
+
+static bool trans_sw_rl(DisasContext *ctx, arg_sw_rl *a)
+{
+ REQUIRE_ZALASR(ctx);
+ return gen_s_rl(ctx, a, (MO_ALIGN | MO_TESL));
+}
+
+static bool trans_sd_rl(DisasContext *ctx, arg_sd_rl *a)
+{
+ REQUIRE_ZALASR(ctx);
+ REQUIRE_64_OR_128BIT(ctx);
+ return gen_s_rl(ctx, a, (MO_ALIGN | MO_TEUQ));
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index f0be79bb16..bfcf1ff1d8 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1091,6 +1091,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase,
target_ulong pc)
#include "insn_trans/trans_rvzicond.c.inc"
#include "insn_trans/trans_rvzawrs.c.inc"
#include "insn_trans/trans_rvzicbo.c.inc"
+#include "insn_trans/trans_rvzalasr.c.inc"
#include "insn_trans/trans_rvzfa.c.inc"
#include "insn_trans/trans_rvzfh.c.inc"
#include "insn_trans/trans_rvk.c.inc"
--
2.32.1 (Apple Git-133)

--00000000000018c2ec0608a695da
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">From 4af1fca6e5c99578a5b80b834c22b70f6419639f Mon Sep 17 0=
0:00:00 2001<br>From: Brendan Sweeney &lt;<a href=3D"mailto:turtwig@utexas.=
edu">turtwig@utexas.edu</a>&gt;<br>Date: Thu, 26 Oct 2023 17:01:29 -0500<br=
>Subject: [PATCH] Support for the RISCV Zalasr extension<br><br>Signed-off-=
by: Brendan Sweeney &lt;<a href=3D"mailto:turtwig@utexas.edu">turtwig@utexa=
s.edu</a>&gt;<br>---<br>target/riscv/cpu.c | 2 +<br>target/riscv/cpu_cfg.h =
| 1 +<br>target/riscv/insn32.decode | 15 +++<br>target/riscv/insn_trans/tra=
ns_rvzalasr.c.inc | 112 +++++++++++++++++++<br>target/riscv/translate.c | 1=
 +<br>5 files changed, 131 insertions(+)<br>create mode 100644 target/riscv=
/insn_trans/trans_rvzalasr.c.inc<br><br>diff --git a/target/riscv/cpu.c b/t=
arget/riscv/cpu.c<br>index ac4a6c7eec..a0414bd956 100644<br>--- a/target/ri=
scv/cpu.c<br>+++ b/target/riscv/cpu.c<br>@@ -85,6 +85,7 @@ const RISCVIsaEx=
tData isa_edata_arr[] =3D {<br>ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION=
_1_10_0, ext_zihintpause),<br>ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0=
, ext_zmmul),<br>ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),=
<br>+ ISA_EXT_DATA_ENTRY(zalasr, PRIV_VERSION_1_12_0, ext_zalasr),<br>ISA_E=
XT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),<br>ISA_EXT_DATA_ENTRY(zfb=
fmin, PRIV_VERSION_1_12_0, ext_zfbfmin),<br>ISA_EXT_DATA_ENTRY(zfh, PRIV_VE=
RSION_1_11_0, ext_zfh),<br>@@ -1248,6 +1249,7 @@ const RISCVCPUMultiExtConf=
ig riscv_cpu_extensions[] =3D {<br>MULTI_EXT_CFG_BOOL(&quot;zihintpause&quo=
t;, ext_zihintpause, true),<br>MULTI_EXT_CFG_BOOL(&quot;zawrs&quot;, ext_za=
wrs, true),<br>MULTI_EXT_CFG_BOOL(&quot;zfa&quot;, ext_zfa, true),<br>+ MUL=
TI_EXT_CFG_BOOL(&quot;zalasr&quot;, ext_zalasr, true),<br>MULTI_EXT_CFG_BOO=
L(&quot;zfh&quot;, ext_zfh, false),<br>MULTI_EXT_CFG_BOOL(&quot;zfhmin&quot=
;, ext_zfhmin, false),<br>MULTI_EXT_CFG_BOOL(&quot;zve32f&quot;, ext_zve32f=
, false),<br>diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h<b=
r>index 0e6a0f245c..8e4f9282fd 100644<br>--- a/target/riscv/cpu_cfg.h<br>++=
+ b/target/riscv/cpu_cfg.h<br>@@ -76,6 +76,7 @@ struct RISCVCPUConfig {<br>=
bool ext_svpbmt;<br>bool ext_zdinx;<br>bool ext_zawrs;<br>+ bool ext_zalasr=
;<br>bool ext_zfa;<br>bool ext_zfbfmin;<br>bool ext_zfh;<br>diff --git a/ta=
rget/riscv/insn32.decode b/target/riscv/insn32.decode<br>index 33597fe2bb..=
ba95cdf964 100644<br>--- a/target/riscv/insn32.decode<br>+++ b/target/riscv=
/insn32.decode<br>@@ -70,6 +70,9 @@<br>@atom_ld ..... aq:1 rl:1 ..... .....=
... ..... ....... &amp;atomic rs2=3D0 %rs1 %rd<br>@atom_st ..... aq:1 rl:1 =
..... ........ ..... ....... &amp;atomic %rs2 %rs1 %rd<br>+@l_aq ..... . rl=
:1 ..... ........ ..... ....... &amp;atomic rs2=3D0 %rs1 %rd aq=3D1<br>+@s_=
rl ..... aq:1 . ..... ........ ..... ....... &amp;atomic %rs2 %rs1 rd=3D0 r=
l=3D1<br>+<br>@r4_rm ..... .. ..... ..... ... ..... ....... %rs3 %rs2 %rs1 =
%rm %rd<br>@r_rm ....... ..... ..... ... ..... ....... %rs2 %rs1 %rm %rd<br=
>@@ -739,6 +742,18 @@ vsetvl 1000000 ..... ..... 111 ..... 1010111 @r<br>wr=
s_nto 000000001101 00000 000 00000 1110011<br>wrs_sto 000000011101 00000 00=
0 00000 1110011<br>+# *** RV32 Zalasr Standard Extension ***<br>+lb_aq 0011=
0 1 . 00000 ..... 000 ..... 0101111 @l_aq<br>+lh_aq 00110 1 . 00000 ..... 0=
01 ..... 0101111 @l_aq<br>+lw_aq 00110 1 . 00000 ..... 010 ..... 0101111 @l=
_aq<br>+sb_rl 00111 . 1 ..... ..... 000 00000 0101111 @s_rl<br>+sh_rl 00111=
 . 1 ..... ..... 001 00000 0101111 @s_rl<br>+sw_rl 00111 . 1 ..... ..... 01=
0 00000 0101111 @s_rl<br>+<br>+# *** RV64 Zalasr Standard Extension (in add=
ition to RV32 Zalasr) ***<br>+ld_aq 00110 1 . 00000 ..... 011 ..... 0101111=
 @l_aq<br>+sd_rl 00111 . 1 ..... ..... 011 00000 0101111 @s_rl<br>+<br># **=
* RV32 Zba Standard Extension ***<br>sh1add 0010000 .......... 010 ..... 01=
10011 @r<br>sh2add 0010000 .......... 100 ..... 0110011 @r<br>diff --git a/=
target/riscv/insn_trans/trans_rvzalasr.c.inc b/target/riscv/insn_trans/tran=
s_rvzalasr.c.inc<br>new file mode 100644<br>index 0000000000..cee81ce8b8<br=
>--- /dev/null<br>+++ b/target/riscv/insn_trans/trans_rvzalasr.c.inc<br>@@ =
-0,0 +1,112 @@<br>+/*<br>+ * RISC-V translation routines for the Zzlasr Sta=
ndard Extension.<br>+ *<br>+ * Copyright (c) 2023 Brendan Sweeney, <a href=
=3D"mailto:brs@berkeley.edu">brs@berkeley.edu</a><br>+ *<br>+ * This progra=
m is free software; you can redistribute it and/or modify it<br>+ * under t=
he terms and conditions of the GNU General Public License,<br>+ * version 2=
 or later, as published by the Free Software Foundation.<br>+ *<br>+ * This=
 program is distributed in the hope it will be useful, but WITHOUT<br>+ * A=
NY WARRANTY; without even the implied warranty of MERCHANTABILITY or<br>+ *=
 FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for<b=
r>+ * more details.<br>+ *<br>+ * You should have received a copy of the GN=
U General Public License along with<br>+ * this program. If not, see &lt;<a=
 href=3D"http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>&gt;=
.<br>+ */<br>+<br>+#define REQUIRE_ZALASR(ctx) do { \<br>+ if (!ctx-&gt;cfg=
_ptr-&gt;ext_zalasr) { \<br>+ return false; \<br>+ } \<br>+} while (0)<br>+=
<br>+static bool gen_l_aq(DisasContext *ctx, arg_atomic *a, MemOp mop)<br>+=
{<br>+ TCGv src1;<br>+<br>+ decode_save_opc(ctx);<br>+ src1 =3D get_address=
(ctx, a-&gt;rs1, 0);<br>+ if (a-&gt;rl) {<br>+ tcg_gen_mb(TCG_MO_ALL | TCG_=
BAR_STRL);<br>+ }<br>+ tcg_gen_qemu_ld_tl(load_val, src1, ctx-&gt;mem_idx, =
mop);<br>+ if (a-&gt;aq) {<br>+ tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);<br>+=
 }<br>+ /* Put data in load_val. */<br>+ gen_set_gpr(ctx, a-&gt;rd, load_va=
l);<br>+<br>+ return true;<br>+}<br>+<br>+static bool trans_lb_aq(DisasCont=
ext *ctx, arg_lb_aq *a)<br>+{<br>+ REQUIRE_ZALASR(ctx);<br>+ return gen_l_a=
q(ctx, a, (MO_ALIGN | MO_SB));<br>+}<br>+<br>+static bool trans_lh_aq(Disas=
Context *ctx, arg_lh_aq *a)<br>+{<br>+ REQUIRE_ZALASR(ctx);<br>+ return gen=
_l_aq(ctx, a, (MO_ALIGN | MO_TESW));<br>+}<br>+<br>+static bool trans_lw_aq=
(DisasContext *ctx, arg_lw_aq *a)<br>+{<br>+ REQUIRE_ZALASR(ctx);<br>+ retu=
rn gen_l_aq(ctx, a, (MO_ALIGN | MO_TESL));<br>+}<br>+<br>+static bool trans=
_ld_aq(DisasContext *ctx, arg_lw_aq *a)<br>+{<br>+ REQUIRE_ZALASR(ctx);<br>=
+ REQUIRE_64_OR_128BIT(ctx);<br>+ return gen_l_aq(ctx, a, (MO_ALIGN | MO_TE=
SQ));<br>+}<br>+<br>+static bool gen_s_rl(DisasContext *ctx, arg_atomic *a,=
 MemOp mop)<br>+{<br>+ TCGv src1, src2;<br>+<br>+ decode_save_opc(ctx);<br>=
+ src1 =3D get_address(ctx, a-&gt;rs1, 0);<br>+<br>+ src2 =3D get_gpr(ctx, =
a-&gt;rs2, EXT_NONE);<br>+<br>+ if (a-&gt;rl) {<br>+ tcg_gen_mb(TCG_MO_ALL =
| TCG_BAR_STRL);<br>+ }<br>+ tcg_gen_qemu_st_i64(src2, src1, ctx-&gt;mem_id=
x, mop);<br>+ if (a-&gt;aq) {<br>+ tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);<b=
r>+ }<br>+<br>+ return true;<br>+}<br>+<br>+static bool trans_sb_rl(DisasCo=
ntext *ctx, arg_sb_rl *a)<br>+{<br>+ REQUIRE_ZALASR(ctx);<br>+ return gen_s=
_rl(ctx, a, (MO_ALIGN | MO_SB));<br>+}<br>+<br>+static bool trans_sh_rl(Dis=
asContext *ctx, arg_sh_rl *a)<br>+{<br>+ REQUIRE_ZALASR(ctx);<br>+ return g=
en_s_rl(ctx, a, (MO_ALIGN | MO_TESW));<br>+}<br>+<br>+static bool trans_sw_=
rl(DisasContext *ctx, arg_sw_rl *a)<br>+{<br>+ REQUIRE_ZALASR(ctx);<br>+ re=
turn gen_s_rl(ctx, a, (MO_ALIGN | MO_TESL));<br>+}<br>+<br>+static bool tra=
ns_sd_rl(DisasContext *ctx, arg_sd_rl *a)<br>+{<br>+ REQUIRE_ZALASR(ctx);<b=
r>+ REQUIRE_64_OR_128BIT(ctx);<br>+ return gen_s_rl(ctx, a, (MO_ALIGN | MO_=
TEUQ));<br>+}<br>diff --git a/target/riscv/translate.c b/target/riscv/trans=
late.c<br>index f0be79bb16..bfcf1ff1d8 100644<br>--- a/target/riscv/transla=
te.c<br>+++ b/target/riscv/translate.c<br>@@ -1091,6 +1091,7 @@ static uint=
32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)<br>#include &quot=
;insn_trans/trans_rvzicond.c.inc&quot;<br>#include &quot;insn_trans/trans_r=
vzawrs.c.inc&quot;<br>#include &quot;insn_trans/trans_rvzicbo.c.inc&quot;<b=
r>+#include &quot;insn_trans/trans_rvzalasr.c.inc&quot;<br>#include &quot;i=
nsn_trans/trans_rvzfa.c.inc&quot;<br>#include &quot;insn_trans/trans_rvzfh.=
c.inc&quot;<br>#include &quot;insn_trans/trans_rvk.c.inc&quot;<br>--<br>2.3=
2.1 (Apple Git-133)<br><br><br></div>

--00000000000018c2ec0608a695da--

