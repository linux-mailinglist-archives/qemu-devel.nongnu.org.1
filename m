Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD50A7818AB
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 11:51:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXIaQ-0000XL-GY; Sat, 19 Aug 2023 05:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIaO-0000TR-It
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:49:36 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIaM-0004TM-ET
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:49:36 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31adc5c899fso1581653f8f.2
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 02:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692438573; x=1693043373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S6L1tFcBps5w1zt5VqJiuC7jg5RBPQJ0EofpJuqqQ7Q=;
 b=HIgVN+ujB87pdyUgCvADy/ALvirOe3yHVnhiJBdq2zBLoQIGQ/v2YpmssyaY1U+gr6
 i6L59AC3ITOaHYxyPuARCFVjVshwr4EwDj7WAIpdXTS7b77CrefwBxO7sm//ECPUGu+I
 5GWBHJN4a3qdb3bwKDdvDz8KSIdb+7vyKrjzE5JkeHV0+ONxrLvIKJkYh+ww5S64X0oi
 CgZsl4gMdtm4lzpakA7/AtIeHISuaUULBwgABSn/vk9ykbHWZpafcLduqCf+RrkgMBCT
 O+/xifPrTQVS5+dNvulxVkpH2oMCbVJorH4VcTo3HsqgxT5oKY1G1GHvW9p+CnqoEUDm
 FgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692438573; x=1693043373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S6L1tFcBps5w1zt5VqJiuC7jg5RBPQJ0EofpJuqqQ7Q=;
 b=PTHofSMFtWrWCO9fjNi1yi1UgQZZ5p39oHmpg4lbfJpB/lF9spUJVBMmCHMBqUNXIO
 xZVTCkKC8MPJ6ewNBU6R334J6my3asKuUq/4Dk3e0JPDPJpM1Jl++IEcjWZU2k+5CnfV
 1PVai4diJkyVCgqe1l+pJv2Xk5ZoZCpF0PRucf+c1POyqR7IYCoz6+sN4yv24QJLkT4M
 TxZNRlVyIsDsoUzZJXHt3vYWdTmaJNIHh4AmVALaC/6j1wNciJ3G9D3lS/NHxhIhqBUj
 +NYNpqWfTMeIM2XuAarjGd59sU/4A9XTQZ7Iyv9Y/14bzTlW8gliGO0K+NAs5VqyvpgY
 fJiw==
X-Gm-Message-State: AOJu0YzTWopvaMKRy5BCoiySUH5jA82mir8rPibooMFQcTZcj37WYNpg
 Bggd6kp+oZY3zLzr/lEYu9uH+jJxXI4=
X-Google-Smtp-Source: AGHT+IERYvLlTEaKUvRexFzMQRNKZZuLVX9DctE8BrTaCMHDugGbkBTUzSQ/hSZt+vCn+qp3O/XCPg==
X-Received: by 2002:a5d:6a43:0:b0:317:f7b0:85f with SMTP id
 t3-20020a5d6a43000000b00317f7b0085fmr1196155wrw.33.1692438572861; 
 Sat, 19 Aug 2023 02:49:32 -0700 (PDT)
Received: from karim.my.domain ([197.39.34.171])
 by smtp.gmail.com with ESMTPSA id
 o18-20020adfead2000000b003143b14848dsm5617216wrn.102.2023.08.19.02.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 02:49:32 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Kyle Evans <kevans@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 18/22] Implement shm_open(2)
Date: Sat, 19 Aug 2023 11:48:02 +0200
Message-Id: <20230819094806.14965-19-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x436.google.com
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

Co-authored-by: Kyle Evans <kevans@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.h            | 27 +++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 31 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 6f33148eb7..013b82f49a 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -252,4 +252,31 @@ static inline abi_long do_obreak(abi_ulong new_brk)
     return bsd_target_brk;
 }
 
+/* shm_open(2) */
+static inline abi_long do_bsd_shm_open(abi_ulong arg1, abi_long arg2,
+        abi_long arg3)
+{
+    int ret;
+    void *p;
+
+#define SHM_PATH(p) ((p) == SHM_ANON ? (p) : path(p))
+    if (arg1 == (uintptr_t)SHM_ANON) {
+        p = SHM_ANON;
+    } else {
+        p = lock_user_string(arg1);
+        if (p == NULL) {
+            return -TARGET_EFAULT;
+        }
+    }
+    ret = get_errno(shm_open(SHM_PATH(p),
+                target_to_host_bitmask(arg2, fcntl_flags_tbl), arg3));
+
+    if (p != SHM_ANON) {
+        unlock_user(p, arg1, 0);
+    }
+
+    return ret;
+}
+#undef SHM_PATH
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 1b9dca9164..2d15255c20 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -531,6 +531,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_mincore(arg1, arg2, arg3);
         break;
 
+    case TARGET_FREEBSD_NR_freebsd12_shm_open: /* shm_open(2) */
+        ret = do_bsd_shm_open(arg1, arg2, arg3);
+        break;
+
 #if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
     case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
         ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
-- 
2.40.0


