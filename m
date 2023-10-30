Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 641AC7DC1C7
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 22:21:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxZe3-00014G-Et; Mon, 30 Oct 2023 17:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdp-000101-Od
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:51 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdh-0006UM-T3
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:40 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c9b95943beso44873145ad.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 14:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698700655; x=1699305455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=srg8id7JB5fyMoPg/HaJjfZgMuzaSTlQ1OJOVHenLyc=;
 b=pStFU0Kv9HPPt97XOGB43gLyVjlEuT7fxIb6g3eOwM11EQQsbBOL0SBLtwoom3oxtu
 4s3fAEKQJb+RBKNWknzJJJBK661nkCrcFYVOMxUnCf+4pggXJqEV1oqdJCeNepKDpR4R
 AyJDiswnG83KVSqvgecUm52mQTTSeGZ8Re4UC2ImewXGIWMzIvudoAItsqItblVKsXnr
 Pl8y0SbZseSJ/Xg2d5Rt0qd6h/u+aKxI9/FAsLHMs6jdieZ5cyTsIlTE3EiQU++0xTd6
 iiA7z9t78QEMFagDGwlVbKz0qTLe+1jJTbIUcaVs4KyWc8tDSUg21Vk3Vct39Je5Hfr3
 lszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698700655; x=1699305455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=srg8id7JB5fyMoPg/HaJjfZgMuzaSTlQ1OJOVHenLyc=;
 b=PGxVIg/iOMfS812iWTrt0rxxpKbXSqk2optgeYtORL4gJPpFfEGboyQlFXfCb2ZgCz
 lLMQGSa6OpOTuEvK85hFH/JVpqZYQ4+jXNAqCpF0PBXDdV5J+ZgMOuJCf5HtKtT/tJ4e
 Sigts9Jtm7cITLW44KESPDlQNhAMJ7U8/+cdX4htkRGJt/Wt+87qA5l6O/rpSDMWJoiZ
 cExL6BuTI6sYD2byj/BrV39mu/8yDAy6jTxVYWP80NI+TJwv98+mEnKLLyayAZd2lcB1
 xzvd+6mTiKwm6RAqdVFRJArZqrrdxX8lizoE/LfvtgtluJBfdwMPKVn7vVB875U85jqL
 n93w==
X-Gm-Message-State: AOJu0YysKfITHvn3HoBf5RM7/CdfxwzCFCVAZQ3k5cKLkC2lUbSYIOon
 ov+IiI0EO8QSujZb6yuExvpziIFzjw/16NQ7vU4=
X-Google-Smtp-Source: AGHT+IFbbAS3tRx3NsyvfdLct5ew+7a5YzwHHZlbaO0iKopEoWJjapZFkrkLyT28EokgnIgIhmDpjg==
X-Received: by 2002:a17:903:41cd:b0:1cc:4e81:36a4 with SMTP id
 u13-20020a17090341cd00b001cc4e8136a4mr4348851ple.5.1698700655196; 
 Mon, 30 Oct 2023 14:17:35 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf2-20020a170903268200b001cc32261bdfsm4670350plb.38.2023.10.30.14.17.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 14:17:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PULL 07/21] linux-user: Replace bprm->fd with bprm->src.fd
Date: Mon, 30 Oct 2023 14:17:13 -0700
Message-Id: <20231030211727.165090-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030211727.165090-1-richard.henderson@linaro.org>
References: <20231030211727.165090-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
index da6591fff0..a0834290e7 100644
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
index fdcc4610fa..5b62aa0a2b 100644
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


