Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 045BCC23734
	for <lists+qemu-devel@lfdr.de>; Fri, 31 Oct 2025 07:49:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEivw-0006sU-F2; Fri, 31 Oct 2025 02:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vEive-0005nh-2O
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 02:48:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vEivb-0003pi-U4
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 02:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761893281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tpASkYS/t70hNn5GY7VCHkTrgmBuPXtl7G4M5sSpgSw=;
 b=MIRXulnGIXIEn9c4hGj4I1yJKn2pwejhLF0zdqAMcTP8n9sH8w4N++QoZPosX/0qAfwL0P
 DmwsSyk908HSS5jCWA9F17u70NAHCLkQgJwL+uJFON0Q3m9BP0Pzs65odvAiJ9tkExp3NY
 UEqfm6Kk/gCZhZ0WfbLkOrnpuvAEyn0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-T6h6fbNfMoaz7IFJzKKU1A-1; Fri,
 31 Oct 2025 02:47:58 -0400
X-MC-Unique: T6h6fbNfMoaz7IFJzKKU1A-1
X-Mimecast-MFC-AGG-ID: T6h6fbNfMoaz7IFJzKKU1A_1761893277
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A141B1955DAA; Fri, 31 Oct 2025 06:47:57 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 36DF41800583; Fri, 31 Oct 2025 06:47:55 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 12/36] audio/paaudio: remove needless return value
Date: Fri, 31 Oct 2025 10:46:05 +0400
Message-ID: <20251031064631.134651-13-marcandre.lureau@redhat.com>
In-Reply-To: <20251031064631.134651-1-marcandre.lureau@redhat.com>
References: <20251031064631.134651-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.51.1


