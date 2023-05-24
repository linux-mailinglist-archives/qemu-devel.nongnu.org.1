Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C58B270FC01
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 18:55:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1rko-0007xw-TM; Wed, 24 May 2023 12:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1q1rkm-0007xn-Mi
 for qemu-devel@nongnu.org; Wed, 24 May 2023 12:54:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1q1rkh-0000np-7H
 for qemu-devel@nongnu.org; Wed, 24 May 2023 12:54:20 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34OEoQo8018678; Wed, 24 May 2023 16:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=NrQfMGr/qSJ+cY7bdN9QJtHC9RaG3vXen8P0FvDhvMs=;
 b=OQihkEXPQtiZH4fJ3pEFddE4uVzwcByOir8VGQ2D0gBXfSLo2g7K2WFWVc7wPGMNoYJM
 9Nhz2ZIcsFHGWa75tG628gsO/r2vzIPjHAKez+kd8cNI7WXCIqKjBK/cwGebue96EN3H
 qiwrCrHPEmDmZ0CicgTv86PeQ4dKz/yYXZvYl8IzWodM1EZpTOOK6HPQVYOgXNJEULf3
 x/avXhPkGfLbziY1aBDcdC14UEj8iaUjDx+PqjJKKjJdm/5hj90489+no24Ob6/apSnv
 fjSJzBIwEMje5s+XrOQ0E3ISZSpC10ERLnTPy92r2oFqXBCUDRfYuDzC5KjknLCdHCC6 Rg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qs4dfaaw8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 May 2023 16:54:15 +0000
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34OGs3IL002929; 
 Wed, 24 May 2023 16:54:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 3qrdtpw5j0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 May 2023 16:54:03 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34OGs3In002909;
 Wed, 24 May 2023 16:54:03 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-tsimpson-lv.qualcomm.com
 [10.47.204.221])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 34OGs34c002895
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 May 2023 16:54:03 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 47164)
 id 067AF6C7; Wed, 24 May 2023 09:54:03 -0700 (PDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, bcain@quicinc.com, quic_mathbern@quicinc.com,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com
Subject: [PATCH 0/1] Change Hexagon maintainer
Date: Wed, 24 May 2023 09:53:54 -0700
Message-Id: <20230524165355.3157700-1-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: r3fPjxIKaGGuAzyTBeIpc0GbwOxXjP4I
X-Proofpoint-ORIG-GUID: r3fPjxIKaGGuAzyTBeIpc0GbwOxXjP4I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_11,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1
 mlxscore=1 mlxlogscore=196
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 spamscore=1
 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240139
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=tsimpson@qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

SSB3aWxsIGJlIHJldGlyaW5nIGZyb20gUXVhbGNvbW0gYXQgdGhlIGVuZCBvZiBNYXksIHNvIEkg
YW0gcGxhY2luZwp0aGUgbWFpbnRhaW5lcnNoaXAgaW4gdGhlIHZlcnkgY2FwYWJsZSBoYW5kcyBv
ZiBCcmlhbiBDYWluLgoKVGF5bG9yIFNpbXBzb24gKDEpOgogIEhleGFnb24gKHRhcmdldC9oZXhh
Z29uKSBDaGFuZ2UgSGV4YWdvbiBtYWludGFpbmVyCgogTUFJTlRBSU5FUlMgfCAyICstCiAubWFp
bG1hcCAgICB8IDEgKwogMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkKCi0tIAoyLjI1LjEKCg==

