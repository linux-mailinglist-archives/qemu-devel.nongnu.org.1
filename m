Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ABF80B91A
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 06:33:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCCOb-0001zQ-DJ; Sun, 10 Dec 2023 00:30:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCOG-0001xl-LA
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:30:08 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCOE-0002x6-G2
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:30:08 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3b9e2a014e8so2154918b6e.2
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 21:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702186205; x=1702791005;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GJUnJ12qTRgUsAW8NX8L3jtpgTyplRd8gOgUQOkKA84=;
 b=kVFe3Z6G3dAh2z1Rpc/MZwkGJA5QWCqAybb2jyyS1Ihgm0zIKDFY8pATZ9CiC0p3rP
 XK0KnimKaMSFD47Z1gtn3b3TwLXrJOJ5EVppmWWeHTxVjsjvjCg63O/nSDVSfVjKCm1W
 rNzuMF/YkbTrAm2wDjrdc5J1A00Zsbybb3SWGDveCJoZL6D6jkTqn241uSQgxZkhXw2C
 oQtSw1/B6glbWLWimzHkyg7QIH8RLcp1aa8GfWjM+TS/0qAYad7pG4ZaFgRNAPLWD8QU
 glufewNr2+9fKXg9mvsFugCJX8MXPiS8nC958lrHnCAEnbxlw/2sGhQ1W+MK1DUQgUHd
 9STA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702186205; x=1702791005;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GJUnJ12qTRgUsAW8NX8L3jtpgTyplRd8gOgUQOkKA84=;
 b=p6YEfy4+8gVpcsqPIVdy1WDACLT38R1TaI3tfqSG8lqa8PVQpDZ5n1Dl0grWmM6Dtv
 g7dOBJj8n6dZAdb6CISj+XTLi5AD6EATRt3tcgKVgwVqcu9IHFXBIbdyh43UjpZdXtNw
 Exq/p3M7JDcVbh5k9mYfKUEguyhso9QhZbhLeGULIuwKpfqNoRq24u08bkEA/IwFj6wA
 qt8CjAxfT7I3uTACtDWKrpkB9NZU+l7nbfSSoVl7Hk6g1TLdMum8naFyQOtQs0lAw89B
 SNC0BNfWh4nTJy9Ma3/QB8sTHKAMjeQKfOg3zSW95FtDDK/HT+YDYC3DSf7akCAibd/T
 il+w==
X-Gm-Message-State: AOJu0Ywf5j6EIcdiiL2TkJYgataRUi+Glbwbx6uEOlo7uaZIkFYe8Etl
 xK3v+6lzMUSTmUwEeSWY+uK1+Q==
X-Google-Smtp-Source: AGHT+IFtlfxaYu5D3FAja7giq5gDQh7FBIpLr1J3uHXlhSrJb7+OCMn+Q4edykW2KX6ox861TOtztA==
X-Received: by 2002:a05:6808:bc8:b0:3b8:b063:6ba4 with SMTP id
 o8-20020a0568080bc800b003b8b0636ba4mr3396436oik.83.1702186205362; 
 Sat, 09 Dec 2023 21:30:05 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 v188-20020a632fc5000000b005c66a7d70fdsm3970044pgv.61.2023.12.09.21.30.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 21:30:05 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 10 Dec 2023 14:29:39 +0900
Subject: [PATCH v8 01/19] tap: Remove tap_probe_vnet_hdr_len()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231210-rss-v8-1-9553ee714d38@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::22a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22a.google.com
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
 net/tap.c         |  8 ++------
 6 files changed, 2 insertions(+), 42 deletions(-)

diff --git a/net/tap_int.h b/net/tap_int.h
index 9a2175655b..8857ff299d 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -35,7 +35,6 @@ ssize_t tap_read_packet(int tapfd, uint8_t *buf, int maxlen);
 
 void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp);
 int tap_probe_vnet_hdr(int fd, Error **errp);
-int tap_probe_vnet_hdr_len(int fd, int len);
 int tap_probe_has_ufo(int fd);
 int tap_probe_has_uso(int fd);
 void tap_fd_set_offload(int fd, int csum, int tso4, int tso6, int ecn, int ufo,
diff --git a/net/tap-bsd.c b/net/tap-bsd.c
index 274ea7bd2c..b4c84441ba 100644
--- a/net/tap-bsd.c
+++ b/net/tap-bsd.c
@@ -217,11 +217,6 @@ int tap_probe_has_uso(int fd)
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
index c7e514ecb0..1226d5fda2 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -185,26 +185,6 @@ int tap_probe_has_uso(int fd)
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
index 08b13af512..51b7830bef 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -221,11 +221,6 @@ int tap_probe_has_uso(int fd)
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
index 4b24f61e3a..38673434cb 100644
--- a/net/tap-stub.c
+++ b/net/tap-stub.c
@@ -52,11 +52,6 @@ int tap_probe_has_uso(int fd)
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
index c23d0323c2..a1f4d9d49f 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -259,11 +259,7 @@ static bool tap_has_vnet_hdr(NetClientState *nc)
 
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
@@ -432,7 +428,7 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
      * Make sure host header length is set correctly in tap:
      * it might have been modified by another instance of qemu.
      */
-    if (tap_probe_vnet_hdr_len(s->fd, s->host_vnet_hdr_len)) {
+    if (vnet_hdr) {
         tap_fd_set_vnet_hdr_len(s->fd, s->host_vnet_hdr_len);
     }
     tap_read_poll(s, true);

-- 
2.43.0


