Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 323017ADF1A
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:37:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqKp-0001gI-4D; Mon, 25 Sep 2023 14:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqKM-0000Uc-3S
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:29:02 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqKJ-0007r0-FD
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:29:01 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4053db20d03so58471365e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666536; x=1696271336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qn9zg45BrccDib3QRpTj6K0GvYzGUuL7OgrnPd2bB1A=;
 b=eluRtK6UHkoLtgydycJ03v5sxglgmEQRz/MoowtjUhzoTUp0mxYexMaXXq8JmEsw7O
 cZJUn7NP8Ld4Mto1LDl/XUtc0RoAMLJXD2gLfNQLU8GqhLVX1pVZ5Us1Ebwu7TY6ymV9
 mqUtGXbnC1ZXDMyspYlFrX9WbC/5hcJCaPr9PywpXpz6nhIZ5YfJ6F6diMYqFiSPgXS0
 wQXFs+IyuYgR7nRNeneThwtO/8ZIGfbyz+wrh0bsFyeDvuiIL9kKNNKRmfdVlfNPDx7u
 9i3EWOVATqS2FJkXkxTrxY8GQZadsU+msJw6En3Tt1C6XJSu5ke+fZhY6A0Tmi+c0AP5
 aIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666536; x=1696271336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qn9zg45BrccDib3QRpTj6K0GvYzGUuL7OgrnPd2bB1A=;
 b=vIY+HxCXVH4c9wjpMqnu1GdYeNUBFRDw8M9gDAatECLG28nIVR+Her9auPSw1duWIg
 P2E887V4F3tW/qaSbBoqq26g4XRpbqj8AELN5nc3tNo0viaUGkD5gFoXzmI6Ygn/Xe4w
 w1f9zysI86/FttFPQ2TrRf6OYA9r3ThKCMgW1Sft8HxCfHntT8SA0iS6+wEmNzyPlY+6
 5hZtrESlIWJPrwWA5ShA2BWOScLgwLm4YErydCkOkSwjPwvWk82YFVIHvTSKvgr0FOEH
 xdjylNVfA8SHBgUPJ2K1h5xhqyjY7OLgDeGMYyl4sLVhxeEiHJ380dfL/8PSGepdiOTV
 K5xw==
X-Gm-Message-State: AOJu0YwzNaCJGmzOnYg8KLR9+Zlo1T9Q1C9BUOOboXSQriMunEE/QKeB
 /KA7E7+gE/bbAGfucwy+uf3AV5DWoUI=
X-Google-Smtp-Source: AGHT+IGUulO3PUf26FpUbyneumBxownmKwy45XWDIeNzjpG6c4FIK0k8K7e5nRubf7vHSRn/TNYeIg==
X-Received: by 2002:adf:f485:0:b0:31d:c3d2:4300 with SMTP id
 l5-20020adff485000000b0031dc3d24300mr6663011wro.71.1695666536378; 
 Mon, 25 Sep 2023 11:28:56 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 u21-20020adfa195000000b00323293bd023sm3412320wru.6.2023.09.25.11.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:28:56 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v6 19/23] bsd-user: Implement shm_open(2)
Date: Mon, 25 Sep 2023 21:27:05 +0300
Message-ID: <20230925182709.4834-20-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
References: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x330.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/bsd-mem.h            | 25 +++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 29 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index b296c5c6f0..f8dc943c23 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -257,4 +257,29 @@ static inline abi_long do_obreak(abi_ulong brk_val)
     return target_brk;
 }
 
+/* shm_open(2) */
+static inline abi_long do_bsd_shm_open(abi_ulong arg1, abi_long arg2,
+        abi_long arg3)
+{
+    int ret;
+    void *p;
+
+    if (arg1 == (uintptr_t)SHM_ANON) {
+        p = SHM_ANON;
+    } else {
+        p = lock_user_string(arg1);
+        if (p == NULL) {
+            return -TARGET_EFAULT;
+        }
+    }
+    ret = get_errno(shm_open(p, target_to_host_bitmask(arg2, fcntl_flags_tbl),
+                             arg3));
+
+    if (p != SHM_ANON) {
+        unlock_user(p, arg1, 0);
+    }
+
+    return ret;
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 5cd60fc272..effa6dac54 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -639,6 +639,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_mincore(arg1, arg2, arg3);
         break;
 
+    case TARGET_FREEBSD_NR_freebsd12_shm_open: /* shm_open(2) */
+        ret = do_bsd_shm_open(arg1, arg2, arg3);
+        break;
+
 #if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
     case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
         ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
-- 
2.42.0


