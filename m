Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D47C5BF5700
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Oct 2025 11:10:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB8Kq-0006w6-OD; Tue, 21 Oct 2025 05:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8KW-0006oO-Tt
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:06:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8KO-0004OR-W2
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761037608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1+QYez7Jzo8MSmdV9f2wjA9ZiZxwt3D7e37RqxqJ5V8=;
 b=eGnRh6pxTVTQrsEwBVPtNILzcreNwBIIfu9UDu9HLQa/gBHZwyveTM3VfsQUNXqhoYegTC
 MipYbwF6F4f36tXZLVoKukEa+ez9P+I7xNv7Ic4WCOBQ2CwEU5h2+MwjREaZk4VrJpSl47
 mRuE35kSfTFQzmqpXeBl0ay8BPidxmo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-VEtmlA0OMnWMYR0KZNIw1g-1; Tue,
 21 Oct 2025 05:06:46 -0400
X-MC-Unique: VEtmlA0OMnWMYR0KZNIw1g-1
X-Mimecast-MFC-AGG-ID: VEtmlA0OMnWMYR0KZNIw1g_1761037601
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8884619560A2; Tue, 21 Oct 2025 09:06:41 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 447E71955F22; Tue, 21 Oct 2025 09:06:39 +0000 (UTC)
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
Subject: [PATCH 36/43] audio: rename audio_get_id()
Date: Tue, 21 Oct 2025 13:03:07 +0400
Message-ID: <20251021090317.425409-37-marcandre.lureau@redhat.com>
In-Reply-To: <20251021090317.425409-1-marcandre.lureau@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
 audio/audio.h                    | 2 +-
 audio/audio.c                    | 2 +-
 hw/core/qdev-properties-system.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/audio/audio.h b/audio/audio.h
index a43ca0700c..85e588a885 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -156,7 +156,7 @@ void audio_help(void);
 
 AudioBE *audio_be_by_name(const char *name, Error **errp);
 AudioBE *audio_get_default_audio_be(Error **errp);
-const char *audio_get_id(AudioFE *fe);
+const char *audio_fe_get_be_id(AudioFE *fe);
 
 #define DEFINE_AUDIO_PROPERTIES(_s, _f)         \
     DEFINE_PROP_AUDIODEV("audiodev", _s, _f)
diff --git a/audio/audio.c b/audio/audio.c
index 7463bbd283..35753ebb97 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -2232,7 +2232,7 @@ AudioBE *audio_be_by_name(const char *name, Error **errp)
     }
 }
 
-const char *audio_get_id(AudioFE *card)
+const char *audio_fe_get_be_id(AudioFE *card)
 {
     if (card->be) {
         assert(card->be->dev);
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index fc8e5eb07a..701f6553c5 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -488,7 +488,7 @@ static void get_audiodev(Object *obj, Visitor *v, const char* name,
 {
     const Property *prop = opaque;
     AudioFE *card = object_field_prop_ptr(obj, prop);
-    char *p = g_strdup(audio_get_id(card));
+    char *p = g_strdup(audio_fe_get_be_id(card));
 
     visit_type_str(v, name, &p, errp);
     g_free(p);
-- 
2.51.0


