Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D01617CB992
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 06:11:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsbOq-0007Nk-U7; Tue, 17 Oct 2023 00:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbOp-0007NT-KD
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:09:43 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbOn-00043k-R0
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:09:43 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1c9d3a21f7aso42060645ad.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 21:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697515780; x=1698120580;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XEdgh6VmGllsYPpxs5/6ahhZy4fZCzY3SP1SSAXYIg4=;
 b=GALkOwn/gPnWI7eJRhSzlKFMGO2Ge1j5MoPnFqPAzwrUYElk0KZ3gvGR7gKXPKxQ6n
 cW6QAk3JbtW/zgikzZyHe3PI5sCSxJpMV8Nms61pAQbxwZiLZrdCG760yNc+HikJ+xhf
 KCTz5w4QQLWsTOqlVJkaGZDCsoV4TvIiulNAJSTUWCF6NqOhTBOpI2gNlDAK8Tm7iCE8
 4FEYjfPQZUwiAhDd6gClgU5Gzzsc6faJbI7KFiz9Wf74aGRgmqY33tt9parsLG8w4rTR
 q8V9vfVUTLeSIpM+DkH6McPoBFC44T9AwFOo1ozDeCkbrHJ9PwlwVhDJ6tOBPOTG4jLL
 +D/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697515780; x=1698120580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XEdgh6VmGllsYPpxs5/6ahhZy4fZCzY3SP1SSAXYIg4=;
 b=pGx8Bj/Tw5NN6J6LEk36InRBQxfcXIsXfwTjRZTvqHtTnc4vbLrI7Q1dL6VW9lkm0a
 L7+UGmSpARC23AhnEU+H2G8RpAVIKCUa2SF2qqe1ITTEl+k/gwK61ywQb1FNayF1/wx4
 GbaCYQPesWEl21Sw35QkIL08rHfXoRkFxEF/cIrlwsAlbDYVtAuEpHWrteeY1B3v4E1y
 zmWY+PyZ0cvXKpj0YRqrjpcIyvMF+x8B1MqmgxpZvfbiC8tGsQ+8VFQZ6uuMtCr+/Qz+
 EyeYzTJbtj2Hfew1D6nmOPSAJqP/wiFasqPoQFra0bwHfkaew/maUrvT4sfGNVVg/sLy
 rGqQ==
X-Gm-Message-State: AOJu0Yy22PTo0KdGyqX39rh0at9ANO7IB2hyDp9AY7zAsbcs7KyMqAHB
 2zuJYdogEY8hcfzHTWsIzBoAISbe8LpQnSxOmv4pYg==
X-Google-Smtp-Source: AGHT+IGFCDXDzfLnYPhXWjBMjtcUsZyuWDqOA2uH+aPCliuZxAMPLHTbG66FEV8tjkXJzXONt6LDJg==
X-Received: by 2002:a17:903:2607:b0:1c5:ce3c:c399 with SMTP id
 jd7-20020a170903260700b001c5ce3cc399mr1231801plb.39.1697515780432; 
 Mon, 16 Oct 2023 21:09:40 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 b11-20020a170902bd4b00b001c9d6923e7dsm386037plx.222.2023.10.16.21.09.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 21:09:40 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 01/21] tap: Remove tap_probe_vnet_hdr_len()
Date: Tue, 17 Oct 2023 13:09:07 +0900
Message-ID: <20231017040932.62997-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017040932.62997-1-akihiko.odaki@daynix.com>
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
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

It was necessary since an Linux older than 2.6.35 may implement the
virtio-net header but may not allow to change its length. Remove it
since such an old Linux is no longer supported.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/tap_int.h     |  1 -
 net/tap-bsd.c     |  5 -----
 net/tap-linux.c   | 20 --------------------
 net/tap-solaris.c |  5 -----
 net/tap-stub.c    |  5 -----
 net/tap.c         | 10 ++--------
 6 files changed, 2 insertions(+), 44 deletions(-)

diff --git a/net/tap_int.h b/net/tap_int.h
index 547f8a5a28..ff7ab23ad7 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -35,7 +35,6 @@ ssize_t tap_read_packet(int tapfd, uint8_t *buf, int maxlen);
 
 void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp);
 int tap_probe_vnet_hdr(int fd, Error **errp);
-int tap_probe_vnet_hdr_len(int fd, int len);
 int tap_probe_has_ufo(int fd);
 void tap_fd_set_offload(int fd, int csum, int tso4, int tso6, int ecn, int ufo);
 void tap_fd_set_vnet_hdr_len(int fd, int len);
diff --git a/net/tap-bsd.c b/net/tap-bsd.c
index 4c98fdd337..bcd9e894a8 100644
--- a/net/tap-bsd.c
+++ b/net/tap-bsd.c
@@ -212,11 +212,6 @@ int tap_probe_has_ufo(int fd)
     return 0;
 }
 
-int tap_probe_vnet_hdr_len(int fd, int len)
-{
-    return 0;
-}
-
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
diff --git a/net/tap-linux.c b/net/tap-linux.c
index f54f308d35..985287816e 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -173,26 +173,6 @@ int tap_probe_has_ufo(int fd)
     return 1;
 }
 
-/* Verify that we can assign given length */
-int tap_probe_vnet_hdr_len(int fd, int len)
-{
-    int orig;
-    if (ioctl(fd, TUNGETVNETHDRSZ, &orig) == -1) {
-        return 0;
-    }
-    if (ioctl(fd, TUNSETVNETHDRSZ, &len) == -1) {
-        return 0;
-    }
-    /* Restore original length: we can't handle failure. */
-    if (ioctl(fd, TUNSETVNETHDRSZ, &orig) == -1) {
-        fprintf(stderr, "TUNGETVNETHDRSZ ioctl() failed: %s. Exiting.\n",
-                strerror(errno));
-        abort();
-        return -errno;
-    }
-    return 1;
-}
-
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
     if (ioctl(fd, TUNSETVNETHDRSZ, &len) == -1) {
diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index 38e15028bf..6ad79fecad 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -216,11 +216,6 @@ int tap_probe_has_ufo(int fd)
     return 0;
 }
 
-int tap_probe_vnet_hdr_len(int fd, int len)
-{
-    return 0;
-}
-
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
diff --git a/net/tap-stub.c b/net/tap-stub.c
index a0fa25804b..422257668c 100644
--- a/net/tap-stub.c
+++ b/net/tap-stub.c
@@ -47,11 +47,6 @@ int tap_probe_has_ufo(int fd)
     return 0;
 }
 
-int tap_probe_vnet_hdr_len(int fd, int len)
-{
-    return 0;
-}
-
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
diff --git a/net/tap.c b/net/tap.c
index c6639d9f20..0403729739 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -248,11 +248,7 @@ static bool tap_has_vnet_hdr(NetClientState *nc)
 
 static bool tap_has_vnet_hdr_len(NetClientState *nc, int len)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
-
-    assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
-
-    return !!tap_probe_vnet_hdr_len(s->fd, len);
+    return tap_has_vnet_hdr(nc);
 }
 
 static int tap_get_vnet_hdr_len(NetClientState *nc)
@@ -419,9 +415,7 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
      * Make sure host header length is set correctly in tap:
      * it might have been modified by another instance of qemu.
      */
-    if (tap_probe_vnet_hdr_len(s->fd, s->host_vnet_hdr_len)) {
-        tap_fd_set_vnet_hdr_len(s->fd, s->host_vnet_hdr_len);
-    }
+    tap_fd_set_vnet_hdr_len(s->fd, s->host_vnet_hdr_len);
     tap_read_poll(s, true);
     s->vhost_net = NULL;
 
-- 
2.42.0


