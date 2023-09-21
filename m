Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B016F7A924E
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 09:55:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjEWP-0004V1-DF; Thu, 21 Sep 2023 03:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjEWO-0004Ut-Al
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:54:48 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjEWL-0001MR-JH
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:54:48 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c5dd017b30so179655ad.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 00:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1695282884; x=1695887684;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uI/Kp4K+XtqHxtYAeT48aX1q/ar4g9aCgFPx0CsLxbY=;
 b=cW9KHB8SyXNfc5DwuMgqjEaCxWtM8lB6Fw2CBy6f0d4EkXVA7UxDrNY44H2xflonKi
 QLbnEnPqxVV1cdejdTo+IV3E1bxcbcWqsw3cYu8KJq+egoqpTrdEoA8TBaZz0G14JuwW
 Idw4duARI2qnbhZGSHZ46xYPqrzXVA2I3PQn6G+I99bamMGavlaATCbD3/2coweRCLGa
 Io4YjpZyu9leTA6cEJEh++N4jPuKZ12FaOGPQYL/9VKtiaDTgCRKBt8xtFS3QdXZSMA6
 BbRmTYVfd785B/Op1QljtcLnHKJWX9DWkkGuLuafG4rxikJQc4uMNbmb8c3Gg6v9NYdQ
 1S1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695282884; x=1695887684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uI/Kp4K+XtqHxtYAeT48aX1q/ar4g9aCgFPx0CsLxbY=;
 b=V5k8a9RGoSwDU9YhI76SxmIYA38+DEIv0fAC1+8Ml66reT9apIu0PsqWULQUbNck9D
 48VKuqYl8UgfOhC9pVlGdlzWlWqOAJpFB6hHn8x2l0/UHOZ7YDb/0WPLqpC53JMc+C1V
 auxoCy257EmgY2P8SveUttQ5LxzGB/lj8Y9s2MRAgUmUCwV3PUFsPYNRZr/uakGKjgio
 DdlaxnvINBqphKtILfXzdbgvlFsWk5JENdr3wNbamQKz66es18NEPpzv/fbT5ABaTVbE
 j0gpia8oZGAbdgqcurs7SDgDjFncJTw1fq3jf3h0QPpePfO4FyK0i2LOAIRkC6R8PJTU
 f+uA==
X-Gm-Message-State: AOJu0YwzgmTHY4HMxvDczre9xemw9aL8nvhLjma1sYmHr55XaZG7Fmb6
 FNoc+Rqbp5L9n/YXiNtmFBe2iGyymfLkx6QaBE4=
X-Google-Smtp-Source: AGHT+IFGVzmlIcIC0WnjXKBiPerXJcLp7Gw8+wBpSNQ9MyxqF6awYw7mKVrGAe8wGqEtAPk+tIpgSw==
X-Received: by 2002:a17:902:ecc5:b0:1c5:9d00:be84 with SMTP id
 a5-20020a170902ecc500b001c59d00be84mr9678037plh.33.1695282884183; 
 Thu, 21 Sep 2023 00:54:44 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:a840:1e00:d54:e521:8bac:7bed])
 by smtp.gmail.com with ESMTPSA id
 p22-20020a170902a41600b001ae0152d280sm761928plq.193.2023.09.21.00.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 00:54:43 -0700 (PDT)
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
Subject: [PATCH v3 1/8] util: Introduce qemu_get_runtime_dir()
Date: Thu, 21 Sep 2023 16:54:15 +0900
Message-ID: <20230921075425.16738-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921075425.16738-1-akihiko.odaki@daynix.com>
References: <20230921075425.16738-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
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

qemu_get_runtime_dir() returns a dynamically allocated directory path
that is appropriate for storing runtime files. It corresponds to "run"
directory in Unix.

With a tree-wide search, it was found that there are several cases
where such a functionality is implemented so let's have one as a common
utlity function.

A notable feature of qemu_get_runtime_dir() is that it uses
$XDG_RUNTIME_DIR if available. While the function is often called by
executables which requires root privileges, it is still possible that
they are called from a user without privilege to write the system
runtime directory. In fact, I decided to write this patch when I ran
virtiofsd in a Linux namespace created by a normal user and realized
it tries to write the system runtime directory, not writable in this
case. $XDG_RUNTIME_DIR should provide a writable directory in such
cases.

This function does not use qemu_get_local_state_dir() or its logic
for Windows. Actually the implementation of qemu_get_local_state_dir()
for Windows seems not right as it calls g_get_system_data_dirs(),
which refers to $XDG_DATA_DIRS. In Unix terminology, it is basically
"/usr/share", not "/var", which qemu_get_local_state_dir() is intended
to provide. Instead, this function try to use the following in order:
- $XDG_RUNTIME_DIR
- LocalAppData folder
- get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run")

This function does not use g_get_user_runtime_dir() either as it
falls back to g_get_user_cache_dir() when $XDG_DATA_DIRS is not
available. In the case, we rather use:
get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run")

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/qemu/osdep.h | 12 ++++++++++++
 util/oslib-posix.c   | 11 +++++++++++
 util/oslib-win32.c   | 26 ++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 2897720fac..bb857c910f 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -636,6 +636,18 @@ void qemu_set_cloexec(int fd);
  */
 char *qemu_get_local_state_dir(void);
 
+/**
+ * qemu_get_runtime_dir:
+ *
+ * Return a dynamically allocated directory path that is appropriate for storing
+ * runtime files. It corresponds to "run" directory in Unix, and uses
+ * $XDG_RUNTIME_DIR if available.
+ *
+ * The caller is responsible for releasing the value returned with g_free()
+ * after use.
+ */
+char *qemu_get_runtime_dir(void);
+
 /**
  * qemu_getauxval:
  * @type: the auxiliary vector key to lookup
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index e86fd64e09..0c82717be5 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -273,6 +273,17 @@ qemu_get_local_state_dir(void)
     return get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR);
 }
 
+char *
+qemu_get_runtime_dir(void)
+{
+    char *env = getenv("XDG_RUNTIME_DIR");
+    if (env) {
+        return g_strdup(env);
+    }
+
+    return get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run");
+}
+
 void qemu_set_tty_echo(int fd, bool echo)
 {
     struct termios tty;
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 19a0ea7fbe..38df7b57b5 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -27,6 +27,8 @@
  */
 
 #include "qemu/osdep.h"
+#include <shlobj.h>
+#include <wchar.h>
 #include <windows.h>
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
@@ -237,6 +239,30 @@ qemu_get_local_state_dir(void)
     return g_strdup(data_dirs[0]);
 }
 
+char *
+qemu_get_runtime_dir(void)
+{
+    size_t size = GetEnvironmentVariableA("XDG_RUNTIME_DIR", NULL, 0);
+    if (size) {
+        char *env = g_malloc(size);
+        GetEnvironmentVariableA("XDG_RUNTIME_DIR", env, size);
+        return env;
+    }
+
+    PWSTR wpath;
+    const wchar_t *cwpath;
+    if (!SHGetKnownFolderPath(&FOLDERID_LocalAppData, KF_FLAG_DEFAULT, NULL, &wpath)) {
+        cwpath = wpath;
+        size = wcsrtombs(NULL, &cwpath, 0, &(mbstate_t){0}) + 1;
+        char *path = g_malloc(size);
+        wcsrtombs(path, &cwpath, size, &(mbstate_t){0});
+        CoTaskMemFree(wpath);
+        return path;
+    }
+
+    return get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run");
+}
+
 void qemu_set_tty_echo(int fd, bool echo)
 {
     HANDLE handle = (HANDLE)_get_osfhandle(fd);
-- 
2.41.0


