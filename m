Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5BE7DC1B4
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 22:18:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxZe0-00011c-Gh; Mon, 30 Oct 2023 17:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdj-0000z1-MI
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:43 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZde-0006Ts-Gv
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:37 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cc131e52f1so30847195ad.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 14:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698700652; x=1699305452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PZXxxvjyYdMGysXW9TK679xn7phxp04idRu5d5Pr4As=;
 b=t774i0zitop84ktHMNkDhhXMkK379t75QGfCTM0+RG5i96oQQDXRf5XD1oAB/Kz0/P
 WYWUOs3kht3AmT2Z9Q/B30gxm8Tgg49p3+fIcNoB0h39a5Y8LcSup8eHOOM7VBhEoGWe
 i5ynjEHps/VhyhBRhz6CjatuYl/s+CKFX8GsWrf8il6gS7AvAbJRgXwxt4AsWFcjdY2O
 gc2DwhaYfDkvVo+Lz1GE3cJh76kqWXAymGlltEvvLqd336AbhkESKnasPYswmYvqrxav
 z0X/9VtGzg4sX9VQOWtYSOXJzK8AUPaKJutvkASIvU+z1gLh97IiEK1o+seEUAc0VSu9
 Om7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698700652; x=1699305452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PZXxxvjyYdMGysXW9TK679xn7phxp04idRu5d5Pr4As=;
 b=mEsRgc1zy1mMB6wfRnTbE4lFgZvjH9DV1cuKyOC2TK1ZagtnaJ0fGkZY/mRlzsRSO+
 QGqslzrMp4TQels1pcyVSyHy10z+eU/ltykwAL01h/NvM46RSmwVFobf56HfYbAx0DQ2
 GnUWnW7JqbMuWQ7YtOx8gNcEzIdHyhizfckNA+Lcw+ITi0nogR0qRIbaMGepbMjKZd9e
 q+PU5wJaARzCMrDyT5Dlpn6gMvxouq9qq/E6F/U0RpZnj0y1hm8xBWQnbAfEndtE2oT4
 Thbp61ueCr4SBWGy7T5TnrSq4BvydBAxlQFIjaunCpKlRKDGmg1k3DVrMeEtCM5zYzBN
 scEg==
X-Gm-Message-State: AOJu0Yz0oT99Q4ODejFHYTPcYofsgV/2pHeZ97QueioLTTRmxcsvlR8K
 dcmfpiyOeijdKkWEfy6ag0etYHmT/TJHQElt6es=
X-Google-Smtp-Source: AGHT+IEGnl8u/vT7VEPEOFz5LMooaX5IMDTJM62KRKPgdZT7oagItHLQ6weeGlS0pYKgYU5GZgt0lQ==
X-Received: by 2002:a17:902:ea0a:b0:1cc:4625:74e2 with SMTP id
 s10-20020a170902ea0a00b001cc462574e2mr885079plg.24.1698700651962; 
 Mon, 30 Oct 2023 14:17:31 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf2-20020a170903268200b001cc32261bdfsm4670350plb.38.2023.10.30.14.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 14:17:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PULL 04/21] linux-user: Do not clobber bprm_buf swapping ehdr
Date: Mon, 30 Oct 2023 14:17:10 -0700
Message-Id: <20231030211727.165090-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030211727.165090-1-richard.henderson@linaro.org>
References: <20231030211727.165090-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
index 2e3809f03c..d5af354a78 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3199,16 +3199,17 @@ static bool parse_elf_properties(int image_fd,
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
@@ -3523,6 +3524,7 @@ static void load_elf_image(const char *image_name, int image_fd,
 static void load_elf_interp(const char *filename, struct image_info *info,
                             char bprm_buf[BPRM_BUF_SIZE])
 {
+    struct elfhdr ehdr;
     int fd, retval;
     Error *err = NULL;
 
@@ -3544,7 +3546,7 @@ static void load_elf_interp(const char *filename, struct image_info *info,
         memset(bprm_buf + retval, 0, BPRM_BUF_SIZE - retval);
     }
 
-    load_elf_image(filename, fd, info, NULL, bprm_buf);
+    load_elf_image(filename, fd, info, &ehdr, NULL, bprm_buf);
 }
 
 static int symfind(const void *s0, const void *s1)
@@ -3737,8 +3739,14 @@ uint32_t get_elf_eflags(int fd)
 
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
 
@@ -3748,12 +3756,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
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
@@ -3840,7 +3843,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
         target_mprotect(tramp_page, TARGET_PAGE_SIZE, PROT_READ | PROT_EXEC);
     }
 
-    bprm->p = create_elf_tables(bprm->p, bprm->argc, bprm->envc, &elf_ex,
+    bprm->p = create_elf_tables(bprm->p, bprm->argc, bprm->envc, &ehdr,
                                 info, (elf_interpreter ? &interp_info : NULL));
     info->start_stack = bprm->p;
 
-- 
2.34.1


