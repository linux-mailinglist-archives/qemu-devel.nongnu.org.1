Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EACEBBFA749
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Oct 2025 09:07:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBSoX-0006ip-Qx; Wed, 22 Oct 2025 02:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSoW-0006hh-5w
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:59:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSoU-0008KK-QO
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761116353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YAafkmBEG44dEvteX7fLDwSFhNPhRmmSpWk7ihmCK6E=;
 b=CKBXfnh9Xqt+kWPl5qxM8KBZf2Z7XHWS7A8o8ha5u2RnShYddiqc9U0yKPVC2HWsA2/aeP
 gbHGaWG+JMAGRrhNwI3TRCNzbUUBxOai86omAk58lyYArANAhtemM+dsbXYNv+16smuRQi
 DdSoSIP9ivCrzWjJK53yXFj6ULbQ3kQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-F7u92J0vP56eHbkFhx5fsg-1; Wed,
 22 Oct 2025 02:59:09 -0400
X-MC-Unique: F7u92J0vP56eHbkFhx5fsg-1
X-Mimecast-MFC-AGG-ID: F7u92J0vP56eHbkFhx5fsg_1761116348
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9ED8F19540E7; Wed, 22 Oct 2025 06:59:08 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4C5B1180044F; Wed, 22 Oct 2025 06:59:06 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 26/42] audio: unregister vmstate description
Date: Wed, 22 Oct 2025 10:56:21 +0400
Message-ID: <20251022065640.1172785-27-marcandre.lureau@redhat.com>
In-Reply-To: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
References: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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
---
 audio/audio.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/audio/audio.c b/audio/audio.c
index b39b86cc2e..e610e8453a 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1614,6 +1614,8 @@ static void audio_vm_change_state_handler (void *opaque, bool running,
     audio_reset_timer (s);
 }
 
+static const VMStateDescription vmstate_audio;
+
 static void audio_state_init(Object *obj)
 {
     AudioState *s = AUDIO_STATE(obj);
@@ -1625,6 +1627,8 @@ static void audio_state_init(Object *obj)
 
     s->vmse = qemu_add_vm_change_state_handler(audio_vm_change_state_handler, s);
     assert(s->vmse != NULL);
+
+    vmstate_register_any(NULL, &vmstate_audio, s);
 }
 
 static void audio_state_finalize(Object *obj)
@@ -1679,6 +1683,8 @@ static void audio_state_finalize(Object *obj)
         qemu_del_vm_change_state_handler(s->vmse);
         s->vmse = NULL;
     }
+
+    vmstate_unregister(NULL, &vmstate_audio, s);
 }
 
 static Object *get_audiodevs_root(void)
@@ -1787,7 +1793,6 @@ static AudioState *audio_init(Audiodev *dev, Error **errp)
     }
     object_unref(s);
     QLIST_INIT (&s->card_head);
-    vmstate_register_any(NULL, &vmstate_audio, s);
     return s;
 
 out:
-- 
2.51.0


