Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B51ED7B9B2A
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 08:47:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoI9B-0002ia-CB; Thu, 05 Oct 2023 02:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qoI97-0002eV-Pa
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 02:47:43 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qoI93-0001gb-2s
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 02:47:39 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bf6ea270b2so4299345ad.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 23:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696488454; x=1697093254;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zGHIZ/nFu0V+cvCgaiJjxfj7nZj/2FIabbcqcODY2Bg=;
 b=23zJDARF8Wk+RVNfZTw2bbdB68CKl/TKt0bYNiiNQA9HjqSg0DbaA9Ypn4KUmgolum
 rcUD4cLih87tOISNUBCDLsFM+siQ3P/D5JINQOvYxw0kjXU3GKjAYYU7EjuYjqC/+o5q
 4AdFf/lnb3vlU2xCWJtRAu2JkBI4c7P8BCsnKTQPI7XTKmwHc7/OxY5yuDxrDbpeo6n6
 4+FBl4E1ppthyQgbQaQX6J2Mc8hs3m0G+VEsuuXdg3SdVWr0j0jcqiwDkaIzuwVJiIuq
 wyCPKXUEQjlqgtOefvys4S0gXYVQZTlZ3bfMfm2nktunRWUtNmOK93Ft0pbw3IqiQpVg
 kJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696488454; x=1697093254;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zGHIZ/nFu0V+cvCgaiJjxfj7nZj/2FIabbcqcODY2Bg=;
 b=cjgKwMx83cZxzFXnqEX4xK3s6JAG+VTXOg55CMU3vh0DaBlSKgCyIbedG8m9UoBFqC
 u8UFyiNzpC2TEx7sWyNHXccC2yBS1x1a/c57pTTTCskzZ3r239a2Hkz/W5EGmKBu2wDG
 xTsXzgkhyk88VWsjFeZtvd6E5VCCdG8zKbMfRtViglO2wXOlhWVCQtw7rZA1oC1HPKED
 KSimiH3ODog0lv2U3f86A8A4P/njGi1p8LJRcQglw49+5attNHJw+s4WvRDZ6peIA4iR
 K/qMZ7+L+1Na4SbKK89CWppVZGtKhKkR29rjqh9RXV6CSP20ZkQyFt2x8n+f3El0eyg6
 bbUQ==
X-Gm-Message-State: AOJu0YwOPHYYm+ATrI2EdI9CBEqnM6xorOg0LjzNPPl5nvIu5TAjZW/v
 vPkW7jv50YPki5vOnR9bEi9KWw==
X-Google-Smtp-Source: AGHT+IFq9J3yy2mi4+946+ZctoFhX9fffqcquBAIoVyMXDj4uzgyt71XTgM4cBUCf1+LVpspFtCYKg==
X-Received: by 2002:a17:902:db06:b0:1c4:2ca5:8b7c with SMTP id
 m6-20020a170902db0600b001c42ca58b7cmr4453693plx.61.1696488454679; 
 Wed, 04 Oct 2023 23:47:34 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:d54:e521:8bac:7bed])
 by smtp.gmail.com with UTF8SMTPSA id
 jw17-20020a170903279100b001b89466a5f4sm771565plb.105.2023.10.04.23.47.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 23:47:34 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Programmingkid <programmingkidx@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] cutils: Fix get_relocated_path on Windows
Date: Thu,  5 Oct 2023 15:47:25 +0900
Message-ID: <20231005064726.6945-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

get_relocated_path() did not have error handling for PathCchSkipRoot()
because a path given to get_relocated_path() was expected to be a valid
path containing a drive letter or UNC server/share path elements on
Windows, but sometimes it turned out otherwise.

The paths passed to get_relocated_path() are defined by macros generated
by Meson. Meson in turn uses a prefix given by the configure script to
generate them. For Windows, the script passes /qemu as a prefix to
Meson by default.

As documented in docs/about/build-platforms.rst, typically MSYS2 is used
for the build system, but it is also possible to use Linux as well. When
MSYS2 is used, its Bash variant recognizes /qemu as a MSYS2 path, and
converts it to a Windows path, adding the MSYS2 prefix including a drive
letter or UNC server/share path elements. Such a conversion does not
happen on a shell on Linux however, and /qemu will be passed as is in
the case.

Implement a proper error handling of PathCchSkipRoot() in
get_relocated_path() so that it can handle a path without a drive letter
or UNC server/share path elements.

Reported-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
V1 -> V2: Compare against S_OK for clarity (Philippe Mathieu-Daudé)

 util/cutils.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/util/cutils.c b/util/cutils.c
index 25373198ad..770d6e023c 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -1155,17 +1155,21 @@ char *get_relocated_path(const char *dir)
     g_string_append(result, "/qemu-bundle");
     if (access(result->str, R_OK) == 0) {
 #ifdef G_OS_WIN32
-        size_t size = mbsrtowcs(NULL, &dir, 0, &(mbstate_t){0}) + 1;
+        const char *src = dir;
+        size_t size = mbsrtowcs(NULL, &src, 0, &(mbstate_t){0}) + 1;
         PWSTR wdir = g_new(WCHAR, size);
-        mbsrtowcs(wdir, &dir, size, &(mbstate_t){0});
+        mbsrtowcs(wdir, &src, size, &(mbstate_t){0});
 
         PCWSTR wdir_skipped_root;
-        PathCchSkipRoot(wdir, &wdir_skipped_root);
+        if (PathCchSkipRoot(wdir, &wdir_skipped_root) == S_OK) {
+            size = wcsrtombs(NULL, &wdir_skipped_root, 0, &(mbstate_t){0});
+            char *cursor = result->str + result->len;
+            g_string_set_size(result, result->len + size);
+            wcsrtombs(cursor, &wdir_skipped_root, size + 1, &(mbstate_t){0});
+        } else {
+            g_string_append(result, dir);
+        }
 
-        size = wcsrtombs(NULL, &wdir_skipped_root, 0, &(mbstate_t){0});
-        char *cursor = result->str + result->len;
-        g_string_set_size(result, result->len + size);
-        wcsrtombs(cursor, &wdir_skipped_root, size + 1, &(mbstate_t){0});
         g_free(wdir);
 #else
         g_string_append(result, dir);
-- 
2.41.0


