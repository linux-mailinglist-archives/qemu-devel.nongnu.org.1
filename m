Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8C57A1DBB
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 13:57:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh7QP-0002RE-MG; Fri, 15 Sep 2023 07:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1qh7QN-0002PM-NV; Fri, 15 Sep 2023 07:55:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1qh7QL-0005dx-Ta; Fri, 15 Sep 2023 07:55:51 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38FBDMvt018362; Fri, 15 Sep 2023 11:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=iievh1f3DKlbxZRTutfNZyfx7efemnA39SxF91qTdKE=;
 b=Fi7+vW5jbfVKvpy8O9l/wuTKOAsgDPKp2gibYR7qfa+sEg+7YQQbf3Lf+MsqoDaWIVqx
 otnpjfTYiPBex2Ass9uF35dSfMzOP+J7DJlVp+e1vLiQwQcoX0Jvg1Z1Cm6Q2R4e6sPd
 Kdhp19idU+TSCrFANn+9YubehoDdmmf1L6z/neQFvUFgIfGqCvePq1bc7zfZhYhvhcR8
 KK2jUKEWlBNG+GET43I4uFcaBZ4DSIvJDK0exNJD15JILFfaU3gKDVD8773Evmj3SCve
 8FNU5ibPDjkjeCYwm0t/s3rOwVJF5JAC7BMM5eC/ycJvWpOs2C9vRlALwNpcuaQCuRzs +w== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4g3grvp3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Sep 2023 11:55:45 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com
 [10.45.79.139])
 by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38FBti7j006445
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Sep 2023 11:55:44 GMT
Received: from qc-i7.qualcomm.com (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 15 Sep
 2023 04:55:43 -0700
From: Leif Lindholm <quic_llindhol@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, Radoslaw Biernacki <rad@semihalf.com>, Peter
 Maydell <peter.maydell@linaro.org>, Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: [PATCH v1 0/3] Refactor PPI logic/definitions for virt/sbsa-ref
Date: Fri, 15 Sep 2023 12:55:32 +0100
Message-ID: <20230915115535.129834-1-quic_llindhol@quicinc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: X65SXE5GF3maING_z_8OuHOSaAlhPIZs
X-Proofpoint-ORIG-GUID: X65SXE5GF3maING_z_8OuHOSaAlhPIZs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_08,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015
 mlxlogscore=245 phishscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150105
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_llindhol@quicinc.com; helo=mx0b-0031df01.pphosted.com
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

This set reworks the handling of private peripheral interrupts in virt
to use INTIDs instead of PPI IDs, to make it easier to cross reference
against Arm's Base System Architecture specification.

It then breaks those definitions out into a separate header and switches
sbsa-ref to use the same header instead of defining its own values
locally.

Changes since RFC:
- Compilation tested
- Reordered patches 1-2 as suggested by Philippe.

Leif Lindholm (3):
  {include/}hw/arm: refactor virt PPI logic
  include/hw/arm: move BSA definitions to bsa.h
  hw/arm/sbsa-ref: use bsa.h for PPI definitions

 hw/arm/sbsa-ref.c        | 23 +++++++++++------------
 hw/arm/virt-acpi-build.c |  4 ++--
 hw/arm/virt.c            |  9 +++++----
 include/hw/arm/bsa.h     | 35 +++++++++++++++++++++++++++++++++++
 include/hw/arm/virt.h    | 12 +-----------
 5 files changed, 54 insertions(+), 29 deletions(-)
 create mode 100644 include/hw/arm/bsa.h

-- 
2.30.2


