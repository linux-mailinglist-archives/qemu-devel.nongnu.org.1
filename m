Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DDB779543
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:52:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUVLw-0005ll-0K; Fri, 11 Aug 2023 12:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUVLq-0005jd-9C
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:51:02 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUVLo-0001MM-Jp
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:51:02 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-563f8e8a53dso1423477a12.3
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691772659; x=1692377459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RtG96b3jmli1q7lVtewuvoGgDoJMS7AqHQZel0hsDHw=;
 b=UiXW5TU+wILTYLNL38oY7ZT/faQ7p/gDcFPljcXnk6DSGenvZNoESlruX7ncDUIMce
 8Iji+wBNTXPbiOoyBDIXHILZaML2e0D6FXq42ACW5bKdCt1vt9Sbb4CdEVjbNLkYgiWc
 Oe9gNO8gLRhV+Mtzw7HZiK2FsR++V2LHzCsq/XKL4Zw9kwsnTV6PlJLxQjBZibgCP8qw
 miT7dxQVtWNRcwJrD6QA5qqkxGgoJ4gmRdV1pQT09XzYVoyX4HowicRLnL4SZdUMczHu
 QqmEseRP5+P/85btDUAUpWWF3ATHeLecqm1oVnQznzldpS7NdVCqbVqTeM3OSZ3xreO5
 zRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691772659; x=1692377459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RtG96b3jmli1q7lVtewuvoGgDoJMS7AqHQZel0hsDHw=;
 b=E4q48YgXaGVUtrrZFC9DoiEUOSjEaZ5t81YSCvUiGPLoztm//QmCUyQHQ2bt6JijL+
 Z5Km7eyZ2U7dPbiTn+X8h6pq6ZHHnwDJTZaGBtebHq4j3m31U35pRT59jNA9LusRIZpc
 hsnG/qttUtM3iElhS+bEEipF+GvyMPhIHQCPyfFkOtByEGQAhKFUGJV9/2fTKpeX3D+y
 jriJiJJxBHpcr0RAeeWEpvFuAa1nciQjsCQmgmtOM9iQ6JKIeLyQ1jgjiKbxwnkl/JqF
 GXPAFdSrvYCeOwQY1RsmKyzJtKwZPmqxVoTvYrnh3t48/cnfGZhKKCbjCGMp6J4I9/1P
 d4mg==
X-Gm-Message-State: AOJu0Yw6c8c/nD5TX2xfqAFZZUpTYKMekzY0GVts0mSxne0PHO0e3T2y
 Gl/rNXxlzQdMiXSsI/vJIX+j1VFTbAiRikWN60w=
X-Google-Smtp-Source: AGHT+IHIMgTxDP9r/zi0dsqcy/vqrOd4NWH8AQs6/65aUsNZE9OuMk/yB+NDjUnccXMWmIirJkq+9w==
X-Received: by 2002:a17:90a:f3c7:b0:267:e011:3e9a with SMTP id
 ha7-20020a17090af3c700b00267e0113e9amr1597673pjb.3.1691772659260; 
 Fri, 11 Aug 2023 09:50:59 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 22-20020a17090a19d600b00263d3448141sm3803713pjj.8.2023.08.11.09.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 09:50:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pbonzini@redhat.com, philmd@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH v3 06/15] linux-user: Replace bprm->fd with bprm->src.fd
Date: Fri, 11 Aug 2023 09:50:43 -0700
Message-Id: <20230811165052.161080-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811165052.161080-1-richard.henderson@linaro.org>
References: <20230811165052.161080-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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


