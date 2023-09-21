Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD937A9273
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 10:01:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjEWg-0004iG-Hx; Thu, 21 Sep 2023 03:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjEWe-0004f9-9b
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:55:04 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjEWc-0001Sq-LX
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:55:04 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c44a25bd0bso12076245ad.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 00:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1695282901; x=1695887701;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+dsr6eyuJ9VSJfAqFZ+Sn8WOb7QBRrG/FmPzrYRLnEY=;
 b=U2GsCXIoPFBYykwz2dirjEzpgUtVgWoOPDafjsAaeSGXlH7qPQGZRIW95BLIqnGjwW
 g7umgSKCFu1ca0yptghvTHQ/y7GQdXy8l5Bq2LCun777hmcVXBhGZ+ivpqYwu1dDN2jH
 J4B1gD9UpbFQ7i1hcmEPGHYzVYRDivvgon2b1hay6PeWzPFLEqbpDtSs3FPAqWJc7kFx
 clU45nDlEMQTeLCn3dZ5OOR/dl9MVmChTLo4K7b0P9lz9hNEHYC1ShgjpEQiPVro2Vpo
 paLJOjWVksh6kCPDRhDUMqGPe8sWAucBm8lmVR5GhElxaA13Q1CmKMMUnXHUjMKf36NJ
 OYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695282901; x=1695887701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+dsr6eyuJ9VSJfAqFZ+Sn8WOb7QBRrG/FmPzrYRLnEY=;
 b=heHxP8pjEIffYcYi6aKh1fJSggxE6DTgrtVx4rTDZynx9tTjd5Tv7jgWgYEpA5IcD3
 yEPe3tg7eVXjsL7g6XC5ho41RTiFS2QkSWeGRF0LxaMvGoacXcj3xFRG2M5VuzHmzWvH
 y9m5Eg5AaBKPamznqYqXXIZoeyMFi8pHA+Wg5bJGpjrxSoOmGaN5HV2EEMcevd1Lr6r/
 yRr3bcjteA+hstZOvHjK2JfJKraKYDQzrVUke2h7XVGk5T6yqbGqYe0cXlSkS92PZC92
 hckTDayBD2Tb6Hn/9cUIYXdFtshiYGQXdDwmC75AABF21gJbdGoNApfhWQYoe5bUtwjS
 7ktQ==
X-Gm-Message-State: AOJu0YyUgT4TuKgkMNj7AFSk9DOfW+fToq5jddKzjg3LeZhmgBktQRe4
 A9UVnMkjKqfFf0gA4ffsKbdw0qx6t4LNRXVVsSQ=
X-Google-Smtp-Source: AGHT+IGhor9je1oMW+9ljkb6gPnNnfkJv4J+3cOZJN3lvufQK8RUdZQKCzNFPt0Xg4Im69lT2Kl4zA==
X-Received: by 2002:a17:902:f813:b0:1b7:f64b:379b with SMTP id
 ix19-20020a170902f81300b001b7f64b379bmr5949643plb.17.1695282901422; 
 Thu, 21 Sep 2023 00:55:01 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:a840:1e00:d54:e521:8bac:7bed])
 by smtp.gmail.com with ESMTPSA id
 p22-20020a170902a41600b001ae0152d280sm761928plq.193.2023.09.21.00.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 00:55:01 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, virtio-fs@redhat.com,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Yan Vugenfirer <yan@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 4/8] qga: Use qemu_get_runtime_dir()
Date: Thu, 21 Sep 2023 16:54:18 +0900
Message-ID: <20230921075425.16738-5-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921075425.16738-1-akihiko.odaki@daynix.com>
References: <20230921075425.16738-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
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

qemu_get_runtime_dir() is used to construct the default state directory.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 qga/main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index 8668b9f3d3..145ee02df3 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -45,12 +45,11 @@
 #define QGA_VIRTIO_PATH_DEFAULT "/dev/virtio-ports/org.qemu.guest_agent.0"
 #endif /* CONFIG_BSD */
 #define QGA_SERIAL_PATH_DEFAULT "/dev/ttyS0"
-#define QGA_STATE_RELATIVE_DIR  "run"
 #else
 #define QGA_VIRTIO_PATH_DEFAULT "\\\\.\\Global\\org.qemu.guest_agent.0"
-#define QGA_STATE_RELATIVE_DIR  "qemu-ga"
 #define QGA_SERIAL_PATH_DEFAULT "COM1"
 #endif
+#define QGA_STATE_RELATIVE_DIR  "qemu-ga"
 #ifdef CONFIG_FSFREEZE
 #define QGA_FSFREEZE_HOOK_DEFAULT CONFIG_QEMU_CONFDIR "/fsfreeze-hook"
 #endif
@@ -129,12 +128,12 @@ static void stop_agent(GAState *s, bool requested);
 static void
 init_dfl_pathnames(void)
 {
-    g_autofree char *state = qemu_get_local_state_dir();
+    g_autofree char *run = qemu_get_runtime_dir();
 
     g_assert(dfl_pathnames.state_dir == NULL);
     g_assert(dfl_pathnames.pidfile == NULL);
-    dfl_pathnames.state_dir = g_build_filename(state, QGA_STATE_RELATIVE_DIR, NULL);
-    dfl_pathnames.pidfile = g_build_filename(state, QGA_STATE_RELATIVE_DIR, "qemu-ga.pid", NULL);
+    dfl_pathnames.state_dir = g_build_filename(run, QGA_STATE_RELATIVE_DIR, NULL);
+    dfl_pathnames.pidfile = g_build_filename(run, QGA_STATE_RELATIVE_DIR, "qemu-ga.pid", NULL);
 }
 
 static void quit_handler(int sig)
-- 
2.41.0


