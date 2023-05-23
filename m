Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D90C970E692
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 22:37:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1YkL-0000PW-6J; Tue, 23 May 2023 16:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qualcomm.com>)
 id 1q1YkJ-0000OQ-GI
 for qemu-devel@nongnu.org; Tue, 23 May 2023 16:36:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qualcomm.com>)
 id 1q1YkD-0005U5-T5
 for qemu-devel@nongnu.org; Tue, 23 May 2023 16:36:39 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34NI19Ww015811
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 20:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=qcppdkim1; bh=QRBcYMzUtluNKOQNK2OZaRcG9C1dDdbE6eLQ+7gTFUQ=;
 b=hRlIgJDHGSPIYKbxiecSfZGTMEejimDn9pPkh0/4E9ZYiL/QOgRnzSLBOLlQNQ21MTo8
 EoUz4uT/4d1MDCJtYW8BuMAQNdx1mVj6XrW8v2juKmHIWkDEgDwjz0In6mq+mR+I98f9
 WsxqZg7aM3q9z9BYl6bdk85jJVc66N/A91Xj5Ups6TY2oNQx9egQQ8BSyp+WbzHmJjln
 0r7jX/ieBF7k4UZ4qmPL07s1fkTwceG8SUcTfFHnSdtpHbC2O4Vuy1cQ/PcOsDRJzP7E
 IkErwwbXlwia5gpCUFxuwYaJD7m1UUTOV3B2CVuYsVJZbsC4kGNgHsocgQeNgk5OVhuQ lA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qr8qrbybq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 20:36:30 +0000
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34NKaTGt003009
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 20:36:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 3qrdtpqdbb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 20:36:29 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34NKaTl8003004
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 20:36:29 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-mathbern-lv.qualcomm.com
 [10.47.235.147])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 34NKaS0t003003
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 May 2023 20:36:29 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 4229910)
 id A345C741F; Tue, 23 May 2023 17:36:28 -0300 (-03)
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, bcain@quicinc.com, quic_mliebel@quicinc.com
Subject: [PATCH 0/2] Hexagon: two minor cleanups to comments and python scripts
Date: Tue, 23 May 2023 17:36:25 -0300
Message-Id: <cover.1684873957.git.quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: mjiGXzcAjhBGI1sKKkEL5PpAD-FtXtB5
X-Proofpoint-ORIG-GUID: mjiGXzcAjhBGI1sKKkEL5PpAD-FtXtB5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_13,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=742 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230164
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mathbern@qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
stale code comments and removing undefined variables from error messages
at python scripts.

Matheus Tavares Bernardino (2):
  target/hexagon/*.py: remove undef vars from bad_register()
  Hexagon: fix outdated `hex_new_*` references in comments

 target/hexagon/genptr.c            | 10 +++++-----
 target/hexagon/translate.c         |  2 +-
 target/hexagon/gen_helper_funcs.py |  8 ++++----
 target/hexagon/gen_tcg_funcs.py    |  6 +++---
 4 files changed, 13 insertions(+), 13 deletions(-)

-- 
2.37.2


