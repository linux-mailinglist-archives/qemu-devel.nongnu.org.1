Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8307ADEE4
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:33:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqKy-000288-8g; Mon, 25 Sep 2023 14:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqKM-0000VW-GT
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:29:02 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqKK-0007rF-ML
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:29:02 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40572aeb6d0so35526075e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666538; x=1696271338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6EwEtIsp5qS7pkISguftTlvIQuUZ+Ff4kRu6nEkFX1U=;
 b=EvmmN1pqjL4DLZh0uClVXjtOjGy1einsBjGaU2c+MYLzw6N/NxscvZUYpWsGdLTVbV
 25jOG35CsfrgUV8x0wGtzuWeHH9Xug88GBpzCqJnc6g+QV3YeZ82YuJDAvDEYv5Bk0ok
 dPEwM9Kfa44HO08qHY5hGIsZ2cNaLkBRFdswcYblG6psUimuDS/GQIq3XR30N3isgSbm
 o+sbwrN24XcfPecOyUCGXJ9sUPkzXvSmwdsc2hD894tTlQ00qMsm+qlnLjEjuBC8OpgV
 WA840PpQqOiDc5FgyNqZj6dtUtcwu2VMtY5tludHwDYzc7ctOJm0EeoPQzyprIJVbdnD
 9VWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666538; x=1696271338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6EwEtIsp5qS7pkISguftTlvIQuUZ+Ff4kRu6nEkFX1U=;
 b=Fib6GEDmBHGnojwow1D40u0AFlk46ja4Nb0QHzeFjcgkvFes3X+bKOvPJHp39/lpwa
 vU2w62DHrHku5Vb9HatZElNl15w9JDTQ8YoA42YP1Ppg/ZkkNdiU7e2UMs4f5BXtdq3X
 gA56HPU3quNWR9bilrgPYGUzawiipgNX3kDrqJXwX5MgfXtxgdhWxK0V7QagDXb8YskR
 +kOAiJFCorOE0hd+dqpItXugHgx2N32rZUnljWedmmDLEf1Dtkhno/uaKjexo40SGMNw
 UjpMAwTtvN3R80ED0XoA2xYTpPnGgK68n2hWSBz4UEhoXtdM9rPLHD3BDbUOfEkkW8Bm
 C26g==
X-Gm-Message-State: AOJu0YyLXP1UfL8j76VHrSsuHJHZzqDI5kIeot0PpiQ8jxP0vtMut5RV
 vFW0RFWWfcxtEt6D35vCScBOmlxmDIM=
X-Google-Smtp-Source: AGHT+IE0cw2casVeLYNIu5MjZpYdJeRArNzEnUm4G7evb968YPVp/M9Z9VpwfYN1trJKabKq3c7GIw==
X-Received: by 2002:a05:600c:d4:b0:405:3a3d:6f42 with SMTP id
 u20-20020a05600c00d400b004053a3d6f42mr6226040wmm.39.1695666537701; 
 Mon, 25 Sep 2023 11:28:57 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 u21-20020adfa195000000b00323293bd023sm3412320wru.6.2023.09.25.11.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:28:57 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v6 20/23] bsd-user: Implement shm_unlink(2) and shmget(2)
Date: Mon, 25 Sep 2023 21:27:06 +0300
Message-ID: <20230925182709.4834-21-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
References: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x334.google.com
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
Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/bsd-mem.h            | 23 +++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++++++
 2 files changed, 31 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index f8dc943c23..c362cc07a3 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -282,4 +282,27 @@ static inline abi_long do_bsd_shm_open(abi_ulong arg1, abi_long arg2,
     return ret;
 }
 
+/* shm_unlink(2) */
+static inline abi_long do_bsd_shm_unlink(abi_ulong arg1)
+{
+    int ret;
+    void *p;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(shm_unlink(p)); /* XXX path(p)? */
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* shmget(2) */
+static inline abi_long do_bsd_shmget(abi_long arg1, abi_ulong arg2,
+        abi_long arg3)
+{
+    return get_errno(shmget(arg1, arg2, arg3));
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index effa6dac54..f0ccd787e5 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -655,6 +655,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 #endif
 
+    case TARGET_FREEBSD_NR_shm_unlink: /* shm_unlink(2) */
+        ret = do_bsd_shm_unlink(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_shmget: /* shmget(2) */
+        ret = do_bsd_shmget(arg1, arg2, arg3);
+        break;
+
         /*
          * Misc
          */
-- 
2.42.0


