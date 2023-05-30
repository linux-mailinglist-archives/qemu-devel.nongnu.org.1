Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91812716276
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:46:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zf5-0005y3-LS; Tue, 30 May 2023 09:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qualcomm.com>)
 id 1q3zf3-0005vU-Ej
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:45:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qualcomm.com>)
 id 1q3zf1-00083v-1f
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:45:17 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34UCUAo0031034
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 13:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=qcppdkim1;
 bh=wcwnrfUmA4AI9aeBkWgPB5bEUdSMWUfx5QoNfvcrYA8=;
 b=L8YtpztKto1kZ3aH/JtC3fuPSyMwTtTnOQyKlHYaXam90o2fpIC8TmTP+9p/x5aZd7FI
 Z6oHv/2UGMOEbh4yo28H4r4FjeO76DBUcS9fr1UPxbX0aWu4r2ASV0RR/Le7qwG4+ldR
 fRuXs7TyekWfHbC+gjBQi+a3nlRiZIBigZB0lN1tCIJ4So4sZbspXhy5cXGysVMLkeqv
 OxSRzbncd+HBLxmB+FwmncXUKfTMw//S7gS5WwASTTG9+6G4ojvYWDYOfJf6HGv6IfNW
 u1DqZruqJoZCREeLmuqth/w1w9wG0fwJEOwu0SXW3TwUUbiKi5k7IWA+jO5//Lkylc3u Tw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qwava8yvx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 13:45:11 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34UDjA1M018925
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 13:45:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 3quaxkrfxd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 13:45:10 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UDjAqQ018912
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 13:45:10 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-mathbern-lv.qualcomm.com
 [10.47.235.147])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 34UDj9lF018892
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 13:45:10 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 4229910)
 id DC61E7589; Tue, 30 May 2023 10:45:09 -0300 (-03)
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, bcain@quicinc.com, quic_mliebel@quicinc.com
Subject: [PATCH 2/2] Hexagon (tests/.../hex_test.h): use portable printf
 formats
Date: Tue, 30 May 2023 10:45:08 -0300
Message-Id: <a4a98ae4b091b02946e5a95801cb19aceb36f20c.1685454251.git.quic_mathbern@quicinc.com>
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
X-Proofpoint-GUID: QJ2_ebffPAfnsAQyKKdGkgpgQU6h3TNd
X-Proofpoint-ORIG-GUID: QJ2_ebffPAfnsAQyKKdGkgpgQU6h3TNd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_10,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 mlxlogscore=386 impostorscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

This fixes compiler messages like "warning: format specifies type
'unsigned int' but the argument has type 'uint32_t' (aka 'unsigned
long') [-Wformat]".

Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
---
 tests/tcg/hexagon/hex_test.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/hexagon/hex_test.h b/tests/tcg/hexagon/hex_test.h
index cfed06a58b..fe253b56e5 100644
--- a/tests/tcg/hexagon/hex_test.h
+++ b/tests/tcg/hexagon/hex_test.h
@@ -19,10 +19,13 @@
 #ifndef HEX_TEST_H
 #define HEX_TEST_H
 
+#include <inttypes.h>
+
 static inline void __check32(int line, uint32_t val, uint32_t expect)
 {
     if (val != expect) {
-        printf("ERROR at line %d: 0x%08x != 0x%08x\n", line, val, expect);
+        printf("ERROR at line %d: 0x%08"PRIx32" != 0x%08"PRIx32"\n",
+               line, val, expect);
         err++;
     }
 }
@@ -32,7 +35,8 @@ static inline void __check32(int line, uint32_t val, uint32_t expect)
 static inline void __check64(int line, uint64_t val, uint64_t expect)
 {
     if (val != expect) {
-        printf("ERROR at line %d: 0x%016llx != 0x%016llx\n", line, val, expect);
+        printf("ERROR at line %d: 0x%016"PRIx64" != 0x%016"PRIx64"\n",
+               line, val, expect);
         err++;
     }
 }
@@ -62,7 +66,8 @@ static inline void __checkp(int line, void *p, void *expect)
 static inline void __check32_ne(int line, uint32_t val, uint32_t expect)
 {
     if (val == expect) {
-        printf("ERROR at line %d: 0x%08x == 0x%08x\n", line, val, expect);
+        printf("ERROR at line %d: 0x%08"PRIx32" == 0x%08"PRIx32"\n",
+               line, val, expect);
         err++;
     }
 }
@@ -72,7 +77,8 @@ static inline void __check32_ne(int line, uint32_t val, uint32_t expect)
 static inline void __check64_ne(int line, uint64_t val, uint64_t expect)
 {
     if (val == expect) {
-        printf("ERROR at line %d: 0x%016llx == 0x%016llx\n", line, val, expect);
+        printf("ERROR at line %d: 0x%016"PRIx64" == 0x%016"PRIx64"\n",
+               line, val, expect);
         err++;
     }
 }
-- 
2.37.2


