Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC40C7A9256
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 09:56:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjEX3-0005ab-2A; Thu, 21 Sep 2023 03:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjEWz-0005Zu-Sb
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:55:25 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjEWy-0001s5-Aj
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:55:25 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c3f97f2239so5625885ad.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 00:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1695282923; x=1695887723;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D7XgavntPO93Ri3KubETdfMRGZmmewXPeIHFa3pR3w4=;
 b=UCtDvIgr5cW7qKvh8DQSdRDOqMQS7od0X9ZJrvWJTNIdo9SaK2A23gOUnYuNnWkvNO
 mIw1x+vYLoz22EkWUS9fGRg4MGKGlTpFJ/h4UyU0FnicR/p+47SZAdjLy2bhDEw61CPy
 sXXcubAxeOVKmxvH9ays2FxiRDNM6g8SrCMe19HtD8Kyw01MDi8bwMT8vXnBTJtWtNsx
 vsQnxDwMhg+/Yk/8KyFEyj2h3wrGCwOxcyUgdyQTmu48sPQbSyPaYvx4npz1IXvifptG
 RQ0o8asGuJ+DXDsDqGhhMYi+j4MVZ0h/FM87rUtoHDDmVWTIWgcSKisVYwY6bYPdDNKL
 pBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695282923; x=1695887723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D7XgavntPO93Ri3KubETdfMRGZmmewXPeIHFa3pR3w4=;
 b=fBHVPCn+td2KJE7gYz1pn9dg5NOpGF8+xRojtMf++jT83i/bjOHlEkBTWeBBmJzw1h
 eFvYErmP3Sywrt/u5kgGLWGephMD5bOfk3PGIgdM2Gm3r2wloFrTfM4YLeBZZwICSMx7
 9wOQ9SK+xpCf+FY1JaQoKgVAni490miFMl3iv6BgsyxlgqnH0aZ8cadk2CqtNHEmX+gH
 5DcO7kFvbpyvpn9oJR69wfDQhLV/pKVu+bf9vstnSkcW6xmUC3/VMn6ahWya3W3dKLO6
 HwOGjEDn2d5hyZe4xERb+rh4Odbi7pix5hO8A0TdKjHPGZZeUZy8Z2TTjx5+lSiADmdE
 pfBQ==
X-Gm-Message-State: AOJu0YyI6raEjuXKREYhFzrTym6dgikVJLLtgTjr593cwPlHC5ZFAMdI
 ECT9W7O9qK96fLMXnscjZ/DsUAkJtn1GTeGtSgI=
X-Google-Smtp-Source: AGHT+IG/v1T7zdMXQ46L8xw0TEVK5wa9C8hkq5sN3uwC6lT4Ey31J9VdmWXzaQisa5tsjvOGXEKLpA==
X-Received: by 2002:a17:902:d4c4:b0:1bf:2e5c:7367 with SMTP id
 o4-20020a170902d4c400b001bf2e5c7367mr5672348plg.42.1695282922889; 
 Thu, 21 Sep 2023 00:55:22 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:a840:1e00:d54:e521:8bac:7bed])
 by smtp.gmail.com with ESMTPSA id
 p22-20020a170902a41600b001ae0152d280sm761928plq.193.2023.09.21.00.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 00:55:22 -0700 (PDT)
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
Subject: [PATCH v3 8/8] spice-app: Use qemu_get_runtime_dir()
Date: Thu, 21 Sep 2023 16:54:22 +0900
Message-ID: <20230921075425.16738-9-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921075425.16738-1-akihiko.odaki@daynix.com>
References: <20230921075425.16738-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

qemu_get_runtime_dir() provides QEMU-specific fallback of runtime
directory.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ui/spice-app.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/spice-app.c b/ui/spice-app.c
index 405fb7f9f5..f6c2343213 100644
--- a/ui/spice-app.c
+++ b/ui/spice-app.c
@@ -151,8 +151,8 @@ static void spice_app_display_early_init(DisplayOptions *opts)
     atexit(spice_app_atexit);
 
     if (qemu_name) {
-        app_dir = g_build_filename(g_get_user_runtime_dir(),
-                                   "qemu", qemu_name, NULL);
+        g_autofree char *run = qemu_get_runtime_dir();
+        app_dir = g_build_filename(run, "qemu", qemu_name, NULL);
         if (g_mkdir_with_parents(app_dir, S_IRWXU) < -1) {
             error_report("Failed to create directory %s: %s",
                          app_dir, strerror(errno));
-- 
2.41.0


