Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB26799650
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 06:37:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qepfW-000145-J8; Sat, 09 Sep 2023 00:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfN-000122-NM
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:53 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfL-0002x3-GB
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:53 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31f853f2f3aso467800f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 21:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694234028; x=1694838828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jNK2HNrdMWVVY1+gcX4oM/Wj3OhUzW/K4i4ACmkfmcg=;
 b=XqF04BzBcaFRZ/Be4wavTa7ACQlcLstK6WR3m3RXfNXdhjsY2PqXvyX1wpK2Avare6
 wfl699R6D5wCa2EQ2t0FxpIvmP0Rq6N7cXiEEIZnH4A/aaCW4pjRUV8ZEIETp/4VDSCQ
 gbtGE7yRh+A/VD+tGvFqepw2YZuvVuEmfnYQ3ObUNGBimcsMrKq6xQhwG3CLianRJWX/
 XfoLjllpRD2uBxdsS13qTvUzYkzGSPVYpc+dtvnl0QKhhwPnIGJRXLYgyOW8l3ZTcKPc
 r3/QOSmIISyUP6wMnt3FVOpCEpGZK23EX+66oTNZdjMJctg8Qk5xqYEYh7nmRfFSjxPk
 pbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694234028; x=1694838828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jNK2HNrdMWVVY1+gcX4oM/Wj3OhUzW/K4i4ACmkfmcg=;
 b=pm3EZ3af3SlOJPHaQYc5m/JmnietNgHH/hgS/8hndZ8yUTihB5DhiGRr9tKPH+FhHQ
 reKCf7J1nGNYJ3WuXkBu9nO+nFlIK9IDU6VqkEfsNUxP4l2/AH23hLDX03WwyapbwQVr
 AIJfm9fbNuXJaSGK96px7cwhxPJta3UCVQxn58CHtuHksceOHbmZOoXaxC7VcTWcHWSR
 9UEcySyiKFYIwt4Z98n1tpDhn/eh6OCsqT1RWZQl7VzaNbyoLU+FP154CkHmTxtYwcHh
 mcZf37uflt2V1d1jewse1hF96pWw4lVv+MWjfR3Wa6ULR2OK13X3WWua8vG8gnjPfciV
 pjZA==
X-Gm-Message-State: AOJu0Yy77wH4KBe2D4PgaigpFEXvYfbGJt2PA/RArviEo5nKtcVAr8m9
 TsWu/AS+p+hhhfQM8ITADCOLNLcleFI=
X-Google-Smtp-Source: AGHT+IGQDhXwLs2I8/rV4WEQtn8xUj1dlYgt1hQXy/C1j/vPpVBSTOaprkF6lDYbkDgKBb/Sau7ybg==
X-Received: by 2002:adf:de01:0:b0:31a:e3df:f719 with SMTP id
 b1-20020adfde01000000b0031ae3dff719mr5549137wrm.17.1694234028331; 
 Fri, 08 Sep 2023 21:33:48 -0700 (PDT)
Received: from karim.my.domain ([197.39.120.250])
 by smtp.gmail.com with ESMTPSA id
 d16-20020adff2d0000000b0031981c500aasm3615102wrp.25.2023.09.08.21.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 21:33:48 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 12/23] bsd-user: Implement mmap(2) and munmap(2)
Date: Thu,  7 Sep 2023 09:42:51 +0200
Message-ID: <20230907074302.79234-13-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
References: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


