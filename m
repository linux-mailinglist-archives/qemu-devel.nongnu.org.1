Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5EE7A0F23
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:44:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgtAi-0003Fa-25; Thu, 14 Sep 2023 16:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAd-0003As-CG
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:40 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAb-0006Jw-DN
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:38 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40434d284f7so12771915e9.3
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694724155; x=1695328955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QZEj0PmQKtrSTSS1pylbPvyIf7jZoRzyI7RzMk4h4sk=;
 b=VlKMAYanjTDgl3WwRMJELgQXUwTKyELVVYwBcaYRXWSFBFkIbkkQLSmrw3uqjbuxip
 vVwGnMeqE9KUGM/yDnPVfVg1+2WaBMA904QoiUIG71eZ+FQNs/JntMYGd3RUD0TG+eDb
 UPIEZeSkCKVpe9C75/WZ0y+iirJCdu77MKjUpo04QBykR4z5SZB1gX2pMcVU4PCHkD2x
 aSjIaSO7xfKwyKMGR9pc0rYUHaIeZ1ZVFuKzaeR2gJ0kmit3gFW35yUdfME3vrQTSamJ
 NaFa83B8rxhRWCyVhbnwgvp6B7+8wf7bFJzeKhgXndD/KmJKNGgqmCZ8TKPk0Ow8WJkL
 +2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694724155; x=1695328955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QZEj0PmQKtrSTSS1pylbPvyIf7jZoRzyI7RzMk4h4sk=;
 b=QT05EZBLqDtn85CmkT8t1Y7XC0NuYe+B2SrnuaOJoNd3S/gR8Ovoy6CP6tU5ckoOJ5
 O192g3oyeR+Tty6DE6ABuKV1voq4O3tClUJc+OZHR6uEIfbkibyezVRYaiWYOcQoPQWe
 W+tUKkqAScXd4fD4E8TW7m5e3Nnu+boC70KKb5QlCkmun0Yc/ClVUKq/BuXko6tbj9oV
 DTxfnV9N/NK8wrM+Lg87Z4+dPzWtGA1VZD+V8m6mUBA264SsRu1wzuLmuuyZYbytXE5z
 mk974xOMItpNaJTEsDk+2zZEdLQFHnDx6ea+BxSbD6xtE08g53a7srjCZZeN8GTE9z+/
 rCoA==
X-Gm-Message-State: AOJu0YyB568APomvAOoygTse1O0owyjyjd+peEUn+lee1xW8KPK48hWT
 f9mCEj9Llt1HoKbtz1tYDplUaCt5pTU=
X-Google-Smtp-Source: AGHT+IH5DOY7De5C/jJNoV6F6BJedkha8rI7y+IyzQ+qLYHceeD6zX7ksjxOxjByQtbtaadcMyjE1w==
X-Received: by 2002:a5d:5107:0:b0:319:6966:f20e with SMTP id
 s7-20020a5d5107000000b003196966f20emr5239543wrt.71.1694724155383; 
 Thu, 14 Sep 2023 13:42:35 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056000124300b0031f34a395e7sm2661880wrx.45.2023.09.14.13.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:42:35 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Kyle Evans <kevans@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 06/23] bsd-user: Implement shm_rename(2) system call
Date: Thu, 14 Sep 2023 23:40:50 +0300
Message-ID: <20230914204107.23778-7-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
References: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32f.google.com
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

From: Kyle Evans <kevans@FreeBSD.org>

Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-misc.h    | 24 ++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  6 ++++++
 2 files changed, 30 insertions(+)

diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
index 6b424b7078..67e450fe7c 100644
--- a/bsd-user/freebsd/os-misc.h
+++ b/bsd-user/freebsd/os-misc.h
@@ -66,5 +66,29 @@ static inline abi_long do_freebsd_shm_open2(abi_ulong pathptr, abi_ulong flags,
 }
 #endif /* __FreeBSD_version >= 1300048 */
 
+#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300049
+/* shm_rename(2) */
+static inline abi_long do_freebsd_shm_rename(abi_ulong fromptr, abi_ulong toptr,
+        abi_ulong flags)
+{
+    int ret;
+    void *ufrom, *uto;
+
+    ufrom = lock_user_string(fromptr);
+    if (ufrom == NULL) {
+        return -TARGET_EFAULT;
+    }
+    uto = lock_user_string(toptr);
+    if (uto == NULL) {
+        unlock_user(ufrom, fromptr, 0);
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(shm_rename(ufrom, uto, flags));
+    unlock_user(ufrom, fromptr, 0);
+    unlock_user(uto, toptr, 0);
+
+    return ret;
+}
+#endif /* __FreeBSD_version >= 1300049 */
 
 #endif /* OS_MISC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 74146d8c72..ae92a2314c 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -603,6 +603,12 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 #endif
 
+#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300049
+    case TARGET_FREEBSD_NR_shm_rename: /* shm_rename(2) */
+        ret = do_freebsd_shm_rename(arg1, arg2, arg3);
+        break;
+#endif
+
         /*
          * sys{ctl, arch, call}
          */
-- 
2.42.0


