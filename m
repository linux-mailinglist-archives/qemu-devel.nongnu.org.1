Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC3A78D018
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:14:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7ow-0003GG-VI; Tue, 29 Aug 2023 19:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6nJ-0002Ns-If
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:02:42 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6nG-00048t-RL
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:02:40 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1cccbd43250so3481872fac.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 15:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693346557; x=1693951357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RtG96b3jmli1q7lVtewuvoGgDoJMS7AqHQZel0hsDHw=;
 b=zuISEipDTVKCziWcRRcRCa/WR24i2orPvxaPumvEN2L7yH17vV/NRNhkqnHSAqxvQt
 vAluQA5u5db/553lY5BVJNl9BsAHxf3S5ZeNixfQ24FBBDlVBRjHmHGJuc5Lu+mJRQse
 imy4Sv8Z/eFOIt9siJ6xlkEtX71moX0TI6I5GnuHPK5yZuAW1lZ/9BL/R/OFgxswiDU7
 MnCBS9zPlbZ9Ondf6WDg71ttpbGWpRF/43dHzIKaNPp+A6weEjJQCTbmm4SXBTx3sZyq
 hb7l/3zcMOkMPJipZqpBTCkUAa0EONhlaScw5hZZBl1dIo3Ya6Cz1ENvvClLUtjZYfEd
 L/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693346557; x=1693951357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RtG96b3jmli1q7lVtewuvoGgDoJMS7AqHQZel0hsDHw=;
 b=eZyvbFuJX7nnyCLvqr6XJ9/af8teVwSD13Z0oZxfvEjvVgx4KK7Dyk7D9jSMoq5l7x
 UUDGkHGqKhWMGhR3v731VpLqPC+pj8Ooe46+7eTYMIOSeD1nD0z2hKoqbTEBg8YkBYd/
 HS1N00IAzxA9ZoMt/EFLZ+EiOSGAXxWeHWnZv1TTFGMce6wJotpciuZH0w/s4+jFkmIa
 xmXIVO3+G7gwwRdiDj/6+Yi954kqZg0zn5GnWTKWMtNtksY0GyPowjWEFzhGuRny/xd0
 k3Yt/cOE/b3RkBDvrHSE0aws+VCgJuSF+6OJHNz6Jml3tsUO0Mn5cqFAPHxRgnv0AxCi
 64vw==
X-Gm-Message-State: AOJu0YxYrooHJLtA2B79UlDsxBITSzS79b9XMoRR7hjYdDUcAS2ry5Cp
 tkQ5ytplcHwFQSsHy1FceZtsVa9EJkg88McRqX4=
X-Google-Smtp-Source: AGHT+IF8ltVCvYw395ZFJBncZVlSPGfJFNrFlHYBaV8q1PV0j/6t4jbaFhuv340ggwBORJBuR4oySA==
X-Received: by 2002:a05:6871:205:b0:1c8:b715:6c81 with SMTP id
 t5-20020a056871020500b001c8b7156c81mr548472oad.55.1693346556873; 
 Tue, 29 Aug 2023 15:02:36 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 b28-20020a63715c000000b0056606274e54sm9538196pgn.31.2023.08.29.15.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 15:02:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH v5 07/20] linux-user: Replace bprm->fd with bprm->src.fd
Date: Tue, 29 Aug 2023 15:02:15 -0700
Message-Id: <20230829220228.928506-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829220228.928506-1-richard.henderson@linaro.org>
References: <20230829220228.928506-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
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


