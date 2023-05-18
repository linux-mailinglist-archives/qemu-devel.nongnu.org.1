Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D16670892D
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 22:11:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzjuE-0002tG-JK; Thu, 18 May 2023 16:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjrc-000098-3P
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjrQ-00056v-Sv
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:38 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34IJwShu006342; Thu, 18 May 2023 20:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9EVcvd8VtvmHIXQn1QTb/4fKfxjuNoBUKFxuJW0T+ig=;
 b=Wk/11NHtxK7umQzU8b8vlqszX51hwffpkC8qM3IXxAlOYU6qw8I38/EFNYYINimn8txL
 99bUG7AROLBAi9Uj6qE6fnU9CAAAX+kRsI9QFVpg/uRMwM/VfEroR4lRs4inIHdl8J48
 8qEeZOZcZq4mvT+h5W7pxvcKmla42VlaJKo3Unvoq1pR3GaDK9wChT/L9OziI9OCsESX
 Rf2Z3adN7uC6kNdgmN+D6e4+UrBhgouWlLdep8bfXM0myVbJqTizESbyNAjcUgmdD0qW
 YDRozyvu8yj+9lJd95+JW3vFRXKFfFLz860v/gFvCzErzOZmwHyr78Poh2aOJGzEDOhp 0Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qnfpw1r20-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:17 +0000
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
 by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34IK4FC4028718; 
 Thu, 18 May 2023 20:04:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 3qmryp305f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:15 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34IK4F6A028598;
 Thu, 18 May 2023 20:04:15 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-tsimpson-lv.qualcomm.com
 [10.47.204.221])
 by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 34IK4EmF028342
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:14 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 47164)
 id 60FBE6C8; Thu, 18 May 2023 13:04:13 -0700 (PDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, bcain@quicinc.com, quic_mathbern@quicinc.com,
 stefanha@redhat.com, ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com
Subject: [PULL v2 08/44] Hexagon (target/hexagon) Add v73 scalar instructions
Date: Thu, 18 May 2023 13:03:35 -0700
Message-Id: <20230518200411.271148-9-tsimpson@quicinc.com>
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
X-Proofpoint-ORIG-GUID: qoeJE10NkPc8sgO8xdfnQrh_gPE1VkOU
X-Proofpoint-GUID: qoeJE10NkPc8sgO8xdfnQrh_gPE1VkOU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_14,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 adultscore=0 phishscore=0 mlxlogscore=601 impostorscore=0 spamscore=0
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

VGhlIGZvbGxvd2luZyBpbnN0cnVjdGlvbnMgYXJlIGFkZGVkCiAgICBKMl9jYWxscmgKICAgIEoy
X2p1bnByaAoKU2lnbmVkLW9mZi1ieTogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMu
Y29tPgpSZXZpZXdlZC1ieTogQW50b24gSm9oYW5zc29uIDxhbmpvQHJldi5uZz4KTWVzc2FnZS1J
ZDogPDIwMjMwNDI3MjI0MDU3LjM3NjY5NjMtOS10c2ltcHNvbkBxdWljaW5jLmNvbT4KLS0tCiB0
YXJnZXQvaGV4YWdvbi9nZW5fdGNnLmggICAgICAgICAgICAgIHwgNCArKysrCiB0YXJnZXQvaGV4
YWdvbi9hdHRyaWJzX2RlZi5oLmluYyAgICAgIHwgMSArCiB0YXJnZXQvaGV4YWdvbi9pbXBvcnRl
ZC9icmFuY2guaWRlZiAgIHwgNyArKysrKystCiB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9lbmNv
ZGVfcHAuZGVmIHwgMiArKwogNCBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZy5oIGIvdGFyZ2V0
L2hleGFnb24vZ2VuX3RjZy5oCmluZGV4IDU5OGQ4MGQzY2UuLjZmMTJmNjY1ZGIgMTAwNjQ0Ci0t
LSBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2cuaAorKysgYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNn
LmgKQEAgLTY1Myw2ICs2NTMsOCBAQAogICAgIGdlbl9jYWxsKGN0eCwgcmlWKQogI2RlZmluZSBm
R0VOX1RDR19KMl9jYWxscihTSE9SVENPREUpIFwKICAgICBnZW5fY2FsbHIoY3R4LCBSc1YpCisj
ZGVmaW5lIGZHRU5fVENHX0oyX2NhbGxyaChTSE9SVENPREUpIFwKKyAgICBnZW5fY2FsbHIoY3R4
LCBSc1YpCiAKICNkZWZpbmUgZkdFTl9UQ0dfSjJfY2FsbHQoU0hPUlRDT0RFKSBcCiAgICAgZ2Vu
X2NvbmRfY2FsbChjdHgsIFB1ViwgVENHX0NPTkRfRVEsIHJpVikKQEAgLTg1MSw2ICs4NTMsOCBA
QAogICAgIGdlbl9qdW1wKGN0eCwgcmlWKQogI2RlZmluZSBmR0VOX1RDR19KMl9qdW1wcihTSE9S
VENPREUpIFwKICAgICBnZW5fanVtcHIoY3R4LCBSc1YpCisjZGVmaW5lIGZHRU5fVENHX0oyX2p1
bXByaChTSE9SVENPREUpIFwKKyAgICBnZW5fanVtcHIoY3R4LCBSc1YpCiAjZGVmaW5lIGZHRU5f
VENHX0o0X2p1bXBzZXRpKFNIT1JUQ09ERSkgXAogICAgIGRvIHsgXAogICAgICAgICB0Y2dfZ2Vu
X21vdmlfdGwoUmRWLCBVaVYpOyBcCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9hdHRyaWJz
X2RlZi5oLmluYyBiL3RhcmdldC9oZXhhZ29uL2F0dHJpYnNfZGVmLmguaW5jCmluZGV4IDNiZWY2
MGJlZjMuLjY5ZGE5Nzc2ZjAgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2F0dHJpYnNfZGVm
LmguaW5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2F0dHJpYnNfZGVmLmguaW5jCkBAIC04OSw2ICs4
OSw3IEBAIERFRl9BVFRSSUIoSlVNUCwgIkp1bXAtdHlwZSBpbnN0cnVjdGlvbiIsICIiLCAiIikK
IERFRl9BVFRSSUIoSU5ESVJFQ1QsICJBYnNvbHV0ZSByZWdpc3RlciBqdW1wIiwgIiIsICIiKQog
REVGX0FUVFJJQihDQUxMLCAiRnVuY3Rpb24gY2FsbCBpbnN0cnVjdGlvbiIsICIiLCAiIikKIERF
Rl9BVFRSSUIoQ09GLCAiQ2hhbmdlLW9mLWZsb3cgaW5zdHJ1Y3Rpb24iLCAiIiwgIiIpCitERUZf
QVRUUklCKEhJTlRFRF9DT0YsICJUaGlzIGluc3RydWN0aW9uIGlzIGEgaGludGVkIGNoYW5nZS1v
Zi1mbG93IiwgIiIsICIiKQogREVGX0FUVFJJQihDT05ERVhFQywgIk1heSBiZSBjYW5jZWxsZWQg
YnkgYSBwcmVkaWNhdGUiLCAiIiwgIiIpCiBERUZfQVRUUklCKERPVE5FV1ZBTFVFLCAiVXNlcyBh
IHJlZ2lzdGVyIHZhbHVlIGdlbmVyYXRlZCBpbiB0aGlzIHBrdCIsICIiLCAiIikKIERFRl9BVFRS
SUIoTkVXQ01QSlVNUCwgIkNvbXBvdW5kIGNvbXBhcmUgYW5kIGp1bXAiLCAiIiwgIiIpCmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9icmFuY2guaWRlZiBiL3RhcmdldC9oZXhh
Z29uL2ltcG9ydGVkL2JyYW5jaC5pZGVmCmluZGV4IDg4ZjVmNDhjY2UuLjkzZTJlMzc1YTUgMTAw
NjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2JyYW5jaC5pZGVmCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2ltcG9ydGVkL2JyYW5jaC5pZGVmCkBAIC0xLDUgKzEsNSBAQAogLyoKLSAqICBD
b3B5cmlnaHQoYykgMjAxOS0yMDIxIFF1YWxjb21tIElubm92YXRpb24gQ2VudGVyLCBJbmMuIEFs
bCBSaWdodHMgUmVzZXJ2ZWQuCisgKiAgQ29weXJpZ2h0KGMpIDIwMTktMjAyMyBRdWFsY29tbSBJ
bm5vdmF0aW9uIENlbnRlciwgSW5jLiBBbGwgUmlnaHRzIFJlc2VydmVkLgogICoKICAqICBUaGlz
IHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29y
IG1vZGlmeQogICogIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGlj
IExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5CkBAIC0zNCw2ICszNCw5IEBAIFE2SU5TTihKMl9qdW1w
LCJqdW1wICNyMjI6MiIsQVRUUklCUyhBX0pESVIpLCAiZGlyZWN0IHVuY29uZGl0aW9uYWwganVt
cCIsCiBRNklOU04oSjJfanVtcHIsImp1bXByIFJzMzIiLEFUVFJJQlMoQV9KSU5ESVIpLCAiaW5k
aXJlY3QgdW5jb25kaXRpb25hbCBqdW1wIiwKIHtmSlVNUFIoUnNOLFJzVixDT0ZfVFlQRV9KVU1Q
Uik7fSkKIAorUTZJTlNOKEoyX2p1bXByaCwianVtcHJoIFJzMzIiLEFUVFJJQlMoQV9KSU5ESVIs
IEFfSElOVEVEX0NPRiksICJpbmRpcmVjdCB1bmNvbmRpdGlvbmFsIGp1bXAiLAore2ZKVU1QUihS
c04sUnNWLENPRl9UWVBFX0pVTVBSKTt9KQorCiAjZGVmaW5lIE9MRENPTkRfSlVNUChUQUcsT1BF
UixPUEVSMixBVFRSSUIsREVTQ1IsU0VNQU5USUNTKSBcCiBRNklOU04oVEFHIyN0LCJpZiAoUHU0
KSAiT1BFUiI6bnQgIk9QRVIyLEFUVFJJQixERVNDUix7ZkJSQU5DSF9TUEVDVUxBVEVfU1RBTEwo
ZkxTQk9MRChQdVYpLCxTUEVDVUxBVEVfTk9UX1RBS0VOLDEyLDApOyBpZiAoZkxTQk9MRChQdVYp
KSB7IFNFTUFOVElDUzsgfX0pIFwKIFE2SU5TTihUQUcjI2YsImlmICghUHU0KSAiT1BFUiI6bnQg
Ik9QRVIyLEFUVFJJQixERVNDUix7ZkJSQU5DSF9TUEVDVUxBVEVfU1RBTEwoZkxTQk9MRE5PVChQ
dVYpLCxTUEVDVUxBVEVfTk9UX1RBS0VOLDEyLDApOyBpZiAoZkxTQk9MRE5PVChQdVYpKSB7IFNF
TUFOVElDUzsgfX0pIFwKQEAgLTE5Niw2ICsxOTksOCBAQCBRNklOU04oSjJfY2FsbHJ0LCJpZiAo
UHU0KSBjYWxsciBSczMyIixBVFRSSUJTKENJTkRJUl9TVEQpLCJpbmRpcmVjdCBjb25kaXRpb25h
bAogUTZJTlNOKEoyX2NhbGxyZiwiaWYgKCFQdTQpIGNhbGxyIFJzMzIiLEFUVFJJQlMoQ0lORElS
X1NURCksImluZGlyZWN0IGNvbmRpdGlvbmFsIGNhbGwgaWYgZmFsc2UiLAoge2ZCUkFOQ0hfU1BF
Q1VMQVRFX1NUQUxMKGZMU0JPTEROT1QoUHVWKSwsU1BFQ1VMQVRFX05PVF9UQUtFTiwxMiwwKTtp
ZiAoZkxTQk9MRE5PVChQdVYpKSB7IGZDQUxMUihSc1YpOyB9fSkKIAorUTZJTlNOKEoyX2NhbGxy
aCwiY2FsbHJoIFJzMzIiLEFUVFJJQlMoQ0lORElSX1NURCwgQV9ISU5URURfQ09GKSwgImhpbnRl
ZCBpbmRpcmVjdCB1bmNvbmRpdGlvbmFsIGNhbGwiLAoreyBmQ0FMTFIoUnNWKTsgfSkKIAogCiAK
ZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2VuY29kZV9wcC5kZWYgYi90YXJn
ZXQvaGV4YWdvbi9pbXBvcnRlZC9lbmNvZGVfcHAuZGVmCmluZGV4IDc2M2Y0NjViZmQuLjBjZDMw
YTVlODUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2VuY29kZV9wcC5kZWYK
KysrIGIvdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvZW5jb2RlX3BwLmRlZgpAQCAtNTI0LDYgKzUy
NCw3IEBAIERFRl9GSUVMRDMyKElDTEFTU19KIiAxMTAtIC0tLS0tLS0tIFBQLSEtLS0tIC0tLS0t
LS0tIixKX1BULCJQcmVkaWN0LXRha2VuIikKIAogREVGX0ZJRUxEUk9XX0RFU0MzMihJQ0xBU1Nf
SiIgMDAwMCAtLS0tLS0tLSBQUC0tLS0tLSAtLS0tLS0tLSIsIlsjMF0gUEM9KFJzKSwgUjMxPXJl
dHVybiIpCiBERUZfRU5DMzIoSjJfY2FsbHIsICAgICBJQ0xBU1NfSiIgMDAwMCAgMTAxc3Nzc3Mg
IFBQLS0tLS0tICAtLS0tLS0tLSIpCitERUZfRU5DMzIoSjJfY2FsbHJoLCAgICBJQ0xBU1NfSiIg
MDAwMCAgMTEwc3Nzc3MgIFBQLS0tLS0tICAtLS0tLS0tLSIpCiAKIERFRl9GSUVMRFJPV19ERVND
MzIoSUNMQVNTX0oiIDAwMDEgLS0tLS0tLS0gUFAtLS0tLS0gLS0tLS0tLS0iLCJbIzFdIGlmIChQ
dSkgUEM9KFJzKSwgUjMxPXJldHVybiIpCiBERUZfRU5DMzIoSjJfY2FsbHJ0LCAgICBJQ0xBU1Nf
SiIgMDAwMSAgMDAwc3Nzc3MgIFBQLS0tLXV1ICAtLS0tLS0tLSIpCkBAIC01MzEsNiArNTMyLDcg
QEAgREVGX0VOQzMyKEoyX2NhbGxyZiwgICAgSUNMQVNTX0oiIDAwMDEgIDAwMXNzc3NzICBQUC0t
LS11dSAgLS0tLS0tLS0iKQogCiBERUZfRklFTERST1dfREVTQzMyKElDTEFTU19KIiAwMDEwIC0t
LS0tLS0tIFBQLS0tLS0tIC0tLS0tLS0tIiwiWyMyXSBQQz0oUnMpOyAiKQogREVGX0VOQzMyKEoy
X2p1bXByLCAgICAgIElDTEFTU19KIiAwMDEwICAxMDBzc3NzcyAgUFAtLS0tLS0gIC0tLS0tLS0t
IikKK0RFRl9FTkMzMihKMl9qdW1wcmgsICAgICBJQ0xBU1NfSiIgMDAxMCAgMTEwc3Nzc3MgIFBQ
LS0tLS0tICAtLS0tLS0tLSIpCiBERUZfRU5DMzIoSjRfaGludGp1bXByLCAgSUNMQVNTX0oiIDAw
MTAgIDEwMXNzc3NzICBQUC0tLS0tLSAgLS0tLS0tLS0iKQogCiBERUZfRklFTERST1dfREVTQzMy
KElDTEFTU19KIiAwMDExIC0tLS0tLS0tIFBQLS0tLS0tIC0tLS0tLS0tIiwiWyMzXSBpZiAoUHUp
IFBDPShScykgIikKLS0gCjIuMjUuMQoK

