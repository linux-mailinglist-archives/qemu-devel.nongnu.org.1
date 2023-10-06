Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 358AC7BB62F
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:16:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoinX-0000Ow-SB; Fri, 06 Oct 2023 07:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoinQ-0008VX-Cq
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:15:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoinO-0000Nh-IH
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rDhVfR35z3X3xylEmcM6bmMtPhshZV4B0CfwZiTj6Bo=;
 b=XnXHub5eeMw6Q6YRFUFrwSBAApr2BdAKt63hsQk1asPKfDvbTAgscD9RIan+A/G4pTgglu
 VvAuSG6U8K5dyB+FpBLkfREBQrOvFJhvSy4yvcOaZC796jlY7v8Inek9OOkMunzSK75Ka5
 SBlREx4Wb8EGcAs+abfkfh63l58WfvE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-_FPqIUVZN8e237eDPaDXzA-1; Fri, 06 Oct 2023 07:14:59 -0400
X-MC-Unique: _FPqIUVZN8e237eDPaDXzA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9b274cc9636so178638666b.0
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590898; x=1697195698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rDhVfR35z3X3xylEmcM6bmMtPhshZV4B0CfwZiTj6Bo=;
 b=lFnt2XKbPs3iZdyMEOy/ZiZC5VivNzrMoOgkMh89LEGUU5sc3eU00rFWvTS8cK5X8L
 inuoNextgIPM+8yI1lTZimW2K2JI0M36vQhN0eUftejnjqoNRtLK75Icpw7zQAUFbBTb
 c4Esxk/FuXgzOT+ysVx3bv2zXlj2ZPoEGwQZmfjQX/DEywv276/3E/wjHPu10hwDI3i+
 0DnDkGHc1Pyd9Y4YD4LqvGRx2lcTy3gR8Wdv3cG3x68pnUZ7YsErV2XyoUTyrxYGMRNv
 cuU4c1lKlfc1idv1fV4tFPN31Wu9X9ro08cwe3c6zKEuUI7I6HG9R0XV92raNXe/8fmt
 BVlA==
X-Gm-Message-State: AOJu0YwuyysxidyZHTVIoE4rrtnGQFvNU47wb7cm6p2VdnkR0adAWIb0
 rin06z/djCsSo+SKovk8UiIlFiCGqrSyr8OA9aASt4cLfcN8sLyGiMcFqhEdniipMVNhczo9S+L
 PVLFHidrJ5CpkRgPLtM+S/vDB4RG0LLwCAgKNCnV6xt0CuFCz8xU0hGYw6Tc0MeaSbA7hSCK1EA
 Q=
X-Received: by 2002:a17:907:6c14:b0:9b6:f0e2:3c00 with SMTP id
 rl20-20020a1709076c1400b009b6f0e23c00mr5950163ejc.71.1696590898021; 
 Fri, 06 Oct 2023 04:14:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA6aJbx3nZw6ZmAcKyf2rBrD/q4pKizMH4Tk+aBfiIG450hbKuN+EEH/n3+EUKryLPp8dqWA==
X-Received: by 2002:a17:907:6c14:b0:9b6:f0e2:3c00 with SMTP id
 rl20-20020a1709076c1400b009b6f0e23c00mr5950147ejc.71.1696590897572; 
 Fri, 06 Oct 2023 04:14:57 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 qh9-20020a170906eca900b009add084a00csm2705612ejb.36.2023.10.06.04.14.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 04:14:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/26] audio: do not use first -audiodev as default audio device
Date: Fri,  6 Oct 2023 13:14:10 +0200
Message-ID: <20231006111412.13130-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006111412.13130-1-pbonzini@redhat.com>
References: <20231006111412.13130-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 docs/about/removed-features.rst | 15 +++++++++++++++
 3 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index a5e6eb4952e..bd4bcabccaf 100644
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
                     error_append_hint(errp, "Perhaps you wanted to use -audio or set audiodev=%s?\n",
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
index 8a0a8fe0765..ed94b4cd0c8 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -442,6 +442,21 @@ line using a ``secret`` object instance.
 The ``-audiodev`` and ``-audio`` command line options are now the only
 way to specify audio backend settings.
 
+Using ``-audiodev`` to define the default audio backend (removed in 8.2)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+If no audiodev property is specified, previous versions would use the
+first ``-audiodev`` command line option as a fallback.  Starting with
+version 8.2, audio backends created with ``-audiodev`` will only be
+used by clients (sound cards, machines with embedded sound hardware, VNC)
+that refer to it in an ``audiodev=`` property.
+
+In order to configure a default audio backend, use the ``-audio``
+command line option without specifying a ``model``; while previous
+versions of QEMU required a model, starting with version 8.2
+QEMU does not require a model and will not create any sound card
+in this case.
+
 Note that the default audio backend must be configured on the command
 line if the ``-nodefaults`` options is used.
 
-- 
2.41.0


