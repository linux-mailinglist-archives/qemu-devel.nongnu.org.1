Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF66F7ADF0D
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:36:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqKH-0000AX-Oq; Mon, 25 Sep 2023 14:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqK7-0008FV-4H
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:47 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqK5-0007mR-8N
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:46 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3231df68584so3244989f8f.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666523; x=1696271323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A4cB5XU1wHkue/WY2K/nTLg+N/2Q1Zd6Xjuos7I4bgs=;
 b=Kg0gKN3MCseuytlzYJ6OukZGzSoRK1p4NMtvJZ+m/CgfCZ0g/MqKYIoRQUSpS1EwqP
 LYp4Vrr9hrLkkRn464EMDO4CwxJme49IfLz/BWt+mrzPzk67EwM8vUatznlRn/VkRVJ4
 2pdD+/zQeUSH7suEkbAmdiNWqGI3GGJocIJAnp5+2+OLePxhSU1sTPfCh0IJUED7eZgn
 z7pNmtmv8jUzSJdAzQuUk0DUFtk9TpiFYh4vcQFrB0ZzcXNKpF/O/GhGH2V8aoAt0i6U
 ib6CVSkn1zXdWke39zPZjUkwYkTgd3mixfeOE4DIzaKgWCLB5wh7rBNKA+BSkjNMMwx4
 i4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666523; x=1696271323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A4cB5XU1wHkue/WY2K/nTLg+N/2Q1Zd6Xjuos7I4bgs=;
 b=MK3ZClyK5JBoA7Uutr/AblQnrbjBdTuSqVkc1lYBaeef2u6gFFdjKRnY1Clxk2JZIO
 Qg62Perc3OFhmSR3NoPk6KRydKeNUptfln1xyEkUKjcF4wLB39LQKmZOOISGbnyTMN5s
 oDklTy8cI8F94DCeIJVegA6Rz+kHuIYM16MS+qeXgIvprjj6qPkG3QSD1Yxl4GO4MRQZ
 T5JPwTOUKRP9UOZdyi4yuedDO94N7pGZutvpFXRjHmMgOMoms1Vuku7CLs4CIAR7L+XD
 ayumRxpbikIe6A9Jzda+HDDbdIbsI2deyEORLMC5O4TKkkoK9iNfF2FJJ1X0Xcw9FFJM
 zYtA==
X-Gm-Message-State: AOJu0YyMxGAtj/3Ke0S48a7qZ3F0lx95blFAtX/13hnHO2/YoG3RF4ne
 5k9vYtqb4W9uWuqVMlih9Pzvs9Rax+Y=
X-Google-Smtp-Source: AGHT+IFR0J2J48ckw5mLScDV5RAE8GymDNdnWSsGrSi+2mpKNDpekA9HxHhcQuwqXIexAOobOG4G2A==
X-Received: by 2002:a5d:42ce:0:b0:319:867e:97d7 with SMTP id
 t14-20020a5d42ce000000b00319867e97d7mr6800750wrr.52.1695666518778; 
 Mon, 25 Sep 2023 11:28:38 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 u21-20020adfa195000000b00323293bd023sm3412320wru.6.2023.09.25.11.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:28:38 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Karim Taha <kariem.taha2.7@gmail.com>, Kyle Evans <kevans@FreeBSD.org>
Subject: [PATCH v6 05/23] bsd-user: Implement shm_open2(2) system call
Date: Mon, 25 Sep 2023 21:26:51 +0300
Message-ID: <20230925182709.4834-6-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
References: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x432.google.com
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

Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-misc.h    | 42 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 10 +++++++++
 2 files changed, 52 insertions(+)

diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
index 8436ccb2f7..6b424b7078 100644
--- a/bsd-user/freebsd/os-misc.h
+++ b/bsd-user/freebsd/os-misc.h
@@ -24,5 +24,47 @@
 #include <sys/random.h>
 #include <sched.h>
 
+int shm_open2(const char *path, int flags, mode_t mode, int shmflags,
+    const char *);
+
+#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
+/* shm_open2(2) */
+static inline abi_long do_freebsd_shm_open2(abi_ulong pathptr, abi_ulong flags,
+    abi_long mode, abi_ulong shmflags, abi_ulong nameptr)
+{
+    int ret;
+    void *uname, *upath;
+
+    if (pathptr == (uintptr_t)SHM_ANON) {
+        upath = SHM_ANON;
+    } else {
+        upath = lock_user_string(pathptr);
+        if (upath == NULL) {
+            return -TARGET_EFAULT;
+        }
+    }
+
+    uname = NULL;
+    if (nameptr != 0) {
+        uname = lock_user_string(nameptr);
+        if (uname == NULL) {
+            unlock_user(upath, pathptr, 0);
+            return -TARGET_EFAULT;
+        }
+    }
+    ret = get_errno(shm_open2(upath,
+                target_to_host_bitmask(flags, fcntl_flags_tbl), mode,
+                target_to_host_bitmask(shmflags, shmflag_flags_tbl), uname));
+
+    if (upath != SHM_ANON) {
+        unlock_user(upath, pathptr, 0);
+    }
+    if (uname != NULL) {
+        unlock_user(uname, nameptr, 0);
+    }
+    return ret;
+}
+#endif /* __FreeBSD_version >= 1300048 */
+
 
 #endif /* OS_MISC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index fa60df529e..74146d8c72 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -33,11 +33,13 @@
 #include "signal-common.h"
 #include "user/syscall-trace.h"
 
+/* BSD independent syscall shims */
 #include "bsd-file.h"
 #include "bsd-proc.h"
 
 /* *BSD dependent syscall shims */
 #include "os-stat.h"
+#include "os-misc.h"
 
 /* I/O */
 safe_syscall3(int, open, const char *, path, int, flags, mode_t, mode);
@@ -592,6 +594,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_freebsd_fcntl(arg1, arg2, arg3);
         break;
 
+        /*
+         * Memory management system calls.
+         */
+#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
+    case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
+        ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
+        break;
+#endif
 
         /*
          * sys{ctl, arch, call}
-- 
2.42.0


