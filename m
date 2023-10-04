Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 217927B7E9B
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:03:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo0ap-0001Wx-0E; Wed, 04 Oct 2023 08:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0Yd-0008Um-Km
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:01:04 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0Yb-00010J-J5
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:00:50 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-32487efc319so2025082f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 05:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696420847; x=1697025647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f0GICmTJrrPt/1QlpCchvnQWSMZXbQVxu/WDlIYHaUw=;
 b=nkBv0Brz1RN7FapVpWhzuWM8V6GSNfbuacwqPnZBgPvFQzLZa75lk6m47VIgbdN6lP
 3j9XojSuwyCJoaRiaQJy4J6BLWtCT6QZ0ql2uKvhVRe/WCPV3S/GSXJWbY1JRnMlZdME
 QVnvq5dh9+MJub9SdfAl4fWN7+k6qFKZa+PuxiWweYBR7Z7ChNuVqCeyLwcjJshK5FbV
 43ojjzFc7roXh9fb9WSeE8Y3aR3aH3AEtpOafLFMhdFhN7pV6Mcqe3GxOt/4yaTHpWjy
 KOn9MPDvpgfk1PaAgYjS9fZh1tnf+cs1drywL6qyCWcZ1wLcCix9oelOU5U/RsfVCfVe
 sNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696420847; x=1697025647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f0GICmTJrrPt/1QlpCchvnQWSMZXbQVxu/WDlIYHaUw=;
 b=Kkj09+6xuKK2a8F06JWSEQ/9Q9TozhM5tGv3KPLtLqH55jK7zhp1tCu1bWzBagV9NW
 fPelRoveaD2JLdqEln9iIDe0H1MCHtyj9uQ39oVkc59FUdDyWNm7RFK5xV/QJ5pZu3Yl
 7rm8NS9v/h1eiHJS33y3dxWFepB3J1lzdFJHCJo0OQEZ7fj583v3TfWkkqNZEqeTDfWm
 o29J34QOr6soqx5Gmfmvr0hoHPoRmLg8P6Omr7HUMCgMh+3ppWD7d6nhVSlFPtLIt/SG
 7IuaFNzl1Y1ccva5XccvMORY1+hjHov97QTbQmTw9Ucm6r6V+HBq916SU91VnE+DqrgE
 VTkQ==
X-Gm-Message-State: AOJu0YwiOZVvAxmk0Y5OAhjlBL2AzVvRm7nUXyhnKm6Zdpq19cc3H3Fc
 sumE3oWBWn6CJ97M7MaReNcNEtOiCd9rbGPha1U=
X-Google-Smtp-Source: AGHT+IHL2TIN4V+wokEd1/Sv4SaIhDM5Y9hsgAMKSI224mQSj1xFlgTYkUI5x2ZhZEzj5ShVR3VXqw==
X-Received: by 2002:a5d:504e:0:b0:320:bbb:5ab1 with SMTP id
 h14-20020a5d504e000000b003200bbb5ab1mr1955791wrt.14.1696420846661; 
 Wed, 04 Oct 2023 05:00:46 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 q4-20020a5d5744000000b003231a0ca5ebsm3817200wrw.49.2023.10.04.05.00.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 05:00:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 04/16] os-posix: Clean up global variable shadowing
Date: Wed,  4 Oct 2023 14:00:07 +0200
Message-ID: <20231004120019.93101-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004120019.93101-1-philmd@linaro.org>
References: <20231004120019.93101-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Fix:

  os-posix.c:103:31: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  bool os_set_runas(const char *optarg)
                                ^
  os-posix.c:176:32: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  void os_set_chroot(const char *optarg)
                                 ^
  /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.h:77:14: note: previous declaration is here
  extern char *optarg;                    /* getopt(3) external variables */
               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/sysemu/os-posix.h |  4 ++--
 os-posix.c                | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/sysemu/os-posix.h b/include/sysemu/os-posix.h
index 6dfdcbb086..dff32ae185 100644
--- a/include/sysemu/os-posix.h
+++ b/include/sysemu/os-posix.h
@@ -49,8 +49,8 @@ void os_setup_signal_handling(void);
 int os_set_daemonize(bool d);
 bool is_daemonized(void);
 void os_daemonize(void);
-bool os_set_runas(const char *optarg);
-void os_set_chroot(const char *optarg);
+bool os_set_runas(const char *user_id);
+void os_set_chroot(const char *path);
 void os_setup_post(void);
 int os_mlock(void);
 
diff --git a/os-posix.c b/os-posix.c
index f90dfda9b0..52ef6990ff 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -94,13 +94,13 @@ static uid_t user_uid = (uid_t)-1; /*   -1      -1        >=0    */
 static gid_t user_gid = (gid_t)-1; /*   -1      -1        >=0    */
 
 /*
- * Prepare to change user ID. optarg can be one of 3 forms:
+ * Prepare to change user ID. user_id can be one of 3 forms:
  *   - a username, in which case user ID will be changed to its uid,
  *     with primary and supplementary groups set up too;
  *   - a numeric uid, in which case only the uid will be set;
  *   - a pair of numeric uid:gid.
  */
-bool os_set_runas(const char *optarg)
+bool os_set_runas(const char *user_id)
 {
     unsigned long lv;
     const char *ep;
@@ -108,14 +108,14 @@ bool os_set_runas(const char *optarg)
     gid_t got_gid;
     int rc;
 
-    user_pwd = getpwnam(optarg);
+    user_pwd = getpwnam(user_id);
     if (user_pwd) {
         user_uid = -1;
         user_gid = -1;
         return true;
     }
 
-    rc = qemu_strtoul(optarg, &ep, 0, &lv);
+    rc = qemu_strtoul(user_id, &ep, 0, &lv);
     got_uid = lv; /* overflow here is ID in C99 */
     if (rc || *ep != ':' || got_uid != lv || got_uid == (uid_t)-1) {
         return false;
@@ -173,9 +173,9 @@ static void change_process_uid(void)
 
 static const char *chroot_dir;
 
-void os_set_chroot(const char *optarg)
+void os_set_chroot(const char *path)
 {
-    chroot_dir = optarg;
+    chroot_dir = path;
 }
 
 static void change_root(void)
-- 
2.41.0


