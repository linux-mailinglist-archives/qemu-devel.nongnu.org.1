Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 638E078BBAE
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:44:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalrs-0003jh-Hq; Mon, 28 Aug 2023 19:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalri-0003fn-HH
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:50 -0400
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrf-0006i6-NJ
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:50 -0400
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-34bbc5eb310so13068465ab.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266106; x=1693870906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tdo1bhYlYELgs4yaIyLrA+/zF6S4843aF57BvFCbvZg=;
 b=racalekAQtuuMnVste1mafwUT3oYz5TnHZiVruY2iQmZbJD+iIx40JDmEFvXMqyCVT
 XEHPPJHQKRu0GltcKy6+OQK9WNHCmUeqUubvPNRT+S+uzQ2XMLHmGR0kkm4RHY5Kiw3Z
 BFsjDVJe7xTW0y8nOxOKkRpUFoZhM1IdYmkMEJqNUC7l6rNvR2gNOd8Qaca1U9N/A3bM
 kydixixyjtdEFHky1Z8n5sSrKiPSZAF1ZASv94iC1il+y/G3dETkU2mwu7a20AH9acq1
 7kX9R3U29TBSfwKmyP82cUeJUMAjRVgErD1mfjpKbK1NThU0ajByeGWjkjjHp6ewqHC0
 Fghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266106; x=1693870906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tdo1bhYlYELgs4yaIyLrA+/zF6S4843aF57BvFCbvZg=;
 b=NoRgd4JclqWJs2RDa+3pd/pdY9jVr5tciWyfsTMV6xwlDiYdPOIyI8GdIgqybTy+lM
 Mla/OERVXuHhfnda2wqHbJWb+DBw6+CA3zb08+0go0SwQpab98HeswtGFJiHLtFNewYh
 IbMxHrGsiS9ybs/UUwNHVt2UtV7FQc4dmw4OdhiO6so22UW7dzyrkNv+N2sQ4TgogDQP
 sA3ul5dZQl1fVb9Wxj6+5QwWRFq6HQQmwzdZ+X1NEe+acKlRwz/XXf+gGGaYTbxGoyos
 1Jh6+AjmokaYcRol+uUsAwKZz7Wr0DQK9Anohnu/nk9vFToPBEKzFSwRkjtEPawPFlZi
 HWFA==
X-Gm-Message-State: AOJu0YxV9sLSnWvuA7qSjynZXa+Rjow03RpER0d9/0on0tT8/OFcDKuE
 8zXuhvGvPAqAFZ7Xm2SDe1EcI7LqtNAEnADSwdg=
X-Google-Smtp-Source: AGHT+IH8hwRKYmiryVkbvRC6OytkVx1ZZs2zJ09vGW9E3PFwVtD7nAHgSrrxhUm4VVska2vZQu4J5g==
X-Received: by 2002:a92:d950:0:b0:34b:aef9:60d4 with SMTP id
 l16-20020a92d950000000b0034baef960d4mr15646837ilq.27.1693266106142; 
 Mon, 28 Aug 2023 16:41:46 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:41:45 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/36] bsd-user: Add struct target_freebsd11_stat to
 bsd-user/syscall_defs
Date: Mon, 28 Aug 2023 17:37:53 -0600
Message-ID: <20230828233821.43074-9-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::134;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x134.google.com
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

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Singed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index aedfbf2d7db..56198cc6a00 100644
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
2.41.0


