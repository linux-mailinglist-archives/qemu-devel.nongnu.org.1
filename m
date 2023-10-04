Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F097B7F65
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:41:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo1B5-0006VX-7n; Wed, 04 Oct 2023 08:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1qo1B3-0006Uo-9l
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:40:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1qo1Al-0002eU-FW
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:40:33 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39484xZQ028794; Wed, 4 Oct 2023 12:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=g49TtmhlUmNxJsQTnb2Qok+1zkUEOTtGcIm7ALbhDi4=;
 b=FyQhoA4ffUiu7ywKpk6oRPWTSxNtcf/Q6Y2YTGsi+O+hJ7pN5WagO+KD8ay049tLwxT3
 JZMGFzn1ec40i2kSb4q2EOMrHpsEXpHgRm7734jpSnkHgciZPEHu9yYOwLEOw67EUMRc
 2br5zdPPxN7nhC8R3z3w9d3UbdhZnkxVFVhUaeKL3+NP30y+5+t7r0+onH8YmTrMIBnl
 fA6czLlik1UwF3JxHDh/9Mc1oazRJJKEPi2WQ9csGDSRdU3eXse/ARdiqNtvZpT+aqx7
 f1+unnAp2m91OgPQkbuLlpXg4IafAsPJ8+rtOQr06CmyH+I+/nbXWDN7fwtRjuSPpcum DA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tgynh951m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 12:40:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 394Ce4eA002104
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 4 Oct 2023 12:40:04 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 4 Oct 2023 05:40:04 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <armbru@redhat.com>, <richard.henderson@linaro.org>, 
 <philmd@linaro.org>, <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>, <stefanha@redhat.com>, <ale@rev.ng>,
 <anjo@rev.ng>, <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PATCH 0/2] Fix usage of GETPC(), variable shadowing
Date: Wed, 4 Oct 2023 05:39:55 -0700
Message-ID: <20231004123957.1732915-1-bcain@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: to-d5EykJ9N8tN25a9echEzUKZTWM2m2
X-Proofpoint-ORIG-GUID: to-d5EykJ9N8tN25a9echEzUKZTWM2m2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_04,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=335 clxscore=1011 adultscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040092
Received-SPF: pass client-ip=205.220.168.131; envelope-from=bcain@quicinc.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

TWF0aGV1cycgcGF0Y2ggaGFzIHByZXZpb3VzbHkgYmVlbiByZXZpZXdlZCwgYnV0IEkgYmFzZWQg
bXkgLVdzaGFkb3cKcGF0Y2ggb24gaGlzLiAgU28gSSdtIHN1Ym1pdHRpbmcgdGhlIHNlcmllcyBm
b3IgcmV2aWV3LgoKQnJpYW4gQ2FpbiAoMSk6CiAgdGFyZ2V0L2hleGFnb246IGZpeCBzb21lIG9j
Y3VycmVuY2VzIG9mIC1Xc2hhZG93PWxvY2FsCgpNYXRoZXVzIFRhdmFyZXMgQmVybmFyZGlubyAo
MSk6CiAgdGFyZ2V0L2hleGFnb246IG1vdmUgR0VUUEMoKSBjYWxscyB0byB0b3AgbGV2ZWwgaGVs
cGVycwoKIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2FsdS5pZGVmIHwgIDYgKy0tCiB0YXJnZXQv
aGV4YWdvbi9tYWNyb3MuaCAgICAgICAgICB8IDE5ICsrKystLS0tCiB0YXJnZXQvaGV4YWdvbi9t
bXZlYy9tYWNyb3MuaCAgICB8ICAyICstCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgICAg
ICB8IDg0ICsrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tCiB0YXJnZXQvaGV4YWdvbi9v
cF9oZWxwZXIuaCAgICAgICB8ICA5IC0tLS0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jICAg
ICAgIHwgMTAgKystLQogNiBmaWxlcyBjaGFuZ2VkLCA1MCBpbnNlcnRpb25zKCspLCA4MCBkZWxl
dGlvbnMoLSkKCi0tIAoyLjI1LjEKCg==

