Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 669E78CD655
	for <lists+qemu-devel@lfdr.de>; Thu, 23 May 2024 16:58:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9t0-0004aT-Tw; Thu, 23 May 2024 10:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sA9sZ-00047v-Lb
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:57:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sA9sU-00046V-BP
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JLEKuIjNUE0upngVj1w8ZNUIo5SFQUiVbbxpLKuiIHs=;
 b=Ar0SqJATGvN7kvTR1/7P6Wp6/uA6UNHmqBr9OYWAMd7rM07sxwaG2KHo4mtFkmRZxZM1QE
 +lmIMmm1QzabTtXBq2y8cLPz+UGKwKLVo4ecjZYztWIT7oW9cuT9cgnX22YOV5Z6ZTvpR5
 u57UiizuUU1aWIrJ2lPFIi5a40wPgDw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-6aLYO5ioPeS2aJZnWQnSOw-1; Thu, 23 May 2024 10:57:07 -0400
X-MC-Unique: 6aLYO5ioPeS2aJZnWQnSOw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6ab8e73bc89so4070006d6.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 07:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476225; x=1717081025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JLEKuIjNUE0upngVj1w8ZNUIo5SFQUiVbbxpLKuiIHs=;
 b=SiWJ89+MMN+QpU2Ci53Yr67W6VNRmWOwNxL0gVP6Zb51dVYDo771QgTPUWI6RXB0Rk
 qNJpcM/5KQvfIkNZUqsZmIZnpp2WdbBDNt+zKjA9CeaOgdEr6HRJPIerPP8dOQ6rDOhI
 tl+eoNfwCE3NeCQalCJRU+J0EQdjmCCOUZ6pdaOespmNsdFf6K3RnFJ62thjC7Nkbsw6
 TjmD1C6QwWzzVYtXwTPics+wvYZ/tSkCNhZ3zeMeYJvCGtan2tHVsDbF/Cezc55aU6zb
 NhvXNN1qVfNtuXJT85MhU+Xk2yglmppxPuSGCxqYJEY0Wduj0n14kE/RaeaZ8c1v/XQS
 ytaA==
X-Gm-Message-State: AOJu0Yy5WHLlf5Ly6e5jhq5mo6gDZNuXPqI04cavE0u3WvAq88Fxfl4D
 d3hk9PnmGDkytHZPKckg/I6h3DzBwkMk6CSr0OAJHIm3peBnWFblMr9Cb2wdyMXtGUUkFe2ieyx
 yuPxqW/UIvKb3qg76+kKe3yOs6z2PzzmiyLcxJhEdWiVYvGNr/tGtKVuyt7OXg8yeYydBREjEWd
 /hxt8lD23THouOtjTbnE+KUddeAMQsAUjXHE/F
X-Received: by 2002:a05:6214:230e:b0:6ab:756b:5d57 with SMTP id
 6a1803df08f44-6ab8f5cfcf5mr49998646d6.27.1716476225253; 
 Thu, 23 May 2024 07:57:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6rDafkvUCgDEofvxExqDpXfr7GtX4pogk6X0aXYMFcGCUs2uMXA4GX122Suzyo47SljP9nw==
X-Received: by 2002:a05:6214:230e:b0:6ab:756b:5d57 with SMTP id
 6a1803df08f44-6ab8f5cfcf5mr49997836d6.27.1716476224571; 
 Thu, 23 May 2024 07:57:04 -0700 (PDT)
Received: from step1.redhat.com (host-79-53-30-109.retail.telecomitalia.it.
 [79.53.30.109]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ab8a05170dsm12949046d6.139.2024.05.23.07.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 07:57:02 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, slp@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>, stefanha@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, gmaglione@redhat.com,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v5 11/13] hostmem: add a new memory backend based on POSIX
 shm_open()
Date: Thu, 23 May 2024 16:55:20 +0200
Message-ID: <20240523145522.313012-12-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523145522.313012-1-sgarzare@redhat.com>
References: <20240523145522.313012-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

shm_open() creates and opens a new POSIX shared memory object.
A POSIX shared memory object allows creating memory backend with an
associated file descriptor that can be shared with external processes
(e.g. vhost-user).

The new `memory-backend-shm` can be used as an alternative when
`memory-backend-memfd` is not available (Linux only), since shm_open()
should be provided by any POSIX-compliant operating system.

This backend mimics memfd, allocating memory that is practically
anonymous. In theory shm_open() requires a name, but this is allocated
for a short time interval and shm_unlink() is called right after
shm_open(). After that, only fd is shared with external processes
(e.g., vhost-user) as if it were associated with anonymous memory.

In the future we may also allow the user to specify the name to be
passed to shm_open(), but for now we keep the backend simple, mimicking
anonymous memory such as memfd.

Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v5
- fixed documentation in qapi/qom.json and qemu-options.hx [Markus]
v4
- fail if we find "share=off" in shm_backend_memory_alloc() [David]
v3
- enriched commit message and documentation to highlight that we
  want to mimic memfd (David)
---
 docs/system/devices/vhost-user.rst |   5 +-
 qapi/qom.json                      |  19 +++++
 backends/hostmem-shm.c             | 123 +++++++++++++++++++++++++++++
 backends/meson.build               |   1 +
 qemu-options.hx                    |  16 ++++
 5 files changed, 162 insertions(+), 2 deletions(-)
 create mode 100644 backends/hostmem-shm.c

diff --git a/docs/system/devices/vhost-user.rst b/docs/system/devices/vhost-user.rst
index 9b2da106ce..35259d8ec7 100644
--- a/docs/system/devices/vhost-user.rst
+++ b/docs/system/devices/vhost-user.rst
@@ -98,8 +98,9 @@ Shared memory object
 
 In order for the daemon to access the VirtIO queues to process the
 requests it needs access to the guest's address space. This is
-achieved via the ``memory-backend-file`` or ``memory-backend-memfd``
-objects. A reference to a file-descriptor which can access this object
+achieved via the ``memory-backend-file``, ``memory-backend-memfd``, or
+``memory-backend-shm`` objects.
+A reference to a file-descriptor which can access this object
 will be passed via the socket as part of the protocol negotiation.
 
 Currently the shared memory object needs to match the size of the main
diff --git a/qapi/qom.json b/qapi/qom.json
index 38dde6d785..d40592d863 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -721,6 +721,21 @@
             '*hugetlbsize': 'size',
             '*seal': 'bool' } }
 
+##
+# @MemoryBackendShmProperties:
+#
+# Properties for memory-backend-shm objects.
+#
+# The @share boolean option is true by default with shm. Setting it to false
+# will cause a failure during allocation because it is not supported by this
+# backend.
+#
+# Since: 9.1
+##
+{ 'struct': 'MemoryBackendShmProperties',
+  'base': 'MemoryBackendProperties',
+  'data': { } }
+
 ##
 # @MemoryBackendEpcProperties:
 #
@@ -985,6 +1000,8 @@
     { 'name': 'memory-backend-memfd',
       'if': 'CONFIG_LINUX' },
     'memory-backend-ram',
+    { 'name': 'memory-backend-shm',
+      'if': 'CONFIG_POSIX' },
     'pef-guest',
     { 'name': 'pr-manager-helper',
       'if': 'CONFIG_LINUX' },
@@ -1056,6 +1073,8 @@
       'memory-backend-memfd':       { 'type': 'MemoryBackendMemfdProperties',
                                       'if': 'CONFIG_LINUX' },
       'memory-backend-ram':         'MemoryBackendProperties',
+      'memory-backend-shm':         { 'type': 'MemoryBackendShmProperties',
+                                      'if': 'CONFIG_POSIX' },
       'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
                                       'if': 'CONFIG_LINUX' },
       'qtest':                      'QtestProperties',
diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
new file mode 100644
index 0000000000..374edc3db8
--- /dev/null
+++ b/backends/hostmem-shm.c
@@ -0,0 +1,123 @@
+/*
+ * QEMU host POSIX shared memory object backend
+ *
+ * Copyright (C) 2024 Red Hat Inc
+ *
+ * Authors:
+ *   Stefano Garzarella <sgarzare@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "sysemu/hostmem.h"
+#include "qapi/error.h"
+
+#define TYPE_MEMORY_BACKEND_SHM "memory-backend-shm"
+
+OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendShm, MEMORY_BACKEND_SHM)
+
+struct HostMemoryBackendShm {
+    HostMemoryBackend parent_obj;
+};
+
+static bool
+shm_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
+{
+    g_autoptr(GString) shm_name = g_string_new(NULL);
+    g_autofree char *backend_name = NULL;
+    uint32_t ram_flags;
+    int fd, oflag;
+    mode_t mode;
+
+    if (!backend->size) {
+        error_setg(errp, "can't create shm backend with size 0");
+        return false;
+    }
+
+    if (!backend->share) {
+        error_setg(errp, "can't create shm backend with `share=off`");
+        return false;
+    }
+
+    /*
+     * Let's use `mode = 0` because we don't want other processes to open our
+     * memory unless we share the file descriptor with them.
+     */
+    mode = 0;
+    oflag = O_RDWR | O_CREAT | O_EXCL;
+    backend_name = host_memory_backend_get_name(backend);
+
+    /*
+     * Some operating systems allow creating anonymous POSIX shared memory
+     * objects (e.g. FreeBSD provides the SHM_ANON constant), but this is not
+     * defined by POSIX, so let's create a unique name.
+     *
+     * From Linux's shm_open(3) man-page:
+     *   For  portable  use,  a shared  memory  object should be identified
+     *   by a name of the form /somename;"
+     */
+    g_string_printf(shm_name, "/qemu-" FMT_pid "-shm-%s", getpid(),
+                    backend_name);
+
+    fd = shm_open(shm_name->str, oflag, mode);
+    if (fd < 0) {
+        error_setg_errno(errp, errno,
+                         "failed to create POSIX shared memory");
+        return false;
+    }
+
+    /*
+     * We have the file descriptor, so we no longer need to expose the
+     * POSIX shared memory object. However it will remain allocated as long as
+     * there are file descriptors pointing to it.
+     */
+    shm_unlink(shm_name->str);
+
+    if (ftruncate(fd, backend->size) == -1) {
+        error_setg_errno(errp, errno,
+                         "failed to resize POSIX shared memory to %" PRIu64,
+                         backend->size);
+        close(fd);
+        return false;
+    }
+
+    ram_flags = RAM_SHARED;
+    ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
+
+    return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend),
+                                              backend_name, backend->size,
+                                              ram_flags, fd, 0, errp);
+}
+
+static void
+shm_backend_instance_init(Object *obj)
+{
+    HostMemoryBackendShm *m = MEMORY_BACKEND_SHM(obj);
+
+    MEMORY_BACKEND(m)->share = true;
+}
+
+static void
+shm_backend_class_init(ObjectClass *oc, void *data)
+{
+    HostMemoryBackendClass *bc = MEMORY_BACKEND_CLASS(oc);
+
+    bc->alloc = shm_backend_memory_alloc;
+}
+
+static const TypeInfo shm_backend_info = {
+    .name = TYPE_MEMORY_BACKEND_SHM,
+    .parent = TYPE_MEMORY_BACKEND,
+    .instance_init = shm_backend_instance_init,
+    .class_init = shm_backend_class_init,
+    .instance_size = sizeof(HostMemoryBackendShm),
+};
+
+static void register_types(void)
+{
+    type_register_static(&shm_backend_info);
+}
+
+type_init(register_types);
diff --git a/backends/meson.build b/backends/meson.build
index 8b2b111497..3867b0d363 100644
--- a/backends/meson.build
+++ b/backends/meson.build
@@ -13,6 +13,7 @@ system_ss.add([files(
 if host_os != 'windows'
   system_ss.add(files('rng-random.c'))
   system_ss.add(files('hostmem-file.c'))
+  system_ss.add([files('hostmem-shm.c'), rt])
 endif
 if host_os == 'linux'
   system_ss.add(files('hostmem-memfd.c'))
diff --git a/qemu-options.hx b/qemu-options.hx
index 4d19660336..982751cb35 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5238,6 +5238,22 @@ SRST
 
         The ``share`` boolean option is on by default with memfd.
 
+    ``-object memory-backend-shm,id=id,merge=on|off,dump=on|off,share=on|off,prealloc=on|off,size=size,host-nodes=host-nodes,policy=default|preferred|bind|interleave``
+        Creates a POSIX shared memory backend object, which allows
+        QEMU to share the memory with an external process (e.g. when
+        using vhost-user).
+
+        ``memory-backend-shm`` is a more portable and less featureful version
+        of ``memory-backend-memfd``. It can then be used in any POSIX system,
+        especially when memfd is not supported.
+
+        Please refer to ``memory-backend-file`` for a description of the
+        options.
+
+        The ``share`` boolean option is on by default with shm. Setting it to
+        off will cause a failure during allocation because it is not supported
+        by this backend.
+
     ``-object iommufd,id=id[,fd=fd]``
         Creates an iommufd backend which allows control of DMA mapping
         through the ``/dev/iommu`` device.
-- 
2.45.1


