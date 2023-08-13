Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A1377A6CD
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:17:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBpO-00085b-0U; Sun, 13 Aug 2023 10:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpL-00084F-3i
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:19 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpJ-0000nk-Kl
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:18 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31781e15a0cso3127102f8f.3
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935936; x=1692540736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H+kI/UOoSzs0V1atGOhJOSHuZhuHYYPbhxRnCeQAmR4=;
 b=JG2Ab5fTYD1v7J3hmEfv+XcQOdsEAP8lHAvX5QRLhs8WpVWuVL86ekayxW3S72AIA8
 0hbXMk1p6S09waLaxqBm3wm69GTLfpgKr52+3/ThzfRkAzOlce5TgyBjgX0RFbP4L6KD
 SO1UdVCVaOpSsn7A2Qzk4To6zDiAMLknBufEHq798NLN8jqg/C7KfvYyt6FrAhmrik4n
 Uq64zd4s8epAmzcVAV7gWY90qbrnsb9blk/bBREBUMEuNOYT1MqcxUCyc9YHs0tRCF81
 JSrb69kZ6EXcjQdmwPenxbPC/pTM3BJ6Bk7bahlMJyAy95XxPetUy1V5IjH8JsWFHXZm
 cfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935936; x=1692540736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H+kI/UOoSzs0V1atGOhJOSHuZhuHYYPbhxRnCeQAmR4=;
 b=bKYJo1cUtUCEsb3cxaYSZBohil3iMQqSr350aut7zknrnEnUJpmASTX+tY+TitJWeF
 JN25tRByGLSBLZKcVly104RgHqx6LFSplojUJrYQKGWWMDt9h2++95BOMJx35l5CFDsT
 TQb+BvFZtg04j9hmkPAxfqaKptThY07LbWgt19FmOT/vKIGDYc3mS+XLA3aYS5ciB7sE
 BKzZe15m2T4JKrZTT5xxPtGzuqut5EqMs33EyZjC/JUShOZH1tefGMSI1ioGP4gRqTqa
 C1Izeh26fijvQIwWV9lEoDc3HCyupDkUpt7bmY4SEddP/XYhp7etB/tucHEEqh0bsAcB
 ttPw==
X-Gm-Message-State: AOJu0YwIIJ0XeLjGzOz5GwhnEbtZhrJLPIZ6qzs2X7Re+rrpBrdL9Co5
 OLy5PPHNgAscXNKfytjfonqKbUAyeO4=
X-Google-Smtp-Source: AGHT+IGrNscV4FGAiHimDEmo4GwNz1BojGsvRcik6wAH0/tKpsmZ5mlJHW4P9JkAcAPUM1A9iKbnpA==
X-Received: by 2002:adf:e74a:0:b0:313:efed:9162 with SMTP id
 c10-20020adfe74a000000b00313efed9162mr5028806wrn.59.1691935936073; 
 Sun, 13 Aug 2023 07:12:16 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:15 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Michal Meloun <mmel@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 06/32] Add struct target_stat to bsd-user/syscall_defs.h
Date: Sun, 13 Aug 2023 05:09:47 +0200
Message-Id: <20230813031013.1743-7-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
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

From: Michal Meloun <mmel@FreeBSD.org>

Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Acked-by:  Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/syscall_defs.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 30c24bfe1b..41259848cd 100644
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
2.40.0


