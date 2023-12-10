Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A34E480BD81
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 23:08:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCRxN-0004w4-KD; Sun, 10 Dec 2023 17:07:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rCRxM-0004vm-D1
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 17:07:24 -0500
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rCRxK-0004Ym-9k
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 17:07:24 -0500
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-590b3337d2bso1045932eaf.2
 for <qemu-devel@nongnu.org>; Sun, 10 Dec 2023 14:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702246040; x=1702850840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7INVYMT5r1D4mt+61zSzjBSfhyLG7TlXNfcj/O5bdpo=;
 b=YjYkSXI3kkxqYVRoULPFTMbevAg0HtRQHuYFHqDZjzf04esfqd42pLRa9x6yPXJwcR
 emXXZfR2ZQFCg2kji7YJBospgaXjfa9uNOWuAmg4H6ecd7YRJ8+zB2DYpux6pwf3FJhC
 RiXjmTmDdDE/YLgX28+nBP7+fxVweGMiBFISLlXLTWm89XFnBPvZOfyySAC3HDl2dfo9
 u49BqOGvzvn8BGYx55bJ6bMn4RtD/LkTino7gi4DQrzjm0DpKpsO27ZX7JkTRyTASXm/
 ysfuaOFmHsYWe0WZld4WBqqY3hQcnokQMxbxC4NY4cItl0ExHBV/uwSV4NcI0nPJyL1A
 OfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702246040; x=1702850840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7INVYMT5r1D4mt+61zSzjBSfhyLG7TlXNfcj/O5bdpo=;
 b=eRAmUK5v1mL5bvT1ZS/tujYJq4pC1zb2+hB7GfFaNioIF6O0wC9LaG6OfBKdKFgQIj
 TZNGMj6M+Ma360SjkQsDzMIFlVSQlgb93saAjyi5OD/Kc5n8qfCXvEPLeub5qFAHbGnh
 lO/UX4mT+JWVoSpRHpKJNwrE1G8UnXEUcJqQvnVe1nB+2F28V97LgXqQ7R+tzHkO9y5D
 qulUV38PCqT8dxTtB4Q2jR1s0owxbybAr0ovc92xTcf/XOqIx1RuZ4gDwWIuPqXI48YH
 qL9uljNNrYMGSFUrnqHZ+VTczWPolA6RpfEDjUDOOp9S+QESUHx5gu3ON+5yiQxgSbI/
 3BLQ==
X-Gm-Message-State: AOJu0Yw2MMz+ALijlwLCJFkhcOCq3atFGxMLUuqKP5LP5dPB3Emd9uG4
 XyTv8m5pVoHR2qFeG+aulZ50St00Xtn99A==
X-Google-Smtp-Source: AGHT+IG0fQLpAWozUYYYArVxFRqb3a7o7Rejbed/RzVjpDObuw+0uU26FUKz/2MX5gY8l0pDlgRaJQ==
X-Received: by 2002:a4a:385a:0:b0:58e:2925:cef4 with SMTP id
 o26-20020a4a385a000000b0058e2925cef4mr1900141oof.5.1702246040255; 
 Sun, 10 Dec 2023 14:07:20 -0800 (PST)
Received: from taylor-ubuntu.austin.rr.com (068-203-008-061.res.spectrum.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 q23-20020a4a6c17000000b0058e200a9065sm1588173ooc.29.2023.12.10.14.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Dec 2023 14:07:19 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 3/9] Hexagon (target/hexagon) Make generators object
 oriented - gen_helper_protos
Date: Sun, 10 Dec 2023 15:07:06 -0700
Message-Id: <20231210220712.491494-4-ltaylorsimpson@gmail.com>
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

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/gen_helper_protos.py | 149 ++--------------------------
 target/hexagon/hex_common.py        |   7 --
 2 files changed, 8 insertions(+), 148 deletions(-)

diff --git a/target/hexagon/gen_helper_protos.py b/target/hexagon/gen_helper_protos.py
index 131043795a..c82b0f54e4 100755
--- a/target/hexagon/gen_helper_protos.py
+++ b/target/hexagon/gen_helper_protos.py
@@ -22,39 +22,6 @@
 import string
 import hex_common
 
-##
-## Helpers for gen_helper_prototype
-##
-def_helper_types = {
-    "N": "s32",
-    "O": "s32",
-    "P": "s32",
-    "M": "s32",
-    "C": "s32",
-    "R": "s32",
-    "V": "ptr",
-    "Q": "ptr",
-}
-
-def_helper_types_pair = {
-    "R": "s64",
-    "C": "s64",
-    "S": "s64",
-    "G": "s64",
-    "V": "ptr",
-    "Q": "ptr",
-}
-
-
-def gen_def_helper_opn(f, tag, regtype, regid, i):
-    if hex_common.is_pair(regid):
-        f.write(f", {def_helper_types_pair[regtype]}")
-    elif hex_common.is_single(regid):
-        f.write(f", {def_helper_types[regtype]}")
-    else:
-        hex_common.bad_register(regtype, regid)
-
-
 ##
 ## Generate the DEF_HELPER prototype for an instruction
 ##     For A2_add: Rd32=add(Rs32,Rt32)
@@ -65,116 +32,15 @@ def gen_helper_prototype(f, tag, tagregs, tagimms):
     regs = tagregs[tag]
     imms = tagimms[tag]
 
-    numresults = 0
-    numscalarresults = 0
-    numscalarreadwrite = 0
-    for regtype, regid in regs:
-        if hex_common.is_written(regid):
-            numresults += 1
-            if hex_common.is_scalar_reg(regtype):
-                numscalarresults += 1
-        if hex_common.is_readwrite(regid):
-            if hex_common.is_scalar_reg(regtype):
-                numscalarreadwrite += 1
-
-    if numscalarresults > 1:
-        ## The helper is bogus when there is more than one result
-        f.write(f"DEF_HELPER_1({tag}, void, env)\n")
-    else:
-        ## Figure out how many arguments the helper will take
-        if numscalarresults == 0:
-            def_helper_size = len(regs) + len(imms) + numscalarreadwrite + 1
-            if hex_common.need_pkt_has_multi_cof(tag):
-                def_helper_size += 1
-            if hex_common.need_pkt_need_commit(tag):
-                def_helper_size += 1
-            if hex_common.need_part1(tag):
-                def_helper_size += 1
-            if hex_common.need_slot(tag):
-                def_helper_size += 1
-            if hex_common.need_PC(tag):
-                def_helper_size += 1
-            if hex_common.helper_needs_next_PC(tag):
-                def_helper_size += 1
-            if hex_common.need_condexec_reg(tag, regs):
-                def_helper_size += 1
-            f.write(f"DEF_HELPER_{def_helper_size}({tag}")
-            ## The return type is void
-            f.write(", void")
-        else:
-            def_helper_size = len(regs) + len(imms) + numscalarreadwrite
-            if hex_common.need_pkt_has_multi_cof(tag):
-                def_helper_size += 1
-            if hex_common.need_pkt_need_commit(tag):
-                def_helper_size += 1
-            if hex_common.need_part1(tag):
-                def_helper_size += 1
-            if hex_common.need_slot(tag):
-                def_helper_size += 1
-            if hex_common.need_PC(tag):
-                def_helper_size += 1
-            if hex_common.need_condexec_reg(tag, regs):
-                def_helper_size += 1
-            if hex_common.helper_needs_next_PC(tag):
-                def_helper_size += 1
-            f.write(f"DEF_HELPER_{def_helper_size}({tag}")
-
-        ## Generate the qemu DEF_HELPER type for each result
-        ## Iterate over this list twice
-        ## - Emit the scalar result
-        ## - Emit the vector result
-        i = 0
-        for regtype, regid in regs:
-            if hex_common.is_written(regid):
-                if not hex_common.is_hvx_reg(regtype):
-                    gen_def_helper_opn(f, tag, regtype, regid, i)
-                i += 1
-
-        ## Put the env between the outputs and inputs
-        f.write(", env")
-        i += 1
-
-        # Second pass
-        for regtype, regid in regs:
-            if hex_common.is_written(regid):
-                if hex_common.is_hvx_reg(regtype):
-                    gen_def_helper_opn(f, tag, regtype, regid, i)
-                    i += 1
-
-        ## For conditional instructions, we pass in the destination register
-        if "A_CONDEXEC" in hex_common.attribdict[tag]:
-            for regtype, regid in regs:
-                if hex_common.is_writeonly(regid) and not hex_common.is_hvx_reg(
-                    regtype
-                ):
-                    gen_def_helper_opn(f, tag, regtype, regid, i)
-                    i += 1
+    declared = []
+    ret_type = hex_common.helper_ret_type(tag, regs).proto_arg
+    declared.append(ret_type)
 
-        ## Generate the qemu type for each input operand (regs and immediates)
-        for regtype, regid in regs:
-            if hex_common.is_read(regid):
-                if hex_common.is_hvx_reg(regtype) and hex_common.is_readwrite(regid):
-                    continue
-                gen_def_helper_opn(f, tag, regtype, regid, i)
-                i += 1
-        for immlett, bits, immshift in imms:
-            f.write(", s32")
+    for arg in hex_common.helper_args(tag, regs, imms):
+        declared.append(arg.proto_arg)
 
-        ## Add the arguments for the instruction pkt_has_multi_cof,
-        ## pkt_needs_commit, PC, next_PC, slot, and part1 (if needed)
-        if hex_common.need_pkt_has_multi_cof(tag):
-            f.write(", i32")
-        if hex_common.need_pkt_need_commit(tag):
-            f.write(', i32')
-        if hex_common.need_PC(tag):
-            f.write(", i32")
-        if hex_common.helper_needs_next_PC(tag):
-            f.write(", i32")
-        if hex_common.need_slot(tag):
-            f.write(", i32")
-        if hex_common.need_part1(tag):
-            f.write(" , i32")
-        f.write(")\n")
+    arguments = ", ".join(declared)
+    f.write(f"DEF_HELPER_{len(declared) - 1}({tag}, {arguments})\n")
 
 
 def main():
@@ -195,6 +61,7 @@ def main():
     if is_idef_parser_enabled:
         hex_common.read_idef_parser_enabled_file(sys.argv[5])
     hex_common.calculate_attribs()
+    hex_common.init_registers()
     tagregs = hex_common.get_tagregs()
     tagimms = hex_common.get_tagimms()
 
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 979f198a30..2abd653e6d 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -290,13 +290,6 @@ def need_pkt_has_multi_cof(tag):
 def need_pkt_need_commit(tag):
     return 'A_IMPLICIT_WRITES_USR' in attribdict[tag]
 
-def need_condexec_reg(tag, regs):
-    if "A_CONDEXEC" in attribdict[tag]:
-        for regtype, regid in regs:
-            if is_writeonly(regid) and not is_hvx_reg(regtype):
-                return True
-    return False
-
 
 def skip_qemu_helper(tag):
     return tag in overrides.keys()
-- 
2.34.1


