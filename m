Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A749B70C31A
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 18:16:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q18Bb-0007lo-OJ; Mon, 22 May 2023 12:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mliebel@quicinc.com>)
 id 1q18BP-0007kn-9t
 for qemu-devel@nongnu.org; Mon, 22 May 2023 12:14:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mliebel@quicinc.com>)
 id 1q18BN-000355-8J
 for qemu-devel@nongnu.org; Mon, 22 May 2023 12:14:51 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34MDKHNN003586
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 16:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=bxOLZid/Z95UhmCgS0fGyP4WyRF7q6T3npDoWm5XsGA=;
 b=YzUgpAwhPNksF6Ku1naJFkX8T18BeioU2bRMfOWp3nQGJ1KnLgaL82tRMEPbOw6R3Dna
 /ONqMyZZhFYbbTVSxbyMDulCLfOhyqynvEB4GN/SMqepXfvjuEXdSIaeOIYJ6wN52nOs
 PybnJYwTzWfl7ROKZUAB+DBEoVA9TBHseUJCUtH2Qin4U9Ax6o1Eo3iHrnabOviSQJmr
 vM7E7NgrpYgxTCAFZNuROlXajsyOBSQT1mn56ii2pmoShu8OYT1bJdUGAwpWq4STkWw4
 pkC3PC8nxCsnPjwjlh/nqSxrwOJx7YwY7tob+U/dI/RsgH0XGvDERGYllrmdUDEMcK5J 0Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qpn7f4a6m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 16:14:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34MGEWZT013548
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 16:14:33 GMT
Received: from hu-mliebel-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 22 May 2023 09:14:32 -0700
From: Marco Liebel <quic_mliebel@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: Taylor Simpson <tsimpson@quicinc.com>, Brian Cain <bcain@quicinc.com>,
 Marco Liebel <quic_mliebel@quicinc.com>
Subject: [PATCH] Hexagon (target/hexagon) Fix assignment to tmp registers
Date: Mon, 22 May 2023 09:13:56 -0700
Message-ID: <20230522161356.438293-1-quic_mliebel@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: GvCYmo7uz7SKwLMw3f27SdZYClEiSVuh
X-Proofpoint-ORIG-GUID: GvCYmo7uz7SKwLMw3f27SdZYClEiSVuh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_11,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=894
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220135
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
    generate_V6_assign_tmp is generated before generate_V6_assign and
    the bit map is updated.

    { v15:14.tmp = vcombine(v21, v16); v25:24 += vmpyo(v18.w,v14.h) }
    This does not work properly because vmpyo is generated before
    vcombine and therefore the bit map does not yet know that there's
    a tmp register.

The parentheses in the decoding function were in the wrong place.
Moving them to the correct location makes shuffling of .tmp vector
registers work as expected.
---
 target/hexagon/mmvec/decode_ext_mmvec.c |  6 ++---
 tests/tcg/hexagon/hvx_misc.c            | 31 +++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/target/hexagon/mmvec/decode_ext_mmvec.c b/target/hexagon/mmvec/decode_ext_mmvec.c
index 061a65ab88..8d60804deb 100644
--- a/target/hexagon/mmvec/decode_ext_mmvec.c
+++ b/target/hexagon/mmvec/decode_ext_mmvec.c
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


