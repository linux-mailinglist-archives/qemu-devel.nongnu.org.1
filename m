Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA59B7D01AA
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:34:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXpS-0006Yp-Al; Thu, 19 Oct 2023 14:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1qtXpP-0006Qc-MH; Thu, 19 Oct 2023 14:33:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1qtXpN-0007m5-5U; Thu, 19 Oct 2023 14:33:03 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JHLliO017804; Thu, 19 Oct 2023 18:32:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=Y/f/pgBe7uF4kgxUtbkvjVoNU94KxcfCsyOxwBFNTlo=;
 b=JPd7xFAQnCe4G27dGEgtsaDdrDDpF8g5YjK8AT3XqMOfGDhuXz5Kn/7T6lxTDtSMTLtA
 Tdm4Ts1YsCrc7Z5fPLo8CmxPbc0sGtb2Rnd2rtFuciyTYGdJ416HOgJO4V0mjwIgTgn4
 ANhDB2lRQbiIXJjRQLkMS3f/QrQs1JyY4x3moTQsAdH0MrEbhGYCporoZ6rRTga39Rn7
 /Nw0nwviyVlG7elgnit97kPuSPUQImPRHoZNBHq+Ml7KZaX6IFqAKqEUsamo4Qhfn6hX
 6vOMWyX3Y1kb2RrS9NKINVxDg7/2WOPx6FhyQGGBgoy3s63fW8JyqCzYxBJ6aImxKYyh 8Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ttg82um1m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 18:32:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39JIWuSr009970
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 18:32:56 GMT
Received: from hu-mathbern-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 19 Oct 2023 11:32:56 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <alex.bennee@linaro.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH] semihosting: fix memleak at semihosting_arg_fallback
Date: Thu, 19 Oct 2023 15:32:46 -0300
Message-ID: <ebb2ec1150da633507c2b735ca8ea1cab05ec92a.1697740364.git.quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: g4-adTB35bv-SqdMOpo9OGYtdbzUe6cb
X-Proofpoint-ORIG-GUID: g4-adTB35bv-SqdMOpo9OGYtdbzUe6cb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_17,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0
 mlxlogscore=690 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310190157
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_mathbern@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We duplicate "cmd" as strtok may modify its argument, but we forgot
to free it later. Furthermore, add_semihosting_arg doesn't take
responsibility for this memory either (it strdup's the argument).

Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
---
 semihosting/config.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/semihosting/config.c b/semihosting/config.c
index 249a377ae8..32aa210460 100644
--- a/semihosting/config.c
+++ b/semihosting/config.c
@@ -112,17 +112,19 @@ static int add_semihosting_arg(void *opaque,
 /* Use strings passed via -kernel/-append to initialize semihosting.argv[] */
 void semihosting_arg_fallback(const char *file, const char *cmd)
 {
-    char *cmd_token;
+    char *cmd_token, *cmd_dup;
 
     /* argv[0] */
     add_semihosting_arg(&semihosting, "arg", file, NULL);
 
     /* split -append and initialize argv[1..n] */
-    cmd_token = strtok(g_strdup(cmd), " ");
+    cmd_dup = g_strdup(cmd);
+    cmd_token = strtok(cmd_dup, " ");
     while (cmd_token) {
         add_semihosting_arg(&semihosting, "arg", cmd_token, NULL);
         cmd_token = strtok(NULL, " ");
     }
+    g_free(cmd_dup);
 }
 
 void qemu_semihosting_enable(void)
-- 
2.37.2


