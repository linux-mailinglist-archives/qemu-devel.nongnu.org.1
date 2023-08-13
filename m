Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A49C77A6C1
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:14:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBpw-0008GF-8w; Sun, 13 Aug 2023 10:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpc-0008Av-7b
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:38 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpa-0000sF-3R
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:35 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbea14706eso31527405e9.2
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935952; x=1692540752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tytNoWwd4l2oWWKY6hZbDrOZveBwceyNmveWX7P6eu0=;
 b=qrHULHUjop1hD9soqGB53Y64bUXC7X0Nl5WhA3CdFAhsUDHnlnwKxu4G8vUEQXnFn+
 a9MK0W+pd4jW5yMhv8mDr/WlaPlkO/OQ7r23Miccf0+tEYB+kUFILH+6gISnctYBTPKi
 6rlY6r0X4a0JoMDq3vONezFbnkv6eckJknqBA9iQfqojXU/yXN6ktejluwxORXDtYsP+
 cx2UhNJs1ygNuZNTWoi+Ya7Qq+TFJX8UFntdE5lxTLm680tjZ2K8kK2kEhCvavIpK/3x
 gGmxJJDn4Yl2JM5sqlqiQZ8oKG56ZNWwANRUgIUkQrla+bs+7pHGCKjk5GEsQ7/+l8oK
 EC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935952; x=1692540752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tytNoWwd4l2oWWKY6hZbDrOZveBwceyNmveWX7P6eu0=;
 b=Cwm4KB3V2QQbA6E+eGzEWbQnXbnwPIdiOKWKbML6pm+1Ir1TQjwMr89MvP7gDvc+GS
 nnorJxB26rm5fRkc0FxTFcyYrIp3YWYaHNSjF0+ywJfvaEacnp4dhnLYfGWLQNSXr/U+
 IY1bAkj1wAFXGLrm0cl+k6eAI6DAcncUyUKB0dC6LUS3megsrN5n5dLjedy4g1GJZhLU
 3VeJXdF0x0GsFG1aUUFzhl+sU1NDupN74RmZv7SKDi0ywd/yb1SLHedFtG1Nd6Glk2Qe
 /P2SvitxtlOnYAfM1cqVGTx1C8STy4ACqwoCWIXsgm+H1MIJdmVR5kUxNDJhm46xpHyR
 qXtw==
X-Gm-Message-State: AOJu0YzHd0rtQWqOcEaN5ciDsd8idvIfbnEmSiwNji3PFz7RB8vJv7ag
 YX3G841+ReLFaBnqspjAJM6/X+VpR+w=
X-Google-Smtp-Source: AGHT+IEBpybv657wgdmmLaFcBYukxRTqJOnXjlqX8/9kDVLkFG7xYAHZ74xKD7l3O3MP0FJLCP1Cng==
X-Received: by 2002:a5d:4a47:0:b0:317:3f64:4901 with SMTP id
 v7-20020a5d4a47000000b003173f644901mr4719807wrs.41.1691935951682; 
 Sun, 13 Aug 2023 07:12:31 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:31 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 19/32] Implement stat related syscalls
Date: Sun, 13 Aug 2023 05:10:00 +0200
Message-Id: <20230813031013.1743-20-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Implement the following syscalls:
statfs(2)
fstatfs(2)
getfsstat(2)

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-stat.h | 69 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index 935663c071..9492c93c55 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -210,4 +210,73 @@ static inline abi_long do_freebsd_fhstatfs(abi_ulong target_fhp_addr,
     return h2t_freebsd_statfs(target_stfs_addr, &host_stfs);
 }
 
+/* statfs(2) */
+static inline abi_long do_freebsd_statfs(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    void *p;
+    struct statfs host_stfs;
+
+    LOCK_PATH(p, arg1);
+    ret = get_errno(statfs(path(p), &host_stfs));
+    UNLOCK_PATH(p, arg1);
+    if (is_error(ret)) {
+        return ret;
+    }
+
+    return h2t_freebsd_statfs(arg2, &host_stfs);
+}
+
+/* fstatfs(2) */
+static inline abi_long do_freebsd_fstatfs(abi_long fd, abi_ulong target_addr)
+{
+    abi_long ret;
+    struct statfs host_stfs;
+
+    ret = get_errno(fstatfs(fd, &host_stfs));
+    if (is_error(ret)) {
+        return ret;
+    }
+
+    return h2t_freebsd_statfs(target_addr, &host_stfs);
+}
+
+/* getfsstat(2) */
+static inline abi_long do_freebsd_getfsstat(abi_ulong target_addr,
+        abi_long bufsize, abi_long flags)
+{
+    abi_long ret;
+    struct statfs *host_stfs;
+    int count;
+    long host_bufsize;
+
+    count = bufsize / sizeof(struct target_statfs);
+
+    /* if user buffer is NULL then return number of mounted FS's */
+    if (target_addr == 0 || count == 0) {
+        return get_errno(freebsd11_getfsstat(NULL, 0, flags));
+    }
+
+    /* XXX check count to be reasonable */
+    host_bufsize = sizeof(struct statfs) * count;
+    host_stfs = alloca(host_bufsize);
+    if (!host_stfs) {
+        return -TARGET_EINVAL;
+    }
+
+    ret = count = get_errno(getfsstat(host_stfs, host_bufsize, flags));
+    if (is_error(ret)) {
+        return ret;
+    }
+
+    while (count--) {
+        if (h2t_freebsd_statfs((target_addr +
+                        (count * sizeof(struct target_statfs))),
+                    &host_stfs[count])) {
+            return -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
 #endif /* BSD_USER_FREEBSD_OS_STAT_H */
-- 
2.40.0


