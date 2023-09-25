Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 978A37ADEBD
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:30:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqHc-0001IP-Qh; Mon, 25 Sep 2023 14:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHa-0001HX-MR
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:10 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHY-0007Ip-SL
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:10 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4053cf48670so58188305e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666365; x=1696271165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c+y7I+dQizuXGTfyfswmuzENo8FjWt4FJ1ZjkqfWpTI=;
 b=Iy9+B+MYfJ74DNwS6RfHU2NigrfxaBUxxvR8YlbBbIXJEW+VL+e354sz06zWZ1hoRa
 xBnNzRGmydncDwXIgulfpizwClUs9pLH+8jfjta7n5DqaoKflKZwq7OihLlgOKo8UdSP
 f5LYObx6w3GKJOsR202wJ5BttTCOgT2PAMKOW0xAjgWpt3a/9n8UNbclZzsWkD3VaKUe
 d8CbKxliIkl88mr5aLG0xsAFhfwlBVhAkyk9L6s+gqIc6KVJS132F/O0Q8SIUCv2gB5d
 Khu1UtIlmRW2uEgec1i77SnytSAF194QzZu0DGqCIWikQVVeuPXiGgnYRUox7lEv6Cjo
 UnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666365; x=1696271165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c+y7I+dQizuXGTfyfswmuzENo8FjWt4FJ1ZjkqfWpTI=;
 b=F4xaaVNUKa90J8KQLclgt1+4AyR/hgHVffVLnVqtAvKHEwONXcqRnmDIXSKoiUVNy3
 UQJosuyu5ox+6b4H0x83ZU0+KUXayge2whDl7v7g7pUp+waDlQ2u6o9kttPDYQfzrD9T
 a7CUwFsSXj9HPta71SKV+KOjrwoAOVYY7Xg4VqQVuPEf2Kc5ko7UkbwYHsORAcD5UCKd
 uNrSPFGoV9euDMzG+Oc6JSuXtyjuZqKjDbVLtBh09tCg58J1PC+zupqDqzIlss9ZikA3
 WSi4h/jZxwFfaEvK+XQHch4IsJiEWgGcD2La1a+PsCOrSv448HqVO7zh7eXy9s4fNhJj
 lHFQ==
X-Gm-Message-State: AOJu0Yy8xyybemsurfwVD/f5I5Jy4xJgCJvENY8xcjp2sr3iG4Pa+fJK
 3NNCnu7LWNXAV1R6/p2jZE4KcBnX5uo=
X-Google-Smtp-Source: AGHT+IEMWf2LlW1Sk+vi05hieRUMEFYp9jGfC0c+gzL3oL/wH9YD47CibgF03nZQ9pX5NdfEHEgo0A==
X-Received: by 2002:a7b:c7ca:0:b0:405:3d04:5f52 with SMTP id
 z10-20020a7bc7ca000000b004053d045f52mr6824524wmk.24.1695666364974; 
 Mon, 25 Sep 2023 11:26:04 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05600c229300b00405953973c3sm2232858wmf.6.2023.09.25.11.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:26:04 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 11/28] bsd-user: Implement getgroups(2) and setgroups(2)
 system calls.
Date: Mon, 25 Sep 2023 21:24:08 +0300
Message-ID: <20230925182425.3163-12-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
References: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32c.google.com
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
Reviewed-by: Warner Losh <imp@bsdimp.com>
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


