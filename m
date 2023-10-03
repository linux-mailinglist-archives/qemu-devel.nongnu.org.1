Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0F97B7564
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:44:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovp-0004TA-0L; Tue, 03 Oct 2023 19:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovk-0004M5-M7
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:57 -0400
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnova-0007S7-FL
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:52 -0400
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-79fb64b5265so61150539f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376145; x=1696980945;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fs1dcVqCXTX8RM3B0vVfSAr/XS18s4HpUbI3OIrGI0Y=;
 b=KTK9fEh5MZYKXqqouRY5vncDUHC4jS6OHf0XghSOL/6648bBUkQvySwJqOnZ92caGW
 PXjGSyYcZKiYYjY02T27lXQ6l7IP8bCpTj4YO76Xh3xtLaBQUgi3PRvDdWbWdhspofX5
 LvvDLz3asDdnR8vRSlFvFExUCvU9oXItKNaSp0aI1tdLRHk3mFpE0Bgi1CM04nCZvFeD
 Qv4FKoNYiWEkPaU58ZuFsHQEQevKEI/sNm15D6XkWpvvQ0owIrQH99tSj8xj5jPQ9orW
 YvKv/kVWlVZ7hgVS2NRiBEwo+Epbrzhu3bePg6LFFrY7A4MHH8HHKXaMlgSGNiQKvnku
 6WnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376145; x=1696980945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fs1dcVqCXTX8RM3B0vVfSAr/XS18s4HpUbI3OIrGI0Y=;
 b=Gi6DEG2BiO5ecegixHooU70EQE7mxgr43OiPcI+e+t62O/c/zXXZLtlCE/g6SzNfQj
 LQyCOzAHiCASHLqRdDYN+j2N95GiBOqHzQ4wq/vRxukhEsDY1pXNiEMPWqw9cAxD1lrQ
 0JX43gxKUi/NMej6BPifU/h8HlX/KUoTSRswuRzzDSUY9dcVRkMu1tJT3gKr9tJKd8Yy
 S3gS+sLtxVOQLZQ17oOv6ynkDOfAf+jKzOSiElobM2kl6+fj89W+16CBnyG86N/tShSx
 S/3ykATWwMCi7E7ebbi+OLTFKo07meskDCS7rv1LfYrHRMTYmxZHjOvdXOuaiApoRYqT
 gEgQ==
X-Gm-Message-State: AOJu0Yzk/TcPXkAV4Hd2A5f5/GRuVolZ++6X1uh8/wQMNPitfA2xe7X8
 PsdA0iw31fXAkOO1qIirVtt95Mp0pUUUOVJN57pWaw==
X-Google-Smtp-Source: AGHT+IEHnC7V/j9hifiV5Z5q6mlaapcsOC0dzD+cGD75OjFTY3x7iyienk3kWXWEpQqsqKzoZrKs6A==
X-Received: by 2002:a5e:8c0c:0:b0:795:16b8:85fc with SMTP id
 n12-20020a5e8c0c000000b0079516b885fcmr1006158ioj.0.1696376145177; 
 Tue, 03 Oct 2023 16:35:45 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:44 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 Kyle Evans <kevans@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 42/51] bsd-user: Implement msync(2)
Date: Tue,  3 Oct 2023 17:32:06 -0600
Message-ID: <20231003233215.95557-43-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d30;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd30.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Message-Id: <20230925182709.4834-15-kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.h            | 11 +++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 0f9e4a1d4be..5e885823a79 100644
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
index 2d8f1a953b2..2525e0bc316 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -811,6 +811,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
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
2.41.0


