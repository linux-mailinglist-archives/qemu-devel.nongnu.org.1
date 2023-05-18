Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C8D70891D
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 22:09:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzjrw-0000dO-Fb; Thu, 18 May 2023 16:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjri-0000FL-Qa
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjrS-000580-Bw
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:46 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34IK2MbC032357; Thu, 18 May 2023 20:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=k1mjpLspw5jPgrQMfZRWhKkGn9H0UBWrTAPv3Mh8xRE=;
 b=igujW+kRUpT9yk5Rmnd8klqI8EX5CwP0+kaPzfRXYJl0h4J1DomAAKVjjo+aFVF8tmcA
 2HtTRzqyUEAvsOQ2sw+hpqiZjP8nzzKnNDIKsfrh97539puhA1YD7AVLFRU3C/xBcx8S
 FtD+n9UZHa+ZuQ1EYMpZUWhvo1kmZSxBSxUSI9i6KHmUIHEyijpnxcvI6LUC3/CmqwkH
 cHpxr5uxIzHMZF5kDKWeb3axYIdl8aBE/SfzgkRovHXne/GA0Ma5CzJmxhj5YMQ/DEeX
 PnR11RmOK+2JP9TcFAkbQGwyhDZEuYD8BJ/LKJoqYMCd7OJzqmdpeNj8X7aspTOgGZSM Dg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qncbht1y8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:18 +0000
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34IK4HHE001268; 
 Thu, 18 May 2023 20:04:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 3qj3mn248d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:17 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34IK4D0l001141;
 Thu, 18 May 2023 20:04:17 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-tsimpson-lv.qualcomm.com
 [10.47.204.221])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 34IK4FPn001185
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:17 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 47164)
 id 99E606DD; Thu, 18 May 2023 13:04:13 -0700 (PDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, bcain@quicinc.com, quic_mathbern@quicinc.com,
 stefanha@redhat.com, ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com
Subject: [PULL v2 28/44] Hexagon (target/hexagon) Move pred_written to
 DisasContext
Date: Thu, 18 May 2023 13:03:55 -0700
Message-Id: <20230518200411.271148-29-tsimpson@quicinc.com>
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
X-Proofpoint-GUID: 4hvCUDw3_QKzNuiBI8ldmUaFp9HV9ZZ3
X-Proofpoint-ORIG-GUID: 4hvCUDw3_QKzNuiBI8ldmUaFp9HV9ZZ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_15,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=728 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305180165
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

VGhlIHByZWRfd3JpdHRlbiB2YXJpYWJsZSBpbiB0aGUgQ1BVSGV4YWdvblN0YXRlIGlzIG9ubHkg
dXNlZCBmb3IKYm9va2tlZXBpbmcgd2l0aGluIHRoZSB0cmFuc2xhdGlvbiBvZiBhIHBhY2tldC4g
IFdpdGggcmVjZW50IGNoYW5nZXMKdGhhdCBlbGltaW5hdGUgdGhlIG5lZWQgdG8gZnJlZSBUQ0d2
IHZhcmlhYmxlcywgdGhlc2UgbWFrZSBtb3JlIHNlbnNlCnRvIGJlIHRyYW5zaWVudCBhbmQga2Vw
dCBpbiBEaXNhc0NvbnRleHQuCgpTdWdnZXN0ZWQtYnk6IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNo
YXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPgpTaWduZWQtb2ZmLWJ5OiBUYXlsb3IgU2ltcHNvbiA8
dHNpbXBzb25AcXVpY2luYy5jb20+ClJldmlld2VkLWJ5OiBSaWNoYXJkIEhlbmRlcnNvbiA8cmlj
aGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4KTWVzc2FnZS1JZDogPDIwMjMwNDI3MjMwMDEyLjM4
MDAzMjctMjAtdHNpbXBzb25AcXVpY2luYy5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vY3B1Lmgg
ICAgICAgfCAyIC0tCiB0YXJnZXQvaGV4YWdvbi9oZWxwZXIuaCAgICB8IDIgKy0KIHRhcmdldC9o
ZXhhZ29uL3RyYW5zbGF0ZS5oIHwgMiArLQogdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMgICAgfCAy
ICstCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyB8IDUgKysrLS0KIHRhcmdldC9oZXhhZ29u
L3RyYW5zbGF0ZS5jIHwgOSArKysrLS0tLS0KIDYgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9u
cygrKSwgMTIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1Lmgg
Yi90YXJnZXQvaGV4YWdvbi9jcHUuaAppbmRleCAyYjRmNzdmYjhlLi43NjczZjlmMzJkIDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuaApA
QCAtOTgsOCArOTgsNiBAQCB0eXBlZGVmIHN0cnVjdCBDUFVBcmNoU3RhdGUgewogICAgIHRhcmdl
dF91bG9uZyB0aGlzX1BDOwogICAgIHRhcmdldF91bG9uZyByZWdfd3JpdHRlbltUT1RBTF9QRVJf
VEhSRUFEX1JFR1NdOwogCi0gICAgdGFyZ2V0X3Vsb25nIHByZWRfd3JpdHRlbjsKLQogICAgIE1l
bUxvZyBtZW1fbG9nX3N0b3Jlc1tTVE9SRVNfTUFYXTsKICAgICB0YXJnZXRfdWxvbmcgcGt0X2hh
c19zdG9yZV9zMTsKICAgICB0YXJnZXRfdWxvbmcgZGN6ZXJvX2FkZHI7CmRpZmYgLS1naXQgYS90
YXJnZXQvaGV4YWdvbi9oZWxwZXIuaCBiL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCmluZGV4IDRi
NzUwZDAzNTEuLmYzYjI5OGJlZWUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5o
CisrKyBiL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCkBAIC0yMSw3ICsyMSw3IEBACiBERUZfSEVM
UEVSX0ZMQUdTXzIocmFpc2VfZXhjZXB0aW9uLCBUQ0dfQ0FMTF9OT19SRVRVUk4sIG5vcmV0dXJu
LCBlbnYsIGkzMikKIERFRl9IRUxQRVJfMShkZWJ1Z19zdGFydF9wYWNrZXQsIHZvaWQsIGVudikK
IERFRl9IRUxQRVJfRkxBR1NfMyhkZWJ1Z19jaGVja19zdG9yZV93aWR0aCwgVENHX0NBTExfTk9f
V0csIHZvaWQsIGVudiwgaW50LCBpbnQpCi1ERUZfSEVMUEVSX0ZMQUdTXzMoZGVidWdfY29tbWl0
X2VuZCwgVENHX0NBTExfTk9fV0csIHZvaWQsIGVudiwgaW50LCBpbnQpCitERUZfSEVMUEVSX0ZM
QUdTXzQoZGVidWdfY29tbWl0X2VuZCwgVENHX0NBTExfTk9fV0csIHZvaWQsIGVudiwgaW50LCBp
bnQsIGludCkKIERFRl9IRUxQRVJfMihjb21taXRfc3RvcmUsIHZvaWQsIGVudiwgaW50KQogREVG
X0hFTFBFUl8zKGdhdGhlcl9zdG9yZSwgdm9pZCwgZW52LCBpMzIsIGludCkKIERFRl9IRUxQRVJf
MShjb21taXRfaHZ4X3N0b3Jlcywgdm9pZCwgZW52KQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFn
b24vdHJhbnNsYXRlLmggYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAppbmRleCBmZGZhMWI2
ZmUzLi5hOWYxY2NlZTI0IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAor
KysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaApAQCAtNzEsNiArNzEsNyBAQCB0eXBlZGVm
IHN0cnVjdCBEaXNhc0NvbnRleHQgewogICAgIGJvb2wgaGFzX2h2eF9oZWxwZXI7CiAgICAgVENH
diBuZXdfdmFsdWVbVE9UQUxfUEVSX1RIUkVBRF9SRUdTXTsKICAgICBUQ0d2IG5ld19wcmVkX3Zh
bHVlW05VTV9QUkVHU107CisgICAgVENHdiBwcmVkX3dyaXR0ZW47CiB9IERpc2FzQ29udGV4dDsK
IAogc3RhdGljIGlubGluZSB2b2lkIGN0eF9sb2dfcHJlZF93cml0ZShEaXNhc0NvbnRleHQgKmN0
eCwgaW50IHBudW0pCkBAIC0xOTQsNyArMTk1LDYgQEAgZXh0ZXJuIFRDR3YgaGV4X3Nsb3RfY2Fu
Y2VsbGVkOwogZXh0ZXJuIFRDR3YgaGV4X2JyYW5jaF90YWtlbjsKIGV4dGVybiBUQ0d2IGhleF9u
ZXdfdmFsdWVfdXNyOwogZXh0ZXJuIFRDR3YgaGV4X3JlZ193cml0dGVuW1RPVEFMX1BFUl9USFJF
QURfUkVHU107Ci1leHRlcm4gVENHdiBoZXhfcHJlZF93cml0dGVuOwogZXh0ZXJuIFRDR3YgaGV4
X3N0b3JlX2FkZHJbU1RPUkVTX01BWF07CiBleHRlcm4gVENHdiBoZXhfc3RvcmVfd2lkdGhbU1RP
UkVTX01BWF07CiBleHRlcm4gVENHdiBoZXhfc3RvcmVfdmFsMzJbU1RPUkVTX01BWF07CmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyBiL3RhcmdldC9oZXhhZ29uL2dlbnB0ci5j
CmluZGV4IDFmNjlmNGY5MjIuLjc4NTc3ODc1OWUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29u
L2dlbnB0ci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2dlbnB0ci5jCkBAIC0xNTEsNyArMTUxLDcg
QEAgdm9pZCBnZW5fbG9nX3ByZWRfd3JpdGUoRGlzYXNDb250ZXh0ICpjdHgsIGludCBwbnVtLCBU
Q0d2IHZhbCkKICAgICAgICAgdGNnX2dlbl9hbmRfdGwocHJlZCwgcHJlZCwgYmFzZV92YWwpOwog
ICAgIH0KICAgICBpZiAoSEVYX0RFQlVHKSB7Ci0gICAgICAgIHRjZ19nZW5fb3JpX3RsKGhleF9w
cmVkX3dyaXR0ZW4sIGhleF9wcmVkX3dyaXR0ZW4sIDEgPDwgcG51bSk7CisgICAgICAgIHRjZ19n
ZW5fb3JpX3RsKGN0eC0+cHJlZF93cml0dGVuLCBjdHgtPnByZWRfd3JpdHRlbiwgMSA8PCBwbnVt
KTsKICAgICB9CiAgICAgc2V0X2JpdChwbnVtLCBjdHgtPnByZWdzX3dyaXR0ZW4pOwogfQpkaWZm
IC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQvaGV4YWdvbi9vcF9o
ZWxwZXIuYwppbmRleCAyNmZiYTlmNWQ2Li5mOTAyMWVmYzdlIDEwMDY0NAotLS0gYS90YXJnZXQv
aGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAt
MjAzLDcgKzIwMyw4IEBAIHN0YXRpYyB2b2lkIHByaW50X3N0b3JlKENQVUhleGFnb25TdGF0ZSAq
ZW52LCBpbnQgc2xvdCkKIH0KIAogLyogVGhpcyBmdW5jdGlvbiBpcyBhIGhhbmR5IHBsYWNlIHRv
IHNldCBhIGJyZWFrcG9pbnQgKi8KLXZvaWQgSEVMUEVSKGRlYnVnX2NvbW1pdF9lbmQpKENQVUhl
eGFnb25TdGF0ZSAqZW52LCBpbnQgaGFzX3N0MCwgaW50IGhhc19zdDEpCit2b2lkIEhFTFBFUihk
ZWJ1Z19jb21taXRfZW5kKShDUFVIZXhhZ29uU3RhdGUgKmVudiwKKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGludCBwcmVkX3dyaXR0ZW4sIGludCBoYXNfc3QwLCBpbnQgaGFzX3N0MSkK
IHsKICAgICBib29sIHJlZ19wcmludGVkID0gZmFsc2U7CiAgICAgYm9vbCBwcmVkX3ByaW50ZWQg
PSBmYWxzZTsKQEAgLTIyNSw3ICsyMjYsNyBAQCB2b2lkIEhFTFBFUihkZWJ1Z19jb21taXRfZW5k
KShDUFVIZXhhZ29uU3RhdGUgKmVudiwgaW50IGhhc19zdDAsIGludCBoYXNfc3QxKQogICAgIH0K
IAogICAgIGZvciAoaSA9IDA7IGkgPCBOVU1fUFJFR1M7IGkrKykgewotICAgICAgICBpZiAoZW52
LT5wcmVkX3dyaXR0ZW4gJiAoMSA8PCBpKSkgeworICAgICAgICBpZiAocHJlZF93cml0dGVuICYg
KDEgPDwgaSkpIHsKICAgICAgICAgICAgIGlmICghcHJlZF9wcmludGVkKSB7CiAgICAgICAgICAg
ICAgICAgSEVYX0RFQlVHX0xPRygiUHJlZGljYXRlcyB3cml0dGVuXG4iKTsKICAgICAgICAgICAg
ICAgICBwcmVkX3ByaW50ZWQgPSB0cnVlOwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vdHJh
bnNsYXRlLmMgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwppbmRleCA0NTlhYWNlOTIxLi5h
NTg1Y2M4Y2ZkIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYworKysgYi90
YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwpAQCAtNDYsNyArNDYsNiBAQCBUQ0d2IGhleF9zbG90
X2NhbmNlbGxlZDsKIFRDR3YgaGV4X2JyYW5jaF90YWtlbjsKIFRDR3YgaGV4X25ld192YWx1ZV91
c3I7CiBUQ0d2IGhleF9yZWdfd3JpdHRlbltUT1RBTF9QRVJfVEhSRUFEX1JFR1NdOwotVENHdiBo
ZXhfcHJlZF93cml0dGVuOwogVENHdiBoZXhfc3RvcmVfYWRkcltTVE9SRVNfTUFYXTsKIFRDR3Yg
aGV4X3N0b3JlX3dpZHRoW1NUT1JFU19NQVhdOwogVENHdiBoZXhfc3RvcmVfdmFsMzJbU1RPUkVT
X01BWF07CkBAIC01NDksNyArNTQ4LDggQEAgc3RhdGljIHZvaWQgZ2VuX3N0YXJ0X3BhY2tldChE
aXNhc0NvbnRleHQgKmN0eCkKICAgICAgICAgfQogICAgIH0KICAgICBpZiAoSEVYX0RFQlVHKSB7
Ci0gICAgICAgIHRjZ19nZW5fbW92aV90bChoZXhfcHJlZF93cml0dGVuLCAwKTsKKyAgICAgICAg
Y3R4LT5wcmVkX3dyaXR0ZW4gPSB0Y2dfdGVtcF9uZXcoKTsKKyAgICAgICAgdGNnX2dlbl9tb3Zp
X3RsKGN0eC0+cHJlZF93cml0dGVuLCAwKTsKICAgICB9CiAKICAgICAvKiBQcmVsb2FkIHRoZSBw
cmVkaWNhdGVkIHJlZ2lzdGVycyBpbnRvIGdldF9yZXN1bHRfZ3ByKGN0eCwgaSkgKi8KQEAgLTEw
MDcsNyArMTAwNyw4IEBAIHN0YXRpYyB2b2lkIGdlbl9jb21taXRfcGFja2V0KERpc2FzQ29udGV4
dCAqY3R4KQogICAgICAgICAgICAgdGNnX2NvbnN0YW50X3RsKHBrdC0+cGt0X2hhc19zdG9yZV9z
MSAmJiAhcGt0LT5wa3RfaGFzX2RjemVyb2EpOwogCiAgICAgICAgIC8qIEhhbmR5IHBsYWNlIHRv
IHNldCBhIGJyZWFrcG9pbnQgYXQgdGhlIGVuZCBvZiBleGVjdXRpb24gKi8KLSAgICAgICAgZ2Vu
X2hlbHBlcl9kZWJ1Z19jb21taXRfZW5kKGNwdV9lbnYsIGhhc19zdDAsIGhhc19zdDEpOworICAg
ICAgICBnZW5faGVscGVyX2RlYnVnX2NvbW1pdF9lbmQoY3B1X2VudiwgY3R4LT5wcmVkX3dyaXR0
ZW4sCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBoYXNfc3QwLCBoYXNfc3Qx
KTsKICAgICB9CiAKICAgICBpZiAocGt0LT52aGlzdF9pbnNuICE9IE5VTEwpIHsKQEAgLTEyMDAs
OCArMTIwMSw2IEBAIHZvaWQgaGV4YWdvbl90cmFuc2xhdGVfaW5pdCh2b2lkKQogICAgICAgICAg
ICAgb2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRlLCBwcmVkW2ldKSwKICAgICAgICAgICAgIGhleGFn
b25fcHJlZG5hbWVzW2ldKTsKICAgICB9Ci0gICAgaGV4X3ByZWRfd3JpdHRlbiA9IHRjZ19nbG9i
YWxfbWVtX25ldyhjcHVfZW52LAotICAgICAgICBvZmZzZXRvZihDUFVIZXhhZ29uU3RhdGUsIHBy
ZWRfd3JpdHRlbiksICJwcmVkX3dyaXR0ZW4iKTsKICAgICBoZXhfdGhpc19QQyA9IHRjZ19nbG9i
YWxfbWVtX25ldyhjcHVfZW52LAogICAgICAgICBvZmZzZXRvZihDUFVIZXhhZ29uU3RhdGUsIHRo
aXNfUEMpLCAidGhpc19QQyIpOwogICAgIGhleF9zbG90X2NhbmNlbGxlZCA9IHRjZ19nbG9iYWxf
bWVtX25ldyhjcHVfZW52LAotLSAKMi4yNS4xCgo=

