Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E6B774102
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:13:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDV-0001v0-EQ; Tue, 08 Aug 2023 13:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDO-0001Jc-1z
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:52 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDL-0003EI-65
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:49 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-317716a4622so4653382f8f.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514585; x=1692119385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2nKvcztbP/6xm29u8gk6LRQW/5mPeFJ/olFfoKE/TSg=;
 b=OkvclSy3esekZGOUvUovaRzmXkiWjrn30J+RrDVEasuzbfUSuX7BJW2fkI3eWfKmqk
 HOU4hIzyOtBMu6ImirK4mnGIpZPxoqvKpz8ZJz2eLEuKEBxNhJz//7MesbS0mIyNwsfI
 LXYPaTXX4UtsBt02VC3b8sOYAxJ3nHQ9awpxxE1edhTF0AG0fTn2xTnDjjynIkDXvA6v
 xjKJRoittINgDSMOlT+Rj1fS0TGpROsj7b3AFFQyujQ/H3t5BW0pXSs0mYbRMTwqkj3P
 +ap4CGssrMSs07KlDxA1Ng5Yp/xOQvu4JjCQL/c7VlHrYjuiEFpxIybQj4NzPDugP8Sr
 y8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514585; x=1692119385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2nKvcztbP/6xm29u8gk6LRQW/5mPeFJ/olFfoKE/TSg=;
 b=Sjr+am9dKdsN+6e5kBee5mqi2H2qBnh7lnpM6UqToroYyo3RRJan9lfE/5LOO0X9eL
 kt35vp1p6pFsBoWFCnG3bQXmKpCkFFCGgQdLwVpRgj4fDYeXu3ADpwMy862dSPcBeeHp
 Xi/AIX5IkadPBNNePmoeqcgRyGncn47CQITPRfBgKsXUdZh5ot9sIcvhz6V10AKUqoYu
 9C8docuSgcqRqeykwEnUUkLkmHgNElZs36FfsFFrL7UhSGD7pAlmj2AFFjWS/hc5+o0m
 sdna3tjtv5Uets/d6MbvOWJTOlvSZ7QsP/Gbbc6BnG4mWoFdBJi3Yva9TwTLEFzY9HKm
 NhIg==
X-Gm-Message-State: AOJu0Yw5mXNq60xBT/KuiyplEp/MJh5jA6FHYpok5omiiZu2USu8Sz7Q
 MV0nPZzDr2WjqH4Pce42XRdTCQl/A0okzg==
X-Google-Smtp-Source: AGHT+IFSbM9fCFmHFeodvUNdV7HeWq+0R93/APawpiIgFPe9zvxoB8LY1dZxxAFrhCYy3Tua4Qc9Sg==
X-Received: by 2002:adf:f6cf:0:b0:317:650e:9030 with SMTP id
 y15-20020adff6cf000000b00317650e9030mr48042wrp.57.1691514585261; 
 Tue, 08 Aug 2023 10:09:45 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:09:44 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 06/33] Add struct target_freebsd11_stat to
 bsd-user/syscall_defs
Date: Tue,  8 Aug 2023 08:07:48 +0200
Message-Id: <20230808060815.9001-7-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42e.google.com
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
 bsd-user/syscall_defs.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index b6d113d24a..5ef76ffa52 100644
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
+    __uint32_t st_gen;      /* file generation number */
+    __int32_t  st_lspare;
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
2.40.0


