Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BB07B75F6
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 02:49:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnq3x-0004Sj-WC; Tue, 03 Oct 2023 20:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1qnq3v-0004Rx-BX
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 20:48:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1qnq3t-0004pV-9B
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 20:48:27 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3940lR50020855; Wed, 4 Oct 2023 00:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=1MwVAnMc2Evw2m2iH057+kuaH/pxIYcWgUTxdbp6/mI=;
 b=BGkPr9WnXcKl0m8QJteKCMMPeTJOmcy6l4NNjI4fAwJ8jO3DJg96gWhiZeTjFXCYHINc
 zjB1kmp6naTdprUdtcXzJWO7ZvBFkGKelM8ZRhheG/YXvpvSaQu0cXG1lUPQN4vwjyyH
 dJ5iIHR9qWCFHK9+46nuSs+2mRF37VfV+KZPIJAweueooecpACqPthKLN/Y40K4kcqZT
 V1/9q8Ls6QbvzxL4khjg4/zeYYQWukHHeVOnLygs1M8eeAyO49WFusoeRGjEd7q9AQ/r
 UIShKdW+/sZDDqqCpJpFMr2nSPKUQd0vJm5SJsJ4xdLmXKCi0CkeFZfSsn1klBInjEsS 7w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tgr9mgkwu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 00:48:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3940mJn2027834
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 4 Oct 2023 00:48:19 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 3 Oct 2023 17:48:19 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <richard.henderson@linaro.org>, <philmd@linaro.org>, 
 <peter.maydell@linaro.org>, <quic_mathbern@quicinc.com>,
 <stefanha@redhat.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PULL 0/2] hex queue
Date: Tue, 3 Oct 2023 17:48:04 -0700
Message-ID: <20231004004806.1461248-1-bcain@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: CVmnB6jnNiHdyaoUsJE_OvLSniGFd4nv
X-Proofpoint-ORIG-GUID: CVmnB6jnNiHdyaoUsJE_OvLSniGFd4nv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_19,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 adultscore=0 clxscore=1011
 mlxlogscore=494 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040004
Received-SPF: pass client-ip=205.220.180.131; envelope-from=bcain@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCAzNmU5YWFiM2M1NjlkNGM5YWQ3ODA0
NzM1OTZlMTg0Nzk4MzhkMWFhOgoKICBtaWdyYXRpb246IE1vdmUgcmV0dXJuIHBhdGggY2xlYW51
cCB0byBtYWluIG1pZ3JhdGlvbiB0aHJlYWQgKDIwMjMtMDktMjcgMTM6NTg6MDIgLTA0MDApCgph
cmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoKCiAgaHR0cHM6Ly9naXRodWIu
Y29tL3F1aWMvcWVtdSB0YWdzL3B1bGwtaGV4LTIwMjMxMDAzCgpmb3IgeW91IHRvIGZldGNoIGNo
YW5nZXMgdXAgdG8gNTNjZGQyNmYxOTA5ZmM0NWFkNTBhNWVhYTk1ZGNmZmYwNjEzMGU1ZjoKCiAg
dGFyZ2V0L2hleGFnb246IGZpeCBzb21lIG9jY3VycmVuY2VzIG9mIC1Xc2hhZG93PWxvY2FsICgy
MDIzLTEwLTAzIDE3OjAyOjI5IC0wNzAwKQoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpIZXhhZ29uIEdFVFBDKCkgYW5kIC1X
c2hhZG93IGZpeGVzCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tCkJyaWFuIENhaW4gKDEpOgogICAgICB0YXJnZXQvaGV4YWdv
bjogZml4IHNvbWUgb2NjdXJyZW5jZXMgb2YgLVdzaGFkb3c9bG9jYWwKCk1hdGhldXMgVGF2YXJl
cyBCZXJuYXJkaW5vICgxKToKICAgICAgdGFyZ2V0L2hleGFnb246IG1vdmUgR0VUUEMoKSBjYWxs
cyB0byB0b3AgbGV2ZWwgaGVscGVycwoKIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2FsdS5pZGVm
IHwgIDYgKy0tCiB0YXJnZXQvaGV4YWdvbi9tYWNyb3MuaCAgICAgICAgICB8IDE5ICsrKysrLS0t
LQogdGFyZ2V0L2hleGFnb24vbW12ZWMvbWFjcm9zLmggICAgfCAgMiArLQogdGFyZ2V0L2hleGFn
b24vb3BfaGVscGVyLmMgICAgICAgfCA4NCArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuaCAgICAgICB8ICA5IC0tLS0tCiB0
YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyAgICAgICB8IDEwICsrLS0tCiA2IGZpbGVzIGNoYW5n
ZWQsIDUwIGluc2VydGlvbnMoKyksIDgwIGRlbGV0aW9ucygtKQo=

