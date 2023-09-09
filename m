Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97830799A97
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 21:39:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf3n4-0005yl-LE; Sat, 09 Sep 2023 15:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3n1-0005xU-Hr
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:43 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3my-0003E5-Qk
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:43 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-401187f8071so19782355e9.0
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 12:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694288319; x=1694893119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jNK2HNrdMWVVY1+gcX4oM/Wj3OhUzW/K4i4ACmkfmcg=;
 b=LP7vBbYgATegzu+2Wd4IUMn0DbTzi/vAcX97dCi/hsW78joK1Ivq6D3w4+gti4UYvX
 37Q0e75Cdgde8XCM+zSLrurEVM+km3SUovJGGda8a0w0zqMv4JKMcf15YUG4G7lm2FiD
 uHeEca5KguG1AHGP1nogD7qRCv/eQRHT47lyeMDJRu6/qrUzSfrdmpuKLU2rNz8qXiu2
 zKwBizt+MPLzIohUxOdgPIjP7QayqypN/+y0zYrSc2kjVcjq9QmaZlaKJiWbJ/fnaVy0
 BH3TvR1+bOPBhUzB0W3kd0xwuq4UE6r81QDXIE3iyp6WXKCR3k4jKcfEFjcBKvsHZBat
 S83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694288319; x=1694893119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jNK2HNrdMWVVY1+gcX4oM/Wj3OhUzW/K4i4ACmkfmcg=;
 b=c7K8u7GRbJ85l0+dUxEN7Vru5YYnhb2J4AePCz/s++TZ0fyqKSlJMSG/bEZd4jtS0V
 xDHY1q6+29YQTPue17dQJG7V/zfVHt8WMaxfwC57wrx3q45ZIxIy7TzYO+TiD3eZglZb
 30mOzQS8XaaiVEDWkmhNx7rKk7zq3ByyyAbswTAxJJzm96e1O3skTYviQnA9lZJFI7Tr
 UWJnmyQHmR+1HBd6mpMHx2shM87w5+/tL/QuE0wGonhq/cMpODo5D0Y1Ya9jcHmgYm+S
 FsgUuTE4//W4g5RkQ0SWkh3Mo5UHrrThM4iJCigr5U7k/lCNfjqhSasmGXqGS6VT32TX
 GCWw==
X-Gm-Message-State: AOJu0YxUPX+Z5U5Gytd7/cQQRa4eksr5kLnTX4eUSS8cdI2gWmDSFG+C
 MuDR/N1md08RDyer4yDdCv2lXdcPWGY=
X-Google-Smtp-Source: AGHT+IGj8FjoRKakkJTG8AFGvOmD0pl6AAuPzaBmtdklNj9c040stqZ7hIIF75yL5hYgdPsVO4iTyA==
X-Received: by 2002:a05:600c:9a2:b0:401:b425:2414 with SMTP id
 w34-20020a05600c09a200b00401b4252414mr6462419wmp.18.1694288319285; 
 Sat, 09 Sep 2023 12:38:39 -0700 (PDT)
Received: from karim.my.domain ([197.39.250.27])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c260d00b003fe4ca8decdsm8612812wma.31.2023.09.09.12.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 12:38:39 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 12/23] bsd-user: Implement mmap(2) and munmap(2)
Date: Sat,  9 Sep 2023 22:36:53 +0300
Message-ID: <20230909193704.1827-13-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32c.google.com
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
 bsd-user/bsd-mem.h            | 20 ++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  9 +++++++++
 2 files changed, 29 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index d865e0807d..76b504f70c 100644
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
index 7e2a395e0f..d88f62319b 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -486,6 +486,15 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
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
2.42.0


