Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 779B278189B
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 11:50:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXIah-0001zG-2u; Sat, 19 Aug 2023 05:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIaf-0001vV-Lc
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:49:53 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIad-0004Wk-Fk
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:49:53 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fe32016bc8so15932025e9.1
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 02:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692438590; x=1693043390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rMb0rESt2U29a5WFBc2T+2BXqQBr9UBe6ZX/BkuOLjo=;
 b=eB9rYnXKHWzAwpyY+QlczWG0jD4efOMY2NFbVl4r1qrWUBai4+1xKwUeOlPqquN9nV
 jeioLeNDR3GOxTFBAR710KlcsyWJb/EIOl2n534Bc7oJu+s9BGle5clp6ZmVVco+zJWb
 Gfs6H89wzD+olAdIuapsV9mydg/uV5hrMBh9vEK7D+lrF4U8N4OQyw8kSiUjWeDErmWz
 LYCyRK5YLAB+CUGRzsjroD60K8ar5ma4MG0jwPL74wmKiOjFjZMAsUIDoomFniVA+lxT
 lgLfRkqOfrXL7lvOJ9D6xQoYDjV2i7ZydPaUw4hVJSjbVBYxNl1ypMjKGQMKQuelvYks
 y5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692438590; x=1693043390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rMb0rESt2U29a5WFBc2T+2BXqQBr9UBe6ZX/BkuOLjo=;
 b=hfzFUeT9aO+t3SyPfPmgi4STLe+RezSDlY1xJhyu3Y7tAvMgsSRMWx0qNIL3DLF/CK
 /BGI0+7nmUqNK3z2auX/A8sFNgoy4qIukEIIdqSeOvpg/9WVZh4+Nm14CwNPPdYaoQZh
 05/C/ipHOQtFmDoswGNrR4KBg8TcKoDgVSVJStp7sqSsbWX7D6f2z2x+bNPsLxFZE+lj
 sbgVB2Dj0l7oFUSQyGdE0Yv2yH6art0y+BSce9kW0G2locEgu0Z+iman+nvKCurBDkXe
 A5Qto9Qi6EU6MeiGkOGBKib7VsLDrXyRMIgQfZPHqWxa0yp3Xp4nPacrrnv2aR0uB+1E
 wCfg==
X-Gm-Message-State: AOJu0Yxumi79UD4z7CYSq8B9U8XvWUU+wT6KH04RV/jwTdOLNBz95u6u
 vqi0KoiK6uYc9jzHc/Z4cZXZIOAA2rY=
X-Google-Smtp-Source: AGHT+IHPaqtP2Lnvp8PdFBXTA/NHw5BxsjTH7anU8/5AVDyuMG1xRgs7uPT3bdK2BV8pLBobGgLalQ==
X-Received: by 2002:a5d:4c4a:0:b0:319:7aa5:b880 with SMTP id
 n10-20020a5d4c4a000000b003197aa5b880mr1059482wrt.48.1692438589993; 
 Sat, 19 Aug 2023 02:49:49 -0700 (PDT)
Received: from karim.my.domain ([197.39.34.171])
 by smtp.gmail.com with ESMTPSA id
 o18-20020adfead2000000b003143b14848dsm5617216wrn.102.2023.08.19.02.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 02:49:49 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 22/22] Add stubs for vadvise(), sbrk() and sstk()
Date: Sat, 19 Aug 2023 11:48:06 +0200
Message-Id: <20230819094806.14965-23-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32e.google.com
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

The above system calls are not supported by qemu.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.h            | 21 +++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 12 ++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index f737b94885..274178bef7 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -407,4 +407,25 @@ static inline abi_long do_bsd_shmdt(abi_ulong shmaddr)
     return get_errno(shmdt(g2h_untagged(shmaddr)));
 }
 
+static inline abi_long do_bsd_vadvise(void)
+{
+    /* See sys_ovadvise() in vm_unix.c */
+    qemu_log("qemu: Unsupported syscall vadvise()\n");
+    return -TARGET_ENOSYS;
+}
+
+static inline abi_long do_bsd_sbrk(void)
+{
+    /* see sys_sbrk() in vm_mmap.c */
+    qemu_log("qemu: Unsupported syscall sbrk()\n");
+    return -TARGET_ENOSYS;
+}
+
+static inline abi_long do_bsd_sstk(void)
+{
+    /* see sys_sstk() in vm_mmap.c */
+    qemu_log("qemu: Unsupported syscall sstk()\n");
+    return -TARGET_ENOSYS;
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index f76bc1eb38..cf4b894fee 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -567,6 +567,18 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_shmdt(arg1);
         break;
 
+    case TARGET_FREEBSD_NR_freebsd11_vadvise:
+        ret = do_bsd_vadvise();
+        break;
+
+    case TARGET_FREEBSD_NR_sbrk:
+        ret = do_bsd_sbrk();
+        break;
+
+    case TARGET_FREEBSD_NR_sstk:
+        ret = do_bsd_sstk();
+        break;
+
         /*
          * Misc
          */
-- 
2.40.0


