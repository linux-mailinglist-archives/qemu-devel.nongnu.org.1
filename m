Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1120677A6BF
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:14:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBpP-00085r-4J; Sun, 13 Aug 2023 10:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpN-00085a-5Z
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:21 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpL-0000oL-Gv
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:20 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-313e742a787so1992788f8f.1
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935937; x=1692540737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ATdcHjSASLEXTB5W8LArsyCsn/nHUJnz/58BCHF9z/I=;
 b=NMnDJJ7c5fFMIP57tOrzC1jlXg/sVe8SarSG9yG5dN5XmiOhKRLKzlm5Ej/KnsQWNI
 aCW8qXwtKFH+poTJ8IpwI9d7BxO34w8RyUBNpP/DXyM2Nw0X+UdOCGekzRo9OcCZh/AU
 7v37KZhF55opd6Y5lggcPIn7cTVSBoOjMYCB9mY4EziYO2Cv9j1znqEpw+sa5IJQp6I6
 wTaWdTocEvXR9mDHPIfItLlPmx2BhCHm568pZ7y6azZfcc/rIOiabbeR2gEXKVTsL0Wf
 53vmZy3Sp7oI0ZxQpm28VASA7c6HIu3SirHpZMBeZKsLmFnmshE4Kn2husSGef7YgVAJ
 H+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935937; x=1692540737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ATdcHjSASLEXTB5W8LArsyCsn/nHUJnz/58BCHF9z/I=;
 b=XVW4z+Jbzz4faozlqVkfq9noniuY4GLQKS6LN+W1l16KtkjZCiMLlNpRMqpcij/qcr
 Rya0WyJrB2a+QwnMGvYQwxKFzv9pOY1gkqnqzNybPhk+Zy/XRm0UiRDzJBqM2W6TEGCY
 vFwFbrshgwFj1vJ++GJbSNCyQT9a8UMSTlRMQZ+Vi+au7PASiwYT/X1GTFF9bLu4DqUz
 /71Ug8NwkBZkZO4RrAfWP4E5f1srglTFWPiUrU+PliXVym+qVHG1g3LzNnV/5x1dXuy7
 6DkcJ3OJImFNU8+IBID3o24TT4SAf2gd4l4JEsLLk+lmWHyRcn5fneye9AsjUxyc0wq/
 pvBQ==
X-Gm-Message-State: AOJu0YzeGMuNYA1GpGXsCD4YWJojufnZdeeHY9Vfb0Z46pkHSSMqsUsk
 D/dKb0zPDTsLOCqVySefvl0STeHH5dg=
X-Google-Smtp-Source: AGHT+IGRaZKWKpOr1atIG/S70Lp7gU6Aj4aJVCrxjjkhRTtgYBoW2UT3whd8QvhSvcEO4668rStoKA==
X-Received: by 2002:a5d:404c:0:b0:314:2f3e:dca5 with SMTP id
 w12-20020a5d404c000000b003142f3edca5mr5137285wrp.28.1691935937122; 
 Sun, 13 Aug 2023 07:12:17 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:16 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 07/32] Add structs target_freebsd11_nstat and
 target_freebsd11_statfs to bsd-user/syscall_defs.h
Date: Sun, 13 Aug 2023 05:09:48 +0200
Message-Id: <20230813031013.1743-8-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x431.google.com
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
 bsd-user/syscall_defs.h | 64 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 41259848cd..f8f37517b2 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -250,6 +250,70 @@ struct target_stat {
     uint64_t  st_spare[10];
 };
 
+
+/* struct nstat is the same as stat above but without the st_lspare field */
+struct target_freebsd11_nstat {
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
+/*
+ * sys/mount.h
+ */
+
+/* filesystem id type */
+typedef struct target_freebsd_fsid { int32_t val[2]; } target_freebsd_fsid_t;
+
+/* filesystem statistics */
+struct target_freebsd11_statfs {
+    uint32_t f_version; /* structure version number */
+    uint32_t f_type;    /* type of filesystem */
+    uint64_t f_flags;   /* copy of mount exported flags */
+    uint64_t f_bsize;   /* filesystem fragment size */
+    uint64_t f_iosize;  /* optimal transfer block size */
+    uint64_t f_blocks;  /* total data blocks in filesystem */
+    uint64_t f_bfree;   /* free blocks in filesystem */
+    int64_t  f_bavail;  /* free blocks avail to non-superuser */
+    uint64_t f_files;   /* total file nodes in filesystem */
+    int64_t  f_ffree;   /* free nodes avail to non-superuser */
+    uint64_t f_syncwrites;  /* count of sync writes since mount */
+    uint64_t f_asyncwrites; /* count of async writes since mount */
+    uint64_t f_syncreads;   /* count of sync reads since mount */
+    uint64_t f_asyncreads;  /* count of async reads since mount */
+    uint64_t f_spare[10];   /* unused spare */
+    uint32_t f_namemax; /* maximum filename length */
+    uint32_t f_owner;   /* user that mounted the filesystem */
+    target_freebsd_fsid_t   f_fsid; /* filesystem id */
+    char     f_charspare[80];           /* spare string space */
+    char     f_fstypename[16];   /* filesys type name */
+    char     f_mntfromname[88];    /* mount filesystem */
+    char     f_mntonname[88];      /* dir on which mounted*/
+};
+
 #define safe_syscall0(type, name) \
 type safe_##name(void) \
 { \
-- 
2.40.0


