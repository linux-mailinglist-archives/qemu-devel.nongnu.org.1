Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6525470C49A
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 19:48:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q19dA-0008PA-8i; Mon, 22 May 2023 13:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mliebel@quicinc.com>)
 id 1q19d8-0008Ok-Gl
 for qemu-devel@nongnu.org; Mon, 22 May 2023 13:47:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mliebel@quicinc.com>)
 id 1q19d6-0004zJ-M5
 for qemu-devel@nongnu.org; Mon, 22 May 2023 13:47:34 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34MFOpTp020574
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 17:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=rNmUz5I7eZVD9oX9/zVQgaWK4/oCaqceaV/rYft3lY8=;
 b=pDPEDb1P50//uOEv1WUR9xdlMvHuxbZCdae8IOHDswM70GSqsBwsLkKQCifR0Eo5KhYJ
 BcsykSSw5byC9bRtP54O8zZQ6fGyKOeuJySYXD5t6PqhPnVeERkCz0syyNNY4WVqn9lf
 EBS9l/mArQBG0+7w23FTZFxgOk1Kha1kalpSTbcjElACNeou46dih/7pnZzjavM16gGr
 POIEB62VaUgjcezhbjj87UGv2xYGBl9tIwZbrnqOEFhK0+r9eSY7XIeXK8UMhtgEHEfc
 3Rwm4W2BMzBUEnYZ1i/9rxQnWR62xh6KRV5F0bvO6zb1M8xeCQ6fJ4t5kGbIyR8S3Rgh vA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qraasreq3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 17:47:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34MHlTsV028609
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 17:47:29 GMT
Received: from hu-mliebel-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 22 May 2023 10:47:29 -0700
From: Marco Liebel <quic_mliebel@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: Taylor Simpson <tsimpson@quicinc.com>, Brian Cain <bcain@quicinc.com>,
 Marco Liebel <quic_mliebel@quicinc.com>
Subject: [PATCH v2] Hexagon (target/hexagon) Fix assignment to tmp registers
Date: Mon, 22 May 2023 10:47:08 -0700
Message-ID: <20230522174708.464197-1-quic_mliebel@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: FuzODKetG5PF3sOF8ZNLVuRgKfmmzyTW
X-Proofpoint-ORIG-GUID: FuzODKetG5PF3sOF8ZNLVuRgKfmmzyTW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_12,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 mlxlogscore=896
 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220150
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_mliebel@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The order in which instructions are generated by gen_insn() influences
assignment to tmp registers. During generation, tmp instructions (e.g.
generate_V6_vassign_tmp) use vreg_src_off() to determine what kind of
register to use as source. If some instruction (e.g.
generate_V6_vmpyowh_64_acc) uses a tmp register but is generated prior
to the corresponding tmp instruction, the vregs_updated_tmp bit map
isn't updated in time.

Exmple:
    { v14.tmp = v16; v25 = v14 } This works properly because
    generate_V6_vassign_tmp is generated before generate_V6_vassign
    and the bit map is updated.

    { v15:14.tmp = vcombine(v21, v16); v25:24 += vmpyo(v18.w,v14.h) }
    This does not work properly because vmpyo is generated before
    vcombine and therefore the bit map does not yet know that there's
    a tmp register.

The parentheses in the decoding function were in the wrong place.
Moving them to the correct location makes shuffling of .tmp vector
registers work as expected.

Signed-off-by: Marco Liebel <quic_mliebel@quicinc.com>
---
 target/hexagon/mmvec/decode_ext_mmvec.c |  8 +++----
 tests/tcg/hexagon/hvx_misc.c            | 31 +++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/target/hexagon/mmvec/decode_ext_mmvec.c b/target/hexagon/mmvec/decode_ext_mmvec.c
index 061a65ab88..174eb3b78b 100644
--- a/target/hexagon/mmvec/decode_ext_mmvec.c
+++ b/target/hexagon/mmvec/decode_ext_mmvec.c
@@ -1,5 +1,5 @@
 /*
- *  Copyright(c) 2019-2021 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -148,9 +148,9 @@ decode_shuffle_for_execution_vops(Packet *pkt)
     int i;
     for (i = 0; i < pkt->num_insns; i++) {
         uint16_t opcode = pkt->insn[i].opcode;
-        if (GET_ATTRIB(opcode, A_LOAD) &&
-            (GET_ATTRIB(opcode, A_CVI_NEW) ||
-             GET_ATTRIB(opcode, A_CVI_TMP))) {
+        if ((GET_ATTRIB(opcode, A_LOAD) &&
+             GET_ATTRIB(opcode, A_CVI_NEW)) ||
+            GET_ATTRIB(opcode, A_CVI_TMP)) {
             /*
              * Find prior consuming vector instructions
              * Move to end of packet
diff --git a/tests/tcg/hexagon/hvx_misc.c b/tests/tcg/hexagon/hvx_misc.c
index 09dec8d7a1..b45170acd1 100644
--- a/tests/tcg/hexagon/hvx_misc.c
+++ b/tests/tcg/hexagon/hvx_misc.c
@@ -60,6 +60,36 @@ static void test_load_tmp(void)
     check_output_w(__LINE__, BUFSIZE);
 }
 
+static void test_load_tmp2(void)
+{
+    void *pout0 = &output[0];
+    void *pout1 = &output[1];
+
+    asm volatile(
+        "r0 = #0x03030303\n\t"
+        "v16 = vsplat(r0)\n\t"
+        "r0 = #0x04040404\n\t"
+        "v18 = vsplat(r0)\n\t"
+        "r0 = #0x05050505\n\t"
+        "v21 = vsplat(r0)\n\t"
+        "{\n\t"
+        "   v25:24 += vmpyo(v18.w, v14.h)\n\t"
+        "   v15:14.tmp = vcombine(v21, v16)\n\t"
+        "}\n\t"
+        "vmem(%0 + #0) = v24\n\t"
+        "vmem(%1 + #0) = v25\n\t"
+        : : "r"(pout0), "r"(pout1)
+        : "r0", "v16", "v18", "v21", "v24", "v25", "memory"
+    );
+
+    for (int i = 0; i < MAX_VEC_SIZE_BYTES / 4; ++i) {
+        expect[0].w[i] = 0x180c0000;
+        expect[1].w[i] = 0x000c1818;
+    }
+
+    check_output_w(__LINE__, 2);
+}
+
 static void test_load_cur(void)
 {
     void *p0 = buffer0;
@@ -435,6 +465,7 @@ int main()
     init_buffers();
 
     test_load_tmp();
+    test_load_tmp2();
     test_load_cur();
     test_load_aligned();
     test_load_unaligned();
-- 
2.25.1


