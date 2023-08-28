Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6F278BBAA
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:44:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalro-0003hq-B1; Mon, 28 Aug 2023 19:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrk-0003gb-ML
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:52 -0400
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalri-0006ie-93
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:52 -0400
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-34baeb01942so13352335ab.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266108; x=1693870908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ck+M28e6yFMA7RarEDVs/Bl/fwVuNc5eFshlRTpFMmk=;
 b=wcXXeiV3s+ncnDZp+9p8i+j6xHbhF+pO5ugmVRgglZ2OcK70Z6bWS7S8/nGncOWjuC
 NQ3ewfnwevD2rFchVlZ65qXPEdPhoDMPs44We6NHejH9ltSAZecJD1VYhK9WkjasUK20
 9jd+XTHUEgF0mt0xwlCsXeNZHU5zC2EntfArKlR7HVTYxe8JzPGK0JXvpXmEv8WKAmtl
 MEYodUxmsfBIiwlbjz4iHDexpIuLrTFDHpsQaW4BnTZs9MZsRcYYfy0kRlE699aCDANJ
 Uq6/z+3IrfStEyM+9w+CjH0LJbQSk61HSa1oUwehSWK75pO2BhOinJG6a1zNabbC9CK7
 ugrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266108; x=1693870908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ck+M28e6yFMA7RarEDVs/Bl/fwVuNc5eFshlRTpFMmk=;
 b=X4c2QGglKIxKEy3BT1VSozW9+8FvzciBFEl0Zgvbijg4CL/9WTkoLtZiW4H+HGPQMZ
 5gfiRgSxGxiDzRhj9VwXKS5XODS7Q3J/scSvurg2305b80Rjbzhqd7GpzDeyDLJ1UPK7
 piScTre/40Eu2lWblpPNjJWsRLFbnoZzp+/FIIAWZM2wz8RkyiazQduoZIIJ8rjWkO0r
 JALTVxMYIArFY+UqEYuVUTd0jHpfsg5kBIKIneoNIIPnVwby+CQcKqhPXigkW2MsGK1G
 O9JKGQBaaJVquamR3l3mIh++X/G77Sjkwy/3SBNBaFIqeKgt3bDBb6P+tUuRWzmPHEfO
 lfKA==
X-Gm-Message-State: AOJu0YzQvocQ2vW2w/XIJEj8hA3JcDrSUfwgnP8rok1Bg/fHX7vVL1mp
 16h68Encg0jlHIN7R8azQnR9p+gkZF2lDAcxKd4=
X-Google-Smtp-Source: AGHT+IGgXv122/ui6jIZX0bNC+lpA2R1OdCs0vbJp7/8mso5QktzJacrbwYkfdITWCAaBicLau4ydA==
X-Received: by 2002:a05:6e02:1523:b0:345:787a:cb1c with SMTP id
 i3-20020a056e02152300b00345787acb1cmr21402832ilu.6.1693266108689; 
 Mon, 28 Aug 2023 16:41:48 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.41.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:41:48 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Michal Meloun <mmel@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 11/36] bsd-user: Add struct target_statfs
Date: Mon, 28 Aug 2023 17:37:56 -0600
Message-ID: <20230828233821.43074-12-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::12e;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x12e.google.com
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

From: Michal Meloun <mmel@FreeBSD.org>

Add struct target_statfs to bsd-user/syscall_defs.h

Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 51d8ff0dd8e..499a80f8bff 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -314,6 +314,31 @@ struct target_freebsd11_statfs {
     char     f_mntonname[88];      /* dir on which mounted*/
 };
 
+struct target_statfs {
+    uint32_t f_version;             /* structure version number */
+    uint32_t f_type;                /* type of filesystem */
+    uint64_t f_flags;               /* copy of mount exported flags */
+    uint64_t f_bsize;               /* filesystem fragment size */
+    uint64_t f_iosize;              /* optimal transfer block size */
+    uint64_t f_blocks;              /* total data blocks in filesystem */
+    uint64_t f_bfree;               /* free blocks in filesystem */
+    int64_t  f_bavail;              /* free blocks avail to non-superuser */
+    uint64_t f_files;               /* total file nodes in filesystem */
+    int64_t  f_ffree;               /* free nodes avail to non-superuser */
+    uint64_t f_syncwrites;          /* count of sync writes since mount */
+    uint64_t f_asyncwrites;         /* count of async writes since mount */
+    uint64_t f_syncreads;           /* count of sync reads since mount */
+    uint64_t f_asyncreads;          /* count of async reads since mount */
+    uint64_t f_spare[10];           /* unused spare */
+    uint32_t f_namemax;             /* maximum filename length */
+    uint32_t f_owner;               /* user that mounted the filesystem */
+    target_freebsd_fsid_t f_fsid;   /* filesystem id */
+    char      f_charspare[80];      /* spare string space */
+    char      f_fstypename[16];     /* filesystem type name */
+    char      f_mntfromname[1024];  /* mounted filesystem */
+    char      f_mntonname[1024];    /* directory on which mounted */
+};
+
 #define safe_syscall0(type, name) \
 type safe_##name(void) \
 { \
-- 
2.41.0


