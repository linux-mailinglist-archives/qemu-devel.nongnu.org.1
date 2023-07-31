Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0844D76A432
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 00:33:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQbRU-00012Q-4h; Mon, 31 Jul 2023 18:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qQbRS-000124-9j
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 18:32:42 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qQbRQ-0002UT-Gg
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 18:32:42 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31763b2c5a4so5153097f8f.3
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 15:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690842759; x=1691447559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/C3GsHFScwRvNPkmYfHnFJs052Dw/j4Lwl+ku+3sy6M=;
 b=PSNYho2OYlUhimrOLaOQbIXNLCEMAmLAy96urojX34mPawSjXMSlE5Zj4T78PNKwZW
 33DBaj9Je5yb0GI/U66XmV+97ApKLK7bvFrDc0qfla4nE/wTFS6vPqLIlJXEClEAKkls
 tFrbUsHOII4V326FWXRGCK+EkzfirSpAsGdlrKFWbdM9dzzQPcCWLzYbOhe+xCvD+3jm
 +OLijRm/Qd8C4X82TK3dQyLbf46FcEOl+X686EmkAnu+8W2kLu9ZMtBYn2BH0lz1wPWy
 49xodUEWqCsfJlwPJFFrE+Zy7cH3ThqjgthfhmF0BllSos4UfjhMySGhavfP5TijxNBt
 lYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690842759; x=1691447559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/C3GsHFScwRvNPkmYfHnFJs052Dw/j4Lwl+ku+3sy6M=;
 b=hyl4SYIWRpKTXK4ViZsD4fuMBCbWsLWHlEwMsXNGpgrkG/IBb1zm1k1rSZOHnxPVxv
 qOnlc/x5PnPDMI1XYwXKCXaQ2wUDyytZ1UghK3kEKaU3vsWNyCbfqdmwt5H6cQ6g8Bt/
 dT+bD0MNs0BaOz/uHC7aMYccB9mupY17BtnLCDHkqvyPN8fLOBODl2sOYU5yDb7rXAzu
 yBB4mcWYbCHFhW9Ec2QbPPWmIyY1rPCACe2Puw8nbxi8eUwTMVcCzSrKFtVzL8rl0Zcv
 uxT/Wmn6aD6fwVewLkIR+xYRAKz8KHMMsHEhF6sFuN4SFbLW//9w7TbGNm1LrQSx7Zkg
 VvlQ==
X-Gm-Message-State: ABy/qLa0hiGBm+Redp2qXNz6+Y7EpGMeGkkRKEEn8g8V/20AhKX9fVUt
 rIYgC1P3WVa04+FkP5BJOmppEQ==
X-Google-Smtp-Source: APBJJlE5QFQJXkviQwWvh6+tR3URsj2x60lEciuUv+lXdgwa8Cumus5S19F8+86TD9Biuqpk4rxO1Q==
X-Received: by 2002:a5d:50d0:0:b0:317:3c89:7f03 with SMTP id
 f16-20020a5d50d0000000b003173c897f03mr969491wrt.5.1690842758525; 
 Mon, 31 Jul 2023 15:32:38 -0700 (PDT)
Received: from localhost.localdomain
 ([2a06:c701:46e5:f400:91e1:5f50:afab:4c79])
 by smtp.gmail.com with ESMTPSA id
 x5-20020aa7dac5000000b005223c34259fsm5915088eds.57.2023.07.31.15.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 15:32:38 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 akihiko.odaki@daynix.com, jasowang@redhat.com, sriram.yagnaraman@est.tech,
 mst@redhat.com, sw@weilnetz.de, qemu-devel@nongnu.org
Cc: yan@daynix.com
Subject: [PATCH v2 2/4] tap: Add check for USO features
Date: Tue,  1 Aug 2023 01:31:46 +0300
Message-Id: <20230731223148.1002258-3-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230731223148.1002258-1-yuri.benditovich@daynix.com>
References: <20230731223148.1002258-1-yuri.benditovich@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::430;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-wr1-x430.google.com
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

Tap indicates support for USO features according to
capabilities of current kernel module.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Signed-off-by: Andrew Melnychecnko <andrew@daynix.com>
---
 include/net/net.h |  3 +++
 net/net.c         |  9 +++++++++
 net/tap-bsd.c     |  5 +++++
 net/tap-linux.c   | 12 ++++++++++++
 net/tap-solaris.c |  5 +++++
 net/tap-stub.c    |  5 +++++
 net/tap.c         | 12 ++++++++++++
 net/tap_int.h     |  1 +
 8 files changed, 52 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index b5ccfbbffb..330d285930 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -54,6 +54,7 @@ typedef void (LinkStatusChanged)(NetClientState *);
 typedef void (NetClientDestructor)(NetClientState *);
 typedef RxFilterInfo *(QueryRxFilter)(NetClientState *);
 typedef bool (HasUfo)(NetClientState *);
+typedef bool (HasUso)(NetClientState *);
 typedef bool (HasVnetHdr)(NetClientState *);
 typedef bool (HasVnetHdrLen)(NetClientState *, int);
 typedef bool (GetUsingVnetHdr)(NetClientState *);
@@ -84,6 +85,7 @@ typedef struct NetClientInfo {
     QueryRxFilter *query_rx_filter;
     NetPoll *poll;
     HasUfo *has_ufo;
+    HasUso *has_uso;
     HasVnetHdr *has_vnet_hdr;
     HasVnetHdrLen *has_vnet_hdr_len;
     GetUsingVnetHdr *get_using_vnet_hdr;
@@ -187,6 +189,7 @@ void qemu_set_info_str(NetClientState *nc,
                        const char *fmt, ...) G_GNUC_PRINTF(2, 3);
 void qemu_format_nic_info_str(NetClientState *nc, uint8_t macaddr[6]);
 bool qemu_has_ufo(NetClientState *nc);
+bool qemu_has_uso(NetClientState *nc);
 bool qemu_has_vnet_hdr(NetClientState *nc);
 bool qemu_has_vnet_hdr_len(NetClientState *nc, int len);
 bool qemu_get_using_vnet_hdr(NetClientState *nc);
diff --git a/net/net.c b/net/net.c
index 543e6dec43..b110e61f66 100644
--- a/net/net.c
+++ b/net/net.c
@@ -495,6 +495,15 @@ bool qemu_has_ufo(NetClientState *nc)
     return nc->info->has_ufo(nc);
 }
 
+bool qemu_has_uso(NetClientState *nc)
+{
+    if (!nc || !nc->info->has_uso) {
+        return false;
+    }
+
+    return nc->info->has_uso(nc);
+}
+
 bool qemu_has_vnet_hdr(NetClientState *nc)
 {
     if (!nc || !nc->info->has_vnet_hdr) {
diff --git a/net/tap-bsd.c b/net/tap-bsd.c
index abd16a2ad2..274ea7bd2c 100644
--- a/net/tap-bsd.c
+++ b/net/tap-bsd.c
@@ -212,6 +212,11 @@ int tap_probe_has_ufo(int fd)
     return 0;
 }
 
+int tap_probe_has_uso(int fd)
+{
+    return 0;
+}
+
 int tap_probe_vnet_hdr_len(int fd, int len)
 {
     return 0;
diff --git a/net/tap-linux.c b/net/tap-linux.c
index 30fcca1bc2..c7e514ecb0 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -173,6 +173,18 @@ int tap_probe_has_ufo(int fd)
     return 1;
 }
 
+int tap_probe_has_uso(int fd)
+{
+    unsigned offload;
+
+    offload = TUN_F_CSUM | TUN_F_USO4 | TUN_F_USO6;
+
+    if (ioctl(fd, TUNSETOFFLOAD, offload) < 0) {
+        return 0;
+    }
+    return 1;
+}
+
 /* Verify that we can assign given length */
 int tap_probe_vnet_hdr_len(int fd, int len)
 {
diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index a617a10e5c..08b13af512 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -216,6 +216,11 @@ int tap_probe_has_ufo(int fd)
     return 0;
 }
 
+int tap_probe_has_uso(int fd)
+{
+    return 0;
+}
+
 int tap_probe_vnet_hdr_len(int fd, int len)
 {
     return 0;
diff --git a/net/tap-stub.c b/net/tap-stub.c
index ac8dfc03b4..4b24f61e3a 100644
--- a/net/tap-stub.c
+++ b/net/tap-stub.c
@@ -47,6 +47,11 @@ int tap_probe_has_ufo(int fd)
     return 0;
 }
 
+int tap_probe_has_uso(int fd)
+{
+    return 0;
+}
+
 int tap_probe_vnet_hdr_len(int fd, int len)
 {
     return 0;
diff --git a/net/tap.c b/net/tap.c
index 14ea4ef26f..bcea8d03f9 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -57,6 +57,7 @@ typedef struct TAPState {
     bool write_poll;
     bool using_vnet_hdr;
     bool has_ufo;
+    bool has_uso;
     bool enabled;
     VHostNetState *vhost_net;
     unsigned host_vnet_hdr_len;
@@ -237,6 +238,15 @@ static bool tap_has_ufo(NetClientState *nc)
     return s->has_ufo;
 }
 
+static bool tap_has_uso(NetClientState *nc)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+
+    assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
+
+    return s->has_uso;
+}
+
 static bool tap_has_vnet_hdr(NetClientState *nc)
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
@@ -384,6 +394,7 @@ static NetClientInfo net_tap_info = {
     .poll = tap_poll,
     .cleanup = tap_cleanup,
     .has_ufo = tap_has_ufo,
+    .has_uso = tap_has_uso,
     .has_vnet_hdr = tap_has_vnet_hdr,
     .has_vnet_hdr_len = tap_has_vnet_hdr_len,
     .get_using_vnet_hdr = tap_get_using_vnet_hdr,
@@ -413,6 +424,7 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
     s->host_vnet_hdr_len = vnet_hdr ? sizeof(struct virtio_net_hdr) : 0;
     s->using_vnet_hdr = false;
     s->has_ufo = tap_probe_has_ufo(s->fd);
+    s->has_uso = tap_probe_has_uso(s->fd);
     s->enabled = true;
     tap_set_offload(&s->nc, 0, 0, 0, 0, 0, 0, 0);
     /*
diff --git a/net/tap_int.h b/net/tap_int.h
index d8861d81ba..9a2175655b 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -37,6 +37,7 @@ void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp);
 int tap_probe_vnet_hdr(int fd, Error **errp);
 int tap_probe_vnet_hdr_len(int fd, int len);
 int tap_probe_has_ufo(int fd);
+int tap_probe_has_uso(int fd);
 void tap_fd_set_offload(int fd, int csum, int tso4, int tso6, int ecn, int ufo,
                         int uso4, int uso6);
 void tap_fd_set_vnet_hdr_len(int fd, int len);
-- 
2.34.3


