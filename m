Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3923756357
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 14:54:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLNdv-00089W-SC; Mon, 17 Jul 2023 08:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qLNd3-0007c1-3D
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:47:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qLNd0-0008NW-KU
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689598022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c0IfWS9EMdsUFmJ5bsrmW0GVPdFrF2Q5OErIVgOV174=;
 b=Bf9DZY4cMPnyRH+uoIKMOHQgD9VQ2gnIndXczCXpeA/IKJGmK2sVI89yUYjZdFvJA8JtMS
 TlPB+AaC9kHPUf0rHOwYhy6VLXW9a1TvmEnCumTMSOByOUatImj2jQgOBMFMMI+K4gjn/G
 uLE+oxNsrzwjyNiyIBBHg3ijOhslACg=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-SB4kTr97Nb6qRVcWwXm8kQ-1; Mon, 17 Jul 2023 08:46:59 -0400
X-MC-Unique: SB4kTr97Nb6qRVcWwXm8kQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACC0F299E742;
 Mon, 17 Jul 2023 12:46:58 +0000 (UTC)
Received: from localhost (unknown [10.39.208.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97412492B01;
 Mon, 17 Jul 2023 12:46:57 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, richard.henderson@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PULL 16/19] audio/pw: add more error reporting
Date: Mon, 17 Jul 2023 16:45:41 +0400
Message-ID: <20230717124545.177236-17-marcandre.lureau@redhat.com>
In-Reply-To: <20230717124545.177236-1-marcandre.lureau@redhat.com>
References: <20230717124545.177236-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Volker Rümelin <vr_qemu@t-online.de>
Message-Id: <20230506163735.3481387-10-marcandre.lureau@redhat.com>
---
 audio/pwaudio.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index 70f0c46240..f1c5e5dd48 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -429,6 +429,10 @@ create_stream(pwaudio *c, PWVoice *v, const char *stream_name,
     struct pw_properties *props;
 
     props = pw_properties_new(NULL, NULL);
+    if (!props) {
+        error_report("Failed to create PW properties: %s", g_strerror(errno));
+        return -1;
+    }
 
     /* 75% of the timer period for faster updates */
     buf_samples = (uint64_t)v->g->dev->timer_period * v->info.rate
@@ -441,8 +445,8 @@ create_stream(pwaudio *c, PWVoice *v, const char *stream_name,
         pw_properties_set(props, PW_KEY_TARGET_OBJECT, name);
     }
     v->stream = pw_stream_new(c->core, stream_name, props);
-
     if (v->stream == NULL) {
+        error_report("Failed to create PW stream: %s", g_strerror(errno));
         return -1;
     }
 
@@ -470,6 +474,7 @@ create_stream(pwaudio *c, PWVoice *v, const char *stream_name,
                             PW_STREAM_FLAG_MAP_BUFFERS |
                             PW_STREAM_FLAG_RT_PROCESS, params, n_params);
     if (res < 0) {
+        error_report("Failed to connect PW stream: %s", g_strerror(errno));
         pw_stream_destroy(v->stream);
         return -1;
     }
-- 
2.41.0


