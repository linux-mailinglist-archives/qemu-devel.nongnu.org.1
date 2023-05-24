Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7275470F4F3
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 13:20:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1mWW-00015t-DF; Wed, 24 May 2023 07:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1q1mWU-00014y-Qd; Wed, 24 May 2023 07:19:18 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1q1mWT-0005VL-AW; Wed, 24 May 2023 07:19:18 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 76688320094B;
 Wed, 24 May 2023 07:19:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Wed, 24 May 2023 07:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm3; t=1684927155; x=
 1685013555; bh=YqGaCzeBP1QNn1kIDA1euHvhKAUTMMU7+EJjuPn+rU8=; b=g
 pc3oaejqMhhdaQTYueDBSe6N+JNvVuff5ieRZZFrRrGk/P6fL7gTv8Cf3wZxZoxb
 8lqb3ThRUCwnUqvUE7TJlEwd9T54FKQYLAXC7QxfSvsg4fPEv+TdiJ9eJePncfdJ
 NONUHsaD7GakjhB7JGmZhwcXuVA9ZQkB9km6OuEgLxN05juiDMmiIpptFQgyO/0+
 WZIeTrmQxY7ipYclQRX9hjPu3Pl/VKBXBJH2SJRYpkZy4L221hUGZsEkz6l+IJue
 FuRrrfr3KxLUYOjiUMuzZFzcQ7EosaOEkq14ZwPu9Rapgi2vmmX2McVxrRmp4/5t
 HlS/XdIGY42tLT+MUxlrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1684927155; x=
 1685013555; bh=YqGaCzeBP1QNn1kIDA1euHvhKAUTMMU7+EJjuPn+rU8=; b=p
 eSPqUYdt7VSzbYpcT3PWpFpBDrrj0eHf5QlvUUr2o/zma3D6aGexdMfYZprSrtaz
 dFfjJOwQhHG1yWfBgYgiTmG1NCbho76XVodykHXYZW9J5h3s5ojrftTi32gDwsug
 A++yw2+AdVBzDY/CxkjuZ+ULMdvnTdOkXVb9ASuSOPOXN4nUqU+Y58/ZV8F36iAy
 5Ti2dN8yd3PddApS/audiukcfiZ4Gmkz56wgUL4uy0tq5Q46yOEl2nsi0t+XF/P4
 Ok+9Al2OGELhIcLqW8+NDy8U/bFUOHreCh5LOwv+3LCMg1JoDibmyRWsyIgG3Ofw
 yLSfddqv/X2PgV9kFt66g==
X-ME-Sender: <xms:svJtZHLsw6Utrco5V94gBByuuuIASPQFTsBesvR_E-YJMQc7f0c0KQ>
 <xme:svJtZLI06LdY_6k8yGAR6K_NeAVZlMycGD_Jx16JyWPcokn9UznfgN76-yLtv16al
 Ze7N0nRWNV4hrhr-TA>
X-ME-Received: <xmr:svJtZPuzrtRF1xzh-v3xrlzOADkBOHINWUV85ACZJcFudlusDvwZfGLaQbL3L77UXBxbfYEvfDDO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejhedgfeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudej
 udegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:svJtZAaQXV5fM97xWXKzepil3tJOMHxAFr4V5LAouTYMlEh2EqX9jA>
 <xmx:svJtZOZ6B3Oj_zPFlnqAN88FKQf_l_-i-EUwJvj0sgThSfv5MP6GvQ>
 <xmx:svJtZECUiPONT_zj0muf1TiwgXan7IhPDDVTNGnFxmgr0SpdAvts5Q>
 <xmx:s_JtZFXSlsbLb2a_-vRXbjdl38pSK5F1PXun9sym2cgK6TFLWA7O8g>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 May 2023 07:19:13 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <j.devantier@samsung.com>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH 3/4] hw/nvme: add placement handle list ranges
Date: Wed, 24 May 2023 13:19:03 +0200
Message-Id: <20230524111904.91179-4-its@irrelevant.dk>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230524111904.91179-1-its@irrelevant.dk>
References: <20230524111904.91179-1-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2334; i=k.jensen@samsung.com;
 h=from:subject; bh=vS8E2scsOJE6wr9X0UOl/Oqkk1vJ57D54CyeDYB3j2Y=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGRt8qjorDoJSCHIewT4lH3hP6bsrZr3hI3gg
 iAx1Lae8BCuTokBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJkbfKoAAoJEE3hrzFt
 Tw3px+cIALU2ktFdUJfAbf9Apw6wO+MGOX+eTrN3x30ZEXhmZ4HJtNiJO/uudENotdYgVALP2aX
 nHb6SApeyrxz4jS0r6MNeaz9FPg6Tb9erae9wC//hL0vu88DWTBtAo9YQ3YYWRQpscmEEGT7y+w
 gaZBpGBy44W9jpENjH0pcqBiru/QWosfWugNU5b+Sp28spWaMX8ior1O+maH+V5O0/GUZw6R7et
 VIrIJDl0LK4uVIrzOgO7HBtrW8S1oXlHuAYC9WrBBPEn0bVDOQOxoRkHYHYGEbfzenmhyzI36lD
 5iQ/KdDRoGExtIkVRWshDThGvo9Bljl8jzvXkr8RvQxvmEEYA1CDGaoG
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.25; envelope-from=its@irrelevant.dk;
 helo=wout2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

From: Klaus Jensen <k.jensen@samsung.com>

Allow the placement handles to be specified as ranges, i.e.
`fdp.ruhs=1:3-5` will attempt to assign ruh 1, 3, 4 and 5 to the
namespace.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ns.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index c4ea2033bb1c..44aba8f4d9cf 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -400,8 +400,9 @@ static bool nvme_ns_init_fdp(NvmeNamespace *ns, Error **errp)
     NvmeRuHandle *ruh;
     uint8_t lbafi = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
     g_autofree unsigned int *ruhids = NULL;
-    unsigned int *ruhid;
-    char *r, *p, *token;
+    unsigned int n, m, *ruhid;
+    const char *endptr, *token;
+    char *r, *p;
     uint16_t *ph;
 
     if (!ns->params.fdp.ruhs) {
@@ -438,17 +439,40 @@ static bool nvme_ns_init_fdp(NvmeNamespace *ns, Error **errp)
 
     /* parse the placement handle identifiers */
     while ((token = qemu_strsep(&p, ";")) != NULL) {
-        if (ns->fdp.nphs++ == endgrp->fdp.nruh) {
-            error_setg(errp, "too many placement handles");
-            free(r);
-            return false;
-        }
-
-        if (qemu_strtoui(token, NULL, 0, ruhid++) < 0) {
+        if (qemu_strtoui(token, &endptr, 0, &n) < 0) {
             error_setg(errp, "cannot parse reclaim unit handle identifier");
             free(r);
             return false;
         }
+
+        m = n;
+
+        /* parse range */
+        if (*endptr == '-') {
+            token = endptr + 1;
+
+            if (qemu_strtoui(token, NULL, 0, &m) < 0) {
+                error_setg(errp, "cannot parse reclaim unit handle identifier");
+                free(r);
+                return false;
+            }
+
+            if (m < n) {
+                error_setg(errp, "invalid reclaim unit handle identifier range");
+                free(r);
+                return false;
+            }
+        }
+
+        for (; n <= m; n++) {
+            if (ns->fdp.nphs++ == endgrp->fdp.nruh) {
+                error_setg(errp, "too many placement handles");
+                free(r);
+                return false;
+            }
+
+            *ruhid++ = n;
+        }
     }
 
     free(r);
-- 
2.40.0


