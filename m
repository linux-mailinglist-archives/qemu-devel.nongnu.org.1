Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EBC70F8EA
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 16:42:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1pgd-0001Rl-3N; Wed, 24 May 2023 10:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qualcomm.com>)
 id 1q1pga-0001Qk-C9
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:41:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qualcomm.com>)
 id 1q1pgX-0000cz-Rx
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:41:56 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34OEWYur013141
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 14:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=qcppdkim1; bh=Bq9hO+Xhfk5Vpp9AIJpWSJHec6gvfHrkAsRN0UBl71Q=;
 b=RZvBaOqqvVqCslUq6VDinORTJMtXwYBrSrMAdB79GAOxy+Dix+NhkvS3cJGivqcfKj75
 G9CBQrx0jXcHEYjotTZMd7cUIuw5sA7KAusofGHlKrAtGlRjhDKf/Gtuut8lv3PvUT7N
 08tu5gPZD9Vk09FJ/NJQ0PtdRgKOw8otau44cIr0kahGilQDHpGpxEwP1O9yunW2mAlt
 B6rIJEVtizHNYIwQywq92i1c9g0Q7FUeoypvtoBVWI36u9osiw18jphz6ZmMpE7uz2DA
 Lcn8Sw3uGR6HNDaDc/kym+OU4PEAH2J/JCRwJ8zFM0XSvbxB9ciZc0WF02dTtKSj5UKZ xw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qsa0v9dg7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 14:41:51 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34OEfoCt026644
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 14:41:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 3qpq9m0pr3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 14:41:50 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34OEfoQr026634
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 14:41:50 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-mathbern-lv.qualcomm.com
 [10.47.235.147])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 34OEfnpK026628
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 May 2023 14:41:50 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 4229910)
 id A15827443; Wed, 24 May 2023 11:41:49 -0300 (-03)
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, bcain@quicinc.com, quic_mliebel@quicinc.com
Subject: [PATCH v2 0/2] Hexagon: minor cleanups to comments and python scripts
Date: Wed, 24 May 2023 11:41:46 -0300
Message-Id: <cover.1684939078.git.quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: HdSYLYzFE5_8FQ8fiJ4QIaAEnMWa-oV1
X-Proofpoint-ORIG-GUID: HdSYLYzFE5_8FQ8fiJ4QIaAEnMWa-oV1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_09,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=791
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240120
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mathbern@qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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

These are two minor follow ups to the last Hexagon pull, updating some
stale code comments and removing undefined variables at python scripts.

Changes in v2:
- Patch 1: adjusted get_regtags() to filter out the unused regs,
           also removing the unused variables at the call sites.
- Patch 2: replaced outdated comments with pseudocode

v1: https://lore.kernel.org/qemu-devel/cover.1684873957.git.quic_mathbern@quicinc.com/

Matheus Tavares Bernardino (2):
  target/hexagon/*.py: clean up used 'toss' and 'numregs' vars
  Hexagon: fix outdated `hex_new_*` comments

 target/hexagon/genptr.c                 | 26 +++++++-------
 target/hexagon/translate.c              |  2 +-
 target/hexagon/gen_analyze_funcs.py     | 10 +++---
 target/hexagon/gen_helper_funcs.py      | 30 ++++++++--------
 target/hexagon/gen_helper_protos.py     | 22 ++++++------
 target/hexagon/gen_idef_parser_funcs.py |  4 +--
 target/hexagon/gen_op_regs.py           |  4 +--
 target/hexagon/gen_tcg_funcs.py         | 46 ++++++++++++-------------
 target/hexagon/hex_common.py            | 24 ++++++-------
 9 files changed, 83 insertions(+), 85 deletions(-)

-- 
2.37.2


