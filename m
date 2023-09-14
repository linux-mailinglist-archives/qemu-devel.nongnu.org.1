Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B067A0F3C
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:47:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgtAs-0003NR-9V; Thu, 14 Sep 2023 16:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAp-0003Kn-0j
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:51 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAl-0006Ne-GX
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:50 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-401b0d97850so14445285e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694724164; x=1695328964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kz+23oIf5l7ES1zwv+zlawDrL/8dIy3f1vjxlJaYUac=;
 b=SFAtbsY/FUUa0qycDs+sh3REk6Ii8RIIMJjZ8Sbgjs2nVOfbXn4Bl99dtqx40BnyP8
 Ms6jqHVR1feVMWvqekmUEkp+Gr/yGTbwb4+u++3XbghVd5qWtntzOyLrEZdxzTIeohl+
 oBtjnhQ306DW5juzes6BfaDCFii2EWuBEGrdqH0st1h3iPrkCh7huRXQg/iwAP7nBAft
 A0pobBYl5IccaiiMCmHL/LR0rFAzOX4Oc+f3cfmVc0t2b0vnLdqVphmu4AShsFVO+WsT
 nNEOJm9Kn4mV8+JZVf+iSVbHtlO3N+Ghn1kuvmh1FJmkpURkgy/ScUoGjj4VtLo8AB/A
 z6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694724164; x=1695328964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kz+23oIf5l7ES1zwv+zlawDrL/8dIy3f1vjxlJaYUac=;
 b=ZQCMIJoAtpck7VldfVIVYT5j3rWX2cZ4eK8hqGKcn2/po+M583xouFuy/jwFzviLDl
 eqpn0K9w03WT5GF8rNAaCxzn1mviwDmRN5U2SYoIr9WsGFuI7fo4Lu/WAuK7Davb5zmO
 VRSLqasB5bsffkjsyQ3juRcXC9L32frQrm8fH49AgmLYiNKohut1f+6neqt8w8TfIpDe
 JKdTLnZ3J0bmOnEFoZ1R5iEuJqWTEoJwFptGGffeBTJxlweRWz9WPHGX5HfaLW3BWqRX
 a1rVUKyb2c+vfukvewc6bxMwc54kbYqwb0DVsYG2xc47ZJd3jmyoRayXYIVLsiskT2m9
 qUOA==
X-Gm-Message-State: AOJu0Yz6DEORos8T7ahSn9rm9N+ffdMbr+qLTyyRl7a10XwtkPy8xkSc
 uDSX4Si5CNWS3UBlyPid1Yrp8DQQqlA=
X-Google-Smtp-Source: AGHT+IHd6Bi9n+rQLRhkvQDVxOvkOyfc3Sd/1qKmbx06Nc7KUU7WlAGXy5wtQEo4E+/3Of3kfQ01wg==
X-Received: by 2002:a1c:7c0e:0:b0:401:b204:3b84 with SMTP id
 x14-20020a1c7c0e000000b00401b2043b84mr5543398wmc.40.1694724164160; 
 Thu, 14 Sep 2023 13:42:44 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056000124300b0031f34a395e7sm2661880wrx.45.2023.09.14.13.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:42:43 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 12/23] bsd-user: Implement mmap(2) and munmap(2)
Date: Thu, 14 Sep 2023 23:40:56 +0300
Message-ID: <20230914204107.23778-13-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
References: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32a.google.com
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
index 42cd52a406..893881c179 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -594,6 +594,15 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
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


