Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9898B7D4CD0
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 11:46:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvDy1-00029p-E2; Tue, 24 Oct 2023 05:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1qvDxy-00027p-TP
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 05:44:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1qvDxw-00013D-PW
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 05:44:50 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39O8VlUX015558
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=hkkog/SGuXWdp1E66a4mEr/VUuRJwNBPJryQvNZnOcE=;
 b=hxzhyg14JuDrqixMttTZoMJAqJSfgbuF0c2y3ldH8YSf/J3EmsMNEPjvg5cxE5Suy3UL
 0mtthaqcRHbvIguA7JmNrxWPa6/rv3HIoq0LgzAm8C+UYannd2AzYrAYZy9ivNUMy3h9
 EInSLSWvLQq5ZNAQbFY+lwOTmcetxhohUVi/NyN0+x/lIAwnMribg/sUbWoryc/5g6gQ
 aLC38LrzByOQj8chUMVJxTkcMis9Zj66a2jPGREcT8YokJcHYZ5nKkGqkhWl/pZ8Ye0c
 RyNg1wv1ae6gwgWodwQWrvXNmYsjDkU7Jm7vHw+fefZ63U7zgvKdRBizAkEKyybZSl42 TA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3twxa0hj05-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:44:44 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39O9iir5015653
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:44:44 GMT
Received: from acaggian1-mac.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 24 Oct 2023 02:44:43 -0700
From: Antonio Caggiano <quic_acaggian@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: Antonio Caggiano <quic_acaggian@quicinc.com>
Subject: [RFC] mem: Fix mem region size when is UINT64_MAX
Date: Tue, 24 Oct 2023 11:43:51 +0200
Message-ID: <20231024094351.50464-1-quic_acaggian@quicinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: a_9-inAyl4kOwEtq8oO58pTQt1HV_kg3
X-Proofpoint-ORIG-GUID: a_9-inAyl4kOwEtq8oO58pTQt1HV_kg3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_09,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=672 impostorscore=0 clxscore=1015
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310240082
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_acaggian@quicinc.com; helo=mx0a-0031df01.pphosted.com
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

This looks like a bug. When the size is `UINT64_MAX`, it is reset to
(Int128)`1 << 64` which actually is `UINT64_MAX + 1`.

Then, an assert is triggered when the size is converted back to uin64_t
by using the int128_get64() function, as the new value happens to be
different than the previous one.

Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com>
---
 system/memory.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index a800fbc9e5..d41fc6af88 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1193,9 +1193,6 @@ static void memory_region_do_init(MemoryRegion *mr,
                                   uint64_t size)
 {
     mr->size = int128_make64(size);
-    if (size == UINT64_MAX) {
-        mr->size = int128_2_64();
-    }
     mr->name = g_strdup(name);
     mr->owner = owner;
     mr->dev = (DeviceState *) object_dynamic_cast(mr->owner, TYPE_DEVICE);
-- 
2.42.0


