Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23367B0FB00
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Jul 2025 21:37:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uefF0-0004Bf-59; Wed, 23 Jul 2025 15:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uefCa-0001of-Ly
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 15:32:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uefCX-0005q0-VL
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 15:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753299149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5pxF3HYd9SJ4EoC1jXlBJCJZwVE7d+gxY+zfy/hA/EE=;
 b=BWnROmuEL21ni3UYTzwQZk3QcWoOL+y25TnfLE9RAkrVZ/PVyrVaSjE9mJy+tKVsBIWM7Y
 5bftps1C4mLcYfly25Q1vcshwvskNTBOyHavX+QRteafrnD26pPr7zwS+WcOucK2VTGUhY
 2d8NcHOhI8Wh8B2pf/hkwBOEANSVKHE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-oKOXLZ26MTCb_vtSGX6NRQ-1; Wed,
 23 Jul 2025 15:32:27 -0400
X-MC-Unique: oKOXLZ26MTCb_vtSGX6NRQ-1
X-Mimecast-MFC-AGG-ID: oKOXLZ26MTCb_vtSGX6NRQ_1753299146
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E839319560AE; Wed, 23 Jul 2025 19:32:25 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.60])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EDBEC180045B; Wed, 23 Jul 2025 19:32:20 +0000 (UTC)
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
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH v4 04/14] virtio: introduce extended features type
Date: Wed, 23 Jul 2025 21:31:24 +0200
Message-ID: <5d72c214940943f2863977539e337cc9ec17c8ea.1753297661.git.pabeni@redhat.com>
In-Reply-To: <cover.1753297661.git.pabeni@redhat.com>
References: <cover.1753297661.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
bits features (bit 64 and above) for the virtio net driver.

Represent the virtio features bitmask with a fixes size array, and
introduce a few helpers to help manipulate them.

Most drivers will keep using only 64 bits features space: use union
to allow them access the lower part of the extended space without any
per driver change.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v3 -> v4:
  - VIRTIO_FEATURES_DWORDS -> VIRTIO_FEATURES_NU64S
  - VIRTIO_FEATURES_WORDS -> VIRTIO_FEATURES_NU32S
  - VIRTIO_DWORD ->  VIRTIO_FEATURES_U64
  - VIRTIO_BIT -> VIRTIO_FEATURES_BIT
  - virtio_features_use_extended -> virtio_features_use_ex
  - move DEFINE_PROP_FEATURE definition here

v2 -> v3:
  - fix preprocessor guard name
  - use BIT_ULL
  - add missing parentheses
  - use memcmp()
  - _is_empty() -> _empty()
  - _andnot() returns a bool, true if dst has any non zero bits
  - _array -> _ex

v1 -> v2:
  - use a fixed size array for features instead of uint128
  - use union with u64 to reduce the needed code churn
---
 include/hw/virtio/virtio-features.h | 127 ++++++++++++++++++++++++++++
 include/hw/virtio/virtio.h          |   7 +-
 2 files changed, 131 insertions(+), 3 deletions(-)
 create mode 100644 include/hw/virtio/virtio-features.h

diff --git a/include/hw/virtio/virtio-features.h b/include/hw/virtio/virtio-features.h
new file mode 100644
index 0000000000..7abdf8601a
--- /dev/null
+++ b/include/hw/virtio/virtio-features.h
@@ -0,0 +1,127 @@
+/*
+ * Virtio features helpers
+ *
+ * Copyright 2025 Red Hat, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_VIRTIO_FEATURES_H
+#define QEMU_VIRTIO_FEATURES_H
+
+#include "qemu/bitops.h"
+
+#define VIRTIO_FEATURES_FMT        "%016"PRIx64"%016"PRIx64
+#define VIRTIO_FEATURES_PR(f)      (f)[1], (f)[0]
+
+#define VIRTIO_FEATURES_MAX        128
+#define VIRTIO_FEATURES_BIT(b)     BIT_ULL((b) % 64)
+#define VIRTIO_FEATURES_U64(b)     ((b) / 64)
+#define VIRTIO_FEATURES_NU32S      (VIRTIO_FEATURES_MAX / 32)
+#define VIRTIO_FEATURES_NU64S      (VIRTIO_FEATURES_MAX / 64)
+
+#define VIRTIO_DECLARE_FEATURES(name)                        \
+    union {                                                  \
+        uint64_t name;                                       \
+        uint64_t name##_ex[VIRTIO_FEATURES_NU64S];         \
+    }
+
+#define DEFINE_PROP_FEATURE(_name, _state, _field, _bit, _defval)          \
+    DEFINE_PROP_BIT64(_name, _state, _field[VIRTIO_FEATURES_U64(_bit)],    \
+                      (_bit) % 64, _defval)
+
+static inline void virtio_features_clear(uint64_t *features)
+{
+    memset(features, 0, sizeof(features[0]) * VIRTIO_FEATURES_NU64S);
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
+    return features[VIRTIO_FEATURES_U64(fbit)] & VIRTIO_FEATURES_BIT(fbit);
+}
+
+static inline void virtio_add_feature_ex(uint64_t *features,
+                                         unsigned int fbit)
+{
+    assert(fbit < VIRTIO_FEATURES_MAX);
+    features[VIRTIO_FEATURES_U64(fbit)] |= VIRTIO_FEATURES_BIT(fbit);
+}
+
+static inline void virtio_clear_feature_ex(uint64_t *features,
+                                           unsigned int fbit)
+{
+    assert(fbit < VIRTIO_FEATURES_MAX);
+    features[VIRTIO_FEATURES_U64(fbit)] &= ~VIRTIO_FEATURES_BIT(fbit);
+}
+
+static inline bool virtio_features_equal(const uint64_t *f1,
+                                         const uint64_t *f2)
+{
+    return !memcmp(f1, f2, sizeof(uint64_t) * VIRTIO_FEATURES_NU64S);
+}
+
+static inline bool virtio_features_use_ex(const uint64_t *features)
+{
+    int i;
+
+    for (i = 1; i < VIRTIO_FEATURES_NU64S; ++i) {
+        if (features[i]) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static inline bool virtio_features_empty(const uint64_t *features)
+{
+    return !virtio_features_use_ex(features) && !features[0];
+}
+
+static inline void virtio_features_copy(uint64_t *to, const uint64_t *from)
+{
+    memcpy(to, from, sizeof(to[0]) * VIRTIO_FEATURES_NU64S);
+}
+
+static inline bool virtio_features_andnot(uint64_t *to, const uint64_t *f1,
+                                           const uint64_t *f2)
+{
+    uint64_t diff = 0;
+    int i;
+
+    for (i = 0; i < VIRTIO_FEATURES_NU64S; i++) {
+        to[i] = f1[i] & ~f2[i];
+        diff |= to[i];
+    }
+    return diff;
+}
+
+static inline void virtio_features_and(uint64_t *to, const uint64_t *f1,
+                                       const uint64_t *f2)
+{
+    int i;
+
+    for (i = 0; i < VIRTIO_FEATURES_NU64S; i++) {
+        to[i] = f1[i] & f2[i];
+    }
+}
+
+static inline void virtio_features_or(uint64_t *to, const uint64_t *f1,
+                                       const uint64_t *f2)
+{
+    int i;
+
+    for (i = 0; i < VIRTIO_FEATURES_NU64S; i++) {
+        to[i] = f1[i] | f2[i];
+    }
+}
+
+#endif
+
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index c594764f23..39e4059a66 100644
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


