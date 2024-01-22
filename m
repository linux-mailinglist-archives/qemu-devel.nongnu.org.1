Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DD7835B0D
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 07:37:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRnuA-0002s1-Mu; Mon, 22 Jan 2024 01:35:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rRnu8-0002pu-Du
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 01:35:32 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rRnu5-0005hg-J8
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 01:35:31 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40M4qn48020229; Mon, 22 Jan 2024 06:35:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:mime-version:content-type
 :content-transfer-encoding; s=qcppdkim1; bh=PvaREmC9Jm4QYMTlrWXa
 9ewsonsVFBFzTB4P5RO4ysM=; b=pQ4cOEUex+DmnKYR6Gu/pXJh1611X29CnGP3
 kgum1IU8qRmP3pBnCIWx/+zZx8KoLZDocLSgWNvUmAzAoRLnHm/Bc1WYWXQFt+LE
 hinIOX6MxgqBGEp9qnNsfP4K/g7PKNFVbIYNWewT7dxKUriCcoJoN0mC2nN1n+0v
 7nHEGqZJArh1UVvLJlnGwD+iond3bsvAqMDHYUS1jHpVYZoNocUPjCgC2c168Yhc
 858b3ct7/kxxLjA3BkOaja+0gdnwAHDhFjoCpUOBy/cDmMulxzog5qDAzqmlhSDv
 G0cwFBL1yuWZhdVEyt0nd/Z9+5eouRzdON8Jj0oW2yPm0YV7/g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr5s4u45j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 06:35:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40M6ZNIW027280
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 06:35:23 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 21 Jan 2024 22:35:22 -0800
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <armbru@redhat.com>, <richard.henderson@linaro.org>, 
 <philmd@linaro.org>, <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>, <stefanha@redhat.com>, <ale@rev.ng>,
 <anjo@rev.ng>, <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PULL 00/15] target-hexagon queue, hexagon docker
Date: Sun, 21 Jan 2024 22:34:46 -0800
Message-ID: <20240122063501.782041-1-bcain@quicinc.com>
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
X-Proofpoint-ORIG-GUID: NHdpd1G4klx69dq8V-V8WeJQ7lNR2KOT
X-Proofpoint-GUID: NHdpd1G4klx69dq8V-V8WeJQ7lNR2KOT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-21_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=433 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCAzZjJhMzU3Yjk1ODQ1ZWEwYmY3NDYz
ZWZmNjY2MWU0M2I5N2QxYWZjOgoKICBNZXJnZSB0YWcgJ2h3LWNwdXMtMjAyNDAxMTknIG9mIGh0
dHBzOi8vZ2l0aHViLmNvbS9waGlsbWQvcWVtdSBpbnRvIHN0YWdpbmcgKDIwMjQtMDEtMTkgMTE6
Mzk6MzggKzAwMDApCgphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoKCiAg
aHR0cHM6Ly9naXRodWIuY29tL3F1aWMvcWVtdSB0YWdzL3B1bGwtaGV4LTIwMjQwMTIxCgpmb3Ig
eW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gYmJlNDIwOWM4YjQzMDBkNzIyZjQ3NzkxZjkxNTFl
MWE2OWNiMDEzNToKCiAgdGFyZ2V0L2hleGFnb246IHJlZHVjZSBzY29wZSBvZiBkZWZfcmVnbnVt
LCByZW1vdmUgZGVhZCBhc3NpZ25tZW50ICgyMDI0LTAxLTIxIDIyOjAyOjQ4IC0wODAwKQoKLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQpDb3Zlcml0eSBmaXgsIGNyb3NzIHRvb2xjaGFpbiB1cGRhdGUsIHN3aXRjaCB0byBkZWNv
ZGV0cmVlCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCkJyaWFuIENhaW4gKDIpOgogICAgICB0ZXN0cy9kb2NrZXI6IEhleGFn
b24gdG9vbGNoYWluIHVwZGF0ZQogICAgICB0YXJnZXQvaGV4YWdvbjogcmVkdWNlIHNjb3BlIG9m
IGRlZl9yZWdudW0sIHJlbW92ZSBkZWFkIGFzc2lnbm1lbnQKClRheWxvciBTaW1wc29uICgxMyk6
CiAgICAgIEhleGFnb24gKHRhcmdldC9oZXhhZ29uKSBGaXggc2hhZG93IHZhcmlhYmxlIHdoZW4g
aWRlZi1wYXJzZXIgaXMgb2ZmCiAgICAgIEhleGFnb24gKHRhcmdldC9oZXhhZ29uKSBDbGVhbiB1
cCBoYW5kbGluZyBvZiBtb2RpZmllciByZWdpc3RlcnMKICAgICAgSGV4YWdvbiAodGFyZ2V0L2hl
eGFnb24pIE1ha2UgZ2VuZXJhdG9ycyBvYmplY3Qgb3JpZW50ZWQgLSBnZW5fdGNnX2Z1bmNzCiAg
ICAgIEhleGFnb24gKHRhcmdldC9oZXhhZ29uKSBNYWtlIGdlbmVyYXRvcnMgb2JqZWN0IG9yaWVu
dGVkIC0gZ2VuX2hlbHBlcl9wcm90b3MKICAgICAgSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIE1h
a2UgZ2VuZXJhdG9ycyBvYmplY3Qgb3JpZW50ZWQgLSBnZW5faGVscGVyX2Z1bmNzCiAgICAgIEhl
eGFnb24gKHRhcmdldC9oZXhhZ29uKSBNYWtlIGdlbmVyYXRvcnMgb2JqZWN0IG9yaWVudGVkIC0g
Z2VuX2lkZWZfcGFyc2VyX2Z1bmNzCiAgICAgIEhleGFnb24gKHRhcmdldC9oZXhhZ29uKSBNYWtl
IGdlbmVyYXRvcnMgb2JqZWN0IG9yaWVudGVkIC0gZ2VuX29wX3JlZ3MKICAgICAgSGV4YWdvbiAo
dGFyZ2V0L2hleGFnb24pIE1ha2UgZ2VuZXJhdG9ycyBvYmplY3Qgb3JpZW50ZWQgLSBnZW5fYW5h
bHl6ZV9mdW5jcwogICAgICBIZXhhZ29uICh0YXJnZXQvaGV4YWdvbikgUmVtb3ZlIHVudXNlZCBX
UklURVNfUFJFRF9SRUcgYXR0cmlidXRlCiAgICAgIEhleGFnb24gKHRhcmdldC9oZXhhZ29uKSBS
ZW1vdmUgZGVhZCBmdW5jdGlvbnMgZnJvbSBoZXhfY29tbW9uLnB5CiAgICAgIEhleGFnb24gKHRh
cmdldC9oZXhhZ29uKSBVc2UgUUVNVSBkZWNvZGV0cmVlICgzMi1iaXQgaW5zdHJ1Y3Rpb25zKQog
ICAgICBIZXhhZ29uICh0YXJnZXQvaGV4YWdvbikgVXNlIFFFTVUgZGVjb2RldHJlZSAoMTYtYml0
IGluc3RydWN0aW9ucykKICAgICAgSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIFJlbW92ZSBvbGQg
ZGVjdHJlZS5weQoKIHRhcmdldC9oZXhhZ29uL1JFQURNRSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDE0ICstCiB0YXJnZXQvaGV4YWdvbi9hdHRyaWJzX2RlZi5oLmluYyAgICAgICAg
ICAgICAgICAgICB8ICAgMSAtCiB0YXJnZXQvaGV4YWdvbi9kZWNvZGUuYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8IDQzOSArKystLS0tLS0tCiB0YXJnZXQvaGV4YWdvbi9kZWNvZGUuaCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNSArLQogdGFyZ2V0L2hleGFnb24vZGVjdHJl
ZS5weSAgICAgICAgICAgICAgICAgICAgICAgICAgfCA0MDMgLS0tLS0tLS0tCiB0YXJnZXQvaGV4
YWdvbi9nZW5fYW5hbHl6ZV9mdW5jcy5weSAgICAgICAgICAgICAgICB8IDE2MyArLS0tCiB0YXJn
ZXQvaGV4YWdvbi9nZW5fZGVjb2RldHJlZS5weSAgICAgICAgICAgICAgICAgICB8IDE5OCArKysr
KwogdGFyZ2V0L2hleGFnb24vZ2VuX2RlY3RyZWVfaW1wb3J0LmMgICAgICAgICAgICAgICAgfCAg
NDkgLS0KIHRhcmdldC9oZXhhZ29uL2dlbl9oZWxwZXJfZnVuY3MucHkgICAgICAgICAgICAgICAg
IHwgMzcwICsrLS0tLS0tLQogdGFyZ2V0L2hleGFnb24vZ2VuX2hlbHBlcl9wcm90b3MucHkgICAg
ICAgICAgICAgICAgfCAxNDkgKy0tLQogdGFyZ2V0L2hleGFnb24vZ2VuX2lkZWZfcGFyc2VyX2Z1
bmNzLnB5ICAgICAgICAgICAgfCAgMjAgKy0KIHRhcmdldC9oZXhhZ29uL2dlbl9vcF9yZWdzLnB5
ICAgICAgICAgICAgICAgICAgICAgIHwgICA2ICstCiB0YXJnZXQvaGV4YWdvbi9nZW5fdGNnLmgg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgOSArLQogdGFyZ2V0L2hleGFnb24vZ2VuX3Rj
Z19mdW5jcy5weSAgICAgICAgICAgICAgICAgICAgfCA1NjYgKy0tLS0tLS0tLS0tLQogdGFyZ2V0
L2hleGFnb24vZ2VuX3RyYW5zX2Z1bmNzLnB5ICAgICAgICAgICAgICAgICAgfCAxMjQgKysrCiB0
YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5ICAgICAgICAgICAgICAgICAgICAgICB8IDkyMSAr
KysrKysrKysrKysrKysrKysrLS0KIHRhcmdldC9oZXhhZ29uL2lkZWYtcGFyc2VyL3BhcnNlci1o
ZWxwZXJzLmMgICAgICAgIHwgICA4ICstCiB0YXJnZXQvaGV4YWdvbi9tYWNyb3MuaCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgOSArLQogdGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAxNDcgKysrLQogdGFyZ2V0L2hleGFnb24vbW12ZWMv
ZGVjb2RlX2V4dF9tbXZlYy5jICAgICAgICAgICAgfCAgIDQgKy0KIHRhcmdldC9oZXhhZ29uL29w
Y29kZXMuYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDI5IC0KIHRhcmdldC9oZXhhZ29u
L29wY29kZXMuaCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyIC0KIHRhcmdldC9oZXhh
Z29uL3RyYW5zbGF0ZS5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA0ICstCiAuLi4vZG9j
a2VyL2RvY2tlcmZpbGVzL2RlYmlhbi1oZXhhZ29uLWNyb3NzLmRvY2tlciB8ICAgNCArLQogMjQg
ZmlsZXMgY2hhbmdlZCwgMTU1OSBpbnNlcnRpb25zKCspLCAyMDg1IGRlbGV0aW9ucygtKQogZGVs
ZXRlIG1vZGUgMTAwNzU1IHRhcmdldC9oZXhhZ29uL2RlY3RyZWUucHkKIGNyZWF0ZSBtb2RlIDEw
MDc1NSB0YXJnZXQvaGV4YWdvbi9nZW5fZGVjb2RldHJlZS5weQogY3JlYXRlIG1vZGUgMTAwNzU1
IHRhcmdldC9oZXhhZ29uL2dlbl90cmFuc19mdW5jcy5weQo=

