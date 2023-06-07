Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBD47258D9
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 10:56:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6oy1-0008MK-W7; Wed, 07 Jun 2023 04:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1q6oy0-0008LS-1l
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 04:56:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1q6oxx-0006ys-Po
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 04:56:31 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3573q3jH025070; Wed, 7 Jun 2023 08:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=AqOM5v5wRoMVZoTCQ2FDOUbfPBWqPzz4mwoVWihfUGU=;
 b=IPf6ITL89Vfm6MLfIsaDW1A00lwH5KjASJRfFyepzXxeVx/PKn8yLXgfS1VYv60CWGwD
 +6JrogjSIU/xw6nPKZyZ6yuoq41Sodn/aZtV+B1qdQwTZ1cc+mOJMmNETv8J3oCwvlbO
 lGaqggYGu3RG5FzIthe6mR7oV003uijlISn/MN6QhcuOKDwe+7aSInoXkqkcQB3oeBdh
 zbgFoJapEtlpUkTa2iE2bVfcxh4vCqTbuGSluEJW9EwGd8oIObZOnPxkMjD/jUU8d4Z1
 zHdaUI7gDSDybDRRvcyO3Kb4wC2xYN0ha9gZBBxbzxuJ/kfRQd++3q7UXQT2QmmaKeYw OQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a7g1dcr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jun 2023 08:56:24 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3578uDn1025705
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 7 Jun 2023 08:56:13 GMT
Received: from acaggian1-mac.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 7 Jun 2023 01:56:12 -0700
From: Antonio Caggiano <quic_acaggian@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Cameron Esfahani
 <dirty@apple.com>, Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PATCH v2] hvf: Report HV_DENIED error
Date: Wed, 7 Jun 2023 10:55:55 +0200
Message-ID: <20230607085555.51643-1-quic_acaggian@quicinc.com>
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
X-Proofpoint-GUID: oLqtkHPH0RaLvFQ6VvLwmHy42-QlDTcS
X-Proofpoint-ORIG-GUID: oLqtkHPH0RaLvFQ6VvLwmHy42-QlDTcS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=682
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070073
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

On MacOS 11 and subsequent versions, in case the resulting binary is not
signed with the proper entitlement, handle and report the HV_DENIED
error.

Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com>
---
v2: Use architecture specific defines from AvailabilityMacros.h to enable the
    HV_DENIED case only on MacOS 11 and subsequent versions.

 accel/hvf/hvf-all.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 754707dbfb..1eacfc6a95 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -38,6 +38,11 @@ void assert_hvf_ok(hv_return_t ret)
     case HV_UNSUPPORTED:
         error_report("Error: HV_UNSUPPORTED");
         break;
+#if __MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_VERSION_11_0
+    case HV_DENIED:
+        error_report("Error: HV_DENIED");
+        break;
+#endif
     default:
         error_report("Unknown Error");
     }
-- 
2.40.0


