Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D2477AAFD
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 21:48:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVGzY-0007lR-7J; Sun, 13 Aug 2023 15:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzW-0007l2-PF
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:10 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzV-0002My-8H
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:10 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fe4cdb727cso37658465e9.0
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 12:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691955787; x=1692560587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H+kI/UOoSzs0V1atGOhJOSHuZhuHYYPbhxRnCeQAmR4=;
 b=Nguw5GqWuNwdU9MrcZ5hNd9U2MfyFAjHXWHIwae2C36ThsTj/45eU2vMA23OlMWi2F
 97u+N41g1fq0HvhxKi59fpLi84LQapbYObC42tAf42vmCCqPcP9rLRCzduUbXkCpI1w9
 konpTW/WWahLDm1BrOyWy6rOMK50K3GMSvIs6dX1StBrUXGhT3SbgPibeVYx9y3rf3dH
 X3vuj1fnva/X7MEQEhOT5v3jB+F13R9cTWs7Q0DrW9sfle4kpRv8PjpKCBpOC4OQLfWY
 2lBb/wh3L1YFGDMqE2Jm61mrYmeahoSa9QSF/FmHWLfTAP0rXd1riNzIKharxitLpqtZ
 WkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691955787; x=1692560587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H+kI/UOoSzs0V1atGOhJOSHuZhuHYYPbhxRnCeQAmR4=;
 b=YwThLTkLn9MY7mNdqAJ04UwE0H1DRgIdA9wSI64A7vQK/+HKbWx/Y09kkRTupPxsio
 avZ/Y/SNDjlCHH1OjBbFf+1Y8l0rJxltk8vSInlE3xD9cxrukEJfkpWf1FY85CIpSjDM
 MnNtj/RlyFfwaGLeQEW+dqz6D6CQBMfzKvVPbhlbRzZW4r/OSMF7V/UMpyr1G2HuHCSx
 RHWQvntq/gQQg3tfUszThAi5oUPqHXceFEP3RPRt6s/kNSvGCieacx//s+YY7Uh5BUbM
 tJefbRLgSS5NC4bOsS2Fr4kQDLVUDOIIOtZePbUSgldhsAWCCKEUBmUe53icBWUvPBrx
 vBuA==
X-Gm-Message-State: AOJu0YyVYdYAFOtp2n8zfEdMiiaYNiBVB2zMiIZLfLkfoy/v+kKbNkOZ
 5BZU9WnEcNAVbvR/JvUTe7sUoLBq7L8=
X-Google-Smtp-Source: AGHT+IEZ8un/7zs3/4IvZsyYt5e/N8qYI0ReCvFfN0UxIAu9syb5SnLkyh6lUTJv5+O0dxpMlWuu5A==
X-Received: by 2002:a05:600c:c7:b0:3fe:1cac:37d5 with SMTP id
 u7-20020a05600c00c700b003fe1cac37d5mr6482455wmm.4.1691955787455; 
 Sun, 13 Aug 2023 12:43:07 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a7bc3d4000000b003fe263dab33sm12234536wmj.9.2023.08.13.12.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 12:43:07 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Michal Meloun <mmel@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 06/32] Add struct target_stat to bsd-user/syscall_defs.h
Date: Sun, 13 Aug 2023 10:41:27 +0200
Message-Id: <20230813084153.6510-7-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
References: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
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

From: Michal Meloun <mmel@FreeBSD.org>

Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Acked-by:  Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/syscall_defs.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 30c24bfe1b..41259848cd 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -212,6 +212,44 @@ struct target_freebsd11_stat {
     unsigned int:(8 / 2) * (16 - (int)sizeof(struct target_freebsd_timespec));
 } __packed;
 
+#if defined(__i386__)
+#define TARGET_HAS_STAT_TIME_T_EXT       1
+#endif
+
+struct target_stat {
+    uint64_t  st_dev;               /* inode's device */
+    uint64_t  st_ino;               /* inode's number */
+    uint64_t  st_nlink;             /* number of hard links */
+    int16_t   st_mode;              /* inode protection mode */
+    int16_t   st_padding0;
+    uint32_t  st_uid;               /* user ID of the file's owner */
+    uint32_t  st_gid;               /* group ID of the file's group */
+    int32_t   st_padding1;
+    uint64_t  st_rdev;              /* device type */
+#ifdef TARGET_HAS_STAT_TIME_T_EXT
+    int32_t   st_atim_ext;
+#endif
+    struct  target_freebsd_timespec st_atim; /* time of last access */
+#ifdef TARGET_HAS_STAT_TIME_T_EXT
+    int32_t   st_mtim_ext;
+#endif
+    struct  target_freebsd_timespec st_mtim; /* time of last data modification */
+#ifdef TARGET_HAS_STAT_TIME_T_EXT
+    int32_t st_ctim_ext;
+#endif
+    struct  target_freebsd_timespec st_ctim;/* time of last file status change */
+#ifdef TARGET_HAS_STAT_TIME_T_EXT
+    int32_t st_btim_ext;
+#endif
+    struct  target_freebsd_timespec st_birthtim;   /* time of file creation */
+    int64_t   st_size;              /* file size, in bytes */
+    int64_t   st_blocks;            /* blocks allocated for file */
+    uint32_t  st_blksize;           /* optimal blocksize for I/O */
+    uint32_t  st_flags;             /* user defined flags for file */
+    uint64_t  st_gen;               /* file generation number */
+    uint64_t  st_spare[10];
+};
+
 #define safe_syscall0(type, name) \
 type safe_##name(void) \
 { \
-- 
2.40.0


