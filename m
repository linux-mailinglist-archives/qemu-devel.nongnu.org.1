Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F51575F1FA
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 12:04:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNsQ7-00062J-W3; Mon, 24 Jul 2023 06:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <4strangepeople@gmail.com>)
 id 1qNsQ5-000628-Lf
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:04:01 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <4strangepeople@gmail.com>)
 id 1qNsQ3-0007YY-J6
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:04:01 -0400
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-3fbea14700bso30801505e9.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 03:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690193037; x=1690797837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=phdjr9yLeFo5F8oWvS/1JZyGXMwccGCUo668O3/Bpvs=;
 b=W1+BNR+1bJm/a8aygTvx6XotsedJWyIu03T5pz+cerOb5Hj5PKVVDLJD9RKwdYMp8V
 KThJP3/j5EQkUNBHfekp+XkuwL9Rv7bkXqNsov810ELVnM76gcegndlkjXTin2J12Tvw
 85vn2uz77x2fEqoctE9gzsEDii7OCIfuxjhNzWj5z7CIR/hlmU0+xXISZEG5GbhGFbQz
 Ufoj5b/gYnA4WoVG8Dz/RSGl/pektRA41zVwmL8X3kHzkBgrjqnbtxOiq10KvD7r2dYr
 OiQiKdJ+/CQi7sNJDjXuY/p1TSbmKVHr4kMsJFkTloqUBehU1Q5LFRlCtugSCVOY4eb/
 SJNw==
X-Gm-Message-State: ABy/qLamWFqzAkdHaGjhpQrZIJGfTjZDWRbmRpOFLznSvxMsCglljKIi
 coRPZor2EeXPWDiOeK1Yh2Te+LWlEtc=
X-Google-Smtp-Source: APBJJlFgsEOhIvlVdvwsylXPDv5ZYALtBx3Bdrdya2EP4vVQo3wS28W2LqwuSYj1KBVo7hYg4amGoQ==
X-Received: by 2002:a05:600c:2907:b0:3fc:1bd:95a6 with SMTP id
 i7-20020a05600c290700b003fc01bd95a6mr5995161wmd.31.1690193037328; 
 Mon, 24 Jul 2023 03:03:57 -0700 (PDT)
Received: from kotebook.zasenko.name ([91.123.151.221])
 by smtp.gmail.com with ESMTPSA id
 o20-20020a5d58d4000000b0031433443265sm12451870wrf.53.2023.07.24.03.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 03:03:56 -0700 (PDT)
From: Sergii Zasenko <sergii@zasenko.name>
To: qemu-devel@nongnu.org
Cc: Sergii Zasenko <sergii@zasenko.name>
Subject: [PATCH] Allow UNIX socket option for VNC websocket
Date: Mon, 24 Jul 2023 13:03:53 +0300
Message-Id: <20230724100353.16628-1-sergii@zasenko.name>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <ZL47B09wgJybWThE@redhat.com>
References: <ZL47B09wgJybWThE@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.128.49;
 envelope-from=4strangepeople@gmail.com; helo=mail-wm1-f49.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

- Remove unix socket option limitation for VNC websocket
- Reflect websocket option changes in documentation

Signed-off-by: Sergii Zasenko <sergii@zasenko.name>
---
 qemu-options.hx | 4 ++++
 ui/vnc.c        | 5 -----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 29b98c3..8cc910d 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2451,6 +2451,10 @@ SRST
         host. It is possible to control the websocket listen address
         independently, using the syntax ``websocket``\ =host:port.
 
+        Websocket could be allowed over UNIX domain socket, using the syntax
+        ``websocket``\ =unix:path, where path is the location of a unix socket
+        to listen for connections on.
+
         If no TLS credentials are provided, the websocket connection
         runs in unencrypted mode. If TLS credentials are provided, the
         websocket connection requires encrypted client connections.
diff --git a/ui/vnc.c b/ui/vnc.c
index 92964dc..dea1414 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3715,11 +3715,6 @@ static int vnc_display_get_address(const char *addrstr,
         addr->type = SOCKET_ADDRESS_TYPE_UNIX;
         addr->u.q_unix.path = g_strdup(addrstr + 5);
 
-        if (websocket) {
-            error_setg(errp, "UNIX sockets not supported with websock");
-            goto cleanup;
-        }
-
         if (to) {
             error_setg(errp, "Port range not support with UNIX socket");
             goto cleanup;
-- 
2.39.2


