Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFC47088FA
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 22:05:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzjrb-0008Ur-Lt; Thu, 18 May 2023 16:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjrL-0008Sv-2I
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjrJ-00058J-3d
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:22 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34IK4JjG002076; Thu, 18 May 2023 20:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2Hmdz411SWjv7pWuRPjFp5tE58zEPOVD40fQ2PKKY8c=;
 b=GMasGoEyCrDr5e/A/RwMoQGr8z6yjaFS/aHk8el28n7XxgUH71IR3/FZfYwhNYr47NAs
 VZLqrOD8xxjhO83qbuUmuYpN2KkQjNC51ipaWUNgOz3n2otN9/lYV0+6YOGY2e4z8eQf
 nN0IaF5JUFxvSIUnfF4HWorRIjjNX9fNbNgcwMq7ZW643TP7z7xfv0ClpOLQFaf4SmLO
 TP6Ppaacu7owoPaWQl4EVw5jjCvmykufoWYVpPXwVwltgtS8ESzqpRyxGLou6BiQZfiE
 pJiuPNaiSPQtmmoZ19dBtLrO6vjL57xlLHNFFOQJ9mdydnkvI54MN75c8w+lIlC4t9QG aA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qn3fsk1mj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:18 +0000
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34IK4Gr7003848; 
 Thu, 18 May 2023 20:04:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 3qnstj08fm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:16 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34IK0BAr028619;
 Thu, 18 May 2023 20:04:16 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-tsimpson-lv.qualcomm.com
 [10.47.204.221])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 34IK4FbT003779
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:16 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 47164)
 id A56AF6E1; Thu, 18 May 2023 13:04:13 -0700 (PDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, bcain@quicinc.com, quic_mathbern@quicinc.com,
 stefanha@redhat.com, ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v2 32/44] target/hexagon: fix = vs. == mishap
Date: Thu, 18 May 2023 13:03:59 -0700
Message-Id: <20230518200411.271148-33-tsimpson@quicinc.com>
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
X-Proofpoint-ORIG-GUID: gzxtfAbJFqy3rxQTr3T25u-wrMHfbjm8
X-Proofpoint-GUID: gzxtfAbJFqy3rxQTr3T25u-wrMHfbjm8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_15,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 impostorscore=0 mlxlogscore=786 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180166
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

RnJvbTogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4KCioqKiogQ2hhbmdlcyBp
biB2MiAqKioqCkZpeCB5eWFzc2VydCdzIGZvciBzaWduIGFuZCB6ZXJvIGV4dGVuZHMKCkNvdmVy
aXR5IHJlcG9ydHMgYSBwYXJhbWV0ZXIgdGhhdCBpcyAic2V0IGJ1dCBuZXZlciB1c2VkIi4gIFRo
aXMgaXMgY2F1c2VkCmJ5IGFuIGFzc2lnbm1lbnQgb3BlcmF0b3IgYmVpbmcgdXNlZCBpbnN0ZWFk
IG9mIGVxdWFsaXR5LgoKQ28tYXV0aG9yZWQtYnk6IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBx
dWljaW5jLmNvbT4KU2lnbmVkLW9mZi1ieTogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0
LmNvbT4KU2lnbmVkLW9mZi1ieTogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29t
PgpSZXZpZXdlZC1ieTogQW50b24gSm9oYW5zc29uIDxhbmpvQHJldi5uZz4KVGVzdGVkLWJ5OiBB
bnRvbiBKb2hhbnNzb24gPGFuam9AcmV2Lm5nPgpNZXNzYWdlLUlkOiA8MjAyMzA0MjgyMDQ0MTEu
MTQwMDkzMS0xLXRzaW1wc29uQHF1aWNpbmMuY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2lkZWYt
cGFyc2VyL3BhcnNlci1oZWxwZXJzLmMgfCAyICstCiB0YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNl
ci9pZGVmLXBhcnNlci55ICAgIHwgNCArKy0tCiAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9pZGVmLXBh
cnNlci9wYXJzZXItaGVscGVycy5jIGIvdGFyZ2V0L2hleGFnb24vaWRlZi1wYXJzZXIvcGFyc2Vy
LWhlbHBlcnMuYwppbmRleCA5NTUwMDk3MjY5Li43YjVlYmFmZWMyIDEwMDY0NAotLS0gYS90YXJn
ZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9wYXJzZXItaGVscGVycy5jCisrKyBiL3RhcmdldC9oZXhh
Z29uL2lkZWYtcGFyc2VyL3BhcnNlci1oZWxwZXJzLmMKQEAgLTExMjAsNyArMTEyMCw3IEBAIEhl
eFZhbHVlIGdlbl9leHRlbmRfb3AoQ29udGV4dCAqYywKICAgICAgICAgICAgICAgICAgICAgICAg
SGV4VmFsdWUgKnZhbHVlLAogICAgICAgICAgICAgICAgICAgICAgICBIZXhTaWduZWRuZXNzIHNp
Z25lZG5lc3MpCiB7Ci0gICAgdW5zaWduZWQgYml0X3dpZHRoID0gKGRzdF93aWR0aCA9IDY0KSA/
IDY0IDogMzI7CisgICAgdW5zaWduZWQgYml0X3dpZHRoID0gKGRzdF93aWR0aCA9PSA2NCkgPyA2
NCA6IDMyOwogICAgIEhleFZhbHVlIHZhbHVlX20gPSAqdmFsdWU7CiAgICAgSGV4VmFsdWUgc3Jj
X3dpZHRoX20gPSAqc3JjX3dpZHRoOwogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9pZGVm
LXBhcnNlci9pZGVmLXBhcnNlci55IGIvdGFyZ2V0L2hleGFnb24vaWRlZi1wYXJzZXIvaWRlZi1w
YXJzZXIueQppbmRleCA1ZjM5MDdlYjI4Li41Yzk4Mzk1NGVkIDEwMDY0NAotLS0gYS90YXJnZXQv
aGV4YWdvbi9pZGVmLXBhcnNlci9pZGVmLXBhcnNlci55CisrKyBiL3RhcmdldC9oZXhhZ29uL2lk
ZWYtcGFyc2VyL2lkZWYtcGFyc2VyLnkKQEAgLTY4Myw3ICs2ODMsNyBAQCBydmFsdWUgOiBGQUlM
CiAgICAgICAgICAgICAgeXlhc3NlcnQoYywgJkAxLCAkNS50eXBlID09IElNTUVESUFURSAmJgog
ICAgICAgICAgICAgICAgICAgICAgICQ1LmltbS50eXBlID09IFZBTFVFLAogICAgICAgICAgICAg
ICAgICAgICAgICJTWFQgZXhwZWN0cyBpbW1lZGlhdGUgdmFsdWVzXG4iKTsKLSAgICAgICAgICAg
ICAkJCA9IGdlbl9leHRlbmRfb3AoYywgJkAxLCAmJDMsICQ1LmltbS52YWx1ZSwgJiQ3LCBTSUdO
RUQpOworICAgICAgICAgICAgICQkID0gZ2VuX2V4dGVuZF9vcChjLCAmQDEsICYkMywgNjQsICYk
NywgU0lHTkVEKTsKICAgICAgICAgIH0KICAgICAgICB8IFpYVCAnKCcgcnZhbHVlICcsJyBJTU0g
JywnIHJ2YWx1ZSAnKScKICAgICAgICAgIHsKQEAgLTY5MSw3ICs2OTEsNyBAQCBydmFsdWUgOiBG
QUlMCiAgICAgICAgICAgICAgeXlhc3NlcnQoYywgJkAxLCAkNS50eXBlID09IElNTUVESUFURSAm
JgogICAgICAgICAgICAgICAgICAgICAgICQ1LmltbS50eXBlID09IFZBTFVFLAogICAgICAgICAg
ICAgICAgICAgICAgICJaWFQgZXhwZWN0cyBpbW1lZGlhdGUgdmFsdWVzXG4iKTsKLSAgICAgICAg
ICAgICAkJCA9IGdlbl9leHRlbmRfb3AoYywgJkAxLCAmJDMsICQ1LmltbS52YWx1ZSwgJiQ3LCBV
TlNJR05FRCk7CisgICAgICAgICAgICAgJCQgPSBnZW5fZXh0ZW5kX29wKGMsICZAMSwgJiQzLCA2
NCwgJiQ3LCBVTlNJR05FRCk7CiAgICAgICAgICB9CiAgICAgICAgfCAnKCcgcnZhbHVlICcpJwog
ICAgICAgICAgewotLSAKMi4yNS4xCgo=

