Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EA87C80D3
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:53:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqC-00084p-9S; Fri, 13 Oct 2023 04:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpq-0007fh-8K
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:54 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpl-0000pf-Vi
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:54 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32799639a2aso1705878f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186861; x=1697791661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rYpwtOT4w+/NrTAyVuKrG5FHgvewvVOKRsjD0G9Vf1E=;
 b=Qqzoc8HzBe9B3ROigNqdMm292290TbepxXyB5zgkSisgZs0ndhueHf3G9sIsZflh4k
 XyWkpB9wtlveSRrEunpZZuC26+oF178aYlVxNuBrAOjP3xWuR/VP6cwwxpyzJQzgs+1C
 EQDt+QcYljA+0OYLx2QEUc5mXIIqzpTGYXtz4jOrq1SmVXiL/WlTw9PFmhkM8iaewA03
 bfCHTP1waiPgN3p1AGtDS43ZusZTvE+sA9ulsN0HFu9XtcenwMaEu0LnfEXGQjoGw61g
 lBDXq7zalDqhYjMbHJvnduEYefSSptarN0hvujtmiy5k9ahBH1eGICyIoHhu49yn7Dcp
 nVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186861; x=1697791661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rYpwtOT4w+/NrTAyVuKrG5FHgvewvVOKRsjD0G9Vf1E=;
 b=Lu7PGZtvIXcnpWktbTBIwkDL93vEpLEOYTfPs8FE7qxTad5Z+OZoMefeqyRBOngwbU
 vzz4M6R3FhHWCdGBKXh4ruRLK1oV/zFYf/LZqofnGJdQrWP6AV014rYqnkbuFbqBGN9Y
 RiXOT0wjMwaxqE03wZ/YnvnnW1pCOCm1SuqXF1riH3NIPmJ5RsN8q2Nt3xv1+lU+H8SN
 VFtCn+l1++wQqm2wjtrxw+gAtf4XEFeyWq1gm77gmV6TVWZDt+B5B6A0kUeEM10to19K
 Aut7x44AFwz4+aFnpMOPIM90G93EJ+tidYmp4njxizZEFQ1J+9JnV9dj0f5rb0CeG+ue
 kmWA==
X-Gm-Message-State: AOJu0Ywb8t2fMH/6MuQoE/FvuGrLGrpUloEbu25Wu+g1TBQa90uhiTsV
 Utl3XBYFYNRUcHX4Z3tzYnfBYlkfEOSt+sjg3+4=
X-Google-Smtp-Source: AGHT+IE3Tv8b4E1NVZKnVENx2ix834qD7w3JQv+BiA2ZOlm93gda4lEcpU8HhPeZIv2CPFSNyDh79g==
X-Received: by 2002:adf:e187:0:b0:32d:89ca:1761 with SMTP id
 az7-20020adfe187000000b0032d89ca1761mr5631589wrb.43.1697186861583; 
 Fri, 13 Oct 2023 01:47:41 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:47:41 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: [RFC PATCH v3 16/78] audio: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:45:44 +0300
Message-Id: <ddf0cdc499d6de6cbffad0575065c799eeb693fe.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 audio/audio.c     | 16 ++++++++--------
 audio/jackaudio.c |  4 ++--
 audio/pwaudio.c   |  4 ++--
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index e9815d6812..ed7c795af7 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -250,23 +250,23 @@ static int audio_pcm_info_eq (struct audio_pcm_info *info, struct audsettings *a
     switch (as->fmt) {
     case AUDIO_FORMAT_S8:
         is_signed = true;
-        /* fall through */
+        fallthrough;
     case AUDIO_FORMAT_U8:
         break;
 
     case AUDIO_FORMAT_S16:
         is_signed = true;
-        /* fall through */
+        fallthrough;
     case AUDIO_FORMAT_U16:
         bits = 16;
         break;
 
     case AUDIO_FORMAT_F32:
         is_float = true;
-        /* fall through */
+        fallthrough;
     case AUDIO_FORMAT_S32:
         is_signed = true;
-        /* fall through */
+        fallthrough;
     case AUDIO_FORMAT_U32:
         bits = 32;
         break;
@@ -290,14 +290,14 @@ void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as)
     switch (as->fmt) {
     case AUDIO_FORMAT_S8:
         is_signed = true;
-        /* fall through */
+        fallthrough;
     case AUDIO_FORMAT_U8:
         mul = 1;
         break;
 
     case AUDIO_FORMAT_S16:
         is_signed = true;
-        /* fall through */
+        fallthrough;
     case AUDIO_FORMAT_U16:
         bits = 16;
         mul = 2;
@@ -305,10 +305,10 @@ void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as)
 
     case AUDIO_FORMAT_F32:
         is_float = true;
-        /* fall through */
+        fallthrough;
     case AUDIO_FORMAT_S32:
         is_signed = true;
-        /* fall through */
+        fallthrough;
     case AUDIO_FORMAT_U32:
         bits = 32;
         mul = 4;
diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index 974a3caad3..fc602411cd 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -576,7 +576,7 @@ static void qjack_client_fini_locked(QJackClient *c)
     switch (c->state) {
     case QJACK_STATE_RUNNING:
         jack_deactivate(c->client);
-        /* fallthrough */
+        fallthrough;
 
     case QJACK_STATE_SHUTDOWN:
         jack_client_close(c->client);
@@ -587,7 +587,7 @@ static void qjack_client_fini_locked(QJackClient *c)
         g_free(c->process_buffers);
 
         c->state = QJACK_STATE_DISCONNECTED;
-        /* fallthrough */
+        fallthrough;
 
     case QJACK_STATE_DISCONNECTED:
         break;
diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index bf26fadb06..89b31617a6 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -497,13 +497,13 @@ qpw_set_position(uint32_t channels, uint32_t position[SPA_AUDIO_MAX_CHANNELS])
     case 8:
         position[6] = SPA_AUDIO_CHANNEL_SL;
         position[7] = SPA_AUDIO_CHANNEL_SR;
-        /* fallthrough */
+        fallthrough;
     case 6:
         position[2] = SPA_AUDIO_CHANNEL_FC;
         position[3] = SPA_AUDIO_CHANNEL_LFE;
         position[4] = SPA_AUDIO_CHANNEL_RL;
         position[5] = SPA_AUDIO_CHANNEL_RR;
-        /* fallthrough */
+        fallthrough;
     case 2:
         position[0] = SPA_AUDIO_CHANNEL_FL;
         position[1] = SPA_AUDIO_CHANNEL_FR;
-- 
2.39.2


