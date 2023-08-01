Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7AE76B8B9
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 17:37:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQrRF-0006UH-3K; Tue, 01 Aug 2023 11:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1qQrRC-0006Tf-Jw
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 11:37:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1qQrRA-00024Q-2B
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 11:37:29 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37189Hnp011086; Tue, 1 Aug 2023 15:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=pWLaE5vb8MaR3/h9wLx1uazl8nEMET3hUZ/2Yk6vsZc=;
 b=lR8I12ObsxD2yeQST5C7brNOkZwJuZBBtJWXMmj5wVWe1F+b1jK5jAXwc3iclTTqVbA0
 8n5ZIpejE7mQc2g50ljbSr0F4WrxsuITc4KRl4gj1HYO9CE3ed6zWDAhoPV1CILR4LdG
 U+9+ciyIq6kNzd9F9648V6B3Ogl3mvG5JnTDr6w2uxVsvQ1CEXe6oufzm8NwwRr3vw6B
 gde6sStSt6roBFc95u1cqhQitB1BDd2rK8CuRKSt2OraXXfCNlr1THn3dA9LAgLmBqDc
 di4rB35AN/gLoQI1Pl4eJL/5KUEP6et+u8ydeVKwYjdADjhlO4OVSBURqDVghZycY2O+ /g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6j4etbpe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Aug 2023 15:37:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 371FbMRd025713
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 1 Aug 2023 15:37:22 GMT
Received: from hu-mathbern-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 1 Aug 2023 08:37:22 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <alex.bennee@linaro.org>, <iii@linux.ibm.com>, <bcain@quicinc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] gdbstub: use 0 ("any process") on packets with no PID
Date: Tue, 1 Aug 2023 12:37:11 -0300
Message-ID: <78a3b06f6ab90a7ff8e73ae14a996eb27ec76c85.1690904195.git.quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: Y86UgaKiP2LSOXJ7SSTuhubySJse8cwi
X-Proofpoint-ORIG-GUID: Y86UgaKiP2LSOXJ7SSTuhubySJse8cwi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_12,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011
 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308010140
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_mathbern@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Previously, qemu-user would always report PID 1 to GDB. This was changed
at dc14a7a6e9 (gdbstub: Report the actual qemu-user pid, 2023-06-30),
but read_thread_id() still considers GDB packets with "no PID" as "PID
1", which is not the qemu-user PID. Fix that by parsing "no PID" as "0",
which the GDB Remote Protocol defines as "any process".

Note that this should have no effect for system emulation as, in this
case, gdb_create_default_process() will assign PID 1 for the first
process and that is what the gdbstub uses for GDB requests with no PID,
or PID 0.

This issue was found with hexagon-lldb, which sends a "Hq" packet with
only the thread-id, but no process-id, leading to the invalid usage of
"PID 1" by qemu-hexagon and a subsequent "E22" reply.

Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
---
 gdbstub/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index ce8b42eb15..e74ecc78cc 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -537,7 +537,7 @@ static GDBThreadIdKind read_thread_id(const char *buf, const char **end_buf,
         /* Skip '.' */
         buf++;
     } else {
-        p = 1;
+        p = 0;
     }
 
     ret = qemu_strtoul(buf, &buf, 16, &t);
-- 
2.37.2


