Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB2D77A6DE
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:19:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBpv-0008GE-Qs; Sun, 13 Aug 2023 10:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpg-0008BK-8w
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:40 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpe-0000to-DH
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:40 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3197808bb08so35171f8f.2
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935956; x=1692540756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rLo5r1g4/RAPygywIJaYvQMkE2Y7Fg+pDuqNkJm5wq4=;
 b=RBzJymzZ0lNvzdcPaapVEgNzZiDCxqNtq0SsxqNvL5HqC0lDxOM+CkGZmDNmjuXhUe
 L5WGwLH05J0AF7dN1iSzRN86aqN4xHxS3kFNYnYYt8GMUL+JAW4NWY3m5ouB8+bPjnye
 QKYvmbNOV+7g/qZhOQIkJNzj5Qjmhmd9ZsghtAoekuIqIj2iD2CkaZ8tAH8Wfglv5CXl
 ikgP8N7yfKe2bAfTpC6LGwjoSDKof6IjotY30xb2WFs4DpI3X4nZjbX2NvZOpRu2kYW/
 dJkkbNCsV7JU/U6JjPq58qeKRc6/+xIoaDrKTGfP4BzqDiUMTZjtKdqPwAOY6JzAVF0k
 ncMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935956; x=1692540756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rLo5r1g4/RAPygywIJaYvQMkE2Y7Fg+pDuqNkJm5wq4=;
 b=aB9mMuhKVaY62OwOSjDJ/JEBXWiDqqpmKtvwCJ9Z/PaOj7CKtxYvhd8altflmjGUsz
 LiNbWt/y4gbsU/rJWI51bM89cQ7oI8+ePaFeN3qCzL4G3DhnC2ssVnxQu/IRD1Vzo/tm
 JeGTyt9TfNj1J+oGTWwgDDdeEh88fiPMEYbV+xHARZ1W7mYVK5e4yaCke9DBaLjYfrBz
 b/niu6cnbaCraKt78qcJCdjUgQDkZxia1MZTHDgtzVtQ0QFNxdznQK33KRC8ib5KKbj4
 Y5WdlM961ZHARmz4occaJvCqKB5LhOOWtNtjkqnGicWFz75wW2rY9dLOQ1Tczq04akVG
 hcqA==
X-Gm-Message-State: AOJu0YxPExGoNdsRhCqlnbuov/Ist+pCMMqxdARZ7quuVKdJsO42tUuy
 HTeajSKvv9Fif2aVQW+WxevO2c5xA9M=
X-Google-Smtp-Source: AGHT+IF20wSvtgPPh97hajSU1QtfWbrWoZlV4G0K8QLXBjheHl2OlhOqaCgzjJlp/Un19zEmZam/Eg==
X-Received: by 2002:adf:f1cb:0:b0:317:66e5:be62 with SMTP id
 z11-20020adff1cb000000b0031766e5be62mr5184891wro.6.1691935956582; 
 Sun, 13 Aug 2023 07:12:36 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:36 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Michal Meloun <mmel@FreeBSD.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 23/32] Implement freebsd11 stat related syscalls
Date: Sun, 13 Aug 2023 05:10:04 +0200
Message-Id: <20230813031013.1743-24-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42c.google.com
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

Implement the freebsd11 variant of the following syscalls:
fstat(2)
fstatat(2)
fhstat(2)
fhstatfs(2)

Co-authored-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-stat.h | 78 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index aef55c8bb5..2e0c7245df 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -24,6 +24,17 @@ int freebsd11_stat(const char *path, struct freebsd11_stat *stat);
 __sym_compat(stat, freebsd11_stat, FBSD_1.0);
 int freebsd11_lstat(const char *path, struct freebsd11_stat *stat);
 __sym_compat(lstat, freebsd11_lstat, FBSD_1.0);
+int freebsd11_fstat(int fd, struct freebsd11_stat *stat);
+__sym_compat(fstat, freebsd11_fstat, FBSD_1.0);
+int freebsd11_fstatat(int fd, const char *path, struct freebsd11_stat *stat,
+        int flag);
+__sym_compat(fstatat, freebsd11_fstatat, FBSD_1.1);
+
+int freebsd11_fhstat(const fhandle_t *fhandle, struct freebsd11_stat *stat);
+__sym_compat(fhstat, freebsd11_fhstat, FBSD_1.0);
+int freebsd11_fhstatfs(const fhandle_t *fhandle, struct freebsd11_statfs * buf);
+__sym_compat(fhstatfs, freebsd11_fhstatfs, FBSD_1.0);
+int freebsd11_statfs(const char *path, struct freebsd11_statfs *buf);
 
 /* stat(2) */
 static inline abi_long do_freebsd11_stat(abi_long arg1, abi_long arg2)
@@ -57,6 +68,19 @@ static inline abi_long do_freebsd11_lstat(abi_long arg1, abi_long arg2)
     return ret;
 }
 
+/* fstat(2) */
+static inline abi_long do_freebsd11_fstat(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    struct freebsd11_stat st;
+
+    ret = get_errno(freebsd11_fstat(arg1, &st));
+    if (!is_error(ret))  {
+        ret = h2t_freebsd11_stat(arg2, &st);
+    }
+    return ret;
+}
+
 /* fstat(2) */
 static inline abi_long do_freebsd_fstat(abi_long arg1, abi_long arg2)
 {
@@ -70,6 +94,23 @@ static inline abi_long do_freebsd_fstat(abi_long arg1, abi_long arg2)
     return ret;
 }
 
+/* fstatat(2) */
+static inline abi_long do_freebsd11_fstatat(abi_long arg1, abi_long arg2,
+        abi_long arg3, abi_long arg4)
+{
+    abi_long ret;
+    void *p;
+    struct freebsd11_stat st;
+
+    LOCK_PATH(p, arg2);
+    ret = get_errno(freebsd11_fstatat(arg1, p, &st, arg4));
+    UNLOCK_PATH(p, arg2);
+    if (!is_error(ret) && arg3) {
+        ret = h2t_freebsd11_stat(arg3, &st);
+    }
+    return ret;
+}
+
 /* fstatat(2) */
 static inline abi_long do_freebsd_fstatat(abi_long arg1, abi_long arg2,
         abi_long arg3, abi_long arg4)
@@ -178,6 +219,24 @@ static inline abi_long do_freebsd_fhopen(abi_long arg1, abi_long arg2)
     return get_errno(fhopen(&host_fh, arg2));
 }
 
+/* fhstat(2) */
+static inline abi_long do_freebsd11_fhstat(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    fhandle_t host_fh;
+    struct freebsd11_stat host_sb;
+
+    ret = t2h_freebsd_fhandle(&host_fh, arg1);
+    if (is_error(ret)) {
+        return ret;
+    }
+    ret = get_errno(freebsd11_fhstat(&host_fh, &host_sb));
+    if (is_error(ret)) {
+        return ret;
+    }
+    return h2t_freebsd11_stat(arg2, &host_sb);
+}
+
 /* fhstat(2) */
 static inline abi_long do_freebsd_fhstat(abi_long arg1, abi_long arg2)
 {
@@ -196,6 +255,25 @@ static inline abi_long do_freebsd_fhstat(abi_long arg1, abi_long arg2)
     return h2t_freebsd_stat(arg2, &host_sb);
 }
 
+/* fhstatfs(2) */
+static inline abi_long do_freebsd11_fhstatfs(abi_ulong target_fhp_addr,
+        abi_ulong target_stfs_addr)
+{
+    abi_long ret;
+    fhandle_t host_fh;
+    struct freebsd11_statfs host_stfs;
+
+    ret = t2h_freebsd_fhandle(&host_fh, target_fhp_addr);
+    if (is_error(ret)) {
+        return ret;
+    }
+    ret = get_errno(freebsd11_fhstatfs(&host_fh, &host_stfs));
+    if (is_error(ret)) {
+        return ret;
+    }
+    return h2t_freebsd11_statfs(target_stfs_addr, &host_stfs);
+}
+
 /* fhstatfs(2) */
 static inline abi_long do_freebsd_fhstatfs(abi_ulong target_fhp_addr,
         abi_ulong target_stfs_addr)
-- 
2.40.0


