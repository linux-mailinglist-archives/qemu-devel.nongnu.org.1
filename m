Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 660DC7A3E89
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 00:28:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi0Bm-0006XZ-4f; Sun, 17 Sep 2023 18:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Bj-0006WW-Sw
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:23 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Bi-0002vp-8W
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:23 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3200257b9a3so1084535f8f.3
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 15:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694989461; x=1695594261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=30VV4yt2ro3MiuAoHh+3abDe9zHvykVDAdOKnvHSpvs=;
 b=ngy515Zm8ReEIoRMP2FmdP63vL05ntibuuXRfEqQoO5tHfWzG5K8Jq6rsy+oF+4Kgd
 9ke7fc2u4PuhjSHUvoT7gXmPLK3MZw/55tG2zpZKgKmN9LTIiQscqNROm5Nww6nDU0do
 G0dYOljVHA6JoNTm2VZNqXSQAySkefQB6FKks22OFTKkJDjmmOmkvoXFoViWY59dmgFr
 mXZhZMb+v/mwKGO9pmZbeg8rNdHr2rbpZhcc85UywTa2ja6hV99u/AqrEx9XZA+xwhhd
 5tPuTHvWEfmiYRtEOSrrU8YgnTzaL9ModiHEdtSR494K9Ss/GpCUL9vxjvk46DnOBnlf
 JQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694989461; x=1695594261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=30VV4yt2ro3MiuAoHh+3abDe9zHvykVDAdOKnvHSpvs=;
 b=u77XZcaVWZH2luIxYAm67+xO0nxfTYzeAg/v8h6NPDzmhOiIx9zzAEb8ACIZxiR2D1
 ZIryKyTZoZK25sPYaXmZNK/Fl29rFE6iTHX0XUm/jboH9clsFxMXFmKGsKf17yrkqkvm
 wvI6rEVtgb9kSaG0J6h9mMRAgn3VEvJYFiD66mP220RaF4mm5o+V+NBJ5fi3gKFKBu8I
 pCeHUBUmKefv1DHO6QngyzpU4rPcljBaxC2/uBvZg6YBptyKPw+THwxY23t12+BWHHJw
 LX6c13IAt1zaDE4eIsbo8N2qQzAVOnZvTtMH3o6sJtFo+5VXcrFU49jiI9C41KUQw0WE
 dUSw==
X-Gm-Message-State: AOJu0YzK7YxFsTlEoGAUOmZwfXvT3c19zUbGfZHsGAx6vZGv16oURolA
 Nmz08W7X49jUFZq6pcFIFXUYTKWBxO0=
X-Google-Smtp-Source: AGHT+IETfchPFROfmlftHvBGdZw7dIP/ZZi8GLxosMoZ8F7jo0fMDZz8ZPa+ifiS/bsC/yH4CahOvw==
X-Received: by 2002:a05:6000:1192:b0:317:636b:fcb1 with SMTP id
 g18-20020a056000119200b00317636bfcb1mr6653622wrx.27.1694989460671; 
 Sun, 17 Sep 2023 15:24:20 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 f7-20020adff987000000b0031c8a43712asm10652527wrr.69.2023.09.17.15.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 15:24:20 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 11/28] bsd-user: Implement getgroups(2) and setgroups(2)
 system calls.
Date: Mon, 18 Sep 2023 01:22:28 +0300
Message-ID: <20230917222246.1921-12-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
References: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42f.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-proc.h           | 44 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  9 +++++++
 2 files changed, 53 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index b6225e520e..7b25aa1982 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -41,4 +41,48 @@ static inline abi_long do_bsd_exit(void *cpu_env, abi_long arg1)
     return 0;
 }
 
+/* getgroups(2) */
+static inline abi_long do_bsd_getgroups(abi_long gidsetsize, abi_long arg2)
+{
+    abi_long ret;
+    uint32_t *target_grouplist;
+    g_autofree gid_t *grouplist;
+    int i;
+
+    grouplist = g_try_new(gid_t, gidsetsize);
+    ret = get_errno(getgroups(gidsetsize, grouplist));
+    if (gidsetsize != 0) {
+        if (!is_error(ret)) {
+            target_grouplist = lock_user(VERIFY_WRITE, arg2, gidsetsize * 2, 0);
+            if (!target_grouplist) {
+                return -TARGET_EFAULT;
+            }
+            for (i = 0; i < ret; i++) {
+                target_grouplist[i] = tswap32(grouplist[i]);
+            }
+            unlock_user(target_grouplist, arg2, gidsetsize * 2);
+        }
+    }
+    return ret;
+}
+
+/* setgroups(2) */
+static inline abi_long do_bsd_setgroups(abi_long gidsetsize, abi_long arg2)
+{
+    uint32_t *target_grouplist;
+    g_autofree gid_t *grouplist;
+    int i;
+
+    grouplist = g_try_new(gid_t, gidsetsize);
+    target_grouplist = lock_user(VERIFY_READ, arg2, gidsetsize * 2, 1);
+    if (!target_grouplist) {
+        return -TARGET_EFAULT;
+    }
+    for (i = 0; i < gidsetsize; i++) {
+        grouplist[i] = tswap32(target_grouplist[i]);
+    }
+    unlock_user(target_grouplist, arg2, 0);
+    return get_errno(setgroups(gidsetsize, grouplist));
+}
+
 #endif /* !BSD_PROC_H_ */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index fa60df529e..535e6287bd 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -223,6 +223,15 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_exit(cpu_env, arg1);
         break;
 
+    case TARGET_FREEBSD_NR_getgroups: /* getgroups(2) */
+        ret = do_bsd_getgroups(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_setgroups: /* setgroups(2) */
+        ret = do_bsd_setgroups(arg1, arg2);
+        break;
+
+
         /*
          * File system calls.
          */
-- 
2.42.0


