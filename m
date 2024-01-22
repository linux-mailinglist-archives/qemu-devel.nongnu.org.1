Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FD4835B18
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 07:38:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRnuX-0003C0-D1; Mon, 22 Jan 2024 01:35:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rRnuC-0002xF-Et
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 01:35:36 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rRnu9-0005jO-K0
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 01:35:36 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40M4s3EO010816; Mon, 22 Jan 2024 06:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=
 qcppdkim1; bh=cRT+vEQ0dLajpkLhdBmzQ1IqlLc4ltfp/Ls4R9vdEEU=; b=k7
 LIxec7vktXqn46v4NO1SGrbLPdSThUPr14/QJFnJvQhlPd8fC5+GvIo09galq4hy
 fmbLfSaqVduuoY4vtvGO83tS3qEnyKKfpGyGQO13YakYMO6OJOIC+bEmnkbohSXb
 ev9EkF1MsZd/gX1igf9LRYt2s7OB5ZNLoWdZ3zrFITMeADdlcAGh8YhGLguxW8c6
 e8khCeH9AS+dRL0hGROBlFkGY60+E5SuLYrlY/McLqP/cjIMiGTIAY70AhUUMtVO
 YX8/i9UAU2zdaAKZttTKTike+eu465yOrLiADZ46GFceQZEjMBZ/p4FT2T3VFWP4
 9hh5Vn9qReBGNoLXvaWA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr54wu5r9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 06:35:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40M6ZTws027353
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 06:35:29 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 21 Jan 2024 22:35:28 -0800
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <armbru@redhat.com>, <richard.henderson@linaro.org>, 
 <philmd@linaro.org>, <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>, <stefanha@redhat.com>, <ale@rev.ng>,
 <anjo@rev.ng>, <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PULL 11/15] Hexagon (target/hexagon) Remove dead functions from
 hex_common.py
Date: Sun, 21 Jan 2024 22:34:57 -0800
Message-ID: <20240122063501.782041-12-bcain@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240122063501.782041-1-bcain@quicinc.com>
References: <20240122063501.782041-1-bcain@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: MexpbNCpjfSreZaPXAmSRz2Sp_ugYS_9
X-Proofpoint-GUID: MexpbNCpjfSreZaPXAmSRz2Sp_ugYS_9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-21_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 mlxlogscore=439 clxscore=1015 suspectscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220046
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

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KClRoZXNlIGZ1
bmN0aW9ucyBhcmUgbm8gbG9uZ2VyIHVzZWQgYWZ0ZXIgbWFraW5nIHRoZSBnZW5lcmF0b3JzCm9i
amVjdCBvcmllbnRlZC4KClNpZ25lZC1vZmYtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2lt
cHNvbkBnbWFpbC5jb20+ClJldmlld2VkLWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNv
bT4KTWVzc2FnZS1JZDogPDIwMjMxMjEwMjIwNzEyLjQ5MTQ5NC0xMC1sdGF5bG9yc2ltcHNvbkBn
bWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJjYWluQHF1aWNpbmMuY29tPgot
LS0KIHRhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkgfCA1MSAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA1MSBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5IGIvdGFyZ2V0L2hleGFnb24vaGV4
X2NvbW1vbi5weQppbmRleCBjYTVlOTYzMGMxLi4xOTU2MjBjN2VjIDEwMDc1NQotLS0gYS90YXJn
ZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CisrKyBiL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24u
cHkKQEAgLTMzLDkgKzMzLDYgQEAKIG92ZXJyaWRlcyA9IHt9ICAjIHRhZ3Mgd2l0aCBoZWxwZXIg
b3ZlcnJpZGVzCiBpZGVmX3BhcnNlcl9lbmFibGVkID0ge30gICMgdGFncyBlbmFibGVkIGZvciBp
ZGVmLXBhcnNlcgogCi1kZWYgYmFkX3JlZ2lzdGVyKHJlZ3R5cGUsIHJlZ2lkKToKLSAgICByYWlz
ZSBFeGNlcHRpb24oZiJCYWQgcmVnaXN0ZXIgcGFyc2U6IHJlZ3R5cGUgJ3tyZWd0eXBlfScgcmVn
aWQgJ3tyZWdpZH0nIikKLQogIyBXZSBzaG91bGQgZG8gdGhpcyBhcyBhIGhhc2ggZm9yIHBlcmZv
cm1hbmNlLAogIyBidXQgdG8ga2VlcCBvcmRlciBsZXQncyBrZWVwIGl0IGFzIGEgbGlzdC4KIGRl
ZiB1bmlxdWlmeShzZXEpOgpAQCAtMjAwLDQ2ICsxOTcsNiBAQCBkZWYgZ2V0X3RhZ2ltbXMoKToK
ICAgICByZXR1cm4gZGljdCh6aXAodGFncywgbGlzdChtYXAoY29tcHV0ZV90YWdfaW1tZWRpYXRl
cywgdGFncykpKSkKIAogCi1kZWYgaXNfcGFpcihyZWdpZCk6Ci0gICAgcmV0dXJuIGxlbihyZWdp
ZCkgPT0gMgotCi0KLWRlZiBpc19zaW5nbGUocmVnaWQpOgotICAgIHJldHVybiBsZW4ocmVnaWQp
ID09IDEKLQotCi1kZWYgaXNfd3JpdHRlbihyZWdpZCk6Ci0gICAgcmV0dXJuIHJlZ2lkWzBdIGlu
ICJkZXh5IgotCi0KLWRlZiBpc193cml0ZW9ubHkocmVnaWQpOgotICAgIHJldHVybiByZWdpZFsw
XSBpbiAiZGUiCi0KLQotZGVmIGlzX3JlYWQocmVnaWQpOgotICAgIHJldHVybiByZWdpZFswXSBp
biAic3R1dnd4eSIKLQotCi1kZWYgaXNfcmVhZHdyaXRlKHJlZ2lkKToKLSAgICByZXR1cm4gcmVn
aWRbMF0gaW4gInh5IgotCi0KLWRlZiBpc19zY2FsYXJfcmVnKHJlZ3R5cGUpOgotICAgIHJldHVy
biByZWd0eXBlIGluICJSUEMiCi0KLQotZGVmIGlzX2h2eF9yZWcocmVndHlwZSk6Ci0gICAgcmV0
dXJuIHJlZ3R5cGUgaW4gIlZRIgotCi0KLWRlZiBpc19vbGRfdmFsKHJlZ3R5cGUsIHJlZ2lkLCB0
YWcpOgotICAgIHJldHVybiByZWd0eXBlICsgcmVnaWQgKyAiViIgaW4gc2VtZGljdFt0YWddCi0K
LQotZGVmIGlzX25ld192YWwocmVndHlwZSwgcmVnaWQsIHRhZyk6Ci0gICAgcmV0dXJuIHJlZ3R5
cGUgKyByZWdpZCArICJOIiBpbiBzZW1kaWN0W3RhZ10KLQotCiBkZWYgbmVlZF9zbG90KHRhZyk6
CiAgICAgaWYgKAogICAgICAgICAiQV9DVklfU0NBVFRFUiIgbm90IGluIGF0dHJpYmRpY3RbdGFn
XQpAQCAtMjgwLDE0ICsyMzcsNiBAQCBkZWYgc2tpcF9xZW11X2hlbHBlcih0YWcpOgogICAgIHJl
dHVybiB0YWcgaW4gb3ZlcnJpZGVzLmtleXMoKQogCiAKLWRlZiBpc190bXBfcmVzdWx0KHRhZyk6
Ci0gICAgcmV0dXJuICJBX0NWSV9UTVAiIGluIGF0dHJpYmRpY3RbdGFnXSBvciAiQV9DVklfVE1Q
X0RTVCIgaW4gYXR0cmliZGljdFt0YWddCi0KLQotZGVmIGlzX25ld19yZXN1bHQodGFnKToKLSAg
ICByZXR1cm4gIkFfQ1ZJX05FVyIgaW4gYXR0cmliZGljdFt0YWddCi0KLQogZGVmIGlzX2lkZWZf
cGFyc2VyX2VuYWJsZWQodGFnKToKICAgICByZXR1cm4gdGFnIGluIGlkZWZfcGFyc2VyX2VuYWJs
ZWQKIAotLSAKMi4yNS4xCgo=

