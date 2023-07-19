Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A652759914
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 17:02:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM8fw-0003Uy-Ux; Wed, 19 Jul 2023 11:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qM8fu-0003UT-Vf
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 11:01:11 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qM8ft-0001nu-42
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 11:01:10 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3159d5e409dso623101f8f.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 08:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689778867; x=1692370867;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=que6iuJEIIMG35TRiCvJ/mt6LAIYpcZEmLyUidZkSX0=;
 b=KDL3mzC6kyKOkFt0OpN59nVObASVygIvCp/i3lJRHTla8gf/C5F92fWyMA0fgBQ6hi
 OQbJ9QxH8WZiTiqg4G7T+HhqUjyuTL+3KBbBlc2PU6GJfzIqh//9uMZPOFAA60XGLTJ4
 8ibRC/phN2+jDyE4qO6K1RgDgtsuwVm0eJ6qpmWX4qjEyUdjqkoJWc+KvKN37Jl9uTfJ
 dBj1lYa/nmPJXwh14TutoiKVKKendReMp23avAhzI2W75T4YesqOio3UJxwZv2HILwro
 WWq/MxZf8EECQ+93JYGvtAYjIUG1uVSLwosF9NvEDqQB2cdpBdGr2zPrNfq9d0TVol5o
 aekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689778867; x=1692370867;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=que6iuJEIIMG35TRiCvJ/mt6LAIYpcZEmLyUidZkSX0=;
 b=kYLMosxMyFwR2uJZzOfRjOO3GnLo3JQOqflCRTiD3U4TGRQyt76KdJQpKB6rDq8Pnl
 8fwXc3vINwx2m1nkG/c1Ujm9LEAgAEnp5iD8ZIIj+U0UF1HvqJz73OtlH7yX6G1VTu7g
 2Bm02I1/DJIVKmoj+HZlOVFc6euMBpRa2KdRrIYt4JRXSHQVQcbI3Bst5/Pccluzvxvk
 KXomt8f33wvqdxsJFGM30YzC0sQjWYAmXvv4l1NzPT9FAP8G9MUD4Rt7QJAGyYDGJ2Sp
 JJ7zsyCtkQeolqfBdam1zKPtbZEc5ctFodWDb6BwIYrKf6LhnZkRdUCjTxrvbo/aiHOC
 vr4Q==
X-Gm-Message-State: ABy/qLZ0GEa4VyYz8tLSpFSSYyRaX2DzBnKNlABEgb35Gnnc3j+jHqjx
 Bz5L8VzU1EUPbfjmPhrqvv5gWnwSpEUqxY73hdI=
X-Google-Smtp-Source: APBJJlEnsJhL1HOsi5tr+iAgl0GKVtKL4iC+orh5sfx6LxiVPGLgj+GcrrF1YgF8uDAOTjPR7fYntA==
X-Received: by 2002:adf:f390:0:b0:314:11e6:da8a with SMTP id
 m16-20020adff390000000b0031411e6da8amr51045wro.1.1689778867226; 
 Wed, 19 Jul 2023 08:01:07 -0700 (PDT)
Received: from localhost.localdomain ([176.187.201.220])
 by smtp.gmail.com with ESMTPSA id
 h4-20020a05600004c400b00313f07ccca4sm5517833wri.117.2023.07.19.08.01.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Jul 2023 08:01:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH for-8.1] tests/test-util-filemonitor: Avoid pointless
 allocations
Date: Wed, 19 Jul 2023 17:01:03 +0200
Message-Id: <20230719150103.36634-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Coverity reports few resource leaks. While they are
harmless, fix them to avoid them showing on the reports.

Reported-by: Coverity (CID 1432615: RESOURCE_LEAK)
Fixes: 4f370b1098 ("test-util-filemonitor: Skip test on non-x86 Travis containers")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/test-util-filemonitor.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tests/unit/test-util-filemonitor.c b/tests/unit/test-util-filemonitor.c
index b629e10857..3ca687860d 100644
--- a/tests/unit/test-util-filemonitor.c
+++ b/tests/unit/test-util-filemonitor.c
@@ -398,7 +398,7 @@ test_file_monitor_events(void)
     };
     Error *local_err = NULL;
     GError *gerr = NULL;
-    QFileMonitor *mon = qemu_file_monitor_new(&local_err);
+    QFileMonitor *mon;
     QemuThread th;
     GTimer *timer;
     gchar *dir = NULL;
@@ -407,12 +407,9 @@ test_file_monitor_events(void)
     char *pathsrc = NULL;
     char *pathdst = NULL;
     QFileMonitorTestData data;
-    GHashTable *ids = g_hash_table_new(g_int64_hash, g_int64_equal);
+    GHashTable *ids;
     char *travis_arch;
 
-    qemu_mutex_init(&data.lock);
-    data.records = NULL;
-
     /*
      * This test does not work on Travis LXD containers since some
      * syscalls are blocked in that environment.
@@ -423,6 +420,12 @@ test_file_monitor_events(void)
         return;
     }
 
+    mon = qemu_file_monitor_new(&local_err);
+    ids = g_hash_table_new(g_int64_hash, g_int64_equal);
+
+    qemu_mutex_init(&data.lock);
+    data.records = NULL;
+
     /*
      * The file monitor needs the main loop running in
      * order to receive events from inotify. We must
-- 
2.38.1


