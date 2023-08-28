Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 236EA78BB9A
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:43:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalrz-0003nF-7w; Mon, 28 Aug 2023 19:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalru-0003mb-NT
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:02 -0400
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrs-0006kw-Dt
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:02 -0400
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-34961362f67so11651665ab.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266119; x=1693870919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BR5YhtuiGQc8+lAV/Cmy0fJIijItE+RF+CzfrwWn6Ik=;
 b=AR/PeWVdMiuGVgEn9kVUjDJ9TT7R9xXLWODTCSffqP9bAipleaPbQ5FJypviwUsxZE
 wdyJno9ANQtC+ad9nXS8YuQO955CoyRQiT/n7afeJK5KA48jmYBcoFtdr4goZSdSwWGf
 vcvqzmj/6q5nZkWQuFZMLDSA4QuVmnUw894C1Qr3CCeATQiq2erElYKhpQn2+785ixe0
 mVOOw6ylDvxK77/D4rGzWbZmHfO4zdIUvF82Wo1si03tWAxnlCnhZEHf2SLMx29k80WS
 u8/xlmkL1MRVPsUzMDMH5eqdMHqe56MY2Y+utosG68f7BLVpvgCwGOvV9W704/KAQVRO
 sTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266119; x=1693870919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BR5YhtuiGQc8+lAV/Cmy0fJIijItE+RF+CzfrwWn6Ik=;
 b=gZv7Dv7ZTpGLEcG/ZDWqPdRWFVTugfP77rrBJwfKQze0d4Wu11H0Kt2Ih76zzBoBDp
 /xzGBZ9P5NfN7KeocA1UUjeWREBERRXfTR0+b3k1soVO/PgtJTvImiUQthWcGFejJwpr
 NIinCo40H6iF3mO/X4OQjFaJ7zJjbVTtLbQkHUvLIFQjY9pUJ8Re0yoR5syZg5pFFLrW
 F909jPTu5RlJylFL04/2U2EatEN81WkYEA0OIPHK3A1Tq8u1t4+IdgyGt06wSpLwNwNN
 Vhlyl/b2KYdh3iacqCH5/MknRB+lh8a6VBqdtqoAhdv0uBLbduFjI53ROgq/XNekmYNp
 NjFw==
X-Gm-Message-State: AOJu0YwKD+E6Trjasx4dTNW0oedNMJQmAgqOnpSw/5RwFHYIJJWPjSM7
 1vjY5KplLRh9myExUNoG0SZjy0r3k4onmU+xvG4=
X-Google-Smtp-Source: AGHT+IHJOV+/CohR5v8oBsh5dAU7BirkqhULbuVPJZWlNmd96PbswP/Hb8UQLWc3nS43GPyabBwg9A==
X-Received: by 2002:a05:6e02:1102:b0:348:7f18:68be with SMTP id
 u2-20020a056e02110200b003487f1868bemr1080188ilk.4.1693266118840; 
 Mon, 28 Aug 2023 16:41:58 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:41:58 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 22/36] bsd-user: Implement statfs related syscalls
Date: Mon, 28 Aug 2023 17:38:07 -0600
Message-ID: <20230828233821.43074-23-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::133;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x133.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-stat.h | 69 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index 935663c0713..9492c93c55a 100644
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
2.41.0


