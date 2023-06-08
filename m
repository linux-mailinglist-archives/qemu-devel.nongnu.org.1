Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AF272800C
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 14:31:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Emr-0001EU-2C; Thu, 08 Jun 2023 08:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1q7Emo-0001EK-0m
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:30:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1q7Emk-00061e-9v
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:30:41 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 358BnWmd004285; Thu, 8 Jun 2023 12:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=T72ZH92DjfQ4OQ8qRX0tpokD25XffbVCTCQy4VMjArI=;
 b=Qdn5dnQybqXRdEIYF0VvKUzn7Aiu/KILqMKoppSluH4Intuudi1yOySkRym7hzsAFfGb
 pQmX7eyhGVp3BWbOpHaQXPuo7o51uIqREgXG2VqMeb7jYzwPbp8q5NtJo6jg8QNv5i6L
 DaK70WMxT43iPCetKh590rgE+r+qnBOucvdG3B8CoJ+yK4kZqHDxecYwWrxhWUgoZa9U
 +iSWrCbIX6LxblWyWMfpXQ+wgqOMhbFDYKVhZOiCF9/Q/3T86LcIl0X4dV6YQY94k7SS
 Si9kPWSES/gSpWyuQyBq1Oo3ZmI8D/g1bvMk+exCnvQcZ64Ow7TK9ZKQ1qXzccLGTzvq hw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r33bvs7gm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Jun 2023 12:30:31 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 358CUVTv032053
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 8 Jun 2023 12:30:31 GMT
Received: from acaggian1-mac.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 8 Jun 2023 05:30:29 -0700
From: Antonio Caggiano <quic_acaggian@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Cameron Esfahani
 <dirty@apple.com>, Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PATCH v3] hvf: Report HV_DENIED error
Date: Thu, 8 Jun 2023 14:30:14 +0200
Message-ID: <20230608123014.28715-1-quic_acaggian@quicinc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: ESLAQpiqVoGZj97s9biDytEmKgAVYtSQ
X-Proofpoint-ORIG-GUID: ESLAQpiqVoGZj97s9biDytEmKgAVYtSQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_08,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0
 mlxscore=0 clxscore=1015 spamscore=0 phishscore=0 mlxlogscore=696
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306080108
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_acaggian@quicinc.com; helo=mx0a-0031df01.pphosted.com
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

On MacOS 11 and subsequent versions, in case the resulting binary is not
signed with the proper entitlement, handle and report the HV_DENIED
error.

Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com>
---
v2: Use architecture specific defines from AvailabilityMacros.h to enable the
    HV_DENIED case only on MacOS 11 and subsequent versions.
v3: Fix ifdef guard.

 accel/hvf/hvf-all.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 754707dbfb..4920787af6 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -38,6 +38,12 @@ void assert_hvf_ok(hv_return_t ret)
     case HV_UNSUPPORTED:
         error_report("Error: HV_UNSUPPORTED");
         break;
+#if defined(MAC_OS_VERSION_11_0) && \
+    MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_VERSION_11_0
+    case HV_DENIED:
+        error_report("Error: HV_DENIED");
+        break;
+#endif
     default:
         error_report("Unknown Error");
     }
-- 
2.40.0


