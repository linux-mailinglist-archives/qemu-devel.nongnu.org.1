Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DF380CEDE
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 16:01:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rChlp-0006wR-Gi; Mon, 11 Dec 2023 10:00:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rChlf-0006qe-Rm
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 10:00:29 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rChlQ-0005Ld-7l
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 10:00:19 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-333630e9e43so4722769f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 07:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702306805; x=1702911605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gRGCxW6C87fW7k1z6BNfM3iwOvIKvLjOJp9SZ6n603I=;
 b=psTn2sKAZ8io0Ja3mHR80E3EPHhO3i80JWb/riq/lgAiwNthgZCxzEDDvtBv1G6yVa
 +VJ0zXbnM2XGDduf5XJtRUQyC0+Zjdi+lSK1dlP/3clmxGjB4oTE/Au7saC/8bfF32f3
 HEGIv1B91Loti69JYTzDF0/uMH3Fd4LtH3B5+ohDXVwmsVMYWXH1sXOO9QdHXpMrn0jU
 9LsZJ8lpQL95H/L+PUip0wqMn13CKDyMg6+vJp2Dy3ImJrE4ppjqGff0qtrx1TsCLukt
 Vs8fb/si2uV5Yaw2qyNr2eAWdE4VaZ55j89m13XejX0RcMgexYPpcg82fIY6uw/CFpRR
 9Jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702306805; x=1702911605;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gRGCxW6C87fW7k1z6BNfM3iwOvIKvLjOJp9SZ6n603I=;
 b=DoApP5amifYrM8+lkHSiZGQtQ3BFBJWmWsfbOWp3tTDA1AQr+PA/rH0WVaRM6k7qyH
 xCM7/XjiwlAH9NAZL6e6RijGCm8cOVyVMRNY/i7MqA8pHX3m254ucQenIGaL7ylZvahB
 sKWwygeRET0B/35xer9uNxoya8CUfVHvJAfkoEmbPQUtqSUeKKxT5erJwSh03MPnuAku
 CJT1TUKe2IWAXi6R/MgxMi9+bvG3+fFKwOShPFieOhq0vwrQlN2889g1b3VoSxkZ9swW
 Rx6tKStJAJV76ZcNJ5F4vC82ZddYTSZgNNXF7P+5U+CptfyJ2NmFwT6SXR6F5wHYikqG
 Utbg==
X-Gm-Message-State: AOJu0YwKlLRCurIONJEy6VHh3sI7ipwRRHX6j7PfSq73MskiNLiXU4vi
 BRvbI5esOM6QCjdgM/0pFj0XAw==
X-Google-Smtp-Source: AGHT+IEUUIkKHo/0xFx7yZaTLtZXK4NcxjZWyn9Zw9RScxTNHUHCpuHOgPbH/+1u8t+buIl0fgrtqg==
X-Received: by 2002:adf:fe04:0:b0:333:2fc4:457 with SMTP id
 n4-20020adffe04000000b003332fc40457mr1403498wrr.80.1702306805001; 
 Mon, 11 Dec 2023 07:00:05 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 w13-20020a5d404d000000b003333f9200d8sm8789562wrp.84.2023.12.11.07.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 07:00:04 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1A3C35FBC6;
 Mon, 11 Dec 2023 15:00:04 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH] chardev: use bool for fe_open
Date: Mon, 11 Dec 2023 14:59:59 +0000
Message-Id: <20231211145959.93759-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The function qemu_chr_fe_init already treats be->fe_open as a bool and
if it acts like a bool it should be one. While we are at it add some
kdoc decorations.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/chardev/char-fe.h | 19 ++++++++++++-------
 chardev/char-fe.c         |  8 ++++----
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 0ff6f87511..87b63f8bc8 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -7,8 +7,12 @@
 typedef void IOEventHandler(void *opaque, QEMUChrEvent event);
 typedef int BackendChangeHandler(void *opaque);
 
-/* This is the backend as seen by frontend, the actual backend is
- * Chardev */
+/**
+ * struct CharBackend - back end as seen by front end
+ * @fe_open: the front end is ready for IO
+ *
+ * The actual backend is Chardev
+ */
 struct CharBackend {
     Chardev *chr;
     IOEventHandler *chr_event;
@@ -17,7 +21,7 @@ struct CharBackend {
     BackendChangeHandler *chr_be_change;
     void *opaque;
     int tag;
-    int fe_open;
+    bool fe_open;
 };
 
 /**
@@ -156,12 +160,13 @@ void qemu_chr_fe_set_echo(CharBackend *be, bool echo);
 
 /**
  * qemu_chr_fe_set_open:
+ * @be: a CharBackend
+ * @fe_open: the front end open status
  *
- * Set character frontend open status.  This is an indication that the
- * front end is ready (or not) to begin doing I/O.
- * Without associated Chardev, do nothing.
+ * This is an indication that the front end is ready (or not) to begin
+ * doing I/O. Without associated Chardev, do nothing.
  */
-void qemu_chr_fe_set_open(CharBackend *be, int fe_open);
+void qemu_chr_fe_set_open(CharBackend *be, bool fe_open);
 
 /**
  * qemu_chr_fe_printf:
diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 7789f7be9c..5a09ef4da7 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -257,7 +257,7 @@ void qemu_chr_fe_set_handlers_full(CharBackend *b,
                                    bool sync_state)
 {
     Chardev *s;
-    int fe_open;
+    bool fe_open;
 
     s = b->chr;
     if (!s) {
@@ -265,10 +265,10 @@ void qemu_chr_fe_set_handlers_full(CharBackend *b,
     }
 
     if (!opaque && !fd_can_read && !fd_read && !fd_event) {
-        fe_open = 0;
+        fe_open = false;
         remove_fd_in_watch(s);
     } else {
-        fe_open = 1;
+        fe_open = true;
     }
     b->chr_can_read = fd_can_read;
     b->chr_read = fd_read;
@@ -336,7 +336,7 @@ void qemu_chr_fe_set_echo(CharBackend *be, bool echo)
     }
 }
 
-void qemu_chr_fe_set_open(CharBackend *be, int fe_open)
+void qemu_chr_fe_set_open(CharBackend *be, bool fe_open)
 {
     Chardev *chr = be->chr;
 
-- 
2.39.2


