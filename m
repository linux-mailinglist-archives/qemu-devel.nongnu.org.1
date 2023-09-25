Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C8C7ADEB2
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:29:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqKJ-0000Kw-M3; Mon, 25 Sep 2023 14:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqKE-00009V-56
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:54 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqKC-0007pF-27
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:53 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40535597f01so70428525e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666530; x=1696271330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gIuhrcV4QbDTEzQ4pUfV3QzwLu3vit3RoCqbf+B/PKA=;
 b=igUYdh7RgGKorxW0nYGxNOIUe8q/GQ1GVbdBdeD+i8x2CVB+WNyV9rdot0gTwd3uaC
 sEBbJ5CzfQi52qZQ/3XiJHdN+XdCrL2aRTCvQ94QFVq4MK/m6AkOuF7Qh/JI86ah6ZD0
 +0OuICTAOPcyv0jJkZLVyouq6xOukxvJKWBSCfg4o2lLLD76VYnAAtywVgBh0f+x5U/w
 eE8OFKYVa/UGOXmqgJzlP1O73L0Pw+u+fVzDIlvA0E+cRxyaUsE4g3G5pcm2XZ1A7KJP
 PDwBI4/+3W8kXm1EKXSm4269S+7zw5YII9S629VbHyz4i/hZOo9fayGJHsVZHLQgZi9A
 SILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666530; x=1696271330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gIuhrcV4QbDTEzQ4pUfV3QzwLu3vit3RoCqbf+B/PKA=;
 b=HMIPJKi8vyVeGmseTJd/HHc4H7gG74w/FCxx46Q1y/NJE4yaExm6WaXeP3lEUDlJ8Z
 pXq67ykc33yQcsYClUQm1n6U9PqaotxU7FCWuzcsv+4n6wR7fAcFg3c+hPkVWu+AclGt
 AdG4QThdiwE2E2q3Xy7rfvXjgXkw9QIACyPaGbVf1jSo8dkyukcVPoK+DFQ19iSH7zc7
 HuGUvswwWrDIZTaQOvVle4pfdeZo428ko99evYf4oMYGUy0HTO9S65X0P5QKha6H7BgH
 9RO5KD7Dp9uOces33s1lTTUFg07gkB4afR2CAyI3Fu99Ek4kuMsabTlaXaIuEkve3lL6
 EX7A==
X-Gm-Message-State: AOJu0Yx6JBAxRK7jYF1lwGEwCZ4Mcnn3V5Ona2iEUgyullVhf8g5t52s
 klvCfcpEgzYfK0fIp+MLTFhlhzYLMR8=
X-Google-Smtp-Source: AGHT+IFfJiUFqkjiIC22TEwmaeUg76dHh98k174I9w47YPucMh0DpQxgj5hirG12AvUwjYxsddWG7g==
X-Received: by 2002:a5d:4a8b:0:b0:320:8d6:74f5 with SMTP id
 o11-20020a5d4a8b000000b0032008d674f5mr6297503wrq.28.1695666530022; 
 Mon, 25 Sep 2023 11:28:50 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 u21-20020adfa195000000b00323293bd023sm3412320wru.6.2023.09.25.11.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:28:49 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v6 14/23] bsd-user: Implement msync(2)
Date: Mon, 25 Sep 2023 21:27:00 +0300
Message-ID: <20230925182709.4834-15-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
References: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x336.google.com
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

Co-authored-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/bsd-mem.h            | 11 +++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 0f9e4a1d4b..5e885823a7 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -88,4 +88,15 @@ static inline abi_long do_bsd_mprotect(abi_long arg1, abi_long arg2,
     return get_errno(target_mprotect(arg1, arg2, arg3));
 }
 
+/* msync(2) */
+static inline abi_long do_bsd_msync(abi_long addr, abi_long len, abi_long flags)
+{
+    if (!guest_range_valid_untagged(addr, len)) {
+        /* It seems odd, but POSIX wants this to be ENOMEM */
+        return -TARGET_ENOMEM;
+    }
+
+    return get_errno(msync(g2h_untagged(addr), len, flags));
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 74c0624637..5aebb18805 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -607,6 +607,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_mprotect(arg1, arg2, arg3);
         break;
 
+    case TARGET_FREEBSD_NR_msync: /* msync(2) */
+        ret = do_bsd_msync(arg1, arg2, arg3);
+        break;
+
 #if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
     case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
         ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
-- 
2.42.0


