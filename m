Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A46CD77A6BD
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:14:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBpp-0008BD-Ut; Sun, 13 Aug 2023 10:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpX-00088r-Hx
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:31 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpV-0000rH-Kp
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:31 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-317744867a6so3171670f8f.1
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935948; x=1692540748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J8L3HOHlk/xf2rOVmXOBAbQXT/UfmcxzbxJEFMoMIhk=;
 b=eebXHd7sPFFCiLYvg+VItLk/RK5FAhQTp+hKCwM5QNz/sf/t64FO53tA+3ZpoX3vxq
 KcBoZKHpjb76yhlvgnp3Z5sarkshX0yBlqpnKO5KIcrCrJ6iVJ8dd8/jHUXAwVZJrBud
 dWEftxlW7uz6TmhTMJOU0+PKPexYldirLYhat9r7m2jiWNbPnibR3xn9HNBYSUSzjtoq
 6JIfMQqkNZ8uKbtroVihQF/U+bwQ7anVPkfFuC7JJPS2ijCChBzU9iO87uFy1+vv4HgE
 KlO+khyRlrOGCytVy7Bx39wqv2IRCSvZL2J/DXqiRvlBOod92Vd24q9HH6vm5Vmsxt1v
 hqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935948; x=1692540748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J8L3HOHlk/xf2rOVmXOBAbQXT/UfmcxzbxJEFMoMIhk=;
 b=IFNiijIbHQWHv4E4X9tT8KRZz2XyEcQQtQlU4lQbhjU/HZ6+JKrDFttilmsf+yvLOZ
 2sXk5CkbbjYz7ikGzs975ebrzPNAf/osLZY3V2GZ0/pk3Cfokd2XAeFjt797WWPbQHNN
 ep9mN6gzBj4GwBpgnaS7f+UDCCOLDz8AtWbR9JPAzQ9/9jGGo95GIAyl2JfXChfGvEDx
 FfO4kytjdNeYP0Vrl+yEin74kDQndoi7727KcUJGUdAp7wZ9RoYoq4Dy+k5TGwDBQRvE
 GT+X4+ep2VrM13EPU1Ie1Zg4lzTlSZVwN2hzkH7GrwbBws7aCGmkzCzOivGXjonpJWyn
 AGUQ==
X-Gm-Message-State: AOJu0YyupI03tyuFZhYamchbrA9EF3d79UDUi4Evio0aL7ejNQfo/UqC
 niEB90/B70nKkJw7Ln/zxmsXg/4J78A=
X-Google-Smtp-Source: AGHT+IFliQ3m1NDs5SrYUS5ZjXKgbbAGxjtHNu/OM/JYE/v8naHcYjgsfuaQgiVZRvdHdJUR9TR0Sw==
X-Received: by 2002:adf:fcd1:0:b0:319:5bde:df70 with SMTP id
 f17-20020adffcd1000000b003195bdedf70mr4739138wrs.42.1691935947924; 
 Sun, 13 Aug 2023 07:12:27 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:27 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Michal Meloun <mmel@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 16/32] Implement h2t_freebsd_stat and h2t_freebsd_statfs
 functions
Date: Sun, 13 Aug 2023 05:09:57 +0200
Message-Id: <20230813031013.1743-17-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x436.google.com
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

They are the 64-bit variants of h2t_freebsd11_stat and
h2t_freebsd11_statfs, respectively

Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-stat.c | 82 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.c b/bsd-user/freebsd/os-stat.c
index 2ce235d5da..f0f9e609c3 100644
--- a/bsd-user/freebsd/os-stat.c
+++ b/bsd-user/freebsd/os-stat.c
@@ -58,6 +58,50 @@ abi_long h2t_freebsd11_stat(abi_ulong target_addr,
     return 0;
 }
 
+abi_long h2t_freebsd_stat(abi_ulong target_addr,
+        struct stat *host_st)
+{
+    struct target_stat *target_st;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_st, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    memset(target_st, 0, sizeof(*target_st));
+    __put_user(host_st->st_dev, &target_st->st_dev);
+    __put_user(host_st->st_ino, &target_st->st_ino);
+    __put_user(host_st->st_nlink, &target_st->st_nlink);
+    __put_user(host_st->st_mode, &target_st->st_mode);
+    __put_user(host_st->st_uid, &target_st->st_uid);
+    __put_user(host_st->st_gid, &target_st->st_gid);
+    __put_user(host_st->st_rdev, &target_st->st_rdev);
+    __put_user(host_st->st_atim.tv_sec, &target_st->st_atim.tv_sec);
+    __put_user(host_st->st_atim.tv_nsec, &target_st->st_atim.tv_nsec);
+#ifdef TARGET_HAS_STAT_TIME_T_EXT
+/*    __put_user(host_st->st_mtim_ext, &target_st->st_mtim_ext); XXX */
+#endif
+    __put_user(host_st->st_mtim.tv_sec, &target_st->st_mtim.tv_sec);
+    __put_user(host_st->st_mtim.tv_nsec, &target_st->st_mtim.tv_nsec);
+#ifdef TARGET_HAS_STAT_TIME_T_EXT
+/*    __put_user(host_st->st_ctim_ext, &target_st->st_ctim_ext); XXX */
+#endif
+    __put_user(host_st->st_ctim.tv_sec, &target_st->st_ctim.tv_sec);
+    __put_user(host_st->st_ctim.tv_nsec, &target_st->st_ctim.tv_nsec);
+#ifdef TARGET_HAS_STAT_TIME_T_EXT
+/*    __put_user(host_st->st_birthtim_ext, &target_st->st_birthtim_ext); XXX */
+#endif
+    __put_user(host_st->st_birthtim.tv_sec, &target_st->st_birthtim.tv_sec);
+    __put_user(host_st->st_birthtim.tv_nsec, &target_st->st_birthtim.tv_nsec);
+
+    __put_user(host_st->st_size, &target_st->st_size);
+    __put_user(host_st->st_blocks, &target_st->st_blocks);
+    __put_user(host_st->st_blksize, &target_st->st_blksize);
+    __put_user(host_st->st_flags, &target_st->st_flags);
+    __put_user(host_st->st_gen, &target_st->st_gen);
+    unlock_user_struct(target_st, target_addr, 1);
+
+    return 0;
+}
+
 abi_long h2t_freebsd11_nstat(abi_ulong target_addr,
         struct freebsd11_stat *host_st)
 {
@@ -170,6 +214,44 @@ abi_long h2t_freebsd11_statfs(abi_ulong target_addr,
     return 0;
 }
 
+abi_long h2t_freebsd_statfs(abi_ulong target_addr,
+        struct statfs *host_statfs)
+{
+    struct target_statfs *target_statfs;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_statfs, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __put_user(host_statfs->f_version, &target_statfs->f_version);
+    __put_user(host_statfs->f_type, &target_statfs->f_type);
+    __put_user(host_statfs->f_flags, &target_statfs->f_flags);
+    __put_user(host_statfs->f_bsize, &target_statfs->f_bsize);
+    __put_user(host_statfs->f_iosize, &target_statfs->f_iosize);
+    __put_user(host_statfs->f_blocks, &target_statfs->f_blocks);
+    __put_user(host_statfs->f_bfree, &target_statfs->f_bfree);
+    __put_user(host_statfs->f_bavail, &target_statfs->f_bavail);
+    __put_user(host_statfs->f_files, &target_statfs->f_files);
+    __put_user(host_statfs->f_ffree, &target_statfs->f_ffree);
+    __put_user(host_statfs->f_syncwrites, &target_statfs->f_syncwrites);
+    __put_user(host_statfs->f_asyncwrites, &target_statfs->f_asyncwrites);
+    __put_user(host_statfs->f_syncreads, &target_statfs->f_syncreads);
+    __put_user(host_statfs->f_asyncreads, &target_statfs->f_asyncreads);
+    /* uint64_t f_spare[10]; */
+    __put_user(host_statfs->f_namemax, &target_statfs->f_namemax);
+    __put_user(host_statfs->f_owner, &target_statfs->f_owner);
+    __put_user(host_statfs->f_fsid.val[0], &target_statfs->f_fsid.val[0]);
+    __put_user(host_statfs->f_fsid.val[1], &target_statfs->f_fsid.val[1]);
+    /* char f_charspace[80]; */
+    strncpy(target_statfs->f_fstypename, host_statfs->f_fstypename,
+        sizeof(target_statfs->f_fstypename));
+    strncpy(target_statfs->f_mntfromname, host_statfs->f_mntfromname,
+        sizeof(target_statfs->f_mntfromname));
+    strncpy(target_statfs->f_mntonname, host_statfs->f_mntonname,
+        sizeof(target_statfs->f_mntonname));
+    unlock_user_struct(target_statfs, target_addr, 1);
+    return 0;
+}
+
 /*
  * fcntl cmd conversion
  */
-- 
2.40.0


