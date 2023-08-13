Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E2077A6C5
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:14:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBpu-0008G3-VV; Sun, 13 Aug 2023 10:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpd-0008B1-30
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:38 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpb-0000sM-Fe
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:36 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fe2fb9b4d7so31611035e9.1
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935953; x=1692540753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nWpL2ZjaRHGF59jykGmUuJR96pZMoEaAnfNSKG75X6s=;
 b=pULEL/pC1+wjHpuiWuNcWe9tY+EUzb1JkYGjIZV455KJb2Pj0RgbvKxBSyR+ji5zC9
 GGSE6Dpf+s8xfLO719Nly6DhQQBkWeO+eDKaHzCOQ9a59qPxmo4jgWStmq8AARHS4l4w
 GTjs5+fwB31msSsaKaxF57Ccj2JCwZu1IxyqXcoSXgBEh0QPihZ8wxI2q1oPFCoqAfDl
 Z3NPElt1yvIe0UtVc0KcOKubga7pPcfVNffmjMBEmHfc/bC627MvvzMy9NfT92p4mkeS
 RW+kfgGjLi+Un5YfrTFrGrRunjBcoAmylBKCn9yoKT4fMZnhIrtOg0SrZjgpyKmR5U84
 rDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935953; x=1692540753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nWpL2ZjaRHGF59jykGmUuJR96pZMoEaAnfNSKG75X6s=;
 b=WTzfVESDaN6Mcov87Cnec6+aUfe0jfLLGNnDX/lhSKPVCbQpG391QJXCeuBWmAEbBM
 lYw4qXLcgJLu01uCTB0k5flqEvuRz5lrERJUGyO5jOTMdY5mUxJk7yoDBu0f/g1Xyi5x
 6dha/25KJeyNWEGtiYv/mg4kPVYcjPB0MZ3khc6KwuN6NJ8kMj3GlXSAXPPRiiwLXud7
 7jJTx6TSDHwpid630oU9PZLDtlP2bEVun55CqeSyCIhhKKSExzfTEK5hTAtf+UujwgB6
 ak36UxpOlcp9gez1CS6WxZyhTuY5qcjdqjF5Vw49xH2a2rIZrEyhA3o/h+WD7Ypm6Dzw
 clSA==
X-Gm-Message-State: AOJu0YwXHpZcR9Ombo6K4Dm67LEVar2f63cTX1ZOgOJHKxzBvfANOnGQ
 vAerzdyBV3Vt1FqEMCOPJ7YpfIXeCZ8=
X-Google-Smtp-Source: AGHT+IFPuo1T/f2pY3GL+sv2H5UxRIgA9wGnBPbHuvNpY2mVY1nXS9Lwo7yzhGTIdSwfcS9uai7c1Q==
X-Received: by 2002:a05:6000:90a:b0:30f:b7b4:3e55 with SMTP id
 cw10-20020a056000090a00b0030fb7b43e55mr5112365wrb.19.1691935952934; 
 Sun, 13 Aug 2023 07:12:32 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:32 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 20/32] Implement stat related syscalls
Date: Sun, 13 Aug 2023 05:10:01 +0200
Message-Id: <20230813031013.1743-21-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
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


