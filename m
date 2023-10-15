Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CCF7C9948
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 16:04:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs1i6-0001Fz-6Y; Sun, 15 Oct 2023 10:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1i3-0001EG-P2
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:03:11 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1i1-0007h7-DM
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:03:10 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-57bab4e9e1aso2311412eaf.3
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 07:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697378588; x=1697983388;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XEdgh6VmGllsYPpxs5/6ahhZy4fZCzY3SP1SSAXYIg4=;
 b=sbl/7WmDoOJE90jzxZA+jAlxvHCpAzjAYhJ21ADDwOIvBo+d5WTIiFVDMAngFZZzJz
 v/35xCUZkQ1FCwkwT+PtwwANGEArU35A521IE8vW5yFkUXfWpSItRHo8I6gxdVh4O/px
 XcQX8sqp5+CZhOg+W2TBqFC/wRTLw9cfctqTiAgZs+3oo/SprrHZdN3whIYJBjd7LyMz
 JcDp33WQ6kfFmCfkngPqOguy1uxQO00x24CkBwu6mzspYeW8sfjUysb4P/xrAPFjh3gS
 ClRwzlgHTifSZqhoIverR2ZFwN+Ut2PZRCNNo0qiiWQfSM5Bz/FZPjjcLrr1qUwSe83d
 ov5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697378588; x=1697983388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XEdgh6VmGllsYPpxs5/6ahhZy4fZCzY3SP1SSAXYIg4=;
 b=nt9QfLb1a2B8TZ1TeFI4IA9rgAYDTLbT+yHOM5cXZgpfqCI+5/LGQ4bdTPptU4nnWX
 uMfJ/haqK6PVtgh1J9QWzWnlauYHh3ab0cyPmMq+ktHF1GoG8l0Lp7p5Fnv2WW5uLzW9
 Q8w5jfGakoPrUCQlMTaGHYOAjGfZuyVd/ZvTnpIALiv3oSD6YqupS1Bnfw+7TyiIIQAa
 3DES+1ThLWgzCLWCbDvAfVO7bf3vm/b37pHYi83qw6sltbND9LVSTP0lXUYeG0sDehl+
 E2Prs5C2McECSKHwV5jQJDXQHNGHU6DeqZVaSZpbuLvX9MFccdlG9YmYM9oVu0dTYvyD
 aNkQ==
X-Gm-Message-State: AOJu0Ywkt6pJDEl4fITIgmp1qf8Vjbzcm2wO8jmLtyBCCSmQ/sZoB+I7
 2GY4qXbIV72VsxKI394u1rGPVYMJt0W6iaDiB6ddtg==
X-Google-Smtp-Source: AGHT+IFl9vZU5R4q06AHwwELoiyA+NFzIpALVt+70e/os5f7wbQEH53Qu5Fqt8HRLBN/uY6YFk1hLg==
X-Received: by 2002:a05:6358:279e:b0:139:a45c:32b2 with SMTP id
 l30-20020a056358279e00b00139a45c32b2mr30210408rwb.11.1697378588110; 
 Sun, 15 Oct 2023 07:03:08 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 v67-20020a626146000000b0068bbd43a6e2sm2645221pfb.10.2023.10.15.07.03.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 07:03:07 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 01/20] tap: Remove tap_probe_vnet_hdr_len()
Date: Sun, 15 Oct 2023 23:02:33 +0900
Message-ID: <20231015140259.259434-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015140259.259434-1-akihiko.odaki@daynix.com>
References: <20231015140259.259434-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c29;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc29.google.com
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


