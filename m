Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 507077A0F1E
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:44:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgtB2-0003Yi-4w; Thu, 14 Sep 2023 16:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAx-0003WT-QT
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:59 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAv-0006RA-P9
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:59 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31fa666000dso1248084f8f.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694724175; x=1695328975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qn9zg45BrccDib3QRpTj6K0GvYzGUuL7OgrnPd2bB1A=;
 b=nSXTLAO6/EHEMPOgSRqCK3X4+/Mo064eny0fg6ftmyHP8z1hEUBa17NeYIIsz6GL1Q
 n0XffjaYIH12EJ1gzFacihvtpXGz3Wp/t6bAQI68aVspKpvTzZKC1eKVgn7lAoESuhyE
 mzAUDLGY/n3Mi9tni95/J6MX/fmjOYfbDNq2x3cp6BXAEGtlXxzQf6Ww0dC0EhwBS5Yd
 eNwuJrH6+7GUn7CX7HvRW1k54Xc7V6emMd0q4ZlnYnowAiLj7qeyFkQnJoilA5MapXBj
 LnXHyZJJVKEoEgncc6JrdUzc1CinP61uVIow7mXsmMav10ROJUcWk6cRrwSMfmS/CTg1
 IKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694724175; x=1695328975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qn9zg45BrccDib3QRpTj6K0GvYzGUuL7OgrnPd2bB1A=;
 b=mbvKfx00FQhjcIwcNGBfN4/iXbMgrP9EvY0moq+S6kuZIKRPKJTurowJRP71KprKZn
 GGAnBu+BY3KNibaqcpqq2iz9DabC22l9w69DnFeDGIZAfqrq3TGt+cfgixZDMWnXsaj0
 G1VLP4u/ngNpxszupRLj9lzucRDXJNa3sHyA5ia54QpcEFOUQsDS8VSQrP7fl6+Hbg22
 OLhE83pVqDjLASXkhynk56ytUHo4n/d5sXud0g+jkxx7iJTmVj0gpyj0cwUANreHIiPR
 R8I9t2fiK49MvpBAii4+Ra5ICLnr/MUNkYwzdZRtGBLWybNFqjk8U0wrb8sBsfg+pfIT
 fXtw==
X-Gm-Message-State: AOJu0YzOIfcN0FjbQm8teVyd76teTnttF5SQzqQaoodBd2YEsGVfJ1zn
 zM2OyTa6lfdWvwxaNei6nC467F9jSR0=
X-Google-Smtp-Source: AGHT+IGQSZ5zJxDNeJMjPhcrNpD/QB6tJLQC7IPL4twcFcbjTGZ8Y+0r94fMjEKLxXXRb/+63HzeKw==
X-Received: by 2002:a5d:4086:0:b0:31f:e418:223d with SMTP id
 o6-20020a5d4086000000b0031fe418223dmr1918413wrp.7.1694724174661; 
 Thu, 14 Sep 2023 13:42:54 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056000124300b0031f34a395e7sm2661880wrx.45.2023.09.14.13.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:42:54 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 19/23] bsd-user: Implement shm_open(2)
Date: Thu, 14 Sep 2023 23:41:03 +0300
Message-ID: <20230914204107.23778-20-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
References: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42c.google.com
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


