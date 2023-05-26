Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D03712827
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 16:22:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2YJ6-0005pe-C3; Fri, 26 May 2023 10:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1q2YJ4-0005os-4s
 for qemu-devel@nongnu.org; Fri, 26 May 2023 10:20:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1q2YJ2-0007CR-D0
 for qemu-devel@nongnu.org; Fri, 26 May 2023 10:20:37 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34QCOcDu002619; Fri, 26 May 2023 14:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=CCAlc/833749PzadyMEYG9yQtuYLfxMbW8OZYLZ4kcE=;
 b=FXggFaH8jOlmNMoKldJkgewoifQM8/zjlBNbeH6hu51MaGIn1dL4lhvRuo+zH4f2v9PO
 16LOn+L9t/knyzkjQTfoUVw58SpyfDN+v+s7W8luNPMCtDRauyaZMOoii00aIif8Yq3J
 Hnyw0SzZlUJ2wfyZLXtNmu8uMrdfvNcltZS6EaJ4/SDhxGIPf/f9VepjX8Q0ptxRNPdl
 7oLtSRLzaqnBa0XhvfwcQHaNNlPJacKVifg2Ypgo8RzIvmLRhctwS48FPQKr6aJ39vM5
 YE3mvXIaFqJZ2yqk5KTeRchYThypbJnCvMs72Bt+9elGY9XaK1W2fBG4m7X+f9crxSEL 8Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qtu0u0emh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 14:20:31 +0000
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34QEKUll032685; 
 Fri, 26 May 2023 14:20:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 3qt382gsk2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 14:20:30 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34QEKUmd032674;
 Fri, 26 May 2023 14:20:30 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-tsimpson-lv.qualcomm.com
 [10.47.204.221])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 34QEKT0P032670
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 14:20:30 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 47164)
 id A177066A; Fri, 26 May 2023 07:20:29 -0700 (PDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, bcain@quicinc.com, quic_mathbern@quicinc.com,
 stefanha@redhat.com, ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 ltaylorsimpson@gmail.com
Subject: [PULL 0/5] Hexagon update
Date: Fri, 26 May 2023 07:20:23 -0700
Message-Id: <20230526142028.1277954-1-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: 781C5xZmoDargQvbUL0HDK8da7QS2txg
X-Proofpoint-GUID: 781C5xZmoDargQvbUL0HDK8da7QS2txg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_04,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxlogscore=402
 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305260120
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=tsimpson@qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBhM2NiNmQ1MDA0ZmY2MzhhZWZlNjg2
ZWNkNTQwNzE4YTc5M2JkMWIxOgoKICBNZXJnZSB0YWcgJ3B1bGwtdGNnLTIwMjMwNTI1JyBvZiBo
dHRwczovL2dpdGxhYi5jb20vcnRoNzY4MC9xZW11IGludG8gc3RhZ2luZyAoMjAyMy0wNS0yNSAx
MToxMTo1MiAtMDcwMCkKCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0OgoK
ICBodHRwczovL2dpdGh1Yi5jb20vcXVpYy9xZW11IHRhZ3MvcHVsbC1oZXgtMjAyMzA1MjYKCmZv
ciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byA3ZDE5NmUyMTk2ZDUwZTBkZGEwZjg3ZjM5NmQ0
ZjRhN2FkOWFhZmJlOgoKICBIZXhhZ29uICh0YXJnZXQvaGV4YWdvbikgQ2hhbmdlIEhleGFnb24g
bWFpbnRhaW5lciAoMjAyMy0wNS0yNiAwNzowMzo0MSAtMDcwMCkKCi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KSGV4YWdvbiB1
cGRhdGUKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0KTWFyY28gTGllYmVsICgxKToKICAgICAgSGV4YWdvbiAodGFyZ2V0L2hl
eGFnb24pIEZpeCBhc3NpZ25tZW50IHRvIHRtcCByZWdpc3RlcnMKCk1hdGhldXMgVGF2YXJlcyBC
ZXJuYXJkaW5vICgyKToKICAgICAgdGFyZ2V0L2hleGFnb24vKi5weTogY2xlYW4gdXAgdXNlZCAn
dG9zcycgYW5kICdudW1yZWdzJyB2YXJzCiAgICAgIEhleGFnb246IGZpeCBvdXRkYXRlZCBgaGV4
X25ld18qYCBjb21tZW50cwoKVGF5bG9yIFNpbXBzb24gKDIpOgogICAgICBIZXhhZ29uICh0ZXN0
cy90Y2cvaGV4YWdvbikgQ2xlYW4gdXAgSGV4YWdvbiBjaGVjay10Y2cgdGVzdHMKICAgICAgSGV4
YWdvbiAodGFyZ2V0L2hleGFnb24pIENoYW5nZSBIZXhhZ29uIG1haW50YWluZXIKCiBNQUlOVEFJ
TkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyICstCiB0ZXN0cy90Y2cvaGV4
YWdvbi9oZXhfdGVzdC5oICAgICAgICAgICAgIHwgMTQ1ICsrKysrKysrKysrKysKIHRhcmdldC9o
ZXhhZ29uL2dlbnB0ci5jICAgICAgICAgICAgICAgICAgfCAgMjYgKystCiB0YXJnZXQvaGV4YWdv
bi9tbXZlYy9kZWNvZGVfZXh0X21tdmVjLmMgIHwgICA4ICstCiB0YXJnZXQvaGV4YWdvbi90cmFu
c2xhdGUuYyAgICAgICAgICAgICAgIHwgICAyICstCiB0ZXN0cy90Y2cvaGV4YWdvbi9hdG9taWNz
LmMgICAgICAgICAgICAgIHwgIDUxICsrLS0tCiB0ZXN0cy90Y2cvaGV4YWdvbi9icmV2LmMgICAg
ICAgICAgICAgICAgIHwgIDczICsrKy0tLS0KIHRlc3RzL3RjZy9oZXhhZ29uL2NpcmMuYyAgICAg
ICAgICAgICAgICAgfCAxNTIgKysrKysrKy0tLS0tLS0KIHRlc3RzL3RjZy9oZXhhZ29uL2R1YWxf
c3RvcmVzLmMgICAgICAgICAgfCAgMjUgKy0tCiB0ZXN0cy90Y2cvaGV4YWdvbi9mcHN0dWZmLmMg
ICAgICAgICAgICAgIHwgMzQxICsrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0KIHRlc3Rz
L3RjZy9oZXhhZ29uL2hleF9zaWdzZWd2LmMgICAgICAgICAgfCAgNDYgKystLS0KIHRlc3RzL3Rj
Zy9oZXhhZ29uL2h2eF9taXNjLmMgICAgICAgICAgICAgfCAgMzEgKysrCiB0ZXN0cy90Y2cvaGV4
YWdvbi9sb2FkX2FsaWduLmMgICAgICAgICAgIHwgMTExICsrKysrLS0tLS0KIHRlc3RzL3RjZy9o
ZXhhZ29uL2xvYWRfdW5wYWNrLmMgICAgICAgICAgfCAxNTkgKysrKysrKy0tLS0tLS0KIHRlc3Rz
L3RjZy9oZXhhZ29uL21lbV9ub3NodWYuYyAgICAgICAgICAgfCAxNjMgKysrKysrKy0tLS0tLS0t
CiB0ZXN0cy90Y2cvaGV4YWdvbi9tZW1fbm9zaHVmX2V4Y2VwdGlvbi5jIHwgIDUyICsrLS0tCiB0
ZXN0cy90Y2cvaGV4YWdvbi9taXNjLmMgICAgICAgICAgICAgICAgIHwgMzM4ICsrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tLQogdGVzdHMvdGNnL2hleGFnb24vbXVsdGlfcmVzdWx0LmMgICAg
ICAgICB8IDE3MSArKysrKysrLS0tLS0tLS0tCiB0ZXN0cy90Y2cvaGV4YWdvbi9vdmVyZmxvdy5j
ICAgICAgICAgICAgIHwgIDYxICsrKy0tLQogdGVzdHMvdGNnL2hleGFnb24vcHJlZ19hbGlhcy5j
ICAgICAgICAgICB8IDExMSArKysrKy0tLS0tCiB0ZXN0cy90Y2cvaGV4YWdvbi9yZWFkX3dyaXRl
X292ZXJsYXAuYyAgIHwgIDU1ICsrKy0tCiB0ZXN0cy90Y2cvaGV4YWdvbi9yZWdfbXV0LmMgICAg
ICAgICAgICAgIHwgIDU0ICsrLS0tCiB0ZXN0cy90Y2cvaGV4YWdvbi91c3IuYyAgICAgICAgICAg
ICAgICAgIHwgMTA5ICsrLS0tLS0tLS0KIC5tYWlsbWFwICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgIDEgKwogdGFyZ2V0L2hleGFnb24vZ2VuX2FuYWx5emVfZnVuY3MucHkgICAg
ICB8ICAxMCArLQogdGFyZ2V0L2hleGFnb24vZ2VuX2hlbHBlcl9mdW5jcy5weSAgICAgICB8ICAz
MCArLS0KIHRhcmdldC9oZXhhZ29uL2dlbl9oZWxwZXJfcHJvdG9zLnB5ICAgICAgfCAgMjIgKy0K
IHRhcmdldC9oZXhhZ29uL2dlbl9pZGVmX3BhcnNlcl9mdW5jcy5weSAgfCAgIDQgKy0KIHRhcmdl
dC9oZXhhZ29uL2dlbl9vcF9yZWdzLnB5ICAgICAgICAgICAgfCAgIDQgKy0KIHRhcmdldC9oZXhh
Z29uL2dlbl90Y2dfZnVuY3MucHkgICAgICAgICAgfCAgNDYgKystLS0KIHRhcmdldC9oZXhhZ29u
L2hleF9jb21tb24ucHkgICAgICAgICAgICAgfCAgMjQgKy0tCiB0ZXN0cy90Y2cvaGV4YWdvbi9N
YWtlZmlsZS50YXJnZXQgICAgICAgIHwgIDE5ICstCiAzMiBmaWxlcyBjaGFuZ2VkLCAxMTUwIGlu
c2VydGlvbnMoKyksIDEyOTYgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMv
dGNnL2hleGFnb24vaGV4X3Rlc3QuaAo=

