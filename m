Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E427CA814
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 14:34:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsMm1-0000SC-On; Mon, 16 Oct 2023 08:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <acaggian@qualcomm.com>)
 id 1qsMlz-0000Rw-LJ
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 08:32:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <acaggian@qualcomm.com>)
 id 1qsMls-0004mF-Br
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 08:32:35 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39GBUEID013032; Mon, 16 Oct 2023 12:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=zKhUvG7dTlakuFHkmjonoiO0hIL+GSckm+It8tTNqaU=;
 b=gweR1IMN2nDFeJxu1C1Cje11k7Etngyf7Id181ND7PEN4cK2P2RZPcc1J4UXCv63/bf+
 6t3w1AdZol2YW9oUBkbYtkcYyK1xqEmdwbLV2MsTWMwhrn2wNqsamdP+M4sH2Sx01LOP
 +gxpgJDZoY8gcDCK2rANDH7Q36d/lc8FBk1EKED4MxdVuaS4ggGOR6yrEWfEsVC/+6Oh
 hUjEbHnTmMZV2L12JhWhdkfmMgx6pUHKN2Wq8D9zSxrUAQbovy0Vkrkg1tfiyYyaDRpZ
 s3TD0/9VcVftZJJG9WB7t1z6QyBuWN0OzlD083HKtEk1FbyFakeq6Ea9s339G+AaLN1b pg== 
Received: from euamsppmta02.qualcomm.com ([212.136.9.4])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tqhxyc7x9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 12:32:28 +0000
Received: from pps.filterd (EUAMSPPMTA02.qualcomm.com [127.0.0.1])
 by EUAMSPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 39GCWQEo011840; 
 Mon, 16 Oct 2023 12:32:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by EUAMSPPMTA02.qualcomm.com (PPS) with ESMTPS id 3tqm2n1s07-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 12:32:26 +0000
Received: from EUAMSPPMTA02.qualcomm.com (EUAMSPPMTA02.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39GCWPKw011834;
 Mon, 16 Oct 2023 12:32:25 GMT
Received: from hu-devc-ams-u20-c.qualcomm.com (hu-acaggian-ams.qualcomm.com
 [10.251.153.136])
 by EUAMSPPMTA02.qualcomm.com (PPS) with ESMTPS id 39GCWPxm011833
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 12:32:25 +0000
Received: by hu-devc-ams-u20-c.qualcomm.com (Postfix, from userid 4298557)
 id C6E6B217B7; Mon, 16 Oct 2023 14:32:25 +0200 (CEST)
From: Antonio Caggiano <quic_acaggian@quicinc.com>
To: qemu-devel@nongnu.org
Cc: Antonio Caggiano <quic_acaggian@quicinc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2] ui/gtk-egl: Check EGLSurface before doing scanout
Date: Mon, 16 Oct 2023 14:32:15 +0200
Message-Id: <20231016123215.2699269-1-quic_acaggian@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: 302fMMG_E0AWRx8d7chvIUv7eu-dqHYP
X-Proofpoint-ORIG-GUID: 302fMMG_E0AWRx8d7chvIUv7eu-dqHYP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_06,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxscore=0 spamscore=0 impostorscore=0
 clxscore=1015 mlxlogscore=628 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310160110
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=acaggian@qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

The first time gd_egl_scanout_texture() is called, there's a possibility
that the GTK drawing area might not be realized yet, in which case its
associated GdkWindow is NULL. This means gd_egl_init() was also skipped
and the EGLContext and EGLSurface stored in the VirtualGfxConsole are
not valid yet.

Continuing with the scanout in this conditions would result in hitting
an assert in libepoxy: "Couldn't find current GLX or EGL context".

A possible workaround is to just ignore the scanout request, giving the
the GTK drawing area some time to finish its realization. At that point,
the gd_egl_init() will succeed and the EGLContext and EGLSurface stored
in the VirtualGfxConsole will be valid.

Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/gtk-egl.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index a1060fd80f..3e8d1c1d02 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -243,12 +243,19 @@ void gd_egl_scanout_texture(DisplayChangeListener *dcl,
     vc->gfx.h = h;
     vc->gfx.y0_top = backing_y_0_top;
 
-    eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
-                   vc->gfx.esurface, vc->gfx.ectx);
+    if (!vc->gfx.esurface) {
+        gd_egl_init(vc);
+        if (!vc->gfx.esurface) {
+            return;
+        }
+
+        eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
+                       vc->gfx.esurface, vc->gfx.ectx);
 
-    gtk_egl_set_scanout_mode(vc, true);
-    egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_height,
-                         backing_id, false);
+        gtk_egl_set_scanout_mode(vc, true);
+        egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_height,
+                             backing_id, false);
+    }
 }
 
 void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
-- 
2.25.1


