Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEA7BF56F2
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Oct 2025 11:10:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB8J4-0002y3-7U; Tue, 21 Oct 2025 05:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8Ir-0002LX-OF
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:05:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8Ip-0004CL-GO
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761037510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gI1QAW8znPF68gfbqfS6bjSoZLHpqR0NqAR5uP2/jK8=;
 b=EYya/NE/0rPo3s/xe8IaG5/kN3QVuVQuhY99tfvLaDqL5qLZb1XPhQIHzQJtRNydeccqeS
 ct4oDSBuIL6B1StsxMZ+sRnFikC3Yv24rhc3op+16edORkj7r3FLWjcMy3HU/OEWbPtzoa
 2iOKOEMfIG8f9RRyc/dvyTHGy0tkDVA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-Hxwmnp8yPbiKG8j-8vRHQg-1; Tue,
 21 Oct 2025 05:05:09 -0400
X-MC-Unique: Hxwmnp8yPbiKG8j-8vRHQg-1
X-Mimecast-MFC-AGG-ID: Hxwmnp8yPbiKG8j-8vRHQg_1761037508
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DC531800743; Tue, 21 Oct 2025 09:05:08 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 85E3D30001BE; Tue, 21 Oct 2025 09:05:06 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 19/43] audio/paaudio: remove needless return value
Date: Tue, 21 Oct 2025 13:02:50 +0400
Message-ID: <20251021090317.425409-20-marcandre.lureau@redhat.com>
In-Reply-To: <20251021090317.425409-1-marcandre.lureau@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/paaudio.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index f3193b08c3..93030f3fc8 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -747,14 +747,13 @@ static void qpa_volume_in(HWVoiceIn *hw, Volume *vol)
     pa_threaded_mainloop_unlock(c->mainloop);
 }
 
-static int qpa_validate_per_direction_opts(Audiodev *dev,
-                                           AudiodevPaPerDirectionOptions *pdo)
+static void qpa_validate_per_direction_opts(Audiodev *dev,
+                                            AudiodevPaPerDirectionOptions *pdo)
 {
     if (!pdo->has_latency) {
         pdo->has_latency = true;
         pdo->latency = 46440;
     }
-    return 1;
 }
 
 /* common */
@@ -844,12 +843,8 @@ static void *qpa_audio_init(Audiodev *dev, Error **errp)
         }
     }
 
-    if (!qpa_validate_per_direction_opts(dev, popts->in)) {
-        return NULL;
-    }
-    if (!qpa_validate_per_direction_opts(dev, popts->out)) {
-        return NULL;
-    }
+    qpa_validate_per_direction_opts(dev, popts->in);
+    qpa_validate_per_direction_opts(dev, popts->out);
 
     g = g_new0(paaudio, 1);
     server = popts->server;
-- 
2.51.0


