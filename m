Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A64B80B39
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Sep 2025 17:46:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyr2W-0006kY-0r; Wed, 17 Sep 2025 08:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uyr1y-0006US-6f
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 08:13:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uyr1v-0007O4-OK
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 08:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758111178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9Q4xWc8twV4ZfVPXPDlECfHdcMe02Sy676sJdmQqNpQ=;
 b=RQZMkdN/WaYiNT9DOX6K93asH0Lp4Zupnvxgb2BXNuXgDFlPUiEx0pq/hyBwXtpZavwgd0
 twjDE83dfV+T5gSCT59nh9eNyFKPTbUGMLx7+waudMEsVjR2u0LNzjUDnZ3RF3D0pL4I+Q
 gc2rQotnsVzsjHl9X6ocG0Nqk+Bk/Mo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-928lOK1ONBuIpan_qczfYw-1; Wed, 17 Sep 2025 08:12:57 -0400
X-MC-Unique: 928lOK1ONBuIpan_qczfYw-1
X-Mimecast-MFC-AGG-ID: 928lOK1ONBuIpan_qczfYw_1758111176
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45de27bf706so37455045e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 05:12:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758111176; x=1758715976;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Q4xWc8twV4ZfVPXPDlECfHdcMe02Sy676sJdmQqNpQ=;
 b=k7Maq5BwNZGfEWGw9lzCXhH0GVU9anIrkj+Ww1bBBkPEq1h/bA32hS7CK16hBJP3Tz
 EaZ1NWYqsjOFzeXF1Iv7h8DDHDYBjYoUJsdZVP/qmsJwCXlxjcFkkdtrFZ0+4PvJYL/U
 vBRJU6WA0Hjd7b8abaBcPlNjAzixJP7O8BQPlpamw3nBIMcq+eVEjyTbjPc5YxWSACeA
 u9LUltOQhzifMA1ll7L+UdNdTk34N66VL3Y+UNItTEKjvlLxJyXqtu3hiNjyzbQhdxzl
 RHoKQagGSOkyyHahjlk4aMqy56GcEONNTcPsGZEJlZZBQrHhteiPcOcRkiOp2Gwe4f9r
 jSmA==
X-Gm-Message-State: AOJu0YywGx0IIE5D7Rc/33DQS/6hW7j74H5k8ATmt40viY6NUm7RyBbP
 iBZ1LKxAMLI6MYJ1Ab3T4NIrvebKB0gvnXQKiEvYSzMdGbfTSb5vjuVrchvLhChNHWyhFzJ54vm
 Q5bQhYc/K/be12nK4h13+U9YXs7PbyeRNvgMu9wKGTRUvrZMwDA5Pkpw3
X-Gm-Gg: ASbGncsHMF/sh/p/9ZZOLQZ6EoZUSsxKdC6106YCdNT+h8jPcAdVQVas6zpZvEJJvey
 fX2bXP8kWQVMSdZkflfnRupGZ7t7rFtpd1TXdpUp7hdba0dBOtMy33mixIk6oyDqJU6syyHhLoy
 b6rXycL4ZujZboY92ANdB4aXNAZ/GWpdUC9++qeme356zqF/joMwamRj4dNu5dQVNjoExOymERO
 N1zqDJPwEe9DGW/g3aOcu1ZA0B4tllsdkCaLy/kILtAkHYXSZQ9UJIem4klkVeg70eeUgR2RA7N
 ih6y8qVHk+zt/8IQe4nkcMOUmVJ3e4/lo3HHLKSdbniw
X-Received: by 2002:a05:600c:1e88:b0:45b:868e:7f7f with SMTP id
 5b1f17b1804b1-46205adf6f4mr22216365e9.17.1758111176016; 
 Wed, 17 Sep 2025 05:12:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEN3WUHmylb4hvg5gxYuV/WfhPU47ps1hDbQBKDhwDeTOw/aFj7P+/BgqIRcuvmjinSZSdIyA==
X-Received: by 2002:a05:600c:1e88:b0:45b:868e:7f7f with SMTP id
 5b1f17b1804b1-46205adf6f4mr22215885e9.17.1758111175544; 
 Wed, 17 Sep 2025 05:12:55 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.183.148])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4613d14d564sm39022665e9.14.2025.09.17.05.12.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 05:12:54 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:12:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6 04/14] virtio: introduce extended features type
Message-ID: <z6ntpzp6ykey5hh65ia3kaka5j7anhxolcizgtq7lqbrokeb2h@r66hv2dtxjsv>
References: <cover.1757676218.git.pabeni@redhat.com>
 <8a041a8fac5b5ea175d3daebfd395c1916332695.1757676218.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8a041a8fac5b5ea175d3daebfd395c1916332695.1757676218.git.pabeni@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Sep 12, 2025 at 03:06:55PM +0200, Paolo Abeni wrote:
>The virtio specifications allows for up to 128 bits for the
>device features. Soon we are going to use some of the 'extended'
>bits features (bit 64 and above) for the virtio net driver.
>
>Represent the virtio features bitmask with a fixes size array, and
>introduce a few helpers to help manipulate them.
>
>Most drivers will keep using only 64 bits features space: use union
>to allow them access the lower part of the extended space without any
>per driver change.
>
>Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>Acked-by: Jason Wang <jasowang@redhat.com>
>Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>---
>v5 -> v6:
>  - removed trailing EoL
>
>v4 -> v5:
>  - DEFINE_PROP_FEATURE -> VIRTIO_DEFINE_PROP_FEATURE
>
>v3 -> v4:
>  - VIRTIO_FEATURES_DWORDS -> VIRTIO_FEATURES_NU64S
>  - VIRTIO_FEATURES_WORDS -> VIRTIO_FEATURES_NU32S
>  - VIRTIO_DWORD ->  VIRTIO_FEATURES_U64
>  - VIRTIO_BIT -> VIRTIO_FEATURES_BIT
>  - virtio_features_use_extended -> virtio_features_use_ex
>  - move DEFINE_PROP_FEATURE definition here
>
>v2 -> v3:
>  - fix preprocessor guard name
>  - use BIT_ULL
>  - add missing parentheses
>  - use memcmp()
>  - _is_empty() -> _empty()
>  - _andnot() returns a bool, true if dst has any non zero bits
>  - _array -> _ex
>
>v1 -> v2:
>  - use a fixed size array for features instead of uint128
>  - use union with u64 to reduce the needed code churn
>---
> include/hw/virtio/virtio-features.h | 126 ++++++++++++++++++++++++++++
> include/hw/virtio/virtio.h          |   7 +-
> 2 files changed, 130 insertions(+), 3 deletions(-)
> create mode 100644 include/hw/virtio/virtio-features.h

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/include/hw/virtio/virtio-features.h b/include/hw/virtio/virtio-features.h
>new file mode 100644
>index 0000000000..e29b7fe48f
>--- /dev/null
>+++ b/include/hw/virtio/virtio-features.h
>@@ -0,0 +1,126 @@
>+/*
>+ * Virtio features helpers
>+ *
>+ * Copyright 2025 Red Hat, Inc.
>+ *
>+ * SPDX-License-Identifier: GPL-2.0-or-later
>+ */
>+
>+#ifndef QEMU_VIRTIO_FEATURES_H
>+#define QEMU_VIRTIO_FEATURES_H
>+
>+#include "qemu/bitops.h"
>+
>+#define VIRTIO_FEATURES_FMT        "%016"PRIx64"%016"PRIx64
>+#define VIRTIO_FEATURES_PR(f)      (f)[1], (f)[0]
>+
>+#define VIRTIO_FEATURES_MAX        128
>+#define VIRTIO_FEATURES_BIT(b)     BIT_ULL((b) % 64)
>+#define VIRTIO_FEATURES_U64(b)     ((b) / 64)
>+#define VIRTIO_FEATURES_NU32S      (VIRTIO_FEATURES_MAX / 32)
>+#define VIRTIO_FEATURES_NU64S      (VIRTIO_FEATURES_MAX / 64)
>+
>+#define VIRTIO_DECLARE_FEATURES(name)                        \
>+    union {                                                  \
>+        uint64_t name;                                       \
>+        uint64_t name##_ex[VIRTIO_FEATURES_NU64S];           \
>+    }
>+
>+#define VIRTIO_DEFINE_PROP_FEATURE(_name, _state, _field, _bit, _defval)   \
>+    DEFINE_PROP_BIT64(_name, _state, _field[VIRTIO_FEATURES_U64(_bit)],    \
>+                      (_bit) % 64, _defval)
>+
>+static inline void virtio_features_clear(uint64_t *features)
>+{
>+    memset(features, 0, sizeof(features[0]) * VIRTIO_FEATURES_NU64S);
>+}
>+
>+static inline void virtio_features_from_u64(uint64_t *features, uint64_t from)
>+{
>+    virtio_features_clear(features);
>+    features[0] = from;
>+}
>+
>+static inline bool virtio_has_feature_ex(const uint64_t *features,
>+                                         unsigned int fbit)
>+{
>+    assert(fbit < VIRTIO_FEATURES_MAX);
>+    return features[VIRTIO_FEATURES_U64(fbit)] & VIRTIO_FEATURES_BIT(fbit);
>+}
>+
>+static inline void virtio_add_feature_ex(uint64_t *features,
>+                                         unsigned int fbit)
>+{
>+    assert(fbit < VIRTIO_FEATURES_MAX);
>+    features[VIRTIO_FEATURES_U64(fbit)] |= VIRTIO_FEATURES_BIT(fbit);
>+}
>+
>+static inline void virtio_clear_feature_ex(uint64_t *features,
>+                                           unsigned int fbit)
>+{
>+    assert(fbit < VIRTIO_FEATURES_MAX);
>+    features[VIRTIO_FEATURES_U64(fbit)] &= ~VIRTIO_FEATURES_BIT(fbit);
>+}
>+
>+static inline bool virtio_features_equal(const uint64_t *f1,
>+                                         const uint64_t *f2)
>+{
>+    return !memcmp(f1, f2, sizeof(uint64_t) * VIRTIO_FEATURES_NU64S);
>+}
>+
>+static inline bool virtio_features_use_ex(const uint64_t *features)
>+{
>+    int i;
>+
>+    for (i = 1; i < VIRTIO_FEATURES_NU64S; ++i) {
>+        if (features[i]) {
>+            return true;
>+        }
>+    }
>+    return false;
>+}
>+
>+static inline bool virtio_features_empty(const uint64_t *features)
>+{
>+    return !virtio_features_use_ex(features) && !features[0];
>+}
>+
>+static inline void virtio_features_copy(uint64_t *to, const uint64_t *from)
>+{
>+    memcpy(to, from, sizeof(to[0]) * VIRTIO_FEATURES_NU64S);
>+}
>+
>+static inline bool virtio_features_andnot(uint64_t *to, const uint64_t *f1,
>+                                           const uint64_t *f2)
>+{
>+    uint64_t diff = 0;
>+    int i;
>+
>+    for (i = 0; i < VIRTIO_FEATURES_NU64S; i++) {
>+        to[i] = f1[i] & ~f2[i];
>+        diff |= to[i];
>+    }
>+    return diff;
>+}
>+
>+static inline void virtio_features_and(uint64_t *to, const uint64_t *f1,
>+                                       const uint64_t *f2)
>+{
>+    int i;
>+
>+    for (i = 0; i < VIRTIO_FEATURES_NU64S; i++) {
>+        to[i] = f1[i] & f2[i];
>+    }
>+}
>+
>+static inline void virtio_features_or(uint64_t *to, const uint64_t *f1,
>+                                       const uint64_t *f2)
>+{
>+    int i;
>+
>+    for (i = 0; i < VIRTIO_FEATURES_NU64S; i++) {
>+        to[i] = f1[i] | f2[i];
>+    }
>+}
>+
>+#endif
>diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>index c594764f23..39e4059a66 100644
>--- a/include/hw/virtio/virtio.h
>+++ b/include/hw/virtio/virtio.h
>@@ -16,6 +16,7 @@
>
> #include "system/memory.h"
> #include "hw/qdev-core.h"
>+#include "hw/virtio/virtio-features.h"
> #include "net/net.h"
> #include "migration/vmstate.h"
> #include "qemu/event_notifier.h"
>@@ -121,9 +122,9 @@ struct VirtIODevice
>      * backend (e.g. vhost) and could potentially be a subset of the
>      * total feature set offered by QEMU.
>      */
>-    uint64_t host_features;
>-    uint64_t guest_features;
>-    uint64_t backend_features;
>+    VIRTIO_DECLARE_FEATURES(host_features);
>+    VIRTIO_DECLARE_FEATURES(guest_features);
>+    VIRTIO_DECLARE_FEATURES(backend_features);
>
>     size_t config_len;
>     void *config;
>-- 
>2.51.0
>


