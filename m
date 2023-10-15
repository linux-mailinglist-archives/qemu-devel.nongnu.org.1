Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A1A7C9951
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 16:05:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs1iG-0001Km-9u; Sun, 15 Oct 2023 10:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1iD-0001KA-Ov
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:03:21 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1i9-0007hv-29
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:03:21 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c9bca1d96cso23745835ad.3
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 07:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697378596; x=1697983396;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4JchmClXziD2vBgzcNf/LgEpJ92hmMKWZAZONhdY+WI=;
 b=tNwluDxHDgbmDaA1Hh4s0djDbGuJhpMfD66PiPE689gMUxLvwphNrF/+sfJdfszTMu
 XpqQ/rJ+ZomzuVK6GYXNQyZIWJQg1A9frU263+1nhzQVbwzGGeVR83KQayNLvnCBWYIt
 BA4zHQHn2mq1XJ8p9FKZVwYiKR3gG1YeaOCA4X8Ypwydd+cDzg84Cyk13NhOb0F5cKUr
 z4MqsZs4B35cbfbUf4bvgzNAkaes/fvtV9ObXWoCojwI4ZGZOT2QCeQ+u6F77c9ULq80
 G/NQZqwP9Dkb88c9ZG81UNyEdZrldUnJQNWt09QDDYnqg9FBGgkVNBovV/SkH/2gdwU6
 NmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697378596; x=1697983396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4JchmClXziD2vBgzcNf/LgEpJ92hmMKWZAZONhdY+WI=;
 b=obCpuLmV4n95IlU6Uc/EXxiVHbsNWRyIkTxTgV48fUnkmDSx8nmjcT9J0xQ17VT1KA
 qrwrVbYrvMm+HYt79J3E8/OsVO7tmCYuWIxPXYns2PDtjfUIB1cmuo49UTJMthQEMCKJ
 tgMjVmzzWEN9WhYLSQe5rEN90Q2TMWScrrbFd8Iph1KtxyKfmfgD+f6BQCoAr6hPNWCD
 pFaLtS+QFBdbbQ0F+sm9vVsf1igj0Znsbjp/PIY22XJUfGWWgW0qvblcjlUhguQthVXL
 4oRAo4F5N/PiSel41TGPKFxJJqXkaeKe/6tXJ5Gwza4h75B/4FmO154tVle/RsPAt304
 QzlQ==
X-Gm-Message-State: AOJu0YxKLLU1+BAWBEiN0fpJQKCGkJDWSejhM+EfV4bkuaH84hMv7Ja4
 X/nxtKCEGALrU7Q/wTV86pAcs8XcnypACcWMXXeodw==
X-Google-Smtp-Source: AGHT+IFEocnBjSgQ7Yfl2w84Cmlvym1cM0bu+t+keU9zsxwAXZ3gFNFaxceBZT0ATV6Z67V/PXHYJw==
X-Received: by 2002:a17:903:120f:b0:1bb:994c:bc43 with SMTP id
 l15-20020a170903120f00b001bb994cbc43mr31358301plh.18.1697378595685; 
 Sun, 15 Oct 2023 07:03:15 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 e1-20020a170902744100b001bbdd44bbb6sm6826542plt.136.2023.10.15.07.03.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 07:03:15 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 03/20] net: Move virtio-net header length assertion
Date: Sun, 15 Oct 2023 23:02:35 +0900
Message-ID: <20231015140259.259434-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015140259.259434-1-akihiko.odaki@daynix.com>
References: <20231015140259.259434-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
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


