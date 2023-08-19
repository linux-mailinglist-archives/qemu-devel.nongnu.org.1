Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ED27818A2
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 11:50:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXIaD-0008IH-7T; Sat, 19 Aug 2023 05:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIaB-0008I1-BF
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:49:23 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIa9-0004R4-2t
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:49:23 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3159d5e409dso1817151f8f.0
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 02:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692438559; x=1693043359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fcEDQVT+54S0bGeOFUY/GJyiJkZ+0XSR0DUTuF9ZCRg=;
 b=JwGoioK7NjCxYbHNyk5lGM13NnWh86LGVZQljTIgyOH/wvGJr5PgsQEwhSqbXox7ta
 KjYGFT2moWchUTmV0L4fXbgBjyER/+mZAFTO78p8Dtrfw/il4VsDVKT3mf+U7TagSKxS
 71RHxDndyh0YRIhjyxZu7IEn1259ykH16GVF9vezbNfiBQ4uy65XRPqg2btY7v3l49NZ
 lBYg6xHeXm0toysQF0fQ0Vqgt/TVYtO7KZrVLNQ1QuN1zYKbB5w1PBBDogBpiKPD8RND
 QNsDjqofKqnEiJNvHYZ160BZM5FzA+fvDO8MiVHe0/aSwgG5iBiVjAcUG83ubLDpto0q
 SYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692438559; x=1693043359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fcEDQVT+54S0bGeOFUY/GJyiJkZ+0XSR0DUTuF9ZCRg=;
 b=Byw7BkCZp48bU7nG9bIZIr7EAROjfWb0UXNuUkoUqiTfGIuPz+/xfmRt7uUH8rQ3mK
 IlPdG8rRiH1/bRvBg6FnAWpHVoamX6v8ZsMw2pVQhddjnrVY8XS/48KvZfhDFHJKVOSZ
 zT4VwKtVRGjOcFhZ5Y1HTPSIGwWnK0A4oMJ2i8ZAioxFsz/0jP36Q9xsLKbuwb4b502n
 +YxWcTvUUhcG4+spdFxMamoH9H2bNRN/kugxReqZoDtclWmgbLnd9bvW1UnCox1NeD9W
 vHUP6ow/KCuS0RMW0DAR9+EaIyXA1sccfpMRYBxQxPk/YjT3NKEvS9a7G1g/3KOUGvCF
 ncWA==
X-Gm-Message-State: AOJu0YxhPCJRWsE3iSjSYyZfbzZzkRVX+u68YTpTvZkYShkOm/d6hzWT
 QtmMbplUp2fDgXAv5ukVhv25gzdt1bU=
X-Google-Smtp-Source: AGHT+IHTOCwN9cLCLqLWd3CzN4SrL0orckUuhaxhWXobtI6MjvS0I1uy5orag+rNX0axxfxNpHaOhA==
X-Received: by 2002:adf:e584:0:b0:319:7908:cf26 with SMTP id
 l4-20020adfe584000000b003197908cf26mr3668779wrm.26.1692438559525; 
 Sat, 19 Aug 2023 02:49:19 -0700 (PDT)
Received: from karim.my.domain ([197.39.34.171])
 by smtp.gmail.com with ESMTPSA id
 o18-20020adfead2000000b003143b14848dsm5617216wrn.102.2023.08.19.02.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 02:49:19 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 15/22] Implement mlock(2), munlock(2), mlockall(2),
 munlockall(2), madvise(2), minherit(2)
Date: Sat, 19 Aug 2023 11:47:59 +0200
Message-Id: <20230819094806.14965-16-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42c.google.com
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
 bsd-user/bsd-mem.h            | 44 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 24 +++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 68d79ac080..f76881519c 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -100,4 +100,48 @@ static inline abi_long do_bsd_msync(abi_long addr, abi_long len, abi_long flags)
     return get_errno(msync(g2h_untagged(addr), len, flags));
 }
 
+/* mlock(2) */
+static inline abi_long do_bsd_mlock(abi_long arg1, abi_long arg2)
+{
+    return get_errno(mlock(g2h_untagged(arg1), arg2));
+}
+
+/* munlock(2) */
+static inline abi_long do_bsd_munlock(abi_long arg1, abi_long arg2)
+{
+    return get_errno(munlock(g2h_untagged(arg1), arg2));
+}
+
+/* mlockall(2) */
+static inline abi_long do_bsd_mlockall(abi_long arg1)
+{
+    return get_errno(mlockall(arg1));
+}
+
+/* munlockall(2) */
+static inline abi_long do_bsd_munlockall(void)
+{
+    return get_errno(munlockall());
+}
+
+/* madvise(2) */
+static inline abi_long do_bsd_madvise(abi_long arg1, abi_long arg2,
+        abi_long arg3)
+{
+    /*
+     * A straight passthrough may not be safe because qemu sometimes
+     * turns private file-backed mapping into anonymous mappings. This
+     * will break MADV_DONTNEED.  This is a hint, so ignoring and returing
+     * success is ok.
+     */
+    return get_errno(0);
+}
+
+/* minherit(2) */
+static inline abi_long do_bsd_minherit(abi_long addr, abi_long len,
+        abi_long inherit)
+{
+    return get_errno(minherit(g2h_untagged(addr), len, inherit));
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 3871b15309..96469f6a63 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -503,6 +503,30 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_msync(arg1, arg2, arg3);
         break;
 
+    case TARGET_FREEBSD_NR_mlock: /* mlock(2) */
+        ret = do_bsd_mlock(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_munlock: /* munlock(2) */
+        ret = do_bsd_munlock(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_mlockall: /* mlockall(2) */
+        ret = do_bsd_mlockall(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_munlockall: /* munlockall(2) */
+        ret = do_bsd_munlockall();
+        break;
+
+    case TARGET_FREEBSD_NR_madvise: /* madvise(2) */
+        ret = do_bsd_madvise(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_minherit: /* minherit(2) */
+        ret = do_bsd_minherit(arg1, arg2, arg3);
+        break;
+
 #if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
     case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
         ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
-- 
2.40.0


