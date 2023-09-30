Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FA47B3D98
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 04:18:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmPWN-0000G5-Ln; Fri, 29 Sep 2023 22:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmPWB-0000C0-3l
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 22:15:43 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmPW3-0001yh-Eq
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 22:15:42 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-57d086365f7so3244352eaf.0
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 19:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696040133; x=1696644933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RLZnYG6gB4JjRwsSZMPasIhTWijR/jDuID0FZ6WSuAE=;
 b=lTSXnstiUUa+YvcwiwLyH46SpdnYn0WvLHWje1DuMdehoHYom+kmGWkyoh6uNtySPn
 fP1/gwZddyqQkR6lwntvXyL4IGpQvUxECTifiA8yLViA5iAsmhqSOBh8kEqcKEtwkzix
 Baj0PV469geaN6p49h9drlc4kpLQ63yLD4oyBnjO+GpEm7ckgbbm8ySXYNvUS9d9sRrw
 NECr0yKqM/N9lgyHlz8ZL2O7iz22WpXvFVeVIpfBBRY/O0rJRqdJ9wQgBmA563dSGO9e
 93Q26vlExSNehRz+bi/uhp20YTOuQ79dX5Zq6SkWHtCBWbJDl48H+t/VsafCHfUmLV8E
 OWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696040133; x=1696644933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RLZnYG6gB4JjRwsSZMPasIhTWijR/jDuID0FZ6WSuAE=;
 b=NzcujD7FTO36+F/IC5DFrWq43ZTrzOsnQ67oWQDqyYXn3domD9YNpvzLf/yfajMMoE
 YS7yiQRof5Du7klYtTs1UkHPYTAS2PCE/2yfPKqrdZJ+us3JqAXJ3HB0X1WQBYjpoFz9
 mjP05LgujFblbJuSXuev2+M0yPJQS/q9mIrMR9kchNDWb+adfuAN5Z/k5CSk+DubmScy
 PunuTmJ0jqzCxkYIRUmeYCoBjEL18t7xcZR1xdaPDUUKWEq/H7P+eemXMtR63K3YZckg
 at1AcC4jI8cM/WUtLoM/lOWN3qAZRnU+wgq1Lf2cHAlTmEP3ipDPR3izifrS6N+A5aQl
 5+sA==
X-Gm-Message-State: AOJu0YwtaJeqsBbAzzOvxkiR+jL06JMgR2rbzmFgmKBpBVvncs47Ez3P
 FI6o239bJViaDudOpitv56d8AKGDB9x2n9fu8+o=
X-Google-Smtp-Source: AGHT+IHpnivAN1sZtQWvydxBfqBw13rbL3KhqE5D9hyt9FmRFisq0XW7BTUta9zXZ3xabyMYTXAfWg==
X-Received: by 2002:a05:6358:7e49:b0:142:dfc2:a441 with SMTP id
 p9-20020a0563587e4900b00142dfc2a441mr6732370rwm.8.1696040133172; 
 Fri, 29 Sep 2023 19:15:33 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fv21-20020a17090b0e9500b002775281b9easm2130692pjb.50.2023.09.29.19.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 19:15:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH v6 02/19] linux-user: Tidy loader_exec
Date: Fri, 29 Sep 2023 19:15:12 -0700
Message-Id: <20230930021529.987950-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230930021529.987950-1-richard.henderson@linaro.org>
References: <20230930021529.987950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Reorg the if cases to reduce indentation.
Test for 4 bytes in the file before checking the signatures.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/linuxload.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/linux-user/linuxload.c b/linux-user/linuxload.c
index 3536dd8104..5b7e9ab983 100644
--- a/linux-user/linuxload.c
+++ b/linux-user/linuxload.c
@@ -154,31 +154,31 @@ int loader_exec(int fdexec, const char *filename, char **argv, char **envp,
 
     retval = prepare_binprm(bprm);
 
-    if (retval >= 0) {
-        if (bprm->buf[0] == 0x7f
-                && bprm->buf[1] == 'E'
-                && bprm->buf[2] == 'L'
-                && bprm->buf[3] == 'F') {
-            retval = load_elf_binary(bprm, infop);
-#if defined(TARGET_HAS_BFLT)
-        } else if (bprm->buf[0] == 'b'
-                && bprm->buf[1] == 'F'
-                && bprm->buf[2] == 'L'
-                && bprm->buf[3] == 'T') {
-            retval = load_flt_binary(bprm, infop);
-#endif
-        } else {
-            return -ENOEXEC;
-        }
+    if (retval < 4) {
+        return -ENOEXEC;
     }
-
-    if (retval >= 0) {
-        /* success.  Initialize important registers */
-        do_init_thread(regs, infop);
+    if (bprm->buf[0] == 0x7f
+        && bprm->buf[1] == 'E'
+        && bprm->buf[2] == 'L'
+        && bprm->buf[3] == 'F') {
+        retval = load_elf_binary(bprm, infop);
+#if defined(TARGET_HAS_BFLT)
+    } else if (bprm->buf[0] == 'b'
+               && bprm->buf[1] == 'F'
+               && bprm->buf[2] == 'L'
+               && bprm->buf[3] == 'T') {
+        retval = load_flt_binary(bprm, infop);
+#endif
+    } else {
+        return -ENOEXEC;
+    }
+    if (retval < 0) {
         return retval;
     }
 
-    return retval;
+    /* Success.  Initialize important registers. */
+    do_init_thread(regs, infop);
+    return 0;
 }
 
 bool imgsrc_read(void *dst, off_t offset, size_t len,
-- 
2.34.1


