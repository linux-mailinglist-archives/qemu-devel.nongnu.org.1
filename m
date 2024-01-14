Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C1C82D29E
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 00:46:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPAAG-0003X8-Dz; Sun, 14 Jan 2024 18:45:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rPAAE-0003Ws-Bi
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 18:45:14 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rPAAC-0006ng-8q
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 18:45:14 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40ENUVUw023944; Sun, 14 Jan 2024 23:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:mime-version:content-type
 :content-transfer-encoding; s=qcppdkim1; bh=g+BLs7JcrxxPDqLBfXVt
 iL5D26+lGpsjpTwKgc8Oo9s=; b=ZxeigbQww9soFvhjfzFPFbsVmx+dXIl9zPEE
 Zyr7v78SuzxYyi224P3CYcHAUt0QNccSomRUYffzeXsvh5c+Dc69UeW4/IXehg8T
 UjiwrPT/TQd/FXEdsnWJ290blC6PpIAzUK5D/shtamtjDivSDi/Dgv3UCF9jbz1v
 Zx8asAHHUaozPWZwgzrO1yAwlMQzPArk3mnzP7K76SblpGivQ5nROosdv5xPXoGQ
 TdC5qbogP3023MJAGJ132k7wV4ohXz8tUA/5+XqwTa3XOBbA4rYzx6sgu3/mnK0d
 NllWKtpnOdnR9L+iE7h8nNjlVpFWoxKMjhC+6Fj8cmBXjOUd+g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vkmjc2872-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 14 Jan 2024 23:45:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ENj6Ef019174
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 14 Jan 2024 23:45:06 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 14 Jan 2024 15:45:05 -0800
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <quic_mathbern@quicinc.com>, <ale@rev.ng>,
 <anjo@rev.ng>, <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>,
 <peter.maydell@linaro.org>
Subject: [PATCH] Reduce scope of def_regnum, remove dead assignment
Date: Sun, 14 Jan 2024 15:44:53 -0800
Message-ID: <20240114234453.4114587-1-bcain@quicinc.com>
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
X-Proofpoint-GUID: bJJEcwDofUmrmzJ1toGUnTpEW5GDNxf7
X-Proofpoint-ORIG-GUID: bJJEcwDofUmrmzJ1toGUnTpEW5GDNxf7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 mlxlogscore=457
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401140186
Received-SPF: pass client-ip=205.220.168.131; envelope-from=bcain@quicinc.com;
 helo=mx0a-0031df01.pphosted.com
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

VGhpcyBpcyBpbnRlbmRlZCB0byBhZGRyZXNzIGEgY292ZXJpdHkgZmluZGluZzogQ0lEIDE1Mjc0
MDguCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4KLS0tCiB0
YXJnZXQvaGV4YWdvbi9tbXZlYy9kZWNvZGVfZXh0X21tdmVjLmMgfCA0ICstLS0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJn
ZXQvaGV4YWdvbi9tbXZlYy9kZWNvZGVfZXh0X21tdmVjLmMgYi90YXJnZXQvaGV4YWdvbi9tbXZl
Yy9kZWNvZGVfZXh0X21tdmVjLmMKaW5kZXggMTc0ZWIzYjc4Yi4uMjAyZDg0YzdjMCAxMDA2NDQK
LS0tIGEvdGFyZ2V0L2hleGFnb24vbW12ZWMvZGVjb2RlX2V4dF9tbXZlYy5jCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL21tdmVjL2RlY29kZV9leHRfbW12ZWMuYwpAQCAtMzMsNyArMzMsNiBAQCBjaGVj
a19uZXdfdmFsdWUoUGFja2V0ICpwa3QpCiAgICAgY29uc3QgY2hhciAqZHN0c3RyID0gTlVMTDsK
ICAgICB1aW50MTZfdCBkZWZfb3Bjb2RlOwogICAgIGNoYXIgbGV0dGVyOwotICAgIGludCBkZWZf
cmVnbnVtOwogCiAgICAgZm9yIChpID0gMTsgaSA8IHBrdC0+bnVtX2luc25zOyBpKyspIHsKICAg
ICAgICAgdWludDE2X3QgdXNlX29wY29kZSA9IHBrdC0+aW5zbltpXS5vcGNvZGU7CkBAIC03OCw3
ICs3Nyw2IEBAIGNoZWNrX25ld192YWx1ZShQYWNrZXQgKnBrdCkKICAgICAgICAgICAgICAgICB9
CiAgICAgICAgICAgICB9CiAgICAgICAgICAgICBpZiAoKGRzdHN0ciA9PSBOVUxMKSAgJiYgR0VU
X0FUVFJJQihkZWZfb3Bjb2RlLCBBX0NWSV9HQVRIRVIpKSB7Ci0gICAgICAgICAgICAgICAgZGVm
X3JlZ251bSA9IDA7CiAgICAgICAgICAgICAgICAgcGt0LT5pbnNuW2ldLnJlZ25vW3VzZV9yZWdp
ZHhdID0gZGVmX29yZWc7CiAgICAgICAgICAgICAgICAgcGt0LT5pbnNuW2ldLm5ld192YWx1ZV9w
cm9kdWNlcl9zbG90ID0gcGt0LT5pbnNuW2RlZl9pZHhdLnNsb3Q7CiAgICAgICAgICAgICB9IGVs
c2UgewpAQCAtODYsNyArODQsNyBAQCBjaGVja19uZXdfdmFsdWUoUGFja2V0ICpwa3QpCiAgICAg
ICAgICAgICAgICAgICAgIC8qIHN0aWxsIG5vdCB0aGVyZSwgd2UgaGF2ZSBhIGJhZCBwYWNrZXQg
Ki8KICAgICAgICAgICAgICAgICAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKICAgICAgICAg
ICAgICAgICB9Ci0gICAgICAgICAgICAgICAgZGVmX3JlZ251bSA9IHBrdC0+aW5zbltkZWZfaWR4
XS5yZWdub1tkc3RzdHIgLSByZWdpbmZvXTsKKyAgICAgICAgICAgICAgICBpbnQgZGVmX3JlZ251
bSA9IHBrdC0+aW5zbltkZWZfaWR4XS5yZWdub1tkc3RzdHIgLSByZWdpbmZvXTsKICAgICAgICAg
ICAgICAgICAvKiBOb3cgcGF0Y2ggdXAgdGhlIGNvbnN1bWVyIHdpdGggdGhlIHJlZ2lzdGVyIG51
bWJlciAqLwogICAgICAgICAgICAgICAgIHBrdC0+aW5zbltpXS5yZWdub1t1c2VfcmVnaWR4XSA9
IGRlZl9yZWdudW0gXiBkZWZfb3JlZzsKICAgICAgICAgICAgICAgICAvKiBzcGVjaWFsIGNhc2Ug
Zm9yIChWeCxWeSkgKi8KLS0gCjIuMjUuMQoK

