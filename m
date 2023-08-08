Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F597740F0
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:13:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDW-0001xM-4U; Tue, 08 Aug 2023 13:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDR-0001R9-9N
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:53 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDP-0003FR-GB
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:52 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3178dd81ac4so4893849f8f.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514590; x=1692119390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JgfqNpuxkggtyaOumlpuSDtILW5+5vEXskfFi5ncc6E=;
 b=pmaTVW7RTNPuI+5CcjlMX3+E9mBXvp0r/NsC1dwlozGKTODwnLtvXjFAThUMFKNhjK
 vCNHO9UJdhrTimHb7xa0397hcJ8hI3xR0H1vlHLS8wz/qa9ybWeknbBMIS72acIWl6f5
 v+kqCFSvVd+77er/Hgbfl2Be5Ju/a020lAWLaSQto+VvxNjJtX7G5OWuE7aSXEolH+pB
 QjLHPd+dDm2n8kHJ1rfyDmCQW+NlTci4j22FRBGgF2quSRM/EYP0Iygd2hH3oeJNrUr1
 KoaO2wdTLEOodTv+urp3OnL8sn+w38tVPzOl+f5cz8vgElwRX+E9rWRZ1ii2tTACU6ez
 AzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514590; x=1692119390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JgfqNpuxkggtyaOumlpuSDtILW5+5vEXskfFi5ncc6E=;
 b=SPxzMn1utBxU9ijoFlfDPID53J4Vv+9gztRTp8ArXbjEnO+w7ivqUjfpnLiiFfextA
 IoNKSXKL6fU/9EaYUafbEvlIwZWia5Mj0aSYSBS+/x0USBh1s28Fpa6GFyDCeO8zpoeY
 pE51W9n8qg6y+nDsETF4cBxtyl4eOUnVGJKfAKaMwijBtqO4/QqkFIZGAJIAy+K9qYPh
 uEhItS2UbxzDwH68dkZlOKLH2Txt+rew5dMjM9HCesyEVgGTIlBRh7ualLamDFT8cYWu
 vRPjKxJ6bkE4OeDwWW8QrCFyicYfMcWHMVF7lcAcmwvwy6x1Wd1cdZ84c5zx2lPpgosJ
 eB3Q==
X-Gm-Message-State: AOJu0YxLg6EMvGXKeZYp6QI7M18tQr3ztFDtmjIZ/eDjXD8UQ0KxXgIy
 JvI/JSynMalpPN+v4RTJgov7VGdJwBPapw==
X-Google-Smtp-Source: AGHT+IEl0YZa9tdPLWXRBi5h2x2XNhUKpWjFPl0QA88yD+w0PQBmV9jCqcfRj7O7g3TjO43P5wBoqg==
X-Received: by 2002:a5d:4a0c:0:b0:314:2f5b:2ce with SMTP id
 m12-20020a5d4a0c000000b003142f5b02cemr102668wrq.12.1691514589773; 
 Tue, 08 Aug 2023 10:09:49 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:09:49 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 10/33] Add struct target_freebsd_fhandle and fcntl flags to
 bsd-user/syscall_defs.h
Date: Tue,  8 Aug 2023 08:07:52 +0200
Message-Id: <20230808060815.9001-11-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x432.google.com
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
---
 bsd-user/syscall_defs.h | 51 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index ab59d00a47..608731f0ac 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -340,6 +340,57 @@ struct target_statfs {
         char      f_mntonname[1024];    /* directory on which mounted */
 };
 
+/* File identifier. These are unique per filesystem on a single machine. */
+#define TARGET_MAXFIDSZ     16
+
+struct target_freebsd_fid {
+    u_short     fid_len;            /* len of data in bytes */
+    u_short     fid_data0;          /* force longword align */
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


