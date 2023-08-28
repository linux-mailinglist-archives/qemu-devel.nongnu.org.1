Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A53F78BBB6
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:45:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalsQ-0003ui-0j; Mon, 28 Aug 2023 19:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalsH-0003sc-Fq
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:26 -0400
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qals6-0006qJ-Ve
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:19 -0400
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-34ca63f6a27so13250175ab.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266127; x=1693870927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9203UaeNY+VxpDbqXbvLLDOyA4HHIbk0lktS3VR1LOM=;
 b=GSNHWCgaev9VugoPzZY7UsKPBVOPw7esJn+ZHxdrdQj4BFNay+hIiITqYc6QOALUnZ
 MBjpQy0OkvuO/G4/t1/0lVW7s097mdknVxLvliy2Pv2r7sM97sRN16/SHdYgJPsV+Q9v
 6gB1YlXlNE8liPJElJXbQojJ2lmZ0aAnZj2j6KAPCbsKbQiF+MO/lB2Y8nrAFYW9BKvk
 EdnMxzBS+v4u2VyDBlnpxOEKDL3/LQCrM5ATTMTic+7RS7jq3gwGil4qIejOdUm72MUk
 jLXgkwlp3SjoW6aF9SrZBC7MXoObj5ohbdvryISjjyn2VEihIQGc8cU5azJ7VCF3dqaz
 yzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266127; x=1693870927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9203UaeNY+VxpDbqXbvLLDOyA4HHIbk0lktS3VR1LOM=;
 b=VGVoek5GBZYVruwAtEXp13g2vbEvJhGHKrueFHaBiur6aR7xBZu3S9oYKY0Fc3bRDj
 KmZhEQc6MglXhmo0BijLkyngpxoY2/3459qcLxSKPvnxczgcK1sQ2adhPhwd09NQ7cHR
 76mROC2jSF0IFAx/4K6/s/So/2Ju2NtstLZTQ8eKKhvLMEQiLZHrJ0OfOa6/k+OyNX6S
 AXZulJAu3iCjPK0Hz+3GmxSWNbIN1gMVXFUuZK/71/y6QJEg6MSADiHpBa1MfTyM+IWa
 rR9fSIzFXJq6ghKMf4AJqrODdffowR1W7QJyrE0NDZJX1v1Vinecr9si1P3plbzS3RCK
 /4Pw==
X-Gm-Message-State: AOJu0YyGeeOYkEZ40lTpTsjFLjkQ+vZ1j1CO8jUE0PCWTrgI6DxfQWgp
 EypA1Ge3dUdUmt/S0a3gpq5v9HDlXUL9MaPtfK0=
X-Google-Smtp-Source: AGHT+IFLrBRsVKP5Jx/MwzacqqGl7X8aM0jI8GLQrYNbSFxG6oi1WsXnUmmKIYlRGToXZuQ7nz0GcQ==
X-Received: by 2002:a92:c5ab:0:b0:34c:e84b:4c60 with SMTP id
 r11-20020a92c5ab000000b0034ce84b4c60mr7436341ilt.17.1693266127592; 
 Mon, 28 Aug 2023 16:42:07 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:42:07 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 32/36] bsd-user: Add glue for the freebsd11_stat syscalls
Date: Mon, 28 Aug 2023 17:38:17 -0600
Message-ID: <20230828233821.43074-33-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::135;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x135.google.com
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

Add glue to call the freebsd11_stat syscalls to the freebsd_syscall:

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
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 42 +++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 2224a280ea2..ade47a0d2f2 100644
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
2.41.0


