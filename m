Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CBBBF56E2
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Oct 2025 11:09:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB8Ix-0002Lk-Oe; Tue, 21 Oct 2025 05:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8Ij-0002G4-VD
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:05:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8Ii-00043E-4j
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761037503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=edCqxjm6+it+f/NsFNu07UOMBwGQMYEzCgffa4wotb8=;
 b=iVJa2vP6jfiPQBLbNc0H5UtbMXV1qMq7LWivr7Sra3cBAp7vOneWpKGEwHzuuGWVxng7OA
 Eb7UglXqPs2ga8QfJx0GHIUP8QUTZetM3r4+0YDxFckXL0hn3oJiWGOJuiV6Ox/GoVCR6G
 LLM0hfzwTo2wbeFAmxoNc7VB2JLs2H4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-nzzETLJiNqGnbY-9I7__8Q-1; Tue,
 21 Oct 2025 05:04:58 -0400
X-MC-Unique: nzzETLJiNqGnbY-9I7__8Q-1
X-Mimecast-MFC-AGG-ID: nzzETLJiNqGnbY-9I7__8Q_1761037497
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 809101800654; Tue, 21 Oct 2025 09:04:57 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F2570180057C; Tue, 21 Oct 2025 09:04:55 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 17/43] audio: register backends in /audiodevs container
Date: Tue, 21 Oct 2025 13:02:48 +0400
Message-ID: <20251021090317.425409-18-marcandre.lureau@redhat.com>
In-Reply-To: <20251021090317.425409-1-marcandre.lureau@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
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

QOM tree now has /audiodevs objects.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio.c | 8 ++++++++
 qom/object.c  | 1 +
 2 files changed, 9 insertions(+)

diff --git a/audio/audio.c b/audio/audio.c
index 754952ce58..4714ed0b9f 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1726,6 +1726,11 @@ void audio_create_default_audiodevs(void)
     }
 }
 
+static Object *get_audiodevs_root(void)
+{
+    return object_get_container("audiodevs");
+}
+
 /*
  * if we have dev, this function was called because of an -audiodev argument =>
  *   initialize a new state with it
@@ -1742,6 +1747,9 @@ static AudioState *audio_init(Audiodev *dev, Error **errp)
     struct audio_driver *driver;
 
     s = AUDIO_STATE(object_new(TYPE_AUDIO_STATE));
+    if (!object_property_try_add_child(get_audiodevs_root(), dev->id, OBJECT(s), errp)) {
+        goto out;
+    }
 
     if (!atexit_registered) {
         atexit(audio_cleanup);
diff --git a/qom/object.c b/qom/object.c
index 1856bb36c7..4f32c1aba7 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1730,6 +1730,7 @@ const char *object_property_get_type(Object *obj, const char *name, Error **errp
 }
 
 static const char *const root_containers[] = {
+    "audiodevs",
     "chardevs",
     "objects",
     "backend"
-- 
2.51.0


