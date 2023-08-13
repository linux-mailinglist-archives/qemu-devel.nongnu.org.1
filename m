Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7F877AB01
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 21:49:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVGzb-0007mj-93; Sun, 13 Aug 2023 15:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzZ-0007lw-CL
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:13 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzX-0002Na-RP
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:13 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fe1fc8768aso37028465e9.1
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691955790; x=1692560590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5FGE2sta9eusQxC1zo0jWDIeINfRT8xwkVjpvLMM6rA=;
 b=FkEInF0QonkUzM6F5ty5NvQEkAz8BYPfey+n0xjKPgICJ1wUHaty0ovJwPHAP0/gxL
 nzTor5gw/YMGITae0xsPJ+xVEtYK0aSZo72dZqRHjlTLLWnm2hCR4C+1VkNVbVs+MKrH
 fnaUzY7qZN0kk+YpkLK/K1me1Wy94DxUFZpWWl2CX9tz58D6sjk+FaXN1MwCm+FGmfvp
 +fET/og/ZWbR0rMwMJbATzfYGsrKGoaQtPaFhd1PiccGXZRAe10nMwMPhPcYqwtRnwEf
 KyluuBCttefoP3WhV037QmPIVM9jwoiRmpG3PnUXHiq6x4e6mLx7PumPZjeh5uIdmTFY
 FxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691955790; x=1692560590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5FGE2sta9eusQxC1zo0jWDIeINfRT8xwkVjpvLMM6rA=;
 b=YI9wfSs7E63R62BB3mNqPTJh0kD74n49sjNlEaaa9lpyuDa3E2bBR/Bvz81IJXhdmf
 jk0+rnhTZl+3iNJjTz9qFoCYd2ZTQUWbS9pLH9zjPLcA7FX1BgoZlu/Sk9wVIrFwA2z2
 9wNp/9+rJ7Osl0maFwWF9WwhSM737W95c1yNWx8v7pQwFtyzcA3Cms3A/taAEFjNomwl
 8Bms87SBjPehn+/EyIj3FRGq5fkoa2k8N2oJ97n1cP+PgmUnv35l4KIFVBUO7W+91V1y
 cYukH5RE6HUnBpCtrJjVOpxCTdk/PrznjmgFyeNtFPdEcTbIUZKeyVeFtePMjyBL554/
 sKgQ==
X-Gm-Message-State: AOJu0YzsMZDpHyz+fLdMtmQIshmH3LGYWme/EF5Da54dV4RGfiH0ue7y
 jPVYiddqu0pcRIHGtHXKhEB6LnP5Nq8=
X-Google-Smtp-Source: AGHT+IGvr6dy+BdMnj9Glxof+hNY9Lv/lIiJnj6jBOL/pqgnhZKV4l9QajraiDi286YZgPe4tvsRAg==
X-Received: by 2002:a05:600c:214d:b0:3fc:193:734e with SMTP id
 v13-20020a05600c214d00b003fc0193734emr6877866wml.32.1691955790036; 
 Sun, 13 Aug 2023 12:43:10 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a7bc3d4000000b003fe263dab33sm12234536wmj.9.2023.08.13.12.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 12:43:09 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Michal Meloun <mmel@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 08/32] Add struct target_statfs to bsd-user/syscall_defs.h
Date: Sun, 13 Aug 2023 10:41:29 +0200
Message-Id: <20230813084153.6510-9-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
References: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x332.google.com
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
Acked-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/syscall_defs.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index f8f37517b2..2aefdd205e 100644
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
2.40.0


