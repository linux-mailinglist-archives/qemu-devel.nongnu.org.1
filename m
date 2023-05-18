Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB68C708927
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 22:10:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzjrs-0000WT-HS; Thu, 18 May 2023 16:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjrc-00009B-4f
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjrR-00057f-Pc
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:38 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34IIQ8An001442; Thu, 18 May 2023 20:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=H62DTHuzllh1PeUx1oE2zbF3ke6XmB8FXpVR/xprcI8=;
 b=k/QdBcBhGS/6Y/Oye+Z4k4gFSgOYdt6lxxicFTiURfknWnd0YviyIhevoI3obZh0VDSU
 w0GD4MHeusSLVIIwVdOWANzGSPfGx5W4OH1g3hR6tL0E1NPgpPdnXdtYO3xQJBfThbew
 Fu7JKNqCuAUmLeSk/61jjGzIi/BVxj+GWeCPWSIoSHz1U2JfPRwzcppDwQV4KhzrOGj2
 Z9a/9CRtN2ek3ZptyT2Ic91Y0W1t5ZOfmSncbACiXgu4ysie1fg0cU6j5Lx7qm94B/qx
 p7T/e4WbbIGMCmOrZyRjWmBDjr5CPnyA+GDemHQSr0RsRIV5G/bisECYlSiy0vYIqQLn 6Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qnfpw1r23-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:18 +0000
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34IK4FOu003793; 
 Thu, 18 May 2023 20:04:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 3qnstj08fg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:16 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34IK4FUY003808;
 Thu, 18 May 2023 20:04:16 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-tsimpson-lv.qualcomm.com
 [10.47.204.221])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 34IK4Fta003787
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:15 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 47164)
 id B084B6E5; Thu, 18 May 2023 13:04:13 -0700 (PDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, bcain@quicinc.com, quic_mathbern@quicinc.com,
 stefanha@redhat.com, ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com
Subject: [PULL v2 36/44] Hexagon (iclass): update J4_hintjumpr slot constraints
Date: Thu, 18 May 2023 13:04:03 -0700
Message-Id: <20230518200411.271148-37-tsimpson@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 99HkfkuADTl7FfRm-A9vwk08pIV441V6
X-Proofpoint-GUID: 99HkfkuADTl7FfRm-A9vwk08pIV441V6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_14,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 adultscore=0 phishscore=0 mlxlogscore=488 impostorscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPHF1aWNfbWF0aGJlcm5AcXVpY2luYy5j
b20+CgpUaGUgSGV4YWdvbiBQUk0gc2F5cyB0aGF0ICJUaGUgYXNzZW1ibGVyIGF1dG9tYXRpY2Fs
bHkgZW5jb2RlcwppbnN0cnVjdGlvbnMgaW4gdGhlIHBhY2tldCBpbiB0aGUgcHJvcGVyIG9yZGVy
LiBJbiB0aGUgYmluYXJ5IGVuY29kaW5nCm9mIGEgcGFja2V0LCB0aGUgaW5zdHJ1Y3Rpb25zIG11
c3QgYmUgb3JkZXJlZCBmcm9tIFNsb3QgMyBkb3duIHRvClNsb3QgMC4iCgpQcmlvciB0byB0aGUg
YXJjaGl0ZWN0dXJlIHZlcnNpb24gdjczLCB0aGUgc2xvdCBjb25zdHJhaW50cyBmcm9tCmluc3Ry
dWN0aW9uICJoaW50anIiIG9ubHkgYWxsb3dlZCBpdCB0byBiZSBleGVjdXRlZCBhdCBzbG90IDIu
CldpdGggdGhhdCBpbiBtaW5kLCBjb25zaWRlciB0aGUgcGFja2V0OgoKICAgIHsKICAgICAgICBo
aW50anIocjApCiAgICAgICAgbm9wCiAgICAgICAgbm9wCiAgICAgICAgaWYgKCFwMCkgbWVtZChy
MSsjMCkgPSByMTowCiAgICB9CgpUbyBzYXRpc2Z5IHRoZSBvcmRlcmluZyBydWxlIHF1b3RlZCBm
cm9tIHRoZSBQUk0sIHRoZSBhc3NlbWJsZXIgd291bGQsCnRodXMsIG1vdmUgb25lIG9mIHRoZSBu
b3BzIHRvIHRoZSBmaXJzdCBwb3NpdGlvbiwgc28gdGhhdCBpdCBjYW4gYmUKYXNzaWduZWQgdG8g
c2xvdCAzIGFuZCB0aGUgc3Vic2VxdWVudCBoaW50anIgdG8gc2xvdCAyLgoKSG93ZXZlciwgc2lu
Y2UgdjczLCBoaW50anIgY2FuIGJlIGV4ZWN1dGVkIGF0IGVpdGhlciBzbG90IDIgb3IgMy4gU28K
dGhlcmUgaXMgbm8gbmVlZCB0byByZW9yZGVyIHRoYXQgcGFja2V0IGFuZCB0aGUgYXNzZW1ibGVy
IHdpbGwgZW5jb2RlIGl0CmFzIGlzLiBXaGVuIFFFTVUgdHJpZXMgdG8gZXhlY3V0ZSBpdCwgaG93
ZXZlciwgd2UgZW5kIHVwIGhpdHRpbmcgYQoibWlzYWxpZ2VkIHN0b3JlIiBleGNlcHRpb24gYmVj
YXVzZSBib3RoIHRoZSBzdG9yZSBhbmQgdGhlIGhpbnRqciB3aWxsCmJlIGFzc2lnbmVkIHRvIHN0
b3JlIDAsIGFuZCBzb21lIGZ1bmN0aW9ucyBsaWtlIGBzbG90X2lzX3ByZWRpY2F0ZWQoKWAKZXhw
ZWN0IHRoZSBkZWNvZGUgbWFjaGluZXJ5IHRvIGFzc2lnbiBvbmx5IG9uZSBpbnN0cnVjdGlvbiBw
ZXIgc2xvdC4gSW4KcGFydGljdWxhciwgdGhlIG1lbnRpb25lZCBmdW5jdGlvbiB3aWxsIHRyYXZl
cnNlIHRoZSBwYWNrZXQgdW50aWwgaXQKZmluZHMgdGhlIGZpcnN0IGluc3RydWN0aW9uIGF0IHRo
ZSBkZXNpcmVkIHNsb3Qgd2hpY2gsIGZvciBzbG90IDAsIHdpbGwKYmUgaGludGpyLiBTaW5jZSBo
aW50anIgaXMgbm90IHByZWRpY2F0ZWQsIHRoZSByZXN1bHQgaXMgdGhhdCB3ZSB0cnkgdG8KZXhl
Y3V0ZSB0aGUgc3RvcmUgcmVnYXJkbGVzcyBvZiB0aGUgcHJlZGljYXRlLiBBbmQgYmVjYXVzZSB0
aGUgcHJlZGljYXRlCmlzIGZhbHNlLCB3ZSBoYWQgbm90IHByZXZpb3VzbHkgbG9hZGVkIGhleF9z
dG9yZV9hZGRyWzBdIG9yCmhleF9zdG9yZV93aWR0aFswXS4gQXMgYSByZXN1bHQsIHRoZSBzdG9y
ZSB3aWxsIGRlY2lkZSBkZSB3aWR0aCBiYXNlZCBvbgp0cmFzaCBtZW1vcnksIGNhdXNpbmcgaXQg
dG8gYmUgbWlzYWxpZ25lZC4KClVwZGF0ZSB0aGUgc2xvdCBjb25zdHJhaW50cyBmb3IgaGludGpy
IHNvIHRoYXQgUUVNVSBjYW4gcHJvcGVybHkgaGFuZGxlCnN1Y2ggZW5jb2RpbmdzLgoKTm90ZTog
dG8gYXZvaWQgc2ltaWxhci1idXQtbm90LWlkZW50aWNhbCBpc3N1ZXMgaW4gdGhlIGZ1dHVyZSwg
d2Ugc2hvdWxkCmxvb2sgZm9yIG11bHRpcGxlIGluc3RydWN0aW9ucyBhdCB0aGUgc2FtZSBzbG90
IGR1cmluZyBkZWNvZGluZyB0aW1lIGFuZAp0aHJvdyBhbiBpbnZhbGlkIHBhY2tldCBleGNlcHRp
b24uIFRoYXQgd2lsbCBiZSBkb25lIGluIHRoZSBzdWJzZXF1ZW50CmNvbW1pdC4KClNpZ25lZC1v
ZmYtYnk6IE1hdGhldXMgVGF2YXJlcyBCZXJuYXJkaW5vIDxxdWljX21hdGhiZXJuQHF1aWNpbmMu
Y29tPgpSZXZpZXdlZC1ieTogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPgpT
aWduZWQtb2ZmLWJ5OiBUYXlsb3IgU2ltcHNvbiA8dHNpbXBzb25AcXVpY2luYy5jb20+Ck1lc3Nh
Z2UtSWQ6IDwwZmNkODI5MzY0MmM2MzI0MTE5ZmJiYWI0NDc0MTE2NGJjYmQwNGZiLjE2NzM2MTY5
NjQuZ2l0LnF1aWNfbWF0aGJlcm5AcXVpY2luYy5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vaWNs
YXNzLmMgfCA2ICsrKystLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9pY2xhc3MuYyBiL3RhcmdldC9o
ZXhhZ29uL2ljbGFzcy5jCmluZGV4IDYwOTEyODY5OTMuLmMzZjg1MjNiMjcgMTAwNjQ0Ci0tLSBh
L3RhcmdldC9oZXhhZ29uL2ljbGFzcy5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2ljbGFzcy5jCkBA
IC0xLDUgKzEsNSBAQAogLyoKLSAqICBDb3B5cmlnaHQoYykgMjAxOS0yMDIxIFF1YWxjb21tIElu
bm92YXRpb24gQ2VudGVyLCBJbmMuIEFsbCBSaWdodHMgUmVzZXJ2ZWQuCisgKiAgQ29weXJpZ2h0
KGMpIDIwMTktMjAyMyBRdWFsY29tbSBJbm5vdmF0aW9uIENlbnRlciwgSW5jLiBBbGwgUmlnaHRz
IFJlc2VydmVkLgogICoKICAqICBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNh
biByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQogICogIGl0IHVuZGVyIHRoZSB0ZXJtcyBv
ZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5CkBAIC01MSw4
ICs1MSwxMCBAQCBTbG90TWFzayBmaW5kX2ljbGFzc19zbG90cyhPcGNvZGUgb3Bjb2RlLCBpbnQg
aXR5cGUpCiAgICAgICAgIHJldHVybiBTTE9UU18wOwogICAgIH0gZWxzZSBpZiAoKG9wY29kZSA9
PSBKMl90cmFwMCkgfHwKICAgICAgICAgICAgICAgIChvcGNvZGUgPT0gWTJfaXN5bmMpIHx8Ci0g
ICAgICAgICAgICAgICAob3Bjb2RlID09IEoyX3BhdXNlKSB8fCAob3Bjb2RlID09IEo0X2hpbnRq
dW1wcikpIHsKKyAgICAgICAgICAgICAgIChvcGNvZGUgPT0gSjJfcGF1c2UpKSB7CiAgICAgICAg
IHJldHVybiBTTE9UU18yOworICAgIH0gZWxzZSBpZiAob3Bjb2RlID09IEo0X2hpbnRqdW1wcikg
eworICAgICAgICByZXR1cm4gU0xPVFNfMjM7CiAgICAgfSBlbHNlIGlmIChHRVRfQVRUUklCKG9w
Y29kZSwgQV9DUlNMT1QyMykpIHsKICAgICAgICAgcmV0dXJuIFNMT1RTXzIzOwogICAgIH0gZWxz
ZSBpZiAoR0VUX0FUVFJJQihvcGNvZGUsIEFfUkVTVFJJQ1RfUFJFRkVSU0xPVDApKSB7Ci0tIAoy
LjI1LjEKCg==

