Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7A37B3D99
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 04:18:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmPWN-0000FP-6m; Fri, 29 Sep 2023 22:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmPWE-0000Cw-FI
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 22:15:48 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmPW7-0001zE-Dv
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 22:15:45 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-27740ce6c76so7673020a91.0
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 19:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696040137; x=1696644937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ouERXhFg7ctw5OaSYt/bZqEXdIR4bSp1DDI90gb5MGQ=;
 b=a2u5zah1GknLt1Scgd+y0T5fWvaGZlVm04DxmbA99Iu6NjknTTaOH8d6DvEfrSYJQn
 eANlANGa2BqYqCIJTgzq7m1ODR1UaaInkThvRxyZB5gdK2fuI2njwmeg+uYOvxWxKuhR
 s6F1zvdhmJMRyZPufbSFC1VfkqrCawZfg85x5F963Ym4DVsy0RTgQxVd+pJHGfToCteQ
 nZBc3+m3rAt5SdBi3FQK3cMUMnNA3nREHemnyssXQEkMA/hzx8I6tFfeJTIU2e1a3gkk
 PkcqzhS8QAu0CoWnSlgQZLdKGEZRccahG32n38RUbPeG8eOt8QG8YqswewbkobuIV22k
 sP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696040137; x=1696644937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ouERXhFg7ctw5OaSYt/bZqEXdIR4bSp1DDI90gb5MGQ=;
 b=xK2EgH6QOP+UudWr322Mf8iyfKT73V08jua+KjZLF7NY+GdX4Y4Y9eDdqYi+PJz4ZJ
 yn0JtiZXLIXusS8kPaVcqWBo1UtMCS5DBzDDVmn+5/lRQk4YqqqN/+b7Uwd4afpAopYl
 RrzVhlj4K7gY4HhZaXckav8IV/v4VFDN4ha5cdFzs5K1ETv08vr/hA/kL8NTdN9QRol4
 EqfJQ1DZGtvRhl8bc7Dm4oG/3Ze+N4+QDs9lIiJFz8vw5AAHd1rw17OGh5/S5HkbJ25+
 58hn6fnK46yPehKLWbUgqgsOP/mSDM/X1LOmZflKanbi7X2dY1FR59o9512QsbPa4tE1
 11Rg==
X-Gm-Message-State: AOJu0YzexV485zjVMMA5wr9dyr3DnfZOmgenup94+Iyvh4P3IbHXWdOs
 VEJHLzfjmIbScYCM3OrHljmVXBSn07ZjGfGRyrE=
X-Google-Smtp-Source: AGHT+IFMqylJTvX7RGWQYUQvZn0yPlqocDaSFkBYcBTnBiRhT4dAJO4AcxPmKBcK8PNsxISaZr4qUA==
X-Received: by 2002:a17:90a:17af:b0:273:ec96:b6f9 with SMTP id
 q44-20020a17090a17af00b00273ec96b6f9mr5739703pja.25.1696040136945; 
 Fri, 29 Sep 2023 19:15:36 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fv21-20020a17090b0e9500b002775281b9easm2130692pjb.50.2023.09.29.19.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 19:15:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH v6 06/19] linux-user: Replace bprm->fd with bprm->src.fd
Date: Fri, 29 Sep 2023 19:15:16 -0700
Message-Id: <20230930021529.987950-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230930021529.987950-1-richard.henderson@linaro.org>
References: <20230930021529.987950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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
index 4331a11bf0..0811f32aaf 100644
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


