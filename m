Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D557CB990
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 06:11:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsbOz-0007P9-NA; Tue, 17 Oct 2023 00:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbOw-0007ON-U8
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:09:50 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbOv-00047O-CG
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:09:50 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6bce254ba56so1690627b3a.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 21:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697515788; x=1698120588;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4JchmClXziD2vBgzcNf/LgEpJ92hmMKWZAZONhdY+WI=;
 b=xyIQZ5yYaGAMI3zEcRhfDKgy0hDI4JGL2nlHhXONlZz1FgZm8p2fY2QlbHTuAGbNFe
 m77JHYenQz05/WfFHODzGiesIcxzF7IGwpqbpSR5Xuzv2WePwJ1qVkzlnilAXCpX0Nfo
 X4V9bfQPMRiOGaybMhC4Jt7vGLlTimhyoNTCl5LUCAJGxSmR3azVv5yFDyrHJB7Qs6p/
 joWXCnh6aHcocbkWLQAnZvvrh6kB9GmNzcemwgmZMXq6SVzT78UNNsaBB+cavjbrftbx
 Dmdc1rgdgJPPHvCNZRzNEHGJS4JuS54jQJGZg1nwk1jZq/iNCR4Kv04G5iFBEctiMyRd
 oJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697515788; x=1698120588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4JchmClXziD2vBgzcNf/LgEpJ92hmMKWZAZONhdY+WI=;
 b=MQKZLSEMYx0prJzT9TvnlBge01AY40fjzYx3HQzURh7zvez5cuYkD+d3D0wexhbsUC
 vQgfdaLGuEo7/i7qc11oiby5UxFRGPyzLGjSrJIMrTbZqqPoQKI086ND8/9XXh8jSXCP
 Wu4xIPyuO1nhAewCsucEcEEXQnU3dq9qpXdBtdgJOGz9JxdGx0Jjll1b31RXjBPaCyT1
 Nl8khPkedfYh30VxiNCzTDBac2j/fmFFTgYpXaZ4utOhHQMWkLvMfDQm8rZBu7KbOqTA
 JtxtneIUcvNsnHW1icXTo1kk7TtTXVb+m7O0XVF3VDJkZdxgj0gI8ps/LZmSmrgirFbT
 pUlA==
X-Gm-Message-State: AOJu0YzMODUf5w7leG5B/wUfEXfPYKscgembQsR8LH4lzt7blbvmprMI
 ZA+VNh/D1n23OlzzfCHWHerHuRtycgKObdpc4Dtv6A==
X-Google-Smtp-Source: AGHT+IHeTpq9y5rVjwxlIlPBFrBYFysVxfREOmw1JwYLXFPBV6og2lkwXPz55N0baWuBYWN2+A/Otw==
X-Received: by 2002:a05:6a00:22c4:b0:6bb:b574:4f60 with SMTP id
 f4-20020a056a0022c400b006bbb5744f60mr1152777pfj.15.1697515787929; 
 Mon, 16 Oct 2023 21:09:47 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 z21-20020aa79f95000000b0069323619f69sm358989pfr.143.2023.10.16.21.09.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 21:09:47 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 03/21] net: Move virtio-net header length assertion
Date: Tue, 17 Oct 2023 13:09:09 +0900
Message-ID: <20231017040932.62997-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017040932.62997-1-akihiko.odaki@daynix.com>
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
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


