Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 376DB799AA7
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 21:42:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf3n5-0005zB-Sc; Sat, 09 Sep 2023 15:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3n2-0005xk-O4
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:44 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3n0-0003EH-Km
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:44 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-401da71b7faso36636245e9.2
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 12:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694288320; x=1694893120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7eYQSo99m8Jb6VuAKy20SyQjPPkVXbzKZOriqtp/fqQ=;
 b=SA03Fk6RNdai2Nl8CZaAng3tJPAV/0kGAvvHEsh/4T5vmP6+aT7mlQZ5ogKTin+zbW
 AhmLvfBeSOIdk+pek7q4h0cfqBR7e4f4IydBrzE3ZgF2oYXv59D4t4jMD/scZvu4F7Lt
 XZwggqDm51xxK7wohgoXO1jwjWTGq8jTmx/V+8+IkX1NvJj6MkAQO6FmB40LO3G1KuAQ
 WaDjYlHbBS+pju1WHpxOj3chR1DvAru1O8X9FRFsm+XYheWvlZ94zh8LCJS2lQ/wTX3B
 tKnrfqPPgA5PV3jNbL1vht+spEASQyy6BvE8YkU405zGEOwXhRTKo10hAf4oP+9R1uxC
 otKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694288320; x=1694893120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7eYQSo99m8Jb6VuAKy20SyQjPPkVXbzKZOriqtp/fqQ=;
 b=uaSO3+sizb9RqyTEuFkA2ff9GniQom6BvysXKrhEuUFdl1EuD8L5NIPdZTYZQm9ahR
 0XqJpau6KD04fsE/Ba1peEuOW6DGxiOg7CXwCKBHfOJ9zTBaJdbMgcwxMATkXJZKQMNR
 GPfw2R+iRdhDwD+8WN52uEieEvt64U6poq6BvehRwik2W6dmq60OKctvOvgLiZFriH/3
 31r7lJQfvoVY0nB0sSmuF/n5nV0JpGXxHq0bHUosnlYMYfGB/fZwmW7zJTle/sp3IzLk
 kwL+13rv9kUS6kWcPfLManwJlScdrwDZ9VBuoJlJ5R8+YXwjPUESh0A130hxbVq46dIG
 RM3A==
X-Gm-Message-State: AOJu0YwWSm0wcblNobTy1R8afUcu374JrrEJeFl5f3Fpnj58daKFe8Ti
 cVnez52ZGtAE3rghPGCsDerGrEZGUg0=
X-Google-Smtp-Source: AGHT+IFi2SqsVQjcKn6BDSHtrLyibvQ3BjPc9zeIF+GkYAvkH3aEAn4Nl5j2bGopqKXFIxGxUDpxOw==
X-Received: by 2002:a7b:c3d0:0:b0:3fe:22a9:907 with SMTP id
 t16-20020a7bc3d0000000b003fe22a90907mr4628598wmj.20.1694288320418; 
 Sat, 09 Sep 2023 12:38:40 -0700 (PDT)
Received: from karim.my.domain ([197.39.250.27])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c260d00b003fe4ca8decdsm8612812wma.31.2023.09.09.12.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 12:38:40 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 13/23] bsd-user: Implement mprotect(2)
Date: Sat,  9 Sep 2023 22:36:54 +0300
Message-ID: <20230909193704.1827-14-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Stacey Son <sson@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-mem.h            | 7 +++++++
 bsd-user/freebsd/os-syscall.c | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 76b504f70c..0f9e4a1d4b 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -81,4 +81,11 @@ static inline abi_long do_bsd_munmap(abi_long arg1, abi_long arg2)
     return get_errno(target_munmap(arg1, arg2));
 }
 
+/* mprotect(2) */
+static inline abi_long do_bsd_mprotect(abi_long arg1, abi_long arg2,
+        abi_long arg3)
+{
+    return get_errno(target_mprotect(arg1, arg2, arg3));
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index d88f62319b..127805e079 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -495,6 +495,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_munmap(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_mprotect: /* mprotect(2) */
+        ret = do_bsd_mprotect(arg1, arg2, arg3);
+        break;
+
 #if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
     case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
         ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
-- 
2.42.0


