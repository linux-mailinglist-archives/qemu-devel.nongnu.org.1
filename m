Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0861E77AAF0
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 21:45:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVGzo-0007sm-Pd; Sun, 13 Aug 2023 15:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzn-0007sX-0h
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:27 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzl-0002Rz-Fy
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:26 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-313e742a787so2084540f8f.1
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 12:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691955804; x=1692560604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nWpL2ZjaRHGF59jykGmUuJR96pZMoEaAnfNSKG75X6s=;
 b=HyVGLzKuYyh2NsEDQi8eh6shQbd6aRLV8kZpTmyqRE/s/4/0zQICke/vaFX6DiTN9s
 o3I+nXgU1FMKrEUULeg1LLgYeIPLomZO5st8vx7zB79jZejDCNmbmQnzf+M7L+Nhq4JY
 DDjhSEMsCBYCA+oz4iVg8xPWBZ+mYYlsLTlYokTCkevEIriHmUOe/aJ/cy8Q57tVnsM0
 OvKvFSCjGf6OU8FlWmEMLrdwaQC3RmCgrA72Ia7sxqnkSDD2vGN7CluYqC2xuG7Ce9DY
 xpln1UiEeMEfcEn6qrPNLCuClELJ+RHOVnPXiBa9WOBtsOOvPGF9mAqMNwLgsjs0UQUW
 HJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691955804; x=1692560604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nWpL2ZjaRHGF59jykGmUuJR96pZMoEaAnfNSKG75X6s=;
 b=b6SVzCz6bpSDFS2xvy2s5ThtRhY8THjbuyOF7B9JfFzmjb6A2y0oGv+3sV9p/uBg96
 aMcwrBV3XFtjDvJwKcMPSVgTNFP5L69QnkbfcSXHoiJNQV9ZA9OHraZD7CwYkaETmzWI
 m6uE4gZxRzOCadGFklS2yuxfvy8kQPcMkXD4eaVT51yqqdpdGZD+rJw307jQugUu4WRV
 8BgD/NAYgtkEgQQaI+O3gq8giAYXfYfkiCR77kp8eTQdmiDVOr/yRIiPByMFwex0XPi0
 Zu3C8rrOpRSLK1+0UH2BXnzBlFOGQiX042jnxkTL1UXn5kt+r5nyAYedUjC42DqybF25
 xf0w==
X-Gm-Message-State: AOJu0Yz8RW8788dJCfhlI7kBvTe119qg+5imuZbc5bw5jpktDX8ImmqG
 E8w5wXA7V+x/O2J28yaTrC66OIGfcAs=
X-Google-Smtp-Source: AGHT+IHm/ihADqgYWsfybnWbsRk6ZacnSaJ/221eRzCRuR9KeUIFWSUQ58BbvVzrRK6gugndBNhOPA==
X-Received: by 2002:a5d:4990:0:b0:317:58a4:916f with SMTP id
 r16-20020a5d4990000000b0031758a4916fmr8093496wrq.33.1691955803898; 
 Sun, 13 Aug 2023 12:43:23 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a7bc3d4000000b003fe263dab33sm12234536wmj.9.2023.08.13.12.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 12:43:23 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 20/32] Implement stat related syscalls
Date: Sun, 13 Aug 2023 10:41:41 +0200
Message-Id: <20230813084153.6510-21-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
References: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42a.google.com
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
getdents(2)
getdirecentries(2)

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-stat.h | 72 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index 9492c93c55..7dc41cd0bf 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -279,4 +279,76 @@ static inline abi_long do_freebsd_getfsstat(abi_ulong target_addr,
     return ret;
 }
 
+/* getdents(2) */
+static inline abi_long do_freebsd11_getdents(abi_long arg1,
+        abi_ulong arg2, abi_long nbytes)
+{
+    abi_long ret;
+    struct freebsd11_dirent *dirp;
+
+    dirp = lock_user(VERIFY_WRITE, arg2, nbytes, 0);
+    if (dirp == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(freebsd11_getdents(arg1, (char *)dirp, nbytes));
+    if (!is_error(ret)) {
+        struct freebsd11_dirent *de;
+        int len = ret;
+        int reclen;
+
+        de = dirp;
+        while (len > 0) {
+            reclen = de->d_reclen;
+            if (reclen > len) {
+                return -TARGET_EFAULT;
+            }
+            de->d_reclen = tswap16(reclen);
+            de->d_fileno = tswap32(de->d_fileno);
+            len -= reclen;
+        }
+    }
+    return ret;
+}
+
+/* getdirecentries(2) */
+static inline abi_long do_freebsd_getdirentries(abi_long arg1,
+        abi_ulong arg2, abi_long nbytes, abi_ulong arg4)
+{
+    abi_long ret;
+    struct dirent *dirp;
+    long basep;
+
+    dirp = lock_user(VERIFY_WRITE, arg2, nbytes, 0);
+    if (dirp == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(getdirentries(arg1, (char *)dirp, nbytes, &basep));
+    if (!is_error(ret)) {
+        struct dirent *de;
+        int len = ret;
+        int reclen;
+
+        de = dirp;
+        while (len > 0) {
+            reclen = de->d_reclen;
+            if (reclen > len) {
+                return -TARGET_EFAULT;
+            }
+            de->d_fileno = tswap64(de->d_fileno);
+            de->d_off = tswap64(de->d_off);
+            de->d_reclen = tswap16(de->d_reclen);
+            de->d_namlen = tswap16(de->d_namlen);
+            len -= reclen;
+            de = (struct dirent *)((void *)de + reclen);
+        }
+    }
+    unlock_user(dirp, arg2, ret);
+    if (arg4) {
+        if (put_user(basep, arg4, abi_ulong)) {
+            return -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
 #endif /* BSD_USER_FREEBSD_OS_STAT_H */
-- 
2.40.0


