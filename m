Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9DF7A985D
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 19:41:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjNcb-0002A7-KW; Thu, 21 Sep 2023 13:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcY-00028K-Lt
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:46 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcO-0007hi-Vo
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:46 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-404fbfac998so14385095e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 10:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695317853; x=1695922653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TcYlraAFAOOQRcPGC3TvQT/INQls2RJxIkH/pggGmhw=;
 b=pQx5C5rDXJIkYEL9Fxor9YnSPw5MMZ6NAsjeErWduNTK+JC5RAAsusxHRzPcp7UMfR
 c66mZdcCHHFsN0XAm8l1b5AkRqi1HQSuwOsJ+VN+vlF3O6k5MgA+ZhRahEbt2oxfj74T
 LC3w12r+NEWCInaynhjsvwIstK4WeV383VigCROLiXiM6KMvM6SGQRrXrFR0wQQKNwnw
 l7Jhznvyd9UDSTZY2sSA52hbPnyK64/lh4cMME/DJq4LdEy8m+OUkdvkuJOqvnlOxdp9
 SmIPikofrLQmeyNrTYtNP3RsmCQn58JxacV5Ommr6+jHkaCUEPcQMXIolRX8ukMfYBcl
 j5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695317853; x=1695922653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TcYlraAFAOOQRcPGC3TvQT/INQls2RJxIkH/pggGmhw=;
 b=p++6rodwqHk4g8hTGZzuXaejY42wcBxYCrzuMqZbKN1NFxF4H6z8/EV9+yzzNnIovK
 aew/FCTzQ/H3wersQo1MoftDSMyKqnpwZnTIuvZCNB8I5i4Wk3UT54LsC5x/N/vr81y/
 P7/g/So04gtJLXbp0985h5P5nHhVjzzo5uuVjF/S7vAPmK+f3CyM2vzfPCi+l0tCFDXb
 TDy7tGGjO73fPHA7bUsgHMFi0uHjI/cKuVnDWZYHtzZ2lLncF4gkcHI0sdTvAZPk/Iz6
 v4E05E1jfDZxkI2x2vJxsl+6LHgnfd1MO9wtnkcz+3ljECn84AiberhANNZ/271y103w
 el8w==
X-Gm-Message-State: AOJu0YzYu6enalqeds2JeRd9f6MoHMI/FIcYxp2xAE4/mG+ZQRNZO/GK
 QgLdCU8plUTUqHeBUVMHM5gSeeqVCunr+U+o/LM=
X-Google-Smtp-Source: AGHT+IEmhWQvU1jpiNMnyyKFUa+gFvsWa8XAcg+MViTVf78LdBGvAVaA0NdQVEqajsKs3Y+2pBDxFQ==
X-Received: by 2002:a1c:4b0e:0:b0:402:ea83:45cf with SMTP id
 y14-20020a1c4b0e000000b00402ea8345cfmr6069426wma.2.1695317853590; 
 Thu, 21 Sep 2023 10:37:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a7bce0e000000b003feff926fc5sm2464122wmc.17.2023.09.21.10.37.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 10:37:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/30] audio/jackaudio: Avoid dynamic stack allocation in
 qjack_process()
Date: Thu, 21 Sep 2023 18:37:14 +0100
Message-Id: <20230921173720.3250581-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921173720.3250581-1-peter.maydell@linaro.org>
References: <20230921173720.3250581-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-id: 20230818155846.1651287-3-peter.maydell@linaro.org
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


