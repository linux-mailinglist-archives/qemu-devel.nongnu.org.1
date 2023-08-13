Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7FA77AAF2
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 21:46:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVGzX-0007lO-N5; Sun, 13 Aug 2023 15:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzV-0007kR-CV
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:09 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzT-0002Mf-Ux
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:09 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fe5c0e5747so21078115e9.0
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 12:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691955786; x=1692560586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N1kSJoA0fUeLrj0hCdLA06yJohbmCzmxtAnupvK2JPQ=;
 b=Vh2l663+i37yRh+PunYEcmq2jBWvqxOqErV+Shm5K03rIjqPp6hj1aZEDJVWwaTFxV
 AT1T9VkmYJHmphhJqvqN4yRncg8SkayR3sMdk7ruQ4u+JPI+xXCjxS0ae8ddOUW5/FME
 YHA5OjJZ+JTiB178fJjeOp8AuthZsaJtRWhkayxH9H3RwAj18UvU32+jIaIGVVVd/6DU
 H0JKvFuwT4WyJ0iREAZxtYsMeASg7m8TzyJpd3Qe8DZKHmNL3ujcPZl67uh0kmeWl38f
 Yph+CuIexhVdbJx5rCaKiwQUC5IC/js3hlx9Gp0kkaf/EqpQfNeWA6R4vgZf6Hg3cqtr
 NS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691955786; x=1692560586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N1kSJoA0fUeLrj0hCdLA06yJohbmCzmxtAnupvK2JPQ=;
 b=IRnQKO8CTlMaEiluxeRc1mpSjk9Tp0oF0CVNlyzyBkximBEaK0BnaGjwDyYsne90qM
 Cw7LWE59NAqMkq4eJwIFPgw1snCzDH22ywPgoXXEquXjxU0oGeQ6YROdK3/fQHA2IWS0
 HRQO4RnOeEvHoToXIzW77AM55Uw9qaKpKvESkWZW6t0kzD5eVMRF6Sbfe8wpQ97LQfbD
 lGoR+S11gWicsZwZmVQ6OBEocfk5Av6iz0O6L26iFA0ThugjOu4pn7zkICYWF2J9K9UQ
 cZZBr7vZTw1M5UdgL3Pgdcs76XcW+hktdaK3fCYZSaB7jyIWCSbKMlQKQdKXbomAbvmC
 t7Qw==
X-Gm-Message-State: AOJu0YyCOM/x55YCjH+NKi7HhSbZjfTTny61Z4fW+7kMv/ikumkd6Ves
 ZvX3lacKVdubJy0qQy7WC7/hUk7uM2Q=
X-Google-Smtp-Source: AGHT+IE0PDUCsK45LBRYcnmlfEuTAZHF0iYUjN3M6n7lgfmlSLqQ9Ox59bErgp7WMYqtYKjP+Xai1w==
X-Received: by 2002:a7b:ce99:0:b0:3fe:1f70:9e54 with SMTP id
 q25-20020a7bce99000000b003fe1f709e54mr8290255wmj.4.1691955786266; 
 Sun, 13 Aug 2023 12:43:06 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a7bc3d4000000b003fe263dab33sm12234536wmj.9.2023.08.13.12.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 12:43:05 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 05/32] Add struct target_freebsd11_stat to
 bsd-user/syscall_defs
Date: Sun, 13 Aug 2023 10:41:26 +0200
Message-Id: <20230813084153.6510-6-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
References: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x333.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/syscall_defs.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index b6d113d24a..30c24bfe1b 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -179,6 +179,39 @@ struct target_freebsd__wrusage {
     struct target_freebsd_rusage wru_children;
 };
 
+/*
+ * sys/stat.h
+ */
+struct target_freebsd11_stat {
+    uint32_t  st_dev;       /* inode's device */
+    uint32_t  st_ino;       /* inode's number */
+    int16_t   st_mode;      /* inode protection mode */
+    int16_t   st_nlink;     /* number of hard links */
+    uint32_t  st_uid;       /* user ID of the file's owner */
+    uint32_t  st_gid;       /* group ID of the file's group */
+    uint32_t  st_rdev;      /* device type */
+    struct  target_freebsd_timespec st_atim; /* time last accessed */
+    struct  target_freebsd_timespec st_mtim; /* time last data modification */
+    struct  target_freebsd_timespec st_ctim; /* time last file status change */
+    int64_t    st_size;     /* file size, in bytes */
+    int64_t    st_blocks;   /* blocks allocated for file */
+    uint32_t   st_blksize;  /* optimal blocksize for I/O */
+    uint32_t   st_flags;    /* user defined flags for file */
+    uint32_t   st_gen;      /* file generation number */
+    int32_t    st_lspare;
+    struct target_freebsd_timespec st_birthtim; /* time of file creation */
+    /*
+     * Explicitly pad st_birthtim to 16 bytes so that the size of
+     * struct stat is backwards compatible.  We use bitfields instead
+     * of an array of chars so that this doesn't require a C99 compiler
+     * to compile if the size of the padding is 0.  We use 2 bitfields
+     * to cover up to 64 bits on 32-bit machines.  We assume that
+     * CHAR_BIT is 8...
+     */
+    unsigned int:(8 / 2) * (16 - (int)sizeof(struct target_freebsd_timespec));
+    unsigned int:(8 / 2) * (16 - (int)sizeof(struct target_freebsd_timespec));
+} __packed;
+
 #define safe_syscall0(type, name) \
 type safe_##name(void) \
 { \
-- 
2.40.0


