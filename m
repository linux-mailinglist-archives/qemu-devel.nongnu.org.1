Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F0F7818AD
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 11:51:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXIaX-0000sU-G4; Sat, 19 Aug 2023 05:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIaV-0000h6-E9
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:49:43 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIaR-0004UU-R7
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:49:42 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31ade53706fso1524293f8f.3
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 02:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692438578; x=1693043378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ymeuouct4OUpqNX5h4xyNSgJQY9GeX0quaUrsnYgBPg=;
 b=IYAKsSR57gtDP754c9+91GxabLSoYCx+i7j7juWQO+8JOBSs7l5VxwnAgnJZmEgB8M
 rEzY9GYB6aIGHKQQ+Dy/ULPKvQmuYE+0UbucGqZtTZHA4d1zMROrjndyfPNS0bzN3Hsb
 L4f9IKj1RyllFBO+cCVaonTYQFfsuEmB0mKHwcdmLfwp/MqC6UiiKRM6PsHL595yVd6R
 5rGEKxTjT9cjXFn4yWIzxO43R04tY7q9xEaOvYOUy65P4aQqAZi2TzElNMj8OWmamiYI
 UpXjJWyGQhW+wqCUK4HMDvdOjgwkOLCdAQm5ZUOaxjgJNr2vAxCDebkyRq91K+lyuuXe
 1S/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692438578; x=1693043378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ymeuouct4OUpqNX5h4xyNSgJQY9GeX0quaUrsnYgBPg=;
 b=WZbkKyH9dVEC/rGo0rgWMtCBoadzE2jtQprbdvmB9N97osCixaw9sXL3fKDlwTm9kL
 i4RM2ItMGzoIGkTmY+6UX79c0gQ1/FljdjhPcvG1rVaqQgSWieDsxxUrg3v5NEmD5oOx
 7Lcc9r2WWIelX0Me8BEmiBkzdY1loxkLSOX5pqIVH76uiHfSTPyyHXmVopl7f9HG3Em8
 5JDX5IfIYc5vzeN4zBmy4tneyNSMM8FOpaGSOuY9vJIWfxszE6wnQbEVbF6LIyQi8e1F
 wj1efVe7ZwZrki3VyV1pI87G1TP85x3z0HBOb2GdxM19JQBn1bHxB3pauxrieKkTijrR
 +XyA==
X-Gm-Message-State: AOJu0YyDs5tdUzPRsCg5goWt7flhkHcpXboPLQ65lPA7ofncTygFOjOw
 0dgEw1Jzaq9UZ7m69N9v7lQbZMhcSyE=
X-Google-Smtp-Source: AGHT+IFtBTweKmwKrNw2ThYz7l9bKnqK4S+PxnarHvVV4VHFlOCszzURlngy+/QgzoessL4Y3FKMAg==
X-Received: by 2002:a5d:6087:0:b0:317:6816:578c with SMTP id
 w7-20020a5d6087000000b003176816578cmr1154889wrt.5.1692438578104; 
 Sat, 19 Aug 2023 02:49:38 -0700 (PDT)
Received: from karim.my.domain ([197.39.34.171])
 by smtp.gmail.com with ESMTPSA id
 o18-20020adfead2000000b003143b14848dsm5617216wrn.102.2023.08.19.02.49.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 02:49:37 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 19/22] Implement shm_unlink(2) and shmget(2)
Date: Sat, 19 Aug 2023 11:48:03 +0200
Message-Id: <20230819094806.14965-20-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x435.google.com
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
 bsd-user/bsd-mem.h            | 23 +++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++++++
 2 files changed, 31 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 013b82f49a..3d91d3eb30 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -279,4 +279,27 @@ static inline abi_long do_bsd_shm_open(abi_ulong arg1, abi_long arg2,
 }
 #undef SHM_PATH
 
+/* shm_unlink(2) */
+static inline abi_long do_bsd_shm_unlink(abi_ulong arg1)
+{
+    int ret;
+    void *p;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(shm_unlink(p)); /* XXX path(p)? */
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* shmget(2) */
+static inline abi_long do_bsd_shmget(abi_long arg1, abi_ulong arg2,
+        abi_long arg3)
+{
+    return get_errno(shmget(arg1, arg2, arg3));
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 2d15255c20..a7db78b9b4 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -547,6 +547,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 #endif
 
+    case TARGET_FREEBSD_NR_shm_unlink: /* shm_unlink(2) */
+        ret = do_bsd_shm_unlink(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_shmget: /* shmget(2) */
+        ret = do_bsd_shmget(arg1, arg2, arg3);
+        break;
+
         /*
          * Misc
          */
-- 
2.40.0


