Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EDD7D039B
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:19:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaQ2-00054N-Ki; Thu, 19 Oct 2023 17:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaQ0-00053c-9c
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:19:00 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaPy-0004pO-9y
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:19:00 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-32dc918d454so98987f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750336; x=1698355136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mJLA18pFybXFPbUpHy1W5xTRic5xRcDchoEnbbPwZSQ=;
 b=I7V+krl9RNg3YV2256XidtTIQ6ogq1G7jL/8xJbHjPeIsgr8zdyF2tQAmngX00WRD0
 KpBSM+Qenkm+n3qiu6wPdShv3phLHyRs2VJFEohZQSmsjcqNTpzilqqSUp/TMMfjGYNR
 AVkWt7cgHbanJwzPmHRfan7NgmDRXV2g1gFH3V1tsl+udylWsMpgJDGyQxbZHgHXQUMb
 TGySfgHy8Cd8n6UIkf819NEESsEOc4OIdqm/t7Bx0oPUqHcvgnopMcnD8dGNnPqUi14L
 LIAtXj891WvH9hKmhLjV1vNAk724ct+u4rDXPMCjXnDWSCI5ZbNm8C7ZPft7Nzn6oWFQ
 EaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750336; x=1698355136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mJLA18pFybXFPbUpHy1W5xTRic5xRcDchoEnbbPwZSQ=;
 b=PupFsqm1AixORGUrQwJ1epNhfw3vVIY8fQVhC79aYOGHnz9Uko3OPuNn+KH9gp3Tz9
 ZdkdI3hXVeZcOZ/RqU/CXxEhR99a1wUd2jjOkr5zMKoHz9tPy2ml3F7f4ZND6sNopSdN
 0F+bvRAtL/5l6CmLnSefue5HGdNXdPpKSmBsaFod7EGwma4H+TQV40aNS9J5uOrMbQPP
 PHf6Z25IBhHFyn7iTJ/4jB7fnwcGPibY+Oy8RmMtuvNL7OA4vmFh6xlhpB3FJn9ySWwR
 S+VLSjT76+nXbnzBObN3N8n531EC6G1hXa1X8JgWtAn342T/NlG5sqqzgCGwlBXHuMUL
 whiw==
X-Gm-Message-State: AOJu0Yy6z+vhGz/vzgr78C8Z/rOe24MU/aM1oezrx3Lt7N7W3CKICmEF
 9HvNeqwMye9TLi/3EGUoeaubY3ABfJLLmjjmhtjIdg==
X-Google-Smtp-Source: AGHT+IEYxWT0/VN73qTkcI+k4L0ezgqbag9tFvKitM7rP1hBYGa7aeUSvgAPV0mPyJyklzoxMG38ZA==
X-Received: by 2002:a5d:4530:0:b0:32d:b8f8:2b18 with SMTP id
 j16-20020a5d4530000000b0032db8f82b18mr2544187wra.32.1697750336705; 
 Thu, 19 Oct 2023 14:18:56 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 r6-20020a5d6946000000b0032da4c98ab2sm219159wrw.35.2023.10.19.14.18.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:18:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/46] cutils: Fix get_relocated_path on Windows
Date: Thu, 19 Oct 2023 23:17:31 +0200
Message-ID: <20231019211814.30576-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

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
Message-ID: <20231005064726.6945-1-akihiko.odaki@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 util/cutils.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/util/cutils.c b/util/cutils.c
index 64f817b477..42364039a5 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -1163,17 +1163,21 @@ char *get_relocated_path(const char *dir)
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


