Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B027EFEBF
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Nov 2023 10:29:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4Hau-0006CC-GT; Sat, 18 Nov 2023 04:26:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4Has-0006Bz-LM
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:26:26 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4Har-0003hd-6y
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:26:26 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cc1e1e74beso24991515ad.1
 for <qemu-devel@nongnu.org>; Sat, 18 Nov 2023 01:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700299584; x=1700904384;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rH3OESzwjQ69xioS7GrBiuwAFBXJAVIbXvkiJ7DPKqQ=;
 b=xc0obqq6qrAEwmTcEU4rg84CjCAMUPNXFtSCx4D1PzmDJI0QQbWVD3xcKFKiKcFgkc
 OICb7OOTujI098aH3bEoR8mTwUcJZALIqEshBnMD2QvNIsfPfECLVQlHWIw6Q8ePhTF8
 CO8xZEEHunRXE/DRqPmiXPtXt8+7cz0Ov79e8y75QCgZr4gA6F58asR+h9CfcMYPzCKB
 f0yJH9/y+SMHg32PxIZ8ViQINyXEcFdtIaQyu+ytK8gos8TIsQfNllNbvUljlNemp11o
 2BUDx3LUcmexVM33hCQzrspBwstVYsUTnN4mb+ZDLbsWrDSK/2TfSFTFL7mVmt3y9r6s
 H7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700299584; x=1700904384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rH3OESzwjQ69xioS7GrBiuwAFBXJAVIbXvkiJ7DPKqQ=;
 b=sRgzT9s6FjCq5f7KpzvbXVxNYHFtLX5X1GtsPFWTccwpmwM5LbvjtKPkFLixkjMkZI
 DrGNjS4EE6W9pGWYno30uKHtisSzqWo/wbvYLpFiavqp/vKxx+GoA6Dhp7sa8kibwaq6
 kzB8trZXhG/b7ebTLLi+dxpw/s0HtzldkLUDBhkrDvu86L7vxcFS2Jmfa0DUBrve+xaE
 DMkTh5UR++9HmLnNBptlXWy9P0PmHJDGUw7duKIUuWZeMQ80M5f1ibRnSQYZowa+GzFw
 fdyVVD8V7jGvTHQ08NTsSB3CCFirWUqffQU5gj2m8CDcuXBpgo6fiCf8FHKoMy2IdGtA
 VzYQ==
X-Gm-Message-State: AOJu0YyB5fSD/DYmebux7fV08MvmYDblMwInCxxZRGS8RMVPfASypn5c
 TSEukn08UB93+VPD2J34JIqmrdXpxnAPROGtID0=
X-Google-Smtp-Source: AGHT+IEsKcWhDILTRW3Q7Gm+luK4/uxTatmXZxb79eJB6f717fUOhlFH2PgSuB704CU/it9Zv8nnGQ==
X-Received: by 2002:a17:902:8bc2:b0:1cc:c9b4:6efe with SMTP id
 r2-20020a1709028bc200b001ccc9b46efemr2302041plo.21.1700299583894; 
 Sat, 18 Nov 2023 01:26:23 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 j3-20020a170902758300b001cc0d1af177sm2622809pll.229.2023.11.18.01.26.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Nov 2023 01:26:23 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Zhang, Chen" <chen.zhang@intel.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH RESEND v7 03/19] net: Move virtio-net header length assertion
Date: Sat, 18 Nov 2023 18:25:43 +0900
Message-ID: <20231118092601.7132-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231118092601.7132-1-akihiko.odaki@daynix.com>
References: <20231118092601.7132-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index f603030dd6..2e7c3fcc2a 100644
--- a/net/net.c
+++ b/net/net.c
@@ -56,6 +56,7 @@
 #include "net/filter.h"
 #include "qapi/string-output-visitor.h"
 #include "qapi/qobject-input-visitor.h"
+#include "standard-headers/linux/virtio_net.h"
 
 /* Net bridge is currently not supported for W32. */
 #if !defined(_WIN32)
@@ -545,6 +546,10 @@ void qemu_set_vnet_hdr_len(NetClientState *nc, int len)
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
index ea2dadc943..f2021b699c 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -267,9 +267,6 @@ static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
 
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
-    assert(len == sizeof(struct virtio_net_hdr_mrg_rxbuf) ||
-           len == sizeof(struct virtio_net_hdr) ||
-           len == sizeof(struct virtio_net_hdr_v1_hash));
 
     tap_fd_set_vnet_hdr_len(s->fd, len);
     s->host_vnet_hdr_len = len;
-- 
2.42.1


