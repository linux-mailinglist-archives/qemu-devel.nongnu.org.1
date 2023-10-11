Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B0C7C5996
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 18:54:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqcSH-0008WO-Nq; Wed, 11 Oct 2023 12:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1qqcSD-0008Vw-5B; Wed, 11 Oct 2023 12:53:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1qqcSB-00010A-Av; Wed, 11 Oct 2023 12:53:00 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39BCKirn002889; Wed, 11 Oct 2023 16:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=48LMkArQrrk8xV0fYkkJ1i/85hu8dWonlWcx7vH/4DQ=;
 b=kheVdQn9uxN0cFs1mQeHLT2ALg4x+gWCvC+RF6pguzXcQyvbszI+OZfmyxy/Ed7lnmgu
 NqBrnh9W16UFAU6dn1N9A+5YgfzJ36nGkRmnU1dcbyQBsLzx+tN2fmySpH5DWFdja6CL
 xT5Kg9DFhCaqJE7/M9jIrfqJN+OCH3nkzZiNGdJqqlAHrd3dgVI4H3fW5JlDsmH6x2wb
 6dZ+sG5YWxuvi6AwzIB65Jek3Tnqz2WSzPx85uTK+sj2VpBsQNc4toNVSPkK23CTBlhC
 yD2r+Jy1/qRKCdr2ZEyL2v4hTqk4QfcMtJ8zCsiJOphbJxOOzh71h39fAhCvMOTAtzvv Qg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tnqh1hbbk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Oct 2023 16:52:53 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39BGqqco005632
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Oct 2023 16:52:52 GMT
Received: from blr-ubuntu-31.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 11 Oct 2023 09:52:48 -0700
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: <peter.maydell@linaro.org>, <alex.bennee@linaro.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <quic_svaddagi@quicinc.com>, <quic_tsoni@quicinc.com>,
 <quic_pheragu@quicinc.com>, <quic_eberman@quicinc.com>,
 <quic_yvasi@quicinc.com>, <quic_cvanscha@quicinc.com>,
 <quic_mnalajal@quicinc.com>
Subject: [RFC/PATCH v0 01/12] hw/arm/virt: Avoid NULL pointer de-reference
Date: Wed, 11 Oct 2023 16:52:23 +0000
Message-ID: <20231011165234.1323725-2-quic_svaddagi@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011165234.1323725-1-quic_svaddagi@quicinc.com>
References: <20231011165234.1323725-1-quic_svaddagi@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: U8w0dNK3NP7TWlZx3ktvX9aTNd9d9kIf
X-Proofpoint-ORIG-GUID: U8w0dNK3NP7TWlZx3ktvX9aTNd9d9kIf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_12,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=692
 mlxscore=0 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310110148
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_svaddagi@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Avoid dereferencing a NULL pointer that its_class_name() could return.

Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
---
 hw/arm/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a13c658bbf..b55d5c7282 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -661,7 +661,7 @@ static void create_its(VirtMachineState *vms)
     const char *itsclass = its_class_name();
     DeviceState *dev;
 
-    if (!strcmp(itsclass, "arm-gicv3-its")) {
+    if (itsclass && !strcmp(itsclass, "arm-gicv3-its")) {
         if (!vms->tcg_its) {
             itsclass = NULL;
         }
-- 
2.25.1


