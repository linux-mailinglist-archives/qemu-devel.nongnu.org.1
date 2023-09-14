Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BA57A0F22
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:44:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgtB7-0003wB-SJ; Thu, 14 Sep 2023 16:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtB1-0003dV-OK
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:43:03 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtB0-0006Uk-4d
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:43:03 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-401c90ed2ecso15991795e9.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694724180; x=1695328980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X4SdHGLTzFQ8VoHFc5maZ2DOZP9CSCnNto04LyR/4Aw=;
 b=CNj5JNOyrfyLnWF0VT5jc04q/nowbLpN3wOFvxNNDTnUdzxxcR1XrsZSFvYZU/vI8P
 qOqn1qY1DrHOMESN60FrartcIqFgqftYzsFOYK/7FndHjVwP1dc4wR0vArZWvnTnLube
 ivsJZogdl961xtIajzedVoZOLt2LibZa1hgb/AU5TlQhGuOQYqe65H1f9VM1t/D0g2D2
 9UqV9Jw+QCOmBVHi6GI2qlocMc68+BdavmDQpBWaKvElsF14Wi0GoNTe1JuXnz/wv1pg
 BrO4hmekJ+KFoKyin1OhvP2dJ7caoonFNDuquIojmCE1hFnfOfOuwdoPVyR+5iJyxCeK
 Zing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694724180; x=1695328980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X4SdHGLTzFQ8VoHFc5maZ2DOZP9CSCnNto04LyR/4Aw=;
 b=xBnt8fULknUOVOg8fSVF7+HYmXCGtbYlQH35oRC1F3BW1jDcYAc6y0dXO7sum6fCm4
 bpT76ZTm3YHPD8IK9Wim9I67nD7C/kWxheLdjduMRufOqqd9AHhOcGQX8T7v65hHgt9q
 ZhV1pE4xdqSev7NRXQJ0UutKX/uFjMsi8IJkIeiTngOlBGDs9gSEZY7d2JoPT2HAkxGz
 Op7JZvifkdT69ATd1QsVBL8eTzLzjnj8W7ehqcsqwleUIZkWWOPEvX1fNGo2Y+pEmoRB
 RYgIDBamwReHZJVQhh9H6wQ9Y3qaVuWR281ZCtjB+2QMoqXtd/bWhi89NY8Iv9ydCcNw
 cfNg==
X-Gm-Message-State: AOJu0YyGm6vNknHNdLmp6V0xa92BWXoS0TgbXYb56pZTDHSkbV+wtSJz
 zTmeWR0tWUnGOnMz+IzqUwF75KDbCBY=
X-Google-Smtp-Source: AGHT+IGL5BUXaTSbCszuEDkxb54qhNvylPyKQQ50nzsBUdXJI+TaxVtlMaGY+G8HxI5Pz/Djfh+ndQ==
X-Received: by 2002:a05:600c:ad7:b0:3fe:ba7:f200 with SMTP id
 c23-20020a05600c0ad700b003fe0ba7f200mr5964195wmr.20.1694724180121; 
 Thu, 14 Sep 2023 13:43:00 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056000124300b0031f34a395e7sm2661880wrx.45.2023.09.14.13.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:42:59 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 23/23] bsd-user: Add stubs for vadvise(), sbrk() and sstk()
Date: Thu, 14 Sep 2023 23:41:07 +0300
Message-ID: <20230914204107.23778-24-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
References: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x335.google.com
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


