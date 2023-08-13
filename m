Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 986C977A6BB
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:13:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBpR-00086Y-G8; Sun, 13 Aug 2023 10:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpP-000867-Bj
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:23 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpN-0000pm-Sg
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:23 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fe2fb9b4d7so31609445e9.1
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935940; x=1692540740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5FGE2sta9eusQxC1zo0jWDIeINfRT8xwkVjpvLMM6rA=;
 b=HZOQAd6GNph15RAacsQ74vQbCi2qPO8spTOQsnSCd+9wRx+AiGssClvPJJD8/E7Hca
 QpQST8YSo4rne8Bv48ICaGXnm/E8nuL8N5baMh6QvnntKzJK9nrM25GGMjWwfYnFrN3x
 9Drr+tjX3y5epmo71MxhaZzvjqJVYGPSPbWuabjM5jXibrO1Gs5YwwbXYrlqUSO0lT+u
 ofG5q1sXVgpLy1BBEmjYcdh2GBQn3QJlYwthqhzvguWQD2Ewx2B6FCK6trDkCoy6S94C
 7LHoJsBQgOxLutES0v+9dppfe0RdsdSUiasyWP57v6JDM8BQafglo9xHNu2InzIYeR0l
 MXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935940; x=1692540740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5FGE2sta9eusQxC1zo0jWDIeINfRT8xwkVjpvLMM6rA=;
 b=MrlB75EbxN6szpflBEhcuCXLk5/sLxAqiX0muS3lG/MrRjlsjBpmmb4ZdA7a2J7elK
 nCI6/0B3J0ZMkykaQYWpZz38fdInWtWMydx2yqXHCH3p6p1lteKT+RBffCbqUEmi/V+5
 SvgAyVpYGuseee40uOilSs/97oZM7EwQdE4opgLdlNpRBHmq77prRcpka5Frvfrx1Ie7
 /QbMEJINREoefny+WItcq+lypu1wpeXdxPxX/MmXX2xyDXlMPvSbK50/9zfAk9XEKXA+
 2g9e1Q8/nWfJUWbjBaxkgjdnFX2jrh7JiVWUEtAc4GGwjoYhynW3pBML1LX+dH+AR+zj
 PgQw==
X-Gm-Message-State: AOJu0Yydhs6m+QLzF7QWl/jq98vzS3w5p7pXY6rVtHW1MsHdvgfryMcM
 9oJgYPnXW2tkN8IvfKfI3Ha3tHziY8A=
X-Google-Smtp-Source: AGHT+IHW5fHkSKUtsObpciTlb8+lasYSuROMEbLFikWrEcHMsDx8Nk5sZTspaRZURQdDxC6ElVY93Q==
X-Received: by 2002:a5d:5962:0:b0:319:6afc:7a3c with SMTP id
 e34-20020a5d5962000000b003196afc7a3cmr2679898wri.10.1691935938211; 
 Sun, 13 Aug 2023 07:12:18 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:17 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Michal Meloun <mmel@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 08/32] Add struct target_statfs to bsd-user/syscall_defs.h
Date: Sun, 13 Aug 2023 05:09:49 +0200
Message-Id: <20230813031013.1743-9-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x336.google.com
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


