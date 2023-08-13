Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F6077AAF8
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 21:47:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVGzc-0007mz-HN; Sun, 13 Aug 2023 15:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGza-0007ma-Gd
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:14 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzZ-0002Np-3S
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:14 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fe4cdb72b9so33223695e9.0
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 12:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691955791; x=1692560591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=67G9fN2Q7zbfyveGtQLMpgK+UelnXLFsR1uug7FJ/Rk=;
 b=r9cbskGBmDH5qrSiXWO7Fmh/7zK+LWgQCmY0mTVp9rAf5N1+x+RYvmdbjJ7kFV/lNy
 gK19M1fVFVLxHZ9vJeyratKY0uU69f/l/BxE3yhchh2xMYqJSzk3kY/evqWHD4ygptLx
 QhFUXOqR0rvhbZ4b+wKh73yUszHa1N5v3zdkn6U1FDW1vYphCu11XoOa7h8mjtNGfXBj
 D8Hm7UJBY4Oc3j4uTUcq3Z/q+2SmNknDxM79uU/KuoXB4q4bLfbNX5lNTVn3fIdmojSA
 T2vXo3h1pSFMOI9wPJQYqLtFk7OFlf/ZBwTB/+TEYK708AxwsAkoXl08GyDRCFHck3Ce
 twbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691955791; x=1692560591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=67G9fN2Q7zbfyveGtQLMpgK+UelnXLFsR1uug7FJ/Rk=;
 b=lJEYBNptbLbIbuwUTZHsI+UwxXZkQRQ+7DwS57j/Ikvhxxyq9JK0jtrNXEZNkylLkk
 nVlK9tJ52j2srdMGI9tNkUSqM0CTtd0mwEdQeIGYsx2q/WbpcK9++5GqmZWZbOZd8NXj
 AmDolgFQUkqzFGUk4PsMJ0DR1zuNvoW/XTB5zsrabfwKFsRQ2KScwOlhZvQ9fLTeuXdE
 1taTrPvpgBwnhAMNRKdsapM5UnmbmwVW0i9AhUhwC0IP6FyGin+e2sOwHVQPceenAspR
 ZguI3O5vOu5TiarjWfI5d+Scu9uF3LSw5AKbiwpPekmWCELmcDrK17siFpDdikyRZMaC
 pmPw==
X-Gm-Message-State: AOJu0YwtMLC+zm9WmnWof4UjZILCJ0SzwoRLFxvS1d5n6JCjj9YXL70J
 BlU9PNhrIDunmJAkQICU2FjV6cL+uvo=
X-Google-Smtp-Source: AGHT+IEdjOBsXeH0mgBoAfUxOkIkSpNE8iXeRNzP6IETMkVvh1Vuqd9K6Y9EkNf9czbPOyB2eAyGPA==
X-Received: by 2002:a05:600c:1c13:b0:3fb:b1af:a455 with SMTP id
 j19-20020a05600c1c1300b003fbb1afa455mr5961948wms.5.1691955791148; 
 Sun, 13 Aug 2023 12:43:11 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a7bc3d4000000b003fe263dab33sm12234536wmj.9.2023.08.13.12.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 12:43:10 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 09/32] Add struct target_freebsd_fhandle and fcntl flags to
 bsd-user/syscall_defs.h
Date: Sun, 13 Aug 2023 10:41:30 +0200
Message-Id: <20230813084153.6510-10-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
References: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x332.google.com
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
 bsd-user/syscall_defs.h | 51 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 2aefdd205e..68db9cf4b2 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -339,6 +339,57 @@ struct target_statfs {
     char      f_mntonname[1024];    /* directory on which mounted */
 };
 
+/* File identifier. These are unique per filesystem on a single machine. */
+#define TARGET_MAXFIDSZ     16
+
+struct target_freebsd_fid {
+    uint16_t    fid_len;            /* len of data in bytes */
+    uint16_t    fid_data0;          /* force longword align */
+    char        fid_data[TARGET_MAXFIDSZ];  /* data (variable len) */
+};
+
+/* Generic file handle */
+struct target_freebsd_fhandle {
+    target_freebsd_fsid_t   fh_fsid;    /* Filesystem id of mount point */
+    struct target_freebsd_fid fh_fid;   /* Filesys specific id */
+};
+typedef struct target_freebsd_fhandle target_freebsd_fhandle_t;
+
+/*
+ * sys/fcntl.h
+ */
+#define TARGET_F_DUPFD              0
+#define TARGET_F_GETFD              1
+#define TARGET_F_SETFD              2
+#define TARGET_F_GETFL              3
+#define TARGET_F_SETFL              4
+#define TARGET_F_GETOWN             5
+#define TARGET_F_SETOWN             6
+#define TARGET_F_OGETLK             7
+#define TARGET_F_OSETLK             8
+#define TARGET_F_OSETLKW            9
+#define TARGET_F_DUP2FD             10
+#define TARGET_F_GETLK              11
+#define TARGET_F_SETLK              12
+#define TARGET_F_SETLKW             13
+#define TARGET_F_SETLK_REMOTE       14
+#define TARGET_F_READAHEAD          15
+#define TARGET_F_RDAHEAD            16
+#define TARGET_F_DUPFD_CLOEXEC     17
+#define TARGET_F_DUP2FD_CLOEXEC    18
+/* FreeBSD-specific */
+#define TARGET_F_ADD_SEALS          19
+#define TARGET_F_GET_SEALS          20
+
+struct target_freebsd_flock {
+    int64_t l_start;
+    int64_t l_len;
+    int32_t l_pid;
+    int16_t l_type;
+    int16_t l_whence;
+    int32_t l_sysid;
+} QEMU_PACKED;
+
 #define safe_syscall0(type, name) \
 type safe_##name(void) \
 { \
-- 
2.40.0


