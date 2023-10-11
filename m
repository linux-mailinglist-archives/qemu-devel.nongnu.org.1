Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 455FD7C5848
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 17:41:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqbKN-0002rK-OA; Wed, 11 Oct 2023 11:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqbJq-0002RW-IG
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:40:23 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqbJe-0001wx-JF
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:40:18 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3af8b498d30so4105315b6e.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 08:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697038805; x=1697643605;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4JchmClXziD2vBgzcNf/LgEpJ92hmMKWZAZONhdY+WI=;
 b=v0aWUNR6m3dfdE6Zmn3b3MBpzZAx72lwIuPWCqgdHdi4uzpTkQ+ZQmkOdThagKrYyn
 WXtWai85VkD/oIECAndJ8oFBcMQX6AtdhygX36FiIS6TScFBao4MgX+WKHZ13XZfZTWy
 QabLEkvvjyHcwI4ZIocgDbTHWu+8YtohuYVg9/U2KZWD9R49aVVL8hp4EqvvyoCZFLHf
 yGdgsMKFVOMW24HL7Euu70DG7m2P1Zd0aG6wgpa6KMXdbcWKMrSyyFjITsRunWuWE15e
 6S1iHLuXjRmVxJS1DQ+LKqFfORALhYiu/D7u9s9wPIbjpdQw0qofVYI89GOoNohhle6/
 hAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697038805; x=1697643605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4JchmClXziD2vBgzcNf/LgEpJ92hmMKWZAZONhdY+WI=;
 b=IB+V98MeKHG580TTdepTQ7De1PFvIKQzV4++97biAASMwm1qbWw9l0Z7PxuVVs7xtJ
 FTxila9f17b96rzT2z6HVrV1D1cxjUpHz7l/6V1KaAqdl6+Nrgocttz42VSWF5emgsMw
 SX3QTa+OHcnCo5Xey2zy1SfrKQZtN8FvZ7qPJgAhRni+yt4QoN4SlHlUJfHpD4Fq7EzK
 Pezt85Ugk9iPez3RNMqBDvrPqCRgg9yiR41aePbxTkNsbwupv6x6Ml/ZkHizlJebYpj/
 vBqXpX3RnhUAG+Ev3HAw912YWlSJwNlTzx7AMlaljDocELUtxfa3xKz7CZXIQYQJcESO
 qAlg==
X-Gm-Message-State: AOJu0YxvJ6ysfGktw9Fo8MS1GJBX0v8aG3c+jEwuOdQRKR512r9hyv/r
 IwrQf51Mr9qQtNfD4BhXZbtsOVX26mtbIPtDmPSSHw==
X-Google-Smtp-Source: AGHT+IFX73HA0SJ+h0kbvxBPddRBEvTN86PYEwykVdtGbczJTNkdv8FXUadzO3xo9NmBtE5ZSTDvuA==
X-Received: by 2002:a05:6358:988d:b0:14c:704b:d19f with SMTP id
 q13-20020a056358988d00b0014c704bd19fmr16731836rwa.3.1697038805424; 
 Wed, 11 Oct 2023 08:40:05 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 z9-20020aa785c9000000b006926e3dc2besm10301011pfn.108.2023.10.11.08.40.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 08:40:05 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 03/11] net: Move virtio-net header length assertion
Date: Thu, 12 Oct 2023 00:39:34 +0900
Message-ID: <20231011153944.39572-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011153944.39572-1-akihiko.odaki@daynix.com>
References: <20231011153944.39572-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::22c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The virtio-net header length assertion should happen for any clients.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 net/net.c | 5 +++++
 net/tap.c | 3 ---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/net.c b/net/net.c
index 1bb4f33a63..6d2fa8d40f 100644
--- a/net/net.c
+++ b/net/net.c
@@ -56,6 +56,7 @@
 #include "net/filter.h"
 #include "qapi/string-output-visitor.h"
 #include "qapi/qobject-input-visitor.h"
+#include "standard-headers/linux/virtio_net.h"
 
 /* Net bridge is currently not supported for W32. */
 #if !defined(_WIN32)
@@ -540,6 +541,10 @@ void qemu_set_vnet_hdr_len(NetClientState *nc, int len)
         return;
     }
 
+    assert(len == sizeof(struct virtio_net_hdr_mrg_rxbuf) ||
+           len == sizeof(struct virtio_net_hdr) ||
+           len == sizeof(struct virtio_net_hdr_v1_hash));
+
     nc->vnet_hdr_len = len;
     nc->info->set_vnet_hdr_len(nc, len);
 }
diff --git a/net/tap.c b/net/tap.c
index 4667933ffe..57389cacc3 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -263,9 +263,6 @@ static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
 
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
-    assert(len == sizeof(struct virtio_net_hdr_mrg_rxbuf) ||
-           len == sizeof(struct virtio_net_hdr) ||
-           len == sizeof(struct virtio_net_hdr_v1_hash));
 
     tap_fd_set_vnet_hdr_len(s->fd, len);
     s->host_vnet_hdr_len = len;
-- 
2.42.0


