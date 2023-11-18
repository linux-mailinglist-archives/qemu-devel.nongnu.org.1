Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A95057EFEAC
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Nov 2023 10:20:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4HTz-0002V1-Hl; Sat, 18 Nov 2023 04:19:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4HTx-0002Uq-I4
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:19:17 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4HTw-00056L-0B
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:19:17 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3b56b618217so1793322b6e.0
 for <qemu-devel@nongnu.org>; Sat, 18 Nov 2023 01:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700299155; x=1700903955;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NH4z8c4GQjAouNwfLwfScwCiclvcDQ3b58PlUlrM6zA=;
 b=hqup4Fg1cEowKgNtK4mOFvvxVF+v4dn2Uaw7lZwoYX67yOiGBmfJ4um4MwX6+PVzSG
 hjOu54wnlIdEvSI6Xm7CQI5WA7NF/dANpGUTQHFhpGUY0uou1+675JKD74evV0SkWbOd
 n+qRecZnMQ0VL8Q+ww/97LeR/HjynFk2JZdJzrzvzm1+HmhdDjuks+yGNSF/7YNHBDFJ
 fvKSINfeaCMMbHNOq9ZALRztWa2i/FoGZxEMBytivsAiVALhAyCONFapvnDktewFm4xf
 V4IZUqHJAN4/adsBAESLsi5m4VHE4zJuVEiHLG2a6ry/z1APFTdHxcYbQyxOjLKncgVP
 UHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700299155; x=1700903955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NH4z8c4GQjAouNwfLwfScwCiclvcDQ3b58PlUlrM6zA=;
 b=gRRUsO9RBy9RujAef0w31hwokcCeI7g7Zd3NOq8dLjIY0rtEBBo+1gothK5BuXAuBG
 gGfvxntsyFsZL07BYhCE8k1tjmyCiZcvL74Ge3oCJdMFHg/JA9QcbwJeqtHUciHieiLY
 WF4CTDI4N5ZghUqjFT/JCGlMEwRWJJhCrAh0nOm5JFjijOYA4XmzYIyCM4ZyOyT8D6Eg
 /d0SSn78eYLEXRk/muIzvlwk6L18b2Tr2uYbvfJtBShv8LGjTSDgDf0MTazgAm2NCY2q
 s4zeLMaKafLvoOh6PNIpdgJ+P/F+qTl/pm7hTCqdWhzm/QNah+XI3DBIutSZd9DrRN8e
 ECgw==
X-Gm-Message-State: AOJu0YyHjeLM/PreFt44JQ4GfeegAi94FNYT/aJJa74xHVZ/kN++RT1H
 mTD3PsxtE35Dm8zkvnZbcf6sQYYMKtgcgC0x1GQ=
X-Google-Smtp-Source: AGHT+IGJMLyOxlQidLehkZaLrtbqrC56xH0PclYmr7GGwc89JmrVAZ+AyrP2oyuuiNHuctljQsXzcA==
X-Received: by 2002:a05:6808:3a0e:b0:3b6:b9db:ea1c with SMTP id
 gr14-20020a0568083a0e00b003b6b9dbea1cmr2811809oib.42.1700299154724; 
 Sat, 18 Nov 2023 01:19:14 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 w6-20020aa78586000000b006cb3a30f75csm1452818pfn.220.2023.11.18.01.19.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Nov 2023 01:19:14 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Zhang, Chen" <chen.zhang@intel.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v7 04/19] net: Remove receive_raw()
Date: Sat, 18 Nov 2023 18:18:18 +0900
Message-ID: <20231118091837.5758-5-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231118091837.5758-1-akihiko.odaki@daynix.com>
References: <20231118091837.5758-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::231;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x231.google.com
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
index 2e7c3fcc2a..66258ce92f 100644
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
2.42.1


