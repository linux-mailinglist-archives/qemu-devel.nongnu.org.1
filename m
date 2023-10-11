Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 095987C5075
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 12:44:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqWgn-0008Ez-W3; Wed, 11 Oct 2023 06:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWgk-0008CS-WD
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:43:39 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWgi-0007fE-8m
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:43:38 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32483535e51so6424182f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 03:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697021013; x=1697625813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UzxurWFBanGJDGa17SzO9nkXVLYIxRz6NOFY5btFFbY=;
 b=YMm7N0b0Y/Wip/32VNVUBE58AJWrlJ8nRx9elgJIqICF/tYRqs4pjWN5aa9O6gDWOn
 yeGdUdMqt3K51vWvjf88ZAjwTKrXoEqOqHWSsE54BwHBnMiuKd1G/7+bLVLZaSwBVZi5
 nrV1EZzdbNkyRfIuEoO5h+1RI8770wivX3vuLcX7AD9IoQ9GGk8MOhd9xiEfcBLErr0R
 n567WyjCuHf+TpACqQw0tYrHAYc4sRBF0z6IlPizyvNeIkQprgMps+Id3VZOQuJuxTER
 6o+Y8d++8MDsLDCdMuS1LJN9XWqAMkdcfSCLGjbjZOl+vyKES9NXapRRCV7e8M6UghQK
 jk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697021013; x=1697625813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UzxurWFBanGJDGa17SzO9nkXVLYIxRz6NOFY5btFFbY=;
 b=qUNVyFxbslaUdbjRCJE2ZAZ83nMFiJrOT86hI1rMaGjfeMt7BddCkzEXtYbFJsT67V
 g94ExVN4Yd18LJ1UU0Qfj2Tzi6p4DWeculSjfQtZgQRs7EWMeG7SfzyYgY1kGPsfRGxa
 YqKBdmt15ullUM948IPiKE0810TDbIzOVfotYzeRzz6B41yABAgpxnLY6UeUnrRZs5fy
 cttdiGFRKBPLIY0lwh2/XlxQLPElsdIlJ0w3Od+n6DDMK0VXeWnXt0pVHcy4zGraiPvG
 Qpy3i6clEHptzDkPkQZ2B0DqxqhSfGCqfd1sVeiPx4EXSnGz9yUudzlGk2A6QVvF/eqX
 Eq+A==
X-Gm-Message-State: AOJu0Yz4RIZKRH14eIhamKy6v94w3XKUeNfiX4gJukBq5IelJrD0aa2k
 9F/DMmcQFCtgBY3LIOWB8py46g==
X-Google-Smtp-Source: AGHT+IEbtP9Arab0E8K3iBUteRok0NShKk49HN3ETQ6pDmgsEBV8G33oAkrly8k5VCJAmfiIx9OdtA==
X-Received: by 2002:adf:e607:0:b0:31f:b9ea:76c with SMTP id
 p7-20020adfe607000000b0031fb9ea076cmr17169987wrm.48.1697021012784; 
 Wed, 11 Oct 2023 03:43:32 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a5d68c4000000b003232f167df5sm15134109wrw.108.2023.10.11.03.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:43:31 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B950A1FFCF;
 Wed, 11 Oct 2023 11:33:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 24/25] contrib/plugins: fix coverity warning in lockstep
Date: Wed, 11 Oct 2023 11:33:28 +0100
Message-Id: <20231011103329.670525-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011103329.670525-1-alex.bennee@linaro.org>
References: <20231011103329.670525-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Coverity complains that e don't check for a truncation when copying in
the path. Bail if we can't copy the whole path into sockaddr.

Fixes: CID 1519045
Fixes: CID 1519046
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231009164104.369749-25-alex.bennee@linaro.org>

diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index 682b11feb2..f0cb8792c6 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -245,6 +245,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 static bool setup_socket(const char *path)
 {
     struct sockaddr_un sockaddr;
+    const gsize pathlen = sizeof(sockaddr.sun_path) - 1;
     int fd;
 
     fd = socket(AF_UNIX, SOCK_STREAM, 0);
@@ -254,7 +255,11 @@ static bool setup_socket(const char *path)
     }
 
     sockaddr.sun_family = AF_UNIX;
-    g_strlcpy(sockaddr.sun_path, path, sizeof(sockaddr.sun_path) - 1);
+    if (g_strlcpy(sockaddr.sun_path, path, pathlen) >= pathlen) {
+        perror("bad path");
+        return false;
+    }
+
     if (bind(fd, (struct sockaddr *)&sockaddr, sizeof(sockaddr)) < 0) {
         perror("bind socket");
         close(fd);
@@ -287,6 +292,7 @@ static bool connect_socket(const char *path)
 {
     int fd;
     struct sockaddr_un sockaddr;
+    const gsize pathlen = sizeof(sockaddr.sun_path) - 1;
 
     fd = socket(AF_UNIX, SOCK_STREAM, 0);
     if (fd < 0) {
@@ -295,7 +301,10 @@ static bool connect_socket(const char *path)
     }
 
     sockaddr.sun_family = AF_UNIX;
-    g_strlcpy(sockaddr.sun_path, path, sizeof(sockaddr.sun_path) - 1);
+    if (g_strlcpy(sockaddr.sun_path, path, pathlen) >= pathlen) {
+        perror("bad path");
+        return false;
+    }
 
     if (connect(fd, (struct sockaddr *)&sockaddr, sizeof(sockaddr)) < 0) {
         perror("failed to connect");
-- 
2.39.2


