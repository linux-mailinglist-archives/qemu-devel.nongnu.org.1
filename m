Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6251716273
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:45:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zf4-0005vE-1g; Tue, 30 May 2023 09:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qualcomm.com>)
 id 1q3zf2-0005tG-58
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:45:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qualcomm.com>)
 id 1q3zf0-00083r-E7
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:45:15 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34U9790u023899
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 13:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=qcppdkim1; bh=NcFKQ6YMlSqijdSM2qIn4y9e89uF1b+CK06/AQHeqms=;
 b=VUh//IlYh/KvJ7bp9I2yU7K2atsYqzq9S1HmLKNpVZUD/1HyEj/nJNS1onkttpoIHmFL
 d+fwJsQx01x9a5e+DRnFXU49j+bZXqOlql9cuUiCK2g1KgbrKTiFyODye3l1g1vPTx7x
 reoZaWAQLMxLjvbTxjGm2uwSgfolU0akOoQGXEYWsBJjsE4qY0KrkH4Nea8DwX83biSj
 bk/anwobW1ZmxF76+GU5orCsihXdOl3X1UoJj1VQIJX+/HeD04ivMgSHRgL4BdnT0XRp
 DnFDYQXCl1uW/q9XU1Q+CEap5L7SqYbJdn5I5pBJ1ju5qRUqfJ6bM6pd8LlD3RhErFOk fg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qw7rts8jw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 13:45:11 +0000
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
 by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34UDYVX2012478
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 13:45:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 3quaxm0h3n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 13:45:10 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UDhlK0022026
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 13:45:10 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-mathbern-lv.qualcomm.com
 [10.47.235.147])
 by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 34UDj9oS024487
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 13:45:10 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 4229910)
 id C239A7583; Tue, 30 May 2023 10:45:09 -0300 (-03)
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, bcain@quicinc.com, quic_mliebel@quicinc.com
Subject: [PATCH 0/2] Hexagon tests: fix test_load_tmp2 and non-portable format
Date: Tue, 30 May 2023 10:45:06 -0300
Message-Id: <cover.1685454251.git.quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: BM3i9ZbcS-jwEU2DmctJzxSGidXNILmg
X-Proofpoint-ORIG-GUID: BM3i9ZbcS-jwEU2DmctJzxSGidXNILmg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_10,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=636 bulkscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300111
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mathbern@qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This series includes two fixes on hexagon test files: one for a
non-porable printf specifier, and the other for the use of an
uninitialized register.

Marco Liebel (1):
  Hexagon (hvx_misc test): fix uninitialized regs at test_load_tmp2

Matheus Tavares Bernardino (1):
  Hexagon (tests/.../hex_test.h): use portable printf formats

 tests/tcg/hexagon/hex_test.h | 14 ++++++++++----
 tests/tcg/hexagon/hvx_misc.c |  7 ++++++-
 2 files changed, 16 insertions(+), 5 deletions(-)

-- 
2.37.2


