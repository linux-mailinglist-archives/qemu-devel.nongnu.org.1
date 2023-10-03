Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FD47B752C
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:37:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovw-0004Yz-HN; Tue, 03 Oct 2023 19:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovm-0004Pc-JB
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:59 -0400
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnove-0007T5-Bs
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:57 -0400
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-79f9acc857cso54764539f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376148; x=1696980948;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PqkFGNnZr4Hir1xs5a2neZwKr2N6dkSvYPZpyI4/s4A=;
 b=POGwBzSXi82zmQJOXY8JV948drkEgDqBXWDu6Zdnz0SrdG/ZE3bto1BfImqYdzil0E
 K7srIHOkqH1q52JkTPpQ+4po0xXACyKLprZzgrtMIEi/J3r69q+OipbAH2uUBRAcRz0v
 tBCDnEWIGrhyZQMfCblbPaYSWPUVPKK/ej/1SFAfvSoVKEHFFfyw7Gd10NhkMWRfIxpD
 4EeHzKSBWIbpau/odvBs1/8yzwGYZmNlG9Iy02E+XfPszoPEaeexpzQSrV0A8Ax8jIe7
 1ubQIrYPqs2j3sCB3uj86VxXHtyaYu4pr0qBihxcUo7D/Q8VSzMhMSMSMdIYON5btsPY
 oqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376148; x=1696980948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PqkFGNnZr4Hir1xs5a2neZwKr2N6dkSvYPZpyI4/s4A=;
 b=ivD4kGwxwCMAH6jy1o9ckDueVkF1fuYHDYV75gtWWspg6745LWKZzGpwZBD5qiwCQO
 zjTDARetIiUTnuoHJ6R3vNUklWDe8NtFij/iKpTZT0rCp6Ev7ysCGfgaCgmFJeTwXyhm
 MSxcHs7le+dnA3Bvwrcy08+h/BFhZexfSOXhrp5DJhuBE+CnEGaRWyWq2/RZibJXkoyR
 HCkD2JNcrOPHFc9YIu/9QxqR+IJaCsDwxd3VgaMrc3Ahn97KxZNVEEakuHbb92kJlvmC
 Lmww3bJfUXZ2kdOTqavJOYJBD8cjeK/cQAgyNuykqoNocwINeAWEeGniY/NgvcWVf+n9
 dm4A==
X-Gm-Message-State: AOJu0YxxdYuKHyf7FgBdcPCwS/7HYnIhj+2qTKpJnXJe0YCWyjYMD5/W
 ZDMpZPFHwoDhQuam/RQmS4OsV7ewB+gk08Nzx02Apw==
X-Google-Smtp-Source: AGHT+IE8k3C998aY9XOLM13sV0eb+89fAHhmQr2pEZw6OPPLmaYSrl0q+alpWcfbEb5k5ZqcSZcWWQ==
X-Received: by 2002:a6b:da06:0:b0:794:d7e8:d239 with SMTP id
 x6-20020a6bda06000000b00794d7e8d239mr844399iob.17.1696376147942; 
 Tue, 03 Oct 2023 16:35:47 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:47 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 45/51] bsd-user: Implement mincore(2)
Date: Tue,  3 Oct 2023 17:32:09 -0600
Message-ID: <20231003233215.95557-46-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d29;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd29.google.com
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

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230925182709.4834-18-kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.h            | 23 +++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 27 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index b00ab3aed8e..0c8d96d9a43 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -189,4 +189,27 @@ static inline abi_long do_bsd_minherit(abi_long addr, abi_long len,
     return get_errno(minherit(g2h_untagged(addr), len, inherit));
 }
 
+/* mincore(2) */
+static inline abi_long do_bsd_mincore(abi_ulong target_addr, abi_ulong len,
+        abi_ulong target_vec)
+{
+    abi_long ret;
+    void *p;
+    abi_ulong vec_len = DIV_ROUND_UP(len, TARGET_PAGE_SIZE);
+
+    if (!guest_range_valid_untagged(target_addr, len)
+        || !page_check_range(target_addr, len, PAGE_VALID)) {
+        return -TARGET_EFAULT;
+    }
+
+    p = lock_user(VERIFY_WRITE, target_vec, vec_len, 0);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(mincore(g2h_untagged(target_addr), len, p));
+    unlock_user(p, target_vec, vec_len);
+
+    return ret;
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index b8c44cea0ff..f054241cd62 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -839,6 +839,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_minherit(arg1, arg2, arg3);
         break;
 
+    case TARGET_FREEBSD_NR_mincore: /* mincore(2) */
+        ret = do_bsd_mincore(arg1, arg2, arg3);
+        break;
+
 #if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
     case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
         ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
-- 
2.41.0


