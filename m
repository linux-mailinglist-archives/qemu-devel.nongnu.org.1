Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B6D7DB2A6
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 06:15:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxKbZ-000211-M7; Mon, 30 Oct 2023 01:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKbX-00020Y-7Y
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:14:23 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKbV-0001iU-PP
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:14:22 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-28002031f06so2427384a91.1
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 22:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698642859; x=1699247659;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cS5c2lrYvG8x9/TYuZkQW3vHO1KmmqfjmOrAWORNJgc=;
 b=ZIU27ahQm/On0+xQzaykT/UWH8jIZ0R/vGMlzHx/MH9wA6Ng6SBp/Ephr6GMqmbo7n
 Ac7Z3IFQ/XvnKCEttiH1gl5Amvvs7yJLD/jgRoW7JkIYjZHS5m9k+zKZuxFOxvfLy/US
 +LRTJrPyLI4ZGpBQ/2eUL1ToR8i0E1442ZTMlfx6DhIF78f2kTr/KVTSx3PL3dnPfRIt
 j9IZBwa8lcGXd3A5CHPPRsBu6r+zrBl/TR8Qb48gCFNwDXtYQUGe0PBoTIhxB4V8lDnd
 6fnGfTLgrHHmvlb9HUhM+BgfCdZr4Xt1eepK8DZJPmQQNU7dwT5VfoPBdZaXmfMZRTLD
 GIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698642859; x=1699247659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cS5c2lrYvG8x9/TYuZkQW3vHO1KmmqfjmOrAWORNJgc=;
 b=raQUC13ZGYupCjb+MI0DHGLSF4LWxFkCB/2+2wmbtmlvGuNBFXdZh8Jy3zT/JhKllG
 rZS+PqDcS1mz+SP5+TZksbjGhlKwEumfpB0JNrYBx4Da0Ou65wWLBT5tD9aMw8wjPkz2
 lHkiFBHcIXy7FJqJ2Q8tQkYRTOXBQqIuzUsvo3KHZjXhj4xl4im/MjbGk84AZAtaVUQj
 nEcH/DxvhcuFvBBO3TVx2bFbVKO1LVSQ3EvIvKnJPzNRkibVFF4XSMPvNMR1StXR+6Lb
 I0T06mdGwmGHWvcSQHggVnqlQsVkLPLF4T8LYsTJR+nJCADsGH0KyMFTI1sj/IK/xt5n
 SXzw==
X-Gm-Message-State: AOJu0Ywm9YQ6U0+ZQqUFIX66y7Vig5EEmIYT8EIUkPyIrGp0vq0yprkk
 0N9R7algH3A75qlz0W6kkjjRUj9Tg7XDtV79VaSqpA==
X-Google-Smtp-Source: AGHT+IHGYuUdcJecXJ2tTOsYR7uzsrUVi5GbKFd+B+ZRFHyfqVeg5rsjxWDBITS7pMIRSmzEM6Uvmg==
X-Received: by 2002:a17:90a:8584:b0:27c:f1f8:2628 with SMTP id
 m4-20020a17090a858400b0027cf1f82628mr6408328pjn.47.1698642859462; 
 Sun, 29 Oct 2023 22:14:19 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 34-20020a17090a09a500b002804af3afb7sm1717737pjo.49.2023.10.29.22.14.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 22:14:19 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v6 03/21] net: Move virtio-net header length assertion
Date: Mon, 30 Oct 2023 14:12:24 +0900
Message-ID: <20231030051356.33123-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231030051356.33123-1-akihiko.odaki@daynix.com>
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102e.google.com
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
index fda9a8f994..717d48ce15 100644
--- a/net/net.c
+++ b/net/net.c
@@ -56,6 +56,7 @@
 #include "net/filter.h"
 #include "qapi/string-output-visitor.h"
 #include "qapi/qobject-input-visitor.h"
+#include "standard-headers/linux/virtio_net.h"
 
 /* Net bridge is currently not supported for W32. */
 #if !defined(_WIN32)
@@ -549,6 +550,10 @@ void qemu_set_vnet_hdr_len(NetClientState *nc, int len)
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
index 0e031ee9fa..d94731b2fa 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -274,9 +274,6 @@ static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
 
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
-    assert(len == sizeof(struct virtio_net_hdr_mrg_rxbuf) ||
-           len == sizeof(struct virtio_net_hdr) ||
-           len == sizeof(struct virtio_net_hdr_v1_hash));
 
     tap_fd_set_vnet_hdr_len(s->fd, len);
     s->host_vnet_hdr_len = len;
-- 
2.42.0


