Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F1A77AAE7
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 21:44:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVGzz-0007xY-P1; Sun, 13 Aug 2023 15:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzy-0007x4-GS
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:38 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzw-0002To-0d
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:38 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fe4b95c371so20962785e9.1
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 12:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691955814; x=1692560614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/pm7PUDTlSRoOOpzR5gtIrbIF/DxYO36NC9GLHOZYTQ=;
 b=nvOdMOyvmixYAUTjs+lJvTWtGUxR8DMf39/Y03ve8pawQB0h5E2pYJrN+bR7mjo314
 k1zz3QukpY7YIlZCqJByb63hMn7F8y6nIRotKNSTSfD7ACxuWpQFiaMTQFA/hzrYgci8
 /4+duDCAjT81eJKojaVNaA/PD7NjgVyKBChXf3tEcDCaxK0M3IDnDWlwrw8NVWXAybks
 Jws21j2jYUcr0YAjShZidp8FyIA6yJxP65hwAQHdC6EqSo/ZJcLRJ36srk+RAcwQXKFK
 z54C0a4uk5cUXOHTyFdWjuR1qWJg5RuxoCASFvGBaxlqt2wUebKpijE9S4OLKoRgeB5F
 F4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691955814; x=1692560614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/pm7PUDTlSRoOOpzR5gtIrbIF/DxYO36NC9GLHOZYTQ=;
 b=E5+Xe7Xibk3ozZYeJ5ben3lHXvv1fEv0eDPwZ2Ky6KvK02E9dYWan09IvDH4sVRLt9
 yRZiGYlVCaD9aHH7byGEi+B4VoqKO0opW67a+p+aSWYvHCFb7Uq6tV5iFW3ENNei0TNN
 Ao4659MecmR8sKTxBqx+0Cv4GqW/Syqr/uugFs7CiJHBfe4bfRFBxdrkX1xaRhBpVHYw
 V1crEV6bjFzSzexlTjry0aMmwBp/43yaxo623Vbnru0dZvnmfNmDDjbeSooKYB7M151s
 KnNRlHyb/7cQ7WkGsf0dXqQxFmwpZJdnj0FrmTMbWq0vuDHddUxW8DyZDIg/2EoO1btm
 nNPQ==
X-Gm-Message-State: AOJu0YwIY5ZJeAQQ3+WKhuCkMzi1rt+fCjwGB6FNdOk+e7e4irpY6ngq
 z8CcFGNywEmkd8u5EY3OQD2kEoHy0jw=
X-Google-Smtp-Source: AGHT+IEbXFwWBt4AJme6an1EK2slUrjw71Z0dTbH3ZEd5nB1RfUq0kjjBAgL5j9/4bQLF30/3iczWw==
X-Received: by 2002:a7b:ca53:0:b0:3fe:3389:122f with SMTP id
 m19-20020a7bca53000000b003fe3389122fmr8274773wml.1.1691955814428; 
 Sun, 13 Aug 2023 12:43:34 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a7bc3d4000000b003fe263dab33sm12234536wmj.9.2023.08.13.12.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 12:43:34 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 29/32] Add glue to call the following syscalls to the
 freebsd_syscall function:
Date: Sun, 13 Aug 2023 10:41:50 +0200
Message-Id: <20230813084153.6510-30-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
References: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


