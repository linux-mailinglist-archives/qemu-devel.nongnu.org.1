Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7907088FF
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 22:05:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzjrw-0000de-Hc; Thu, 18 May 2023 16:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjrZ-00008p-3J
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjrQ-00056p-PL
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:34 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34IJmVvt007224; Thu, 18 May 2023 20:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=lZlVs3q3iZ9gDzJEaWf1AguCNSammLdmyCpXTpWUU9w=;
 b=V7Q6QVKl+UdOGlKvkDRHnOCariatYELuCxImZyrAh4juGtSkS1fM2D/fLZonkEuOo87s
 INo++jXbVO67zP7r8AMIpvkT8uBPjF1MW8M+iXwNonKUN7PLX/IIV9L3ypKRQIoVQD/v
 4flydzU6ZzLkRQYswACWRqBWpfF+4P9RiOWXZhYlxL7pWxu9Qze3Pd5OhtvmQ+6kB2Ql
 HCUSiOp9ROwDwSpdYaQTUuMDJSSaP7neg2fcevw379WRQpBcnTzjm2HO4HmTXWjQ8L3p
 AKTixRkG0q9Hzsfi/7h+V97oCDVmGwbxaLhfYA73vlvGOZ0FZOIbl76V2tPlwnl63N2T Yg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qncbht1y4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:17 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34IK4Fj0013684; 
 Thu, 18 May 2023 20:04:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 3qmrx7jyxd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:15 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34IK4FoU013656;
 Thu, 18 May 2023 20:04:15 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-tsimpson-lv.qualcomm.com
 [10.47.204.221])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 34IK4EAu013610
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:15 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 47164)
 id 746E86D0; Thu, 18 May 2023 13:04:13 -0700 (PDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, bcain@quicinc.com, quic_mathbern@quicinc.com,
 stefanha@redhat.com, ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com
Subject: [PULL v2 15/44] Hexagon (target/hexagon) Remove log_reg_write from
 op_helper.[ch]
Date: Thu, 18 May 2023 13:03:42 -0700
Message-Id: <20230518200411.271148-16-tsimpson@quicinc.com>
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
X-Proofpoint-GUID: C4mhq9nsmaW1i9xkPw2gkkYm9SceyRZG
X-Proofpoint-ORIG-GUID: C4mhq9nsmaW1i9xkPw2gkkYm9SceyRZG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_15,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=558 classifier=spam adjust=0 reason=mlx
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

V2l0aCB0aGUgb3ZlcnJpZGVzIGFkZGVkIGluIHByaW9yIGNvbW1pdHMsIHRoaXMgZnVuY3Rpb24g
aXMgbm90IHVzZWQKUmVtb3ZlIHJlZmVyZW5jZXMgaW4gbWFjcm9zLmgKClNpZ25lZC1vZmYtYnk6
IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNvbT4KUmV2aWV3ZWQtYnk6IFJpY2hh
cmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPgpNZXNzYWdlLUlkOiA8
MjAyMzA0MjcyMzAwMTIuMzgwMDMyNy03LXRzaW1wc29uQHF1aWNpbmMuY29tPgotLS0KIHRhcmdl
dC9oZXhhZ29uL21hY3Jvcy5oICAgIHwgMTQgLS0tLS0tLS0tLS0tLS0KIHRhcmdldC9oZXhhZ29u
L29wX2hlbHBlci5oIHwgIDQgLS0tLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgfCAxNyAt
LS0tLS0tLS0tLS0tLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCAzNSBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9tYWNyb3MuaCBiL3RhcmdldC9oZXhhZ29uL21hY3Jvcy5o
CmluZGV4IGIxZmY0MGM4OTQuLjk5NWFlMGUzODQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29u
L21hY3Jvcy5oCisrKyBiL3RhcmdldC9oZXhhZ29uL21hY3Jvcy5oCkBAIC0zNDMsMTAgKzM0Myw2
IEBAIHN0YXRpYyBpbmxpbmUgVENHdiBnZW5fcmVhZF9pcmVnKFRDR3YgcmVzdWx0LCBUQ0d2IHZh
bCwgaW50IHNoaWZ0KQogCiAjZGVmaW5lIGZSRUFEX0xSKCkgKGVudi0+Z3ByW0hFWF9SRUdfTFJd
KQogCi0jZGVmaW5lIGZXUklURV9MUihBKSBsb2dfcmVnX3dyaXRlKGVudiwgSEVYX1JFR19MUiwg
QSkKLSNkZWZpbmUgZldSSVRFX0ZQKEEpIGxvZ19yZWdfd3JpdGUoZW52LCBIRVhfUkVHX0ZQLCBB
KQotI2RlZmluZSBmV1JJVEVfU1AoQSkgbG9nX3JlZ193cml0ZShlbnYsIEhFWF9SRUdfU1AsIEEp
Ci0KICNkZWZpbmUgZlJFQURfU1AoKSAoZW52LT5ncHJbSEVYX1JFR19TUF0pCiAjZGVmaW5lIGZS
RUFEX0xDMCAoZW52LT5ncHJbSEVYX1JFR19MQzBdKQogI2RlZmluZSBmUkVBRF9MQzEgKGVudi0+
Z3ByW0hFWF9SRUdfTEMxXSkKQEAgLTM3MSwxNiArMzY3LDYgQEAgc3RhdGljIGlubGluZSBUQ0d2
IGdlbl9yZWFkX2lyZWcoVENHdiByZXN1bHQsIFRDR3YgdmFsLCBpbnQgc2hpZnQpCiAjZGVmaW5l
IGZCUkFOQ0goTE9DLCBUWVBFKSAgICAgICAgICBmV1JJVEVfTlBDKExPQykKICNkZWZpbmUgZkpV
TVBSKFJFR05PLCBUQVJHRVQsIFRZUEUpIGZCUkFOQ0goVEFSR0VULCBDT0ZfVFlQRV9KVU1QUikK
ICNkZWZpbmUgZkhJTlRKUihUQVJHRVQpIHsgLyogTm90IG1vZGVsbGVkIGluIHFlbXUgKi99Ci0j
ZGVmaW5lIGZXUklURV9MT09QX1JFR1MwKFNUQVJULCBDT1VOVCkgXAotICAgIGRvIHsgXAotICAg
ICAgICBsb2dfcmVnX3dyaXRlKGVudiwgSEVYX1JFR19MQzAsIENPVU5UKTsgIFwKLSAgICAgICAg
bG9nX3JlZ193cml0ZShlbnYsIEhFWF9SRUdfU0EwLCBTVEFSVCk7IFwKLSAgICB9IHdoaWxlICgw
KQotI2RlZmluZSBmV1JJVEVfTE9PUF9SRUdTMShTVEFSVCwgQ09VTlQpIFwKLSAgICBkbyB7IFwK
LSAgICAgICAgbG9nX3JlZ193cml0ZShlbnYsIEhFWF9SRUdfTEMxLCBDT1VOVCk7ICBcCi0gICAg
ICAgIGxvZ19yZWdfd3JpdGUoZW52LCBIRVhfUkVHX1NBMSwgU1RBUlQpO1wKLSAgICB9IHdoaWxl
ICgwKQogCiAjZGVmaW5lIGZTRVRfT1ZFUkZMT1coKSBTRVRfVVNSX0ZJRUxEKFVTUl9PVkYsIDEp
CiAjZGVmaW5lIGZTRVRfTFBDRkcoVkFMKSBTRVRfVVNSX0ZJRUxEKFVTUl9MUENGRywgKFZBTCkp
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuaCBiL3RhcmdldC9oZXhhZ29u
L29wX2hlbHBlci5oCmluZGV4IGRiMjJiNTQ0MDEuLjZiZDRiMDc4NDkgMTAwNjQ0Ci0tLSBhL3Rh
cmdldC9oZXhhZ29uL29wX2hlbHBlci5oCisrKyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5o
CkBAIC0xOSwxNSArMTksMTEgQEAKICNkZWZpbmUgSEVYQUdPTl9PUF9IRUxQRVJfSAogCiAvKiBN
aXNjIGZ1bmN0aW9ucyAqLwotdm9pZCB3cml0ZV9uZXdfcGMoQ1BVSGV4YWdvblN0YXRlICplbnYs
IGJvb2wgcGt0X2hhc19tdWx0aV9jb2YsIHRhcmdldF91bG9uZyBhZGRyKTsKLQogdWludDhfdCBt
ZW1fbG9hZDEoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHNsb3QsIHRhcmdldF91bG9u
ZyB2YWRkcik7CiB1aW50MTZfdCBtZW1fbG9hZDIoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQz
Ml90IHNsb3QsIHRhcmdldF91bG9uZyB2YWRkcik7CiB1aW50MzJfdCBtZW1fbG9hZDQoQ1BVSGV4
YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHNsb3QsIHRhcmdldF91bG9uZyB2YWRkcik7CiB1aW50
NjRfdCBtZW1fbG9hZDgoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHNsb3QsIHRhcmdl
dF91bG9uZyB2YWRkcik7CiAKLXZvaWQgbG9nX3JlZ193cml0ZShDUFVIZXhhZ29uU3RhdGUgKmVu
diwgaW50IHJudW0sCi0gICAgICAgICAgICAgICAgICAgdGFyZ2V0X3Vsb25nIHZhbCk7CiB2b2lk
IGxvZ19zdG9yZTY0KENQVUhleGFnb25TdGF0ZSAqZW52LCB0YXJnZXRfdWxvbmcgYWRkciwKICAg
ICAgICAgICAgICAgICAgaW50NjRfdCB2YWwsIGludCB3aWR0aCwgaW50IHNsb3QpOwogdm9pZCBs
b2dfc3RvcmUzMihDUFVIZXhhZ29uU3RhdGUgKmVudiwgdGFyZ2V0X3Vsb25nIGFkZHIsCmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hl
bHBlci5jCmluZGV4IDNjYzcxYjY5ZDkuLjdlOWUzZjMwNWUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9o
ZXhhZ29uL29wX2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCkBAIC01
MiwyMyArNTIsNiBAQCBHX05PUkVUVVJOIHZvaWQgSEVMUEVSKHJhaXNlX2V4Y2VwdGlvbikoQ1BV
SGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IGV4Y3ApCiAgICAgZG9fcmFpc2VfZXhjZXB0aW9u
X2VycihlbnYsIGV4Y3AsIDApOwogfQogCi12b2lkIGxvZ19yZWdfd3JpdGUoQ1BVSGV4YWdvblN0
YXRlICplbnYsIGludCBybnVtLAotICAgICAgICAgICAgICAgICAgIHRhcmdldF91bG9uZyB2YWwp
Ci17Ci0gICAgSEVYX0RFQlVHX0xPRygibG9nX3JlZ193cml0ZVslZF0gPSAiIFRBUkdFVF9GTVRf
bGQgIiAoMHgiIFRBUkdFVF9GTVRfbHggIikiLAotICAgICAgICAgICAgICAgICAgcm51bSwgdmFs
LCB2YWwpOwotICAgIGlmICh2YWwgPT0gZW52LT5ncHJbcm51bV0pIHsKLSAgICAgICAgSEVYX0RF
QlVHX0xPRygiIE5PIENIQU5HRSIpOwotICAgIH0KLSAgICBIRVhfREVCVUdfTE9HKCJcbiIpOwot
Ci0gICAgZW52LT5uZXdfdmFsdWVbcm51bV0gPSB2YWw7Ci0gICAgaWYgKEhFWF9ERUJVRykgewot
ICAgICAgICAvKiBEbyB0aGlzIHNvIEhFTFBFUihkZWJ1Z19jb21taXRfZW5kKSB3aWxsIGtub3cg
Ki8KLSAgICAgICAgZW52LT5yZWdfd3JpdHRlbltybnVtXSA9IDE7Ci0gICAgfQotfQotCiBzdGF0
aWMgdm9pZCBsb2dfcHJlZF93cml0ZShDUFVIZXhhZ29uU3RhdGUgKmVudiwgaW50IHBudW0sIHRh
cmdldF91bG9uZyB2YWwpCiB7CiAgICAgSEVYX0RFQlVHX0xPRygibG9nX3ByZWRfd3JpdGVbJWRd
ID0gIiBUQVJHRVRfRk1UX2xkCi0tIAoyLjI1LjEKCg==

