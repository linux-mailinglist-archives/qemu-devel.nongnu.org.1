Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21467977E6A
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Sep 2024 13:21:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp4LF-0008Sj-3n; Fri, 13 Sep 2024 07:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1sp4L5-0008Ek-HH
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 07:19:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1sp4L0-0001lg-VO
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 07:19:45 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DA9o1R004943;
 Fri, 13 Sep 2024 11:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=eftRzcZF8WQ87jo+CZemZp
 SPso+NPe1DAPR3d/EUTmw=; b=H2mfPhCU1x6h1m0rmYbAMGjMJjRf2DyKiCf2I0
 bUbl6F4vf8FOBEuFov8zeHuVlHGPmDHnz3yW8/UPRIAFtlC7ryRSBF9wN9Rv1Zfg
 s0gXRtRMOaFAcKWFQlXXtML71/OynCu8Etxy/J988ERf1zOkdbgxVlPhsiSuVLSd
 vHvCh5nRhzqghP6v/TXtYCGW2QXZTVh/eQc8srC9Yj81s23rUC5q+xZWGaAIdpfj
 MTLkfFs9sm7ISz1zOTqmrEiLQoAsfmH6O4kZp+PYetvolIa3/IciDOzB9VlQ3HJx
 J7wGFPyrjzHCoz0THZ3WB05NPE5hvMJefZoo5UlodR8lpZIw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy738p0h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 11:19:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48DBJc4n023038
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 11:19:38 GMT
Received: from hu-mathbern-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 13 Sep 2024 04:19:38 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>, <thuth@redhat.com>, <bcain@quicinc.com>
Subject: [PATCH v2] docs/fuzz: fix outdated mention to enable-sanitizers
Date: Fri, 13 Sep 2024 08:19:28 -0300
Message-ID: <0ecf4e1ab26771009d74a2ce61e7c17ddc586ef7.1726226316.git.quic_mathbern@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 3h1rIVjv28e7MppS1wrAmvEmMdcUaF8u
X-Proofpoint-GUID: 3h1rIVjv28e7MppS1wrAmvEmMdcUaF8u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=471 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409130078
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_mathbern@quicinc.com; helo=mx0b-0031df01.pphosted.com
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

This options has been removed at cb771ac1f5 (meson: Split
--enable-sanitizers to --enable-{asan, ubsan}, 2024-08-13), so let's
update its last standing mention in the docs.

Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
---
In v2: fixed grammar typo and s/use-after-frees/uses-after-free/
v1: https://lore.kernel.org/qemu-devel/a788215960b94d863baeffb736f06e3fb94275e7.1726145226.git.quic_mathbern@quicinc.com/

 docs/devel/testing/fuzzing.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/docs/devel/testing/fuzzing.rst b/docs/devel/testing/fuzzing.rst
index dfe1973cf8..c3ac084311 100644
--- a/docs/devel/testing/fuzzing.rst
+++ b/docs/devel/testing/fuzzing.rst
@@ -21,8 +21,9 @@ Building the fuzzers
 
 To build the fuzzers, install a recent version of clang:
 Configure with (substitute the clang binaries with the version you installed).
-Here, enable-sanitizers, is optional but it allows us to reliably detect bugs
-such as out-of-bounds accesses, use-after-frees, double-frees etc.::
+Here, enable-asan and enable-ubsan are optional but they allow us to reliably
+detect bugs such as out-of-bounds accesses, uses-after-free, double-frees
+etc.::
 
     CC=clang-8 CXX=clang++-8 /path/to/configure \
         --enable-fuzzing --enable-asan --enable-ubsan
-- 
2.37.2


