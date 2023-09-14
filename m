Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6347A0F24
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:44:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgtAu-0003P0-Bn; Thu, 14 Sep 2023 16:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAp-0003L6-6u
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:51 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAm-0006O4-A3
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:50 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31ad779e6b3so1307216f8f.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694724167; x=1695328967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gIuhrcV4QbDTEzQ4pUfV3QzwLu3vit3RoCqbf+B/PKA=;
 b=BVj6KyYtk5gf+UsdGpqQLGH9m6U84AtJOix8ZmzNkxecbzVenuDqfzMxtNAFleL/eI
 7YG45DL8Cgi0yu8FP83P5XBqtIZFHQ4A70liH+Z36lIK9ggeB76oLFDbGtFaeiC8X2SR
 XZlQftvtcKRtbbSxsAPMFutf+KpjrD0+xSE5w4Y+4yZWY0rkG6NVlr3j/Q5fLkOkaQ31
 loMT0SA43wuZOUFxpveAe1NEeY4+LkH1OIveVU05QlJ6I93lcj0DKdudkg2DpAR6z2Mf
 i4g77YzLRTqJVK59x4+kaDLGgM4kBNK3q+SgOwJEF0Moi4DLaF5mG+ECBcqr6AMVM2/f
 fMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694724167; x=1695328967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gIuhrcV4QbDTEzQ4pUfV3QzwLu3vit3RoCqbf+B/PKA=;
 b=s+sY5gPsmjzzz5RcmdaUwhUBOLjrfOfmg/vOR5eQ1swywxlFhb2WpnG1H9QtD9bid4
 hQgf2y/LGakqbmNIBFFT8qSFtdbAA0WYMwwSmfHXVREWXRJtW2C+pREdrptXVfoAsgVH
 A8gobAYt1aexyoxXJQGay7d3b2nh6jx6HvCjnSaXHj8j0PxKlfKLYPsF8nopAj5pokbw
 mhBvdOicQmZFmk5ptnNCL75Y1L9SEfX2b3GZHkrKPInOO4ncmKk+cnpv1ywowJww9wYt
 uvhuWhkW4Ivh1ct9BEIofYQxvScu0j9DB1DpePORlVxpFLBMw/Ab93HIJpkY0hWYw3P0
 jWCA==
X-Gm-Message-State: AOJu0Yyf2L/+OUKcb++6dLgbFXxasPXLosMDlnFqQBO+evLMXJzPnZoY
 EGIlQ5B0ES2tXy/Ud7kl1E9X3bWjDKA=
X-Google-Smtp-Source: AGHT+IH6TtQcZrQ2gltMGp8WcKm0ils8JrlnBFvhM2FYpL4hKWpbkejY7mfZIFR+1jaaqp6ORqSC8w==
X-Received: by 2002:a05:6000:180b:b0:31a:d450:c513 with SMTP id
 m11-20020a056000180b00b0031ad450c513mr5911869wrh.26.1694724166782; 
 Thu, 14 Sep 2023 13:42:46 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056000124300b0031f34a395e7sm2661880wrx.45.2023.09.14.13.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:42:46 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 14/23] bsd-user: Implement msync(2)
Date: Thu, 14 Sep 2023 23:40:58 +0300
Message-ID: <20230914204107.23778-15-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
References: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x433.google.com
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


