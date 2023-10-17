Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F707CB98D
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 06:11:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsbPC-0007RP-71; Tue, 17 Oct 2023 00:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbP9-0007QI-HX
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:10:03 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbP1-0004DR-Nj
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:10:03 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3b2b1b25547so2340975b6e.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 21:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697515794; x=1698120594;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3g8IJT6uWVVctIq1l77oTeOIaQXbUPqE/HwHsGc+XSA=;
 b=mIXvWmknsU/fXES8Qcr0gGA59fA6X0avCHkQtvLLOx1bo+Ol90FHu9Ock7sDfrfYV+
 c+wbVZCAVQq/KDE4ly5lI7thX4/tNHf7oey3xwp2s358ayMB+cu0o5C0ex2TNrSrzjOS
 grBhH9SRirb/Hnk1h7RKGubkntIazC2f4BVmOVBunpvH5n7a78jkanwnSvwBvkvW0sF8
 RUg3Jbj42Hi9D84fJjw3Vdtipo1gj9KcGoULekSZeZThwz/0WIziJmCSpd+OBfswQodJ
 GJi6vrxXNmPzH8iKSWm7Kh0egc74dySTuYgjRuyK96c5foQaCCEK+B6rVeAA5zE3/0/h
 tZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697515794; x=1698120594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3g8IJT6uWVVctIq1l77oTeOIaQXbUPqE/HwHsGc+XSA=;
 b=mDweChYKuKntbL9TgjCaOY1Qyomz2Ba5RUbg4fdBuhegpMcuMYs2S9/hYby9TeOBvP
 ixSruso4QxrprWoe/4y6TpNcF6cLr8017tqy8Oq7MjnDFbLeMNMoyaz6R0wIcZGjOhH0
 QGoOOwEjFOcg7Gvob1rIu4cvAvld2fPYzy4hf74xnThZGwcvGZkynR5xc4a3T3w3jE0p
 Ke22PvlmvUiV0rIZhVLNynarVGEg2ntZTKVC9Y1lkSQlDc/iqkjdD1LzCn363sdibCdQ
 ZsJLS73Dic+x9ukcvhclREZJizd1XyM73vCJMWCJt7PZPuTisOOEH+qbnKy92h659D/e
 K8TA==
X-Gm-Message-State: AOJu0YwanWfgPkYO/chN1o7MrCr0fg5xM1yKYJtz41MelFQAu2PxPiZn
 qqZRoFo/fmmycat53OUYYvY3ZAcAWTyORYOEuwGeuA==
X-Google-Smtp-Source: AGHT+IElTuxJP9IuYkbxE4d+0mueohxUtDLj5nYHVO2ri9JvBE0KnRcyqSIOWSGZ8hQY92Z8F2de8Q==
X-Received: by 2002:a05:6808:14c9:b0:3a7:c2e8:5e7c with SMTP id
 f9-20020a05680814c900b003a7c2e85e7cmr1634866oiw.43.1697515794644; 
 Mon, 16 Oct 2023 21:09:54 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 p24-20020a63e658000000b005ae776b8616sm409847pgj.19.2023.10.16.21.09.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 21:09:54 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 05/21] tap: Remove tap_receive()
Date: Tue, 17 Oct 2023 13:09:11 +0900
Message-ID: <20231017040932.62997-6-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017040932.62997-1-akihiko.odaki@daynix.com>
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::22e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22e.google.com
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

The receive member of NetClientInfo is only for legacy clients and the
receive_iov member is always used when it is set.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 net/tap.c | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 087b2d3bc6..668d69c0de 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -131,41 +131,6 @@ static ssize_t tap_receive_iov(NetClientState *nc, const struct iovec *iov,
     return tap_write_packet(s, iovp, iovcnt);
 }
 
-static ssize_t tap_receive_raw(NetClientState *nc, const uint8_t *buf, size_t size)
-{
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
-    struct iovec iov[2];
-    int iovcnt = 0;
-    struct virtio_net_hdr_mrg_rxbuf hdr = { };
-
-    if (s->host_vnet_hdr_len) {
-        iov[iovcnt].iov_base = &hdr;
-        iov[iovcnt].iov_len  = s->host_vnet_hdr_len;
-        iovcnt++;
-    }
-
-    iov[iovcnt].iov_base = (char *)buf;
-    iov[iovcnt].iov_len  = size;
-    iovcnt++;
-
-    return tap_write_packet(s, iov, iovcnt);
-}
-
-static ssize_t tap_receive(NetClientState *nc, const uint8_t *buf, size_t size)
-{
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
-    struct iovec iov[1];
-
-    if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
-        return tap_receive_raw(nc, buf, size);
-    }
-
-    iov[0].iov_base = (char *)buf;
-    iov[0].iov_len  = size;
-
-    return tap_write_packet(s, iov, 1);
-}
-
 #ifndef __sun__
 ssize_t tap_read_packet(int tapfd, uint8_t *buf, int maxlen)
 {
@@ -355,7 +320,6 @@ int tap_get_fd(NetClientState *nc)
 static NetClientInfo net_tap_info = {
     .type = NET_CLIENT_DRIVER_TAP,
     .size = sizeof(TAPState),
-    .receive = tap_receive,
     .receive_iov = tap_receive_iov,
     .poll = tap_poll,
     .cleanup = tap_cleanup,
-- 
2.42.0


