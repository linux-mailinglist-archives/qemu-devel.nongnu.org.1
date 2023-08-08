Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 873847740E3
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:12:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDp-0003dK-EE; Tue, 08 Aug 2023 13:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDl-0003Ht-Ab
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:13 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDj-0003i3-58
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:12 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31765aee31bso4445596f8f.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514609; x=1692119409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eCdA62/Dvn+WHdtoc4x1NnC5NRctPWftqEx5wGKru2s=;
 b=U6sBYPchYecEa1MJxJJJMAYkWcIMVkbrVr3RwSW7c/2u0Lmnt0oxRPgp5cULphiYvr
 5nPmJevsrs4OMhpFSAMJc3WnIhyqy9YIl+WS3UJpssG1RXb3jv918HIl2e7I+XEqDl1v
 kBa81gKx/LzQPqXOUAtDYmjk3erLShbb4b50+THLrSWZBdf8+yV2F98Bl3xdrEx3dJcm
 P8HgaTu+mIbFmXQkr7r79BbjeLqRxECoOuJSD5jpjPzXqGBklkXaBPjcLFgk3F52xzI9
 1faYF1YIJ9XgkOJKYULkobWohz3wyU005hIwnEJEWMN47tz7xbHG/L0ytRza6P1MUxYP
 729Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514609; x=1692119409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eCdA62/Dvn+WHdtoc4x1NnC5NRctPWftqEx5wGKru2s=;
 b=XqYmf/OWtEWhLblnsJboklsKZgBpAPaNluHfG0PPfT+BiVbNLAtJicRuu31LCH0Wiz
 +ycCsNp0bJkq1UzMEuH6ZEF84Ygmjoud7jpO6poneVeRCoOoPD1aetonOlsNkaOvnHcT
 SiTfQCI88orsKr5cjBca5fh7wzskIETzIqTDP7DNldLVMRj5SUSRDw1DNx5xSCw+FeMX
 FKOFeZ++uiIdot3GYTXsl+nYyPWoOCcoMPGmk2gdRe3QF25O7xECVI4D3nWimSAYYm9D
 4n8gxg6kVgyNSMgouXaO+wcway3mIs5Iz6yXvkWcdcG8Bu1AlrbJBzmF8ORfNXxlTUCq
 +fmQ==
X-Gm-Message-State: AOJu0Yxfx5N9qPLwND8pHuOFAznQ5eVvuCUTAwDmWBPFUuseqOObCWGv
 JIyvLI5EHouoaiBRKNyZBiCIN55tIMqODg==
X-Google-Smtp-Source: AGHT+IHJJ2nYY8ZQbo1F+HZmk7Q2Fcpo3rp4J0S6y/jTOAhLcylGuiAzN/R3y00oV42QZ0ScFRTwbg==
X-Received: by 2002:a5d:428a:0:b0:317:3f0c:b40e with SMTP id
 k10-20020a5d428a000000b003173f0cb40emr46920wrq.58.1691514609396; 
 Tue, 08 Aug 2023 10:10:09 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.10.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:10:09 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Michal Meloun <mmel@FreeBSD.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 24/33] Implement freebsd11 stat related syscalls
Date: Tue,  8 Aug 2023 08:08:06 +0200
Message-Id: <20230808060815.9001-25-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42f.google.com
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


