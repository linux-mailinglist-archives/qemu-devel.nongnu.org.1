Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F00D6AAC823
	for <lists+qemu-devel@lfdr.de>; Tue,  6 May 2025 16:36:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJOL-0006TV-Aa; Tue, 06 May 2025 10:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJOJ-0006RA-2g
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:35:27 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJOH-00012P-6U
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:35:26 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43ede096d73so35016875e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542123; x=1747146923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJbqmq9kFpuW6bFY3e+x+p51Q9qF9BEDYXcNOdMViWc=;
 b=iPTO/otqkRb6tjUGKURzcslD3umdH+x4gPgxKTLxIknMWiiiF2bphGKA5qhzjER2n6
 SYekeMSElo6GwRkaDrergG1bzbYCvUd4bg7LJ4VEtScQRvzdDGm3xr9fexSV4qAzFc2p
 k6bNHVNNe8zX7zHCXbpugaN2DrxZDw8kBv1enr9lshDd9+l3cmXZ9R5decsnhK4F2ckd
 VpBQPJCjGFtKeW+ATYl4bGwTGh4Y75pVsb0lQ23VFpOO/bTqUljOpFBPZ9tmLySpqJeU
 8EUnYMD0HF9GmhZYL/+DSaHpV5TZ2zSfgTUeNrNjwDhvjQ/zOqPl7qhFAzZA3g/MYLgk
 QFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542123; x=1747146923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EJbqmq9kFpuW6bFY3e+x+p51Q9qF9BEDYXcNOdMViWc=;
 b=wM4OleERnZi6OGEvhGAjTUIuJmzbyamrk0LlRWa0rztCMPIGYMtUWW94XELoae+zou
 A85+COCC//0qJ1tLtM6OsQLVz1ozWbvfMbjTsZsbsVDDaab+HJrRCRIaL7vTBaFQmL74
 X8kRkAgjPgPhMurg9wjJ1H7t0Q2MGJrUohGfHfGx8MUgPpV5orHL+vV9C34oPKHf80RS
 8R99V9b317Z14quHJQBcuYhGI75HwNEaoFW9NEaihb4k7VvlZCQkxEiwtwL8mEb2QbKV
 5VThfodpjcSnzyx8MU3xAYkcGKz5FvmKKAW5+C9sNm06eOmxUGAeWhkLg87MKIeyuS6v
 kqOw==
X-Gm-Message-State: AOJu0YzXmFAuGnPCh9YwsegYtIRhVO1HpkxSG3qMoVu1Xr7zsGgtK9EN
 zc7LRr4zY7rX97E1cDLbrOxKNtKG6wKFjJ0vBlPsvN5GDQkFZejG09YuJ1fHEJ2FnnE/7jXH5LT
 9
X-Gm-Gg: ASbGncsfZyJTPzm1Go0yglBc9LkDMYCCXRxlPY+56/Wkd5xv95LOP9XvbEMcQMp6+Lv
 EQxJujufs1c9mP4sYCpAO7M+Wf1BNkEMJNb0I6YXsAvAGbRD7UzytpExmdBFD/8veALMdl+2Xpr
 b7DP69nKCKjmoVFRttsz2mX41Fde0hDnaXhyITHAf04LPBB+XFplGiBAl1PlA3RvcJ+SgZPcxD+
 jon2vccoqz4Zpaczz8GbPt6GyI24q252Y4m3/IV/aCAwfJm24r21IRHolQUMksR3dz4aPIjMBwk
 RVhAeIvq2Xb3re6mJtVPz75UZxJuumEGQ9QrlW3xKDM/J8fafIk1b6Sgm2BdLDt9qfm/uxwk5wJ
 OAcodQ01JGkh3a5RWkUo3
X-Google-Smtp-Source: AGHT+IHm/TCOIjAoETc3x3haBoYu7LECfFiIq1TC+eypuHC82NlLojM17S94NK3HKMWrmc9G2jQCqw==
X-Received: by 2002:a5d:6489:0:b0:3a0:b1ff:8542 with SMTP id
 ffacd0b85a97d-3a0b1ff88f7mr1739276f8f.8.1746542123326; 
 Tue, 06 May 2025 07:35:23 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89cc441sm174930805e9.3.2025.05.06.07.35.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:35:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/22] qom: Factor qom_resolve_path() out
Date: Tue,  6 May 2025 16:34:51 +0200
Message-ID: <20250506143512.4315-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143512.4315-1-philmd@linaro.org>
References: <20250506143512.4315-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

From: Steve Sistare <steven.sistare@oracle.com>

Factor out a helper to resolve the user's path and print error messages.
No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <1741036202-265696-2-git-send-email-steven.sistare@oracle.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qom/qom-qmp-cmds.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index e8665476182..293755f409e 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -28,15 +28,11 @@
 #include "qom/object_interfaces.h"
 #include "qom/qom-qobject.h"
 
-ObjectPropertyInfoList *qmp_qom_list(const char *path, Error **errp)
+static Object *qom_resolve_path(const char *path, Error **errp)
 {
-    Object *obj;
     bool ambiguous = false;
-    ObjectPropertyInfoList *props = NULL;
-    ObjectProperty *prop;
-    ObjectPropertyIterator iter;
+    Object *obj = object_resolve_path(path, &ambiguous);
 
-    obj = object_resolve_path(path, &ambiguous);
     if (obj == NULL) {
         if (ambiguous) {
             error_setg(errp, "Path '%s' is ambiguous", path);
@@ -44,6 +40,19 @@ ObjectPropertyInfoList *qmp_qom_list(const char *path, Error **errp)
             error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
                       "Device '%s' not found", path);
         }
+    }
+    return obj;
+}
+
+ObjectPropertyInfoList *qmp_qom_list(const char *path, Error **errp)
+{
+    Object *obj;
+    ObjectPropertyInfoList *props = NULL;
+    ObjectProperty *prop;
+    ObjectPropertyIterator iter;
+
+    obj = qom_resolve_path(path, errp);
+    if (obj == NULL) {
         return NULL;
     }
 
-- 
2.47.1


