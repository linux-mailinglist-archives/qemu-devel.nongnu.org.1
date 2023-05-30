Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B413716275
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:46:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zf4-0005x8-Oa; Tue, 30 May 2023 09:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qualcomm.com>)
 id 1q3zf3-0005vS-ED
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:45:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qualcomm.com>)
 id 1q3zf1-00083u-99
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:45:17 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34U6qBfR019831
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 13:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=qcppdkim1;
 bh=WuhrqVXMCKbx60pzUKS+XDlVz++v0zUXHT9fTDIlHy0=;
 b=hR+SDPSHjOlXqJjBviVT6eaCAWQd4lN1In7U5xJMGqvUN2aBDyF9EIG3iqnvC9hmDx00
 SGKTy87tHCYLYbbsF+MQZTXDVTkYmHxqRuJoGb5M2ZClqD/QJVOs8j/yZbhOz39yDeEu
 0UHwYZwKo3B6Xo589mpLnlnklD+kvkUu4XNpvYTxNUj5iP21k0Y4pncardXhFSho5igI
 VMq7WoNviNjaELjsym64tFcsAQ8ka3fzj+HJvMKeRVwljaBdxVjJrtl0wUA3M6IS809Y
 ezOF5W9d2iMjPmoXSD2/ehZExAhYbM3uWxR6zp36kGgpoYQtE1fxbexMP+8P18G/bSHm 9A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qw03q1s4r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 13:45:11 +0000
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34UDjA70028148
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 13:45:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 3quaxkrtr1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 13:45:10 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UDjAH8028138
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 13:45:10 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-mathbern-lv.qualcomm.com
 [10.47.235.147])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 34UDj9qZ028126
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 13:45:10 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 4229910)
 id CE70E7587; Tue, 30 May 2023 10:45:09 -0300 (-03)
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, bcain@quicinc.com, quic_mliebel@quicinc.com
Subject: [PATCH 1/2] Hexagon (hvx_misc test): fix uninitialized regs at
 test_load_tmp2
Date: Tue, 30 May 2023 10:45:07 -0300
Message-Id: <d7116649bde930a0d3ec3eaaf8638bdf0a02b118.1685454251.git.quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1685454251.git.quic_mathbern@quicinc.com>
References: <cover.1685454251.git.quic_mathbern@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: VKDQg73NKL5gMnE_AHrUBvxLt2jyqtgK
X-Proofpoint-ORIG-GUID: VKDQg73NKL5gMnE_AHrUBvxLt2jyqtgK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_10,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 clxscore=1015 mlxlogscore=888 adultscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300111
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mathbern@qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Marco Liebel <quic_mliebel@quicinc.com>

This test case was using some vector registers which were not properly
initialized.

Signed-off-by: Marco Liebel <quic_mliebel@quicinc.com>
Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
---
 tests/tcg/hexagon/hvx_misc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/hexagon/hvx_misc.c b/tests/tcg/hexagon/hvx_misc.c
index b45170acd1..b56b8f9cc5 100644
--- a/tests/tcg/hexagon/hvx_misc.c
+++ b/tests/tcg/hexagon/hvx_misc.c
@@ -66,6 +66,11 @@ static void test_load_tmp2(void)
     void *pout1 = &output[1];
 
     asm volatile(
+        "r0 = #0x0\n\t"
+        "v14 = vsplat(r0)\n\t"
+        "v15 = vsplat(r0)\n\t"
+        "v24 = vsplat(r0)\n\t"
+        "v25 = vsplat(r0)\n\t"
         "r0 = #0x03030303\n\t"
         "v16 = vsplat(r0)\n\t"
         "r0 = #0x04040404\n\t"
@@ -79,7 +84,7 @@ static void test_load_tmp2(void)
         "vmem(%0 + #0) = v24\n\t"
         "vmem(%1 + #0) = v25\n\t"
         : : "r"(pout0), "r"(pout1)
-        : "r0", "v16", "v18", "v21", "v24", "v25", "memory"
+        : "r0", "v14", "v15", "v16", "v18", "v21", "v24", "v25", "memory"
     );
 
     for (int i = 0; i < MAX_VEC_SIZE_BYTES / 4; ++i) {
-- 
2.37.2


