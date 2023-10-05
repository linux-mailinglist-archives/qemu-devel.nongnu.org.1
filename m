Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F0C7B9D21
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 14:59:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoNw5-0007lz-Qx; Thu, 05 Oct 2023 08:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoNw0-0007hc-5L
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:58:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoNvy-0007kC-EG
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696510709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zT0mvsYGj0W3YfH+3Z5zqBtAhqUNz5Jtuejiza4ByXU=;
 b=MZL+AQqiHUCzN3M/sPJ6e2sa1dXomnoAVOKyDC9JmIrTL4KMLDDBsTRIXo7gTyl67HNoGl
 4DJnLwc/iBWfzYa7KdDoWF/U/394IYAX5DhPhOcBgIDybOD0qfeMBRE7lkGKHwRwtCKxBT
 mBXFLfrCh8w8yas01myt1nKFOlfbrlA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-VsKAAwJjOCyhCkGfXVz8gQ-1; Thu, 05 Oct 2023 08:58:28 -0400
X-MC-Unique: VsKAAwJjOCyhCkGfXVz8gQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9a9d7a801a3so88863766b.2
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 05:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696510706; x=1697115506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zT0mvsYGj0W3YfH+3Z5zqBtAhqUNz5Jtuejiza4ByXU=;
 b=e0b9Wptm3DBTSVIMIFfzjcHPise/tH7p45Kl2VBmoiIdhPFVNb1gVLJjX2+vegm9U1
 +iuMyn7Ak6loVpYUBj0Cg/UVmPz1bw2fla2IZ30/MxMiodxcQCyllFpJ8w6nSkveqnqX
 pqVDd0FTWnpG1wyU424Krd8s6vpaUqEa021VzpoOQPCzifTVhX+7gfmf2ANGmEYOXD6S
 NFo1lBSx3iV+A5a1c8WVD6XAI17PjLz2bRw5J1EtKO5tV0QozAA+GMZr0/HB9P1/2FVo
 iK/BW0D/wWnH9b8azO3o8hGHZ/nObHVyAtYdqxkNiBHL27d4vU5i9xDT+1UCNarhw6gD
 Ulrg==
X-Gm-Message-State: AOJu0Yx1f19sz1AzI5PvBe4O6Kc9EshCGcFm33hgARVm0ZMkyIT/TWm+
 LGHF7i/F7p7r+tXo77WJtFdcpYLI8Wg1bvpGelJVJrbVv99Dho7Xjh/OCEoGYKXe2iLU6I/BL12
 O97z/itdRvJSdlnX0+EpnzpyVHQ8+wr033tz4y74dSAyN3TWncstCzypRjDozIklg0D6l160GY4
 U=
X-Received: by 2002:a17:906:29a:b0:9aa:23c9:aa52 with SMTP id
 26-20020a170906029a00b009aa23c9aa52mr4688076ejf.20.1696510706364; 
 Thu, 05 Oct 2023 05:58:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+Qb96Y84Of0jNFbogxf9Yc6Iz9pXMSQC+cs0v+tlvLID1Br8j3hIKrnk6ro59sa6dhVpizg==
X-Received: by 2002:a17:906:29a:b0:9aa:23c9:aa52 with SMTP id
 26-20020a170906029a00b009aa23c9aa52mr4688058ejf.20.1696510706046; 
 Thu, 05 Oct 2023 05:58:26 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 cw11-20020a170906c78b00b0099e12a49c8fsm1177812ejb.173.2023.10.05.05.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 05:58:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	berrange@redhat.com
Subject: [PATCH 5/7] audio: do not use first -audiodev as default audio device
Date: Thu,  5 Oct 2023 14:58:13 +0200
Message-ID: <20231005125815.66082-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005125815.66082-1-pbonzini@redhat.com>
References: <20231005125815.66082-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It is now possible to specify the options for the default audio device
using -audio, so there is no need anymore to use a fake -audiodev option.

Remove the fall back to QTAILQ_FIRST(&audio_states), instead remember the
AudioState that was created from default_audiodevs and use that one.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/audio.c                   | 25 +++++++------------------
 docs/about/deprecated.rst       |  6 ------
 docs/about/removed-features.rst |  8 ++++++++
 3 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 186cc4d336e..de37ad7c074 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -104,6 +104,7 @@ static audio_driver *audio_driver_lookup(const char *name)
 
 static QTAILQ_HEAD(AudioStateHead, AudioState) audio_states =
     QTAILQ_HEAD_INITIALIZER(audio_states);
+static AudioState *default_audio_state;
 
 const struct mixeng_volume nominal_volume = {
     .mute = 0,
@@ -1660,6 +1661,7 @@ static void free_audio_state(AudioState *s)
 
 void audio_cleanup(void)
 {
+    default_audio_state = NULL;
     while (!QTAILQ_EMPTY(&audio_states)) {
         AudioState *s = QTAILQ_FIRST(&audio_states);
         QTAILQ_REMOVE(&audio_states, s, list);
@@ -1760,6 +1762,7 @@ static AudioState *audio_init(Audiodev *dev, Error **errp)
             goto out;
         }
     } else {
+        assert(!default_audio_state);
         for (;;) {
             AudiodevListEntry *e = QSIMPLEQ_FIRST(&default_audiodevs);
             if (!e) {
@@ -1801,24 +1804,9 @@ out:
 bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp)
 {
     if (!card->state) {
-        if (!QTAILQ_EMPTY(&audio_states)) {
-            /*
-             * FIXME: once it is possible to create an arbitrary
-             * default device via -audio DRIVER,OPT=VALUE (no "model"),
-             * replace this special case with the default AudioState*,
-             * storing it in a separate global.  For now, keep the
-             * warning to encourage moving off magic use of the first
-             * -audiodev.
-             */
-            if (QSIMPLEQ_EMPTY(&default_audiodevs)) {
-                dolog("Device %s: audiodev default parameter is deprecated, please "
-                      "specify audiodev=%s\n", name,
-                      QTAILQ_FIRST(&audio_states)->dev->id);
-            }
-            card->state = QTAILQ_FIRST(&audio_states);
-        } else {
-            card->state = audio_init(NULL, errp);
-            if (!card->state) {
+        if (!default_audio_state) {
+            default_audio_state = audio_init(NULL, errp);
+            if (!default_audio_state) {
                 if (!QSIMPLEQ_EMPTY(&audiodevs)) {
                     error_append_hint(errp, "Perhaps you wanted to set audiodev=%s?\n",
                                       QSIMPLEQ_FIRST(&audiodevs)->dev->id);
@@ -1826,6 +1814,7 @@ bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp)
                 return false;
             }
         }
+        card->state = default_audio_state;
     }
 
     card->name = g_strdup (name);
diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 2f51cf770ae..d59bcf36230 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -37,12 +37,6 @@ coverage.
 System emulator command line arguments
 --------------------------------------
 
-Creating sound card devices without ``audiodev=`` property (since 4.2)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-When not using the deprecated legacy audio config, each sound card
-should specify an ``audiodev=`` property.
-
 Short-form boolean options (since 6.0)
 ''''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 58c94392c65..27639370f96 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -442,10 +442,18 @@ line using a ``secret`` object instance.
 The ``-audiodev`` and ``-audio`` command line options are now the only
 way to specify audio backend settings.
 
+Using ``-audiodev`` to define the default audio backend (removed in 8.2)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
 QEMU does not create default audio backends anymore if any of the
 ``-audiodev``, ``-audio`` or ``-nodefaults`` options are used on the
 command line.
 
+If an audio backend is created with ``-audiodev``, each sound card
+that wants to use it should specify an ``audiodev=``
+property.  Previously, the first audiodev command line option would be
+used as a fallback.
+
 Creating vnc without ``audiodev=`` property (removed in 8.2)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
-- 
2.41.0


