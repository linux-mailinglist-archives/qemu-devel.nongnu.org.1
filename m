Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C08D82D29A
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 00:26:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rP9qE-0000ou-9S; Sun, 14 Jan 2024 18:24:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rP9qB-0000oW-Es
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 18:24:31 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rP9q9-0003rX-L2
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 18:24:31 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40EN0CTZ029785; Sun, 14 Jan 2024 23:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:mime-version:content-type
 :content-transfer-encoding; s=qcppdkim1; bh=1G+tPq1KwwaDdNltkMQf
 aAOycmmpep9+DKgLG8ssh9Q=; b=DgAeuLKZiLcXO0yVxp/u2GTXkwgEixxK88w4
 t2iGkI+FVXkVcXUhY9UnMqm81ff5fiH+T7+AXAM3XWnGlS1be2Yg0kmfnq5kQeNK
 LiJFqdoLnH+gdYBPIVIyk4qqscXKCQ50i7R3oGR+J9/D3CS1MQeXY25bwEixHGhE
 fuhInUAZgFkZmpBVu9COHxXulwDpfgBnXdKteMlgW3OCLUJdViVCm/dMX07xDkAn
 mxnTK9A4kinWuzrf3gBl8OWmxJlIB2fLn0Etv1NM2oU9Nea8K960fEE1nobSD7yh
 +kDzvjmxDwYKeanh/2XaiNkLZIzmqdLCAxbQc9QRPkxp0zbXUA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vkmjma8f9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 14 Jan 2024 23:24:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ENONTk000322
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 14 Jan 2024 23:24:23 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 14 Jan 2024 15:24:22 -0800
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <quic_mathbern@quicinc.com>, <ale@rev.ng>,
 <anjo@rev.ng>, <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Thomas Huth
 <thuth@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH] tests/docker: Hexagon toolchain update
Date: Sun, 14 Jan 2024 15:23:54 -0800
Message-ID: <20240114232354.4109231-1-bcain@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: qwIZtCrFi9j7Q5rkdJ8COaDmq8SDAPJQ
X-Proofpoint-ORIG-GUID: qwIZtCrFi9j7Q5rkdJ8COaDmq8SDAPJQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011
 suspectscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 priorityscore=1501 mlxlogscore=577
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401140183
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
CgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4KLS0tCiB0ZXN0
cy9kb2NrZXIvZG9ja2VyZmlsZXMvZGViaWFuLWhleGFnb24tY3Jvc3MuZG9ja2VyIHwgNCArKy0t
CiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL3Rlc3RzL2RvY2tlci9kb2NrZXJmaWxlcy9kZWJpYW4taGV4YWdvbi1jcm9zcy5kb2Nr
ZXIgYi90ZXN0cy9kb2NrZXIvZG9ja2VyZmlsZXMvZGViaWFuLWhleGFnb24tY3Jvc3MuZG9ja2Vy
CmluZGV4IDdjMzhkN2M5ZTQuLjYwYmQ4ZmFhMjAgMTAwNjQ0Ci0tLSBhL3Rlc3RzL2RvY2tlci9k
b2NrZXJmaWxlcy9kZWJpYW4taGV4YWdvbi1jcm9zcy5kb2NrZXIKKysrIGIvdGVzdHMvZG9ja2Vy
L2RvY2tlcmZpbGVzL2RlYmlhbi1oZXhhZ29uLWNyb3NzLmRvY2tlcgpAQCAtMzgsOSArMzgsOSBA
QCBSVU4gYXB0LWdldCB1cGRhdGUgJiYgXAogUlVOIC91c3IvYmluL3BpcDMgaW5zdGFsbCB0b21s
aQogCiBFTlYgVE9PTENIQUlOX0lOU1RBTEwgL29wdAotRU5WIFRPT0xDSEFJTl9SRUxFQVNFIDE2
LjAuMAorRU5WIFRPT0xDSEFJTl9SRUxFQVNFIDEyLkRlYy4yMDIzCiBFTlYgVE9PTENIQUlOX0JB
U0VOQU1FICJjbGFuZytsbHZtLSR7VE9PTENIQUlOX1JFTEVBU0V9LWNyb3NzLWhleGFnb24tdW5r
bm93bi1saW51eC1tdXNsIgotRU5WIFRPT0xDSEFJTl9VUkwgaHR0cHM6Ly9jb2RlbGluYXJvLmpm
cm9nLmlvL2FydGlmYWN0b3J5L2NvZGVsaW5hcm8tdG9vbGNoYWluLWZvci1oZXhhZ29uL3Yke1RP
T0xDSEFJTl9SRUxFQVNFfS8ke1RPT0xDSEFJTl9CQVNFTkFNRX0udGFyLnh6CitFTlYgVE9PTENI
QUlOX1VSTCBodHRwczovL2NvZGVsaW5hcm8uamZyb2cuaW8vYXJ0aWZhY3RvcnkvY29kZWxpbmFy
by10b29sY2hhaW4tZm9yLWhleGFnb24vJHtUT09MQ0hBSU5fUkVMRUFTRX0vJHtUT09MQ0hBSU5f
QkFTRU5BTUV9LnRhci54egogRU5WIENDQUNIRV9XUkFQUEVSU0RJUiAiL3Vzci9saWJleGVjL2Nj
YWNoZS13cmFwcGVycyIKIAogUlVOIGN1cmwgLSNTTCAiJFRPT0xDSEFJTl9VUkwiIHwgdGFyIC14
SkMgIiRUT09MQ0hBSU5fSU5TVEFMTCIKLS0gCjIuMjUuMQoK

