Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D267B3D95
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 04:17:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmPWI-0000Dy-JJ; Fri, 29 Sep 2023 22:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmPWB-0000C2-70
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 22:15:43 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmPW4-0001ym-MM
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 22:15:42 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-692a885f129so10682191b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 19:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696040134; x=1696644934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N6Gi1W2NSeoXsGrs8c4mvQh099VY+s2zRGNYCJyf/Qs=;
 b=zUi+DDIeqHCzcKhsnhdy1aAvNO/QWvGU865QF0nTz7gBSaFeGtLc7PNG/LXY1zcpUX
 FlHQnhXJBeAekfDZ/JGSLYCgJQDt6cEuZppluDkqIyyM5NzjR1ebEE1R3Pi8SrEaBMLI
 dm1m1iu2E+85+JHI7Ho5Nn4w8fAPYu72UqX5oE8qQH5BjglyorFcV42FDwwf0yTwwF6K
 B2n2pM7K9Bk2Yesu48ES3ps9APQU/afa6JljySiyzn3oH70HrhkazfgmyzHgqSIV2WvK
 a8K8vPnaRP5q1JnL4L/FPKb+sws/ou9JU9MWe7Zx4OhFEmu11QawCyGFpICT8Ngbq8t4
 nQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696040134; x=1696644934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N6Gi1W2NSeoXsGrs8c4mvQh099VY+s2zRGNYCJyf/Qs=;
 b=jSFYXdJKmQy2g/ZTfFs9B+/k3Zn5FE9KjEpwZJ7VLvgfG1EcaWcsTr762OgsSlqQCd
 cPr10OFHaXrqbxtDjmdav1wmzne1mQWTz4Q+JmFp4iLuT6XxY4kngbWZ/SgUC2TOCcYO
 SJZu3doTuqqVdsv9dyEIf2lJzqMvwjcSTMnifLYPN3aLrf1fP8lyRksmurjmGGq1ZjyP
 0fKCVsX45foSGCINVZqz7tMVamhCNsMRBtnalTCATZErgH+xJlRzsTfu115JztdtrFtr
 nedv076TdZXJV8avjNERZKckQPwk/kHDAiOlg98G+euAJWJ7qfyt2Yf3wpeqf+a8ZElT
 jN4Q==
X-Gm-Message-State: AOJu0YyZyqQDk9J5R6TmmNPz7VA0qQV4UOtEdN4NEb6BygMSXkrrYdmQ
 J0Xkaxxk+q7PFvzdQsdg+MN4FMVSbDDtPxGrKdE=
X-Google-Smtp-Source: AGHT+IFbcm3E0IJLvxCfXs7rkZDdZtowgTKpbaVMEzH6ZIABRQAv/eDgtzf5OnVnDad6gFaWAYfOhQ==
X-Received: by 2002:a05:6a20:7f8a:b0:131:b3fa:eaaa with SMTP id
 d10-20020a056a207f8a00b00131b3faeaaamr7316302pzj.61.1696040134158; 
 Fri, 29 Sep 2023 19:15:34 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fv21-20020a17090b0e9500b002775281b9easm2130692pjb.50.2023.09.29.19.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 19:15:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH v6 03/19] linux-user: Do not clobber bprm_buf swapping ehdr
Date: Fri, 29 Sep 2023 19:15:13 -0700
Message-Id: <20230930021529.987950-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230930021529.987950-1-richard.henderson@linaro.org>
References: <20230930021529.987950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Rearrange the allocation of storage for ehdr between load_elf_image
and load_elf_binary.  The same set of copies are done, but we don't
modify bprm_buf, which will be important later.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index db75cd4b33..e5c014611c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3164,16 +3164,17 @@ static bool parse_elf_properties(int image_fd,
    On return: INFO values will be filled in, as necessary or available.  */
 
 static void load_elf_image(const char *image_name, int image_fd,
-                           struct image_info *info, char **pinterp_name,
+                           struct image_info *info, struct elfhdr *ehdr,
+                           char **pinterp_name,
                            char bprm_buf[BPRM_BUF_SIZE])
 {
-    struct elfhdr *ehdr = (struct elfhdr *)bprm_buf;
     struct elf_phdr *phdr;
     abi_ulong load_addr, load_bias, loaddr, hiaddr, error;
     int i, retval, prot_exec;
     Error *err = NULL;
 
     /* First of all, some simple consistency checks */
+    memcpy(ehdr, bprm_buf, sizeof(*ehdr));
     if (!elf_check_ident(ehdr)) {
         error_setg(&err, "Invalid ELF image for this architecture");
         goto exit_errmsg;
@@ -3488,6 +3489,7 @@ static void load_elf_image(const char *image_name, int image_fd,
 static void load_elf_interp(const char *filename, struct image_info *info,
                             char bprm_buf[BPRM_BUF_SIZE])
 {
+    struct elfhdr ehdr;
     int fd, retval;
     Error *err = NULL;
 
@@ -3509,7 +3511,7 @@ static void load_elf_interp(const char *filename, struct image_info *info,
         memset(bprm_buf + retval, 0, BPRM_BUF_SIZE - retval);
     }
 
-    load_elf_image(filename, fd, info, NULL, bprm_buf);
+    load_elf_image(filename, fd, info, &ehdr, NULL, bprm_buf);
 }
 
 static int symfind(const void *s0, const void *s1)
@@ -3702,8 +3704,14 @@ uint32_t get_elf_eflags(int fd)
 
 int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
 {
+    /*
+     * We need a copy of the elf header for passing to create_elf_tables.
+     * We will have overwritten the original when we re-use bprm->buf
+     * while loading the interpreter.  Allocate the storage for this now
+     * and let elf_load_image do any swapping that may be required.
+     */
+    struct elfhdr ehdr;
     struct image_info interp_info;
-    struct elfhdr elf_ex;
     char *elf_interpreter = NULL;
     char *scratch;
 
@@ -3713,12 +3721,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
 #endif
 
     load_elf_image(bprm->filename, bprm->fd, info,
-                   &elf_interpreter, bprm->buf);
-
-    /* ??? We need a copy of the elf header for passing to create_elf_tables.
-       If we do nothing, we'll have overwritten this when we re-use bprm->buf
-       when we load the interpreter.  */
-    elf_ex = *(struct elfhdr *)bprm->buf;
+                   &ehdr, &elf_interpreter, bprm->buf);
 
     /* Do this so that we can load the interpreter, if need be.  We will
        change some of these later */
@@ -3805,7 +3808,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
         target_mprotect(tramp_page, TARGET_PAGE_SIZE, PROT_READ | PROT_EXEC);
     }
 
-    bprm->p = create_elf_tables(bprm->p, bprm->argc, bprm->envc, &elf_ex,
+    bprm->p = create_elf_tables(bprm->p, bprm->argc, bprm->envc, &ehdr,
                                 info, (elf_interpreter ? &interp_info : NULL));
     info->start_stack = bprm->p;
 
-- 
2.34.1


