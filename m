Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0337740CC
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:10:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDw-0004cG-KE; Tue, 08 Aug 2023 13:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDt-0004JY-Kj
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:21 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDr-0003qg-U2
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:21 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-317dcdae365so2683812f8f.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514618; x=1692119418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=htR7DySjkwXmkr4i/feK2Wpjipk8wcHMAZjZzgfbE8g=;
 b=Lrh7KmWI2jnULG2VBoq+s4sCaHoO9MVsUpjuyFKbTzq9o2l4wW8iXEA8sR6Faz3qsQ
 0QzmSD2tr71/MZAxwgK9hgUhcTixH0vsV5P00mkvPlF15CCcZy8YIWmKvCumkAzw9QaC
 4TQdpymy4BFxjnDIqL+DiLcFJnUuDQfvVSHKns3OPlJelLwc7dhpf8FV2MErv3WJKV+R
 cP/DxZad+y/nV5BmQZM6gyu94h/kUq9JUXQGRC2Mt8D4gfddzyAaMF1RCM5IIk+4vi5t
 Wm9RrwYY65+0mrTOFnl5Qb8JYTW1yhsPDKvdBYpj6KB1iKNOdFQaBRSlY+NAU0gU7zaC
 JmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514618; x=1692119418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=htR7DySjkwXmkr4i/feK2Wpjipk8wcHMAZjZzgfbE8g=;
 b=JJhlotylGqiv1RVZLwXttRTqByIM3pGOVSIssvGkJi1zsVuh96zezayCJ3s0C2Zf2j
 aHd/L/OZfCN6djBrFgS10G9a+mUgXDdovZ1ewQu1bEwCZ++tVK0MzJEbd46nynCrHjW4
 r7c2eFVdmSRUbLy2HFAHleTVLTKQBO9Cggqt4rJRI/ZyQsy5RXswnFd2bUJcRGMdS+Zq
 aw1MRRhICGB/PqZ6YuMSlT7c8HLqqj2tmy9oJe06oEWKWT5F81KJdqILVDTJ+rge5Mzm
 fJEzUximqsb38DftC9XLd7bEyhqancVczY1iQIUVFQwIzjUzHUhVbUt+m4MP0etPm8mo
 UIZg==
X-Gm-Message-State: AOJu0Ywo0zNo+0mLFQPOL1K6oFP8qNwqiC0JV0S0JNJsSyxJTC2ek5gN
 qFGJwNa/Z7gmfqCBuNnIZY0TAWj+N/SRww==
X-Google-Smtp-Source: AGHT+IFdzUJqi4aUettm847OW8rOsnMSJmroLDHUcJBfaGd1tkJ/Qc+YMfnG9GhM8+vnUvVjk3Dfgg==
X-Received: by 2002:a5d:4ecf:0:b0:317:562d:3f21 with SMTP id
 s15-20020a5d4ecf000000b00317562d3f21mr67524wrv.10.1691514617946; 
 Tue, 08 Aug 2023 10:10:17 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:10:17 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 30/33] Add glue to call the following syscalls to the
 freebsd_syscall function:
Date: Tue,  8 Aug 2023 08:08:12 +0200
Message-Id: <20230808060815.9001-31-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
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

From: Warner Losh <imp@bsdimp.com>

freebsd11_stat
freebsd11_lstat
freebsd11_fstat
freebsd11_fstatat
freebsd11_nstat, freebsd11_nfstat, freebsd11_nlstat
fstatat
fstat

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-syscall.c | 42 +++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 2224a280ea..ade47a0d2f 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -36,6 +36,9 @@
 #include "bsd-file.h"
 #include "bsd-proc.h"
 
+/* *BSD dependent syscall shims */
+#include "os-stat.h"
+
 /* I/O */
 safe_syscall3(int, open, const char *, path, int, flags, mode_t, mode);
 safe_syscall4(int, openat, int, fd, const char *, path, int, flags, mode_t,
@@ -482,6 +485,45 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_undelete(arg1);
         break;
 
+        /*
+         * stat system calls
+         */
+    case TARGET_FREEBSD_NR_freebsd11_stat: /* stat(2) */
+        ret = do_freebsd11_stat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_lstat: /* lstat(2) */
+        ret = do_freebsd11_lstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_fstat: /* fstat(2) */
+        ret = do_freebsd11_fstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_fstat: /* fstat(2) */
+        ret = do_freebsd_fstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_fstatat: /* fstatat(2) */
+        ret = do_freebsd11_fstatat(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_fstatat: /* fstatat(2) */
+        ret = do_freebsd_fstatat(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_nstat: /* undocumented */
+        ret = do_freebsd11_nstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_nfstat: /* undocumented */
+        ret = do_freebsd11_nfstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_nlstat: /* undocumented */
+        ret = do_freebsd11_nlstat(arg1, arg2);
+        break;
+
         /*
          * sys{ctl, arch, call}
          */
-- 
2.40.0


