Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC01777E83F
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 20:06:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWKs0-00026w-O1; Wed, 16 Aug 2023 14:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWKrx-000253-TY
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:03:45 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWKrv-0001JB-EV
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:03:45 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bc8045e09dso44592305ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 11:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692209022; x=1692813822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hnWfSxPGmBDugDNsx/9arIWCUJcfcyXd41yVekLb5Tk=;
 b=afiy5sInHu265F+vBkOieYxZaCEiQ5T8C4CMDdi5wJgiaQYYs3vJFkWcKnKcFNUXFr
 n7ld/k8JdcKSx/Uf9jMY0qvbc4t0c7A0yCQPWPVqMNUPODkCEPzZf+6lO13OQJqY25eg
 EAscvJaXLkLzfCFbcttBE599yrODbGTrg/5QeZ7pLwXk5mKnROVXv+kD9Ofw/4reD3Hn
 DdQ+PXfbUY9lb39DzdA9HD12bO0WaOo7oAp9oMn0MsMwoQ6tb17jgccOPCowX4WTHuA0
 hM3FEE6cVW0By8X06GeS/OIULAX7YWuW4WmLHduEFxw5QUEclxt8xKPP8MsHjx9d/mm0
 n2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692209022; x=1692813822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hnWfSxPGmBDugDNsx/9arIWCUJcfcyXd41yVekLb5Tk=;
 b=UggmMQGWlDusSOWuTtkvd/zU/g0VdopXK1jtbrgZVPs/W/swPQ056nyJJb/jXUY7pM
 9Or8TdQ9Su7eBm8qV4nasSL9W2uEN+jn7eDns1jpMC9hSvnbbdOARBOkpRzRTdDElYCj
 ieiVvNwqLZJEjQfpV/T7VEIcYtQEXjA31HrIaBVJipRQrs+USeIyPtSvB9gqmMMT2BF6
 unBdCUAnMepmDr/I5oEfods4/4lymWQabn0qFkm6eZmJj7+18HiOvpDkkKTNyS8ux3e1
 37NPauqj5BXhFRtK71V5vQ02ITDyh6gCfZAS1DsxBHX3WaHCok0a9TUjxXuFrbV1T6yr
 rR9A==
X-Gm-Message-State: AOJu0YyMdTOO4wSs0or5aU/Z2hABCHH73pAGRycnEZsb1eoxZy2zCihR
 SYTSknJWD8SiWfTtLlYFhkLM4ztvL4HGkptARZM=
X-Google-Smtp-Source: AGHT+IEqNnIPgi/VYHZicgLkc001IjDihJ8GYsp26CzDk2SDeUjmQzcvyeacP5KA/Hxo4gGmZEjn9Q==
X-Received: by 2002:a17:902:a3c9:b0:1bc:9c49:f8ce with SMTP id
 q9-20020a170902a3c900b001bc9c49f8cemr2236035plb.4.1692209022119; 
 Wed, 16 Aug 2023 11:03:42 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a170902868e00b001bc2831e1a9sm13446584plo.90.2023.08.16.11.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 11:03:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH v4 03/18] linux-user: Do not clobber bprm_buf swapping ehdr
Date: Wed, 16 Aug 2023 11:03:23 -0700
Message-Id: <20230816180338.572576-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816180338.572576-1-richard.henderson@linaro.org>
References: <20230816180338.572576-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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


