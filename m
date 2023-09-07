Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC0C799642
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 06:35:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qepfq-00019x-5l; Sat, 09 Sep 2023 00:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfm-00018m-UA
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:34:18 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfX-0002yd-5W
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:34:17 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40078c4855fso28893615e9.3
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 21:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694234038; x=1694838838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7gLIXJm83In4ehfDWmTTDmbWjCCrqaLS41dVOxq/Wi8=;
 b=AwooZAY5KN6+yvybTYFkO6615XZ+RXeQBs20J21nLGY4WkkR7dwT1IHw83vgcP6T/b
 j9Xw5DZqoAIj1sirUXccKAV+iDbKp6nqZMi641gNC2hV0t16wGjJ+qCHJEm0p7v3QhWA
 F6P03CSQXzXJCKzQuKJnceET/FSqJpLpT03OuTz+fF6qYHuWkiykTdk4XeqOGsgbYcTr
 c8UAyJAJRP5FXBqUyRSarG98LJr25YrG0yUHDeiOZQ9M24uTOO0PNZG3RjEsj5g2FmSr
 qELinQGx38G5INAYuU/oMnKAtPBaWvXbSFCY8nh1jEru6S5uQeMeHnpzWWzm3U6ljRgs
 2Qkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694234038; x=1694838838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7gLIXJm83In4ehfDWmTTDmbWjCCrqaLS41dVOxq/Wi8=;
 b=JeUmC1n1DqNHav9m3Av3VsGhbzFEO0nQBjQWd+OAFCSPoURGW6m/U8GDtZFFx+kf5K
 uFG/Fcuouvg/mwkonwihNGZlJEqrNphw4nEo7OhTwGo7V1rR7phUN9BMw8G+kPoY9i6w
 2cFPFnHTvFJOmit/lU8BzPcxIvS5CBI2JNyjGi5oM8XNlbvH6a/GAtnQMIXAkoIIOWlS
 nUnDZTuVTmuP1FQH4Ogv7CyCwa5a9qQZrZLSdFFukkxT0SvIsjFtrHWDlQcnJDKOjTBL
 egXAgGBZoVLnwgc0W84jgPuJfDfR+gWhavoqYnOy/suC0CsjcuSs/iGNuMthX+nYpwgd
 e/Mg==
X-Gm-Message-State: AOJu0YygBifo72Vh1/rr/WDjS5BYTUsEAQVkYwXnCv/yvvTVl93EhAvl
 huRZE4RkdN3H5LwwNvbuQuP1VWD/l24=
X-Google-Smtp-Source: AGHT+IFYst0OtV655f1J3NPUFBv6Bb3p3bv2jGzkHyH4EiCuZeVVtBOswQ2Upte5+qMSexAMEVIkFQ==
X-Received: by 2002:a05:600c:2946:b0:3fc:7eb:1119 with SMTP id
 n6-20020a05600c294600b003fc07eb1119mr3794466wmd.15.1694234038524; 
 Fri, 08 Sep 2023 21:33:58 -0700 (PDT)
Received: from karim.my.domain ([197.39.120.250])
 by smtp.gmail.com with ESMTPSA id
 d16-20020adff2d0000000b0031981c500aasm3615102wrp.25.2023.09.08.21.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 21:33:58 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 20/23] bsd-user: Implement shm_unlink(2) and shmget(2)
Date: Thu,  7 Sep 2023 09:42:59 +0200
Message-ID: <20230907074302.79234-21-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
References: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/bsd-mem.h            | 23 +++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++++++
 2 files changed, 31 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index a48f919ff2..27d4e7f079 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -281,4 +281,27 @@ static inline abi_long do_bsd_shm_open(abi_ulong arg1, abi_long arg2,
     return ret;
 }
 
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
index 7404b0aa72..52cca2300f 100644
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
2.42.0


