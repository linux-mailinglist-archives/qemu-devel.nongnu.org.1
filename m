Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8552A70F8EB
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 16:42:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1pgd-0001Rp-K5; Wed, 24 May 2023 10:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qualcomm.com>)
 id 1q1pgb-0001RH-CN
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:41:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qualcomm.com>)
 id 1q1pgX-0000d9-Ts
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:41:57 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34OA6Zr9016222; Wed, 24 May 2023 14:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=qcppdkim1;
 bh=dsMmg5OuF/Z9H3h+K9bWdBUa912BCnkCvFUV5yA6cj0=;
 b=eagIqWTvwbmhVafaSLuima09xeb3w1vJdVDf16rjxboT7V8lKLUd35gA697Uc3e+LrxH
 z/lgrJ+1xwJnh8t5ojiDkdYnLVv+54gLYaFWSVIKJZqhY1TzI0tNrcN035RxvyBJ53F4
 zGzHy7YhBRznEM/C0JPUWYZYoAopAEtZDR4uRbjR6SAVlK3WQPXkjQKr8SpdHrQxEWm7
 dPBoEJH0UUzEqA8RPunUQYkhjcvuoSeLZKvWgUvkYzZY4yr1Y/vevYR6gjekd6SErjF9
 tvwqAv0FULtWw90IkVtvfuzld/PZ0j8mPEla5hm2w7V50lIdjlYsEKbpIrid7uYS3Uvo ew== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qs42ut1a4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 May 2023 14:41:52 +0000
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34OEadPE020153; 
 Wed, 24 May 2023 14:41:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 3qrduqchbh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 May 2023 14:41:50 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34OEfooc025348;
 Wed, 24 May 2023 14:41:50 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-mathbern-lv.qualcomm.com
 [10.47.235.147])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 34OEfnFD025336
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 May 2023 14:41:50 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 4229910)
 id C33F4744A; Wed, 24 May 2023 11:41:49 -0300 (-03)
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, bcain@quicinc.com, quic_mliebel@quicinc.com,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 1/2] target/hexagon/*.py: clean up used 'toss' and
 'numregs' vars
Date: Wed, 24 May 2023 11:41:47 -0300
Message-Id: <3ffd4ccb972879f57f499705c624e8eaba7f8b52.1684939078.git.quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1684939078.git.quic_mathbern@quicinc.com>
References: <cover.1684939078.git.quic_mathbern@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: UNmLTivz5ROfkQzo5TjVN9xoKbOxZ9mD
X-Proofpoint-GUID: UNmLTivz5ROfkQzo5TjVN9xoKbOxZ9mD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_09,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxlogscore=826 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240120
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mathbern@qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Many Hexagon python scripts call hex_common.get_tagregs(), but only one
call site use the full reg structure given by this function. To make the
code cleaner, let's make get_tagregs() filter out the unused fields
(i.e. 'toss' and 'numregs'), properly removed the unused variables at
the call sites. The hex_common.bad_register() function is also adjusted
to work exclusively with 'regtype' and 'regid' args. For the single call
site that does use toss/numregs, we provide an optional parameter to
get_tagregs() which will restore the old full behavior.

Suggested-by: Taylor Simpson <tsimpson@quicinc.com>
Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
---
 target/hexagon/gen_analyze_funcs.py     | 10 +++---
 target/hexagon/gen_helper_funcs.py      | 30 ++++++++--------
 target/hexagon/gen_helper_protos.py     | 22 ++++++------
 target/hexagon/gen_idef_parser_funcs.py |  4 +--
 target/hexagon/gen_op_regs.py           |  4 +--
 target/hexagon/gen_tcg_funcs.py         | 46 ++++++++++++-------------
 target/hexagon/hex_common.py            | 24 ++++++-------
 7 files changed, 70 insertions(+), 70 deletions(-)

diff --git a/target/hexagon/gen_analyze_funcs.py b/target/hexagon/gen_analyze_funcs.py
index 00868cc6cb..c3b521abef 100755
--- a/target/hexagon/gen_analyze_funcs.py
+++ b/target/hexagon/gen_analyze_funcs.py
@@ -165,7 +165,7 @@ def analyze_opn_new(f, tag, regtype, regid, regno):
         hex_common.bad_register(regtype, regid)
 
 
-def analyze_opn(f, tag, regtype, regid, toss, numregs, i):
+def analyze_opn(f, tag, regtype, regid, i):
     if hex_common.is_pair(regid):
         analyze_opn_old(f, tag, regtype, regid, i)
     elif hex_common.is_single(regid):
@@ -174,9 +174,9 @@ def analyze_opn(f, tag, regtype, regid, toss, numregs, i):
         elif hex_common.is_new_val(regtype, regid, tag):
             analyze_opn_new(f, tag, regtype, regid, i)
         else:
-            hex_common.bad_register(regtype, regid, toss, numregs)
+            hex_common.bad_register(regtype, regid)
     else:
-        hex_common.bad_register(regtype, regid, toss, numregs)
+        hex_common.bad_register(regtype, regid)
 
 
 ##
@@ -202,8 +202,8 @@ def gen_analyze_func(f, tag, regs, imms):
 
     i = 0
     ## Analyze all the registers
-    for regtype, regid, toss, numregs in regs:
-        analyze_opn(f, tag, regtype, regid, toss, numregs, i)
+    for regtype, regid in regs:
+        analyze_opn(f, tag, regtype, regid, i)
         i += 1
 
     has_generated_helper = not hex_common.skip_qemu_helper(
diff --git a/target/hexagon/gen_helper_funcs.py b/target/hexagon/gen_helper_funcs.py
index e80550f94e..ce21d3b688 100755
--- a/target/hexagon/gen_helper_funcs.py
+++ b/target/hexagon/gen_helper_funcs.py
@@ -87,9 +87,9 @@ def gen_helper_arg_opn(f, regtype, regid, i, tag):
         elif hex_common.is_new_val(regtype, regid, tag):
             gen_helper_arg_new(f, regtype, regid, i)
         else:
-            hex_common.bad_register(regtype, regid, toss, numregs)
+            hex_common.bad_register(regtype, regid)
     else:
-        hex_common.bad_register(regtype, regid, toss, numregs)
+        hex_common.bad_register(regtype, regid)
 
 
 def gen_helper_arg_imm(f, immlett):
@@ -135,7 +135,7 @@ def gen_helper_dest_decl_opn(f, regtype, regid, i):
         else:
             gen_helper_dest_decl(f, regtype, regid, i)
     else:
-        hex_common.bad_register(regtype, regid, toss, numregs)
+        hex_common.bad_register(regtype, regid)
 
 
 def gen_helper_src_var_ext(f, regtype, regid):
@@ -185,7 +185,7 @@ def gen_helper_return_opn(f, regtype, regid, i):
         else:
             gen_helper_return(f, regtype, regid, i)
     else:
-        hex_common.bad_register(regtype, regid, toss, numregs)
+        hex_common.bad_register(regtype, regid)
 
 
 ##
@@ -208,7 +208,7 @@ def gen_helper_function(f, tag, tagregs, tagimms):
     numresults = 0
     numscalarresults = 0
     numscalarreadwrite = 0
-    for regtype, regid, toss, numregs in regs:
+    for regtype, regid in regs:
         if hex_common.is_written(regid):
             numresults += 1
             if hex_common.is_scalar_reg(regtype):
@@ -226,7 +226,7 @@ def gen_helper_function(f, tag, tagregs, tagimms):
         ## The return type of the function is the type of the destination
         ## register (if scalar)
         i = 0
-        for regtype, regid, toss, numregs in regs:
+        for regtype, regid in regs:
             if hex_common.is_written(regid):
                 if hex_common.is_pair(regid):
                     if hex_common.is_hvx_reg(regtype):
@@ -239,7 +239,7 @@ def gen_helper_function(f, tag, tagregs, tagimms):
                     else:
                         gen_helper_return_type(f, regtype, regid, i)
                 else:
-                    hex_common.bad_register(regtype, regid, toss, numregs)
+                    hex_common.bad_register(regtype, regid)
             i += 1
 
         if numscalarresults == 0:
@@ -248,7 +248,7 @@ def gen_helper_function(f, tag, tagregs, tagimms):
 
         ## Arguments include the vector destination operands
         i = 1
-        for regtype, regid, toss, numregs in regs:
+        for regtype, regid in regs:
             if hex_common.is_written(regid):
                 if hex_common.is_pair(regid):
                     if hex_common.is_hvx_reg(regtype):
@@ -262,12 +262,12 @@ def gen_helper_function(f, tag, tagregs, tagimms):
                         # This is the return value of the function
                         continue
                 else:
-                    hex_common.bad_register(regtype, regid, toss, numregs)
+                    hex_common.bad_register(regtype, regid)
                 i += 1
 
         ## For conditional instructions, we pass in the destination register
         if "A_CONDEXEC" in hex_common.attribdict[tag]:
-            for regtype, regid, toss, numregs in regs:
+            for regtype, regid in regs:
                 if hex_common.is_writeonly(regid) and not hex_common.is_hvx_reg(
                     regtype
                 ):
@@ -275,7 +275,7 @@ def gen_helper_function(f, tag, tagregs, tagimms):
                     i += 1
 
         ## Arguments to the helper function are the source regs and immediates
-        for regtype, regid, toss, numregs in regs:
+        for regtype, regid in regs:
             if hex_common.is_read(regid):
                 if hex_common.is_hvx_reg(regtype) and hex_common.is_readwrite(regid):
                     continue
@@ -315,12 +315,12 @@ def gen_helper_function(f, tag, tagregs, tagimms):
         ## Declare the return variable
         i = 0
         if "A_CONDEXEC" not in hex_common.attribdict[tag]:
-            for regtype, regid, toss, numregs in regs:
+            for regtype, regid in regs:
                 if hex_common.is_writeonly(regid):
                     gen_helper_dest_decl_opn(f, regtype, regid, i)
                 i += 1
 
-        for regtype, regid, toss, numregs in regs:
+        for regtype, regid in regs:
             if hex_common.is_read(regid):
                 if hex_common.is_pair(regid):
                     if hex_common.is_hvx_reg(regtype):
@@ -329,7 +329,7 @@ def gen_helper_function(f, tag, tagregs, tagimms):
                     if hex_common.is_hvx_reg(regtype):
                         gen_helper_src_var_ext(f, regtype, regid)
                 else:
-                    hex_common.bad_register(regtype, regid, toss, numregs)
+                    hex_common.bad_register(regtype, regid)
 
         if hex_common.need_slot(tag):
             if "A_LOAD" in hex_common.attribdict[tag]:
@@ -345,7 +345,7 @@ def gen_helper_function(f, tag, tagregs, tagimms):
             f.write("    arch_fpop_end(env);\n")
 
         ## Save/return the return variable
-        for regtype, regid, toss, numregs in regs:
+        for regtype, regid in regs:
             if hex_common.is_written(regid):
                 gen_helper_return_opn(f, regtype, regid, i)
         f.write("}\n\n")
diff --git a/target/hexagon/gen_helper_protos.py b/target/hexagon/gen_helper_protos.py
index 3dedd76cb4..131043795a 100755
--- a/target/hexagon/gen_helper_protos.py
+++ b/target/hexagon/gen_helper_protos.py
@@ -46,13 +46,13 @@
 }
 
 
-def gen_def_helper_opn(f, tag, regtype, regid, toss, numregs, i):
+def gen_def_helper_opn(f, tag, regtype, regid, i):
     if hex_common.is_pair(regid):
         f.write(f", {def_helper_types_pair[regtype]}")
     elif hex_common.is_single(regid):
         f.write(f", {def_helper_types[regtype]}")
     else:
-        hex_common.bad_register(regtype, regid, toss, numregs)
+        hex_common.bad_register(regtype, regid)
 
 
 ##
@@ -68,7 +68,7 @@ def gen_helper_prototype(f, tag, tagregs, tagimms):
     numresults = 0
     numscalarresults = 0
     numscalarreadwrite = 0
-    for regtype, regid, toss, numregs in regs:
+    for regtype, regid in regs:
         if hex_common.is_written(regid):
             numresults += 1
             if hex_common.is_scalar_reg(regtype):
@@ -124,10 +124,10 @@ def gen_helper_prototype(f, tag, tagregs, tagimms):
         ## - Emit the scalar result
         ## - Emit the vector result
         i = 0
-        for regtype, regid, toss, numregs in regs:
+        for regtype, regid in regs:
             if hex_common.is_written(regid):
                 if not hex_common.is_hvx_reg(regtype):
-                    gen_def_helper_opn(f, tag, regtype, regid, toss, numregs, i)
+                    gen_def_helper_opn(f, tag, regtype, regid, i)
                 i += 1
 
         ## Put the env between the outputs and inputs
@@ -135,27 +135,27 @@ def gen_helper_prototype(f, tag, tagregs, tagimms):
         i += 1
 
         # Second pass
-        for regtype, regid, toss, numregs in regs:
+        for regtype, regid in regs:
             if hex_common.is_written(regid):
                 if hex_common.is_hvx_reg(regtype):
-                    gen_def_helper_opn(f, tag, regtype, regid, toss, numregs, i)
+                    gen_def_helper_opn(f, tag, regtype, regid, i)
                     i += 1
 
         ## For conditional instructions, we pass in the destination register
         if "A_CONDEXEC" in hex_common.attribdict[tag]:
-            for regtype, regid, toss, numregs in regs:
+            for regtype, regid in regs:
                 if hex_common.is_writeonly(regid) and not hex_common.is_hvx_reg(
                     regtype
                 ):
-                    gen_def_helper_opn(f, tag, regtype, regid, toss, numregs, i)
+                    gen_def_helper_opn(f, tag, regtype, regid, i)
                     i += 1
 
         ## Generate the qemu type for each input operand (regs and immediates)
-        for regtype, regid, toss, numregs in regs:
+        for regtype, regid in regs:
             if hex_common.is_read(regid):
                 if hex_common.is_hvx_reg(regtype) and hex_common.is_readwrite(regid):
                     continue
-                gen_def_helper_opn(f, tag, regtype, regid, toss, numregs, i)
+                gen_def_helper_opn(f, tag, regtype, regid, i)
                 i += 1
         for immlett, bits, immshift in imms:
             f.write(", s32")
diff --git a/target/hexagon/gen_idef_parser_funcs.py b/target/hexagon/gen_idef_parser_funcs.py
index 29160fcb1d..f4518e653f 100644
--- a/target/hexagon/gen_idef_parser_funcs.py
+++ b/target/hexagon/gen_idef_parser_funcs.py
@@ -131,7 +131,7 @@ def main():
             imms = tagimms[tag]
 
             arguments = []
-            for regtype, regid, toss, numregs in regs:
+            for regtype, regid in regs:
                 prefix = "in " if hex_common.is_read(regid) else ""
 
                 is_pair = hex_common.is_pair(regid)
@@ -147,7 +147,7 @@ def main():
                 elif is_single_new:
                     arguments.append(f"{prefix}{regtype}{regid}N")
                 else:
-                    hex_common.bad_register(regtype, regid, toss, numregs)
+                    hex_common.bad_register(regtype, regid)
 
             for immlett, bits, immshift in imms:
                 arguments.append(hex_common.imm_name(immlett))
diff --git a/target/hexagon/gen_op_regs.py b/target/hexagon/gen_op_regs.py
index 42972c7f9e..a8a7712129 100755
--- a/target/hexagon/gen_op_regs.py
+++ b/target/hexagon/gen_op_regs.py
@@ -70,7 +70,7 @@ def strip_reg_prefix(x):
 def main():
     hex_common.read_semantics_file(sys.argv[1])
     hex_common.read_attribs_file(sys.argv[2])
-    tagregs = hex_common.get_tagregs()
+    tagregs = hex_common.get_tagregs(full=True)
     tagimms = hex_common.get_tagimms()
 
     with open(sys.argv[3], "w") as f:
@@ -79,7 +79,7 @@ def main():
             rregs = []
             wregs = []
             regids = ""
-            for regtype, regid, toss, numregs in regs:
+            for regtype, regid, _, numregs in regs:
                 if hex_common.is_read(regid):
                     if regid[0] not in regids:
                         regids += regid[0]
diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs.py
index c73467b840..fe29d83d4d 100755
--- a/target/hexagon/gen_tcg_funcs.py
+++ b/target/hexagon/gen_tcg_funcs.py
@@ -223,7 +223,7 @@ def genptr_decl_new(f, tag, regtype, regid, regno):
         hex_common.bad_register(regtype, regid)
 
 
-def genptr_decl_opn(f, tag, regtype, regid, toss, numregs, i):
+def genptr_decl_opn(f, tag, regtype, regid, i):
     if hex_common.is_pair(regid):
         genptr_decl(f, tag, regtype, regid, i)
     elif hex_common.is_single(regid):
@@ -232,9 +232,9 @@ def genptr_decl_opn(f, tag, regtype, regid, toss, numregs, i):
         elif hex_common.is_new_val(regtype, regid, tag):
             genptr_decl_new(f, tag, regtype, regid, i)
         else:
-            hex_common.bad_register(regtype, regid, toss, numregs)
+            hex_common.bad_register(regtype, regid)
     else:
-        hex_common.bad_register(regtype, regid, toss, numregs)
+        hex_common.bad_register(regtype, regid)
 
 
 def genptr_decl_imm(f, immlett):
@@ -354,12 +354,12 @@ def genptr_src_read_opn(f, regtype, regid, tag):
         elif hex_common.is_new_val(regtype, regid, tag):
             genptr_src_read_new(f, regtype, regid)
         else:
-            hex_common.bad_register(regtype, regid, toss, numregs)
+            hex_common.bad_register(regtype, regid)
     else:
-        hex_common.bad_register(regtype, regid, toss, numregs)
+        hex_common.bad_register(regtype, regid)
 
 
-def gen_helper_call_opn(f, tag, regtype, regid, toss, numregs, i):
+def gen_helper_call_opn(f, tag, regtype, regid, i):
     if i > 0:
         f.write(", ")
     if hex_common.is_pair(regid):
@@ -370,9 +370,9 @@ def gen_helper_call_opn(f, tag, regtype, regid, toss, numregs, i):
         elif hex_common.is_new_val(regtype, regid, tag):
             f.write(f"{regtype}{regid}N")
         else:
-            hex_common.bad_register(regtype, regid, toss, numregs)
+            hex_common.bad_register(regtype, regid)
     else:
-        hex_common.bad_register(regtype, regid, toss, numregs)
+        hex_common.bad_register(regtype, regid)
 
 
 def gen_helper_decl_imm(f, immlett):
@@ -468,7 +468,7 @@ def genptr_dst_write_opn(f, regtype, regid, tag):
         else:
             genptr_dst_write(f, tag, regtype, regid)
     else:
-        hex_common.bad_register(regtype, regid, toss, numregs)
+        hex_common.bad_register(regtype, regid)
 
 
 ##
@@ -502,8 +502,8 @@ def gen_tcg_func(f, tag, regs, imms):
         gen_decl_ea_tcg(f, tag)
     i = 0
     ## Declare all the operands (regs and immediates)
-    for regtype, regid, toss, numregs in regs:
-        genptr_decl_opn(f, tag, regtype, regid, toss, numregs, i)
+    for regtype, regid in regs:
+        genptr_decl_opn(f, tag, regtype, regid, i)
         i += 1
     for immlett, bits, immshift in imms:
         genptr_decl_imm(f, immlett)
@@ -514,14 +514,14 @@ def gen_tcg_func(f, tag, regs, imms):
         f.write("    fCHECKFORGUEST();\n")
 
     ## Read all the inputs
-    for regtype, regid, toss, numregs in regs:
+    for regtype, regid in regs:
         if hex_common.is_read(regid):
             genptr_src_read_opn(f, regtype, regid, tag)
 
     if hex_common.is_idef_parser_enabled(tag):
         declared = []
         ## Handle registers
-        for regtype, regid, toss, numregs in regs:
+        for regtype, regid in regs:
             if hex_common.is_pair(regid) or (
                 hex_common.is_single(regid)
                 and hex_common.is_old_val(regtype, regid, tag)
@@ -532,7 +532,7 @@ def gen_tcg_func(f, tag, regs, imms):
             elif hex_common.is_new_val(regtype, regid, tag):
                 declared.append(f"{regtype}{regid}N")
             else:
-                hex_common.bad_register(regtype, regid, toss, numregs)
+                hex_common.bad_register(regtype, regid)
 
         ## Handle immediates
         for immlett, bits, immshift in imms:
@@ -564,11 +564,11 @@ def gen_tcg_func(f, tag, regs, imms):
         f.write(f"    gen_helper_{tag}(")
         i = 0
         ## If there is a scalar result, it is the return type
-        for regtype, regid, toss, numregs in regs:
+        for regtype, regid in regs:
             if hex_common.is_written(regid):
                 if hex_common.is_hvx_reg(regtype):
                     continue
-                gen_helper_call_opn(f, tag, regtype, regid, toss, numregs, i)
+                gen_helper_call_opn(f, tag, regtype, regid, i)
                 i += 1
         if i > 0:
             f.write(", ")
@@ -576,23 +576,23 @@ def gen_tcg_func(f, tag, regs, imms):
         i = 1
         ## For conditional instructions, we pass in the destination register
         if "A_CONDEXEC" in hex_common.attribdict[tag]:
-            for regtype, regid, toss, numregs in regs:
+            for regtype, regid in regs:
                 if hex_common.is_writeonly(regid) and not hex_common.is_hvx_reg(
                     regtype
                 ):
-                    gen_helper_call_opn(f, tag, regtype, regid, toss, numregs, i)
+                    gen_helper_call_opn(f, tag, regtype, regid, i)
                     i += 1
-        for regtype, regid, toss, numregs in regs:
+        for regtype, regid in regs:
             if hex_common.is_written(regid):
                 if not hex_common.is_hvx_reg(regtype):
                     continue
-                gen_helper_call_opn(f, tag, regtype, regid, toss, numregs, i)
+                gen_helper_call_opn(f, tag, regtype, regid, i)
                 i += 1
-        for regtype, regid, toss, numregs in regs:
+        for regtype, regid in regs:
             if hex_common.is_read(regid):
                 if hex_common.is_hvx_reg(regtype) and hex_common.is_readwrite(regid):
                     continue
-                gen_helper_call_opn(f, tag, regtype, regid, toss, numregs, i)
+                gen_helper_call_opn(f, tag, regtype, regid, i)
                 i += 1
         for immlett, bits, immshift in imms:
             gen_helper_call_imm(f, immlett)
@@ -612,7 +612,7 @@ def gen_tcg_func(f, tag, regs, imms):
         f.write(");\n")
 
     ## Write all the outputs
-    for regtype, regid, toss, numregs in regs:
+    for regtype, regid in regs:
         if hex_common.is_written(regid):
             genptr_dst_write_opn(f, regtype, regid, tag)
 
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index f3aac55db0..dce1b852a7 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -30,9 +30,8 @@
 overrides = {}  # tags with helper overrides
 idef_parser_enabled = {}  # tags enabled for idef-parser
 
-def bad_register(*args):
-    args_str = ", ".join(map(str, args))
-    raise Exception(f"Bad register parse: {args_str}")
+def bad_register(regtype, regid):
+    raise Exception(f"Bad register parse: regtype '{regtype}' regid '{regid}'")
 
 # We should do this as a hash for performance,
 # but to keep order let's keep it as a list.
@@ -124,7 +123,7 @@ def calculate_attribs():
     tagregs = get_tagregs()
     for tag in tags:
         regs = tagregs[tag]
-        for regtype, regid, toss, numregs in regs:
+        for regtype, regid in regs:
             if regtype == "P" and is_written(regid):
                 attribdict[tag].add("A_WRITES_PRED_REG")
     # Mark conditional jumps and calls
@@ -170,10 +169,11 @@ def MACROATTRIB(macname, beh, attribstring):
         attribs = []
     macros[macname] = Macro(macname, beh, attribs)
 
-
-def compute_tag_regs(tag):
-    return uniquify(regre.findall(behdict[tag]))
-
+def compute_tag_regs(tag, full):
+    tagregs = regre.findall(behdict[tag])
+    if not full:
+        tagregs = map(lambda reg: reg[:2], tagregs)
+    return uniquify(tagregs)
 
 def compute_tag_immediates(tag):
     return uniquify(immre.findall(behdict[tag]))
@@ -200,9 +200,9 @@ def compute_tag_immediates(tag):
 ##          x, y             read-write register
 ##          xx, yy           read-write register pair
 ##
-def get_tagregs():
-    return dict(zip(tags, list(map(compute_tag_regs, tags))))
-
+def get_tagregs(full=False):
+    compute_func = lambda tag: compute_tag_regs(tag, full)
+    return dict(zip(tags, list(map(compute_func, tags))))
 
 def get_tagimms():
     return dict(zip(tags, list(map(compute_tag_immediates, tags))))
@@ -285,7 +285,7 @@ def need_pkt_need_commit(tag):
 
 def need_condexec_reg(tag, regs):
     if "A_CONDEXEC" in attribdict[tag]:
-        for regtype, regid, toss, numregs in regs:
+        for regtype, regid in regs:
             if is_writeonly(regid) and not is_hvx_reg(regtype):
                 return True
     return False
-- 
2.37.2


