Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D3472BBF1
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 11:21:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8dil-0008CC-AK; Mon, 12 Jun 2023 05:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1q8dij-0008C4-Gi
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 05:20:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1q8dih-0004zE-So
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 05:20:17 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35C8lA0o032236; Mon, 12 Jun 2023 09:20:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=6t79hbs4iludnzaDpAdjZA6QFoG43MPzfoXurgoHaro=;
 b=LSlb1EkTlNIz7CUf5s/fs24hh5iNONDjNZx6Tm7wIZXApFUhNfIjWQHrYetJiixoWn03
 juQyLh+C6g/yYQw5aXjMHIvP//AzTUmGthkmTiuqIlaAN/sV6gGOoYF4Sr0NvDEr3Spt
 216O4Cy20A8SC2YkjNEwECLz3le5Rw69fjRWnbAprIecr8zzOfpz5WXSr3wxeadR44hx
 NkFWAF4e+fS04Jrxas3Fc3OxMu9A98tnJWRD4e6eocrkflvqcfTVnTwXyDg2OnW8Mxxo
 r+SIwkVZRuAQotjkVTE3G95TlUkRjHil6/2FVjK1Rptkjq/EyjP2adduSiHod6iTNFW7 2A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r4hjbtyhy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jun 2023 09:20:13 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35C9KCHT014310
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jun 2023 09:20:12 GMT
Received: from acaggian1-mac.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 12 Jun 2023 02:20:10 -0700
From: Antonio Caggiano <quic_acaggian@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd
 Hoffmann <kraxel@redhat.com>
Subject: [PATCH v5] ui/sdl2: OpenGL window context
Date: Mon, 12 Jun 2023 11:19:59 +0200
Message-ID: <20230612091959.2983-1-quic_acaggian@quicinc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: KJz46DpRI0uyjcvzapVllWhJj-gThlTS
X-Proofpoint-GUID: KJz46DpRI0uyjcvzapVllWhJj-gThlTS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_05,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=888
 clxscore=1015 bulkscore=0 phishscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306120079
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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
v2: There is no need to specify major and minor version if the SDL renderer is
    not created. Also, tested on Windows.
v3: Completely messed up the commit, now fixed.
v4: Check winctx and renderer before destroying.
v5: Reviewed-by.

 ui/sdl2.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 9d703200bf..0d91b555e3 100644
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
@@ -128,10 +128,14 @@ void sdl2_window_destroy(struct sdl2_console *scon)
         return;
     }
 
-    SDL_GL_DeleteContext(scon->winctx);
-    scon->winctx = NULL;
-    SDL_DestroyRenderer(scon->real_renderer);
-    scon->real_renderer = NULL;
+    if (scon->winctx) {
+        SDL_GL_DeleteContext(scon->winctx);
+        scon->winctx = NULL;
+    }
+    if (scon->real_renderer) {
+        SDL_DestroyRenderer(scon->real_renderer);
+        scon->real_renderer = NULL;
+    }
     SDL_DestroyWindow(scon->real_window);
     scon->real_window = NULL;
 }
-- 
2.40.0


