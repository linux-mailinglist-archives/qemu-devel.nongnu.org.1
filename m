Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3093F708934
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 22:12:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzjrx-0000ed-3I; Thu, 18 May 2023 16:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjrZ-00008q-3K
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjrQ-00056i-OK
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:34 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34IJpZJV010468; Thu, 18 May 2023 20:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dvpLHlTbyxvms4Vv5aompRO/RFTctvhwKSAD9MAsE/Y=;
 b=QRnyM+xD6OhwFJtxg+W4r088IHoO8dIaTSKuND8UZBmh2ZTFB6vHWc7f++HPNZBoKjql
 8vKkxse/V7KgFiJ2l0145cddk9UhH4cZs+oV+sOPIYTIaMJc1gLOMaEuOwJV4MWE2+50
 w3MrWDCgN9NanKm8N2Xdee1Os+dCiGfYCUQ+dEVl+29qbzd+gEZaKUUeCQbnnGRaQnC7
 NfzTJt9MXtjxa9wzqBeoqOeC42vfKjJ32oz6YQZbIM8MxRxjIEh0Ag1nbWJAIrjavjNk
 7eoHk0EV0f63bH80oTWWdqGGLjfGZB284NXr7tF+h7UDL9S9aBzc3PPFsTLLnKG+2osP Aw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qn73utj1w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:17 +0000
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
 by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34IK4Fll028732; 
 Thu, 18 May 2023 20:04:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 3qmryp305t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:15 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34IK4FfW028642;
 Thu, 18 May 2023 20:04:15 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-tsimpson-lv.qualcomm.com
 [10.47.204.221])
 by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 34IK4EKj028343
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:15 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 47164)
 id 662316CB; Thu, 18 May 2023 13:04:13 -0700 (PDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, bcain@quicinc.com, quic_mathbern@quicinc.com,
 stefanha@redhat.com, ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com
Subject: [PULL v2 10/44] meson.build Add CONFIG_HEXAGON_IDEF_PARSER
Date: Thu, 18 May 2023 13:03:37 -0700
Message-Id: <20230518200411.271148-11-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518200411.271148-1-tsimpson@quicinc.com>
References: <20230518200411.271148-1-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: NhsR9JzSecluYfekJWmd2nmgQWZEBQYK
X-Proofpoint-GUID: NhsR9JzSecluYfekJWmd2nmgQWZEBQYK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_15,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=634 malwarescore=0
 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1015 adultscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180165
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=tsimpson@qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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

RW5hYmxlIGNvbmRpdGlvbmFsIGNvbXBpbGF0aW9uIGRlcGVuZGluZyBvbiB3aGV0aGVyIGlkZWYt
cGFyc2VyCmlzIGNvbmZpZ3VyZWQKClNpZ25lZC1vZmYtYnk6IFRheWxvciBTaW1wc29uIDx0c2lt
cHNvbkBxdWljaW5jLmNvbT4KUmV2aWV3ZWQtYnk6IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJk
LmhlbmRlcnNvbkBsaW5hcm8ub3JnPgpNZXNzYWdlLUlkOiA8MjAyMzA0MjcyMzAwMTIuMzgwMDMy
Ny0yLXRzaW1wc29uQHF1aWNpbmMuY29tPgotLS0KIG1lc29uLmJ1aWxkIHwgMSArCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9tZXNvbi5idWlsZCBiL21lc29u
LmJ1aWxkCmluZGV4IGQzY2Y0ODk2MGIuLmIzNjEyNGZkYzQgMTAwNjQ0Ci0tLSBhL21lc29uLmJ1
aWxkCisrKyBiL21lc29uLmJ1aWxkCkBAIC0xODY2LDYgKzE4NjYsNyBAQCBlbmRpZgogY29uZmln
X2hvc3RfZGF0YS5zZXQoJ0NPTkZJR19HVEsnLCBndGsuZm91bmQoKSkKIGNvbmZpZ19ob3N0X2Rh
dGEuc2V0KCdDT05GSUdfVlRFJywgdnRlLmZvdW5kKCkpCiBjb25maWdfaG9zdF9kYXRhLnNldCgn
Q09ORklHX0dUS19DTElQQk9BUkQnLCBoYXZlX2d0a19jbGlwYm9hcmQpCitjb25maWdfaG9zdF9k
YXRhLnNldCgnQ09ORklHX0hFWEFHT05fSURFRl9QQVJTRVInLCBnZXRfb3B0aW9uKCdoZXhhZ29u
X2lkZWZfcGFyc2VyJykpCiBjb25maWdfaG9zdF9kYXRhLnNldCgnQ09ORklHX0xJQkFUVFInLCBo
YXZlX29sZF9saWJhdHRyKQogY29uZmlnX2hvc3RfZGF0YS5zZXQoJ0NPTkZJR19MSUJDQVBfTkcn
LCBsaWJjYXBfbmcuZm91bmQoKSkKIGNvbmZpZ19ob3N0X2RhdGEuc2V0KCdDT05GSUdfRUJQRics
IGxpYmJwZi5mb3VuZCgpKQotLSAKMi4yNS4xCgo=

