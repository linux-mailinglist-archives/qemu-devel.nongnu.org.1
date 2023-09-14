Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D88147A0EC0
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:08:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsZu-0003KK-AF; Thu, 14 Sep 2023 16:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZo-0003C9-H1
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:36 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZb-0001Z4-OJ
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:25 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40472c3faadso10348745e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694721862; x=1695326662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jNK2HNrdMWVVY1+gcX4oM/Wj3OhUzW/K4i4ACmkfmcg=;
 b=Y/d/AvfpAsTlHB68ivlkCAi/K9C6dRxYS5wg+XPM4pbLHXdbydMC00cYJbTa3Ormgb
 ZmzpCivwFD8oZd2fSJttx8qmHRYoL74dXRhIzUSXslfrJoDxwVk+oZB9oyc2xLUCZR2L
 PppqQQMxChv5Bqkj1SiYDpNdGErdxr0nRaLfH8BqPhX6OnbTajH4G58DRMntPuMNxeeo
 p8nozAVdgdg+/Xl3ODRgoVwLFrizEN5YgyDjYlquQ9t12Dl2cYajqKucOYfjQ79Gbn5t
 O1/DocsUTFPGjdp7jucj9sGnTCaNZbPDZMFufssiJV1qqNy1ORIs2U9E7mSlWO++oB0p
 mR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694721862; x=1695326662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jNK2HNrdMWVVY1+gcX4oM/Wj3OhUzW/K4i4ACmkfmcg=;
 b=OvK3dDy+e0fHkskcPh+AuPaBMHJnxzXZL1Yfysj38KmoRT8fY/obGUF8FKV6qlBs+M
 kDPbCmJf73S8YujexyiSJlTvhUN00t/l1eQkFbxpEozg5ZRQldhpoBTO9YDGDf9fWZKe
 i6PtzAK8079ECb02BE19qyVoKwOuzkOY9d/uUhAKhP89M884LUI/cAS/5/rqLj4++NXA
 FMRmAXf1M9m0K0JKJ9sMrjaUKwIeXw6oXF/0vrWm8yHFk3yzO+gXAth9G0GkOJzPffJw
 hSavNs5I2sTz20UaXpZ+3ZHC+EUoF/RQiSlxn3j1gJYxAj74QZLY+RrDD+WHoTPVo1MF
 M44w==
X-Gm-Message-State: AOJu0Yzlwxs3bQqCTmiz0Y+TMMNaJFebJF5C1IHSWwLQpzjGh+1Euy2Q
 lW4iH9lCgbD1qXfEMTNeUuL54tMx6Ug=
X-Google-Smtp-Source: AGHT+IHQGD6dz5wEd3MyiZoT4l0hKMxrVa0Aw4dbpAobdzMRgP7Imu5OnaeJFh2yn9ydzrx0zXo1nQ==
X-Received: by 2002:a05:600c:20c4:b0:3fe:e85b:425d with SMTP id
 y4-20020a05600c20c400b003fee85b425dmr5668375wmm.9.1694721862067; 
 Thu, 14 Sep 2023 13:04:22 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a7bc7c7000000b00402bda974ddsm2851130wmk.6.2023.09.14.13.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:04:21 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 12/23] bsd-user: Implement mmap(2) and munmap(2)
Date: Thu, 14 Sep 2023 23:02:31 +0300
Message-ID: <20230914200242.20148-13-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
References: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32e.google.com
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


