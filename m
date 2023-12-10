Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEDE80B908
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 06:32:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCCOg-00020X-4G; Sun, 10 Dec 2023 00:30:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCOS-0001za-Ot
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:30:23 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCOR-0002z9-8L
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:30:20 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d0538d9bbcso31300485ad.3
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 21:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702186218; x=1702791018;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KX65shTch/jteimEZK1e35z3QLoxDKxh0Rc0DoJAhZ8=;
 b=ELXYTEAYYsAWcqfJRp5pN8aDAZxifPz/JKWPzHptSIopMyd5b5tPKKgO2uZIJMuqrw
 wNNNrYykCtAGXjpgUp9Yq86Ps2RAkJpKJxNyJ+JcdVpXFSLfBvuNlxCoB/hWQaIBUOVC
 cTaWEHQ5zPDpLGybgDyRqKesSdfryYt3LWep0KbDSAsUtNlVCJ3FBi8f6fzfq5gj/DTK
 3LSMtanXgs08k5KuuZhqntGXJdP47b40BPnR8lrj3+jI1WNADpVyY3d5TNTsYfHdyaXL
 7r8iMMSxBPv7Zqmz5gkMIffb84FQTkIM4NyNoGgLhU4cAo0XzEETRW5Y8ooU7Q9Vm8Q8
 TVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702186218; x=1702791018;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KX65shTch/jteimEZK1e35z3QLoxDKxh0Rc0DoJAhZ8=;
 b=k8u1jkv/CT4+GW4dxOb0vF0QP2XfYtaoLqx/Vi36U1Bur611dM0/N5gk7uwRfntFH1
 mXgFsSNsQ6xUn2C0nf3LmIOt3RhYP3IGfFqq/PSWMN1bsIU+gEZzuEhfpEAZuEp756Jl
 fb+AybMyFdTvBAQOw66AQZa4YD3SIKrR6ZNDGYnBfWW6AN3PdlNk003ETwkR+1+KEuLf
 vWca/J7AdRY+EliPYByR1o4Vl+SzMRHy6uEQSjjCZ+nn1ShwAxe4fU49dkFbksWZJXkI
 X+0ntWKSGup6efvIfIZLafwLwMZzChnyiNDCNYZOTyWgpOmg/fH6ulgC4EKTydrEPiy8
 u7Xg==
X-Gm-Message-State: AOJu0Ywxlp/afoCgb4DWcwWnWbnsfIprOEzfNq/BH/OG03LuXmiLOUrW
 9WAMdqaQ9ppXiHsqSRIn9aXhNg==
X-Google-Smtp-Source: AGHT+IGGZSB6VB0rXbzD79MwqNHEP8JOJoMa0YMXnKDbtyYXwZwKb6xVB3bXST4MG8sGrM7IM/ekoQ==
X-Received: by 2002:a17:903:245:b0:1cf:d650:380a with SMTP id
 j5-20020a170903024500b001cfd650380amr2820779plh.13.1702186217903; 
 Sat, 09 Dec 2023 21:30:17 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 12-20020a170902ee4c00b001d0c134dc2dsm4227830plo.77.2023.12.09.21.30.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 21:30:17 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 10 Dec 2023 14:29:42 +0900
Subject: [PATCH v8 04/19] net: Remove receive_raw()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231210-rss-v8-4-9553ee714d38@daynix.com>
References: <20231210-rss-v8-0-9553ee714d38@daynix.com>
In-Reply-To: <20231210-rss-v8-0-9553ee714d38@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
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

While netmap implements virtio-net header, it does not implement
receive_raw(). Instead of implementing receive_raw for netmap, add
virtio-net headers in the common code and use receive_iov()/receive()
instead. This also fixes the buffer size for the virtio-net header.

Fixes: fbbdbddec0 ("tap: allow extended virtio header with hash info")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/net/net.h |  1 -
 net/net.c         | 18 ++++++++++++------
 net/tap.c         |  1 -
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index 374a827190..899ed63047 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -72,7 +72,6 @@ typedef struct NetClientInfo {
     NetClientDriver type;
     size_t size;
     NetReceive *receive;
-    NetReceive *receive_raw;
     NetReceiveIOV *receive_iov;
     NetCanReceive *can_receive;
     NetStart *start;
diff --git a/net/net.c b/net/net.c
index 2e70c4f221..3aa0fc393d 100644
--- a/net/net.c
+++ b/net/net.c
@@ -782,11 +782,7 @@ static ssize_t nc_sendv_compat(NetClientState *nc, const struct iovec *iov,
         offset = iov_to_buf(iov, iovcnt, 0, buf, offset);
     }
 
-    if (flags & QEMU_NET_PACKET_FLAG_RAW && nc->info->receive_raw) {
-        ret = nc->info->receive_raw(nc, buffer, offset);
-    } else {
-        ret = nc->info->receive(nc, buffer, offset);
-    }
+    ret = nc->info->receive(nc, buffer, offset);
 
     g_free(buf);
     return ret;
@@ -801,6 +797,8 @@ static ssize_t qemu_deliver_packet_iov(NetClientState *sender,
     MemReentrancyGuard *owned_reentrancy_guard;
     NetClientState *nc = opaque;
     int ret;
+    struct virtio_net_hdr_v1_hash vnet_hdr = { };
+    g_autofree struct iovec *iov_copy = NULL;
 
 
     if (nc->link_down) {
@@ -819,7 +817,15 @@ static ssize_t qemu_deliver_packet_iov(NetClientState *sender,
         owned_reentrancy_guard->engaged_in_io = true;
     }
 
-    if (nc->info->receive_iov && !(flags & QEMU_NET_PACKET_FLAG_RAW)) {
+    if ((flags & QEMU_NET_PACKET_FLAG_RAW) && nc->vnet_hdr_len) {
+        iov_copy = g_new(struct iovec, iovcnt + 1);
+        iov_copy[0].iov_base = &vnet_hdr;
+        iov_copy[0].iov_len =  nc->vnet_hdr_len;
+        memcpy(&iov_copy[1], iov, iovcnt * sizeof(*iov));
+        iov = iov_copy;
+    }
+
+    if (nc->info->receive_iov) {
         ret = nc->info->receive_iov(nc, iov, iovcnt);
     } else {
         ret = nc_sendv_compat(nc, iov, iovcnt, flags);
diff --git a/net/tap.c b/net/tap.c
index f2021b699c..09ad8ae255 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -360,7 +360,6 @@ static NetClientInfo net_tap_info = {
     .type = NET_CLIENT_DRIVER_TAP,
     .size = sizeof(TAPState),
     .receive = tap_receive,
-    .receive_raw = tap_receive_raw,
     .receive_iov = tap_receive_iov,
     .poll = tap_poll,
     .cleanup = tap_cleanup,

-- 
2.43.0


