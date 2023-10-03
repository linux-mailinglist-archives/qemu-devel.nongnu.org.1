Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EAC7B750F
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:36:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnove-0004Hp-6i; Tue, 03 Oct 2023 19:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovc-0004HN-83
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:48 -0400
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovY-0007RV-KQ
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:47 -0400
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-79fce245bf6so58308039f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376143; x=1696980943;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5PHERJl8GQhbey89K8x6f4j4Q8OwnuZ/ncrkVlq5O9w=;
 b=cCcwhsB1+oqnUmB3xg+W9BA/ssR1rHLUQqXLGEXAws2fkl1wWJL5UVmg+gTuLi2xvR
 uIZcBWO6JPU/WX4yDDjUF3jFgAPx7sUbMC8/ONsofXTgOnVDxT8EM3mggeRJ4G8HaFjN
 VDBG19ms68AKHbnCdRPlfpvoP52aM6e0WP5z+f9Fl7CJYf7ZW4HKEk0GSuEkkaZ3u0k5
 isDZr/oGAqVa9pPxXRiLaF/XeAy1hrNvYIHQ5Lcc6TAgvpd9dcnKHM1PV1mPzUwwijQG
 bwlh314nH4X15wG6QSV9PK93xKTYLPNkM46Xo7lhjiQJ5S2ttd6K2idgn0SW4AWM/ZLc
 fahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376143; x=1696980943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5PHERJl8GQhbey89K8x6f4j4Q8OwnuZ/ncrkVlq5O9w=;
 b=HrucR3rD9UjVsVyS1STBuHE4XL56cR6olYnZvRpox8gTq8RVGvHaMlyOr3KBvHd2Fd
 kuNGiITNTKbou9rnGUjh1Qo2BnKAagFGTVeiLtCfozbEbNDzkE2Ozi8m4+uhTV5HVjX0
 z5vMdFXTIBtvo/FFk3ueIcWVTcpGWi6ULOqadcvL4srd47Wqtw1L7EffJMAr/yLTvH33
 eFJxsFZFtalysfUgxNAW5hFFUhxzPd1UGg6NWKJ6el+R7kx0MF0AQyIWQtd9c0+rPjnJ
 acQOQJGuztaDie/46vseAIYXSKDlkrwxxI0mkpCJqup1DOkHaJM4zP8qrA46Hbx08b4T
 JxuA==
X-Gm-Message-State: AOJu0Yy9h4xnP08nmn32M6iT4cPLGsTKRxHcAT1bM0uSgYH4tDnyF1Bn
 Abf9Zs2YKtcJ4b7DQbzv89uFRTdZUlctJdvwVW2UOg==
X-Google-Smtp-Source: AGHT+IGgHX/teRChYawrxjQXFIcTwY0y2OSfMDOhMTtXYTkyTcBre7viDHKFtGo17DW9FBpYWK7DkA==
X-Received: by 2002:a05:6602:220c:b0:786:fff8:13c2 with SMTP id
 n12-20020a056602220c00b00786fff813c2mr973198ion.11.1696376143372; 
 Tue, 03 Oct 2023 16:35:43 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:43 -0700 (PDT)
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
Subject: [PULL 40/51] bsd-user: Implement mmap(2) and munmap(2)
Date: Tue,  3 Oct 2023 17:32:04 -0600
Message-ID: <20231003233215.95557-41-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d35;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd35.google.com
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
Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230925182709.4834-13-kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.h            | 20 ++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  9 +++++++++
 2 files changed, 29 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index d865e0807d8..76b504f70c5 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -61,4 +61,24 @@ extern struct bsd_shm_regions bsd_shm_regions[];
 extern abi_ulong target_brk;
 extern abi_ulong initial_target_brk;
 
+/* mmap(2) */
+static inline abi_long do_bsd_mmap(void *cpu_env, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5, abi_long arg6, abi_long arg7,
+    abi_long arg8)
+{
+    if (regpairs_aligned(cpu_env) != 0) {
+        arg6 = arg7;
+        arg7 = arg8;
+    }
+    return get_errno(target_mmap(arg1, arg2, arg3,
+                                 target_to_host_bitmask(arg4, mmap_flags_tbl),
+                                 arg5, target_arg64(arg6, arg7)));
+}
+
+/* munmap(2) */
+static inline abi_long do_bsd_munmap(abi_long arg1, abi_long arg2)
+{
+    return get_errno(target_munmap(arg1, arg2));
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 7887ad4c0c6..b03837d032a 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -798,6 +798,15 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         /*
          * Memory management system calls.
          */
+    case TARGET_FREEBSD_NR_mmap: /* mmap(2) */
+        ret = do_bsd_mmap(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6, arg7,
+                          arg8);
+        break;
+
+    case TARGET_FREEBSD_NR_munmap: /* munmap(2) */
+        ret = do_bsd_munmap(arg1, arg2);
+        break;
+
 #if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
     case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
         ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
-- 
2.41.0


