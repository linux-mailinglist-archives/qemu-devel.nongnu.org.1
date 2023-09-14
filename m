Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC7B7A0EB5
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:05:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsa9-0003dE-1K; Thu, 14 Sep 2023 16:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsa2-0003NZ-92
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:50 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZo-0001Zv-Cn
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:38 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-403004a96eeso14586805e9.3
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694721865; x=1695326665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZzCf4SxTDBS+/M86UxgHIAN1U8HQ8Zh8Ai7mVoDHpm0=;
 b=i+05+Z3Lf5aJ0w5TXF5R8qjzjz6+qAMSBbdviETNjzyzXsxUY2Hk5CRpbDxWJxN5lQ
 wWzXytn7zZxCwLKvKX8Y8I5wyUNc5EioPXh3BXdrOodqc5sbz7+vg3jvFxEuu4nDftTv
 t7OG0qx8EKJnfiezqFVFmaHJ4/5JEjRLp0xNuNANf2VDDuYxcM0xnQ6mRKQtb7npsnRh
 xn8NN2NC1lp7tcs5JhFFDaAQyCdCY+LObAeD2NBlRrhmNxbxx+ecT8xGcRi9gQ471UA2
 h6zWozWudrcxBITcnQ7Vq6eQSO65dveJL3eX9g0qvYfQ1vqPgH0ihoyWjR57t9mGdBQX
 wn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694721865; x=1695326665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZzCf4SxTDBS+/M86UxgHIAN1U8HQ8Zh8Ai7mVoDHpm0=;
 b=qKH1dIYHYi2OAfXY3gVHOFdUjWRvbq8FT5jEg012ZLUj7WhVz8gXSkgZMTAefYQQcK
 RQG2IptM4BrxF2bOWQ6yAygDuPN1gKN6GCCDXkEGF3VZO3oGEGV28L0CaPLUmx9kXCnM
 AlCbjx9gZ7Tz3n/8ngtDc0etAV++tcxFmkR+BerrSt4Cq227OZGovb96X/pPWCTnSYsI
 suZyE7Wt0fhmduJ/atfWpIDe+CnhgMUOyB6uJg3bhrscOVgZ0eIiSO7YjMgGwFL09sYL
 O1LU8PkXq3Z8pm2JGGsybsp+tjbz4RsXcP5Ae4uEc5EsOowIrmceUluNMXDm/8gWZ+eI
 EJQg==
X-Gm-Message-State: AOJu0YxhbhCYoFHPzJjMxHe/HX9m3GIqABO2WeRqoU3WQtdNjnJUETM4
 yyFqEBgBWU0kZQJPgXfIqwgdlouFIJM=
X-Google-Smtp-Source: AGHT+IFOhTP03yszajhdw5NjTwa+Op8bFSwNWEBe2n7Xq4EKdRnhcfISriBLEi7J+xVFX8gfVSqKqA==
X-Received: by 2002:a05:600c:2218:b0:401:be5a:989 with SMTP id
 z24-20020a05600c221800b00401be5a0989mr5223819wml.23.1694721864574; 
 Thu, 14 Sep 2023 13:04:24 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a7bc7c7000000b00402bda974ddsm2851130wmk.6.2023.09.14.13.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:04:24 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 14/23] bsd-user: Implement msync(2)
Date: Thu, 14 Sep 2023 23:02:33 +0300
Message-ID: <20230914200242.20148-15-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
References: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
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
index 127805e079..859492dee7 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -499,6 +499,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
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


