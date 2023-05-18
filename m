Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A115708999
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 22:35:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzkKY-0003mJ-7g; Thu, 18 May 2023 16:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzkKL-0003kZ-Tv
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:34:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzkKI-0004Dj-LM
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:34:21 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34IK0feH006858; Thu, 18 May 2023 20:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-type : content-transfer-encoding; s=qcppdkim1;
 bh=W2kuBjwfN6S7IaDJAHBohIN4KMRVqUj3vum7+GdSMPs=;
 b=Oa8aP1Veg68+uSCiigw+hQEx2qilDbhq8g2IgV8Jyi6ynSpnjuC7nxsT0EzsXQ22s9zo
 RTyeDRnfNN3HCXXtjogTzjfXS0+o9RTbbOxhPI+N09LBqN1DXBt66jvpobXZPFL5iw2d
 TlAe3UhOSGllRFNQv6GqKnFNn9B9/ofMxXu+/0r817nFkjpEngA76vI5LrODGzPLNYZ7
 3OKNfN9GVA7EceiowR+5JBPQxnoGXQWLxEW/jXe7/cdVWttVws/Q81bGB0DaIDEMd3L4
 un8K92pdZ82BN2KHPxS7BwaCYnvmC2KeRmLPLaOAwSnANkr99WdrlpPhJ1Ik9CmZ9RKX +Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qned31w4c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:34:15 +0000
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
 by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34IKYF8h029751; 
 Thu, 18 May 2023 20:34:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 3qmryp340f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:34:15 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34IKYEOK029569;
 Thu, 18 May 2023 20:34:14 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-tsimpson-lv.qualcomm.com
 [10.47.204.221])
 by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 34IKYDB2029478
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:34:14 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 47164)
 id C526868B; Thu, 18 May 2023 13:34:13 -0700 (PDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, bcain@quicinc.com, quic_mathbern@quicinc.com,
 stefanha@redhat.com, ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v2 40/44] gdbstub: add test for untimely stop-reply packets
Date: Thu, 18 May 2023 13:04:07 -0700
Message-Id: <20230518200411.271148-41-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518200411.271148-1-tsimpson@quicinc.com>
References: <20230518200411.271148-1-tsimpson@quicinc.com>
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
X-Proofpoint-ORIG-GUID: LBcmIzL3kAF2jmA60ORxJRK7h1fZMznf
X-Proofpoint-GUID: LBcmIzL3kAF2jmA60ORxJRK7h1fZMznf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_15,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180169
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPHF1aWNfbWF0aGJlcm5AcXVpY2luYy5j
b20+CgpJbiB0aGUgcHJldmlvdXMgY29tbWl0LCB3ZSBtb2RpZmllZCBnZGJzdHViLmMgdG8gb25s
eSBzZW5kIHN0b3AtcmVwbHkKcGFja2V0cyBhcyBhIHJlc3BvbnNlIHRvIEdEQiBjb21tYW5kcyB0
aGF0IGFjY2VwdCBpdC4gTm93LCBsZXQncyBhZGQgYQp0ZXN0IGZvciB0aGlzIGludGVuZGVkIGJl
aGF2aW9yLiBSdW5uaW5nIHRoaXMgdGVzdCBiZWZvcmUgdGhlIGZpeCBmcm9tCnRoZSBwcmV2aW91
cyBjb21taXQgZmFpbHMgYXMgUUVNVSBzZW5kcyBhIHN0b3AtcmVwbHkgcGFja2V0CmFzeW5jaHJv
bm91c2x5LCB3aGVuIEdEQiB3YXMgaW4gZmFjdCB3YWl0aW5nIGFuIEFDSy4KClNpZ25lZC1vZmYt
Ynk6IE1hdGhldXMgVGF2YXJlcyBCZXJuYXJkaW5vIDxxdWljX21hdGhiZXJuQHF1aWNpbmMuY29t
PgpBY2tlZC1ieTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPgpTaWduZWQt
b2ZmLWJ5OiBUYXlsb3IgU2ltcHNvbiA8dHNpbXBzb25AcXVpY2luYy5jb20+Ck1lc3NhZ2UtSWQ6
IDxhMzBkOTNiOWE4ZDY2ZTlkOTI5NDM1NGNmYTJmYzNhZjM1ZjAwMjAyLjE2ODMyMTQzNzUuZ2l0
LnF1aWNfbWF0aGJlcm5AcXVpY2luYy5jb20+Ci0tLQogdGVzdHMvZ3Vlc3QtZGVidWcvcnVuLXRl
c3QucHkgICAgICAgICAgICAgICAgICAgIHwgMTYgKysrKysrKysrKysrLS0tLQogLi4uL3RjZy9t
dWx0aWFyY2gvc3lzdGVtL01ha2VmaWxlLnNvZnRtbXUtdGFyZ2V0IHwgMTYgKysrKysrKysrKysr
KysrLQogMiBmaWxlcyBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL3Rlc3RzL2d1ZXN0LWRlYnVnL3J1bi10ZXN0LnB5IGIvdGVzdHMvZ3Vlc3Qt
ZGVidWcvcnVuLXRlc3QucHkKaW5kZXggZDg2NWU0NmVjZC4uZGU2MTA2YTVlNSAxMDA3NTUKLS0t
IGEvdGVzdHMvZ3Vlc3QtZGVidWcvcnVuLXRlc3QucHkKKysrIGIvdGVzdHMvZ3Vlc3QtZGVidWcv
cnVuLXRlc3QucHkKQEAgLTI2LDExICsyNiwxMiBAQCBkZWYgZ2V0X2FyZ3MoKToKICAgICBwYXJz
ZXIuYWRkX2FyZ3VtZW50KCItLXFhcmdzIiwgaGVscD0iUWVtdSBhcmd1bWVudHMgZm9yIHRlc3Qi
KQogICAgIHBhcnNlci5hZGRfYXJndW1lbnQoIi0tYmluYXJ5IiwgaGVscD0iQmluYXJ5IHRvIGRl
YnVnIiwKICAgICAgICAgICAgICAgICAgICAgICAgIHJlcXVpcmVkPVRydWUpCi0gICAgcGFyc2Vy
LmFkZF9hcmd1bWVudCgiLS10ZXN0IiwgaGVscD0iR0RCIHRlc3Qgc2NyaXB0IiwKLSAgICAgICAg
ICAgICAgICAgICAgICAgIHJlcXVpcmVkPVRydWUpCisgICAgcGFyc2VyLmFkZF9hcmd1bWVudCgi
LS10ZXN0IiwgaGVscD0iR0RCIHRlc3Qgc2NyaXB0IikKICAgICBwYXJzZXIuYWRkX2FyZ3VtZW50
KCItLWdkYiIsIGhlbHA9IlRoZSBnZGIgYmluYXJ5IHRvIHVzZSIsCiAgICAgICAgICAgICAgICAg
ICAgICAgICBkZWZhdWx0PU5vbmUpCisgICAgcGFyc2VyLmFkZF9hcmd1bWVudCgiLS1nZGItYXJn
cyIsIGhlbHA9IkFkZGl0aW9uYWwgZ2RiIGFyZ3VtZW50cyIpCiAgICAgcGFyc2VyLmFkZF9hcmd1
bWVudCgiLS1vdXRwdXQiLCBoZWxwPSJBIGZpbGUgdG8gcmVkaXJlY3Qgb3V0cHV0IHRvIikKKyAg
ICBwYXJzZXIuYWRkX2FyZ3VtZW50KCItLXN0ZGVyciIsIGhlbHA9IkEgZmlsZSB0byByZWRpcmVj
dCBzdGRlcnIgdG8iKQogCiAgICAgcmV0dXJuIHBhcnNlci5wYXJzZV9hcmdzKCkKIApAQCAtNTgs
NiArNTksMTAgQEAgZGVmIGxvZyhvdXRwdXQsIG1zZyk6CiAgICAgICAgIG91dHB1dCA9IG9wZW4o
YXJncy5vdXRwdXQsICJ3IikKICAgICBlbHNlOgogICAgICAgICBvdXRwdXQgPSBOb25lCisgICAg
aWYgYXJncy5zdGRlcnI6CisgICAgICAgIHN0ZGVyciA9IG9wZW4oYXJncy5zdGRlcnIsICJ3IikK
KyAgICBlbHNlOgorICAgICAgICBzdGRlcnIgPSBOb25lCiAKICAgICBzb2NrZXRfZGlyID0gVGVt
cG9yYXJ5RGlyZWN0b3J5KCJxZW11LWdkYnN0dWIiKQogICAgIHNvY2tldF9uYW1lID0gb3MucGF0
aC5qb2luKHNvY2tldF9kaXIubmFtZSwgImdkYnN0dWIuc29ja2V0IikKQEAgLTc3LDYgKzgyLDgg
QEAgZGVmIGxvZyhvdXRwdXQsIG1zZyk6CiAKICAgICAjIE5vdyBsYXVuY2ggZ2RiIHdpdGggb3Vy
IHRlc3QgYW5kIGNvbGxlY3QgdGhlIHJlc3VsdAogICAgIGdkYl9jbWQgPSAiJXMgJXMiICUgKGFy
Z3MuZ2RiLCBhcmdzLmJpbmFyeSkKKyAgICBpZiBhcmdzLmdkYl9hcmdzOgorICAgICAgICBnZGJf
Y21kICs9ICIgJXMiICUgKGFyZ3MuZ2RiX2FyZ3MpCiAgICAgIyBydW4gcXVpZXRseSBhbmQgaWdu
b3JlIC5nZGJpbml0CiAgICAgZ2RiX2NtZCArPSAiIC1xIC1uIC1iYXRjaCIKICAgICAjIGRpc2Fi
bGUgcHJvbXB0cyBpbiBjYXNlIG9mIGNyYXNoCkBAIC04NCwxMyArOTEsMTQgQEAgZGVmIGxvZyhv
dXRwdXQsIG1zZyk6CiAgICAgIyBjb25uZWN0IHRvIHJlbW90ZQogICAgIGdkYl9jbWQgKz0gIiAt
ZXggJ3RhcmdldCByZW1vdGUgJXMnIiAlIChzb2NrZXRfbmFtZSkKICAgICAjIGZpbmFsbHkgdGhl
IHRlc3Qgc2NyaXB0IGl0c2VsZgotICAgIGdkYl9jbWQgKz0gIiAteCAlcyIgJSAoYXJncy50ZXN0
KQorICAgIGlmIGFyZ3MudGVzdDoKKyAgICAgICAgZ2RiX2NtZCArPSAiIC14ICVzIiAlIChhcmdz
LnRlc3QpCiAKIAogICAgIHNsZWVwKDEpCiAgICAgbG9nKG91dHB1dCwgIkdEQiBDTUQ6ICVzIiAl
IChnZGJfY21kKSkKIAotICAgIHJlc3VsdCA9IHN1YnByb2Nlc3MuY2FsbChnZGJfY21kLCBzaGVs
bD1UcnVlLCBzdGRvdXQ9b3V0cHV0KQorICAgIHJlc3VsdCA9IHN1YnByb2Nlc3MuY2FsbChnZGJf
Y21kLCBzaGVsbD1UcnVlLCBzdGRvdXQ9b3V0cHV0LCBzdGRlcnI9c3RkZXJyKQogCiAgICAgIyBB
IHJlc3VsdCBvZiBncmVhdGVyIHRoYW4gMTI4IGluZGljYXRlcyBhIGZhdGFsIHNpZ25hbCAobGlr
ZWx5IGEKICAgICAjIGNyYXNoIGR1ZSB0byBnZGIgaW50ZXJuYWwgZmFpbHVyZSkuIFRoYXQncyBh
IHByb2JsZW0gZm9yIEdEQiBhbmQKZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9tdWx0aWFyY2gvc3lz
dGVtL01ha2VmaWxlLnNvZnRtbXUtdGFyZ2V0IGIvdGVzdHMvdGNnL211bHRpYXJjaC9zeXN0ZW0v
TWFrZWZpbGUuc29mdG1tdS10YXJnZXQKaW5kZXggNWY0MzJjOTVmMy4uZmU0MDE5NWQzOSAxMDA2
NDQKLS0tIGEvdGVzdHMvdGNnL211bHRpYXJjaC9zeXN0ZW0vTWFrZWZpbGUuc29mdG1tdS10YXJn
ZXQKKysrIGIvdGVzdHMvdGNnL211bHRpYXJjaC9zeXN0ZW0vTWFrZWZpbGUuc29mdG1tdS10YXJn
ZXQKQEAgLTI3LDYgKzI3LDIwIEBAIHJ1bi1nZGJzdHViLW1lbW9yeTogbWVtb3J5CiAJCSItbW9u
aXRvciBub25lIC1kaXNwbGF5IG5vbmUgLWNoYXJkZXYgZmlsZSQoQ09NTUEpcGF0aD0kPC5vdXQk
KENPTU1BKWlkPW91dHB1dCAkKFFFTVVfT1BUUykiIFwKIAkJLS1iaW4gJDwgLS10ZXN0ICQoTVVM
VElBUkNIX1NSQykvZ2Ric3R1Yi9tZW1vcnkucHksIFwKIAlzb2Z0bW11IGdkYnN0dWIgc3VwcG9y
dCkKKworcnVuLWdkYnN0dWItdW50aW1lbHktcGFja2V0OiBoZWxsbworCSQoY2FsbCBydW4tdGVz
dCwgJEAsICQoR0RCX1NDUklQVCkgXAorCQktLWdkYiAkKEhBVkVfR0RCX0JJTikgXAorCQktLWdk
Yi1hcmdzICItZXggJ3NldCBkZWJ1ZyByZW1vdGUgMSciIFwKKwkJLS1vdXRwdXQgdW50aW1lbHkt
cGFja2V0LmdkYi5vdXQgXAorCQktLXN0ZGVyciB1bnRpbWVseS1wYWNrZXQuZ2RiLmVyciBcCisJ
CS0tcWVtdSAkKFFFTVUpIFwKKwkJLS1iaW4gJDwgLS1xYXJncyBcCisJCSItbW9uaXRvciBub25l
IC1kaXNwbGF5IG5vbmUgLWNoYXJkZXYgZmlsZSQoQ09NTUEpcGF0aD11bnRpbWVseS1wYWNrZXQu
b3V0JChDT01NQSlpZD1vdXRwdXQgJChRRU1VX09QVFMpIiwgXAorCSJzb2Z0bW11IGdkYnN0dWIg
dW50aW1lbHkgcGFja2V0cyIpCisJJChjYWxsIHF1aWV0LWNvbW1hbmQsIFwKKwkJKCEgZ3JlcCAt
RnEgJ1BhY2tldCBpbnN0ZWFkIG9mIEFjaywgaWdub3JpbmcgaXQnIHVudGltZWx5LXBhY2tldC5n
ZGIuZXJyKSwgXAorCQkiR1JFUCIsICJmaWxlICB1bnRpbWVseS1wYWNrZXQuZ2RiLmVyciIpCiBl
bHNlCiBydW4tZ2Ric3R1Yi0lOgogCSQoY2FsbCBza2lwLXRlc3QsICJnZGJzdHViIHRlc3QgJCoi
LCAibm8gZ3Vlc3QgYXJjaCBzdXBwb3J0IikKQEAgLTM2LDQgKzUwLDQgQEAgcnVuLWdkYnN0dWIt
JToKIAkkKGNhbGwgc2tpcC10ZXN0LCAiZ2Ric3R1YiB0ZXN0ICQqIiwgIm5lZWQgd29ya2luZyBn
ZGIiKQogZW5kaWYKIAotTVVMVElBUkNIX1JVTlMgKz0gcnVuLWdkYnN0dWItbWVtb3J5CitNVUxU
SUFSQ0hfUlVOUyArPSBydW4tZ2Ric3R1Yi1tZW1vcnkgcnVuLWdkYnN0dWItdW50aW1lbHktcGFj
a2V0Ci0tIAoyLjI1LjEKCg==

