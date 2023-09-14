Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A480D7A0EBE
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:08:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsa8-0003cJ-5v; Thu, 14 Sep 2023 16:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsa2-0003Nb-92
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:50 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZq-0001e8-SM
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:44 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40472f9db24so10299005e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694721876; x=1695326676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OJDoqCnf4TN8wQwqqwufdbynxXMjm684U/3NF9ubcCc=;
 b=oEx3dN97heX+5h6/5ljvKAMVp0n+8u+hjYGVEXgZnvHqyW7c1fh5M8pf5Fj4nb2iSz
 Q8TOHlVryh8LUzkh+/8fIRhROfaSiYh4XgD1HdnvKuMou9pEuc7EpBs5cPWdHainxNU2
 X+lvMco47zq94KDZpFZnXGRBCZrGIeZOlsYUfyRTVnK7pPmT0tYGMpzMDjW1ADxcchUz
 ztIkuNCe38EIOTk0dNsu17aPslS0rKGRMGqkZZPw3xiFf4n6yeqLXd7axRU2MaAL4XIs
 z5R63JQdOA8cRIaayAaw/dVwvOQnGURbx23GoKAiGfATMXmOMEow58+jjQ8BROK56IcI
 VAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694721876; x=1695326676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OJDoqCnf4TN8wQwqqwufdbynxXMjm684U/3NF9ubcCc=;
 b=Gx5ZGo4+kziDGhrrMvDWsZLFWlwwyoNIpeyrvIjTH5cI+kTDLgD6zfzQBueyufNRpJ
 07B15h8R9Srg9CehC5i3Z1S44mdeTwDc/zyRLJeJL9491pZUXttMcx+adZZwvPEw5Wx9
 8xbtpy2DWNkXNRT1A5L3CdRY7epfYi6qiXs98KVyXiHqSkftKiKqcPYDyDC9sFkaCZwX
 3QZghjH8/fRBHZl94IqLDGogcNWCVDgRUAunMcwSRNHKnLlB7gg2WImvf+sxOzJg2Q1n
 Huk7+XZhV/XBK+DbTHHjvTcY1PgZw1q1oy9aTdUjLaH5m78mdON8PwcWolpM0lt4ObGU
 a6Mw==
X-Gm-Message-State: AOJu0YwN7Idj+Tta+paPZaGwu+HUA4DnsiSveZTLdCg12pX10SzyA3B8
 +3rqlk7P+74Ipvi2oLcu6s+ZXec96l0=
X-Google-Smtp-Source: AGHT+IEjzEJTBBQ+fr1/8SJAr6yEXRB+/C0fsW+aONBDBhoOy90B1LonJWPXQ0Z/zwRBDVj1XaIyCw==
X-Received: by 2002:a05:600c:152:b0:401:b204:3b97 with SMTP id
 w18-20020a05600c015200b00401b2043b97mr5313268wmm.4.1694721876361; 
 Thu, 14 Sep 2023 13:04:36 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a7bc7c7000000b00402bda974ddsm2851130wmk.6.2023.09.14.13.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:04:36 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 23/23] bsd-user: Add stubs for vadvise(), sbrk() and sstk()
Date: Thu, 14 Sep 2023 23:02:42 +0300
Message-ID: <20230914200242.20148-24-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
References: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x329.google.com
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
index fe0968773e..9647249e90 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -567,6 +567,18 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
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


