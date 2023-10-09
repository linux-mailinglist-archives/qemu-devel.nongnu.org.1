Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4857BD7E6
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 12:04:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpn6z-0003CE-GV; Mon, 09 Oct 2023 06:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpn6V-000358-DG
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:03:13 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpn6P-00008j-Qf
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:03:07 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40572aeb73cso39562275e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 03:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696845780; x=1697450580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wt6aiJAngF+1rHQyivcpsZ85UBVqDOe5WBHF8BS6ZcM=;
 b=PaZFK/qWUOpEWgz3aCM6roj84qUETeZCRrAWDU1Nalz0qMiavJQ/1fH9RCLgY1lvz/
 HxnUBE0zNeB1cMa+bSk1YJa9j2oT25GjfiQqQZpbyWk7LARaLkfgVjTjP4vS5n71/XhM
 3yGX2/r//zM7tMOL8Vq8PsM4MLEe0xoXk3WtB5OgXfU3Fva/NwEmLD9RhfCeGWnalYqx
 nRva6SoCPUXSwSKfBv9ZsF47p6+IgDzKCmNcZhU876+zTWRcd+LK1U6NISP1s9HtqdDP
 +5pXrn7aGXwRkPLMYfoyB4NGp7CAl1M/3HDJ5dpiHjUImCgTOZ3NrIadNBSiwlRBQuLG
 SZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696845780; x=1697450580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wt6aiJAngF+1rHQyivcpsZ85UBVqDOe5WBHF8BS6ZcM=;
 b=vDGlx5c5MLXD93ZaqyPR5PeBBNXxooOjYOhrieIbsbyvWnN0xWziOL0fIdGFddBNSB
 S5OXjXCH71ZN3XYLbcd7HbXU071pX/3H8zLt+qDdClw4EwcQ0LMxOnRdnBHisY3oQAK8
 2oCmIg7633SoLIUPIYmctshn86/fluKLjvwH/vWb1BKWVrf4zXY52wJaMOnMF9HvcElL
 5wUHmv/u8XZBbeu3gT6bX6panjJWZ+rBjNIlPN1+XMrMjV4XzwLHRGGS6gloF3h0xvW0
 Y22NV9BSa8Dlia8dVjqDeWc2Gy1a3gxOTyS8rpBcftnKQwrnrL2j+HZaivyNo0vqLG8b
 lHuQ==
X-Gm-Message-State: AOJu0Yx0GUlxurvaY3Yr7cP/sSN7Lg6IDxzi6pvsz+zc+4k+bIdwD7Y0
 w2AdF/YFmnfGNGBCoItbxgUBb0Z3vOPMw6zM+vI=
X-Google-Smtp-Source: AGHT+IGwkZSg+joHT24dMZ1WFsuknuULHGcBmy67Rlf5ihuFrLxd446Pk2bDYSGTsnWRhzWOto+btw==
X-Received: by 2002:a5d:4d12:0:b0:31f:f9a9:a742 with SMTP id
 z18-20020a5d4d12000000b0031ff9a9a742mr12146379wrt.23.1696845780208; 
 Mon, 09 Oct 2023 03:03:00 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr.
 [176.170.217.185]) by smtp.gmail.com with ESMTPSA id
 v6-20020adff686000000b0031980294e9fsm9054813wrp.116.2023.10.09.03.02.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Oct 2023 03:02:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Alberto Garcia <berto@igalia.com>,
 Hao Wu <wuhaotsh@google.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Tyrone Ting <kfting@nuvoton.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/10] system/qtest: Clean up global variable shadowing in
 qtest_server_init()
Date: Mon,  9 Oct 2023 12:02:42 +0200
Message-ID: <20231009100251.56019-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009100251.56019-1-philmd@linaro.org>
References: <20231009100251.56019-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Rename the variable to fix:

  softmmu/qtest.c:869:13: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
      Object *qtest;
              ^
  softmmu/qtest.c:53:15: note: previous declaration is here
  static QTest *qtest;
                ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 softmmu/qtest.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/softmmu/qtest.c b/softmmu/qtest.c
index 35b643a274..7964f0b248 100644
--- a/softmmu/qtest.c
+++ b/softmmu/qtest.c
@@ -866,7 +866,7 @@ void qtest_server_init(const char *qtest_chrdev, const char *qtest_log, Error **
 {
     ERRP_GUARD();
     Chardev *chr;
-    Object *qtest;
+    Object *qobj;
 
     chr = qemu_chr_new("qtest", qtest_chrdev, NULL);
     if (chr == NULL) {
@@ -875,18 +875,18 @@ void qtest_server_init(const char *qtest_chrdev, const char *qtest_log, Error **
         return;
     }
 
-    qtest = object_new(TYPE_QTEST);
-    object_property_set_str(qtest, "chardev", chr->label, &error_abort);
+    qobj = object_new(TYPE_QTEST);
+    object_property_set_str(qobj, "chardev", chr->label, &error_abort);
     if (qtest_log) {
-        object_property_set_str(qtest, "log", qtest_log, &error_abort);
+        object_property_set_str(qobj, "log", qtest_log, &error_abort);
     }
-    object_property_add_child(qdev_get_machine(), "qtest", qtest);
-    user_creatable_complete(USER_CREATABLE(qtest), errp);
+    object_property_add_child(qdev_get_machine(), "qtest", qobj);
+    user_creatable_complete(USER_CREATABLE(qobj), errp);
     if (*errp) {
-        object_unparent(qtest);
+        object_unparent(qobj);
     }
     object_unref(OBJECT(chr));
-    object_unref(qtest);
+    object_unref(qobj);
 }
 
 static bool qtest_server_start(QTest *q, Error **errp)
-- 
2.41.0


