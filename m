Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF32D708910
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 22:08:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzjst-000144-KN; Thu, 18 May 2023 16:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjrc-000097-2V
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjrR-00057Y-Iy
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:39 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34IJMruu010897; Thu, 18 May 2023 20:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yAw1UHaSqSAEbrwaoIG4fmdHagvhe0u7vA9M55wG+8E=;
 b=NVGN2yUaK2sgskfSh0v838/8wsTfNyGMlkA7l10AKCDaJZHYn4JbGFDgQMF7g59Tqh14
 Ov23WoZ77DYK+HuQB10hvcLPdX3AppIV/kXY6oiTJ4fUS2kooh5LD8Ze/5aSeJ5uD6Ke
 TbqQ2ESW5Oj5QBw/y9COKKHV3OlvfGoFXMSwVyRu3v5UTVBHRtXOtGDmomI82iw/Gkqc
 LK1UO5WoAKY4gV4GYPjIiIJScqn9udbBojZ4U1UXmkjvHjAWqBxUwE48tw/hRyBbG+3c
 n4sZVIin8FaukRucazAOx1eT8eC4RcGWUSer3DTBo5LcdPjTjtG4/MgictrzST8iGWGV KA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qn8d2jewv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:17 +0000
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
 by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34IK4GW5028879; 
 Thu, 18 May 2023 20:04:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 3qmryp306e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:16 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34IK4F6C028598;
 Thu, 18 May 2023 20:04:16 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-tsimpson-lv.qualcomm.com
 [10.47.204.221])
 by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 34IK4FQD028664
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:16 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 47164)
 id 8C1146D8; Thu, 18 May 2023 13:04:13 -0700 (PDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, bcain@quicinc.com, quic_mathbern@quicinc.com,
 stefanha@redhat.com, ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com
Subject: [PULL v2 23/44] Hexagon (target/hexagon) Short-circuit more HVX
 single instruction packets
Date: Thu, 18 May 2023 13:03:50 -0700
Message-Id: <20230518200411.271148-24-tsimpson@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 6YpE3_X4KCngzBa01hv_lS9DYodQy3H9
X-Proofpoint-GUID: 6YpE3_X4KCngzBa01hv_lS9DYodQy3H9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_15,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 malwarescore=0 mlxlogscore=930 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

VGhlIGdlbmVyYXRlZCBoZWxwZXJzIGZvciBIVlggdXNlIHBhc3MtYnktcmVmZXJlbmNlLCBzbyB0
aGV5IGNhbid0CnNob3J0LWNpcmN1aXQgd2hlbiB0aGUgcmVhZHMvd3JpdGVzIG92ZXJsYXAuICBU
aGUgaW5zdHJ1Y3Rpb25zIHdpdGgKb3ZlcnJpZGVzIGFyZSBPSyBiZWNhdXNlIHRoZXkgdXNlIHRj
Z19nZW5fZ3ZlY18qLgoKV2UgYWRkIGEgZmxhZyBoYXNfaHZ4X2hlbHBlciB0byBEaXNhc0NvbnRl
eHQgYW5kIGV4dGVuZCBnZW5fYW5hbHl6ZV9mdW5jcwp0byBzZXQgdGhlIGZsYWcgd2hlbiB0aGUg
aW5zdHJ1Y3Rpb24gaXMgYW4gSFZYIGluc3RydWN0aW9uIHdpdGggYQpnZW5lcmF0ZWQgaGVscGVy
LgoKV2UgYWRkIGFuIG92ZXJyaWRlIGZvciBWNl92Y29tYmluZSBzbyB0aGF0IGl0IGNhbiBiZSBz
aG9ydC1jaXJjdWl0ZWQKYWxvbmcgd2l0aCBhIHRlc3QgY2FzZSBpbiB0ZXN0cy90Y2cvaGV4YWdv
bi9odnhfbWlzYy5jCgpTaWduZWQtb2ZmLWJ5OiBUYXlsb3IgU2ltcHNvbiA8dHNpbXBzb25AcXVp
Y2luYy5jb20+ClJldmlld2VkLWJ5OiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJz
b25AbGluYXJvLm9yZz4KTWVzc2FnZS1JZDogPDIwMjMwNDI3MjMwMDEyLjM4MDAzMjctMTUtdHNp
bXBzb25AcXVpY2luYy5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19odnguaCAgICAg
ICAgfCAyMyArKysrKysrKysrKysrKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRl
LmggICAgICAgICAgfCAgMSArCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyAgICAgICAgICB8
IDE3ICsrKysrKysrKysrKysrKy0tCiB0ZXN0cy90Y2cvaGV4YWdvbi9odnhfbWlzYy5jICAgICAg
ICB8IDIxICsrKysrKysrKysrKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vZ2VuX2FuYWx5emVf
ZnVuY3MucHkgfCAgNSArKysrKwogNSBmaWxlcyBjaGFuZ2VkLCA2NSBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfaHZ4Lmgg
Yi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oCmluZGV4IDhkY2VlYWQ1ZTUuLjQ0YmFlNTNm
OGQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfaHZ4LmgKKysrIGIvdGFyZ2V0
L2hleGFnb24vZ2VuX3RjZ19odnguaApAQCAtMTQwLDYgKzE0MCwyOSBAQCBzdGF0aWMgaW5saW5l
IHZvaWQgYXNzZXJ0X3ZoaXN0X3RtcChEaXNhc0NvbnRleHQgKmN0eCkKICAgICAgICAgICAgICAg
ICAgICAgICAgICBzaXplb2YoTU1WZWN0b3IpLCBzaXplb2YoTU1WZWN0b3IpKTsgXAogICAgIH0g
d2hpbGUgKDApCiAKKy8qCisgKiBWZWN0b3IgY29tYmluZQorICoKKyAqIEJlIGNhcmVmdWwgdGhh
dCB0aGUgc291cmNlIGFuZCBkZXN0IGRvbid0IG92ZXJsYXAKKyAqLworI2RlZmluZSBmR0VOX1RD
R19WNl92Y29tYmluZShTSE9SVENPREUpIFwKKyAgICBkbyB7IFwKKyAgICAgICAgaWYgKFZkZFZf
b2ZmICE9IFZ1Vl9vZmYpIHsgXAorICAgICAgICAgICAgdGNnX2dlbl9ndmVjX21vdihNT182NCwg
VmRkVl9vZmYsIFZ2Vl9vZmYsIFwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9m
KE1NVmVjdG9yKSwgc2l6ZW9mKE1NVmVjdG9yKSk7IFwKKyAgICAgICAgICAgIHRjZ19nZW5fZ3Zl
Y19tb3YoTU9fNjQsIFZkZFZfb2ZmICsgc2l6ZW9mKE1NVmVjdG9yKSwgVnVWX29mZiwgXAorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2YoTU1WZWN0b3IpLCBzaXplb2YoTU1WZWN0
b3IpKTsgXAorICAgICAgICB9IGVsc2UgeyBcCisgICAgICAgICAgICBpbnRwdHJfdCB0bXBvZmYg
PSBvZmZzZXRvZihDUFVIZXhhZ29uU3RhdGUsIHZ0bXApOyBcCisgICAgICAgICAgICB0Y2dfZ2Vu
X2d2ZWNfbW92KE1PXzY0LCB0bXBvZmYsIFZ1Vl9vZmYsIFwKKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc2l6ZW9mKE1NVmVjdG9yKSwgc2l6ZW9mKE1NVmVjdG9yKSk7IFwKKyAgICAgICAg
ICAgIHRjZ19nZW5fZ3ZlY19tb3YoTU9fNjQsIFZkZFZfb2ZmLCBWdlZfb2ZmLCBcCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihNTVZlY3RvciksIHNpemVvZihNTVZlY3Rvcikp
OyBcCisgICAgICAgICAgICB0Y2dfZ2VuX2d2ZWNfbW92KE1PXzY0LCBWZGRWX29mZiArIHNpemVv
ZihNTVZlY3RvciksIHRtcG9mZiwgXAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXpl
b2YoTU1WZWN0b3IpLCBzaXplb2YoTU1WZWN0b3IpKTsgXAorICAgICAgICB9IFwKKyAgICB9IHdo
aWxlICgwKQorCiAvKiBWZWN0b3IgY29uZGl0aW9uYWwgbW92ZSAqLwogI2RlZmluZSBmR0VOX1RD
R19WRUNfQ01PVihQUkVEKSBcCiAgICAgZG8geyBcCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdv
bi90cmFuc2xhdGUuaCBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCmluZGV4IDNmNmZkMzQ1
MmMuLjI2YmNhZTAzOTUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCisr
KyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCkBAIC02OCw2ICs2OCw3IEBAIHR5cGVkZWYg
c3RydWN0IERpc2FzQ29udGV4dCB7CiAgICAgYm9vbCBpc190aWdodF9sb29wOwogICAgIGJvb2wg
bmVlZF9wa3RfaGFzX3N0b3JlX3MxOwogICAgIGJvb2wgc2hvcnRfY2lyY3VpdDsKKyAgICBib29s
IGhhc19odnhfaGVscGVyOwogfSBEaXNhc0NvbnRleHQ7CiAKIHN0YXRpYyBpbmxpbmUgdm9pZCBj
dHhfbG9nX3ByZWRfd3JpdGUoRGlzYXNDb250ZXh0ICpjdHgsIGludCBwbnVtKQpkaWZmIC0tZ2l0
IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUu
YwppbmRleCA4ZTdhNDM3N2M4Li5mZTg1ZWRjMWVjIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdv
bi90cmFuc2xhdGUuYworKysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwpAQCAtMzc4LDgg
KzM3OCwyMCBAQCBzdGF0aWMgYm9vbCBuZWVkX2NvbW1pdChEaXNhc0NvbnRleHQgKmN0eCkKICAg
ICAgICAgcmV0dXJuIHRydWU7CiAgICAgfQogCi0gICAgaWYgKHBrdC0+bnVtX2luc25zID09IDEg
JiYgIXBrdC0+cGt0X2hhc19odngpIHsKLSAgICAgICAgcmV0dXJuIGZhbHNlOworICAgIGlmIChw
a3QtPm51bV9pbnNucyA9PSAxKSB7CisgICAgICAgIGlmIChwa3QtPnBrdF9oYXNfaHZ4KSB7Cisg
ICAgICAgICAgICAvKgorICAgICAgICAgICAgICogVGhlIEhWWCBpbnN0cnVjdGlvbnMgd2l0aCBn
ZW5lcmF0ZWQgaGVscGVycyB1c2UKKyAgICAgICAgICAgICAqIHBhc3MtYnktcmVmZXJlbmNlLCBz
byB0aGV5IG5lZWQgdGhlIHJlYWQvd3JpdGUgb3ZlcmxhcAorICAgICAgICAgICAgICogY2hlY2sg
YmVsb3cuCisgICAgICAgICAgICAgKiBUaGUgSFZYIGluc3RydWN0aW9ucyB3aXRoIG92ZXJyaWRl
cyBhcmUgT0suCisgICAgICAgICAgICAgKi8KKyAgICAgICAgICAgIGlmICghY3R4LT5oYXNfaHZ4
X2hlbHBlcikgeworICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsKKyAgICAgICAgICAgIH0K
KyAgICAgICAgfSBlbHNlIHsKKyAgICAgICAgICAgIHJldHVybiBmYWxzZTsKKyAgICAgICAgfQog
ICAgIH0KIAogICAgIC8qIENoZWNrIGZvciBvdmVybGFwIGJldHdlZW4gcmVnaXN0ZXIgcmVhZHMg
YW5kIHdyaXRlcyAqLwpAQCAtNDU0LDYgKzQ2Niw3IEBAIHN0YXRpYyB2b2lkIGFuYWx5emVfcGFj
a2V0KERpc2FzQ29udGV4dCAqY3R4KQogewogICAgIFBhY2tldCAqcGt0ID0gY3R4LT5wa3Q7CiAg
ICAgY3R4LT5uZWVkX3BrdF9oYXNfc3RvcmVfczEgPSBmYWxzZTsKKyAgICBjdHgtPmhhc19odnhf
aGVscGVyID0gZmFsc2U7CiAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBwa3QtPm51bV9pbnNuczsg
aSsrKSB7CiAgICAgICAgIEluc24gKmluc24gPSAmcGt0LT5pbnNuW2ldOwogICAgICAgICBjdHgt
Pmluc24gPSBpbnNuOwpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vaHZ4X21pc2MuYyBi
L3Rlc3RzL3RjZy9oZXhhZ29uL2h2eF9taXNjLmMKaW5kZXggZDBlNjRlMDM1Zi4uYzg5ZmUwMjUz
ZCAxMDA2NDQKLS0tIGEvdGVzdHMvdGNnL2hleGFnb24vaHZ4X21pc2MuYworKysgYi90ZXN0cy90
Y2cvaGV4YWdvbi9odnhfbWlzYy5jCkBAIC00NTQsNiArNDU0LDI1IEBAIHN0YXRpYyB2b2lkIHRl
c3RfbG9hZF9jdXJfcHJlZGljYXRlZCh2b2lkKQogICAgIGNoZWNrX291dHB1dF93KF9fTElORV9f
LCBCVUZTSVpFKTsKIH0KIAorc3RhdGljIHZvaWQgdGVzdF92Y29tYmluZSh2b2lkKQoreworICAg
IGZvciAoaW50IGkgPSAwOyBpIDwgQlVGU0laRSAvIDI7IGkrKykgeworICAgICAgICBhc20gdm9s
YXRpbGUoInYyID0gdnNwbGF0KCUwKVxuXHQiCisgICAgICAgICAgICAgICAgICAgICAidjMgPSB2
c3BsYXQoJTEpXG5cdCIKKyAgICAgICAgICAgICAgICAgICAgICJ2MzoyID0gdmNvbWJpbmUodjIs
IHYzKVxuXHQiCisgICAgICAgICAgICAgICAgICAgICAidm1lbSglMisjMCkgPSB2MlxuXHQiCisg
ICAgICAgICAgICAgICAgICAgICAidm1lbSglMisjMSkgPSB2M1xuXHQiCisgICAgICAgICAgICAg
ICAgICAgICA6CisgICAgICAgICAgICAgICAgICAgICA6ICJyIigyICogaSksICJyIigyICogaSAr
IDEpLCAiciIoJm91dHB1dFsyICogaV0pCisgICAgICAgICAgICAgICAgICAgICA6ICJ2MiIsICJ2
MyIsICJtZW1vcnkiKTsKKyAgICAgICAgZm9yIChpbnQgaiA9IDA7IGogPCBNQVhfVkVDX1NJWkVf
QllURVMgLyA0OyBqKyspIHsKKyAgICAgICAgICAgIGV4cGVjdFsyICogaV0ud1tqXSA9IDIgKiBp
ICsgMTsKKyAgICAgICAgICAgIGV4cGVjdFsyICogaSArIDFdLndbal0gPSAyICogaTsKKyAgICAg
ICAgfQorICAgIH0KKyAgICBjaGVja19vdXRwdXRfdyhfX0xJTkVfXywgQlVGU0laRSk7Cit9CisK
IGludCBtYWluKCkKIHsKICAgICBpbml0X2J1ZmZlcnMoKTsKQEAgLTQ5NCw2ICs1MTMsOCBAQCBp
bnQgbWFpbigpCiAgICAgdGVzdF9sb2FkX3RtcF9wcmVkaWNhdGVkKCk7CiAgICAgdGVzdF9sb2Fk
X2N1cl9wcmVkaWNhdGVkKCk7CiAKKyAgICB0ZXN0X3Zjb21iaW5lKCk7CisKICAgICBwdXRzKGVy
ciA/ICJGQUlMIiA6ICJQQVNTIik7CiAgICAgcmV0dXJuIGVyciA/IDEgOiAwOwogfQpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VuX2FuYWx5emVfZnVuY3MucHkgYi90YXJnZXQvaGV4YWdv
bi9nZW5fYW5hbHl6ZV9mdW5jcy5weQppbmRleCA4NmFlYzVhYzRiLi4zNmRhNjY5NDUwIDEwMDc1
NQotLS0gYS90YXJnZXQvaGV4YWdvbi9nZW5fYW5hbHl6ZV9mdW5jcy5weQorKysgYi90YXJnZXQv
aGV4YWdvbi9nZW5fYW5hbHl6ZV9mdW5jcy5weQpAQCAtMjEyLDYgKzIxMiwxMSBAQCBkZWYgZ2Vu
X2FuYWx5emVfZnVuYyhmLCB0YWcsIHJlZ3MsIGltbXMpOgogICAgIGlmIGhhc19nZW5lcmF0ZWRf
aGVscGVyIGFuZCAiQV9TQ0FMQVJfTE9BRCIgaW4gaGV4X2NvbW1vbi5hdHRyaWJkaWN0W3RhZ106
CiAgICAgICAgIGYud3JpdGUoIiAgICBjdHgtPm5lZWRfcGt0X2hhc19zdG9yZV9zMSA9IHRydWU7
XG4iKQogCisgICAgIyMgTWFyayBIVlggaW5zdHJ1Y3Rpb25zIHdpdGggZ2VuZXJhdGVkIGhlbHBl
cnMKKyAgICBpZiAoaGFzX2dlbmVyYXRlZF9oZWxwZXIgYW5kCisgICAgICAgICJBX0NWSSIgaW4g
aGV4X2NvbW1vbi5hdHRyaWJkaWN0W3RhZ10pOgorICAgICAgICBmLndyaXRlKCIgICAgY3R4LT5o
YXNfaHZ4X2hlbHBlciA9IHRydWU7XG4iKQorCiAgICAgZi53cml0ZSgifVxuXG4iKQogCiAKLS0g
CjIuMjUuMQoK

