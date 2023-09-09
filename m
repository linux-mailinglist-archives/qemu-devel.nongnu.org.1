Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75842799AAA
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 21:42:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf3mv-0005rb-Qd; Sat, 09 Sep 2023 15:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3mt-0005pL-7J
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:35 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3mr-0003Cv-0j
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:34 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-401c90ed2ecso33518125e9.0
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 12:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694288311; x=1694893111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQPQkmqbnFACQIlUwkAtPXqSarrHZNN1zhubxQ6WoBA=;
 b=TU4+oqX6U7KSBa0CQlLfqAUdFRTRp68FyPF2Tan7oQnNbdVGamxkm+TDzgQQj7wX9K
 qsJeW0zerG/nVpeLyoOIhplPFTubpPaz4quSUbIs7NsvkV/thBlDX7Ax+tx60kEquSMf
 4d+yiJvkuiHr4dRtjLsu3IFdA22GIXqPCuMUwHZUzdd3kvRDErOhweE4zHDiN1zL5xyG
 zK1lYG5Vc+0bQg+8EPC1UMV1pRou59NSFKH0tQFdh/EekxGl+d49JIzPTVu7JMA72vK+
 zoCVlvCw/Qk9nytf786EpP/vPLTgsIJgf7MlkXcOHBcc+wKW0Xoeci8++tP0RrmhVZyG
 4s+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694288311; x=1694893111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NQPQkmqbnFACQIlUwkAtPXqSarrHZNN1zhubxQ6WoBA=;
 b=cTtxkb16MyF1ta7Rm7j49j5MxLMtvCpg7wQvkUBeWAP+hVZhRGHy/dlaaZ9l7UJKfu
 xLU2LsPG5L5N+Q+owRkWTe+WLQqvNQewsfm39MhwzUqDHxSAcooVXdd5ibIBHoMa4Qo7
 yUX0pDyCU/rk3ceF/WbQGAyuof0Rx6njTuPO1q4ZfRMjDaCdC5V8orIpt76iI8gkJZyf
 YlkRw4P08PiMH6NAaLSk3bvA60ouvX3P2NYUyK12S921Xn3i3s+HAHyQ5ZDWgb8DHaNo
 KvELDc4sBvGzMapDx8rnzsle01im73AOUyzE/62B92NXIc6DTEbmGRsTXUbvztD3ovjd
 6K/w==
X-Gm-Message-State: AOJu0Ywp8UaC8oObJpFkFgK5+Nl/Mk2x5yuyp19BLKMvMDq818cEl/Du
 SulSStdehUUuKUjO+09zR7cSWteDf8k=
X-Google-Smtp-Source: AGHT+IGyV8gr7r6Tu63x0cNGCLW0DUnl8bdyzwH9WXDtmfa22IsCEokIErpQaZa2Yyn6OutdrPsQbw==
X-Received: by 2002:a05:600c:1e14:b0:401:d1a3:d7f7 with SMTP id
 ay20-20020a05600c1e1400b00401d1a3d7f7mr4676505wmb.30.1694288311311; 
 Sat, 09 Sep 2023 12:38:31 -0700 (PDT)
Received: from karim.my.domain ([197.39.250.27])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c260d00b003fe4ca8decdsm8612812wma.31.2023.09.09.12.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 12:38:31 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Kyle Evans <kevans@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 06/23] bsd-user: Implement shm_rename(2) system call
Date: Sat,  9 Sep 2023 22:36:47 +0300
Message-ID: <20230909193704.1827-7-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32f.google.com
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

From: Kyle Evans <kevans@FreeBSD.org>

Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-misc.h    | 24 ++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  6 ++++++
 2 files changed, 30 insertions(+)

diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
index 6b424b7078..67e450fe7c 100644
--- a/bsd-user/freebsd/os-misc.h
+++ b/bsd-user/freebsd/os-misc.h
@@ -66,5 +66,29 @@ static inline abi_long do_freebsd_shm_open2(abi_ulong pathptr, abi_ulong flags,
 }
 #endif /* __FreeBSD_version >= 1300048 */
 
+#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300049
+/* shm_rename(2) */
+static inline abi_long do_freebsd_shm_rename(abi_ulong fromptr, abi_ulong toptr,
+        abi_ulong flags)
+{
+    int ret;
+    void *ufrom, *uto;
+
+    ufrom = lock_user_string(fromptr);
+    if (ufrom == NULL) {
+        return -TARGET_EFAULT;
+    }
+    uto = lock_user_string(toptr);
+    if (uto == NULL) {
+        unlock_user(ufrom, fromptr, 0);
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(shm_rename(ufrom, uto, flags));
+    unlock_user(ufrom, fromptr, 0);
+    unlock_user(uto, toptr, 0);
+
+    return ret;
+}
+#endif /* __FreeBSD_version >= 1300049 */
 
 #endif /* OS_MISC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index b4311db578..2920370ad2 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -495,6 +495,12 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 #endif
 
+#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300049
+    case TARGET_FREEBSD_NR_shm_rename: /* shm_rename(2) */
+        ret = do_freebsd_shm_rename(arg1, arg2, arg3);
+        break;
+#endif
+
         /*
          * sys{ctl, arch, call}
          */
-- 
2.42.0


