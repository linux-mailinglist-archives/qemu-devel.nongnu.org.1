Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BED3178BB9B
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:43:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalrq-0003i5-61; Mon, 28 Aug 2023 19:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrm-0003gn-Pa
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:54 -0400
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalri-0006ip-Ux
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:53 -0400
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-34bad74fb3dso14269845ab.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266109; x=1693870909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dKikkRC80oy5DbtX2PLleQEU+3OLPjrRbS0XoUPdcnk=;
 b=XcsOsQrUl5xK4SawEHt26YusywJ+9SMxGD2OJhkYb8p+g7pzuDlHpTa2zuQ4ifYWfw
 kVobm7V0h2pHA3jqHQmhNkx0/xZz7wCIF1c5XD3pEGodRypA6qMbwUuBBDzxqfD+m37m
 Xh6dEtU9BQM+GaxByCrE7wfcyq/iyPEO01Th7qvMRCsAuwnrfnCeJ0eHO8V6c/RasGmT
 JJXxzr+Jb0QzOxAqH+ykOZxf/yx4H0bv9iO+Oxk4K1GW/MIVDP1rQqbwFJ2ESAzM4dr6
 gaiY6OjM61XmzcE63mSlMlZX9vekTUd3BYNoLeQ3KcyXHBgYeqhXifePPuGuOaP4QIt3
 cTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266109; x=1693870909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dKikkRC80oy5DbtX2PLleQEU+3OLPjrRbS0XoUPdcnk=;
 b=JVNDYd9e4+WSaC6UX6ya/fPka4p4QiEqNR6wRfxn6UQ6ZxBYWT5cVVVY9509MzZIrA
 DgmdFc20qRraupPhDJTc/ScpCpAoIduLGoYf/wfajWZRVSoz63vkv4Bv8jhRZSO4W97p
 JQUO+zBidSh4RkG32G+DNijQp9WHOdIIcVGlv0ScRG3HeVEld4/bmcMRhT1Szc8R/dJA
 mINshQFYTFV/AE9FQGslaR/qn++ZV2gHwZHSD3KfK3Nf95AXlVT2a4faRUVd86KJGoSv
 KmL64NN/9CoqJioWlL50Nae7yTLGUo8nv/6lsmp6bfcPNL4ZmWsFaJG08G7oi7aX+mS+
 oOXQ==
X-Gm-Message-State: AOJu0YzlKLiRHlWb6rmvIxD5qaDfY+ldNrMqPU4d4VQJBwsarP0Yyrt8
 n36dykACks2sVEPtnQzGKH1wiAWJU/A8f6yvUJw=
X-Google-Smtp-Source: AGHT+IGUJdNbP0jEYHYDE6A4cQjK+qDzIZQIzPuN3o6TQmumXZVtk9RytTNrJ6uRkg0J5gXYtYRVnA==
X-Received: by 2002:a92:cda6:0:b0:34c:dbeb:a2a7 with SMTP id
 g6-20020a92cda6000000b0034cdbeba2a7mr14445155ild.23.1693266109490; 
 Mon, 28 Aug 2023 16:41:49 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:41:49 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 12/36] bsd-user: Add struct target_freebsd_fhandle and fcntl
 flags
Date: Mon, 28 Aug 2023 17:37:57 -0600
Message-ID: <20230828233821.43074-13-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::135;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x135.google.com
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

Add struct target_freebsd_fhandle and fcntl flags to
bsd-user/syscall_defs.h

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 51 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 499a80f8bff..96ae90b0631 100644
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
2.41.0


