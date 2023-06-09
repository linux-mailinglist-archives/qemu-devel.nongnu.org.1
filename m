Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38324729F05
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 17:47:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7cmq-0001ib-Ps; Fri, 09 Jun 2023 10:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1q7cmk-0001iQ-NX
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 10:08:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1q7cmi-00007h-W7
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 10:08:14 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 359Dw3I3014023; Fri, 9 Jun 2023 14:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=sYbCOEW2hN4b2TzCX/G9Pc6nIfeY03bCBJZUfd6YxIk=;
 b=Gkv3wpYIbCIgrr2O7K5gZDKo9Z9qP4fZkXg8kNT0r3OXiIHBiFOOGRV0EP0vugzEBN/L
 QZb3WeVPaOcix+3QyWOfEpXD/t6Se/DBQ/S3gTt6ML53pvcftY4U56mqc21vjGR1gJgH
 n+SuKQy8Pks5GGMST1GEy7/Hgbuvu87Fh5XfDoB5u5SPzjH8rPsPbaQBXt2m62yFfh6J
 Yu5xMuXqTcjjCe0olnK6mh94aufncYZ8Zz4krL3LMqhxmEWE/KE6aI3VUXq7Xe+wq9dx
 ImH8tyf4AVAr0lRBi6JB+4m/y2GwtEjMdFWW6hdHZDgGwuNzd0Nu+ZGf4Z1EMqyiHWKA EA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r3vu4h0nk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Jun 2023 14:08:11 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 359E8AvF028026
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 9 Jun 2023 14:08:10 GMT
Received: from acaggian1-mac.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 9 Jun 2023 07:08:07 -0700
From: Antonio Caggiano <quic_acaggian@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?=
 <marcandre.lureau@redhat.com>
Subject: [PATCH v3] ui/sdl2: OpenGL window context
Date: Fri, 9 Jun 2023 16:07:52 +0200
Message-ID: <20230609140752.69758-1-quic_acaggian@quicinc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: qsc3Pg8erHZ9szFjgVaoMtDDDsUo7naG
X-Proofpoint-ORIG-GUID: qsc3Pg8erHZ9szFjgVaoMtDDDsUo7naG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_10,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=801
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090119
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_acaggian@quicinc.com; helo=mx0b-0031df01.pphosted.com
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

When OpenGL is enabled, create only the OpenGL context, ignoring the SDL
renderer as it is unused anyway.

Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com>
---
v2: There is no need to specify major and minor version if the SDL renderer is
    not created. Also, tested on Windows.
v3: Completely messed up the commit, now fixed.

 ui/sdl2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 9d703200bf..82e6ee5511 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -113,11 +113,11 @@ void sdl2_window_create(struct sdl2_console *scon)
 
         SDL_SetHint(SDL_HINT_RENDER_DRIVER, driver);
         SDL_SetHint(SDL_HINT_RENDER_BATCHING, "1");
-    }
-    scon->real_renderer = SDL_CreateRenderer(scon->real_window, -1, 0);
 
-    if (scon->opengl) {
         scon->winctx = SDL_GL_CreateContext(scon->real_window);
+    } else {
+        /* The SDL renderer is only used by sdl2-2D, when OpenGL is disabled */
+        scon->real_renderer = SDL_CreateRenderer(scon->real_window, -1, 0);
     }
     sdl_update_caption(scon);
 }
-- 
2.40.0


