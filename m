Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EA3725972
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 11:05:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6p6K-0003k7-TR; Wed, 07 Jun 2023 05:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1q6p6F-0003je-V6
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 05:05:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1q6p6C-00009G-SA
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 05:05:03 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3578JJf2010018; Wed, 7 Jun 2023 09:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=UAYW+y89LXIVidXwZlCsfsCn3BECXIV9OmsHodPIkDo=;
 b=kXWOiTGSbkwveoaPLSU7GD3XTUwvKlLRvyT92Gjn3Zh1B30V255Sk7bJ7tsglmmWZt+m
 yG1PlVresH2sEUUB0kQJWJC0odc/fUJhVJrosIfbO+bFgqiD7YltEq2UJfliGdlRyyI5
 pgD+6N3pZVdGyWeRX+qr6VNCwbatlag/hKG7U+hubmX7f90hmT7i3+HrZuC6fWGi0BCZ
 Vz9fh/xD0tZg5Gr+XhLwuHXUMFzit0xktI2T594KeS4ATJC84ij105aB2A7XY4+f01QI
 Kmog9U1Wg+g7xwcG14CjuU+aob/AbDRfM8MCPlOJjdvFR00IzohptIs5gQ9dino/5WvA LQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a6y9dqe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jun 2023 09:04:58 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35794v3T001591
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 7 Jun 2023 09:04:57 GMT
Received: from acaggian1-mac.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 7 Jun 2023 02:04:56 -0700
From: Antonio Caggiano <quic_acaggian@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?=
 <marcandre.lureau@redhat.com>
Subject: [PATCH] ui/sdl2: Allow high-dpi
Date: Wed, 7 Jun 2023 11:04:34 +0200
Message-ID: <20230607090434.53682-1-quic_acaggian@quicinc.com>
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
X-Proofpoint-GUID: wH6fttiAiP4LmWnpW_XFEnmSmdz2gnVu
X-Proofpoint-ORIG-GUID: wH6fttiAiP4LmWnpW_XFEnmSmdz2gnVu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=769 phishscore=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070075
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_acaggian@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Add the SDL_WINDOW_ALLOW_HIGHDPI flag when creating a window and get the
drawable size instead of the window size when setting up the framebuffer
and the viewport.

Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com>
---
 ui/sdl2-gl.c | 4 ++--
 ui/sdl2.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index bbfa70eac3..251b7d56d6 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -53,7 +53,7 @@ static void sdl2_gl_render_surface(struct sdl2_console *scon)
     SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
     sdl2_set_scanout_mode(scon, false);
 
-    SDL_GetWindowSize(scon->real_window, &ww, &wh);
+    SDL_GL_GetDrawableSize(scon->real_window, &ww, &wh);
     surface_gl_setup_viewport(scon->gls, scon->surface, ww, wh);
 
     surface_gl_render_texture(scon->gls, scon->surface);
@@ -239,7 +239,7 @@ void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
 
     SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
 
-    SDL_GetWindowSize(scon->real_window, &ww, &wh);
+    SDL_GL_GetDrawableSize(scon->real_window, &ww, &wh);
     egl_fb_setup_default(&scon->win_fb, ww, wh);
     egl_fb_blit(&scon->win_fb, &scon->guest_fb, !scon->y0_top);
 
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 9d703200bf..c9c83815ca 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -95,7 +95,7 @@ void sdl2_window_create(struct sdl2_console *scon)
     }
 #ifdef CONFIG_OPENGL
     if (scon->opengl) {
-        flags |= SDL_WINDOW_OPENGL;
+        flags |= SDL_WINDOW_OPENGL | SDL_WINDOW_ALLOW_HIGHDPI;
     }
 #endif
 
-- 
2.40.0


