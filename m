Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 482B77A9253
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 09:56:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjEWv-0005Ro-HH; Thu, 21 Sep 2023 03:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjEWt-0005QH-De
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:55:19 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjEWr-0001kc-Tj
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:55:19 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c3bd829b86so5362675ad.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 00:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1695282916; x=1695887716;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BwxdqCjoYRjwt5W3IBIll6piBuHczsH0wiYwmGYAieo=;
 b=b8HfBxF38uEGvmUWIxAFkVR+Pm3ENjqaxypFiO3IiZEJGgQIEPOqwUfM/7RHK/zTGd
 7OcGOzfVceHveHev1MY9mgfdXD+pjbv1F/fBhrEZ5goQOOmj3j8L47jAZXIzWhTMna8F
 dVl9RM6TXYiuVbqHrFiVV2ud0KSPGGMyMelp8cSiGBc1tDU63cIZZ6G4DCttsKb6pQvi
 rOpEsoxzPS9uMwY0c4KScCnycfT6+9iEeyFkRD1YsIGv3ETRW8Tq5xeAAo/UMSKQ/E2h
 LLyjBAmemhxLBtuvRM47kaFi1CzaVjJjkLVkbbl7MvfwqDST5k26AaVqE5z5f6K7HBTV
 bc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695282916; x=1695887716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BwxdqCjoYRjwt5W3IBIll6piBuHczsH0wiYwmGYAieo=;
 b=F9TAQcO2fr0+sEjlfxdVUiZ4DBVpA3eYbZbLbBt6qHeS2/eAf90ZtsSTITh3QQO2Cd
 4d79/urO+E/R/lSu+N3Co4pBAhxrwJvMbfjywfJ2cXpeD+GOPqF9qhcFiaAKAF8FTl3H
 qkBd7/Y+izs15qV4sj3JjUF19qpgp4FQ3XO/MpdY9Ef104i7LG17QajyoXwtVljHSQXI
 nyUYwABoGkFxQn5E5WZmNCujNE2J3S5V7N6u6VUOjoq2o6mVJ49dEEFenZ5S6EIRxndi
 /rBZvhBjV/+NlZEtLtR7qygU7htbZUvU1zmJHSrbhkc/fluESfArU8zUCQZxOGmgrqun
 U8Tw==
X-Gm-Message-State: AOJu0YwgDGtK0Vn88cbOnVdll0r6ETzEeZUx9ljwKU/aX58bbbXVVYjc
 qZpxljcuvwr1XewVV+fRJUVRaQjQriVyGODouVc=
X-Google-Smtp-Source: AGHT+IH7nIquB+DMv/CPBw8OR3yLj3tGkrYUNDykHy4NgyvuZ2VSaZVzLcNtjkCnMAQ9X4Na0Bz7dA==
X-Received: by 2002:a17:902:e5d2:b0:1c3:ae56:4594 with SMTP id
 u18-20020a170902e5d200b001c3ae564594mr4273593plf.49.1695282916472; 
 Thu, 21 Sep 2023 00:55:16 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:a840:1e00:d54:e521:8bac:7bed])
 by smtp.gmail.com with ESMTPSA id
 p22-20020a170902a41600b001ae0152d280sm761928plq.193.2023.09.21.00.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 00:55:16 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, virtio-fs@redhat.com,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Yan Vugenfirer <yan@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 7/8] util: Remove qemu_get_local_state_dir()
Date: Thu, 21 Sep 2023 16:54:21 +0900
Message-ID: <20230921075425.16738-8-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921075425.16738-1-akihiko.odaki@daynix.com>
References: <20230921075425.16738-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

There are no users of the function anymore.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/qemu/osdep.h |  8 --------
 util/oslib-posix.c   |  6 ------
 util/oslib-win32.c   | 10 ----------
 3 files changed, 24 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index bb857c910f..cc585447ef 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -628,14 +628,6 @@ ssize_t qemu_write_full(int fd, const void *buf, size_t count)
 
 void qemu_set_cloexec(int fd);
 
-/* Return a dynamically allocated directory path that is appropriate for storing
- * local state.
- *
- * The caller is responsible for releasing the value returned with g_free()
- * after use.
- */
-char *qemu_get_local_state_dir(void);
-
 /**
  * qemu_get_runtime_dir:
  *
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 0c82717be5..f3054ad2cd 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -267,12 +267,6 @@ int qemu_socketpair(int domain, int type, int protocol, int sv[2])
     return ret;
 }
 
-char *
-qemu_get_local_state_dir(void)
-{
-    return get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR);
-}
-
 char *
 qemu_get_runtime_dir(void)
 {
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 38df7b57b5..f93c3bff8e 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -229,16 +229,6 @@ int qemu_get_thread_id(void)
     return GetCurrentThreadId();
 }
 
-char *
-qemu_get_local_state_dir(void)
-{
-    const char * const *data_dirs = g_get_system_data_dirs();
-
-    g_assert(data_dirs && data_dirs[0]);
-
-    return g_strdup(data_dirs[0]);
-}
-
 char *
 qemu_get_runtime_dir(void)
 {
-- 
2.41.0


