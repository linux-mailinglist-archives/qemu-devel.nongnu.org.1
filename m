Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAA478BBAC
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:44:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalrr-0003im-F2; Mon, 28 Aug 2023 19:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrk-0003gH-AH
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:52 -0400
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrh-0006iW-Ek
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:52 -0400
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-34961362f67so11651375ab.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266108; x=1693870908;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CHVIeIEsGWfKvFkl87UQKdXlAw8VkJUEJfOxAHtMyYE=;
 b=Yk1jFDTL6uhPJ6Qn5NGnsUSA/ESuI3yu8KQBQNyvmpEYKLx+pIjpePxw8EFI1YjlwH
 zmbRrWoj/epnqbOHFaGz0ZaLmE7iJkzlNm3BadyjymxYkVjdZP/MHpBnswDBqiH1pSj6
 FXaKymTkOWLkJzD/jCrQ8EsBRV8JMd832y9xuaM4XXgRreOFSZyHWmCBbcUIv76XcZrQ
 GOqgWcSULdVeQyGu5FX6nsff00ZmpwYMLpoJ8Oy4NhzBmmJGIsvOsGfj2sP63QonvEs7
 CxG/+ol8AqKKuBXYMk2QMM+zneK7pR86R1BfaUzsJCj9OF4yFXTWUUXk9qjI8Wp4nsEL
 KOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266108; x=1693870908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CHVIeIEsGWfKvFkl87UQKdXlAw8VkJUEJfOxAHtMyYE=;
 b=Pnq6b1zV3D8V9YtaSIG4WYVi5nUN+Tb7G6GYna5delrQkh3dVkVBxjhqlrAQkdcfaH
 bnDWh+nGIzPLL779BDLK5851VcAWKorClsOhFr9Ao83VEaw1ognJi06BbUAo6ACh1wf+
 wuR18e1X4fm+fDEvwa07W6OdVUh14MVJJz7rIqSp/QTL8NAHry+JWwg/vEmMwwRoDmOt
 Ylyj8W29TEoCiVjYW5NN6OZhQx4yz9vMaR1siJSpY52qxU9DrHDu8zavBtG9DvBrALl5
 et1mevjhRiKeHRQ6Qi2TsLfi6ONlb90qFajxJxLWfdDXhQLTynHuw6h1xomkPGmCtYsv
 f0sA==
X-Gm-Message-State: AOJu0YxomtWwSXCwVpHD1UmhdFnnI0qiE1Ui/EZjW9beev1OC1U26kQ8
 zR+v78JsRc4xr0BCeHeiVKibhMEV8XZuwUyA240=
X-Google-Smtp-Source: AGHT+IESOx+QPRn44v1SdQ4TRuEju/P46ieCkRDkTB2bEu6xxYax/ykbmKcuIF9nZjvWJu6qVf4SVw==
X-Received: by 2002:a92:cdaf:0:b0:345:873d:1102 with SMTP id
 g15-20020a92cdaf000000b00345873d1102mr980283ild.15.1693266107840; 
 Mon, 28 Aug 2023 16:41:47 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.41.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:41:47 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 10/36] bsd-user: Add structs target_freebsd11_{nstat,statfs}
Date: Mon, 28 Aug 2023 17:37:55 -0600
Message-ID: <20230828233821.43074-11-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::12d;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x12d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add structs target_freebsd11_nstat and target_freebsd11_statfs to
bsd-user/syscall_defs.h

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/syscall_defs.h | 64 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index bd04b30a560..51d8ff0dd8e 100644
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
2.41.0


