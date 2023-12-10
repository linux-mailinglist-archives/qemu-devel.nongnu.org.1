Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8223680BD83
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 23:09:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCRxQ-0004xE-PW; Sun, 10 Dec 2023 17:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rCRxO-0004wL-Jd
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 17:07:26 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rCRxL-0004Yt-MN
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 17:07:26 -0500
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6d9f7af8918so1546631a34.0
 for <qemu-devel@nongnu.org>; Sun, 10 Dec 2023 14:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702246042; x=1702850842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P4024QTjxEkW25t7YisZgfh1WWvxDhGZu/xSpCDNWDc=;
 b=kMhp7OKxOj4YZzR7hzDAwzmndyJeoOINAdkp+UPiI+I6ftddtf7olfz4ndMtYM12AR
 wWAZId/JLiH1ldJtDgi0+tIGqwF8Thsdc6ezkrFv5AZ25zdwhLnEYy9cwpGlLrxeV2Lu
 QZpG2bJOIhPrhGtZ9vgrdgn7cYdlrFdwyHBBbKb7SorxUNSWgJmYEFOj1k9yX1A4VUr9
 iD95Ak+DX7rwaDO8T7XrmzveBI/foEojaIZ/ue8/SJQlWyfP1gvjYzZyosMwDgKwP9dv
 ir1IV/jgJlOt7rzj2kFSbKX8YPX02dPHA/WT0w3m0nb0MxJmohsAvGXW+eh+XVCf7dm7
 YT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702246042; x=1702850842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P4024QTjxEkW25t7YisZgfh1WWvxDhGZu/xSpCDNWDc=;
 b=BcJL/lpzSngG8YJjOl4wX4GM6zD2a+z4Eyd5DCHfhgjPqUy997DNwR4ZkiQ/m2Gul4
 75mOLgCtqBE7M4/HxH4YDwEnJqZRylT+O+sjGt50dKIQebqv0IM0DNG610Sot2iNJe5R
 Qng5LAyqD+rtUnlhhTmQFhzouWgLvg0qq5Qim5GdvL3HtwaKHNAVmb+yog+OItZNGpY4
 yUgntl2v45KHCon0cV8Z3Cu7SwfMaV4wWvz3BWpHDnRsz/yAhhpRUG0qKqAEqm7dRQmc
 w3PFBuXqE5+TZoxmixaFCYQWtxZ/Wch6bcsnWeB2B5Nm1E0xO3CHIRxN9F3uoZHR48MO
 2RMQ==
X-Gm-Message-State: AOJu0YybEKYBleOA1L4YO15Sujggy8Wy1pF4FFmUcgjtTwsM5srhrz5N
 V64h3Fbi40TeSymLAFe9LNevPOq5I00dAw==
X-Google-Smtp-Source: AGHT+IEdF57XxbVsv6YCDIO90u+hUtKaqS9Ct9uN10i+/+SYdFRQBu8JvMNhzVV2Ap3BM73W/6/HuA==
X-Received: by 2002:a9d:734b:0:b0:6d9:f753:efd7 with SMTP id
 l11-20020a9d734b000000b006d9f753efd7mr3276219otk.71.1702246041694; 
 Sun, 10 Dec 2023 14:07:21 -0800 (PST)
Received: from taylor-ubuntu.austin.rr.com (068-203-008-061.res.spectrum.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 q23-20020a4a6c17000000b0058e200a9065sm1588173ooc.29.2023.12.10.14.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Dec 2023 14:07:21 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 4/9] Hexagon (target/hexagon) Make generators object
 oriented - gen_helper_funcs
Date: Sun, 10 Dec 2023 15:07:07 -0700
Message-Id: <20231210220712.491494-5-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231210220712.491494-1-ltaylorsimpson@gmail.com>
References: <20231210220712.491494-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x32f.google.com
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
 target/hexagon/gen_helper_funcs.py | 368 +++++------------------------
 target/hexagon/hex_common.py       |  48 +++-
 2 files changed, 103 insertions(+), 313 deletions(-)

diff --git a/target/hexagon/gen_helper_funcs.py b/target/hexagon/gen_helper_funcs.py
index ce21d3b688..9cc3d69c49 100755
--- a/target/hexagon/gen_helper_funcs.py
+++ b/target/hexagon/gen_helper_funcs.py
@@ -23,181 +23,14 @@
 import hex_common
 
 
-##
-## Helpers for gen_helper_function
-##
-def gen_decl_ea(f):
-    f.write("    uint32_t EA;\n")
-
-
-def gen_helper_return_type(f, regtype, regid, regno):
-    if regno > 1:
-        f.write(", ")
-    f.write("int32_t")
-
-
-def gen_helper_return_type_pair(f, regtype, regid, regno):
-    if regno > 1:
-        f.write(", ")
-    f.write("int64_t")
-
-
-def gen_helper_arg(f, regtype, regid, regno):
-    if regno > 0:
-        f.write(", ")
-    f.write(f"int32_t {regtype}{regid}V")
-
-
-def gen_helper_arg_new(f, regtype, regid, regno):
-    if regno >= 0:
-        f.write(", ")
-    f.write(f"int32_t {regtype}{regid}N")
-
-
-def gen_helper_arg_pair(f, regtype, regid, regno):
-    if regno >= 0:
-        f.write(", ")
-    f.write(f"int64_t {regtype}{regid}V")
-
-
-def gen_helper_arg_ext(f, regtype, regid, regno):
-    if regno > 0:
-        f.write(", ")
-    f.write(f"void *{regtype}{regid}V_void")
-
-
-def gen_helper_arg_ext_pair(f, regtype, regid, regno):
-    if regno > 0:
-        f.write(", ")
-    f.write(f"void *{regtype}{regid}V_void")
-
-
-def gen_helper_arg_opn(f, regtype, regid, i, tag):
-    if hex_common.is_pair(regid):
-        if hex_common.is_hvx_reg(regtype):
-            gen_helper_arg_ext_pair(f, regtype, regid, i)
-        else:
-            gen_helper_arg_pair(f, regtype, regid, i)
-    elif hex_common.is_single(regid):
-        if hex_common.is_old_val(regtype, regid, tag):
-            if hex_common.is_hvx_reg(regtype):
-                gen_helper_arg_ext(f, regtype, regid, i)
-            else:
-                gen_helper_arg(f, regtype, regid, i)
-        elif hex_common.is_new_val(regtype, regid, tag):
-            gen_helper_arg_new(f, regtype, regid, i)
-        else:
-            hex_common.bad_register(regtype, regid)
-    else:
-        hex_common.bad_register(regtype, regid)
-
-
-def gen_helper_arg_imm(f, immlett):
-    f.write(f", int32_t {hex_common.imm_name(immlett)}")
-
-
-def gen_helper_dest_decl(f, regtype, regid, regno, subfield=""):
-    f.write(f"    int32_t {regtype}{regid}V{subfield} = 0;\n")
-
-
-def gen_helper_dest_decl_pair(f, regtype, regid, regno, subfield=""):
-    f.write(f"    int64_t {regtype}{regid}V{subfield} = 0;\n")
-
-
-def gen_helper_dest_decl_ext(f, regtype, regid):
-    if regtype == "Q":
-        f.write(
-            f"    /* {regtype}{regid}V is *(MMQReg *)" f"({regtype}{regid}V_void) */\n"
-        )
-    else:
-        f.write(
-            f"    /* {regtype}{regid}V is *(MMVector *)"
-            f"({regtype}{regid}V_void) */\n"
-        )
-
-
-def gen_helper_dest_decl_ext_pair(f, regtype, regid, regno):
-    f.write(
-        f"    /* {regtype}{regid}V is *(MMVectorPair *))"
-        f"{regtype}{regid}V_void) */\n"
-    )
-
-
-def gen_helper_dest_decl_opn(f, regtype, regid, i):
-    if hex_common.is_pair(regid):
-        if hex_common.is_hvx_reg(regtype):
-            gen_helper_dest_decl_ext_pair(f, regtype, regid, i)
-        else:
-            gen_helper_dest_decl_pair(f, regtype, regid, i)
-    elif hex_common.is_single(regid):
-        if hex_common.is_hvx_reg(regtype):
-            gen_helper_dest_decl_ext(f, regtype, regid)
-        else:
-            gen_helper_dest_decl(f, regtype, regid, i)
-    else:
-        hex_common.bad_register(regtype, regid)
-
-
-def gen_helper_src_var_ext(f, regtype, regid):
-    if regtype == "Q":
-        f.write(
-            f"    /* {regtype}{regid}V is *(MMQReg *)" f"({regtype}{regid}V_void) */\n"
-        )
-    else:
-        f.write(
-            f"    /* {regtype}{regid}V is *(MMVector *)"
-            f"({regtype}{regid}V_void) */\n"
-        )
-
-
-def gen_helper_src_var_ext_pair(f, regtype, regid, regno):
-    f.write(
-        f"    /* {regtype}{regid}V{regno} is *(MMVectorPair *)"
-        f"({regtype}{regid}V{regno}_void) */\n"
-    )
-
-
-def gen_helper_return(f, regtype, regid, regno):
-    f.write(f"    return {regtype}{regid}V;\n")
-
-
-def gen_helper_return_pair(f, regtype, regid, regno):
-    f.write(f"    return {regtype}{regid}V;\n")
-
-
-def gen_helper_dst_write_ext(f, regtype, regid):
-    return
-
-
-def gen_helper_dst_write_ext_pair(f, regtype, regid):
-    return
-
-
-def gen_helper_return_opn(f, regtype, regid, i):
-    if hex_common.is_pair(regid):
-        if hex_common.is_hvx_reg(regtype):
-            gen_helper_dst_write_ext_pair(f, regtype, regid)
-        else:
-            gen_helper_return_pair(f, regtype, regid, i)
-    elif hex_common.is_single(regid):
-        if hex_common.is_hvx_reg(regtype):
-            gen_helper_dst_write_ext(f, regtype, regid)
-        else:
-            gen_helper_return(f, regtype, regid, i)
-    else:
-        hex_common.bad_register(regtype, regid)
-
-
 ##
 ## Generate the TCG code to call the helper
 ##     For A2_add: Rd32=add(Rs32,Rt32), { RdV=RsV+RtV;}
 ##     We produce:
 ##       int32_t HELPER(A2_add)(CPUHexagonState *env, int32_t RsV, int32_t RtV)
 ##       {
-##           uint32_t slot __attribute__(unused)) = 4;
 ##           int32_t RdV = 0;
 ##           { RdV=RsV+RtV;}
-##           COUNT_HELPER(A2_add);
 ##           return RdV;
 ##       }
 ##
@@ -205,151 +38,67 @@ def gen_helper_function(f, tag, tagregs, tagimms):
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
-        f.write(
-            f"void HELPER({tag})(CPUHexagonState *env) " f"{{ BOGUS_HELPER({tag}); }}\n"
-        )
-    else:
-        ## The return type of the function is the type of the destination
-        ## register (if scalar)
-        i = 0
+    ret_type = hex_common.helper_ret_type(tag, regs).func_arg
+
+    declared = []
+    for arg in hex_common.helper_args(tag, regs, imms):
+        declared.append(arg.func_arg)
+
+    arguments = ", ".join(declared)
+    f.write(f"{ret_type} HELPER({tag})({arguments})\n")
+    f.write("{\n")
+    if hex_common.need_ea(tag):
+        f.write(hex_common.code_fmt(f"""\
+            uint32_t EA;
+        """))
+    ## Declare the return variable
+    if not hex_common.is_predicated(tag):
         for regtype, regid in regs:
-            if hex_common.is_written(regid):
-                if hex_common.is_pair(regid):
-                    if hex_common.is_hvx_reg(regtype):
-                        continue
-                    else:
-                        gen_helper_return_type_pair(f, regtype, regid, i)
-                elif hex_common.is_single(regid):
-                    if hex_common.is_hvx_reg(regtype):
-                        continue
-                    else:
-                        gen_helper_return_type(f, regtype, regid, i)
-                else:
-                    hex_common.bad_register(regtype, regid)
-            i += 1
+            reg = hex_common.get_register(tag, regtype, regid)
+            if reg.is_writeonly() and not reg.is_hvx_reg():
+                f.write(hex_common.code_fmt(f"""\
+                    {reg.helper_arg_type()} {reg.helper_arg_name()} = 0;
+                """))
 
-        if numscalarresults == 0:
-            f.write("void")
-        f.write(f" HELPER({tag})(CPUHexagonState *env")
-
-        ## Arguments include the vector destination operands
-        i = 1
-        for regtype, regid in regs:
-            if hex_common.is_written(regid):
-                if hex_common.is_pair(regid):
-                    if hex_common.is_hvx_reg(regtype):
-                        gen_helper_arg_ext_pair(f, regtype, regid, i)
-                    else:
-                        continue
-                elif hex_common.is_single(regid):
-                    if hex_common.is_hvx_reg(regtype):
-                        gen_helper_arg_ext(f, regtype, regid, i)
-                    else:
-                        # This is the return value of the function
-                        continue
-                else:
-                    hex_common.bad_register(regtype, regid)
-                i += 1
-
-        ## For conditional instructions, we pass in the destination register
-        if "A_CONDEXEC" in hex_common.attribdict[tag]:
-            for regtype, regid in regs:
-                if hex_common.is_writeonly(regid) and not hex_common.is_hvx_reg(
-                    regtype
-                ):
-                    gen_helper_arg_opn(f, regtype, regid, i, tag)
-                    i += 1
-
-        ## Arguments to the helper function are the source regs and immediates
-        for regtype, regid in regs:
-            if hex_common.is_read(regid):
-                if hex_common.is_hvx_reg(regtype) and hex_common.is_readwrite(regid):
-                    continue
-                gen_helper_arg_opn(f, regtype, regid, i, tag)
-                i += 1
-        for immlett, bits, immshift in imms:
-            gen_helper_arg_imm(f, immlett)
-            i += 1
-
-        if hex_common.need_pkt_has_multi_cof(tag):
-            f.write(", uint32_t pkt_has_multi_cof")
-        if (hex_common.need_pkt_need_commit(tag)):
-            f.write(", uint32_t pkt_need_commit")
-
-        if hex_common.need_PC(tag):
-            if i > 0:
-                f.write(", ")
-            f.write("target_ulong PC")
-            i += 1
-        if hex_common.helper_needs_next_PC(tag):
-            if i > 0:
-                f.write(", ")
-            f.write("target_ulong next_PC")
-            i += 1
-        if hex_common.need_slot(tag):
-            if i > 0:
-                f.write(", ")
-            f.write("uint32_t slotval")
-            i += 1
-        if hex_common.need_part1(tag):
-            if i > 0:
-                f.write(", ")
-            f.write("uint32_t part1")
-        f.write(")\n{\n")
-        if hex_common.need_ea(tag):
-            gen_decl_ea(f)
-        ## Declare the return variable
-        i = 0
-        if "A_CONDEXEC" not in hex_common.attribdict[tag]:
-            for regtype, regid in regs:
-                if hex_common.is_writeonly(regid):
-                    gen_helper_dest_decl_opn(f, regtype, regid, i)
-                i += 1
-
-        for regtype, regid in regs:
-            if hex_common.is_read(regid):
-                if hex_common.is_pair(regid):
-                    if hex_common.is_hvx_reg(regtype):
-                        gen_helper_src_var_ext_pair(f, regtype, regid, i)
-                elif hex_common.is_single(regid):
-                    if hex_common.is_hvx_reg(regtype):
-                        gen_helper_src_var_ext(f, regtype, regid)
-                else:
-                    hex_common.bad_register(regtype, regid)
-
-        if hex_common.need_slot(tag):
-            if "A_LOAD" in hex_common.attribdict[tag]:
-                f.write("    bool pkt_has_store_s1 = slotval & 0x1;\n")
-            f.write("    uint32_t slot = slotval >> 1;\n")
-
-        if "A_FPOP" in hex_common.attribdict[tag]:
-            f.write("    arch_fpop_start(env);\n")
-
-        f.write(f"    {hex_common.semdict[tag]}\n")
-
-        if "A_FPOP" in hex_common.attribdict[tag]:
-            f.write("    arch_fpop_end(env);\n")
+    ## Print useful information about HVX registers
+    for regtype, regid in regs:
+        reg = hex_common.get_register(tag, regtype, regid)
+        if reg.is_hvx_reg():
+            reg.helper_hvx_desc(f)
+
+    if hex_common.need_slot(tag):
+        if "A_LOAD" in hex_common.attribdict[tag]:
+            f.write(hex_common.code_fmt(f"""\
+                bool pkt_has_store_s1 = slotval & 0x1;
+            """))
+        f.write(hex_common.code_fmt(f"""\
+            uint32_t slot = slotval >> 1;
+        """))
+
+    if "A_FPOP" in hex_common.attribdict[tag]:
+        f.write(hex_common.code_fmt(f"""\
+            arch_fpop_start(env);
+        """))
+
+    f.write(hex_common.code_fmt(f"""\
+        {hex_common.semdict[tag]}
+    """))
+
+    if "A_FPOP" in hex_common.attribdict[tag]:
+        f.write(hex_common.code_fmt(f"""\
+            arch_fpop_end(env);
+        """))
+
+    ## Return the scalar result
+    for regtype, regid in regs:
+        reg = hex_common.get_register(tag, regtype, regid)
+        if reg.is_written() and not reg.is_hvx_reg():
+            f.write(hex_common.code_fmt(f"""\
+                return {reg.helper_arg_name()};
+            """))
 
-        ## Save/return the return variable
-        for regtype, regid in regs:
-            if hex_common.is_written(regid):
-                gen_helper_return_opn(f, regtype, regid, i)
-        f.write("}\n\n")
-        ## End of the helper definition
+    f.write("}\n\n")
+    ## End of the helper definition
 
 
 def main():
@@ -370,6 +119,7 @@ def main():
     if is_idef_parser_enabled:
         hex_common.read_idef_parser_enabled_file(sys.argv[5])
     hex_common.calculate_attribs()
+    hex_common.init_registers()
     tagregs = hex_common.get_tagregs()
     tagimms = hex_common.get_tagimms()
 
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 2abd653e6d..fc9ce4e2b0 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -275,10 +275,6 @@ def need_PC(tag):
     return "A_IMPLICIT_READS_PC" in attribdict[tag]
 
 
-def helper_needs_next_PC(tag):
-    return "A_CALL" in attribdict[tag]
-
-
 def need_next_PC(tag):
     return "A_CALL" in attribdict[tag]
 
@@ -680,6 +676,10 @@ def decl_tcg(self, f, tag, regno):
             """))
     def log_write(self, f, tag):
         pass
+    def helper_hvx_desc(self, f):
+        f.write(code_fmt(f"""\
+            /* {self.reg_tcg()} is *(MMVector *)({self.helper_arg_name()}) */
+        """))
 
 class VRegSource(Register, Hvx, OldSource):
     def decl_tcg(self, f, tag, regno):
@@ -692,6 +692,10 @@ def decl_tcg(self, f, tag, regno):
                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
             """))
+    def helper_hvx_desc(self, f):
+        f.write(code_fmt(f"""\
+            /* {self.reg_tcg()} is *(MMVector *)({self.helper_arg_name()}) */
+        """))
 
 class VRegNewSource(Register, Hvx, NewSource):
     def decl_tcg(self, f, tag, regno):
@@ -701,6 +705,10 @@ def decl_tcg(self, f, tag, regno):
                 const intptr_t {self.hvx_off()} =
                     ctx_future_vreg_off(ctx, {self.reg_num}, 1, true);
             """))
+    def helper_hvx_desc(self, f):
+        f.write(code_fmt(f"""\
+            /* {self.reg_tcg()} is *(MMVector *)({self.helper_arg_name()}) */
+        """))
 
 class VRegReadWrite(Register, Hvx, ReadWrite):
     def decl_tcg(self, f, tag, regno):
@@ -719,6 +727,10 @@ def decl_tcg(self, f, tag, regno):
             """))
     def log_write(self, f, tag):
         pass
+    def helper_hvx_desc(self, f):
+        f.write(code_fmt(f"""\
+            /* {self.reg_tcg()} is *(MMVector *)({self.helper_arg_name()}) */
+        """))
 
 class VRegTmp(Register, Hvx, ReadWrite):
     def decl_tcg(self, f, tag, regno):
@@ -739,6 +751,10 @@ def log_write(self, f, tag):
             gen_log_vreg_write(ctx, {self.hvx_off()}, {self.reg_num},
                                {hvx_newv(tag)});
         """))
+    def helper_hvx_desc(self, f):
+        f.write(code_fmt(f"""\
+            /* {self.reg_tcg()} is *(MMVector *)({self.helper_arg_name()}) */
+        """))
 
 class VRegPairDest(Register, Hvx, Dest):
     def decl_tcg(self, f, tag, regno):
@@ -754,6 +770,10 @@ def decl_tcg(self, f, tag, regno):
             """))
     def log_write(self, f, tag):
         pass
+    def helper_hvx_desc(self, f):
+        f.write(code_fmt(f"""\
+            /* {self.reg_tcg()} is *(MMVectorPair *)({self.helper_arg_name()}) */
+        """))
 
 class VRegPairSource(Register, Hvx, OldSource):
     def decl_tcg(self, f, tag, regno):
@@ -773,6 +793,10 @@ def decl_tcg(self, f, tag, regno):
                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
             """))
+    def helper_hvx_desc(self, f):
+        f.write(code_fmt(f"""\
+            /* {self.reg_tcg()} is *(MMVectorPair *)({self.helper_arg_name()}) */
+        """))
 
 class VRegPairReadWrite(Register, Hvx, ReadWrite):
     def decl_tcg(self, f, tag, regno):
@@ -797,6 +821,10 @@ def log_write(self, f, tag):
             gen_log_vreg_write_pair(ctx, {self.hvx_off()}, {self.reg_num},
                                     {hvx_newv(tag)});
         """))
+    def helper_hvx_desc(self, f):
+        f.write(code_fmt(f"""\
+            /* {self.reg_tcg()} is *(MMVectorPair *)({self.helper_arg_name()}) */
+        """))
 
 class QRegDest(Register, Hvx, Dest):
     def decl_tcg(self, f, tag, regno):
@@ -812,6 +840,10 @@ def decl_tcg(self, f, tag, regno):
             """))
     def log_write(self, f, tag):
         pass
+    def helper_hvx_desc(self, f):
+        f.write(code_fmt(f"""\
+            /* {self.reg_tcg()} is *(MMQReg *)({self.helper_arg_name()}) */
+        """))
 
 class QRegSource(Register, Hvx, OldSource):
     def decl_tcg(self, f, tag, regno):
@@ -825,6 +857,10 @@ def decl_tcg(self, f, tag, regno):
                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
             """))
+    def helper_hvx_desc(self, f):
+        f.write(code_fmt(f"""\
+            /* {self.reg_tcg()} is *(MMQReg *)({self.helper_arg_name()}) */
+        """))
 
 class QRegReadWrite(Register, Hvx, ReadWrite):
     def decl_tcg(self, f, tag, regno):
@@ -843,6 +879,10 @@ def decl_tcg(self, f, tag, regno):
             """))
     def log_write(self, f, tag):
         pass
+    def helper_hvx_desc(self, f):
+        f.write(code_fmt(f"""\
+            /* {self.reg_tcg()} is *(MMQReg *)({self.helper_arg_name()}) */
+        """))
 
 def init_registers():
     regs = {
-- 
2.34.1


