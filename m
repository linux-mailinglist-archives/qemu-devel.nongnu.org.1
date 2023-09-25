Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D585A7ADEDC
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:33:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqL1-0002E4-AZ; Mon, 25 Sep 2023 14:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqKP-0000qC-D5
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:29:09 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqKN-0007rs-Mp
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:29:05 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4054f790190so55646755e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666541; x=1696271341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X4SdHGLTzFQ8VoHFc5maZ2DOZP9CSCnNto04LyR/4Aw=;
 b=nYXfGEmKSgBoOLJwgEPWJ4SXkrg2w0MyOYRTog953AUclMXoXA9OEbl7TUPf51BNou
 uKy9v3BHbGI3sjRpWjbjRWgP3r3h8lPI8hI4Fmh7PKa7ypzkDb3Iz+p6ixQ9MT8MwYdY
 0Sbs8IAh0Ye+cJKqbJVuCy39Mhhvxbv5nVYhHMKUYPk7MITEmDNUy6op9EF94OeOs04M
 YtCbSexI0Y5H03pfMh0fCr1Na+oqlCtJTPjAqceaj2U/HajKcfjxJp0djtbtimDVGFof
 CK63Eh1oDV+a6/PzMZjGNK+4A29pvBZX6Y4fxQVsUGnC5dzTv7j9TwiqLzEnrjtKyi3l
 rYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666541; x=1696271341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X4SdHGLTzFQ8VoHFc5maZ2DOZP9CSCnNto04LyR/4Aw=;
 b=te5GT4qR0nki7rKxIwiX06+5rDrJbNmzHIwWl1TAtm05UatLNuIKACuYnxUU1uAUwU
 1PpctjbApdaWyQdh08YR/5NxvCMCrTpVShOuPuCXsFoSVREkC8io8H0V9mzI/XpRJHcF
 Of+C6F+d+GwW8iOc8XmqyVEsYpPFLF550rBVuooKtR3X4MCG15I1Z90x5OrV2lUduTLW
 f5DvAb1B501QQCtaLImNR7Xin+uq3zVWSPglBfJvcDiTjt0NKnC5laMPnKIu39NOmqLl
 VFQZV8bHGamvC5PgmC7tFSPtmeQmwJE+jun+EHSiIkrsmJgPqgolbeMLS7lioOKdGBMc
 LP8A==
X-Gm-Message-State: AOJu0YxpKWPzSX0zkxmFGw7R/91EL7LpDFccz8qMlL40VZ2181F0AI6o
 KGAuTRQ0yAXJYohsuGunj+oQ4EmCMc4=
X-Google-Smtp-Source: AGHT+IEpRJiB1xLyDtQCm6IXVRaBtXsUvLOkv4EzFS2R8rXB03INLeJ+HL1pRXICYVOyxc94U/qYUQ==
X-Received: by 2002:a05:600c:141:b0:3fe:2b8c:9f0b with SMTP id
 w1-20020a05600c014100b003fe2b8c9f0bmr6507047wmm.23.1695666541294; 
 Mon, 25 Sep 2023 11:29:01 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 u21-20020adfa195000000b00323293bd023sm3412320wru.6.2023.09.25.11.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:29:00 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v6 23/23] bsd-user: Add stubs for vadvise(), sbrk() and sstk()
Date: Mon, 25 Sep 2023 21:27:09 +0300
Message-ID: <20230925182709.4834-24-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
References: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32e.google.com
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

From: Warner Losh <imp@bsdimp.com>

The above system calls are not supported by qemu.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/bsd-mem.h            | 18 ++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 12 ++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index c512a4e375..c3e72e3b86 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -431,4 +431,22 @@ static inline abi_long do_bsd_shmdt(abi_ulong shmaddr)
     return ret;
 }
 
+static inline abi_long do_bsd_vadvise(void)
+{
+    /* See sys_ovadvise() in vm_unix.c */
+    return -TARGET_EINVAL;
+}
+
+static inline abi_long do_bsd_sbrk(void)
+{
+    /* see sys_sbrk() in vm_mmap.c */
+    return -TARGET_EOPNOTSUPP;
+}
+
+static inline abi_long do_bsd_sstk(void)
+{
+    /* see sys_sstk() in vm_mmap.c */
+    return -TARGET_EOPNOTSUPP;
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 6b32d4df68..ce2a6bc29e 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -675,6 +675,18 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_shmdt(arg1);
         break;
 
+    case TARGET_FREEBSD_NR_freebsd11_vadvise:
+        ret = do_bsd_vadvise();
+        break;
+
+    case TARGET_FREEBSD_NR_sbrk:
+        ret = do_bsd_sbrk();
+        break;
+
+    case TARGET_FREEBSD_NR_sstk:
+        ret = do_bsd_sstk();
+        break;
+
         /*
          * Misc
          */
-- 
2.42.0


