Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEFD7A0ECA
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:10:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsa7-0003cA-J9; Thu, 14 Sep 2023 16:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsa2-0003Na-8v
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:50 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZo-0001d0-Fo
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:41 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-401da71b83cso15464215e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694721873; x=1695326673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NS0DB5hX3kwUPaV4Xfxg8VuoBza3wbu8TrNIf4kL3mQ=;
 b=OWkKlVCmYjzls+5dyfaTyMcrxix0ODDGrWVfXVAC62XvAyKISmuKKZ/v7cjhIW/m6/
 a6mrxhPcqpbaxDyM0c7B9u6BOIU1WhnS+gsoBKO+DA55m3OsyEipaSbM3I4nI3uAweRd
 Hzk+h1dCsrso0PViZv4O3gZG4Xh4R9l2XEvmdX3eRD7M8h6rwunQxygu1wNY0zVUQ3R4
 +7huC9gvsjPC0TNJJd4ji9a6DOiegFSvDhBq/+9OaQ9PEk1R5nUJHMftM1COphtZR36I
 iZBAMzTu1kzKZI24RRFBnvnVkkYI70wRD8DnvmO2bsvWUg2MOlXYxqOyqqSzNJXXIjsY
 emzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694721873; x=1695326673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NS0DB5hX3kwUPaV4Xfxg8VuoBza3wbu8TrNIf4kL3mQ=;
 b=mJoTVEx2Dnx33NZahb6VlC1VjFRmlsYXQaq/MVR82b4tWgoD4/vgzwcjd25mxcuCuX
 2B3ZdhS7+8KU5C51wO62ybKutDBOo4clICQfJMorCQ3+s5vxGHXy5l+1NCyy5oAm/up1
 LcCCLyevTsO0suLSI/alk2IkHqOLp/EICbIyjtMDc5rVtXYJ2/wxSCSU5GekO3bbb64Q
 WSePcl2Vh3peJJoLe2xAZ/hP51Gs32ybMWP8pquIwS3HW0DNGdkXFVBpsiz5H9QuAwfr
 T+uiko9rJubCMMSvA85YZwkxKJ5QMAkOEwXYrIiTAMlG/23wIg21tkLOOJdR4cyadZLp
 C+IA==
X-Gm-Message-State: AOJu0Yz+5w8A5plcH8s6ufs3AKHWLMIQkus9bbNsMkZBoA7MJRgz9b2z
 rl+tsHvXNVqXqTnLmn1h0JgB5XnkYXw=
X-Google-Smtp-Source: AGHT+IH0TXPTbJEY7Yd7+Ij6Oi+o2PgnMj9A9r3rI6o9tqqmo5gHJwea/U917RRRgwcjaFFMAv5w6w==
X-Received: by 2002:a05:600c:3410:b0:404:6ed7:e75a with SMTP id
 y16-20020a05600c341000b004046ed7e75amr2339625wmp.9.1694721872514; 
 Thu, 14 Sep 2023 13:04:32 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a7bc7c7000000b00402bda974ddsm2851130wmk.6.2023.09.14.13.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:04:32 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 20/23] bsd-user: Implement shm_unlink(2) and shmget(2)
Date: Thu, 14 Sep 2023 23:02:39 +0300
Message-ID: <20230914200242.20148-21-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
References: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x329.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/bsd-mem.h            | 23 +++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++++++
 2 files changed, 31 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index f8dc943c23..c362cc07a3 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -282,4 +282,27 @@ static inline abi_long do_bsd_shm_open(abi_ulong arg1, abi_long arg2,
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


