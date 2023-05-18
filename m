Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B82708919
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 22:09:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzjuB-0002ev-NJ; Thu, 18 May 2023 16:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjrg-00009h-O4
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjrS-00058C-Ge
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:42 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34IJIcZd016314; Thu, 18 May 2023 20:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=D8izu/HS5HGvUEXLxsxIMgK2a7vh1w+iZrJISoMB1jU=;
 b=RfNVaAxarJVklkedqMri1dxc86DudMLi+cikrrGAjLUNFeDAm+gad2HlA//j/e+VboOj
 ibD20iIxWvuWe7cSaANJiOQs3In2YitjeC0mVL0TpR7453nrwNYGexOgzud1KW+zxP33
 r2KQgbypJWKyLevxohlrPZ+v+112qsD4itKpMxqAroimhcYPuAFVH3DGMERuYo3SplxO
 K5T/xGLmaZYgO1H0ELxREBMu4zkk4ONRAC7Yh9gDhlR23EvaNdzOTn7UKuTm/A7T2zOa
 YgxfNpTa534AcjdeURnQu5Fgh+Ft/xD3V5i6hemXNcxcarpOPbxcjg8921mtHakVaEYW PA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qnfpw1r26-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:19 +0000
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34IK4H1f012661; 
 Thu, 18 May 2023 20:04:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 3qj3mmta08-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:16 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34IK0v27007639;
 Thu, 18 May 2023 20:04:16 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-tsimpson-lv.qualcomm.com
 [10.47.204.221])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 34IK4FQ3012585
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:16 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 47164)
 id B34D56E6; Thu, 18 May 2023 13:04:13 -0700 (PDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, bcain@quicinc.com, quic_mathbern@quicinc.com,
 stefanha@redhat.com, ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com
Subject: [PULL v2 37/44] Hexagon (decode): look for pkts with multiple insns
 at the same slot
Date: Thu, 18 May 2023 13:04:04 -0700
Message-Id: <20230518200411.271148-38-tsimpson@quicinc.com>
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
X-Proofpoint-ORIG-GUID: VrDbFYPvCEYv3aZtoutwJsUDozrQeIHf
X-Proofpoint-GUID: VrDbFYPvCEYv3aZtoutwJsUDozrQeIHf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_14,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
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
b20+CgpFYWNoIHNsb3QgaW4gYSBwYWNrZXQgY2FuIGJlIGFzc2lnbmVkIHRvIGF0IG1vc3Qgb25l
IGluc3RydWN0aW9uLgpBbHRob3VnaCB0aGUgYXNzZW1ibGVyIGdlbmVyYWxseSBvdWdodCB0byBl
bmZvcmNlIHRoaXMgcnVsZSwgd2UgYmV0dGVyCmJlIHNhZmUgdGhhbiBzb3JyeSBhbmQgYWxzbyBk
byBzb21lIGNoZWNrIHRvIHByb3Blcmx5IHRocm93IGFuICJpbnZhbGlkCnBhY2tldCIgZXhjZXB0
aW9uIG9uIHdyb25nIHNsb3QgYXNzaWdubWVudHMuCgpUaGlzIHNob3VsZCBhbHNvIG1ha2UgaXQg
ZWFzaWVyIHRvIGRlYnVnIHBvc3NpYmxlIGZ1dHVyZSBlcnJvcnMgY2F1c2VkCmJ5IG1pc3Npbmcg
dXBkYXRlcyB0byBgZmluZF9pY2xhc3Nfc2xvdHMoKWAgcnVsZXMgaW4KdGFyZ2V0L2hleGFnb24v
aWNsYXNzLmMuCgpDby1hdXRob3JlZC1ieTogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNp
bmMuY29tPgpTaWduZWQtb2ZmLWJ5OiBUYXlsb3IgU2ltcHNvbiA8dHNpbXBzb25AcXVpY2luYy5j
b20+ClNpZ25lZC1vZmYtYnk6IE1hdGhldXMgVGF2YXJlcyBCZXJuYXJkaW5vIDxxdWljX21hdGhi
ZXJuQHF1aWNpbmMuY29tPgpSZXZpZXdlZC1ieTogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1
aWNpbmMuY29tPgpUZXN0ZWQtYnk6IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNv
bT4KTWVzc2FnZS1JZDogPGY4YjgyOTQ0MzUyMzU2ODgyM2QwNjJhZGY4YmY2NjU5YmM2ZDRhM2Yu
MTY4MzU1Mjk4NC5naXQucXVpY19tYXRoYmVybkBxdWljaW5jLmNvbT4KLS0tCiB0YXJnZXQvaGV4
YWdvbi9kZWNvZGUuYyAgICAgICAgICAgfCAzMCArKysrKysrKysrKysrKysrKysrKysrKysrKyst
LS0KIHRlc3RzL3RjZy9oZXhhZ29uL2ludmFsaWQtc2xvdHMuYyB8IDI5ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCiB0ZXN0cy90Y2cvaGV4YWdvbi9NYWtlZmlsZS50YXJnZXQgfCAgNyAr
KysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDYzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
CiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvdGNnL2hleGFnb24vaW52YWxpZC1zbG90cy5jCgpk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMgYi90YXJnZXQvaGV4YWdvbi9kZWNv
ZGUuYwppbmRleCAwNDFjOGRlNzUxLi45NDZjNTVjYzcxIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4
YWdvbi9kZWNvZGUuYworKysgYi90YXJnZXQvaGV4YWdvbi9kZWNvZGUuYwpAQCAtMSw1ICsxLDUg
QEAKIC8qCi0gKiAgQ29weXJpZ2h0KGMpIDIwMTktMjAyMiBRdWFsY29tbSBJbm5vdmF0aW9uIENl
bnRlciwgSW5jLiBBbGwgUmlnaHRzIFJlc2VydmVkLgorICogIENvcHlyaWdodChjKSAyMDE5LTIw
MjMgUXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4gQWxsIFJpZ2h0cyBSZXNlcnZlZC4K
ICAqCiAgKiAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmli
dXRlIGl0IGFuZC9vciBtb2RpZnkKICAqICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBH
ZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQpAQCAtNzk3LDcgKzc5NywyNiBA
QCBzdGF0aWMgYm9vbCBkZWNvZGVfcGFyc2ViaXRzX2lzX2xvb3BlbmQodWludDMyX3QgZW5jb2Rp
bmczMikKICAgICByZXR1cm4gYml0cyA9PSAweDI7CiB9CiAKLXN0YXRpYyB2b2lkCitzdGF0aWMg
Ym9vbCBoYXNfdmFsaWRfc2xvdF9hc3NpZ25tZW50KFBhY2tldCAqcGt0KQoreworICAgIGludCB1
c2VkX3Nsb3RzID0gMDsKKyAgICBmb3IgKGludCBpID0gMDsgaSA8IHBrdC0+bnVtX2luc25zOyBp
KyspIHsKKyAgICAgICAgaW50IHNsb3RfbWFzazsKKyAgICAgICAgSW5zbiAqaW5zbiA9ICZwa3Qt
Pmluc25baV07CisgICAgICAgIGlmIChkZWNvZGVfb3Bjb2RlX2VuZHNfbG9vcChpbnNuLT5vcGNv
ZGUpKSB7CisgICAgICAgICAgICAvKiBXZSBvdmVybG9hZCBzbG90IDAgZm9yIGVuZGxvb3AuICov
CisgICAgICAgICAgICBjb250aW51ZTsKKyAgICAgICAgfQorICAgICAgICBzbG90X21hc2sgPSAx
IDw8IGluc24tPnNsb3Q7CisgICAgICAgIGlmICh1c2VkX3Nsb3RzICYgc2xvdF9tYXNrKSB7Cisg
ICAgICAgICAgICByZXR1cm4gZmFsc2U7CisgICAgICAgIH0KKyAgICAgICAgdXNlZF9zbG90cyB8
PSBzbG90X21hc2s7CisgICAgfQorICAgIHJldHVybiB0cnVlOworfQorCitzdGF0aWMgYm9vbAog
ZGVjb2RlX3NldF9zbG90X251bWJlcihQYWNrZXQgKnBrdCkKIHsKICAgICBpbnQgc2xvdDsKQEAg
LTg4Niw2ICs5MDUsOCBAQCBkZWNvZGVfc2V0X3Nsb3RfbnVtYmVyKFBhY2tldCAqcGt0KQogICAg
ICAgICAvKiBUaGVuIHB1c2ggaXQgdG8gc2xvdDAgKi8KICAgICAgICAgcGt0LT5pbnNuW3Nsb3Qx
X2lpZHhdLnNsb3QgPSAwOwogICAgIH0KKworICAgIHJldHVybiBoYXNfdmFsaWRfc2xvdF9hc3Np
Z25tZW50KHBrdCk7CiB9CiAKIC8qCkBAIC05NjEsOCArOTgyLDExIEBAIGludCBkZWNvZGVfcGFj
a2V0KGludCBtYXhfd29yZHMsIGNvbnN0IHVpbnQzMl90ICp3b3JkcywgUGFja2V0ICpwa3QsCiAg
ICAgZGVjb2RlX2FwcGx5X2V4dGVuZGVycyhwa3QpOwogICAgIGlmICghZGlzYXNfb25seSkgewog
ICAgICAgICBkZWNvZGVfcmVtb3ZlX2V4dGVuZGVycyhwa3QpOworICAgICAgICBpZiAoIWRlY29k
ZV9zZXRfc2xvdF9udW1iZXIocGt0KSkgeworICAgICAgICAgICAgLyogSW52YWxpZCBwYWNrZXQg
Ki8KKyAgICAgICAgICAgIHJldHVybiAwOworICAgICAgICB9CiAgICAgfQotICAgIGRlY29kZV9z
ZXRfc2xvdF9udW1iZXIocGt0KTsKICAgICBkZWNvZGVfZmlsbF9uZXd2YWx1ZV9yZWdubyhwa3Qp
OwogCiAgICAgaWYgKHBrdC0+cGt0X2hhc19odngpIHsKZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9o
ZXhhZ29uL2ludmFsaWQtc2xvdHMuYyBiL3Rlc3RzL3RjZy9oZXhhZ29uL2ludmFsaWQtc2xvdHMu
YwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwLi4zNjZjZTRmNDJmCi0tLSAv
ZGV2L251bGwKKysrIGIvdGVzdHMvdGNnL2hleGFnb24vaW52YWxpZC1zbG90cy5jCkBAIC0wLDAg
KzEsMjkgQEAKKy8qCisgKiAgQ29weXJpZ2h0KGMpIDIwMjMgUXVhbGNvbW0gSW5ub3ZhdGlvbiBD
ZW50ZXIsIEluYy4gQWxsIFJpZ2h0cyBSZXNlcnZlZC4KKyAqCisgKiAgVGhpcyBwcm9ncmFtIGlz
IGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyAq
ICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFz
IHB1Ymxpc2hlZCBieQorICogIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2
ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yCisgKiAgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0
ZXIgdmVyc2lvbi4KKyAqCisgKiAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBo
b3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCisgKiAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZ
OyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKKyAqICBNRVJDSEFOVEFCSUxJ
VFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlCisgKiAgR05V
IEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KKyAqCisgKiAgWW91IHNo
b3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vu
c2UKKyAqICBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCBzZWUgPGh0dHA6Ly93d3cu
Z251Lm9yZy9saWNlbnNlcy8+LgorICovCisKK2NoYXIgbWVtWzhdIF9fYXR0cmlidXRlX18oKGFs
aWduZWQoOCkpKTsKKworaW50IG1haW4oKQoreworICAgIGFzbSB2b2xhdGlsZSgKKyAgICAgICAg
InIwID0gI21lbVxuIgorICAgICAgICAvKiBJbnZhbGlkIHBhY2tldCAoMiBpbnN0cnVjdGlvbnMg
YXQgc2xvdCAwKTogKi8KKyAgICAgICAgIi53b3JkIDB4YTE4MDQxMDBcbiIgLyogeyBtZW13KHIw
KSA9IHIxOyAgICAgICovCisgICAgICAgICIud29yZCAweDI4MDMyODA0XG4iIC8qICAgcjMgPSAj
MDsgcjQgPSAjMCB9ICAqLworICAgICAgICA6IDogOiAicjAiLCAicjMiLCAicjQiLCAibWVtb3J5
Iik7CisgICAgcmV0dXJuIDA7Cit9CmRpZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9NYWtl
ZmlsZS50YXJnZXQgYi90ZXN0cy90Y2cvaGV4YWdvbi9NYWtlZmlsZS50YXJnZXQKaW5kZXggNjEw
OWE3ZWQxMC4uODkwY2NlZWQ1ZCAxMDA2NDQKLS0tIGEvdGVzdHMvdGNnL2hleGFnb24vTWFrZWZp
bGUudGFyZ2V0CisrKyBiL3Rlc3RzL3RjZy9oZXhhZ29uL01ha2VmaWxlLnRhcmdldApAQCAtNTAs
NiArNTAsMTMgQEAgSEVYX1RFU1RTICs9IHZlY3Rvcl9hZGRfaW50CiBIRVhfVEVTVFMgKz0gc2Nh
dHRlcl9nYXRoZXIKIEhFWF9URVNUUyArPSBodnhfbWlzYwogSEVYX1RFU1RTICs9IGh2eF9oaXN0
b2dyYW0KK0hFWF9URVNUUyArPSBpbnZhbGlkLXNsb3RzCisKK3J1bi1hbmQtY2hlY2stZXhjZXB0
aW9uID0gJChjYWxsIHJ1bi10ZXN0LCQyLCQzIDI+JDIuc3RkZXJyOyBcCisJdGVzdCAkJD8gLWVx
IDEgJiYgZ3JlcCAtcSAiZXhjZXB0aW9uICQoc3RyaXAgJDEpIiAkMi5zdGRlcnIpCisKK3J1bi1p
bnZhbGlkLXNsb3RzOiBpbnZhbGlkLXNsb3RzCisJJChjYWxsIHJ1bi1hbmQtY2hlY2stZXhjZXB0
aW9uLCAweDE1LCAkQCwgJChRRU1VKSAkKFFFTVVfT1BUUykgJDwpCiAKIEhFWF9URVNUUyArPSB0
ZXN0X2FicwogSEVYX1RFU1RTICs9IHRlc3RfYml0Y250Ci0tIAoyLjI1LjEKCg==

