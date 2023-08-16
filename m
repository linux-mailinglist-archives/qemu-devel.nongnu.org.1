Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD26877E83B
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 20:05:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWKs3-0002Bx-EI; Wed, 16 Aug 2023 14:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWKs0-00026u-4V
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:03:48 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWKrx-0001K4-TW
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:03:47 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bdca7cc28dso38507695ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 11:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692209024; x=1692813824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RtG96b3jmli1q7lVtewuvoGgDoJMS7AqHQZel0hsDHw=;
 b=OYZ6xemAXvjp939jMTyaTd9OpdU7rtzYEsDef4uXacOVOm5rk3gn+vph1H5b5iu48q
 hTdFi5MkMx/pqiGHRW6R3rvzx9wFL0oPM+kvSpyXszxgbYFRqNoG8Lyq8o3hMRPM8DI4
 XoNvd+CMJ5ZcZDPs24DTP6HF9EQ56Hd9/6ErIcGQ6j1fmzy+3BDpWo2olfMtCiAT/E8w
 wXxzJiGd/TiGv0LceuyhhBQJ3VET8ExthQd/V0Gj2BKp8LbJfZELuqSiNTtYVENU4EOz
 6t+d09iMrw9wlbEJVyD5xoaZUaSFPn8TPTDPrbGy20ioO46ntTQOFCp6H2OE8iI1SrAC
 031A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692209024; x=1692813824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RtG96b3jmli1q7lVtewuvoGgDoJMS7AqHQZel0hsDHw=;
 b=EeJDpqCkfaIu3meEYcXtWl2+Vl2nhvYjmblvcBBU0/XaQxBjD1Dd9EzzxfIt86lLvJ
 qlm6IMdRxCMZR4xPMRiV4LlrFaVVjzHjjPg4iTT6gd7DhEjuOFl3rKQEL81yQbdXF7bR
 KFMlUCnAaqHcJtMKtVCf+HVIhQ8nFwEKxbvd3MTot/Majj/OufYZIIQyVgqbdm/oByug
 sx/5oq9h+Q8TSO8kIv8k6EkGZcjee59iGNQckkvmaSriq70ky13C6ee1aBB2TYIFhGPg
 7kpKCIU3Sp/dF3diAoJtlGcPU/3C+vi9O60pg3XZno/ahrwdxgKk4p072LjTFCcOwqjp
 6V+A==
X-Gm-Message-State: AOJu0YzBgsZR5owSFKIn97BJF5sYlCG7Vl+XZghBMg0mbP/twlxIUWB2
 vzs2vHcJ4wXJypkuzvKcB+5HBVS7LrJjbIaqbn4=
X-Google-Smtp-Source: AGHT+IElbCT/zV9myCRNSP2t0yHxVrBE2mMI/P1J2Mj+Q4/FddFJOc92GMr+NsJs6BT1XdKPK+UDww==
X-Received: by 2002:a17:902:c943:b0:1bc:6c8:cded with SMTP id
 i3-20020a170902c94300b001bc06c8cdedmr2831020pla.67.1692209024447; 
 Wed, 16 Aug 2023 11:03:44 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a170902868e00b001bc2831e1a9sm13446584plo.90.2023.08.16.11.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 11:03:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH v4 06/18] linux-user: Replace bprm->fd with bprm->src.fd
Date: Wed, 16 Aug 2023 11:03:26 -0700
Message-Id: <20230816180338.572576-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816180338.572576-1-richard.henderson@linaro.org>
References: <20230816180338.572576-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

There are only a couple of uses of bprm->fd remaining.
Migrate to the other field.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h    | 1 -
 linux-user/flatload.c  | 8 ++++----
 linux-user/linuxload.c | 5 ++---
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index 311d20f5d1..5b4cdddd50 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -74,7 +74,6 @@ struct linux_binprm {
     char buf[BPRM_BUF_SIZE] __attribute__((aligned));
     ImageSource src;
     abi_ulong p;
-    int fd;
     int e_uid, e_gid;
     int argc, envc;
     char **argv;
diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index 8f5e9f489b..15e3ec5f6b 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -463,7 +463,7 @@ static int load_flat_file(struct linux_binprm * bprm,
         DBG_FLT("BINFMT_FLAT: ROM mapping of file (we hope)\n");
 
         textpos = target_mmap(0, text_len, PROT_READ|PROT_EXEC,
-                              MAP_PRIVATE, bprm->fd, 0);
+                              MAP_PRIVATE, bprm->src.fd, 0);
         if (textpos == -1) {
             fprintf(stderr, "Unable to mmap process text\n");
             return -1;
@@ -490,7 +490,7 @@ static int load_flat_file(struct linux_binprm * bprm,
         } else
 #endif
         {
-            result = target_pread(bprm->fd, datapos,
+            result = target_pread(bprm->src.fd, datapos,
                                   data_len + (relocs * sizeof(abi_ulong)),
                                   fpos);
         }
@@ -540,10 +540,10 @@ static int load_flat_file(struct linux_binprm * bprm,
         else
 #endif
         {
-            result = target_pread(bprm->fd, textpos,
+            result = target_pread(bprm->src.fd, textpos,
                                   text_len, 0);
             if (result >= 0) {
-                result = target_pread(bprm->fd, datapos,
+                result = target_pread(bprm->src.fd, datapos,
                     data_len + (relocs * sizeof(abi_ulong)),
                     ntohl(hdr->data_start));
             }
diff --git a/linux-user/linuxload.c b/linux-user/linuxload.c
index 5b7e9ab983..4a794f8cea 100644
--- a/linux-user/linuxload.c
+++ b/linux-user/linuxload.c
@@ -39,7 +39,7 @@ static int prepare_binprm(struct linux_binprm *bprm)
     int mode;
     int retval;
 
-    if (fstat(bprm->fd, &st) < 0) {
+    if (fstat(bprm->src.fd, &st) < 0) {
         return -errno;
     }
 
@@ -69,7 +69,7 @@ static int prepare_binprm(struct linux_binprm *bprm)
         bprm->e_gid = st.st_gid;
     }
 
-    retval = read(bprm->fd, bprm->buf, BPRM_BUF_SIZE);
+    retval = read(bprm->src.fd, bprm->buf, BPRM_BUF_SIZE);
     if (retval < 0) {
         perror("prepare_binprm");
         exit(-1);
@@ -144,7 +144,6 @@ int loader_exec(int fdexec, const char *filename, char **argv, char **envp,
 {
     int retval;
 
-    bprm->fd = fdexec;
     bprm->src.fd = fdexec;
     bprm->filename = (char *)filename;
     bprm->argc = count(argv);
-- 
2.34.1


