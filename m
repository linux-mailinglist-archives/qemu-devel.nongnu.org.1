Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 332FA7A5D51
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:04:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiWdI-0002qz-N8; Tue, 19 Sep 2023 05:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1qiWd8-0002q2-D1; Tue, 19 Sep 2023 05:02:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1qiWd5-0003cK-Fx; Tue, 19 Sep 2023 05:02:49 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38J6S5Vf005007; Tue, 19 Sep 2023 09:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=obLK7zjVdxPNE4PruUSFa2db5nLNc6JawmNN+S/Ypr8=;
 b=GtVbvuBya0lNPwS52G593NbrBkd6oM4y3LuQxnYNvhCJ2Jc9Ncpi1905/BD+ngn4d6Ta
 VwerO7hwjo/N3buqEhEaeeY5TcbDEMGgQiC8nLqm14QDy2vJQEvjHudiCH30+IY99AQN
 c/3LbILFiclJqQXzR+bYvaVgmv0eiw6NDr8nF0uCke27+6hpbqWaE9ViwH1lIFyaW904
 lTWl7e79BUdlsGh+RPeaSC7TVYHhJhcp5y+jC9oSZEn+ltaVVH5XjHdJopfSRjLdVsZE
 LxByxYDOw/i4t++evpB5yLFRYZ58PTTMCMaQ6BLAy0uSTaWVwcfrABAjrRXY9EWJejoS LQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t6qf6j3d5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 09:02:39 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com
 [10.45.79.139])
 by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38J92cfk022514
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 09:02:38 GMT
Received: from qc-i7.qualcomm.com (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 19 Sep
 2023 02:02:36 -0700
From: Leif Lindholm <quic_llindhol@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, Radoslaw Biernacki <rad@semihalf.com>, Peter
 Maydell <peter.maydell@linaro.org>, Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: [PATCH v2 0/3] Refactor PPI logic/definitions for virt/sbsa-ref
Date: Tue, 19 Sep 2023 10:02:26 +0100
Message-ID: <20230919090229.188092-1-quic_llindhol@quicinc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: QU0Z8OJ8p0np3vYbelBeC4fe-S97yORh
X-Proofpoint-ORIG-GUID: QU0Z8OJ8p0np3vYbelBeC4fe-S97yORh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_03,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=248 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309190075
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_llindhol@quicinc.com; helo=mx0a-0031df01.pphosted.com
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

This set reworks the handling of private peripheral interrupts in virt
to use INTIDs instead of PPI IDs, to make it easier to cross reference
against Arm's Base System Architecture specification.

It then breaks those definitions out into a separate header and switches
sbsa-ref to use the same header instead of defining its own values
locally.

Changes since v1:
- Replaced PPI macro with PPI_TO_INTID/INTID_TO_PPI macros.
- Fixed a few missing changes to interrupt translation (some reported
  by Peter, some I found when I searched more properly)
- Changed ppibase to intidbase in gic creation instead of doing the
  translation, as suggested by Peter.
- Added explicit comment that listed IDs are INTIDs.

Changes since RFC:
- Compilation tested
- Reordered patches 1-2 as suggested by Philippe.

Leif Lindholm (3):
  {include/}hw/arm: refactor virt PPI logic
  include/hw/arm: move BSA definitions to bsa.h
  hw/arm/sbsa-ref: use bsa.h for PPI definitions

 hw/arm/sbsa-ref.c        | 20 +++++++++-----------
 hw/arm/virt-acpi-build.c | 12 ++++++------
 hw/arm/virt.c            | 24 ++++++++++++++----------
 include/hw/arm/bsa.h     | 37 +++++++++++++++++++++++++++++++++++++
 include/hw/arm/virt.h    | 12 +-----------
 5 files changed, 67 insertions(+), 38 deletions(-)
 create mode 100644 include/hw/arm/bsa.h

-- 
2.30.2


