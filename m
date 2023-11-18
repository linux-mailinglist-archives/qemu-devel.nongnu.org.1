Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6288A7EFEAA
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Nov 2023 10:20:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4HTo-0002Ta-0P; Sat, 18 Nov 2023 04:19:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4HTl-0002Sz-5U
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:19:05 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4HTj-00055W-Jl
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:19:04 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1cc5b705769so24993515ad.0
 for <qemu-devel@nongnu.org>; Sat, 18 Nov 2023 01:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700299142; x=1700903942;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V2WqTGsj76jZXQ8vdPVVfqT8PnTeJYClWaZDpNJ/6/w=;
 b=L6weqCdFYx7zhfRx69rNEq6T/9bZDkNeWx21V2CLAf5VHyxYFNgdn5sTsgY4gLDTV3
 HZkSJZ2FIqZqHabnJ461mrGydP/qzXQ1sB7cNxMFzTjlt2l6MOAzX4Fa0X8occhqZG3W
 /BfBzuTK+Vox5Jtc2YB5hHJl3ewLX5Aheu8WVv+Lxr7SUe35b5ar2TUpqe4naqGwGtB9
 PPJFJ8swaqFPX9ZVccYJs5t4eQk4xDZvCL3tR28rguCAGa7Dab4MrXriGrISCH1k789+
 oOIZ3Y+FzJ9pWJWHwyWmQ0GyN5VBWy1m6f+40H9uOrTVjFiH8pFAIvF9PzFuYn9FZ9EI
 PNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700299142; x=1700903942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V2WqTGsj76jZXQ8vdPVVfqT8PnTeJYClWaZDpNJ/6/w=;
 b=cfVVt3tV8lmTd9DQiHdQ0w3jiAcNQpyLTqXzNAvbujknjpnio+bgulmt84PaFcpiNE
 FupGLuoQVl1L1wFcLqr4K1EOdmMUPEJ5uh76jwKYSRDpX7e0UhzqDmHw20buYLkrQegW
 fTPv4B7+/KMDlgCqKGv5BuDSxnqa6FqR/KVAhtiASTQXzDDoKugH0TTCTqqkUd6NN2zg
 JjTySAbKlL6FyiFudkcYtD9RwTlMFdEiyEzq/6aPK/5jyHgHyZfBZdJ0sK8icwg5hpRW
 AWbdvwKie0UMJ8pCkxKdARu/1rtB4Sio+49mqP5yr3AUFQBQ+0ZZJhGCI1x4dAsJPI1B
 h0Fw==
X-Gm-Message-State: AOJu0YwL7ZqcYrhihlauPLJMtc1Gg4DKOJdGkZGqWcnzt8EuhZGw/+/X
 p2NNWJvvAAicMKXSjFK4IbDffCqEz0JD4C2mXDo=
X-Google-Smtp-Source: AGHT+IF8vexX91+ock5vsnajJ6Zv+UnpHq02XiURJfsH44zkEh/p7qcrX3A8xk6vE3ufkoEHEzFrLA==
X-Received: by 2002:a17:902:ec92:b0:1cf:532e:9a77 with SMTP id
 x18-20020a170902ec9200b001cf532e9a77mr942439plg.58.1700299141995; 
 Sat, 18 Nov 2023 01:19:01 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 o24-20020a170902779800b001bd28b9c3ddsm2602785pll.299.2023.11.18.01.19.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Nov 2023 01:19:01 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Zhang, Chen" <chen.zhang@intel.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v7 01/19] tap: Remove tap_probe_vnet_hdr_len()
Date: Sat, 18 Nov 2023 18:18:15 +0900
Message-ID: <20231118091837.5758-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231118091837.5758-1-akihiko.odaki@daynix.com>
References: <20231118091837.5758-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
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
2.42.1


