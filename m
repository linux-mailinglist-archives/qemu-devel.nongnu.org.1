Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E94E7C63DB
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:17:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn54-0007aH-JD; Thu, 12 Oct 2023 00:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn4y-0007F9-88
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:45 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn4w-0002no-MF
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:44 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-692eed30152so438494b3a.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697084020; x=1697688820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZSF9QAZgi8Qs5AcjmTJpC1uYejEYXhrl+o5RUlkuh58=;
 b=Oif7tQAA+1f0RNPET63lJcIlbPlcxSeo0MLaK+1jMYbi1RDJAZpjXVUY2HH7Se5nkp
 CDawh3H+wgw6HCOIalXRLq4OKeCX0yCiTvpTs9L2+eSN52D2nScyBwrFvRNpoZRFMXOb
 8mDIfW/alS+fXr297Ie5+yAWczw/cFE9g4adFOfP9tqGJpiWCpmEHo591N7JwSl1kmve
 Bsy72KpE4KREvJDmQJ1nUOsbSYS/XMur7N83t19I1KWoLaFBO2/iTd1jPsGURKCfVfCy
 9ftdvPZDtRPQ+55vLy+3Mr0zFJumMZF+Ykb2umfwZTO3VMzqhHc2VIHHTJn3K/sryvW3
 QKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697084020; x=1697688820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZSF9QAZgi8Qs5AcjmTJpC1uYejEYXhrl+o5RUlkuh58=;
 b=CQwlYgKMu5BxGDVXHuLT3tl8XvfSI4kndEsKcp9GjGienJ9Yd4d9K2tB4VKdopLG2A
 eXrHX3BOFdIN3VUfyxYsix2nWg3sturJWWpTeSiB07CuA8/RSA+jFEZdyAQnb47qjF1v
 XSApG8HMI0kMKkVxTrYFbNiWv2+WuVH56ME4TQKY5iOTh9n+azuVKvelIp0m78OYr1bR
 +fK/Y2KO50HvQgn11T3mV2C171hxK2wrUd3YJ6sfd7FzsWJ1AAzdCbrrvPA/kN1vgY5X
 AHkrawjGRAw5M31cUNI8oDzv1nSkHNk9m+hBjRez1w7bEbyM+VD8Tbe94elEoo0zTj98
 +7eQ==
X-Gm-Message-State: AOJu0Yz6OtranlLT1+elLydxaQt6mPHOulC1DFfL/UrPrUljuhqSt5u/
 9htwGISfHgaHAhZrz4Iz0hrgcbT4nVSR3Q==
X-Google-Smtp-Source: AGHT+IG+sDB/8KMlydqAYpx/pyD5qW/KODA2kDl+fh82BLasLWPEGhQ5xeatIKrP/WXb7q5FFXjQsQ==
X-Received: by 2002:a05:6a20:4405:b0:16b:9f9b:5764 with SMTP id
 ce5-20020a056a20440500b0016b9f9b5764mr20751579pzb.54.1697084020158; 
 Wed, 11 Oct 2023 21:13:40 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:13:39 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 45/54] softmmu: pass the main loop status to gdb "Wxx" packet
Date: Thu, 12 Oct 2023 14:10:42 +1000
Message-ID: <20231012041051.2572507-46-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Clément Chigot <chigot@adacore.com>

gdb_exit function aims to close gdb sessions and sends the exit code of
the current execution. It's being called by qemu_cleanup once the main
loop is over.
Until now, the exit code sent was always 0. Now that hardware can
shutdown this main loop with custom exit codes, these codes must be
transfered to gdb as well.

Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231003071427.188697-3-chigot@adacore.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/sysemu/sysemu.h | 2 +-
 system/main.c           | 2 +-
 system/runstate.c       | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 25be2a692e..73a37949c2 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -101,7 +101,7 @@ bool defaults_enabled(void);
 
 void qemu_init(int argc, char **argv);
 int qemu_main_loop(void);
-void qemu_cleanup(void);
+void qemu_cleanup(int);
 
 extern QemuOptsList qemu_legacy_drive_opts;
 extern QemuOptsList qemu_common_drive_opts;
diff --git a/system/main.c b/system/main.c
index 694388bd7f..9b91d21ea8 100644
--- a/system/main.c
+++ b/system/main.c
@@ -35,7 +35,7 @@ int qemu_default_main(void)
     int status;
 
     status = qemu_main_loop();
-    qemu_cleanup();
+    qemu_cleanup(status);
 
     return status;
 }
diff --git a/system/runstate.c b/system/runstate.c
index 363a5ea8dd..ea9d6c2a32 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -834,9 +834,9 @@ void qemu_init_subsystems(void)
 }
 
 
-void qemu_cleanup(void)
+void qemu_cleanup(int status)
 {
-    gdb_exit(0);
+    gdb_exit(status);
 
     /*
      * cleaning up the migration object cancels any existing migration
-- 
2.41.0


