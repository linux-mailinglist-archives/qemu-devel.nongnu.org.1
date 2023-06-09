Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3700729F6E
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 17:58:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7ci7-0008LX-NM; Fri, 09 Jun 2023 10:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1q7chr-0008Kl-Qq
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 10:03:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1q7chp-0007QV-D7
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 10:03:11 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 359D7Yf1029493; Fri, 9 Jun 2023 14:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=EXC1vyZWH6y3zU6VDY/bn0i/D0cnVRYEJVXm1/Cacos=;
 b=P0IvwKmdMDb4XEIvkZIvWkzJ3u0BTdFlfizP4fiIjV0N7I6BxVjobenv4mHnCvHY2toU
 CfHwxRpPaPHeU6cyXiJ8vmPMlbM6aHeXLlROMGivAb0whzZn4Y4Z5SLAfpgDlNDtyjw7
 z2+QCQORuf3Lmjzk5KFy2SI3KixF3WkUjkOuvucVOOrhqb2KWvgkRa5QUx9vqDWdoF9u
 Ql70U+WiL+1Gtbz47EYa0TaBUMhEkTO8PL09YPmAYD0Xx5jQYJkfdBmUUOl4JzgOODU7
 036ZpahwkB8trMju63/mpq2hdnjd/6gWYViJWw0Fix6GyDrwyxFNqkolFALvzCMrxRRm 2g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r43d4882s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Jun 2023 14:03:05 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 359E34KV007967
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 9 Jun 2023 14:03:04 GMT
Received: from acaggian1-mac.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 9 Jun 2023 07:03:01 -0700
From: Antonio Caggiano <quic_acaggian@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?=
 <marcandre.lureau@redhat.com>
Subject: [PATCH v2] ui/sdl2: OpenGL window context
Date: Fri, 9 Jun 2023 16:02:35 +0200
Message-ID: <20230609140235.68740-1-quic_acaggian@quicinc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: 6bMixxB51AYQJwa6GYVJ-sODQDPI1-Zr
X-Proofpoint-GUID: 6bMixxB51AYQJwa6GYVJ-sODQDPI1-Zr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_10,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=701 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

 ui/sdl2.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 9d703200bf..cf1833b1ad 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -104,7 +104,11 @@ void sdl2_window_create(struct sdl2_console *scon)
                                          surface_width(scon->surface),
                                          surface_height(scon->surface),
                                          flags);
+
     if (scon->opengl) {
+        scon->winctx = SDL_GL_CreateContext(scon->real_window);
+    } else {
+        /* The SDL renderer is only used by sdl2-2D, when OpenGL is disabled */
         const char *driver = "opengl";
 
         if (scon->opts->gl == DISPLAYGL_MODE_ES) {
@@ -113,11 +117,8 @@ void sdl2_window_create(struct sdl2_console *scon)
 
         SDL_SetHint(SDL_HINT_RENDER_DRIVER, driver);
         SDL_SetHint(SDL_HINT_RENDER_BATCHING, "1");
-    }
-    scon->real_renderer = SDL_CreateRenderer(scon->real_window, -1, 0);
 
-    if (scon->opengl) {
-        scon->winctx = SDL_GL_CreateContext(scon->real_window);
+        scon->real_renderer = SDL_CreateRenderer(scon->real_window, -1, 0);
     }
     sdl_update_caption(scon);
 }
@@ -128,10 +129,14 @@ void sdl2_window_destroy(struct sdl2_console *scon)
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


