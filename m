Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0627F1F5B
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 22:41:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5BwW-0007G9-Tx; Mon, 20 Nov 2023 16:36:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Bw8-00071A-UI
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:36:09 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Bw6-0004EW-NW
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:36:08 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-32d81864e3fso3099062f8f.2
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 13:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700516164; x=1701120964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0dlpM+IXDv7rbEXsFyB/MgTxRgvBWVHr070iMACWqDk=;
 b=K81jkTwoupQ1E9CW6VNTe6j4cTqznb8xldikM3B8ZleWUlwEVd0eNwcHJScPH//qX1
 9hcdmSgQUarTc4KUWl4LVyvfElTBsfIfboyPnfW09r2hUMe2LiURleWjHWJYD2Wq50OX
 DPzYb+C8C2E42IcPJvAiPLxDnUsD3M229Kgcezd5tTfZhhBMC5sAqKY3HohrlsJSxKR9
 cFnfcKmJQ99nBmuRxkdXw7cvgaxRWs2L/G4UbRj49io7o3Zebo5b4TvitTbmt5Xw/tS6
 R2f9AQfhSsiQygDgX95Zu9XIw/XmG8qbtnTl8DKJltFE5hTAF0L3MJ+wlrhuaCsaU9ot
 htRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700516164; x=1701120964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0dlpM+IXDv7rbEXsFyB/MgTxRgvBWVHr070iMACWqDk=;
 b=sqGe6m01vByv7Oym1+cxoNOUMEjuLmvpZ6O/oIBw2kbBlXrrbqUfgZIj58zhq9LgSM
 I+XZ+AqEYuDaDZMW63Wx6FCthRiooo1Nrjo5pAKsGPPys4+kNYNgKWib2mT6ycVSHJfF
 SP7wzIONMqyzhhr4o8uOCJBnZQJd5ImJc9leewD4ptXi8NNqpWBn3RuC0van4iz0svTB
 mPMeVxDla4Y9aFWkM/BSK7ATcax1Qb6E+XcjEjg50aoVutM39nAPgkg10qNnj0R8ABKP
 5iVd2fOkAMVWwjR5LlX9/RjsFSSstibg5ZydeRcjxRwk+/KN6I0S6R8QmC8E1GZd5YCT
 m3Cw==
X-Gm-Message-State: AOJu0Yy7MWKm79Xbb2RUy6LrIrwDwUC1pRPqLaqqT1fPcJ5KM+qaTbs4
 B4sHQJgfUqmQF/ecmkTV90tcZzXKo4tGQxwETcM=
X-Google-Smtp-Source: AGHT+IFKWWsEUaV+GlawzfgfQFbqDi3cRyBFKHW1tYfi2uX7aM39x3KOrU7IYYjmKoPQP6ycH3BlJg==
X-Received: by 2002:a5d:5b83:0:b0:32f:b4ab:8cb with SMTP id
 df3-20020a5d5b83000000b0032fb4ab08cbmr4544478wrb.34.1700516163652; 
 Mon, 20 Nov 2023 13:36:03 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 df10-20020a5d5b8a000000b00331a55d3875sm8189914wrb.38.2023.11.20.13.35.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 13:36:03 -0800 (PST)
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
Subject: [PATCH-for-9.0 16/25] backends: Have HostMemoryBackendClass::alloc()
 handler return a boolean
Date: Mon, 20 Nov 2023 22:32:50 +0100
Message-ID: <20231120213301.24349-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120213301.24349-1-philmd@linaro.org>
References: <20231120213301.24349-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01,
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

Following the example documented since commit e3fe3988d7 ("error:
Document Error API usage rules"), have cpu_exec_realizefn()
return a boolean indicating whether an error is set or not.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/sysemu/hostmem.h | 10 +++++++++-
 backends/hostmem-epc.c   | 11 +++++------
 backends/hostmem-file.c  | 19 ++++++++++---------
 backends/hostmem-memfd.c | 10 +++++-----
 backends/hostmem-ram.c   |  9 +++++----
 backends/hostmem.c       |  5 ++---
 6 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index 39326f1d4f..0e411aaa29 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -47,7 +47,15 @@ OBJECT_DECLARE_TYPE(HostMemoryBackend, HostMemoryBackendClass,
 struct HostMemoryBackendClass {
     ObjectClass parent_class;
 
-    void (*alloc)(HostMemoryBackend *backend, Error **errp);
+    /**
+     * alloc: Allocate memory from backend.
+     *
+     * @backend: the #HostMemoryBackend.
+     * @errp: pointer to Error*, to store an error if it happens.
+     *
+     * Return: true on success, else false setting @errp with error.
+     */
+    bool (*alloc)(HostMemoryBackend *backend, Error **errp);
 };
 
 /**
diff --git a/backends/hostmem-epc.c b/backends/hostmem-epc.c
index 3ceb079f9e..735e2e1cf8 100644
--- a/backends/hostmem-epc.c
+++ b/backends/hostmem-epc.c
@@ -17,7 +17,7 @@
 #include "sysemu/hostmem.h"
 #include "hw/i386/hostmem-epc.h"
 
-static void
+static bool
 sgx_epc_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 {
     g_autofree char *name = NULL;
@@ -26,21 +26,20 @@ sgx_epc_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 
     if (!backend->size) {
         error_setg(errp, "can't create backend with size 0");
-        return;
+        return false;
     }
 
     fd = qemu_open_old("/dev/sgx_vepc", O_RDWR);
     if (fd < 0) {
         error_setg_errno(errp, errno,
                          "failed to open /dev/sgx_vepc to alloc SGX EPC");
-        return;
+        return false;
     }
 
     name = object_get_canonical_path(OBJECT(backend));
     ram_flags = (backend->share ? RAM_SHARED : 0) | RAM_PROTECTED;
-    memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend),
-                                   name, backend->size, ram_flags,
-                                   fd, 0, errp);
+    return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
+                                          backend->size, ram_flags, fd, 0, errp);
 }
 
 static void sgx_epc_backend_instance_init(Object *obj)
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index fe8c481f8f..ac3e433cbd 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -36,12 +36,13 @@ struct HostMemoryBackendFile {
     OnOffAuto rom;
 };
 
-static void
+static bool
 file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 {
 #ifndef CONFIG_POSIX
     error_setg(errp, "backend '%s' not supported on this host",
                object_get_typename(OBJECT(backend)));
+    return false;
 #else
     HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(backend);
     g_autofree gchar *name = NULL;
@@ -49,11 +50,11 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 
     if (!backend->size) {
         error_setg(errp, "can't create backend with size 0");
-        return;
+        return false;
     }
     if (!fb->mem_path) {
         error_setg(errp, "mem-path property not set");
-        return;
+        return false;
     }
 
     switch (fb->rom) {
@@ -65,18 +66,18 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         if (!fb->readonly) {
             error_setg(errp, "property 'rom' = 'on' is not supported with"
                        " 'readonly' = 'off'");
-            return;
+            return false;
         }
         break;
     case ON_OFF_AUTO_OFF:
         if (fb->readonly && backend->share) {
             error_setg(errp, "property 'rom' = 'off' is incompatible with"
                        " 'readonly' = 'on' and 'share' = 'on'");
-            return;
+            return false;
         }
         break;
     default:
-        assert(false);
+        g_assert_not_reached();
     }
 
     name = host_memory_backend_get_name(backend);
@@ -86,9 +87,9 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
     ram_flags |= fb->is_pmem ? RAM_PMEM : 0;
     ram_flags |= RAM_NAMED_FILE;
-    memory_region_init_ram_from_file(&backend->mr, OBJECT(backend), name,
-                                     backend->size, fb->align, ram_flags,
-                                     fb->mem_path, fb->offset, errp);
+    return memory_region_init_ram_from_file(&backend->mr, OBJECT(backend), name,
+                                            backend->size, fb->align, ram_flags,
+                                            fb->mem_path, fb->offset, errp);
 #endif
 }
 
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index db28ab5a56..3923ea9364 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -31,7 +31,7 @@ struct HostMemoryBackendMemfd {
     bool seal;
 };
 
-static void
+static bool
 memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 {
     HostMemoryBackendMemfd *m = MEMORY_BACKEND_MEMFD(backend);
@@ -41,7 +41,7 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 
     if (!backend->size) {
         error_setg(errp, "can't create backend with size 0");
-        return;
+        return false;
     }
 
     fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
@@ -49,14 +49,14 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
                            F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
                            errp);
     if (fd == -1) {
-        return;
+        return false;
     }
 
     name = host_memory_backend_get_name(backend);
     ram_flags = backend->share ? RAM_SHARED : 0;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
-    memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
-                                   backend->size, ram_flags, fd, 0, errp);
+    return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
+                                          backend->size, ram_flags, fd, 0, errp);
 }
 
 static bool
diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
index 0a670fc22a..d121249f0f 100644
--- a/backends/hostmem-ram.c
+++ b/backends/hostmem-ram.c
@@ -16,7 +16,7 @@
 #include "qemu/module.h"
 #include "qom/object_interfaces.h"
 
-static void
+static bool
 ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 {
     g_autofree char *name = NULL;
@@ -24,14 +24,15 @@ ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 
     if (!backend->size) {
         error_setg(errp, "can't create backend with size 0");
-        return;
+        return false;
     }
 
     name = host_memory_backend_get_name(backend);
     ram_flags = backend->share ? RAM_SHARED : 0;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
-    memory_region_init_ram_flags_nomigrate(&backend->mr, OBJECT(backend), name,
-                                           backend->size, ram_flags, errp);
+    return memory_region_init_ram_flags_nomigrate(&backend->mr, OBJECT(backend),
+                                                  name, backend->size,
+                                                  ram_flags, errp);
 }
 
 static void
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 1723c19165..3f8eb936d7 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -331,9 +331,8 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
     if (!bc->alloc) {
         return;
     }
-    bc->alloc(backend, &local_err);
-    if (local_err) {
-        goto out;
+    if (!bc->alloc(backend, errp)) {
+        return;
     }
 
     ptr = memory_region_get_ram_ptr(&backend->mr);
-- 
2.41.0


