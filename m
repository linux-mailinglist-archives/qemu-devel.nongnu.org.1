Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2942478BBBB
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:46:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalrs-0003jd-GE; Mon, 28 Aug 2023 19:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrj-0003gG-OU
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:52 -0400
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrg-0006iF-QV
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:51 -0400
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-34dea77cbe6so867545ab.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266107; x=1693870907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=myWLdhC0sTpg74wmYRm8tt2zULF2VyHwrBtwz0SCxYk=;
 b=XhZQmPUmRjJqxh85RPS3Va/3dopZGU2YGx5ZaJyPF+3W2Q1cLgFaoDkeOdA0djXxyx
 RaVWQ7mmwKn1lFmJSYOhx3e3pYN2nzv42FMSdKtzm6u5LEq3qdSsh1QL2H+ev77ch8Dw
 nP+NUuZDwcWfHstRKlV9GUwsy+eq6PMVFAmXYc4QMRKxTuQf1tNS5kiEFKQ+FALldeYQ
 5ptX8MwYTIRr3PUeBRIccG0uWQhPMywzGQ1OI0f0HPzSfWOqpzcGwn/oqMzvJEYUmfmq
 BFY1dEKsL03V1ltKJM2Nlrzn4T0sh4kTthqTJ8g7BPNgjzK5/jg83a2fLKFjgcsDKmyc
 ufnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266107; x=1693870907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=myWLdhC0sTpg74wmYRm8tt2zULF2VyHwrBtwz0SCxYk=;
 b=iGXdUP/CsnHk1qy1L3VlDG5K7mg2JwuAbnRXaj8MwkMzkhdOmLyw7T7uj1dmX9fkG6
 185+PzS3G0X8FMxQZOdk18OoH1gYuoOTBsJ63f/VSza6UGbGFE2KxS5/NHQZKyRu7OWF
 +jg+pTYYvdBTvHjERfDKCkJxk3DCYSZK8LN5hOBiA/TFf/BG6fyezUxwk02G/DL0kJlX
 1fuKHUCfOe+fHUzowajW115ZR3GNJ/G0PzVGLxPpZt5EhF+JDHNHDtK6a7/onm0grGCQ
 ydhBRg7xxg6AdqXHNBscjCF1ZQjUJsLhESPBCDLuH17m6M/dNTL1AinYAG1FnAcsQLDe
 VU0A==
X-Gm-Message-State: AOJu0YzGUnDTVTTUg5p54TY1dlTskdRVDdSB7NlvGABZzjJU53njBLJX
 C0HD5H+caDG5tvLmfWtJBy/s7P9q4T93qrFJNMU=
X-Google-Smtp-Source: AGHT+IHIdf9FOygmwZiYUt4GRO0eMCUqU6mlnskJ4cLSEWTpOs9UYLoxlgTJd2NsqH1el382D75kfQ==
X-Received: by 2002:a92:cda3:0:b0:349:785:adc7 with SMTP id
 g3-20020a92cda3000000b003490785adc7mr22067151ild.15.1693266106975; 
 Mon, 28 Aug 2023 16:41:46 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:41:46 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Michal Meloun <mmel@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/36] bsd-user: Add struct target_stat to
 bsd-user/syscall_defs.h
Date: Mon, 28 Aug 2023 17:37:54 -0600
Message-ID: <20230828233821.43074-10-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::136;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x136.google.com
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

Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Acked-by:  Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 56198cc6a00..bd04b30a560 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -212,6 +212,44 @@ struct target_freebsd11_stat {
     unsigned int:(8 / 2) * (16 - (int)sizeof(struct target_freebsd_timespec));
 } __packed;
 
+#if defined(__i386__)
+#define TARGET_HAS_STAT_TIME_T_EXT       1
+#endif
+
+struct target_stat {
+    uint64_t  st_dev;               /* inode's device */
+    uint64_t  st_ino;               /* inode's number */
+    uint64_t  st_nlink;             /* number of hard links */
+    int16_t   st_mode;              /* inode protection mode */
+    int16_t   st_padding0;
+    uint32_t  st_uid;               /* user ID of the file's owner */
+    uint32_t  st_gid;               /* group ID of the file's group */
+    int32_t   st_padding1;
+    uint64_t  st_rdev;              /* device type */
+#ifdef TARGET_HAS_STAT_TIME_T_EXT
+    int32_t   st_atim_ext;
+#endif
+    struct  target_freebsd_timespec st_atim; /* time of last access */
+#ifdef TARGET_HAS_STAT_TIME_T_EXT
+    int32_t   st_mtim_ext;
+#endif
+    struct  target_freebsd_timespec st_mtim; /* time of last data modification */
+#ifdef TARGET_HAS_STAT_TIME_T_EXT
+    int32_t st_ctim_ext;
+#endif
+    struct  target_freebsd_timespec st_ctim;/* time of last file status change */
+#ifdef TARGET_HAS_STAT_TIME_T_EXT
+    int32_t st_btim_ext;
+#endif
+    struct  target_freebsd_timespec st_birthtim;   /* time of file creation */
+    int64_t   st_size;              /* file size, in bytes */
+    int64_t   st_blocks;            /* blocks allocated for file */
+    uint32_t  st_blksize;           /* optimal blocksize for I/O */
+    uint32_t  st_flags;             /* user defined flags for file */
+    uint64_t  st_gen;               /* file generation number */
+    uint64_t  st_spare[10];
+};
+
 #define safe_syscall0(type, name) \
 type safe_##name(void) \
 { \
-- 
2.41.0


