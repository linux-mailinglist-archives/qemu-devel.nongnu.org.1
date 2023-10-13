Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A05DF7C8017
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:25:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCwP-0004ta-7J; Fri, 13 Oct 2023 03:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCwL-0004pW-PG
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:50:33 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCw6-0004RG-S5
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:50:33 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-32caaa1c493so1474141f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183417; x=1697788217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VKQKRFN28e3kmjOkBArdYuYESMT4wctP/PohXvBXbu8=;
 b=xKphdBkjnN/ae963vYXpUrkF2STIkbj1evl8XrpJDm9/ba46wySJVlSblOyctFOURO
 oK26dP893qyav0jieXFrC2XY0MLxJr0zDuLppT/XNmibLU8GdXQgZ5vELdcLczKdESzJ
 9UuVd+peelyxPKEJG+M0psukEpQp+wFefDFbcLtjp9QfqvyUZYtUPT4CCtW+mWBb8oWu
 D0DSZli6ABq/bsai7bUQRLUKLKSNvtj3FsI5zNBPejFAHzxcuAQvUKnZk64D4pV/VrHO
 BmHm5HD43MAqT44YqEYEtkvzGKm+GCPbgCNj82CsUzDpxJrQkNiOATKneuJHaIpIrrNi
 IV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183417; x=1697788217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VKQKRFN28e3kmjOkBArdYuYESMT4wctP/PohXvBXbu8=;
 b=X2HmVO5IGaMR1uygQixiIoNmlloIx0Q/wgXwu4YqnB52NTrbNQX3QwHQ0as27nXKVu
 4PJ/UF684/JS/gBLJzPcGSSJh4juAJXOahi5hi+6x0wzWyWV9iBNzv/Q51cZxkuhmmm1
 1V7xjEOQ6nL1NpoBIUW0SXKZWuWsVCou8CPtQi8oxf1yg28EerFpqL5BW+2QHPk8OJwZ
 +gG4SDvke9y3jiSg6rw2JEga9iGpgfXejWS5UGAnX3ADwA9GfPvLB0ENpuCkIY1PCcPs
 b1KD/g5yPYUvNrNwHG9KCtgQgrbZrINQbZxt8DqR6K4YNzoTLoUHDuCzJV29CoDtWsPH
 3SvA==
X-Gm-Message-State: AOJu0YyvIVGOyOtsgRvhCIgMQOc4lun7HspVKRWXScFqQBlGx8juUD05
 scCcGljfRvHoC8AxGQIlHuvk5Ho6FFMHjn5qJm0=
X-Google-Smtp-Source: AGHT+IH88UN9ANhVaz4Vpwl4T895r5eT+izGLn+Fs24GD+Z88YwWnqzoqnKSzjktiIVZVn9M/g3RMA==
X-Received: by 2002:adf:c846:0:b0:32d:84fe:359a with SMTP id
 e6-20020adfc846000000b0032d84fe359amr5110019wrh.34.1697183417138; 
 Fri, 13 Oct 2023 00:50:17 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:50:16 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: [RFC PATCH 16/78] audio: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:47:20 +0300
Message-Id: <9f8879f961e38a2adfd205129beb94788de64c2e.1697183082.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x435.google.com
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
@@ -245,39 +245,39 @@ static int audio_validate_settings (struct audsettings *as)
 static int audio_pcm_info_eq (struct audio_pcm_info *info, struct audsettings *as)
 {
     int bits = 8;
     bool is_signed = false, is_float = false;
 
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
 
     default:
         abort();
     }
     return info->freq == as->freq
         && info->nchannels == as->nchannels
         && info->is_signed == is_signed
         && info->is_float == is_float
         && info->bits == bits
         && info->swap_endianness == (as->endianness != AUDIO_HOST_ENDIANNESS);
 }
@@ -285,45 +285,45 @@ static int audio_pcm_info_eq (struct audio_pcm_info *info, struct audsettings *a
 void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as)
 {
     int bits = 8, mul;
     bool is_signed = false, is_float = false;
 
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
         mul = 4;
         break;
 
     default:
         abort();
     }
 
     info->freq = as->freq;
     info->bits = bits;
     info->is_signed = is_signed;
     info->is_float = is_float;
     info->nchannels = as->nchannels;
     info->bytes_per_frame = as->nchannels * mul;
     info->bytes_per_second = info->freq * info->bytes_per_frame;
     info->swap_endianness = (as->endianness != AUDIO_HOST_ENDIANNESS);
 }
diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index 974a3caad3..fc602411cd 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -574,22 +574,22 @@ static int qjack_init_in(HWVoiceIn *hw, struct audsettings *as,
 static void qjack_client_fini_locked(QJackClient *c)
 {
     switch (c->state) {
     case QJACK_STATE_RUNNING:
         jack_deactivate(c->client);
-        /* fallthrough */
+        fallthrough;
 
     case QJACK_STATE_SHUTDOWN:
         jack_client_close(c->client);
         c->client = NULL;
 
         qjack_buffer_free(&c->fifo);
         g_free(c->port);
         g_free(c->process_buffers);
 
         c->state = QJACK_STATE_DISCONNECTED;
-        /* fallthrough */
+        fallthrough;
 
     case QJACK_STATE_DISCONNECTED:
         break;
     }
 }
diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index bf26fadb06..89b31617a6 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -487,31 +487,31 @@ static void
 qpw_set_position(uint32_t channels, uint32_t position[SPA_AUDIO_MAX_CHANNELS])
 {
     memcpy(position, (uint32_t[SPA_AUDIO_MAX_CHANNELS]) { SPA_AUDIO_CHANNEL_UNKNOWN, },
            sizeof(uint32_t) * SPA_AUDIO_MAX_CHANNELS);
     /*
      * TODO: This currently expects the only frontend supporting more than 2
      * channels is the usb-audio.  We will need some means to set channel
      * order when a new frontend gains multi-channel support.
      */
     switch (channels) {
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
         break;
     case 1:
         position[0] = SPA_AUDIO_CHANNEL_MONO;
         break;
     default:
         dolog("Internal error: unsupported channel count %d\n", channels);
     }
 }
-- 
2.39.2


