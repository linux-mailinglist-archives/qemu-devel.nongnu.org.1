Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 450C77740EE
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:12:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDe-0002EQ-S5; Tue, 08 Aug 2023 13:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDa-000298-Ti
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:02 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDZ-0003Mp-2C
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:02 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fe5c0e58c0so22162855e9.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514599; x=1692119399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f1DVEj9gV4h69+era7txyW8Wg/o1egzcjAPEzcjHmS0=;
 b=mu6Key9DW0wwgXA0thdN65fgqxEDuAoPVIV6CAe+xB3C03TNizsDbYCCBHmzzuNvm8
 kXBlPhuu7s2ylEMhQr0dVnRAWM9MCnel+UzDUqVKAqBxcE2AGg3OTbWTAvQ+HdRuhlmY
 pp6TfkXuhDEmXs+UmHE12iL0E0/BmXsRc0GAGMdPUxRdjIyp9C7FnLorBIcqJvBOiNvL
 k7JLm3Vu8oTHvzEjxebpRPlnTfTTut1nuPiLFp8nC9BhvqCRZ86+xGa0LlcPw6U5IZVB
 Xj0eyNP5kgFg1zlbWutFChm8lXxduGBFcQCHF5VUM1zem3knSs7JoQ1nKVIKVotP33r8
 OI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514599; x=1692119399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f1DVEj9gV4h69+era7txyW8Wg/o1egzcjAPEzcjHmS0=;
 b=Jvp6t8fVq0uNtdg4ssY+w/5J+FJ/BYk32pxwLnB1keMIK8IGv/AKze0M9SQPatZP3q
 dtoQHAudyysgxGGJ9fwkQwzUiSU1BmgTQL1ta4lSk0kKlZL0McnNGGwjV4daI3VF7AMQ
 UCaXBwKwySZHIRWwjfnL+iVFwtYlpHW7Cd/B9fWNHD+t1I+LMxfeuluwSqwkceU5fXTt
 AmyVVUMWBA4EtsGmZGD/dlESoHi3/sHR0vJP6oS1m8juNPZCJgK1dSq9vYQkimUYQqJ+
 idDibut3A2DabKQC4A4P0Cgb7Xt8YPxW1kJCNX7ScX5qOSaJi20YO8QMvGvBtEuwpAt9
 cSTA==
X-Gm-Message-State: AOJu0YzDv31GgzuZb+KeYaAZo9hft+VZ/hja2bQegZAbu9Tr6eugJYfN
 EYge0TZVbS+jNB7HmuJZwNPsTbOMbKTYMg==
X-Google-Smtp-Source: AGHT+IECxS3ApsB9E47j8qGC3KynHrBcz1f+LuWnlz4J1TlFNbvtvo+d1dctbLkBhmsv/mm2FCHYOA==
X-Received: by 2002:a7b:c7c6:0:b0:3fe:2b76:3d7 with SMTP id
 z6-20020a7bc7c6000000b003fe2b7603d7mr358224wmk.10.1691514599514; 
 Tue, 08 Aug 2023 10:09:59 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:09:59 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 18/33] Implement stat related syscalls
Date: Tue,  8 Aug 2023 08:08:00 +0200
Message-Id: <20230808060815.9001-19-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
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
stat(2)
lstat(2)
fstat(2)
fstatat(2)
nstat
nfstat
nlstat

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-stat.h | 130 +++++++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 bsd-user/freebsd/os-stat.h

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
new file mode 100644
index 0000000000..f8f99b4a72
--- /dev/null
+++ b/bsd-user/freebsd/os-stat.h
@@ -0,0 +1,130 @@
+/*
+ *  stat related system call shims and definitions
+ *
+ *  Copyright (c) 2013 Stacey D. Son
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef BSD_USER_FREEBSD_OS_STAT_H
+#define BSD_USER_FREEBSD_OS_STAT_H
+
+/* stat(2) */
+static inline abi_long do_freebsd11_stat(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    void *p;
+    struct freebsd11_stat st;
+
+    LOCK_PATH(p, arg1);
+    ret = get_errno(freebsd11_stat(path(p), &st));
+    UNLOCK_PATH(p, arg1);
+    if (!is_error(ret)) {
+        ret = h2t_freebsd11_stat(arg2, &st);
+    }
+    return ret;
+}
+
+/* lstat(2) */
+static inline abi_long do_freebsd11_lstat(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    void *p;
+    struct freebsd11_stat st;
+
+    LOCK_PATH(p, arg1);
+    ret = get_errno(freebsd11_lstat(path(p), &st));
+    UNLOCK_PATH(p, arg1);
+    if (!is_error(ret)) {
+        ret = h2t_freebsd11_stat(arg2, &st);
+    }
+    return ret;
+}
+
+/* fstat(2) */
+static inline abi_long do_freebsd_fstat(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    struct stat st;
+
+    ret = get_errno(fstat(arg1, &st));
+    if (!is_error(ret))  {
+        ret = h2t_freebsd_stat(arg2, &st);
+    }
+    return ret;
+}
+
+/* fstatat(2) */
+static inline abi_long do_freebsd_fstatat(abi_long arg1, abi_long arg2,
+        abi_long arg3, abi_long arg4)
+{
+    abi_long ret;
+    void *p;
+    struct stat st;
+
+    LOCK_PATH(p, arg2);
+    ret = get_errno(fstatat(arg1, p, &st, arg4));
+    UNLOCK_PATH(p, arg2);
+    if (!is_error(ret) && arg3) {
+        ret = h2t_freebsd_stat(arg3, &st);
+    }
+    return ret;
+}
+
+/* undocummented nstat(char *path, struct nstat *ub) syscall */
+static abi_long do_freebsd11_nstat(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    void *p;
+    struct freebsd11_stat st;
+
+    LOCK_PATH(p, arg1);
+    ret = get_errno(freebsd11_nstat(path(p), &st));
+    UNLOCK_PATH(p, arg1);
+    if (!is_error(ret)) {
+        ret = h2t_freebsd11_nstat(arg2, &st);
+    }
+    return ret;
+}
+
+/* undocummented nfstat(int fd, struct nstat *sb) syscall */
+static abi_long do_freebsd11_nfstat(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    struct freebsd11_stat st;
+
+    ret = get_errno(freebsd11_nfstat(arg1, &st));
+    if (!is_error(ret))  {
+        ret = h2t_freebsd11_nstat(arg2, &st);
+    }
+    return ret;
+}
+
+/* undocummented nlstat(char *path, struct nstat *ub) syscall */
+static abi_long do_freebsd11_nlstat(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    void *p;
+    struct freebsd11_stat st;
+
+    LOCK_PATH(p, arg1);
+    ret = get_errno(freebsd11_nlstat(path(p), &st));
+    UNLOCK_PATH(p, arg1);
+    if (!is_error(ret)) {
+        ret = h2t_freebsd11_nstat(arg2, &st);
+    }
+    return ret;
+}
+
+#endif /* BSD_USER_FREEBSD_OS_STAT_H */
-- 
2.40.0


