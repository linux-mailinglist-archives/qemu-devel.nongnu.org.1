Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F2278D031
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:18:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7mv-0000jI-6f; Tue, 29 Aug 2023 19:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6nF-0002NK-Bs
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:02:37 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6nC-000489-So
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:02:37 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-68a42d06d02so3440244b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 15:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693346553; x=1693951353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YtpDBOXKHVSEIF4Yn08bUEAK6iy270wE2qCEwjH4NwE=;
 b=JqA3/s/W4ZhFfGgUhnqLP3oTJLjjQIsYIod0ZjJxffTbSXAd3QPFivcun7uTzeBXNx
 B5BOaJWB2M2U9TWK+EHukqZdPpo3gX4RkMjjZuBIiDDNAyxXTdO15q2URRFNiTNI50T7
 D5iFcbFd03gRgADNsYABMi0XsSQpVmcj7r9jYNGrTPb2LQBApbZUxKKc7tCE6O0v8PE8
 8J9wZqDw5HgjoaLGBhw6ek4HgflGjmmbUxD5qQf9DQutcOy9Lmuh4aZ1lv5wpcBIzaVw
 pTG1IikIqrMLpCQ1jOACQNyVsYmhbRmQbni/b67sff5Vt2kbq8Z3RrVNUvRfRIOfsMuo
 qfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693346553; x=1693951353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YtpDBOXKHVSEIF4Yn08bUEAK6iy270wE2qCEwjH4NwE=;
 b=S/IynLuVMGSrqPIUpMNyl3HduaIGqOyXVycxIBYLK23niV5oxrPnbugzn3dkWdKU9u
 xIGaSyvR/I8SNbj28HTnD17ITbLrJX8IZOft7uBINSBwR5mJqNfj5Ccuwr+bxmzzbsjx
 mZisKm7Ev+QgRmk9h4ov38L311OXhEpza+IPm0O68Rra5zJM7AQHkhLfasabUd4y90bg
 AY7qQemaRKGIc1vqdkmR0LoHFEfIGqa2FYFNJ+9WKjCXDzXp6HOrHPk6LAWIiu8qN5ot
 uDwxC77qmXasbeLVHUTpvekfE3xktluevqBOP5/CPYVC/3Mt0iZmLrGVrP6Hnu5TKNvn
 9LPA==
X-Gm-Message-State: AOJu0YwMcMXGrSXdQFjZbQyGWGxj6TGE2sLehoDnimlqv4hQZfgeoP4L
 g9H3CXSOBgU8WCOoB7lOxOOQEf6LPDRUX9pB0F4=
X-Google-Smtp-Source: AGHT+IFIJ3N/JkRRGucB4+WzFXcDKFBwzScVLbt97V/7rwPSFo4yVvJc7Xai80JX13qnyfAuvcpAHg==
X-Received: by 2002:a05:6a00:3393:b0:68c:42:d3d7 with SMTP id
 cm19-20020a056a00339300b0068c0042d3d7mr457649pfb.25.1693346553526; 
 Tue, 29 Aug 2023 15:02:33 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 b28-20020a63715c000000b0056606274e54sm9538196pgn.31.2023.08.29.15.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 15:02:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH v5 04/20] linux-user: Do not clobber bprm_buf swapping ehdr
Date: Tue, 29 Aug 2023 15:02:12 -0700
Message-Id: <20230829220228.928506-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829220228.928506-1-richard.henderson@linaro.org>
References: <20230829220228.928506-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 92b981c445..4d3b25ed14 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3020,16 +3020,17 @@ static bool parse_elf_properties(int image_fd,
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
@@ -3344,6 +3345,7 @@ static void load_elf_image(const char *image_name, int image_fd,
 static void load_elf_interp(const char *filename, struct image_info *info,
                             char bprm_buf[BPRM_BUF_SIZE])
 {
+    struct elfhdr ehdr;
     int fd, retval;
     Error *err = NULL;
 
@@ -3365,7 +3367,7 @@ static void load_elf_interp(const char *filename, struct image_info *info,
         memset(bprm_buf + retval, 0, BPRM_BUF_SIZE - retval);
     }
 
-    load_elf_image(filename, fd, info, NULL, bprm_buf);
+    load_elf_image(filename, fd, info, &ehdr, NULL, bprm_buf);
 }
 
 static int symfind(const void *s0, const void *s1)
@@ -3558,8 +3560,14 @@ uint32_t get_elf_eflags(int fd)
 
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
 
@@ -3571,12 +3579,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
     info->start_mmap = (abi_ulong)ELF_START_MMAP;
 
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
@@ -3663,7 +3666,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
         target_mprotect(tramp_page, TARGET_PAGE_SIZE, PROT_READ | PROT_EXEC);
     }
 
-    bprm->p = create_elf_tables(bprm->p, bprm->argc, bprm->envc, &elf_ex,
+    bprm->p = create_elf_tables(bprm->p, bprm->argc, bprm->envc, &ehdr,
                                 info, (elf_interpreter ? &interp_info : NULL));
     info->start_stack = bprm->p;
 
-- 
2.34.1


