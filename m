Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1563A827ADF
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 23:49:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMyQT-0006Wy-Ui; Mon, 08 Jan 2024 17:48:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rMyQR-0006WI-BU
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 17:48:55 -0500
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rMyQP-0008VQ-1u
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 17:48:55 -0500
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7bbec1d1c9dso147465239f.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 14:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704754131; x=1705358931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LD0J90wvo9OOp0y/+eqEnhanYAzvneHwaomHEfxgwnc=;
 b=E7gQiZaAidvUmCKA/lQJ5wBW+KE7LXk9VGaaJgdAkNqGKyC/b9qQeFgV1WzzME5w5t
 i2ZaUvMnWeFOyS/nsq6GWFGkKgpRc7qaq98Aue59FZNL/pndhnthslKqXny6W18/fpPJ
 pim7gGaPEFfJZKjJW0nRI8QtQSvTuYDroEayCQQPrSjwQxQAlkYg5c5JUOLzTkqQ8m3P
 DVpliqfKtYELAwr/F55uh2ktt6gloVN76DGntqBybQreX5IiinHbT+4soydj02tFJMDC
 ZRSs4a5/eyiJphTv8DyBvlaIb+wY21ytx2rP6Oks/u3ywt9WAXSYj63dP78gweX14DZO
 CZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704754131; x=1705358931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LD0J90wvo9OOp0y/+eqEnhanYAzvneHwaomHEfxgwnc=;
 b=c0H4H4wSuqm6WH/ubHLwH43tlWGP7kN2d0q0lHOalndLEFAOVEEJsqEmRjzOUmWLe/
 pNyeNNiPtBISB2IS3Vtsl7EGoC8G83+6rKyUBYcblngvo6Lf9J9W70Gx4bnUB/WiXxPp
 BBqIVYEid1MC7QIUbpjy6hn637vZ5TSIO4DZhozqbVsvqLOp5SSPf6X2S9UwKYsppdPg
 UyMEGBu+1Apqvr/fAxmIjTBQnV+MS3HdSBtz/yV6oC5yX5CjQim+fuuej3Oo8XDkWfBg
 pgpeeEVIiMrr5gaOor4YT5n2ef8bS6PUu6/82GQOuZe/Y5pVthdoAEgMIgNvL49pTigM
 hCrQ==
X-Gm-Message-State: AOJu0Yz11WT7vb2CVAQLymOQfWUIzXZbCMknDdp/kreiRvGomKnjdA9M
 j8Wostj0rjK+eHp1FnUMuQmetUoKvknwzw==
X-Google-Smtp-Source: AGHT+IE0r530paTaefmXeK4JGMp5Z5+3tpnUW0SlFmR6gXLY2Mkw6/ZmFLypS12hRupZQlLG847nfw==
X-Received: by 2002:a5e:dd07:0:b0:7b7:fac7:fda8 with SMTP id
 t7-20020a5edd07000000b007b7fac7fda8mr6273092iop.39.1704754131258; 
 Mon, 08 Jan 2024 14:48:51 -0800 (PST)
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-73-169-12-54.hsd1.co.comcast.net. [73.169.12.54])
 by smtp.gmail.com with ESMTPSA id
 t7-20020a056638204700b0046e08e513b2sm241877jaj.116.2024.01.08.14.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 14:48:50 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 2/3] Hexagon (target/hexagon) Use QEMU decodetree (16-bit
 instructions)
Date: Mon,  8 Jan 2024 15:48:44 -0700
Message-Id: <20240108224845.285864-3-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108224845.285864-1-ltaylorsimpson@gmail.com>
References: <20240108224845.285864-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d35;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd35.google.com
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

Section 10.3 of the Hexagon V73 Programmer's Reference Manual

A duplex is encoded as a 32-bit instruction with bits [15:14] set to 00.
The sub-instructions that comprise a duplex are encoded as 13-bit fields
in the duplex.

Create a decoder for each subinstruction class (a, l1, l2, s1, s2).

Extend gen_trans_funcs.py to handle all instructions rather than
filter by instruction class.

There is a g_assert_not_reached() in decode_insns() in decode.c to
verify we never try to use the old decoder on 16-bit instructions.

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/decode.c           | 85 +++++++++++++++++++++++++++++
 target/hexagon/README             |  1 +
 target/hexagon/gen_decodetree.py  | 14 ++++-
 target/hexagon/gen_trans_funcs.py | 12 +----
 target/hexagon/meson.build        | 90 +++++++++++++++++++++++++++++++
 5 files changed, 190 insertions(+), 12 deletions(-)

diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index bddad1f75e..160b23a895 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -60,6 +60,7 @@ static int decode_mapped_reg_##NAME(DisasContext *ctx, int x) \
 }
 DECODE_MAPPED(R_16)
 DECODE_MAPPED(R_8)
+DECODE_MAPPED(R__8)
 
 /* Helper function for decodetree_trans_funcs_generated.c.inc */
 static int shift_left(DisasContext *ctx, int x, int n, int immno)
@@ -77,6 +78,13 @@ static int shift_left(DisasContext *ctx, int x, int n, int immno)
 #include "decode_normal_generated.c.inc"
 #include "decode_hvx_generated.c.inc"
 
+/* Include the generated decoder for 16 bit insn */
+#include "decode_subinsn_a_generated.c.inc"
+#include "decode_subinsn_l1_generated.c.inc"
+#include "decode_subinsn_l2_generated.c.inc"
+#include "decode_subinsn_s1_generated.c.inc"
+#include "decode_subinsn_s2_generated.c.inc"
+
 /* Include the generated helpers for the decoder */
 #include "decodetree_trans_funcs_generated.c.inc"
 
@@ -790,6 +798,63 @@ decode_insns_tablewalk(Insn *insn, const DectreeTable *table,
     }
 }
 
+/*
+ * Section 10.3 of the Hexagon V73 Programmer's Reference Manual
+ *
+ * A duplex is encoded as a 32-bit instruction with bits [15:14] set to 00.
+ * The sub-instructions that comprise a duplex are encoded as 13-bit fields
+ * in the duplex.
+ *
+ * Per table 10-4, the 4-bit duplex iclass is encoded in bits 31:29, 13
+ */
+static uint32_t get_duplex_iclass(uint32_t encoding)
+{
+    uint32_t iclass = extract32(encoding, 13, 1);
+    iclass = deposit32(iclass, 1, 3, extract32(encoding, 29, 3));
+    return iclass;
+}
+
+/*
+ * Per table 10-5, the duplex ICLASS field values that specify the group of
+ * each sub-instruction in a duplex
+ *
+ * This table points to the decode instruction for each entry in the table
+ */
+typedef bool (*subinsn_decode_func)(DisasContext *ctx, uint16_t insn);
+typedef struct {
+    subinsn_decode_func decode_slot0_subinsn;
+    subinsn_decode_func decode_slot1_subinsn;
+} subinsn_decode_groups;
+
+static const subinsn_decode_groups decode_groups[16] = {
+    [0x0] = { decode_subinsn_l1, decode_subinsn_l1 },
+    [0x1] = { decode_subinsn_l2, decode_subinsn_l1 },
+    [0x2] = { decode_subinsn_l2, decode_subinsn_l2 },
+    [0x3] = { decode_subinsn_a,  decode_subinsn_a },
+    [0x4] = { decode_subinsn_l1, decode_subinsn_a },
+    [0x5] = { decode_subinsn_l2, decode_subinsn_a },
+    [0x6] = { decode_subinsn_s1, decode_subinsn_a },
+    [0x7] = { decode_subinsn_s2, decode_subinsn_a },
+    [0x8] = { decode_subinsn_s1, decode_subinsn_l1 },
+    [0x9] = { decode_subinsn_s1, decode_subinsn_l2 },
+    [0xa] = { decode_subinsn_s1, decode_subinsn_s1 },
+    [0xb] = { decode_subinsn_s2, decode_subinsn_s1 },
+    [0xc] = { decode_subinsn_s2, decode_subinsn_l1 },
+    [0xd] = { decode_subinsn_s2, decode_subinsn_l2 },
+    [0xe] = { decode_subinsn_s2, decode_subinsn_s2 },
+    [0xf] = { NULL,              NULL },              /* Reserved */
+};
+
+static uint16_t get_slot0_subinsn(uint32_t encoding)
+{
+    return extract32(encoding, 0, 13);
+}
+
+static uint16_t get_slot1_subinsn(uint32_t encoding)
+{
+    return extract32(encoding, 16, 13);
+}
+
 static unsigned int
 decode_insns(DisasContext *ctx, Insn *insn, uint32_t encoding)
 {
@@ -805,8 +870,28 @@ decode_insns(DisasContext *ctx, Insn *insn, uint32_t encoding)
         table = &dectree_table_DECODE_ROOT_32;
         g_assert_not_reached();
     } else {
+        uint32_t iclass = get_duplex_iclass(encoding);
+        unsigned int slot0_subinsn = get_slot0_subinsn(encoding);
+        unsigned int slot1_subinsn = get_slot1_subinsn(encoding);
+        subinsn_decode_func decode_slot0_subinsn =
+            decode_groups[iclass].decode_slot0_subinsn;
+        subinsn_decode_func decode_slot1_subinsn =
+            decode_groups[iclass].decode_slot1_subinsn;
+
+        /* The slot1 subinsn needs to be in the packet first */
+        if (decode_slot1_subinsn(ctx, slot1_subinsn)) {
+            insn->generate = opcode_genptr[insn->opcode];
+            insn->iclass = iclass_bits(encoding);
+            ctx->insn = ++insn;
+            if (decode_slot0_subinsn(ctx, slot0_subinsn)) {
+                insn->generate = opcode_genptr[insn->opcode];
+                insn->iclass = iclass_bits(encoding);
+                return 2;
+            }
+        }
         /* start with EE table - duplex instructions */
         table = &dectree_table_DECODE_ROOT_EE;
+        g_assert_not_reached();
     }
     return decode_insns_tablewalk(insn, table, encoding);
 }
diff --git a/target/hexagon/README b/target/hexagon/README
index 1b2a4d0eac..746ebec378 100644
--- a/target/hexagon/README
+++ b/target/hexagon/README
@@ -195,6 +195,7 @@ Step 1 is to run target/hexagon/gen_dectree_import.c to produce
 Step 2 is to import iset.py into target/hexagon/gen_decodetree.py to produce
     <BUILD_DIR>/target/hexagon/normal_decode_generated
     <BUILD_DIR>/target/hexagon/hvx_decode_generated
+    <BUILD_DIR>/target/hexagon/subinsn_*_decode_generated
 Step 3 is to process the above files with QEMU's decodetree.py to produce
     <BUILD_DIR>/target/hexagon/decode_*_generated.c.inc
 Step 4 is to import iset.py into target/hexagon/gen_trans_funcs.py to produce
diff --git a/target/hexagon/gen_decodetree.py b/target/hexagon/gen_decodetree.py
index 1693148ec0..2dff975f55 100755
--- a/target/hexagon/gen_decodetree.py
+++ b/target/hexagon/gen_decodetree.py
@@ -96,8 +96,10 @@ def skip_tag(tag, class_to_decode):
 ##     A2_add   ..................-.....---..... @A2_add
 ##
 def gen_decodetree_file(f, class_to_decode):
+    is_subinsn = class_to_decode.startswith("SUBINSN_")
     f.write(f"## DO NOT MODIFY - This file is generated by {sys.argv[0]}\n\n")
-    f.write("%PP\t14:2\n\n")
+    if not is_subinsn:
+        f.write("%PP\t14:2\n\n")
     for tag in sorted(encs.keys(), key=iset.tags.index):
         if skip_tag(tag, class_to_decode):
             continue
@@ -107,6 +109,12 @@ def gen_decodetree_file(f, class_to_decode):
 
         enc = encs[tag]
         enc_str = "".join(reversed(encs[tag]))
+
+        # The subinstructions come with a 13-bit encoding, but
+        # decodetree.py needs 16 bits
+        if is_subinsn:
+            enc_str = "---" + enc_str
+
         f.write(f"## {tag}:\t{enc_str}\n")
         f.write("##\n")
 
@@ -176,7 +184,9 @@ def gen_decodetree_file(f, class_to_decode):
             imm_letter = "i" if imm_type.islower() else "I"
             f.write(f" {imm_type}{imm_letter}=%{tag}_{imm_type}{imm_letter}")
 
-        f.write(" %PP\n")
+        if not is_subinsn:
+            f.write(" %PP")
+        f.write("\n")
 
          # Replace the 0s and 1s with .
         for x in { "0", "1" }:
diff --git a/target/hexagon/gen_trans_funcs.py b/target/hexagon/gen_trans_funcs.py
index c907131009..53e844a44b 100755
--- a/target/hexagon/gen_trans_funcs.py
+++ b/target/hexagon/gen_trans_funcs.py
@@ -40,11 +40,6 @@ def ordered_unique(l):
     return sorted(set(l), key=l.index)
 
 
-def skip_tag(tag, classes):
-    enc_class = iset.iset[tag]["enc_class"]
-    return enc_class not in classes
-
-
 def code_fmt(txt):
     return textwrap.indent(textwrap.dedent(txt), "    ")
 
@@ -76,12 +71,9 @@ def mark_which_imm_extended(f, tag):
 ##         return true;
 ##     }
 ##
-def gen_trans_funcs(f, classes):
+def gen_trans_funcs(f):
     f.write(f"/* DO NOT MODIFY - This file is generated by {sys.argv[0]} */\n\n")
     for tag in sorted(encs.keys(), key=iset.tags.index):
-        if skip_tag(tag, classes):
-            continue
-
         regs = ordered_unique(regre.findall(iset.iset[tag]["syntax"]))
         imms = ordered_unique(immre.findall(iset.iset[tag]["syntax"]))
 
@@ -129,4 +121,4 @@ def gen_trans_funcs(f, classes):
 if __name__ == "__main__":
     hex_common.read_semantics_file(sys.argv[1])
     with open(sys.argv[2], "w") as f:
-        gen_trans_funcs(f, { "NORMAL", "EXT_mmvec" })
+        gen_trans_funcs(f)
diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
index 831bd5716a..1bd1ebcba1 100644
--- a/target/hexagon/meson.build
+++ b/target/hexagon/meson.build
@@ -154,6 +154,51 @@ hvx_decode_generated = custom_target(
 )
 hexagon_ss.add(hvx_decode_generated)
 
+subinsn_a_decode_generated = custom_target(
+    'subinsn_a_decode_generated',
+    output: 'subinsn_a_decode_generated',
+    depends: [iset_py, semantics_generated],
+    env: {'PYTHONPATH': meson.current_build_dir()},
+    command: [python, files('gen_decodetree.py'), semantics_generated, 'SUBINSN_A', '@OUTPUT@'],
+)
+hexagon_ss.add(subinsn_a_decode_generated)
+
+subinsn_l1_decode_generated = custom_target(
+    'subinsn_l1_decode_generated',
+    output: 'subinsn_l1_decode_generated',
+    depends: [iset_py, semantics_generated],
+    env: {'PYTHONPATH': meson.current_build_dir()},
+    command: [python, files('gen_decodetree.py'), semantics_generated, 'SUBINSN_L1', '@OUTPUT@'],
+)
+hexagon_ss.add(subinsn_l1_decode_generated)
+
+subinsn_l2_decode_generated = custom_target(
+    'subinsn_l2_decode_generated',
+    output: 'subinsn_l2_decode_generated',
+    depends: [iset_py, semantics_generated],
+    env: {'PYTHONPATH': meson.current_build_dir()},
+    command: [python, files('gen_decodetree.py'), semantics_generated, 'SUBINSN_L2', '@OUTPUT@'],
+)
+hexagon_ss.add(subinsn_l2_decode_generated)
+
+subinsn_s1_decode_generated = custom_target(
+    'subinsn_s1_decode_generated',
+    output: 'subinsn_s1_decode_generated',
+    depends: [iset_py, semantics_generated],
+    env: {'PYTHONPATH': meson.current_build_dir()},
+    command: [python, files('gen_decodetree.py'), semantics_generated, 'SUBINSN_S1', '@OUTPUT@'],
+)
+hexagon_ss.add(subinsn_s1_decode_generated)
+
+subinsn_s2_decode_generated = custom_target(
+    'subinsn_s2_decode_generated',
+    output: 'subinsn_s2_decode_generated',
+    depends: [iset_py, semantics_generated],
+    env: {'PYTHONPATH': meson.current_build_dir()},
+    command: [python, files('gen_decodetree.py'), semantics_generated, 'SUBINSN_S2', '@OUTPUT@'],
+)
+hexagon_ss.add(subinsn_s2_decode_generated)
+
 #
 # Run the QEMU decodetree.py script to produce the instruction decoder
 #
@@ -176,6 +221,51 @@ decode_hvx_generated = custom_target(
 )
 hexagon_ss.add(decode_hvx_generated)
 
+decode_subinsn_a_generated = custom_target(
+    'decode_subinsn_a_generated.c.inc',
+    output: 'decode_subinsn_a_generated.c.inc',
+    input: subinsn_a_decode_generated,
+    env: {'PYTHONPATH': meson.current_build_dir()},
+    command: [python, files(decodetree_py), subinsn_a_decode_generated, ['--static-decode=decode_subinsn_a', '--insnwidth=16'], '-o', '@OUTPUT@'],
+)
+hexagon_ss.add(decode_subinsn_a_generated)
+
+decode_subinsn_l1_generated = custom_target(
+    'decode_subinsn_l1_generated.c.inc',
+    output: 'decode_subinsn_l1_generated.c.inc',
+    input: subinsn_l1_decode_generated,
+    env: {'PYTHONPATH': meson.current_build_dir()},
+    command: [python, files(decodetree_py), subinsn_l1_decode_generated, ['--static-decode=decode_subinsn_l1', '--insnwidth=16'], '-o', '@OUTPUT@'],
+)
+hexagon_ss.add(decode_subinsn_l1_generated)
+
+decode_subinsn_l2_generated = custom_target(
+    'decode_subinsn_l2_generated.c.inc',
+    output: 'decode_subinsn_l2_generated.c.inc',
+    input: subinsn_l2_decode_generated,
+    env: {'PYTHONPATH': meson.current_build_dir()},
+    command: [python, files(decodetree_py), subinsn_l2_decode_generated, ['--static-decode=decode_subinsn_l2', '--insnwidth=16'], '-o', '@OUTPUT@'],
+)
+hexagon_ss.add(decode_subinsn_l2_generated)
+
+decode_subinsn_s1_generated = custom_target(
+    'decode_subinsn_s1_generated.c.inc',
+    output: 'decode_subinsn_s1_generated.c.inc',
+    input: subinsn_s1_decode_generated,
+    env: {'PYTHONPATH': meson.current_build_dir()},
+    command: [python, files(decodetree_py), subinsn_s1_decode_generated, ['--static-decode=decode_subinsn_s1', '--insnwidth=16'], '-o', '@OUTPUT@'],
+)
+hexagon_ss.add(decode_subinsn_s1_generated)
+
+decode_subinsn_s2_generated = custom_target(
+    'decode_subinsn_s2_generated.c.inc',
+    output: 'decode_subinsn_s2_generated.c.inc',
+    input: subinsn_s2_decode_generated,
+    env: {'PYTHONPATH': meson.current_build_dir()},
+    command: [python, files(decodetree_py), subinsn_s2_decode_generated, ['--static-decode=decode_subinsn_s2', '--insnwidth=16'], '-o', '@OUTPUT@'],
+)
+hexagon_ss.add(decode_subinsn_s2_generated)
+
 #
 # Generate the trans_* functions that the decoder will use
 #
-- 
2.34.1


