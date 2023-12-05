Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 347D3804453
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 02:54:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAKcf-0002ph-C5; Mon, 04 Dec 2023 20:53:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rAKcc-0002p3-CZ
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 20:53:15 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rAKcZ-0005xH-Vo
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 20:53:13 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3b8b6acc3e7so1396211b6e.1
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 17:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701741190; x=1702345990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MosRm14ICMpC1jHhUAP7YrawZmdyFb/HQO0qcsrf7kc=;
 b=JJwC6KTUZdva/afyZryEzdjmW6Csr84WLOE1KSWu9CN9ZmF74wpiNr55g5Z9UyUqB5
 xUR12lbI4QPrMVjWwjcxwqb/KhIMo9ojhHkKQO+GFPqFuHUeXCUoeCqnPK6Xn34f0EQq
 8f5GsmtVGWNshu5DHX2Xx8cRFN2xs2wMrK8JRyBySJz2uLA8I826JKDkvcl4buwhbYVN
 P15tvgY/4e10NaGsBAerew/rH6syIONKtTqGDkIa7b9uEW+V04mAhCgppP94ITqBeIx0
 PKuRF39SxEJ62tur211fIMlTCdnHDgBtZKxnIE8Qw2mPqEhKQTP2G4wKgkVqK0UAXwoZ
 VYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701741190; x=1702345990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MosRm14ICMpC1jHhUAP7YrawZmdyFb/HQO0qcsrf7kc=;
 b=b5AZUREfKKayG88y9sZkTWridV/zWeOuICkH/a1+POrk5oFt608ZS94fk+Q14doF29
 zWh6DvG2PdaXQae93hy25rNKGCB50hVIpQlp0zkmV3SgoGxrHO7LszAcmqSZDVTsgVLR
 66Q4M515Nyh6SSncKMzc3UIQlXgR5lK/UnIaRxb6QrmDao7aP1VjSFo+g97VSRNgmr+U
 TJqOQ9j20FoqexmkZctnIiBXWIqox5hbnw807yw0CelaaLasO1muty8b4svOYrXO0bw6
 r1/reRKOiX3bECzBezO/GfXwPDOxlUN/Jheimls/2TQUBkBrFy5j12yaFK4x9NrbCUvo
 +Kwg==
X-Gm-Message-State: AOJu0Yy2cg3v5jYJO8z+YvGO625IIKynSt7s+kNtYj36OLqPfiiCydd7
 /gvmHbYFigUS7WIK7qJd6DyCz1NzAQEYqw==
X-Google-Smtp-Source: AGHT+IG55W9PAkCZNjvRlIfJONaBExPx/d1YWd1r06kes/beZ4OamrFihO8+dEOdJxA3GpIWILdu3g==
X-Received: by 2002:a05:6808:2023:b0:3b8:b063:5d62 with SMTP id
 q35-20020a056808202300b003b8b0635d62mr5906068oiw.73.1701741190158; 
 Mon, 04 Dec 2023 17:53:10 -0800 (PST)
Received: from taylor-ubuntu.austin.rr.com (068-203-008-061.res.spectrum.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 c4-20020aca1c04000000b003b8b7063a44sm1064624oic.44.2023.12.04.17.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 17:53:09 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH 3/9] Hexagon (target/hexagon) Make generators object oriented
 - gen_helper_protos
Date: Mon,  4 Dec 2023 18:52:57 -0700
Message-Id: <20231205015303.575807-4-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205015303.575807-1-ltaylorsimpson@gmail.com>
References: <20231205015303.575807-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x229.google.com
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
 target/hexagon/gen_helper_protos.py | 184 ++++++++--------------------
 target/hexagon/hex_common.py        |  15 +--
 2 files changed, 55 insertions(+), 144 deletions(-)

diff --git a/target/hexagon/gen_helper_protos.py b/target/hexagon/gen_helper_protos.py
index 131043795a..9277199e1d 100755
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
@@ -65,116 +32,62 @@ def gen_helper_prototype(f, tag, tagregs, tagimms):
     regs = tagregs[tag]
     imms = tagimms[tag]
 
-    numresults = 0
+    ## If there is a scalar result, it is the return type
+    return_type = ""
     numscalarresults = 0
-    numscalarreadwrite = 0
     for regtype, regid in regs:
-        if hex_common.is_written(regid):
-            numresults += 1
-            if hex_common.is_scalar_reg(regtype):
+        reg = hex_common.get_register(tag, regtype, regid)
+        if reg.is_written() and reg.is_scalar_reg():
+                return_type = reg.helper_proto_type()
                 numscalarresults += 1
-        if hex_common.is_readwrite(regid):
-            if hex_common.is_scalar_reg(regtype):
-                numscalarreadwrite += 1
+    if numscalarresults == 0:
+        return_type = "void"
 
     if numscalarresults > 1:
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
+        raise Exception("numscalarresults > 1")
 
-        ## Put the env between the outputs and inputs
-        f.write(", env")
-        i += 1
+    declared = []
+    declared.append(return_type)
 
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
-
-        ## Generate the qemu type for each input operand (regs and immediates)
+    ## Put the env between the outputs and inputs
+    declared.append("env")
+
+    ## For predicated instructions, we pass in the destination register
+    if hex_common.is_predicated(tag):
         for regtype, regid in regs:
-            if hex_common.is_read(regid):
-                if hex_common.is_hvx_reg(regtype) and hex_common.is_readwrite(regid):
-                    continue
-                gen_def_helper_opn(f, tag, regtype, regid, i)
-                i += 1
-        for immlett, bits, immshift in imms:
-            f.write(", s32")
-
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
+            reg = hex_common.get_register(tag, regtype, regid)
+            if reg.is_writeonly() and not reg.is_hvx_reg():
+                declared.append(reg.helper_proto_type())
+    ## Pass the HVX destination registers
+    for regtype, regid in regs:
+        reg = hex_common.get_register(tag, regtype, regid)
+        if reg.is_written() and reg.is_hvx_reg():
+            declared.append(reg.helper_proto_type())
+    ## Pass the source registers
+    for regtype, regid in regs:
+        reg = hex_common.get_register(tag, regtype, regid)
+        if reg.is_read() and not (reg.is_hvx_reg() and reg.is_readwrite()):
+            declared.append(reg.helper_proto_type())
+    ## Pass the immediates
+    for immlett, bits, immshift in imms:
+        declared.append("s32")
+
+    ## Other stuff the helper might need
+    if hex_common.need_pkt_has_multi_cof(tag):
+        declared.append("i32")
+    if hex_common.need_pkt_need_commit(tag):
+        declared.append("i32")
+    if hex_common.need_PC(tag):
+        declared.append("i32")
+    if hex_common.need_next_PC(tag):
+        declared.append("i32")
+    if hex_common.need_slot(tag):
+        declared.append("i32")
+    if hex_common.need_part1(tag):
+        declared.append("i32")
+
+    arguments = ", ".join(declared)
+    f.write(f"DEF_HELPER_{len(declared) - 1}({tag}, {arguments})\n")
 
 
 def main():
@@ -195,6 +108,7 @@ def main():
     if is_idef_parser_enabled:
         hex_common.read_idef_parser_enabled_file(sys.argv[5])
     hex_common.calculate_attribs()
+    hex_common.init_registers()
     tagregs = hex_common.get_tagregs()
     tagimms = hex_common.get_tagimms()
 
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 2f8963db59..4149c2ce91 100755
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
@@ -404,10 +397,12 @@ def is_hvx_reg(self):
         return False
 
 class Single(Scalar):
-    pass
+    def helper_proto_type(self):
+        return "s32"
 
 class Pair(Scalar):
-    pass
+    def helper_proto_type(self):
+        return "s64"
 
 class Hvx:
     def is_scalar_reg(self):
@@ -416,6 +411,8 @@ def is_hvx_reg(self):
         return True
     def hvx_off(self):
         return f"{self.reg_tcg()}_off"
+    def helper_proto_type(self):
+        return "ptr"
 
 #
 # Every register is either Dest or OldSource or NewSource or ReadWrite
-- 
2.34.1


