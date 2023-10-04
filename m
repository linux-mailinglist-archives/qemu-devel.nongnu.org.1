Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2B67B7B1D
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:06:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxUx-0005TI-7v; Wed, 04 Oct 2023 04:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxUf-0004sj-Nc
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxUd-0001bo-N0
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e6RIGJDZm9vqgaVvilT/iqK5gBS9e4D2YBhuylyTSNo=;
 b=ec6Tgz/N+uufIbV1kNwiemDHd1yG+wU3sNFDHz/KHGGo+sbd7LQLwAGbqcKq39+yuf/ikW
 8wqX/3PvlFA99X62PnWioOnH6yuGli2V5R965qJFY07Z57hlA9Sa9AIdD5jQjt4yyuEGxz
 q9X5a6G8d1bn22IRUSIs1pKlO7LP2/I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-bd4UW5NcP_OA-Uhcoh6-vQ-1; Wed, 04 Oct 2023 04:44:24 -0400
X-MC-Unique: bd4UW5NcP_OA-Uhcoh6-vQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fef5403093so3256475e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409062; x=1697013862;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e6RIGJDZm9vqgaVvilT/iqK5gBS9e4D2YBhuylyTSNo=;
 b=wezcqmgRk8/ajFk+OsAv5u8O8f3FR3QPGd4rDiEn7h6e6cjVtgZOIPMA6nlrUBw7f9
 FUN0wmdozCf2K9iJLtYPH3NTvnu1IWrJqj/GJyCuy3CXnwoaJieOMZavXOBTnAka1HgP
 IJEEJP7YNH5uLj672RXZp+90AaEn2uS7z4dDTQlNtkgaXVDIBaN4oOrPET+Y1MwSpGDy
 E/7SFcU57BDSJn6rwvwnIqx4TN298083LXWdbsYES22w19YbEHg7ZCoTuGKCYaqvC7vP
 E3lJhKD4V7QyVbem7mm4vjl4F79dxmjyDDe9/WbCEvdNbiGYr9W0+CIQbe2BR7sJ5PLE
 3VKQ==
X-Gm-Message-State: AOJu0YyZC3EJKCCm6lnuDhKcSCZl6pI7ovg7lo/urWL1aGZqk1r82qfe
 kEwkYA1lYxFIUCa4qrEny5z6wgAj3mIJQ7x/bO5uGighAMUb+Zega9lmms8chFIgVPqycmi1w8c
 uHKeOWx6Pf5J+ynM39euJckDc9K1p0upFgEVTKRMjQy4lug9shrYK2FdU9AjXD4oPAA7Z
X-Received: by 2002:a05:600c:228c:b0:400:140c:6083 with SMTP id
 12-20020a05600c228c00b00400140c6083mr4037191wmf.2.1696409062687; 
 Wed, 04 Oct 2023 01:44:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGq0rCCZaOaJu5CSqx5z2v6YZb7TcpEprt/fZ7xVkEADpA8Aj1Li/LBC6STYdBgvZJR530A0w==
X-Received: by 2002:a05:600c:228c:b0:400:140c:6083 with SMTP id
 12-20020a05600c228c00b00400140c6083mr4037176wmf.2.1696409062370; 
 Wed, 04 Oct 2023 01:44:22 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 6-20020a05600c22c600b0040303a9965asm934756wmg.40.2023.10.04.01.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:44:21 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:44:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PULL 23/63] vhost-user: move VhostUserProtocolFeature definition to
 header file
Message-ID: <af658f95421ffb1ee49581c88e8008a2c810741e.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jonah Palmer <jonah.palmer@oracle.com>

Move the definition of VhostUserProtocolFeature to
include/hw/virtio/vhost-user.h.

Remove previous definitions in hw/scsi/vhost-user-scsi.c,
hw/virtio/vhost-user.c, and hw/virtio/virtio-qmp.c.

Previously there were 3 separate definitions of this over 3 different
files. Now only 1 definition of this will be present for these 3 files.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20230926224107.2951144-4-jonah.palmer@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-user.h | 21 +++++++++++++++++++++
 hw/scsi/vhost-user-scsi.c      |  4 ----
 hw/virtio/vhost-user.c         | 21 ---------------------
 hw/virtio/virtio-qmp.c         | 22 +---------------------
 4 files changed, 22 insertions(+), 46 deletions(-)

diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 191216a74f..80e2b4a463 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -11,6 +11,27 @@
 #include "chardev/char-fe.h"
 #include "hw/virtio/virtio.h"
 
+enum VhostUserProtocolFeature {
+    VHOST_USER_PROTOCOL_F_MQ = 0,
+    VHOST_USER_PROTOCOL_F_LOG_SHMFD = 1,
+    VHOST_USER_PROTOCOL_F_RARP = 2,
+    VHOST_USER_PROTOCOL_F_REPLY_ACK = 3,
+    VHOST_USER_PROTOCOL_F_NET_MTU = 4,
+    VHOST_USER_PROTOCOL_F_BACKEND_REQ = 5,
+    VHOST_USER_PROTOCOL_F_CROSS_ENDIAN = 6,
+    VHOST_USER_PROTOCOL_F_CRYPTO_SESSION = 7,
+    VHOST_USER_PROTOCOL_F_PAGEFAULT = 8,
+    VHOST_USER_PROTOCOL_F_CONFIG = 9,
+    VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD = 10,
+    VHOST_USER_PROTOCOL_F_HOST_NOTIFIER = 11,
+    VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD = 12,
+    VHOST_USER_PROTOCOL_F_RESET_DEVICE = 13,
+    VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 14,
+    VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
+    VHOST_USER_PROTOCOL_F_STATUS = 16,
+    VHOST_USER_PROTOCOL_F_MAX
+};
+
 /**
  * VhostUserHostNotifier - notifier information for one queue
  * @rcu: rcu_head for cleanup
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index ee99b19e7a..df6b66cc1a 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -39,10 +39,6 @@ static const int user_feature_bits[] = {
     VHOST_INVALID_FEATURE_BIT
 };
 
-enum VhostUserProtocolFeature {
-    VHOST_USER_PROTOCOL_F_RESET_DEVICE = 13,
-};
-
 static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VHostUserSCSI *s = (VHostUserSCSI *)vdev;
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 8dcf049d42..a096335921 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -56,27 +56,6 @@
  */
 #define VHOST_USER_MAX_CONFIG_SIZE 256
 
-enum VhostUserProtocolFeature {
-    VHOST_USER_PROTOCOL_F_MQ = 0,
-    VHOST_USER_PROTOCOL_F_LOG_SHMFD = 1,
-    VHOST_USER_PROTOCOL_F_RARP = 2,
-    VHOST_USER_PROTOCOL_F_REPLY_ACK = 3,
-    VHOST_USER_PROTOCOL_F_NET_MTU = 4,
-    VHOST_USER_PROTOCOL_F_BACKEND_REQ = 5,
-    VHOST_USER_PROTOCOL_F_CROSS_ENDIAN = 6,
-    VHOST_USER_PROTOCOL_F_CRYPTO_SESSION = 7,
-    VHOST_USER_PROTOCOL_F_PAGEFAULT = 8,
-    VHOST_USER_PROTOCOL_F_CONFIG = 9,
-    VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD = 10,
-    VHOST_USER_PROTOCOL_F_HOST_NOTIFIER = 11,
-    VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD = 12,
-    VHOST_USER_PROTOCOL_F_RESET_DEVICE = 13,
-    /* Feature 14 reserved for VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS. */
-    VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
-    VHOST_USER_PROTOCOL_F_STATUS = 16,
-    VHOST_USER_PROTOCOL_F_MAX
-};
-
 #define VHOST_USER_PROTOCOL_FEATURE_MASK ((1 << VHOST_USER_PROTOCOL_F_MAX) - 1)
 
 typedef enum VhostUserRequest {
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 3431711db5..1dd96ed20f 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -17,6 +17,7 @@
 #include "qapi/qapi-commands-qom.h"
 #include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qjson.h"
+#include "hw/virtio/vhost-user.h"
 
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/vhost_types.h"
@@ -37,27 +38,6 @@
 #define FEATURE_ENTRY(name, desc) (qmp_virtio_feature_map_t) \
     { .virtio_bit = name, .feature_desc = desc }
 
-enum VhostUserProtocolFeature {
-    VHOST_USER_PROTOCOL_F_MQ = 0,
-    VHOST_USER_PROTOCOL_F_LOG_SHMFD = 1,
-    VHOST_USER_PROTOCOL_F_RARP = 2,
-    VHOST_USER_PROTOCOL_F_REPLY_ACK = 3,
-    VHOST_USER_PROTOCOL_F_NET_MTU = 4,
-    VHOST_USER_PROTOCOL_F_BACKEND_REQ = 5,
-    VHOST_USER_PROTOCOL_F_CROSS_ENDIAN = 6,
-    VHOST_USER_PROTOCOL_F_CRYPTO_SESSION = 7,
-    VHOST_USER_PROTOCOL_F_PAGEFAULT = 8,
-    VHOST_USER_PROTOCOL_F_CONFIG = 9,
-    VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD = 10,
-    VHOST_USER_PROTOCOL_F_HOST_NOTIFIER = 11,
-    VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD = 12,
-    VHOST_USER_PROTOCOL_F_RESET_DEVICE = 13,
-    VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 14,
-    VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
-    VHOST_USER_PROTOCOL_F_STATUS = 16,
-    VHOST_USER_PROTOCOL_F_MAX
-};
-
 /* Virtio transport features mapping */
 static const qmp_virtio_feature_map_t virtio_transport_map[] = {
     /* Virtio device transport features */
-- 
MST


