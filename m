Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F12B01CE5
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Jul 2025 15:06:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDQv-00015A-Dv; Fri, 11 Jul 2025 09:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uaDPD-0000PT-OF
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:03:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uaDPB-0003dh-16
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752238987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5yly3nninxANG8fY6SgAUY1NzkHCj4BYLVU/1/Wli1k=;
 b=M5qsNg7k217asILvEfZrv804WV0zd4wGRrwpFZwx2RxvpT3MgG2r5OGPgnBRCjB2zpFzF6
 kTjzC+TtzUHK1LooxbGA1o44m5LyhYvRRMTr2zMw+IiKunFhKmtflbXEez2E4+XZrGdrVS
 85eqxbDWztfjV9OkwzF7qrUXp7OeE3E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-bDRKrRr3Oni6HZBneah4dA-1; Fri,
 11 Jul 2025 09:03:03 -0400
X-MC-Unique: bDRKrRr3Oni6HZBneah4dA-1
X-Mimecast-MFC-AGG-ID: bDRKrRr3Oni6HZBneah4dA_1752238981
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DBDB19560A6; Fri, 11 Jul 2025 13:03:01 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.145])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 693BB19560B0; Fri, 11 Jul 2025 13:02:54 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Luigi Rizzo <lrizzo@google.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH RFC v2 03/13] virtio: introduce extended features type
Date: Fri, 11 Jul 2025 15:02:08 +0200
Message-ID: <8c179f9cd04d6cb5e6f822203c6a057704133386.1752229731.git.pabeni@redhat.com>
In-Reply-To: <cover.1752229731.git.pabeni@redhat.com>
References: <cover.1752229731.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The virtio specifications allows for up to 128 bits for the
device features. Soon we are going to use some of the 'extended'
bits features (above 64) for the virtio net driver.

Represent the virtio features bitmask with a fixes size array, and
introduce a few helpers to help manipulate them.

Most drivers will keep using only 64 bits features space: use union
to allow them access the lower part of the extended space without any
per driver change.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
  - use a fixed size array for features instead of uint128
  - use union with u64 to reduce the needed code churn
---
 include/hw/virtio/virtio-features.h | 124 ++++++++++++++++++++++++++++
 include/hw/virtio/virtio.h          |   7 +-
 2 files changed, 128 insertions(+), 3 deletions(-)
 create mode 100644 include/hw/virtio/virtio-features.h

diff --git a/include/hw/virtio/virtio-features.h b/include/hw/virtio/virtio-features.h
new file mode 100644
index 0000000000..cc735f7f81
--- /dev/null
+++ b/include/hw/virtio/virtio-features.h
@@ -0,0 +1,124 @@
+/*
+ * Virtio features helpers
+ *
+ * Copyright 2025 Red Hat, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef _QEMU_VIRTIO_FEATURES_H
+#define _QEMU_VIRTIO_FEATURES_H
+
+#define VIRTIO_FEATURES_FMT        "%016"PRIx64"%016"PRIx64
+#define VIRTIO_FEATURES_PR(f)      f[1], f[0]
+
+#define VIRTIO_FEATURES_MAX        128
+#define VIRTIO_BIT(b)              (1ULL << (b & 0x3f))
+#define VIRTIO_DWORD(b)            ((b) >> 6)
+#define VIRTIO_FEATURES_WORDS     (VIRTIO_FEATURES_MAX >> 5)
+#define VIRTIO_FEATURES_DWORDS      (VIRTIO_FEATURES_WORDS >> 1)
+
+#define VIRTIO_DECLARE_FEATURES(name)                        \
+    union {                                                  \
+        uint64_t name;                                       \
+        uint64_t name##_array[VIRTIO_FEATURES_DWORDS];       \
+    }
+
+static inline void virtio_features_clear(uint64_t *features)
+{
+    memset(features, 0, sizeof(features[0]) * VIRTIO_FEATURES_DWORDS);
+}
+
+static inline void virtio_features_from_u64(uint64_t *features, uint64_t from)
+{
+    virtio_features_clear(features);
+    features[0] = from;
+}
+
+static inline bool virtio_has_feature_ex(const uint64_t *features,
+                                         unsigned int fbit)
+{
+    assert(fbit < VIRTIO_FEATURES_MAX);
+    return features[VIRTIO_DWORD(fbit)] & VIRTIO_BIT(fbit);
+}
+
+static inline void virtio_add_feature_ex(uint64_t *features,
+                                         unsigned int fbit)
+{
+    assert(fbit < VIRTIO_FEATURES_MAX);
+    features[VIRTIO_DWORD(fbit)] |= VIRTIO_BIT(fbit);
+}
+
+static inline void virtio_clear_feature_ex(uint64_t *features,
+                                           unsigned int fbit)
+{
+    assert(fbit < VIRTIO_FEATURES_MAX);
+    features[VIRTIO_DWORD(fbit)] &= ~VIRTIO_BIT(fbit);
+}
+
+static inline bool virtio_features_equal(const uint64_t *f1,
+                                         const uint64_t *f2)
+{
+    uint64_t diff = 0;
+    int i;
+
+    for (i = 0; i < VIRTIO_FEATURES_DWORDS; ++i) {
+        diff |= f1[i] ^ f2[i];
+    }
+    return !!diff;
+}
+
+static inline bool virtio_features_use_extended(const uint64_t *features)
+{
+    int i;
+
+    for (i = 1; i < VIRTIO_FEATURES_DWORDS; ++i) {
+        if (features[i]) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static inline bool virtio_features_is_empty(const uint64_t *features)
+{
+    return !virtio_features_use_extended(features) && !features[0];
+}
+
+static inline void virtio_features_copy(uint64_t *to, const uint64_t *from)
+{
+    memcpy(to, from, sizeof(to[0]) * VIRTIO_FEATURES_DWORDS);
+}
+
+static inline void virtio_features_andnot(uint64_t *to, const uint64_t *f1,
+                                           const uint64_t *f2)
+{
+    int i;
+
+    for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++) {
+        to[i] = f1[i] & ~f2[i];
+    }
+}
+
+static inline void virtio_features_and(uint64_t *to, const uint64_t *f1,
+                                       const uint64_t *f2)
+{
+    int i;
+
+    for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++) {
+        to[i] = f1[i] & f2[i];
+    }
+}
+
+static inline void virtio_features_or(uint64_t *to, const uint64_t *f1,
+                                       const uint64_t *f2)
+{
+    int i;
+
+    for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++) {
+        to[i] = f1[i] | f2[i];
+    }
+}
+
+#endif
+
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 214d4a77e9..0d1eb20489 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -16,6 +16,7 @@
 
 #include "system/memory.h"
 #include "hw/qdev-core.h"
+#include "hw/virtio/virtio-features.h"
 #include "net/net.h"
 #include "migration/vmstate.h"
 #include "qemu/event_notifier.h"
@@ -121,9 +122,9 @@ struct VirtIODevice
      * backend (e.g. vhost) and could potentially be a subset of the
      * total feature set offered by QEMU.
      */
-    uint64_t host_features;
-    uint64_t guest_features;
-    uint64_t backend_features;
+    VIRTIO_DECLARE_FEATURES(host_features);
+    VIRTIO_DECLARE_FEATURES(guest_features);
+    VIRTIO_DECLARE_FEATURES(backend_features);
 
     size_t config_len;
     void *config;
-- 
2.50.0


