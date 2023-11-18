Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 409D67EFEA8
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Nov 2023 10:20:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4HTv-0002UQ-9q; Sat, 18 Nov 2023 04:19:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4HTt-0002UG-Oj
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:19:13 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4HTs-00056B-8o
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:19:13 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5c21e185df5so405282a12.1
 for <qemu-devel@nongnu.org>; Sat, 18 Nov 2023 01:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700299151; x=1700903951;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rH3OESzwjQ69xioS7GrBiuwAFBXJAVIbXvkiJ7DPKqQ=;
 b=vRl8wpM6LNC39A1qJQg3z1JAOhuPJOhY//Qg8AVEow2QfrR0P640QUdwxHotLwb7H4
 IaXHryrYid8fGZMFzw5iG4W2VhsdFcQgdTZA6uiqCmn3zMRBMkoUE9Z2U4zn+GjuprW4
 YArWKgFtMhU1wdsiCtTLQz+LTEYfiIfPBujRo3MtmgQ+IEqWnm/6n8AtFLwtH0KanGxh
 1ZmnMQ0115ROj43HgyWoFdbvG/Prhw2eLBsjR9jsChfKeVQDu2K+Wo6OUHT5zBwcBo9U
 XHLGirZvIOaXjV2mUn0axQzlWXCKG9yIqSZaMqCgDO83QKdOw7Z9Yk2vUJD/JSWIyT1Y
 FsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700299151; x=1700903951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rH3OESzwjQ69xioS7GrBiuwAFBXJAVIbXvkiJ7DPKqQ=;
 b=sBOTTirwWK2m62kDLCKLAbqRDF13gWomXy49IHZuSTx5FNu+a4ZZu6kj97zt10t+0Q
 21ThDO951ahKacPeWpPRT9KKGkZh+ENEZyoReZZSyoVVnr2nJCgKBB/BSfXsfAhA1et6
 AxL10/e3GxXmLDR+mLLVV5d3gF0Dqdvlo1uav572FviSyZXfq4/BTPUw+jHL9CKRyK55
 ITQlgUP/r9Akn7fg7nKeDqpX6saAZaMfjNERUU4vuTEOutqihonnUMNN2dOMPaYpuFQU
 3/48hStQ2mX8JMqYP9EdbAKkxtkJ8yIQcqdY5M6zNiYN+mgqzOdEQoYYc66Yq/fwGJVB
 E7ww==
X-Gm-Message-State: AOJu0YyiqXznLIsrPrnbk1ZDiqc0xil7/jcmrLMCrvz93Doc2vFncWxd
 8Nr3a8NMXeoibHapgO40X+PDLU/uelHIz7GZw5U=
X-Google-Smtp-Source: AGHT+IE1Nl3zgmoCdvFSwQPu8llszF9ksnX/DqNnMSCi7jM2sog+VVWMY55Mh9Pd4+lcfGXsAwc+0A==
X-Received: by 2002:a05:6a20:1584:b0:188:290f:3da6 with SMTP id
 h4-20020a056a20158400b00188290f3da6mr2082026pzj.41.1700299150987; 
 Sat, 18 Nov 2023 01:19:10 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 fn21-20020a056a002fd500b006c34a04c782sm2664146pfb.61.2023.11.18.01.19.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Nov 2023 01:19:10 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Zhang, Chen" <chen.zhang@intel.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v7 03/19] net: Move virtio-net header length assertion
Date: Sat, 18 Nov 2023 18:18:17 +0900
Message-ID: <20231118091837.5758-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231118091837.5758-1-akihiko.odaki@daynix.com>
References: <20231118091837.5758-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::530;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x530.google.com
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


