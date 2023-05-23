Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 662B570E696
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 22:37:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1YkI-0000Mh-E1; Tue, 23 May 2023 16:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qualcomm.com>)
 id 1q1YkF-0000Ll-VG
 for qemu-devel@nongnu.org; Tue, 23 May 2023 16:36:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qualcomm.com>)
 id 1q1YkE-0005UG-8B
 for qemu-devel@nongnu.org; Tue, 23 May 2023 16:36:35 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34NK84Ru022046
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 20:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=qcppdkim1;
 bh=6gYIsrxnpEoDRMWGSCaHoMZzNttFGJ3YmoA0FetGEbo=;
 b=HBJfW4CmurMoOGBK7LAqJF+G+FBBnYmrdcxish/SqgBy4aIeXNiVL6rA1I2h1sitBauV
 zJ8pb6y/o9TvW6KVZj2UexIkhLC9WepntPaM1BtvY75by1ttbwZ5E0g8W5nDKN+1o5v6
 QY/GJmNauVr3PXqHE8g4AG1bhVqiBjC4eXC1ZDIrUpy1MPxS6YOnPzmqRPio+Tl77bH5
 ifnQR7AHYXid1YBeUDHZAKpesrFLM8Eyb+A/O6dbNt/EjMdGKhXHn4sEYvRfDBTQkyst
 2aKy6Y8ROPSuvUsCvoPEWyIegXh70OrqQZQMFj3UifvdY9Kq/8bC78xdGKbSJIQFD39s Jg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qrpmm2d8q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 20:36:31 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34NKXe6A021350
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 20:36:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 3qpq9kujbe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 20:36:30 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34NKaULT025391
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 20:36:30 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-mathbern-lv.qualcomm.com
 [10.47.235.147])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 34NKaSIl025383
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 May 2023 20:36:30 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 4229910)
 id AFC807425; Tue, 23 May 2023 17:36:28 -0300 (-03)
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, bcain@quicinc.com, quic_mliebel@quicinc.com
Subject: [PATCH 1/2] target/hexagon/*.py: remove undef vars from bad_register()
Date: Tue, 23 May 2023 17:36:26 -0300
Message-Id: <ccd8a781537de107a9acfc0610a29837245d0a26.1684873957.git.quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1684873957.git.quic_mathbern@quicinc.com>
References: <cover.1684873957.git.quic_mathbern@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: IqhbyTWxXjZOQPOHcQLxHLrY-_iONf7K
X-Proofpoint-GUID: IqhbyTWxXjZOQPOHcQLxHLrY-_iONf7K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_13,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 adultscore=0 mlxlogscore=642 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230164
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mathbern@qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Some calls to `hex_common.bad_register()` in Hexagon python files are
passing undefined variables. Let's remove those.

Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
---
 target/hexagon/gen_helper_funcs.py | 8 ++++----
 target/hexagon/gen_tcg_funcs.py    | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/hexagon/gen_helper_funcs.py b/target/hexagon/gen_helper_funcs.py
index e80550f94e..367d08aceb 100755
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
diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs.py
index c73467b840..c87ea856f7 100755
--- a/target/hexagon/gen_tcg_funcs.py
+++ b/target/hexagon/gen_tcg_funcs.py
@@ -354,9 +354,9 @@ def genptr_src_read_opn(f, regtype, regid, tag):
         elif hex_common.is_new_val(regtype, regid, tag):
             genptr_src_read_new(f, regtype, regid)
         else:
-            hex_common.bad_register(regtype, regid, toss, numregs)
+            hex_common.bad_register(regtype, regid)
     else:
-        hex_common.bad_register(regtype, regid, toss, numregs)
+        hex_common.bad_register(regtype, regid)
 
 
 def gen_helper_call_opn(f, tag, regtype, regid, toss, numregs, i):
@@ -468,7 +468,7 @@ def genptr_dst_write_opn(f, regtype, regid, tag):
         else:
             genptr_dst_write(f, tag, regtype, regid)
     else:
-        hex_common.bad_register(regtype, regid, toss, numregs)
+        hex_common.bad_register(regtype, regid)
 
 
 ##
-- 
2.37.2


