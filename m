Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DB4955C57
	for <lists+qemu-devel@lfdr.de>; Sun, 18 Aug 2024 13:45:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfeJo-0003G9-SJ; Sun, 18 Aug 2024 07:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sfeJm-0003Aa-3Y
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 07:43:30 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sfeJh-0001am-IY
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 07:43:29 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2d37e5b7b02so2275942a91.1
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2024 04:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723981403; x=1724586203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xsgi/YBTanPwujUzGi55DzCKnuDN8bNeQofaYM3EfPo=;
 b=MmZ8GUOiX62DcAuOLkceOly6fwNqjTkOgTzHoBuspkjXehbY3rbwIA8lGarpUv3SLK
 8bQw8FPr7XXEwYLaf6kJoLufKbuAhEw0N/rxv2VlRsFpzqQL0TF/VcWcVby2uZ7sLYAV
 4/I17p+KC1fNkUm0Pgn9OJAbucr+ClPEZun8FFXnEinpeg3YGn+tUDIXsw8pql1gFeJ9
 i8WK80YWMqhRSXE88V+CtSrcxKjI4LxvP5X229EnMjjPLHWzm4PuxaebplxHnb9lS8VM
 TdU7aMl6ik0hjHNSme1q3t2C3fQFKM2beZAMBIZyWIysPcVsP++CXigBqhzsbswyQpH1
 Hkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723981403; x=1724586203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xsgi/YBTanPwujUzGi55DzCKnuDN8bNeQofaYM3EfPo=;
 b=i0Ye6fsLChN8D1YJrAAyLKp2npWF9lD7mQ+642Trk60vYPFZQuN19VZfMMCpGQwf47
 ew0eDdJnS54f9e2TPHlsY/OcnNHzkq/cvZCMhCy4u0BKRUpIkNJf4TOk05NO1TIWkz5x
 nSuFJwlKKSh8Q89CA5RyPhaMN8XgoVxFdlbqaWuc9fil45yJ4IPPrId3vgoBpP71Iv2n
 aaUF6LxG5K7+WVaEho5m7/y4J01UXUWzSnQXdQmfrNanGI7d2ePEOJcrPf3LUJO8Ewso
 I34HI0OIrnAB2dCGRmdpRTLYQ6rdRcX3/fQ3nakFGvAeXqi8yly5jGaByzDg9hj18TBe
 pIdg==
X-Gm-Message-State: AOJu0YwSam5Z39I7Tp6clsTHzp9MSEslsrkqdHmkmZOjMw0zhO/FwFYT
 6KtW1USZEtGudyq6e1TM75DB+lSSG29zsdOZqUJKYmSy+TqRge8Kq+FJ6w==
X-Google-Smtp-Source: AGHT+IEAmS+yf28VmQt5+iALSAQzE3FAa8aByRbBUHVGtrwsWj1cDHQ0HgIjLDc504xAPgEcZHWuOQ==
X-Received: by 2002:a17:90a:55cf:b0:2d3:c0e5:cbac with SMTP id
 98e67ed59e1d1-2d3dfdaaba4mr7104570a91.7.1723981402261; 
 Sun, 18 Aug 2024 04:43:22 -0700 (PDT)
Received: from localhost.localdomain ([103.103.35.174])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3e2c61fe4sm5303617a91.4.2024.08.18.04.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Aug 2024 04:43:21 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v4 3/6] device/virtio-nsm: Support for Nitro Secure Module
 device
Date: Sun, 18 Aug 2024 17:42:54 +0600
Message-Id: <20240818114257.21456-4-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240818114257.21456-1-dorjoychy111@gmail.com>
References: <20240818114257.21456-1-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=dorjoychy111@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Nitro Secure Module (NSM)[1] device is used in AWS Nitro Enclaves for
stripped down TPM functionality like cryptographic attestation. The
requests to and responses from NSM device are CBOR[2] encoded.

This commit adds support for NSM device in QEMU. Although related to
AWS Nitro Enclaves, the virito-nsm device is independent and can be
used in other machine types as well. The libcbor[3] library has been
used for the CBOR encoding and decoding functionalities.

[1] https://lists.oasis-open.org/archives/virtio-comment/202310/msg00387.html
[2] http://cbor.io/
[3] https://libcbor.readthedocs.io/en/latest/

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 MAINTAINERS                      |   10 +
 hw/virtio/Kconfig                |    5 +
 hw/virtio/cbor-helpers.c         |  292 ++++++
 hw/virtio/meson.build            |    4 +
 hw/virtio/virtio-nsm-pci.c       |   73 ++
 hw/virtio/virtio-nsm.c           | 1648 ++++++++++++++++++++++++++++++
 include/hw/virtio/cbor-helpers.h |   43 +
 include/hw/virtio/virtio-nsm.h   |   59 ++
 8 files changed, 2134 insertions(+)
 create mode 100644 hw/virtio/cbor-helpers.c
 create mode 100644 hw/virtio/virtio-nsm-pci.c
 create mode 100644 hw/virtio/virtio-nsm.c
 create mode 100644 include/hw/virtio/cbor-helpers.h
 create mode 100644 include/hw/virtio/virtio-nsm.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a59537c9c5..aa7846107e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2349,6 +2349,16 @@ F: include/sysemu/rng*.h
 F: backends/rng*.c
 F: tests/qtest/virtio-rng-test.c
 
+virtio-nsm
+M: Alexander Graf <graf@amazon.com>
+M: Dorjoy Chowdhury <dorjoychy111@gmail.com>
+S: Maintained
+F: hw/virtio/cbor-helpers.c
+F: hw/virtio/virtio-nsm.c
+F: hw/virtio/virtio-nsm-pci.c
+F: include/hw/virtio/cbor-helpers.h
+F: include/hw/virtio/virtio-nsm.h
+
 vhost-user-stubs
 M: Alex Bennée <alex.bennee@linaro.org>
 S: Maintained
diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index aa63ff7fd4..29fee32035 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -6,6 +6,11 @@ config VIRTIO_RNG
     default y
     depends on VIRTIO
 
+config VIRTIO_NSM
+   bool
+   default y
+   depends on VIRTIO
+
 config VIRTIO_IOMMU
     bool
     default y
diff --git a/hw/virtio/cbor-helpers.c b/hw/virtio/cbor-helpers.c
new file mode 100644
index 0000000000..5140020d4e
--- /dev/null
+++ b/hw/virtio/cbor-helpers.c
@@ -0,0 +1,292 @@
+/*
+ * QEMU CBOR helpers
+ *
+ * Copyright (c) 2024 Dorjoy Chowdhury <dorjoychy111@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include "hw/virtio/cbor-helpers.h"
+
+bool qemu_cbor_map_add(cbor_item_t *map, cbor_item_t *key, cbor_item_t *value)
+{
+    bool success = false;
+    struct cbor_pair pair = (struct cbor_pair) {
+        .key = cbor_move(key),
+        .value = cbor_move(value)
+    };
+
+    success = cbor_map_add(map, pair);
+    if (!success) {
+        cbor_incref(pair.key);
+        cbor_incref(pair.value);
+    }
+
+    return success;
+}
+
+bool qemu_cbor_array_push(cbor_item_t *array, cbor_item_t *value)
+{
+    bool success = false;
+
+    success = cbor_array_push(array, cbor_move(value));
+    if (!success) {
+        cbor_incref(value);
+    }
+
+    return success;
+}
+
+bool qemu_cbor_add_bool_to_map(cbor_item_t *map, const char *key, bool value)
+{
+    cbor_item_t *key_cbor = NULL;
+    cbor_item_t *value_cbor = NULL;
+
+    key_cbor = cbor_build_string(key);
+    if (!key_cbor) {
+        goto cleanup;
+    }
+    value_cbor = cbor_build_bool(value);
+    if (!value_cbor) {
+        goto cleanup;
+    }
+    if (!qemu_cbor_map_add(map, key_cbor, value_cbor)) {
+        goto cleanup;
+    }
+
+    return true;
+
+ cleanup:
+    if (key_cbor) {
+        cbor_decref(&key_cbor);
+    }
+    if (value_cbor) {
+        cbor_decref(&value_cbor);
+    }
+    return false;
+}
+
+bool qemu_cbor_add_uint8_to_map(cbor_item_t *map, const char *key,
+                                uint8_t value)
+{
+    cbor_item_t *key_cbor = NULL;
+    cbor_item_t *value_cbor = NULL;
+
+    key_cbor = cbor_build_string(key);
+    if (!key_cbor) {
+        goto cleanup;
+    }
+    value_cbor = cbor_build_uint8(value);
+    if (!value_cbor) {
+        goto cleanup;
+    }
+    if (!qemu_cbor_map_add(map, key_cbor, value_cbor)) {
+        goto cleanup;
+    }
+
+    return true;
+
+ cleanup:
+    if (key_cbor) {
+        cbor_decref(&key_cbor);
+    }
+    if (value_cbor) {
+        cbor_decref(&value_cbor);
+    }
+    return false;
+}
+
+bool qemu_cbor_add_map_to_map(cbor_item_t *map, const char *key,
+                              size_t nested_map_size,
+                              cbor_item_t **nested_map)
+{
+    cbor_item_t *key_cbor = NULL;
+    cbor_item_t *value_cbor = NULL;
+
+    key_cbor = cbor_build_string(key);
+    if (!key_cbor) {
+        goto cleanup;
+    }
+    value_cbor = cbor_new_definite_map(nested_map_size);
+    if (!value_cbor) {
+        goto cleanup;
+    }
+    if (!qemu_cbor_map_add(map, key_cbor, value_cbor)) {
+        goto cleanup;
+    }
+    *nested_map = value_cbor;
+
+    return true;
+
+ cleanup:
+    if (key_cbor) {
+        cbor_decref(&key_cbor);
+    }
+    if (value_cbor) {
+        cbor_decref(&value_cbor);
+    }
+    return false;
+}
+
+bool qemu_cbor_add_bytestring_to_map(cbor_item_t *map, const char *key,
+                                     uint8_t *arr, size_t len)
+{
+    cbor_item_t *key_cbor = NULL;
+    cbor_item_t *value_cbor = NULL;
+
+    key_cbor = cbor_build_string(key);
+    if (!key_cbor) {
+        goto cleanup;
+    }
+    value_cbor = cbor_build_bytestring(arr, len);
+    if (!value_cbor) {
+        goto cleanup;
+    }
+    if (!qemu_cbor_map_add(map, key_cbor, value_cbor)) {
+        goto cleanup;
+    }
+
+    return true;
+
+ cleanup:
+    if (key_cbor) {
+        cbor_decref(&key_cbor);
+    }
+    if (value_cbor) {
+        cbor_decref(&value_cbor);
+    }
+    return false;
+}
+
+bool qemu_cbor_add_string_to_map(cbor_item_t *map, const char *key,
+                                 const char *value)
+{
+    cbor_item_t *key_cbor = NULL;
+    cbor_item_t *value_cbor = NULL;
+
+    key_cbor = cbor_build_string(key);
+    if (!key_cbor) {
+        goto cleanup;
+    }
+    value_cbor = cbor_build_string(value);
+    if (!value_cbor) {
+        goto cleanup;
+    }
+    if (!qemu_cbor_map_add(map, key_cbor, value_cbor)) {
+        goto cleanup;
+    }
+
+    return true;
+
+ cleanup:
+    if (key_cbor) {
+        cbor_decref(&key_cbor);
+    }
+    if (value_cbor) {
+        cbor_decref(&value_cbor);
+    }
+    return false;
+}
+
+bool qemu_cbor_add_uint8_array_to_map(cbor_item_t *map, const char *key,
+                                      uint8_t *arr, size_t len)
+{
+    cbor_item_t *key_cbor = NULL;
+    cbor_item_t *value_cbor = NULL;
+
+    key_cbor = cbor_build_string(key);
+    if (!key_cbor) {
+        goto cleanup;
+    }
+    value_cbor = cbor_new_definite_array(len);
+    if (!value_cbor) {
+        goto cleanup;
+    }
+
+    for (int i = 0; i < len; ++i) {
+        cbor_item_t *tmp = cbor_build_uint8(arr[i]);
+        if (!tmp) {
+            goto cleanup;
+        }
+        if (!qemu_cbor_array_push(value_cbor, tmp)) {
+            cbor_decref(&tmp);
+            goto cleanup;
+        }
+    }
+    if (!qemu_cbor_map_add(map, key_cbor, value_cbor)) {
+        goto cleanup;
+    }
+
+    return true;
+
+ cleanup:
+    if (key_cbor) {
+        cbor_decref(&key_cbor);
+    }
+    if (value_cbor) {
+        cbor_decref(&value_cbor);
+    }
+    return false;
+}
+
+bool qemu_cbor_add_uint8_key_bytestring_to_map(cbor_item_t *map, uint8_t key,
+                                               uint8_t *buf, size_t len)
+{
+    cbor_item_t *key_cbor = NULL;
+    cbor_item_t *value_cbor = NULL;
+
+    key_cbor = cbor_build_uint8(key);
+    if (!key_cbor) {
+        goto cleanup;
+    }
+    value_cbor = cbor_build_bytestring(buf, len);
+    if (!value_cbor) {
+        goto cleanup;
+    }
+    if (!qemu_cbor_map_add(map, key_cbor, value_cbor)) {
+        goto cleanup;
+    }
+
+    return true;
+
+ cleanup:
+    if (key_cbor) {
+        cbor_decref(&key_cbor);
+    }
+    if (value_cbor) {
+        cbor_decref(&value_cbor);
+    }
+    return false;
+}
+
+bool qemu_cbor_add_uint64_to_map(cbor_item_t *map, const char *key,
+                                 uint64_t value)
+{
+    cbor_item_t *key_cbor = NULL;
+    cbor_item_t *value_cbor = NULL;
+
+    key_cbor = cbor_build_string(key);
+    if (!key_cbor) {
+        goto cleanup;
+    }
+    value_cbor = cbor_build_uint64(value);
+    if (!value_cbor) {
+        goto cleanup;
+    }
+    if (!qemu_cbor_map_add(map, key_cbor, value_cbor)) {
+        goto cleanup;
+    }
+
+    return true;
+
+ cleanup:
+    if (key_cbor) {
+        cbor_decref(&key_cbor);
+    }
+    if (value_cbor) {
+        cbor_decref(&value_cbor);
+    }
+    return false;
+}
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 621fc65454..7ccb61cf74 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -48,12 +48,15 @@ else
   system_virtio_ss.add(files('vhost-stub.c'))
 endif
 
+libcbor = dependency('libcbor', version: '>=0.7.0')
+
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs.c'))
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c'))
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
+specific_virtio_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: [files('virtio-nsm.c', 'cbor-helpers.c'), libcbor])
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_SCMI', if_true: files('vhost-user-scmi.c'))
 specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_SCMI'], if_true: files('vhost-user-scmi-pci.c'))
@@ -70,6 +73,7 @@ virtio_pci_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('virtio-crypto-pc
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_INPUT_HOST', if_true: files('virtio-input-host-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_INPUT', if_true: files('virtio-input-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: [files('virtio-nsm-pci.c', 'cbor-helpers.c'), libcbor])
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_9P', if_true: files('virtio-9p-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_SCSI', if_true: files('virtio-scsi-pci.c'))
diff --git a/hw/virtio/virtio-nsm-pci.c b/hw/virtio/virtio-nsm-pci.c
new file mode 100644
index 0000000000..dca797315a
--- /dev/null
+++ b/hw/virtio/virtio-nsm-pci.c
@@ -0,0 +1,73 @@
+/*
+ * AWS Nitro Secure Module (NSM) device
+ *
+ * Copyright (c) 2024 Dorjoy Chowdhury <dorjoychy111@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/virtio/virtio-pci.h"
+#include "hw/virtio/virtio-nsm.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "qom/object.h"
+
+typedef struct VirtIONsmPCI VirtIONsmPCI;
+
+#define TYPE_VIRTIO_NSM_PCI "virtio-nsm-pci-base"
+DECLARE_INSTANCE_CHECKER(VirtIONsmPCI, VIRTIO_NSM_PCI,
+                         TYPE_VIRTIO_NSM_PCI)
+
+struct VirtIONsmPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIONSM vdev;
+};
+
+static void virtio_nsm_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VirtIONsmPCI *vnsm = VIRTIO_NSM_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&vnsm->vdev);
+
+    virtio_pci_force_virtio_1(vpci_dev);
+
+    if (!qdev_realize(vdev, BUS(&vpci_dev->bus), errp)) {
+        return;
+    }
+}
+
+static void virtio_nsm_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+
+    k->realize = virtio_nsm_pci_realize;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static void virtio_nsm_initfn(Object *obj)
+{
+    VirtIONsmPCI *dev = VIRTIO_NSM_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_NSM);
+}
+
+static const VirtioPCIDeviceTypeInfo virtio_nsm_pci_info = {
+    .base_name             = TYPE_VIRTIO_NSM_PCI,
+    .generic_name          = "virtio-nsm-pci",
+    .instance_size = sizeof(VirtIONsmPCI),
+    .instance_init = virtio_nsm_initfn,
+    .class_init    = virtio_nsm_pci_class_init,
+};
+
+static void virtio_nsm_pci_register(void)
+{
+    virtio_pci_types_register(&virtio_nsm_pci_info);
+}
+
+type_init(virtio_nsm_pci_register)
diff --git a/hw/virtio/virtio-nsm.c b/hw/virtio/virtio-nsm.c
new file mode 100644
index 0000000000..e91848a2b0
--- /dev/null
+++ b/hw/virtio/virtio-nsm.c
@@ -0,0 +1,1648 @@
+/*
+ * AWS Nitro Secure Module (NSM) device
+ *
+ * Copyright (c) 2024 Dorjoy Chowdhury <dorjoychy111@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/guest-random.h"
+#include "qapi/error.h"
+
+#include "crypto/hash.h"
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/virtio-nsm.h"
+#include "hw/virtio/cbor-helpers.h"
+#include "standard-headers/linux/virtio_ids.h"
+
+#define NSM_PCR_DATA_REQ_MAX_SIZE 512
+
+enum NSMResponseTypes {
+    NSM_SUCCESS = 0,
+    NSM_INVALID_ARGUMENT = 1,
+    NSM_INVALID_INDEX = 2,
+    NSM_READONLY_INDEX = 3,
+    NSM_INVALID_OPERATION = 4,
+    NSM_BUFFER_TOO_SMALL = 5,
+    NSM_INPUT_TOO_LARGE = 6,
+    NSM_INTERNAL_ERROR = 7,
+};
+
+static const char *error_string(enum NSMResponseTypes type)
+{
+    const char *str;
+    switch (type) {
+    case NSM_INVALID_ARGUMENT:
+        str = "InvalidArgument";
+        break;
+    case NSM_INVALID_INDEX:
+        str = "InvalidIndex";
+        break;
+    case NSM_READONLY_INDEX:
+        str = "ReadOnlyIndex";
+        break;
+    case NSM_INVALID_OPERATION:
+        str = "InvalidOperation";
+        break;
+    case NSM_BUFFER_TOO_SMALL:
+        str = "BufferTooSmall";
+        break;
+    case NSM_INPUT_TOO_LARGE:
+        str = "InputTooLarge";
+        break;
+    default:
+        str = "InternalError";
+        break;
+    }
+
+    return str;
+}
+
+/*
+ * Error response structure:
+ *
+ * {
+ *   Map(1) {
+ *     key = String("Error"),
+ *     value = String(error_name)
+ *   }
+ * }
+ *
+ * where error_name can be one of the following:
+ *   InvalidArgument
+ *   InvalidIndex
+ *   InvalidResponse
+ *   ReadOnlyIndex
+ *   InvalidOperation
+ *   BufferTooSmall
+ *   InputTooLarge
+ *   InternalError
+ */
+
+static bool error_response(struct iovec *response, enum NSMResponseTypes error,
+                           Error **errp)
+{
+    cbor_item_t *root;
+    size_t len;
+    bool r = false;
+
+    root = cbor_new_definite_map(1);
+    if (!root) {
+        goto err;
+    }
+
+    if (!qemu_cbor_add_string_to_map(root, "Error", error_string(error))) {
+        goto err;
+    }
+
+    len = cbor_serialize(root, response->iov_base, response->iov_len);
+    if (len == 0) {
+        error_setg(errp, "Response buffer is small for %s response",
+                   error_string(error));
+        goto out;
+    }
+    response->iov_len = len;
+    r = true;
+
+ out:
+    if (root) {
+        cbor_decref(&root);
+    }
+    return r;
+
+ err:
+    error_setg(errp, "Failed to initialize %s response", error_string(error));
+    goto out;
+}
+
+/*
+ * GetRandom response structure:
+ *
+ * {
+ *   Map(1) {
+ *     key = String("GetRandom"),
+ *     value = Map(1) {
+ *       key = String("random"),
+ *       value = Byte_String()
+ *     }
+ *   }
+ * }
+ */
+static bool handle_GetRandom(VirtIONSM *vnsm, struct iovec *request,
+                             struct iovec *response, Error **errp)
+{
+    cbor_item_t *root, *nested_map;
+    size_t len;
+    uint8_t rnd[64];
+    bool r = false;
+
+    root = cbor_new_definite_map(1);
+    if (!root) {
+        goto err;
+    }
+
+    if (!qemu_cbor_add_map_to_map(root, "GetRandom", 1, &nested_map)) {
+        goto err;
+    }
+
+    qemu_guest_getrandom_nofail(rnd, 64);
+
+    if (!qemu_cbor_add_bytestring_to_map(nested_map, "random", rnd, 64)) {
+        goto err;
+    }
+
+    len = cbor_serialize(root, response->iov_base, response->iov_len);
+    if (len == 0) {
+        if (error_response(response, NSM_BUFFER_TOO_SMALL, errp)) {
+            r = true;
+        }
+        goto out;
+    }
+
+    response->iov_len = len;
+    r = true;
+
+ out:
+    if (root) {
+        cbor_decref(&root);
+    }
+    return r;
+
+ err:
+    error_setg(errp, "Failed to initialize GetRandom response");
+    goto out;
+}
+
+/*
+ * DescribeNSM response structure:
+ *
+ * {
+ *   Map(1) {
+ *     key = String("DescribeNSM"),
+ *     value = Map(7) {
+ *       key = String("digest"),
+ *       value = String("SHA384"),
+ *       key = String("max_pcrs"),
+ *       value = Uint8(32),
+ *       key = String("module_id"),
+ *       value = String("i-1234-enc5678"),
+ *       key = String("locked_pcrs"),
+ *       value = Array<Uint8>(),
+ *       key = String("version_major"),
+ *       value = Uint8(1),
+ *       key = String("version_minor"),
+ *       value = Uint8(0),
+ *       key = String("version_patch"),
+ *       value = Uint8(0)
+ *     }
+ *   }
+ * }
+ */
+static bool handle_DescribeNSM(VirtIONSM *vnsm, struct iovec *request,
+                               struct iovec *response, Error **errp)
+{
+    cbor_item_t *root, *nested_map;
+    uint16_t locked_pcrs_cnt = 0;
+    uint8_t locked_pcrs_ind[NSM_MAX_PCRS];
+    size_t len;
+    bool r = false;
+
+    root = cbor_new_definite_map(1);
+    if (!root) {
+        goto err;
+    }
+
+    if (!qemu_cbor_add_map_to_map(root, "DescribeNSM", 7, &nested_map)) {
+        goto err;
+    }
+
+    if (!qemu_cbor_add_string_to_map(nested_map, "digest", vnsm->digest)) {
+        goto err;
+    }
+
+    if (!qemu_cbor_add_uint8_to_map(nested_map, "max_pcrs", vnsm->max_pcrs)) {
+        goto err;
+    }
+
+    if (!qemu_cbor_add_string_to_map(nested_map, "module_id",
+                                     vnsm->module_id)) {
+        goto err;
+    }
+
+    for (uint8_t i = 0; i < NSM_MAX_PCRS; ++i) {
+        if (vnsm->pcrs[i].locked) {
+            locked_pcrs_ind[locked_pcrs_cnt++] = i;
+        }
+    }
+    if (!qemu_cbor_add_uint8_array_to_map(nested_map, "locked_pcrs",
+                                          locked_pcrs_ind, locked_pcrs_cnt)) {
+        goto err;
+    }
+
+    if (!qemu_cbor_add_uint8_to_map(nested_map, "version_major",
+                                    vnsm->version_major)) {
+        goto err;
+    }
+
+    if (!qemu_cbor_add_uint8_to_map(nested_map, "version_minor",
+                                    vnsm->version_minor)) {
+        goto err;
+    }
+
+    if (!qemu_cbor_add_uint8_to_map(nested_map, "version_patch",
+                                    vnsm->version_patch)) {
+        goto err;
+    }
+
+    len = cbor_serialize(root, response->iov_base, response->iov_len);
+    if (len == 0) {
+        if (error_response(response, NSM_BUFFER_TOO_SMALL, errp)) {
+            r = true;
+        }
+        goto out;
+    }
+
+    response->iov_len = len;
+    r = true;
+
+ out:
+    if (root) {
+        cbor_decref(&root);
+    }
+    return r;
+
+ err:
+    error_setg(errp, "Failed to initialize DescribeNSM response");
+    goto out;
+}
+
+/*
+ * DescribePCR request structure:
+ *
+ * {
+ *   Map(1) {
+ *     key = String("DescribePCR"),
+ *     value = Map(1) {
+ *       key = String("index"),
+ *       value = Uint8(pcr)
+ *     }
+ *   }
+ * }
+ */
+typedef struct NSMDescribePCRReq {
+    uint8_t index;
+} NSMDescribePCRReq;
+
+static enum NSMResponseTypes get_nsm_describe_pcr_req(
+    uint8_t *req, size_t len,
+    NSMDescribePCRReq *nsm_req)
+{
+    size_t size;
+    uint8_t *str;
+    struct cbor_pair *pair;
+    cbor_item_t *item = NULL;
+    struct cbor_load_result result;
+    enum NSMResponseTypes r = NSM_INVALID_ARGUMENT;
+
+    item = cbor_load(req, len, &result);
+    if (!item || result.error.code != CBOR_ERR_NONE) {
+        goto cleanup;
+    }
+
+    pair = cbor_map_handle(item);
+    if (!cbor_isa_map(pair->value) || cbor_map_size(pair->value) != 1) {
+        goto cleanup;
+    }
+
+    pair = cbor_map_handle(pair->value);
+    if (!cbor_isa_string(pair->key)) {
+        goto cleanup;
+    }
+
+    str = cbor_string_handle(pair->key);
+    size = cbor_string_length(pair->key);
+    if (!str || size != 5 || memcmp(str, "index", 5) != 0) {
+        goto cleanup;
+    }
+    if (!cbor_isa_uint(pair->value) ||
+        cbor_int_get_width(pair->value) != CBOR_INT_8) {
+        goto cleanup;
+    }
+
+    nsm_req->index = cbor_get_uint8(pair->value);
+    r = NSM_SUCCESS;
+    goto cleanup;
+
+ cleanup:
+    if (item) {
+        cbor_decref(&item);
+    }
+    return r;
+}
+
+/*
+ * DescribePCR response structure:
+ *
+ * {
+ *   Map(1) {
+ *     key = String("DescribePCR"),
+ *     value = Map(2) {
+ *       key = String("data"),
+ *       value = Byte_String(),
+ *       key = String("lock"),
+ *       value = Bool()
+ *     }
+ *   }
+ * }
+ */
+static bool handle_DescribePCR(VirtIONSM *vnsm, struct iovec *request,
+                               struct iovec *response, Error **errp)
+{
+    cbor_item_t *root = NULL;
+    cbor_item_t *nested_map;
+    size_t len;
+    NSMDescribePCRReq nsm_req;
+    enum NSMResponseTypes type;
+    struct PCRInfo *pcr;
+    bool r = false;
+
+    type = get_nsm_describe_pcr_req(request->iov_base, request->iov_len,
+                                    &nsm_req);
+    if (type != NSM_SUCCESS) {
+        if (error_response(response, type, errp)) {
+            r = true;
+        }
+        goto out;
+    }
+    if (nsm_req.index >= vnsm->max_pcrs) {
+        if (error_response(response, NSM_INVALID_INDEX, errp)) {
+            r = true;
+        }
+        goto out;
+    }
+    pcr = &(vnsm->pcrs[nsm_req.index]);
+
+    root = cbor_new_definite_map(1);
+    if (!root) {
+        goto err;
+    }
+
+    if (!qemu_cbor_add_map_to_map(root, "DescribePCR", 2, &nested_map)) {
+        goto err;
+    }
+
+    if (!qemu_cbor_add_bytestring_to_map(nested_map, "data", pcr->data,
+                                         SHA384_BYTE_LEN)) {
+        goto err;
+    }
+
+    if (!qemu_cbor_add_bool_to_map(nested_map, "lock", pcr->locked)) {
+        goto err;
+    }
+
+    len = cbor_serialize(root, response->iov_base, response->iov_len);
+    if (len == 0) {
+        if (error_response(response, NSM_BUFFER_TOO_SMALL, errp)) {
+            r = true;
+        }
+        goto out;
+    }
+
+    response->iov_len = len;
+    r = true;
+
+ out:
+    if (root) {
+        cbor_decref(&root);
+    }
+    return r;
+
+ err:
+    error_setg(errp, "Failed to initialize DescribePCR response");
+    goto out;
+}
+
+/*
+ * ExtendPCR request structure:
+ *
+ * {
+ *   Map(1) {
+ *     key = String("ExtendPCR"),
+ *     value = Map(2) {
+ *       key = String("index"),
+ *       value = Uint8(pcr),
+ *       key = String("data"),
+ *       value = Byte_String(data),
+ *     }
+ *   }
+ * }
+ */
+typedef struct NSMExtendPCRReq {
+    uint8_t index;
+    uint16_t data_len;
+    uint8_t data[NSM_PCR_DATA_REQ_MAX_SIZE];
+} NSMExtendPCRReq;
+
+static bool get_nsm_extend_pcr_req(uint8_t *req, size_t len,
+                                   NSMExtendPCRReq *nsm_req)
+{
+    cbor_item_t *item = NULL;
+    size_t size ;
+    uint8_t *str;
+    struct cbor_pair *pair;
+    struct cbor_load_result result;
+    enum NSMResponseTypes r = NSM_INVALID_ARGUMENT;
+
+    item = cbor_load(req, len, &result);
+    if (!item || result.error.code != CBOR_ERR_NONE) {
+        goto cleanup;
+    }
+
+    pair = cbor_map_handle(item);
+    if (!cbor_isa_map(pair->value) || cbor_map_size(pair->value) != 2) {
+        goto cleanup;
+    }
+    pair = cbor_map_handle(pair->value);
+    if (!cbor_isa_string(pair->key)) {
+        goto cleanup;
+    }
+    str = cbor_string_handle(pair->key);
+    size = cbor_string_length(pair->key);
+    if (!str || size != 5 || memcmp(str, "index", 5) != 0) {
+        goto cleanup;
+    }
+    if (!cbor_isa_uint(pair->value) ||
+        cbor_int_get_width(pair->value) != CBOR_INT_8) {
+        goto cleanup;
+    }
+    nsm_req->index = cbor_get_uint8(pair->value);
+
+    /* let's move forward to the next key value pair */
+    pair++;
+    if (!cbor_isa_string(pair->key)) {
+        goto cleanup;
+    }
+    str = cbor_string_handle(pair->key);
+    size = cbor_string_length(pair->key);
+    if (!str || size != 4 || memcmp(str, "data", 4) != 0) {
+        goto cleanup;
+    }
+    if (!cbor_isa_bytestring(pair->value)) {
+        goto cleanup;
+    }
+    str = cbor_bytestring_handle(pair->value);
+    size = cbor_bytestring_length(pair->value);
+    if (!str || size == 0) {
+        goto cleanup;
+    }
+    if (size > NSM_PCR_DATA_REQ_MAX_SIZE) {
+        r = NSM_INPUT_TOO_LARGE;
+        goto cleanup;
+    }
+
+    nsm_req->data_len = size;
+    memcpy(nsm_req->data, str, size);
+    r = NSM_SUCCESS;
+    goto cleanup;
+
+ cleanup:
+    if (item) {
+        cbor_decref(&item);
+    }
+    return r;
+}
+
+/*
+ * ExtendPCR response structure:
+ *
+ * {
+ *   Map(1) {
+ *     key = String("ExtendPCR"),
+ *     value = Map(1) {
+ *       key = String("data"),
+ *       value = Byte_String()
+ *     }
+ *   }
+ * }
+ */
+static bool handle_ExtendPCR(VirtIONSM *vnsm, struct iovec *request,
+                             struct iovec *response, Error **errp)
+{
+    cbor_item_t *root = NULL;
+    cbor_item_t *nested_map;
+    size_t len;
+    NSMExtendPCRReq nsm_req;
+    enum NSMResponseTypes type;
+    struct PCRInfo *pcr;
+    bool r = false;
+
+    type = get_nsm_extend_pcr_req(request->iov_base, request->iov_len,
+                                  &nsm_req);
+    if (type != NSM_SUCCESS) {
+        if (error_response(response, type, errp)) {
+            r = true;
+        }
+        goto out;
+    }
+    if (nsm_req.index >= vnsm->max_pcrs) {
+        if (error_response(response, NSM_INVALID_INDEX, errp)) {
+            r = true;
+        }
+        goto out;
+    }
+
+    pcr = &(vnsm->pcrs[nsm_req.index]);
+
+    if (pcr->locked) {
+        if (error_response(response, NSM_READONLY_INDEX, errp)) {
+            r = true;
+        }
+        goto out;
+    }
+
+    if (!vnsm->extend_pcr(vnsm, nsm_req.index, nsm_req.data,
+                          nsm_req.data_len)) {
+        if (error_response(response, NSM_INTERNAL_ERROR, errp)) {
+            r = true;
+        }
+        goto out;
+    }
+
+    root = cbor_new_definite_map(1);
+    if (!root) {
+        goto err;
+    }
+
+    if (!qemu_cbor_add_map_to_map(root, "ExtendPCR", 1, &nested_map)) {
+        goto err;
+    }
+
+    if (!qemu_cbor_add_bytestring_to_map(nested_map, "data", pcr->data,
+                                         SHA384_BYTE_LEN)) {
+        goto err;
+    }
+
+    len = cbor_serialize(root, response->iov_base, response->iov_len);
+    if (len == 0) {
+        if (error_response(response, NSM_BUFFER_TOO_SMALL, errp)) {
+            r = true;
+        }
+        goto out;
+    }
+
+    response->iov_len = len;
+    r = true;
+
+ out:
+    if (root) {
+        cbor_decref(&root);
+    }
+    return r;
+
+ err:
+    error_setg(errp, "Failed to initialize DescribePCR response");
+    goto out;
+}
+
+/*
+ * LockPCR request structure:
+ *
+ * {
+ *   Map(1) {
+ *     key = String("LockPCR"),
+ *     value = Map(1) {
+ *       key = String("index"),
+ *       value = Uint8(pcr)
+ *     }
+ *   }
+ * }
+ */
+typedef struct NSMLockPCRReq {
+    uint8_t index;
+} NSMLockPCRReq;
+
+static enum NSMResponseTypes get_nsm_lock_pcr_req(uint8_t *req, size_t len,
+                                                  NSMLockPCRReq *nsm_req)
+{
+    cbor_item_t *item = NULL;
+    size_t size;
+    uint8_t *str;
+    struct cbor_pair *pair;
+    struct cbor_load_result result;
+    enum NSMResponseTypes r = NSM_INVALID_ARGUMENT;
+
+    item = cbor_load(req, len, &result);
+    if (!item || result.error.code != CBOR_ERR_NONE) {
+        goto cleanup;
+    }
+
+    pair = cbor_map_handle(item);
+    if (!cbor_isa_map(pair->value) || cbor_map_size(pair->value) != 1) {
+        goto cleanup;
+    }
+    pair = cbor_map_handle(pair->value);
+    if (!cbor_isa_string(pair->key)) {
+        goto cleanup;
+    }
+    str = cbor_string_handle(pair->key);
+    size = cbor_string_length(pair->key);
+    if (!str || size != 5 || memcmp(str, "index", 5) != 0) {
+        goto cleanup;
+    }
+    if (!cbor_isa_uint(pair->value) ||
+        cbor_int_get_width(pair->value) != CBOR_INT_8) {
+        goto cleanup;
+    }
+
+    nsm_req->index = cbor_get_uint8(pair->value);
+    r = NSM_SUCCESS;
+    goto cleanup;
+
+ cleanup:
+    if (item) {
+        cbor_decref(&item);
+    }
+    return r;
+}
+
+/*
+ * LockPCR success response structure:
+ * {
+ *   String("LockPCR")
+ * }
+ */
+static bool handle_LockPCR(VirtIONSM *vnsm, struct iovec *request,
+                           struct iovec *response, Error **errp)
+{
+    cbor_item_t *root = NULL;
+    size_t len;
+    NSMLockPCRReq nsm_req;
+    enum NSMResponseTypes type;
+    struct PCRInfo *pcr;
+    bool r = false;
+
+    type = get_nsm_lock_pcr_req(request->iov_base, request->iov_len, &nsm_req);
+    if (type != NSM_SUCCESS) {
+        if (error_response(response, type, errp)) {
+            r = true;
+        }
+        goto cleanup;
+    }
+    if (nsm_req.index >= vnsm->max_pcrs) {
+        if (error_response(response, NSM_INVALID_INDEX, errp)) {
+            r = true;
+        }
+        goto cleanup;
+    }
+
+    pcr = &(vnsm->pcrs[nsm_req.index]);
+
+    if (pcr->locked) {
+        if (error_response(response, NSM_READONLY_INDEX, errp)) {
+            r = true;
+        }
+        goto cleanup;
+    }
+
+    pcr->locked = true;
+
+    root = cbor_build_string("LockPCR");
+    if (!root) {
+        goto err;
+    }
+
+    len = cbor_serialize(root, response->iov_base, response->iov_len);
+    if (len == 0) {
+        if (error_response(response, NSM_BUFFER_TOO_SMALL, errp)) {
+            r = true;
+        }
+        goto cleanup;
+    }
+
+    response->iov_len = len;
+    r = true;
+    goto cleanup;
+
+ err:
+    error_setg(errp, "Failed to initialize LockPCR response");
+
+ cleanup:
+    if (root) {
+        cbor_decref(&root);
+    }
+    return r;
+}
+
+/*
+ * LockPCRs request structure:
+ *
+ * {
+ *   Map(1) {
+ *     key = String("LockPCRs"),
+ *     value = Map(1) {
+ *       key = String("range"),
+ *       value = Uint8(pcr)
+ *     }
+ *   }
+ * }
+ */
+typedef struct NSMLockPCRsReq {
+    uint16_t range;
+} NSMLockPCRsReq;
+
+static enum NSMResponseTypes get_nsm_lock_pcrs_req(uint8_t *req, size_t len,
+                                                   NSMLockPCRsReq *nsm_req)
+{
+    cbor_item_t *item = NULL;
+    size_t size;
+    uint8_t *str;
+    struct cbor_pair *pair;
+    struct cbor_load_result result;
+    enum NSMResponseTypes r = NSM_INVALID_ARGUMENT;
+
+    item = cbor_load(req, len, &result);
+    if (!item || result.error.code != CBOR_ERR_NONE) {
+        goto cleanup;
+    }
+
+    pair = cbor_map_handle(item);
+    if (!cbor_isa_map(pair->value) || cbor_map_size(pair->value) != 1) {
+        goto cleanup;
+    }
+    pair = cbor_map_handle(pair->value);
+    if (!cbor_isa_string(pair->key)) {
+        goto cleanup;
+    }
+    str = cbor_string_handle(pair->key);
+    size = cbor_string_length(pair->key);
+    if (!str || size != 5 || memcmp(str, "range", 5) != 0) {
+        goto cleanup;
+    }
+    if (!cbor_isa_uint(pair->value) ||
+        cbor_int_get_width(pair->value) != CBOR_INT_8) {
+        goto cleanup;
+    }
+
+    nsm_req->range = cbor_get_uint8(pair->value);
+    r = NSM_SUCCESS;
+    goto cleanup;
+
+ cleanup:
+    if (item) {
+        cbor_decref(&item);
+    }
+    return r;
+}
+
+/*
+ * LockPCRs success response structure:
+ * {
+ *   String("LockPCRs")
+ * }
+ */
+static bool handle_LockPCRs(VirtIONSM *vnsm, struct iovec *request,
+                            struct iovec *response, Error **errp)
+{
+    cbor_item_t *root = NULL;
+    size_t len;
+    NSMLockPCRsReq nsm_req;
+    enum NSMResponseTypes type;
+    bool r = false;
+
+    type = get_nsm_lock_pcrs_req(request->iov_base, request->iov_len, &nsm_req);
+    if (type != NSM_SUCCESS) {
+        if (error_response(response, type, errp)) {
+            r = true;
+        }
+        goto cleanup;
+    }
+    if (nsm_req.range >= vnsm->max_pcrs) {
+        if (error_response(response, NSM_INVALID_INDEX, errp)) {
+            r = true;
+        }
+        goto cleanup;
+    }
+
+    for (int i = 0; i <= nsm_req.range; ++i) {
+        vnsm->pcrs[i].locked = true;
+    }
+
+    root = cbor_build_string("LockPCRs");
+    if (!root) {
+        goto err;
+    }
+
+    len = cbor_serialize(root, response->iov_base, response->iov_len);
+    if (len == 0) {
+        if (error_response(response, NSM_BUFFER_TOO_SMALL, errp)) {
+            r = true;
+        }
+        goto cleanup;
+    }
+
+    response->iov_len = len;
+    r = true;
+    goto cleanup;
+
+ err:
+    error_setg(errp, "Failed to initialize response");
+
+ cleanup:
+    if (root) {
+        cbor_decref(&root);
+    }
+    return r;
+}
+
+/*
+ * Attestation request structure:
+ *
+ *   Map(1) {
+ *     key = String("Attestation"),
+ *     value = Map(3) {
+ *       key = String("user_data"),
+ *       value = Byte_String() || null,
+ *       key = String("nonce"),
+ *       value = Byte_String() || null,
+ *       key = String("public_key"),
+ *       value = Byte_String() || null,
+ *     }
+ *   }
+ * }
+ */
+typedef struct NSMAttestationReq {
+    uint16_t user_data_len;
+    uint8_t user_data[NSM_USER_DATA_MAX_SIZE];
+
+    uint16_t nonce_len;
+    uint8_t nonce[NSM_NONCE_MAX_SIZE];
+
+    uint16_t public_key_len;
+    uint8_t public_key[NSM_PUBLIC_KEY_MAX_SIZE];
+} NSMAttestationReq;
+
+static enum NSMResponseTypes get_nsm_attestation_req(uint8_t *req, size_t len,
+                                                     NSMAttestationReq *nsm_req)
+{
+    cbor_item_t *item = NULL;
+    size_t size;
+    uint8_t *str;
+    struct cbor_pair *pair;
+    struct cbor_load_result result;
+    enum NSMResponseTypes r = NSM_INVALID_ARGUMENT;
+
+    item = cbor_load(req, len, &result);
+    if (!item || result.error.code != CBOR_ERR_NONE) {
+        goto cleanup;
+    }
+
+    pair = cbor_map_handle(item);
+    if (!cbor_isa_map(pair->value) || cbor_map_size(pair->value) != 3) {
+        goto cleanup;
+    }
+    pair = cbor_map_handle(pair->value);
+    if (!cbor_isa_string(pair->key)) {
+        goto cleanup;
+    }
+    str = cbor_string_handle(pair->key);
+    size = cbor_string_length(pair->key);
+    if (!str || size != 9 || memcmp(str, "user_data", 9) != 0) {
+        goto cleanup;
+    }
+
+    if (cbor_isa_bytestring(pair->value)) {
+        str = cbor_bytestring_handle(pair->value);
+        size = cbor_bytestring_length(pair->value);
+        if (!str || size == 0) {
+            goto cleanup;
+        }
+        if (size > NSM_USER_DATA_MAX_SIZE) {
+            r = NSM_INPUT_TOO_LARGE;
+            goto cleanup;
+        }
+        memcpy(nsm_req->user_data, str, size);
+        nsm_req->user_data_len = size;
+    } else if (cbor_is_null(pair->value)) {
+        nsm_req->user_data_len = 0;
+    } else {
+        goto cleanup;
+    }
+
+    /* let's move forward */
+    pair++;
+    if (!cbor_isa_string(pair->key)) {
+        goto cleanup;
+    }
+    str = cbor_string_handle(pair->key);
+    size = cbor_string_length(pair->key);
+    if (!str || size != 5 || memcmp(str, "nonce", 5) != 0) {
+        goto cleanup;
+    }
+
+    if (cbor_isa_bytestring(pair->value)) {
+        str = cbor_bytestring_handle(pair->value);
+        size = cbor_bytestring_length(pair->value);
+        if (!str || size == 0) {
+            goto cleanup;
+        }
+        if (size > NSM_NONCE_MAX_SIZE) {
+            r = NSM_INPUT_TOO_LARGE;
+            goto cleanup;
+        }
+        memcpy(nsm_req->nonce, str, size);
+        nsm_req->nonce_len = size;
+    } else if (cbor_is_null(pair->value)) {
+        nsm_req->nonce_len = 0;
+    } else {
+        goto cleanup;
+    }
+
+    /* let's move forward */
+    pair++;
+    if (!cbor_isa_string(pair->key)) {
+        goto cleanup;
+    }
+    str = cbor_string_handle(pair->key);
+    size = cbor_string_length(pair->key);
+    if (!str || size != 10 || memcmp(str, "public_key", 10) != 0) {
+        goto cleanup;
+    }
+
+    if (cbor_isa_bytestring(pair->value)) {
+        str = cbor_bytestring_handle(pair->value);
+        size = cbor_bytestring_length(pair->value);
+        if (!str || size == 0) {
+            goto cleanup;
+        }
+        if (size > NSM_PUBLIC_KEY_MAX_SIZE) {
+            r = NSM_INPUT_TOO_LARGE;
+            goto cleanup;
+        }
+        memcpy(nsm_req->public_key, str, size);
+        nsm_req->public_key_len = size;
+    } else if (cbor_is_null(pair->value)) {
+        nsm_req->public_key_len = 0;
+    } else {
+        goto cleanup;
+    }
+
+    r = NSM_SUCCESS;
+
+ cleanup:
+    if (item) {
+        cbor_decref(&item);
+    }
+    return r;
+}
+
+static bool add_protected_header_to_cose(cbor_item_t *cose)
+{
+    cbor_item_t *map = NULL;
+    cbor_item_t *key = NULL;
+    cbor_item_t *value = NULL;
+    cbor_item_t *bs = NULL;
+    size_t len;
+    bool r = false;
+    size_t buf_len = 4096;
+    uint8_t *buf = g_malloc(buf_len);
+
+    map = cbor_new_definite_map(1);
+    if (!map) {
+        goto cleanup;
+    }
+    key = cbor_build_uint8(1);
+    if (!key) {
+        goto cleanup;
+    }
+    value = cbor_new_int8();
+    if (!value) {
+        goto cleanup;
+    }
+    cbor_mark_negint(value);
+    /* we don't actually sign the data, so we use -1 as the 'alg' value */
+    cbor_set_uint8(value, 0);
+
+    if (!qemu_cbor_map_add(map, key, value)) {
+        goto cleanup;
+    }
+
+    len = cbor_serialize(map, buf, buf_len);
+    if (len == 0) {
+        goto cleanup_map;
+    }
+
+    bs = cbor_build_bytestring(buf, len);
+    if (!bs) {
+        goto cleanup_map;
+    }
+    if (!qemu_cbor_array_push(cose, bs)) {
+        cbor_decref(&bs);
+        goto cleanup_map;
+    }
+    r = true;
+    goto cleanup_map;
+
+ cleanup:
+    if (key) {
+        cbor_decref(&key);
+    }
+    if (value) {
+        cbor_decref(&value);
+    }
+
+ cleanup_map:
+    if (map) {
+        cbor_decref(&map);
+    }
+    g_free(buf);
+    return r;
+}
+
+static bool add_unprotected_header_to_cose(cbor_item_t *cose)
+{
+    cbor_item_t *map = cbor_new_definite_map(0);
+    if (!map) {
+        goto cleanup;
+    }
+    if (!qemu_cbor_array_push(cose, map)) {
+        goto cleanup;
+    }
+
+    return true;
+
+ cleanup:
+    if (map) {
+        cbor_decref(&map);
+    }
+    return false;
+}
+
+static bool add_ca_bundle_to_payload(cbor_item_t *map)
+{
+    cbor_item_t *key_cbor = NULL;
+    cbor_item_t *value_cbor = NULL;
+    cbor_item_t *bs = NULL;
+    uint8_t zero[64] = {0};
+
+    key_cbor = cbor_build_string("cabundle");
+    if (!key_cbor) {
+        goto cleanup;
+    }
+    value_cbor = cbor_new_definite_array(1);
+    if (!value_cbor) {
+        goto cleanup;
+    }
+    bs = cbor_build_bytestring(zero, 64);
+    if (!bs) {
+        goto cleanup;
+    }
+    if (!qemu_cbor_array_push(value_cbor, bs)) {
+        cbor_decref(&bs);
+        goto cleanup;
+    }
+    if (!qemu_cbor_map_add(map, key_cbor, value_cbor)) {
+        goto cleanup;
+    }
+
+    return true;
+
+ cleanup:
+    if (key_cbor) {
+        cbor_decref(&key_cbor);
+    }
+    if (value_cbor) {
+        cbor_decref(&value_cbor);
+    }
+    return false;
+}
+
+static bool add_payload_to_cose(cbor_item_t *cose, VirtIONSM *vnsm)
+{
+    cbor_item_t *root = NULL;
+    cbor_item_t *nested_map;
+    cbor_item_t *bs = NULL;
+    size_t locked_cnt;
+    uint8_t ind[NSM_MAX_PCRS];
+    size_t payload_map_size = 6;
+    size_t len;
+    struct PCRInfo *pcr;
+    uint8_t zero[64] = {0};
+    bool r = false;
+    size_t buf_len = 16384;
+    uint8_t *buf = g_malloc(buf_len);
+
+    if (vnsm->public_key_len > 0) {
+        payload_map_size++;
+    }
+    if (vnsm->user_data_len > 0) {
+        payload_map_size++;
+    }
+    if (vnsm->nonce_len > 0) {
+        payload_map_size++;
+    }
+    root = cbor_new_definite_map(payload_map_size);
+    if (!root) {
+        goto cleanup;
+    }
+    if (!qemu_cbor_add_string_to_map(root, "module_id", vnsm->module_id)) {
+        goto cleanup;
+    }
+    if (!qemu_cbor_add_string_to_map(root, "digest", vnsm->digest)) {
+        goto cleanup;
+    }
+    if (!qemu_cbor_add_uint64_to_map(root, "timestamp",
+                                     (uint64_t) time(NULL) * 1000)) {
+        goto cleanup;
+    }
+
+    locked_cnt = 0;
+    for (uint8_t i = 0; i < NSM_MAX_PCRS; ++i) {
+        if (vnsm->pcrs[i].locked) {
+            ind[locked_cnt++] = i;
+        }
+    }
+    if (!qemu_cbor_add_map_to_map(root, "pcrs", locked_cnt, &nested_map)) {
+        goto cleanup;
+    }
+    for (uint8_t i = 0; i < locked_cnt; ++i) {
+        pcr = &(vnsm->pcrs[ind[i]]);
+        if (!qemu_cbor_add_uint8_key_bytestring_to_map(nested_map, ind[i],
+                                                       pcr->data,
+                                                       SHA384_BYTE_LEN)) {
+            goto cleanup;
+        }
+    }
+    if (!qemu_cbor_add_bytestring_to_map(root, "certificate", zero, 64)) {
+        goto cleanup;
+    }
+    if (!add_ca_bundle_to_payload(root)) {
+        goto cleanup;
+    }
+    if (vnsm->public_key_len > 0 &&
+        !qemu_cbor_add_bytestring_to_map(root, "public_key", vnsm->public_key,
+                                         vnsm->public_key_len)) {
+        goto cleanup;
+    }
+    if (!qemu_cbor_add_bytestring_to_map(root, "user_data", vnsm->user_data,
+                                         vnsm->user_data_len)) {
+        goto cleanup;
+    }
+    if (!qemu_cbor_add_bytestring_to_map(root, "nonce", vnsm->nonce,
+                                         vnsm->nonce_len)) {
+        goto cleanup;
+    }
+    len = cbor_serialize(root, buf, buf_len);
+    if (len == 0) {
+        goto cleanup;
+    }
+
+    bs = cbor_build_bytestring(buf, len);
+    if (!bs) {
+        goto cleanup;
+    }
+    if (!qemu_cbor_array_push(cose, bs)) {
+        cbor_decref(&bs);
+        goto cleanup;
+    }
+
+    r = true;
+
+ cleanup:
+    if (root) {
+        cbor_decref(&root);
+    }
+    g_free(buf);
+    return r;
+}
+
+static bool add_signature_to_cose(cbor_item_t *cose)
+{
+    cbor_item_t *bs = NULL;
+    uint8_t zero[64] = {0};
+
+    /* we don't actually sign the data, so we just put 64 zero bytes */
+    bs = cbor_build_bytestring(zero, 64);
+    if (!bs) {
+        goto cleanup;
+    }
+
+    if (!qemu_cbor_array_push(cose, bs)) {
+        goto cleanup;
+    }
+
+    return true;
+
+ cleanup:
+    if (bs) {
+        cbor_decref(&bs);
+    }
+    return false;
+}
+
+/*
+ * Attestation response structure:
+ *
+ * {
+ *   Map(1) {
+ *     key = String("Attestation"),
+ *     value = Map(1) {
+ *       key = String("document"),
+ *       value = Byte_String()
+ *     }
+ *   }
+ * }
+ *
+ * The document is a serialized COSE sign1 blob of the structure:
+ * {
+ *   Array(4) {
+ *     [0] { ByteString() }, // serialized protected header
+ *     [1] { Map(0) },       // 0 length map
+ *     [2] { ByteString() }, // serialized payload
+ *     [3] { ByteString() }, // signature
+ *   }
+ * }
+ *
+ * where [0] protected header is a serialized CBOR blob of the structure:
+ * {
+ *   Map(1) {
+ *     key = Uint8(1)         // alg
+ *     value = NegativeInt8() // Signing algorithm
+ *   }
+ * }
+ *
+ * [2] payload is serialized CBOR blob of the structure:
+ * {
+ *   Map(9/8/7) {
+ *     [0] { key = String("module_id"), value = String(module_id) },
+ *     [1] { key = String("digest"), value = String("SHA384") },
+ *     [2] {
+ *           key = String("timestamp"),
+ *           value = Uint64(unix epoch of  when document was created)
+ *         },
+ *     [3] {
+ *           key = String("pcrs"),
+ *           value = Map(locked_pcr_cnt) {
+ *                       key = Uint8(pcr_index),
+ *                       value = ByteString(pcr_data)
+ *                   },
+ *         },
+ *     [4] {
+ *           key = String("certificate"),
+ *           value = ByteString(Signing certificate)
+ *         },
+ *     [5] { key = String("cabundle"), value = Array(N) { ByteString()... } },
+ *     [6] { key = String("public_key"), value = ByteString() }, // optional
+ *     [7] { key = String("user_data"), value = ByteString() },  // optional
+ *     [8] { key = String("nonce"), value = ByteString() },      // optional
+ *   }
+ * }
+ */
+static bool handle_Attestation(VirtIONSM *vnsm, struct iovec *request,
+                               struct iovec *response, Error **errp)
+{
+    cbor_item_t *root = NULL;
+    cbor_item_t *cose = NULL;
+    cbor_item_t *nested_map;
+    size_t len;
+    NSMAttestationReq nsm_req;
+    enum NSMResponseTypes type;
+    bool r = false;
+    size_t buf_len = 16384;
+    uint8_t *buf = g_malloc(buf_len);
+
+    type = get_nsm_attestation_req(request->iov_base, request->iov_len,
+                                   &nsm_req);
+    if (type != NSM_SUCCESS) {
+        if (error_response(response, type, errp)) {
+            r = true;
+        }
+        goto out;
+    }
+
+    cose = cbor_new_definite_array(4);
+    if (!cose) {
+        goto err;
+    }
+    if (!add_protected_header_to_cose(cose)) {
+        goto err;
+    }
+    if (!add_unprotected_header_to_cose(cose)) {
+        goto err;
+    }
+
+    if (nsm_req.public_key_len > 0) {
+        memcpy(vnsm->public_key, nsm_req.public_key, nsm_req.public_key_len);
+        vnsm->public_key_len = nsm_req.public_key_len;
+    }
+    if (nsm_req.user_data_len > 0) {
+        memcpy(vnsm->user_data, nsm_req.user_data, nsm_req.user_data_len);
+        vnsm->user_data_len = nsm_req.user_data_len;
+    }
+    if (nsm_req.nonce_len > 0) {
+        memcpy(vnsm->nonce, nsm_req.nonce, nsm_req.nonce_len);
+        vnsm->nonce_len = nsm_req.nonce_len;
+    }
+
+    if (!add_payload_to_cose(cose, vnsm)) {
+        goto err;
+    }
+
+    if (!add_signature_to_cose(cose)) {
+        goto err;
+    }
+
+    len = cbor_serialize(cose, buf, buf_len);
+    if (len == 0) {
+        goto err;
+    }
+
+    root = cbor_new_definite_map(1);
+    if (!root) {
+        goto err;
+    }
+    if (!qemu_cbor_add_map_to_map(root, "Attestation", 1, &nested_map)) {
+        goto err;
+    }
+    if (!qemu_cbor_add_bytestring_to_map(nested_map, "document", buf, len)) {
+        goto err;
+    }
+
+    len = cbor_serialize(root, response->iov_base, response->iov_len);
+    if (len == 0) {
+        if (error_response(response, NSM_BUFFER_TOO_SMALL, errp)) {
+            r = true;
+        }
+        goto out;
+    }
+
+    response->iov_len = len;
+    r = true;
+
+ out:
+    if (root) {
+        cbor_decref(&root);
+    }
+    if (cose) {
+        cbor_decref(&cose);
+    }
+    g_free(buf);
+    return r;
+
+ err:
+    error_setg(errp, "Failed to initialize Attestation response");
+    goto out;
+}
+
+enum CBOR_ROOT_TYPE {
+    CBOR_ROOT_TYPE_STRING = 0,
+    CBOR_ROOT_TYPE_MAP = 1,
+};
+
+struct nsm_cmd {
+    char name[16];
+    /*
+     * There are 2 types of request
+     * 1) String(); "GetRandom", "DescribeNSM"
+     * 2) Map(1) { key: String(), value: ... }
+     */
+    enum CBOR_ROOT_TYPE root_type;
+    bool (*response_fn)(VirtIONSM *vnsm, struct iovec *request,
+                        struct iovec *response, Error **errp);
+};
+
+const struct nsm_cmd nsm_cmds[] = {
+    { "GetRandom",   CBOR_ROOT_TYPE_STRING,  handle_GetRandom },
+    { "DescribeNSM", CBOR_ROOT_TYPE_STRING,  handle_DescribeNSM },
+    { "DescribePCR", CBOR_ROOT_TYPE_MAP,     handle_DescribePCR },
+    { "ExtendPCR",   CBOR_ROOT_TYPE_MAP,     handle_ExtendPCR },
+    { "LockPCR",     CBOR_ROOT_TYPE_MAP,     handle_LockPCR },
+    { "LockPCRs",    CBOR_ROOT_TYPE_MAP,     handle_LockPCRs },
+    { "Attestation", CBOR_ROOT_TYPE_MAP,     handle_Attestation },
+};
+
+static const struct nsm_cmd *get_nsm_request_cmd(uint8_t *buf, size_t len)
+{
+    size_t size;
+    uint8_t *req;
+    enum CBOR_ROOT_TYPE root_type;
+    struct cbor_load_result result;
+    cbor_item_t *item = cbor_load(buf, len, &result);
+    if (!item || result.error.code != CBOR_ERR_NONE) {
+        goto cleanup;
+    }
+
+    if (cbor_isa_string(item)) {
+        size = cbor_string_length(item);
+        req = cbor_string_handle(item);
+        root_type = CBOR_ROOT_TYPE_STRING;
+    } else if (cbor_isa_map(item) && cbor_map_size(item) == 1) {
+        struct cbor_pair *handle = cbor_map_handle(item);
+        if (cbor_isa_string(handle->key)) {
+            size = cbor_string_length(handle->key);
+            req = cbor_string_handle(handle->key);
+            root_type = CBOR_ROOT_TYPE_MAP;
+        } else {
+            goto cleanup;
+        }
+    } else {
+        goto cleanup;
+    }
+
+    if  (size == 0 || req == NULL) {
+        goto cleanup;
+    }
+
+    for (int i = 0; i < ARRAY_SIZE(nsm_cmds); ++i) {
+        if (nsm_cmds[i].root_type == root_type &&
+            strlen(nsm_cmds[i].name) == size &&
+            memcmp(nsm_cmds[i].name, req, size) == 0) {
+            cbor_decref(&item);
+            return &nsm_cmds[i];
+        }
+    }
+
+ cleanup:
+    if (item) {
+        cbor_decref(&item);
+    }
+    return NULL;
+}
+
+static bool get_nsm_request_response(VirtIONSM *vnsm, struct iovec *req,
+                                     struct iovec *resp, Error **errp)
+{
+    const struct nsm_cmd *cmd;
+
+    cmd = get_nsm_request_cmd(req->iov_base, req->iov_len);
+
+    if (cmd == NULL) {
+        if (error_response(resp, NSM_INVALID_OPERATION, errp)) {
+            return true;
+        }
+        error_setg(errp, "Failed to initialize InvalidOperation response");
+        return false;
+    }
+
+    return cmd->response_fn(vnsm, req, resp, errp);
+}
+
+static void handle_input(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtQueueElement *out_elem = NULL;
+    VirtQueueElement *in_elem = NULL;
+    VirtIONSM *vnsm = VIRTIO_NSM(vdev);
+    Error *err = NULL;
+
+    out_elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
+    if (!out_elem) {
+        /* nothing in virtqueue */
+        return;
+    }
+
+    if (out_elem->out_num != 1) {
+        virtio_error(vdev, "Expected one request buffer first in virtqueue");
+        goto cleanup;
+    }
+
+    in_elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
+    if (!in_elem) {
+        virtio_error(vdev, "Expected response buffer after request buffer "
+                     "in virtqueue");
+        goto cleanup;
+    }
+    if (in_elem->in_num != 1) {
+        virtio_error(vdev, "Expected one response buffer after request buffer "
+                     "in virtqueue");
+        goto cleanup;
+    }
+
+    if (!get_nsm_request_response(vnsm, out_elem->out_sg, in_elem->in_sg,
+                                  &err)) {
+        error_report_err(err);
+        virtio_error(vdev, "Failed to get NSM request response");
+        goto cleanup;
+    }
+
+    virtqueue_push(vq, out_elem, 0);
+    virtqueue_push(vq, in_elem, in_elem->in_sg->iov_len);
+    g_free(out_elem);
+    g_free(in_elem);
+    virtio_notify(vdev, vq);
+    return;
+
+ cleanup:
+    if (out_elem) {
+        virtqueue_detach_element(vq, out_elem, 0);
+    }
+    if (in_elem) {
+        virtqueue_detach_element(vq, in_elem, 0);
+    }
+    g_free(out_elem);
+    g_free(in_elem);
+    return;
+}
+
+static uint64_t get_features(VirtIODevice *vdev, uint64_t f, Error **errp)
+{
+    return f;
+}
+
+static bool extend_pcr(VirtIONSM *vnsm, int ind, uint8_t *data, uint16_t len)
+{
+    Error *err = NULL;
+    struct PCRInfo *pcr = &(vnsm->pcrs[ind]);
+    size_t digest_len = SHA384_BYTE_LEN;
+    uint8_t result[SHA384_BYTE_LEN];
+    uint8_t *ptr = result;
+    struct iovec iov[2] = {
+        { .iov_base = pcr->data, .iov_len = SHA384_BYTE_LEN },
+        { .iov_base = data, .iov_len = len },
+    };
+
+    if (qcrypto_hash_bytesv(QCRYPTO_HASH_ALG_SHA384, iov, 2, &ptr, &digest_len,
+                            &err) < 0) {
+        return false;
+    }
+
+    memcpy(pcr->data, result, SHA384_BYTE_LEN);
+    return true;
+}
+
+static void lock_pcr(VirtIONSM *vnsm, int ind)
+{
+    vnsm->pcrs[ind].locked = true;
+}
+
+static void virtio_nsm_device_realize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtIONSM *vnsm = VIRTIO_NSM(dev);
+
+    vnsm->max_pcrs = NSM_MAX_PCRS;
+    vnsm->digest = (char *) "SHA384";
+    if (vnsm->module_id == NULL) {
+        vnsm->module_id = (char *) "i-234-enc5678";
+    }
+    vnsm->version_major = 1;
+    vnsm->version_minor = 0;
+    vnsm->version_patch = 0;
+    vnsm->extend_pcr = extend_pcr;
+    vnsm->lock_pcr = lock_pcr;
+
+    virtio_init(vdev, VIRTIO_ID_NITRO_SEC_MOD, 0);
+
+    vnsm->vq = virtio_add_queue(vdev, 2, handle_input);
+}
+
+static void virtio_nsm_device_unrealize(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+
+    virtio_del_queue(vdev, 0);
+    virtio_cleanup(vdev);
+}
+
+static const VMStateDescription vmstate_virtio_nsm = {
+    .name = "virtio-nsm",
+    .minimum_version_id = 1,
+    .version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_VIRTIO_DEVICE,
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static Property virtio_nsm_properties[] = {
+    DEFINE_PROP_STRING("module-id", VirtIONSM, module_id),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_nsm_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, virtio_nsm_properties);
+    dc->vmsd = &vmstate_virtio_nsm;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    vdc->realize = virtio_nsm_device_realize;
+    vdc->unrealize = virtio_nsm_device_unrealize;
+    vdc->get_features = get_features;
+}
+
+static const TypeInfo virtio_nsm_info = {
+    .name = TYPE_VIRTIO_NSM,
+    .parent = TYPE_VIRTIO_DEVICE,
+    .instance_size = sizeof(VirtIONSM),
+    .class_init = virtio_nsm_class_init,
+};
+
+static void virtio_register_types(void)
+{
+    type_register_static(&virtio_nsm_info);
+}
+
+type_init(virtio_register_types)
diff --git a/include/hw/virtio/cbor-helpers.h b/include/hw/virtio/cbor-helpers.h
new file mode 100644
index 0000000000..bfbfbb1613
--- /dev/null
+++ b/include/hw/virtio/cbor-helpers.h
@@ -0,0 +1,43 @@
+/*
+ * QEMU CBOR helpers
+ *
+ * Copyright (c) 2024 Dorjoy Chowdhury <dorjoychy111@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#ifndef QEMU_VIRTIO_CBOR_HELPERS_H
+#define QEMU_VIRTIO_CBOR_HELPERS_H
+
+#include <cbor.h>
+
+bool qemu_cbor_map_add(cbor_item_t *map, cbor_item_t *key, cbor_item_t *value);
+
+bool qemu_cbor_array_push(cbor_item_t *array, cbor_item_t *value);
+
+bool qemu_cbor_add_bool_to_map(cbor_item_t *map, const char *key, bool value);
+
+bool qemu_cbor_add_uint8_to_map(cbor_item_t *map, const char *key,
+                                uint8_t value);
+
+bool qemu_cbor_add_map_to_map(cbor_item_t *map, const char *key,
+                              size_t nested_map_size,
+                              cbor_item_t **nested_map);
+
+bool qemu_cbor_add_bytestring_to_map(cbor_item_t *map, const char *key,
+                                     uint8_t *arr, size_t len);
+
+bool qemu_cbor_add_string_to_map(cbor_item_t *map, const char *key,
+                                 const char *value);
+
+bool qemu_cbor_add_uint8_array_to_map(cbor_item_t *map, const char *key,
+                                      uint8_t *arr, size_t len);
+
+bool qemu_cbor_add_uint8_key_bytestring_to_map(cbor_item_t *map, uint8_t key,
+                                               uint8_t *buf, size_t len);
+
+bool qemu_cbor_add_uint64_to_map(cbor_item_t *map, const char *key,
+                                 uint64_t value);
+#endif
diff --git a/include/hw/virtio/virtio-nsm.h b/include/hw/virtio/virtio-nsm.h
new file mode 100644
index 0000000000..7901c19fe4
--- /dev/null
+++ b/include/hw/virtio/virtio-nsm.h
@@ -0,0 +1,59 @@
+/*
+ * AWS Nitro Secure Module (NSM) device
+ *
+ * Copyright (c) 2024 Dorjoy Chowdhury <dorjoychy111@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#ifndef QEMU_VIRTIO_NSM_H
+#define QEMU_VIRTIO_NSM_H
+
+#include "hw/virtio/virtio.h"
+#include "qom/object.h"
+
+#define NSM_MAX_PCRS 32
+#define NSM_USER_DATA_MAX_SIZE 512
+#define NSM_NONCE_MAX_SIZE 512
+#define NSM_PUBLIC_KEY_MAX_SIZE 1024
+#define SHA384_BYTE_LEN 48
+
+#define TYPE_VIRTIO_NSM "virtio-nsm-device"
+OBJECT_DECLARE_SIMPLE_TYPE(VirtIONSM, VIRTIO_NSM)
+#define VIRTIO_NSM_GET_PARENT_CLASS(obj) \
+    OBJECT_GET_PARENT_CLASS(obj, TYPE_VIRTIO_NSM)
+
+struct PCRInfo {
+    bool locked;
+    uint8_t data[SHA384_BYTE_LEN];
+};
+
+struct VirtIONSM {
+    VirtIODevice parent_obj;
+
+    /* Only one vq - guest puts request and response buffers on it */
+    VirtQueue *vq;
+
+    /* NSM State */
+    uint16_t max_pcrs;
+    struct PCRInfo pcrs[NSM_MAX_PCRS];
+    char *digest;
+    char *module_id;
+    uint8_t version_major;
+    uint8_t version_minor;
+    uint8_t version_patch;
+
+    uint16_t public_key_len;
+    uint8_t public_key[NSM_PUBLIC_KEY_MAX_SIZE];
+    uint16_t user_data_len;
+    uint8_t user_data[NSM_USER_DATA_MAX_SIZE];
+    uint16_t nonce_len;
+    uint8_t nonce[NSM_NONCE_MAX_SIZE];
+
+    bool (*extend_pcr)(VirtIONSM *vnsm, int ind, uint8_t *data, uint16_t len);
+    void (*lock_pcr)(VirtIONSM *vnsm, int ind);
+};
+
+#endif
-- 
2.39.2


