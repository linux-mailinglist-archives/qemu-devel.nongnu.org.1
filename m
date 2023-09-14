Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7AB7A034B
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 14:04:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgl2x-0008PE-2v; Thu, 14 Sep 2023 08:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1qgl2h-0008Hx-Qc; Thu, 14 Sep 2023 08:01:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1qgl2f-0007GA-54; Thu, 14 Sep 2023 08:01:54 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38EAmUKE018509; Thu, 14 Sep 2023 12:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=RnLsc1KZ4ViLV/rgxW2Hk6Lh65nfDEYyUkf5ay/+arw=;
 b=JpVUb10XdCkOjgItxxzDR/yUCw/dz3vQkVZYIRy/4Det207LA1sijdNEKDS4hvpH4w5F
 3AzhJlj023S6iZW7kOxHBJtyR5QSNodPrcV80SzwS08hepUau77cz20VagO0429Soil/
 1AQbdl0ZseVmFrZYSTRHWKHqJQY2PksqRtsqhbOI9cmcNDGRfYsSpNjY5TM9mFmadVbF
 +gi10qiFbncdOBIsMC3CAFnEWhPcmMKcX1LwJd1oHXAb60VhfIdMmE5U1w4eb2BpSJpS
 TupfFBG7AjY7Z++ZYnXgqma/5HdHineUOn71LSc1ZY1uG+qfiXbarUUH3bnEWbXxE5DB WA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3waxgs37-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Sep 2023 12:01:49 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com
 [10.45.79.139])
 by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38EC1c3U007915
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Sep 2023 12:01:39 GMT
Received: from qc-i7.qualcomm.com (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 14 Sep
 2023 05:01:37 -0700
From: Leif Lindholm <quic_llindhol@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, Radoslaw Biernacki <rad@semihalf.com>, Peter
 Maydell <peter.maydell@linaro.org>, Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>
Subject: [RFC PATCH 0/3] Refactor PPI logic/definitions for virt/sbsa-ref
Date: Thu, 14 Sep 2023 13:01:21 +0100
Message-ID: <20230914120124.55410-1-quic_llindhol@quicinc.com>
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
X-Proofpoint-ORIG-GUID: yd4mBju7MAgYVyvvwnw1v6_j2spMDzoB
X-Proofpoint-GUID: yd4mBju7MAgYVyvvwnw1v6_j2spMDzoB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 mlxlogscore=633 suspectscore=0 mlxscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140103
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

While reviewing Marcin's patch this morning, cross referencing different
specifications and looking at various places around the source code in
order to convinced myself he really hadn't missed something out (the
existing plumbing made it *so* clean to add), my brain broke slightly
at keeping track of PPIs/INTIDs between the various sources.

Moreover, I found the PPI() macro in virt.h to be doing the exact
opposite of what I would have expected it to (it converts a PPI to an
INTID rather than the other way around).

So I refactored stuff so that:
- PPIs defined by BSA are moved to a (new) common header.
- The _IRQ definitions for those PPIs refer to the INTIDs.
- sbsa-ref and virt both use these definitions.

This change does objectively add a bit more noise to the code, since it
means more locations need to use the PPI macro than before, but it felt
like a readability improvement to me.

Not even compilation tested, just the least confusing way of asking
whether the change could be accepted at all.

Leif Lindholm (3):
  include/hw/arm: move BSA definitions to bsa.h
  {include/}hw/arm: refactor BSA/virt PPI logic
  hw/arm/sbsa-ref: use bsa.h for PPI definitions

 hw/arm/sbsa-ref.c        | 24 +++++++++++-------------
 hw/arm/virt-acpi-build.c |  4 ++--
 hw/arm/virt.c            |  9 +++++----
 include/hw/arm/bsa.h     | 35 +++++++++++++++++++++++++++++++++++
 include/hw/arm/virt.h    | 12 +-----------
 5 files changed, 54 insertions(+), 30 deletions(-)
 create mode 100644 include/hw/arm/bsa.h

-- 
2.30.2

