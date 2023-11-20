Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 393777F1F45
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 22:36:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Bvu-0005xa-6j; Mon, 20 Nov 2023 16:35:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Bvr-0005dh-I5
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:35:51 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Bvo-0004An-29
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:35:51 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-32df66c691dso3101499f8f.3
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 13:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700516146; x=1701120946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3MTfYspIRofl2d+GaSi2n8kVPRZkUBrCgY4w5h7qsWI=;
 b=rHCisfklOOZap7cAJbGgmlFoeqKULQ+vmkXMpcqkYm1FMUQgU/uqY8C9XKoF4vJcon
 EOQClWEzXKJ2tY6eaWz7z/R0M14kcrBKyL/UP5MCMcG80eRYNepDWAI3pLooUsXP4Ay/
 CY4lariSQW5YBcH8ebqgWUKiVFq+tYlHoQxeeakHbfLX4xpB6upFB8/GEGOrO7cfUA9b
 /6+weJHKreC4kXBwZJHu1lVuo2R4Rcn5PPa1RS3Pp7YGoxdvhdJ1bJ2j5i9vSOYFNJ/H
 ssgKeIliyOmCpHjweuy/hFVETRZOL932UePeKnUuR3AJlvM7eThIZoEO6hAlE+YChpdH
 2frg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700516146; x=1701120946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3MTfYspIRofl2d+GaSi2n8kVPRZkUBrCgY4w5h7qsWI=;
 b=FBfKuTjbAZrZi/QpVWv8cP+2YL4VeFoGJBehPqePcu/ndUPBxeaNpC02PMrVhQA8qO
 9bM6/Q8wWjoE9R7R54RwnZSzswK/M80TQanwii1yindUUZZo2EKkDZs3q+kYJBE0klPL
 SgDOR77mGrmJkE9M/CBuE7gLxjUA2KiivVuKKol6Jg/Q3IMN+Ky5GZMN4An0HZS53H6M
 SyFTjAoWaeuYqjFcDIOn4UI+aoFDWX3WPGg86Bcx3U4o05+EwvYM19J8nbLFtJD2YxLQ
 MSv5qGBQzEaqJp51EOS08NTI4jrDwzmyC/ll+Nl5DzID7/XWza58fiMS4lTfQka+YiVP
 IXnA==
X-Gm-Message-State: AOJu0YzIYNVPrL6cCslXHxvz7CRvFIuiPeVPL7DAce5roSdlSEV8rXS2
 zOldmt8U7t4/cR4X8kznp4WnnJZ4bvYmpKV+rk8=
X-Google-Smtp-Source: AGHT+IHJw4br/gAEOYJKCgGb2gTZzW99Smd0qhk85joM8RLaXzPatxg5y5ZLale/3WnFXBjccrYtZg==
X-Received: by 2002:a5d:4012:0:b0:32d:8855:138d with SMTP id
 n18-20020a5d4012000000b0032d8855138dmr5256601wrp.66.1700516146517; 
 Mon, 20 Nov 2023 13:35:46 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a5d5909000000b0032f9688ea48sm12319327wrd.10.2023.11.20.13.35.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 13:35:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH-for-9.0 14/25] backends: Use g_autofree in
 HostMemoryBackendClass::alloc() handlers
Date: Mon, 20 Nov 2023 22:32:48 +0100
Message-ID: <20231120213301.24349-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120213301.24349-1-philmd@linaro.org>
References: <20231120213301.24349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

In preparation of having HostMemoryBackendClass::alloc() handlers
return a boolean, have them use g_autofree.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 backends/hostmem-epc.c   | 3 +--
 backends/hostmem-file.c  | 3 +--
 backends/hostmem-memfd.c | 3 +--
 backends/hostmem-ram.c   | 3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/backends/hostmem-epc.c b/backends/hostmem-epc.c
index 4e162d6789..3ceb079f9e 100644
--- a/backends/hostmem-epc.c
+++ b/backends/hostmem-epc.c
@@ -20,8 +20,8 @@
 static void
 sgx_epc_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 {
+    g_autofree char *name = NULL;
     uint32_t ram_flags;
-    char *name;
     int fd;
 
     if (!backend->size) {
@@ -41,7 +41,6 @@ sgx_epc_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend),
                                    name, backend->size, ram_flags,
                                    fd, 0, errp);
-    g_free(name);
 }
 
 static void sgx_epc_backend_instance_init(Object *obj)
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 361d4a8103..fe8c481f8f 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -44,8 +44,8 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
                object_get_typename(OBJECT(backend)));
 #else
     HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(backend);
+    g_autofree gchar *name = NULL;
     uint32_t ram_flags;
-    gchar *name;
 
     if (!backend->size) {
         error_setg(errp, "can't create backend with size 0");
@@ -89,7 +89,6 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     memory_region_init_ram_from_file(&backend->mr, OBJECT(backend), name,
                                      backend->size, fb->align, ram_flags,
                                      fb->mem_path, fb->offset, errp);
-    g_free(name);
 #endif
 }
 
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 3fc85c3db8..db28ab5a56 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -35,8 +35,8 @@ static void
 memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 {
     HostMemoryBackendMemfd *m = MEMORY_BACKEND_MEMFD(backend);
+    g_autofree char *name = NULL;
     uint32_t ram_flags;
-    char *name;
     int fd;
 
     if (!backend->size) {
@@ -57,7 +57,6 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
     memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
                                    backend->size, ram_flags, fd, 0, errp);
-    g_free(name);
 }
 
 static bool
diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
index b8e55cdbd0..0a670fc22a 100644
--- a/backends/hostmem-ram.c
+++ b/backends/hostmem-ram.c
@@ -19,8 +19,8 @@
 static void
 ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 {
+    g_autofree char *name = NULL;
     uint32_t ram_flags;
-    char *name;
 
     if (!backend->size) {
         error_setg(errp, "can't create backend with size 0");
@@ -32,7 +32,6 @@ ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
     memory_region_init_ram_flags_nomigrate(&backend->mr, OBJECT(backend), name,
                                            backend->size, ram_flags, errp);
-    g_free(name);
 }
 
 static void
-- 
2.41.0


