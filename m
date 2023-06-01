Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1C7719FEA
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 16:28:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4jH1-0003ox-CY; Thu, 01 Jun 2023 10:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1q4jGy-0003nA-KJ
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:27:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1q4jGx-0007x8-10
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:27:28 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 351CcLAq022585; Thu, 1 Jun 2023 14:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=U7IDYtAUWk4I7Vb2V+jFH7LfQFmk4BnCHXzEerAYWfA=;
 b=mIW6pYiF8AfYWfv37b88WvmRk4JS+wUeJZ5dY3ltfx+lUsXE5G0TyOaOPXAAGC3OAjXt
 1njw+dRwgwuBttD+To+HoKMajTRWfiKaT4Ik4pam/wZ4/19yIZUEcvR/tr89qvariIrm
 yroCCbK9YWCjO5YbWHyE43PctyoL+/i1kYkITkQwDXWm5wjJlAPidmgcPBvwnJkjsR+R
 /VVy8YjS78PkVM63qU5flPCSvO43mmWNjYvmInJEJ5bse0dzTFbhaeU9mQIlaYV2h3VA
 Hvote2eeDQzWzs6nLEbDNSDNFh3VfIivXXUQkDHFw/C3/1qyPFv3P7HZbQm85tNZ3JBr 2g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxugrg9ru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 14:27:23 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 351ERMpb031737
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 1 Jun 2023 14:27:22 GMT
Received: from acaggian1-mac.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 1 Jun 2023 07:27:21 -0700
From: Antonio Caggiano <quic_acaggian@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PATCH] hvf: Report HV_DENIED error
Date: Thu, 1 Jun 2023 16:27:04 +0200
Message-ID: <20230601142704.68768-1-quic_acaggian@quicinc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: GfFy_HmNfHGjZQ0Dl3Ct-5Cnbdj-ukhp
X-Proofpoint-GUID: GfFy_HmNfHGjZQ0Dl3Ct-5Cnbdj-ukhp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 mlxlogscore=691 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1011 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010127
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_acaggian@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In case the resulting binary is not signed with the proper entitlement,
handle and report the HV_DENIED error.

Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com>
---
 accel/hvf/hvf-all.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 0043f4d308..679907a147 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -38,6 +38,9 @@ void assert_hvf_ok(hv_return_t ret)
     case HV_UNSUPPORTED:
         error_report("Error: HV_UNSUPPORTED");
         break;
+    case HV_DENIED:
+        error_report("Error: HV_DENIED");
+        break;
     default:
         error_report("Unknown Error");
     }
-- 
2.40.0


