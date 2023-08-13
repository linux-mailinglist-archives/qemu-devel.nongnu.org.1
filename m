Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8E477AAE5
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 21:44:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVGzm-0007sO-MJ; Sun, 13 Aug 2023 15:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzk-0007rg-Q3
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:24 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzj-0002Q9-53
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:24 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fe1a17f983so33046795e9.3
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 12:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691955801; x=1692560601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D4VC00NMaV/EVxyvh1YhfOSLjPJ+EyYcglqkFbj3qYA=;
 b=DEYcRmooWODjrPebEf7QEIXUOVX6chHgM0LiTR9wBahmo3HKGY7ppJOLQhcr5e6w8W
 xZGvfhzqCJSTXB/h2IJEpc1FV3vTuzD7al+w344XB6hc2DcNGnU5by+m3pWVrrDbHpLy
 7BA8u696oRb8sVmgLySlBRy3Guc59RFbCJsCJBz5y8k34Dd+ZEj8eVWINL/5/JTQu55I
 94Z+JSvhoI8eOgt0ZxRz0O8CNN6wHGFyiKfcBbrTpcovO+mhqPIgZ/Iu7W3Sls/HFROi
 m5ZUG7nTRrnecb2hB1NEDPid7bbyre/iJVZqCXDwWfsbLZqTCVMO/NtzmupO2xBHPrYd
 SNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691955801; x=1692560601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D4VC00NMaV/EVxyvh1YhfOSLjPJ+EyYcglqkFbj3qYA=;
 b=RY3lZR35SAyRH2IwztBuYbQ9eS4XNohiC+fgpcztqj8tEPgzLYFE8GKNd7Oy+H9MLq
 KHZgaoYFUy5CvBlFyR5yiBzj99DZeaRx2mgQYi3yRrebEi9PQ/QmxYcBl9L0p/LH+uIO
 0VA22QWe5Vcqd/rMOs83m9Y7gdkd+hhjUmVPbkzGJFQImCQClVIGF2H8cNlLQD4DXkyJ
 o7bMBSZOvTQ3YHryu/STPWbndnnHaWpU3G02+KCIl9gcfg6L2+WEKKZkhNAjJpbazrGy
 8f6pEU5eHit9W4YgmQLh5BfA0nyPLMROBQzjVmDjcdx6D2O3zWLuf375uHkXCBcw/Owo
 6ZgA==
X-Gm-Message-State: AOJu0YwPT/cwvZpQbcQGvlh5mGOha9B5qG4dgDMz+dBqDEnDIZDGk2Ky
 IoHgcDzfnAdg+IhyJbH3c4JQV2hE70w=
X-Google-Smtp-Source: AGHT+IF5TYJF6E4sB+qEj6BnhtgHkIYjE9kCBOOpiRjfQM/ucO3GF5jkztSI3d1P0e3ZKWRsCaZrGg==
X-Received: by 2002:a05:600c:2494:b0:3fc:7d2:e0c0 with SMTP id
 20-20020a05600c249400b003fc07d2e0c0mr6407023wms.27.1691955801620; 
 Sun, 13 Aug 2023 12:43:21 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a7bc3d4000000b003fe263dab33sm12234536wmj.9.2023.08.13.12.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 12:43:21 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 18/32] Implement stat related syscalls
Date: Sun, 13 Aug 2023 10:41:39 +0200
Message-Id: <20230813084153.6510-19-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
References: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x331.google.com
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
getfh(2)
lgetfh(2)
fhopen(2)
fhstat(2)
fhstatfs(2)

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-stat.h | 83 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index f8f99b4a72..935663c071 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -127,4 +127,87 @@ static abi_long do_freebsd11_nlstat(abi_long arg1, abi_long arg2)
     return ret;
 }
 
+/* getfh(2) */
+static abi_long do_freebsd_getfh(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    void *p;
+    fhandle_t host_fh;
+
+    LOCK_PATH(p, arg1);
+    ret = get_errno(getfh(path(p), &host_fh));
+    UNLOCK_PATH(p, arg1);
+    if (is_error(ret)) {
+        return ret;
+    }
+    return h2t_freebsd_fhandle(arg2, &host_fh);
+}
+
+/* lgetfh(2) */
+static inline abi_long do_freebsd_lgetfh(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    void *p;
+    fhandle_t host_fh;
+
+    LOCK_PATH(p, arg1);
+    ret = get_errno(lgetfh(path(p), &host_fh));
+    UNLOCK_PATH(p, arg1);
+    if (is_error(ret)) {
+        return ret;
+    }
+    return h2t_freebsd_fhandle(arg2, &host_fh);
+}
+
+/* fhopen(2) */
+static inline abi_long do_freebsd_fhopen(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    fhandle_t host_fh;
+
+    ret = t2h_freebsd_fhandle(&host_fh, arg1);
+    if (is_error(ret)) {
+        return ret;
+    }
+
+    return get_errno(fhopen(&host_fh, arg2));
+}
+
+/* fhstat(2) */
+static inline abi_long do_freebsd_fhstat(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    fhandle_t host_fh;
+    struct stat host_sb;
+
+    ret = t2h_freebsd_fhandle(&host_fh, arg1);
+    if (is_error(ret)) {
+        return ret;
+    }
+    ret = get_errno(fhstat(&host_fh, &host_sb));
+    if (is_error(ret)) {
+        return ret;
+    }
+    return h2t_freebsd_stat(arg2, &host_sb);
+}
+
+/* fhstatfs(2) */
+static inline abi_long do_freebsd_fhstatfs(abi_ulong target_fhp_addr,
+        abi_ulong target_stfs_addr)
+{
+    abi_long ret;
+    fhandle_t host_fh;
+    struct statfs host_stfs;
+
+    ret = t2h_freebsd_fhandle(&host_fh, target_fhp_addr);
+    if (is_error(ret)) {
+        return ret;
+    }
+    ret = get_errno(fhstatfs(&host_fh, &host_stfs));
+    if (is_error(ret)) {
+        return ret;
+    }
+    return h2t_freebsd_statfs(target_stfs_addr, &host_stfs);
+}
+
 #endif /* BSD_USER_FREEBSD_OS_STAT_H */
-- 
2.40.0


