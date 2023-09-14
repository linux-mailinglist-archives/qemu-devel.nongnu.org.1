Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1397A0EB0
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:05:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsZw-0003MJ-Ob; Thu, 14 Sep 2023 16:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZr-0003IG-5d
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:39 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZo-0001ci-7M
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:38 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-404732a0700so10114135e9.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694721871; x=1695326671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0VfkzU3g4TZJQAxsKU6UmdXYGb19ZcCTqRB08BetneE=;
 b=BgFqUM52x79XlccB8c/iFUEdKSijwmHSTq8zHXKhCldi+MKtpg8Hn9obSieOPyNbI+
 APCzE7PJuxKS/YL3nSceiy7YGT2hsJw+ujCaDbDYmXtqE+lwnbWZ0zoVtS0zg07Wp2Fp
 4FjPGtBLxgSbLiE6ToKo9tb7jBs3wUbm2hXIDnlwmT56vgqq1mn6JTnDawUN6mIaXDKr
 MZP5B0mLz2jdCMbkbktE9XKJ3s57uy4ruEcgn3S6jXzSwlCCx2wU/ha28c/pNwQNDaME
 /feWya1w8idojUB+Bi6nne0WCteUfW8m6B8xzJzDtEie+CNUZbj51juSGnEJVykVGAz5
 xETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694721871; x=1695326671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0VfkzU3g4TZJQAxsKU6UmdXYGb19ZcCTqRB08BetneE=;
 b=P2PMyKjXYhAARokKS54Gl8XHsdecN+QlFZwVa+WJ+nUOGjHq+7rTQ/67HO7y+EpUAE
 9ZFk3GwggJLSzQtfnv37IanWlK2UqaWS5GbaU5DKBs/Qc+U0CqJRaoY7x2A2czH9XGKq
 77X34b76xSBkSKPWacNADf0IoldAO4Z1g0lBNIXqQOtJAj7xfMaCnmkZoZZKHLhxinEl
 cjdOfGEiCT9YaYijHJHt/DrOjz/zH5M+BCpRwC1IURdxMdcCuJHoM78zLm01rFvA2jFK
 A27GlzqslsvnVaT/GfajhdIWt0IcO+CImlchLkQLL+/kE0GoplLPgnJptBzS+wRAzpuS
 QeIA==
X-Gm-Message-State: AOJu0YxgPqeSaQJym87qtzGdETa09l5DE8gw42Ab/poQLiEaAbwFoyRr
 tnZhSGWO22HHOs0T6H+tIQbGWkkBOro=
X-Google-Smtp-Source: AGHT+IHY519GyI5rQomek66FTnCq3GZrbFrJNS1wBApY7zWL9U+FPZ8cwNjXnCsRLg3ML+yxxre2qQ==
X-Received: by 2002:a05:600c:21d2:b0:3fe:1b4e:c484 with SMTP id
 x18-20020a05600c21d200b003fe1b4ec484mr5410388wmj.5.1694721871366; 
 Thu, 14 Sep 2023 13:04:31 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a7bc7c7000000b00402bda974ddsm2851130wmk.6.2023.09.14.13.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:04:31 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 19/23] bsd-user: Implement shm_open(2)
Date: Thu, 14 Sep 2023 23:02:38 +0300
Message-ID: <20230914200242.20148-20-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
References: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32b.google.com
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
index 8dd29fddde..7404b0aa72 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -531,6 +531,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
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


