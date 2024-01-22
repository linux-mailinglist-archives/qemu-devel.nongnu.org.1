Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B60C9835B11
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 07:37:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRnuU-000393-GG; Mon, 22 Jan 2024 01:35:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rRnu9-0002rT-L0
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 01:35:33 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rRnu6-0005ho-8Z
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 01:35:33 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40M5rgL8015863; Mon, 22 Jan 2024 06:35:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=
 qcppdkim1; bh=b1qvPqrfBiS8UxnyADfim+yy6lcUnuGWCz0MbBC8NI4=; b=aC
 gdy9xH2CF0QUFxPSs6Z1Ht2sXkbEoLHPaicWJAUmcWcpZFFLC5W1Pz/ygnFnZrZi
 gmCIZOhopAsbn0FPVvnFnnfI0nSk5xmibhcNgyjlRtugNPTIs1sw22xjNo0j1NrS
 WJ1UTRsDq1Y3GZdiQS3pZHHXZqOvLMuYGm1oYEWoZf8wTBZgxipIT/ZLSQKJY3Fi
 zfi6JWKXfZSu5qjCxFAb2PRm/RJuNvMFsj86ONjRPYaRn2TTKGdf6WXDuVz2jVpY
 3hv9oeLVxMYd4oKGcHkGUCeGrQeAFDkqoi4STsDHELdM/oHUCF+0zNIrzbagaS4z
 Ofka/tQ5h89yJt7aEN8g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vsjktg2u6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 06:35:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40M6ZP4o012312
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 06:35:25 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 21 Jan 2024 22:35:24 -0800
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <armbru@redhat.com>, <richard.henderson@linaro.org>, 
 <philmd@linaro.org>, <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>, <stefanha@redhat.com>, <ale@rev.ng>,
 <anjo@rev.ng>, <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Thomas Huth
 <thuth@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 01/15] tests/docker: Hexagon toolchain update
Date: Sun, 21 Jan 2024 22:34:47 -0800
Message-ID: <20240122063501.782041-2-bcain@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240122063501.782041-1-bcain@quicinc.com>
References: <20240122063501.782041-1-bcain@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: Ti65DkomvTGNUPU1VU_hV8gWCy8uzrH_
X-Proofpoint-ORIG-GUID: Ti65DkomvTGNUPU1VU_hV8gWCy8uzrH_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-21_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0
 suspectscore=0 clxscore=1011 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 mlxlogscore=727 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220046
Received-SPF: pass client-ip=205.220.180.131; envelope-from=bcain@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

VGhpcyB1cGRhdGUgaW5jbHVkZXMgc3VwcG9ydCBmb3IgcHJpdmlsZWdlZCBpbnN0cnVjdGlvbnMu
CgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4KUmV2aWV3ZWQt
Ynk6IE1hdGhldXMgVGF2YXJlcyBCZXJuYXJkaW5vIDxxdWljX21hdGhiZXJuQHF1aWNpbmMuY29t
PgpUZXN0ZWQtYnk6IE1hdGhldXMgVGF2YXJlcyBCZXJuYXJkaW5vIDxxdWljX21hdGhiZXJuQHF1
aWNpbmMuY29tPgpNZXNzYWdlLUlkOiA8MjAyNDAxMTQyMzIzNTQuNDEwOTIzMS0xLWJjYWluQHF1
aWNpbmMuY29tPgotLS0KIHRlc3RzL2RvY2tlci9kb2NrZXJmaWxlcy9kZWJpYW4taGV4YWdvbi1j
cm9zcy5kb2NrZXIgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdHMvZG9ja2VyL2RvY2tlcmZpbGVzL2RlYmlh
bi1oZXhhZ29uLWNyb3NzLmRvY2tlciBiL3Rlc3RzL2RvY2tlci9kb2NrZXJmaWxlcy9kZWJpYW4t
aGV4YWdvbi1jcm9zcy5kb2NrZXIKaW5kZXggN2MzOGQ3YzllNC4uNjBiZDhmYWEyMCAxMDA2NDQK
LS0tIGEvdGVzdHMvZG9ja2VyL2RvY2tlcmZpbGVzL2RlYmlhbi1oZXhhZ29uLWNyb3NzLmRvY2tl
cgorKysgYi90ZXN0cy9kb2NrZXIvZG9ja2VyZmlsZXMvZGViaWFuLWhleGFnb24tY3Jvc3MuZG9j
a2VyCkBAIC0zOCw5ICszOCw5IEBAIFJVTiBhcHQtZ2V0IHVwZGF0ZSAmJiBcCiBSVU4gL3Vzci9i
aW4vcGlwMyBpbnN0YWxsIHRvbWxpCiAKIEVOViBUT09MQ0hBSU5fSU5TVEFMTCAvb3B0Ci1FTlYg
VE9PTENIQUlOX1JFTEVBU0UgMTYuMC4wCitFTlYgVE9PTENIQUlOX1JFTEVBU0UgMTIuRGVjLjIw
MjMKIEVOViBUT09MQ0hBSU5fQkFTRU5BTUUgImNsYW5nK2xsdm0tJHtUT09MQ0hBSU5fUkVMRUFT
RX0tY3Jvc3MtaGV4YWdvbi11bmtub3duLWxpbnV4LW11c2wiCi1FTlYgVE9PTENIQUlOX1VSTCBo
dHRwczovL2NvZGVsaW5hcm8uamZyb2cuaW8vYXJ0aWZhY3RvcnkvY29kZWxpbmFyby10b29sY2hh
aW4tZm9yLWhleGFnb24vdiR7VE9PTENIQUlOX1JFTEVBU0V9LyR7VE9PTENIQUlOX0JBU0VOQU1F
fS50YXIueHoKK0VOViBUT09MQ0hBSU5fVVJMIGh0dHBzOi8vY29kZWxpbmFyby5qZnJvZy5pby9h
cnRpZmFjdG9yeS9jb2RlbGluYXJvLXRvb2xjaGFpbi1mb3ItaGV4YWdvbi8ke1RPT0xDSEFJTl9S
RUxFQVNFfS8ke1RPT0xDSEFJTl9CQVNFTkFNRX0udGFyLnh6CiBFTlYgQ0NBQ0hFX1dSQVBQRVJT
RElSICIvdXNyL2xpYmV4ZWMvY2NhY2hlLXdyYXBwZXJzIgogCiBSVU4gY3VybCAtI1NMICIkVE9P
TENIQUlOX1VSTCIgfCB0YXIgLXhKQyAiJFRPT0xDSEFJTl9JTlNUQUxMIgotLSAKMi4yNS4xCgo=

