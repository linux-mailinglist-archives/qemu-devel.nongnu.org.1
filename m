Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 897E077952F
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:52:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUVLs-0005k7-Mz; Fri, 11 Aug 2023 12:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUVLo-0005j1-LC
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:51:00 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUVLl-0001Lg-Uo
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:51:00 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6bcade59b24so2038217a34.0
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691772657; x=1692377457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hnWfSxPGmBDugDNsx/9arIWCUJcfcyXd41yVekLb5Tk=;
 b=yYlUuYX5gu3gIL2BRMy7+/gMG9zVkJcO9M8aInowUWTth07HGlKCak3saAXJsJbafH
 vkx0ZgglRCk6sy9Gmp9t0lkL2PiM3Iz9TvJZsSlBb5qY+nzBueZMV6irCx0KS1OHuUfG
 mZzYlS2rqV9OtH/sd+U1pNkanBMtIK6W5cCeaz8cl/SvQtpt50a5ooLQKUcF2pkhXf8p
 B7rPALCJYLy5hEF9hud1R2jkrx1njHrG6A+PYbM5aOK8DSP9xpjpbwIKgtcF7taMOfaD
 PxR3LUstneohFTeF8owRYA7S3EaaZM0m3yIKPBYuaTmk0PfjSTkUAwJtmKs6kfayTav7
 6ZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691772657; x=1692377457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hnWfSxPGmBDugDNsx/9arIWCUJcfcyXd41yVekLb5Tk=;
 b=WQOy/2nBoB6TVccjtcVBHR6A4ONGBmn7EOFORtnaqqugdmOCQswi4pdcvV5bDRT+lm
 onUjlhRm6w0j2HAuwbIdXvSnOzrqvPmqedX3yR84hqH2oRKuelCuU2W21SZMVwG912Jz
 ZwEz8LaUIkESQ8sQsxlzffoNvTeaJ/E1JJOTd0ZBYjtRerMNTodowtXn+zv3PJ4g7csh
 BhxRx/2BbBncGU+dvGKFHZ1n0KK4k8nHvsPBomMLDTZgdXUvJpNp+5Sm8z3jWqJ1Q4wD
 5YszuFeIDJRxHR8a9ecL6WLcydXla67lhDvGbA8Q9Q9nHwGKN6vviHiKGUjvZ06ij4rX
 BgNw==
X-Gm-Message-State: AOJu0YzvCCMqAsb0x4bayQ7hwVPWnJAq2JhUlUuteYNiMG2OU3eXtnFW
 NOaKujYIObskzGE7TZ6vk7Hz1X+lIRfqsjHeW4k=
X-Google-Smtp-Source: AGHT+IGGJXzP/A5dv0s6/pUDHgYDMIfoEYZeHoo505tGLmhM5raGKxOlWschXhFXMnHnUQCbzqking==
X-Received: by 2002:a9d:6d93:0:b0:6bc:de9b:a3e6 with SMTP id
 x19-20020a9d6d93000000b006bcde9ba3e6mr2475520otp.24.1691772656794; 
 Fri, 11 Aug 2023 09:50:56 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 22-20020a17090a19d600b00263d3448141sm3803713pjj.8.2023.08.11.09.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 09:50:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pbonzini@redhat.com, philmd@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH v3 03/15] linux-user: Do not clobber bprm_buf swapping ehdr
Date: Fri, 11 Aug 2023 09:50:40 -0700
Message-Id: <20230811165052.161080-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811165052.161080-1-richard.henderson@linaro.org>
References: <20230811165052.161080-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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
index ac03beb01b..11bbf4e99b 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3019,16 +3019,17 @@ static bool parse_elf_properties(int image_fd,
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
@@ -3343,6 +3344,7 @@ static void load_elf_image(const char *image_name, int image_fd,
 static void load_elf_interp(const char *filename, struct image_info *info,
                             char bprm_buf[BPRM_BUF_SIZE])
 {
+    struct elfhdr ehdr;
     int fd, retval;
     Error *err = NULL;
 
@@ -3364,7 +3366,7 @@ static void load_elf_interp(const char *filename, struct image_info *info,
         memset(bprm_buf + retval, 0, BPRM_BUF_SIZE - retval);
     }
 
-    load_elf_image(filename, fd, info, NULL, bprm_buf);
+    load_elf_image(filename, fd, info, &ehdr, NULL, bprm_buf);
 }
 
 static int symfind(const void *s0, const void *s1)
@@ -3557,8 +3559,14 @@ uint32_t get_elf_eflags(int fd)
 
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
 
@@ -3570,12 +3578,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
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
@@ -3662,7 +3665,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
         target_mprotect(tramp_page, TARGET_PAGE_SIZE, PROT_READ | PROT_EXEC);
     }
 
-    bprm->p = create_elf_tables(bprm->p, bprm->argc, bprm->envc, &elf_ex,
+    bprm->p = create_elf_tables(bprm->p, bprm->argc, bprm->envc, &ehdr,
                                 info, (elf_interpreter ? &interp_info : NULL));
     info->start_stack = bprm->p;
 
-- 
2.34.1


