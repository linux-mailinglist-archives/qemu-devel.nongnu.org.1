Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 702DC7B9A61
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:48:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFHs-0005M0-Kz; Wed, 04 Oct 2023 23:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFHa-0004rG-Iv
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:44:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFHV-0000DS-Nb
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e6RIGJDZm9vqgaVvilT/iqK5gBS9e4D2YBhuylyTSNo=;
 b=Is+EOulXnMOyqRInXR8eUsgGABFfVf0+C19UFidgDXyyeeK5N6s6iiTLWjXibSfjNd2PY1
 IVZuB9G6SGl3iqV1B1xdaLGYvA3YryzHhSSeoM9sTx8l44BcnjqXbEJO+EL36ZYyvyvzdm
 QldsD5oFiW9gmg3lVXpsBJ/eGFdji1Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-szO76y9fNDmL3hUDaV4Srw-1; Wed, 04 Oct 2023 23:44:01 -0400
X-MC-Unique: szO76y9fNDmL3hUDaV4Srw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4059475c174so4085665e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477440; x=1697082240;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e6RIGJDZm9vqgaVvilT/iqK5gBS9e4D2YBhuylyTSNo=;
 b=LBN81VN6CDJheGwM/3tk+UOfGzu7Z/cY8eHQrmNyU/yoehVO0W6IcOK8gQ34fRh0eK
 TLDSOI+zMGmPbF7BdMmYUJD+T2jwXIueTehLqNUUB7DekWbfZy3cbL6F9cpIw3WEVh9W
 2YP4fWASelGS+UJdkdyzAwbpfp4hK7m27sSS1HCRtSN+Rma5SpqAq7iDi93z3Pl5Q3h9
 lmu/oMoKWCnh6dqxZpqZwFYBS/V5yW3ifW3GI32ATKC/z9wR33Eymv7SGRG8pasNspSa
 rH84Hjg3dCKEq2R+tDu4sx+zRegU/he/OZpA4+saQm2+bNZxDnrFeFYCBSd6mSSVIS8j
 Eigw==
X-Gm-Message-State: AOJu0YwlzOkvKAFmCUR9D1R+jBihkc70hGfVvB23MccA2QO9aXqPwxtt
 pc15ZeclVql91Ej/AhabH5tDDdDRhZuSxYmZeUwmM2fAypIjkWnq5Rn8rNIHMDkz459ORETWOXw
 SX/iTGYxQNRNlZZquFjldMUKtJ1XRMPA1qKUq4lPf9COgeCQUOUmpZFELZbikRe4Io6/R
X-Received: by 2002:a7b:c5ca:0:b0:406:7021:7d8 with SMTP id
 n10-20020a7bc5ca000000b00406702107d8mr4205032wmk.20.1696477439938; 
 Wed, 04 Oct 2023 20:43:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCOynrgc4dy2uJwSL4wI6VNAK3YfoQwE5LhjNL631Fjn8W0Qa7LXZCxqY0a32xxIyk4Zqqqw==
X-Received: by 2002:a7b:c5ca:0:b0:406:7021:7d8 with SMTP id
 n10-20020a7bc5ca000000b00406702107d8mr4205017wmk.20.1696477439657; 
 Wed, 04 Oct 2023 20:43:59 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 hn8-20020a05600ca38800b00405959bbf4fsm543902wmb.19.2023.10.04.20.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:43:59 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:43:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL v2 23/53] vhost-user: move VhostUserProtocolFeature definition
 to header file
Message-ID: <3d123a8b411706423581db7d26a7bbe548360751.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
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


