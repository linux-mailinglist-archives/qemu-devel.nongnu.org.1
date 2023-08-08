Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0DD7740F1
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:13:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDW-0001x8-2C; Tue, 08 Aug 2023 13:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDP-0001Mc-Cm
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:52 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDN-0003Er-82
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:51 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fe12820bffso50231215e9.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514587; x=1692119387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jg3raXr25SZU0NJZhlFSeKjZ1CpRADnItniEeYv9fD8=;
 b=CApZy3HPlivyRfmg2hg/xXVW284d2GAviToveXQ+iTIAzZbrdFV8ZTEDWY8DAerQUu
 l6KFdQEq5ZWsnP8fGVFc4eaf2+6mMvpzegMrYtI2On/rbuNHgHH22VzjPj9lkIMBAz1x
 bPCBZ8dauuwhQCcJKqalANxi66OBtg5z5SVHQjAD0GuCGmCcrGXqnTfE2iuvwU5PWJqT
 hoxC0MrRh7L5h3Yv0TOztfBcoQjUJyJfC7T3VuW3e8zw3/8kLJpWL3wlT1/IZ6X+j2vv
 46UXvIyWLT4OaIjHsUTi6m0zsB5Gl43IKIV31tZQpSrDgTkn7M+rfBvn3xsXQWUENtAg
 cfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514587; x=1692119387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jg3raXr25SZU0NJZhlFSeKjZ1CpRADnItniEeYv9fD8=;
 b=hiAJWsHhzYft4Qy/eef5L+nRl2fM2QfT4hB+RTJKiyP949S4xgZQ11QnCqP+vWp1FC
 P7dyDT0RF/kCCbhRnUcPp+zrlMFEjw7oQR1VBWcF0aIFmLiB9mzJLkpnyEYOMdm0B6Ld
 Nrguq2HQk/2HNltvg1E9bHoSJK4oj4skYrtjSxA8YBSYqbSK7cp/geE7QEHDNjYsrb7s
 GZ4fnmxhe370mFjd+G+vuZO+Ed8Z/Kua/aWizteE2njtFavSaEatUtVM4ttT6hDIuF9t
 W4jeNuJGMRmdILjygD1VKym+btZUlPG3BX54uELdBQ8xlAHzMdgWXfJYff57XxwPPxo2
 kk7A==
X-Gm-Message-State: AOJu0YwO6vL0/oxTIuwpnMqFi1/hc1cQ7CN775rY3F2jWwe7Ut3TMkX3
 a9664pcdt53pajoEOtdneTFsQYZtgwWgbA==
X-Google-Smtp-Source: AGHT+IH8GqqHhv3QB6aSJmzNBp10pXpv/ypWrb+qVvkrbhf1gXF97W9MF3ZMQXaBQPoc+VRJQfp38A==
X-Received: by 2002:a5d:448a:0:b0:30e:5bd0:21a2 with SMTP id
 j10-20020a5d448a000000b0030e5bd021a2mr35809wrq.52.1691514587537; 
 Tue, 08 Aug 2023 10:09:47 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:09:47 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 08/33] Add structs target_freebsd11_nstat and
 target_freebsd11_statfs to bsd-user/syscall_defs.h
Date: Tue,  8 Aug 2023 08:07:50 +0200
Message-Id: <20230808060815.9001-9-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
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

From: Stacey Son <sson@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/syscall_defs.h | 65 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index e796e7e13d..06be8244de 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -250,6 +250,71 @@ struct target_stat {
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
+    __uint32_t st_gen;      /* file generation number */
+    /* __int32_t  st_lspare; */
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


