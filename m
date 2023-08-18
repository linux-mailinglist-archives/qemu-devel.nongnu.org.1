Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A36780FB2
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 17:59:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX1sF-0005Ja-8D; Fri, 18 Aug 2023 11:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qX1sD-0005J5-DI
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:58:53 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qX1sA-0004wd-FL
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:58:53 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fe45481edfso10489335e9.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692374329; x=1692979129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tt8gFXZAVgdSU8JxW7d1fDhLvNPeIviD1msZV2xcw/0=;
 b=N+simupBpQC/XNMuPjHaVTjvwF9Q5bN3vSU5CC15EUYwYKLzB9ltQr8cKJBWZN2LFV
 7k71gTogBVFVAW/evF27LAF+9/Hcj2nOw0NfcERIhN9rze1cwLUjlTz0dLlMdbrLVsH6
 BU1rkPegAWei2ocylJTtb6+GAMoBLraY7DI7J9PAttJNk++hjaP0XzRZV3gWoifBfN7z
 kQknWNx2DxI8XAznWDIMw0H/B10bq3Jae86KhKFc7rS+b/2e32mChg+UH58VFWwdUpvG
 OJlgVQ5J6VoOIOScvJpwT3SUS62xLoLNNDSl4aJQSw5bJInBfJHZW23LgddpYNsmsIT0
 vwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692374329; x=1692979129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tt8gFXZAVgdSU8JxW7d1fDhLvNPeIviD1msZV2xcw/0=;
 b=CLg6fS1Z2dlUh3lxr2JLXIB2XizDnP86VUq41CM8BxJsHMzwu9rQ3XseKWQGeXF6xI
 jYp7bmc02HDJep9BKy+jxh63a3wtQqSCQhsW+wybQRgeuGFCSE7UoFYQ+EFRgFpqy7RG
 Gtf5iEUZlh0dZouWyB41di+f93Pk38WLSRwsG9yAgOt28J4F4PL43mmikKKKsqWHbXTN
 qKbBWwx8P8oZDDAeY0dmDhlplyLJ7btGlLO2q/AcITc0wCzwDFxR3w/a3bRZD3jdDiPs
 jNIiWmpLunv3/POvyH46PscX6+Gw7cSEVGhGRX3MppWNlRY03TB/2VSeJmDKuj7WxKVB
 5r0A==
X-Gm-Message-State: AOJu0YxBRToDVKtvwAWlfL3dFm5Pts0O0sgb6CAp7ol/T80xRXztmbMk
 Ei4O3ny5D5ffjfTl3HW8glsvWbpH2DKvQ19932k=
X-Google-Smtp-Source: AGHT+IHrRHQAa8psh6HkaX5DtFA1zBhnSH53y7d1O3vf6UXmyS3CdSOmIoDaAixhXM5u5J6Xa3raDQ==
X-Received: by 2002:a7b:cb8e:0:b0:3f8:fc96:6bfd with SMTP id
 m14-20020a7bcb8e000000b003f8fc966bfdmr2461506wmi.17.1692374328768; 
 Fri, 18 Aug 2023 08:58:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 y21-20020a7bcd95000000b003fbb346279dsm3275702wmj.38.2023.08.18.08.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 08:58:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: [PATCH 2/2] audio/jackaudio: Avoid dynamic stack allocation in
 qjack_process()
Date: Fri, 18 Aug 2023 16:58:46 +0100
Message-Id: <20230818155846.1651287-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818155846.1651287-1-peter.maydell@linaro.org>
References: <20230818155846.1651287-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Avoid a dynamic stack allocation in qjack_process().  Since this
function is a JACK process callback, we are not permitted to malloc()
here, so we allocate a working buffer in qjack_client_init() instead.

The codebase has very few VLAs, and if we can get rid of them all we
can make the compiler error on new additions.  This is a defensive
measure against security bugs where an on-stack dynamic allocation
isn't correctly size-checked (e.g.  CVE-2021-3527).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This feels like we ought to be able to say "we know there are at most
X channels, so allocate an array of size X on the stack", but I
couldn't find anything in the audio subsystem from a quick look that
set an obvious bound on the number of channels.  Is there some
straightforward constant MAX_CHANNELS somewhere?
---
 audio/jackaudio.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index 7cb2a49f971..e1eaa3477dc 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -70,6 +70,9 @@ typedef struct QJackClient {
     int             buffersize;
     jack_port_t   **port;
     QJackBuffer     fifo;
+
+    /* Used as workspace by qjack_process() */
+    float **process_buffers;
 }
 QJackClient;
 
@@ -267,22 +270,21 @@ static int qjack_process(jack_nframes_t nframes, void *arg)
     }
 
     /* get the buffers for the ports */
-    float *buffers[c->nchannels];
     for (int i = 0; i < c->nchannels; ++i) {
-        buffers[i] = jack_port_get_buffer(c->port[i], nframes);
+        c->process_buffers[i] = jack_port_get_buffer(c->port[i], nframes);
     }
 
     if (c->out) {
         if (likely(c->enabled)) {
-            qjack_buffer_read_l(&c->fifo, buffers, nframes);
+            qjack_buffer_read_l(&c->fifo, c->process_buffers, nframes);
         } else {
             for (int i = 0; i < c->nchannels; ++i) {
-                memset(buffers[i], 0, nframes * sizeof(float));
+                memset(c->process_buffers[i], 0, nframes * sizeof(float));
             }
         }
     } else {
         if (likely(c->enabled)) {
-            qjack_buffer_write_l(&c->fifo, buffers, nframes);
+            qjack_buffer_write_l(&c->fifo, c->process_buffers, nframes);
         }
     }
 
@@ -448,6 +450,9 @@ static int qjack_client_init(QJackClient *c)
           jack_get_client_name(c->client));
     }
 
+    /* Allocate working buffer for process callback */
+    c->process_buffers = g_new(float *, c->nchannels);
+
     jack_set_process_callback(c->client, qjack_process , c);
     jack_set_port_registration_callback(c->client, qjack_port_registration, c);
     jack_set_xrun_callback(c->client, qjack_xrun, c);
@@ -579,6 +584,7 @@ static void qjack_client_fini_locked(QJackClient *c)
 
         qjack_buffer_free(&c->fifo);
         g_free(c->port);
+        g_free(c->process_buffers);
 
         c->state = QJACK_STATE_DISCONNECTED;
         /* fallthrough */
-- 
2.34.1


