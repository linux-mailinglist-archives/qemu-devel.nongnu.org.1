Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76115799A99
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 21:39:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf3n9-00060U-UX; Sat, 09 Sep 2023 15:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3n6-000601-Ta
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:49 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3n4-0003FL-PM
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:48 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-401ec23be82so34937785e9.0
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 12:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694288325; x=1694893125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PVDg2xAqYdL1qO9Pj5OML28yXvjot1xjk5EVQ6V643o=;
 b=ih44dzP04J01qv6p6XaD666TEz6fKJK0I7tylB50Uwq/1spoiS0Jngu+Xf77EoPK5T
 vOfSZ5YopxlSZCWxZYS5Rplx6GwStXNu6EzwtY/06oA7Y14VguZp3R780W6GCD2RLY7b
 6c/GX5qfDUKbY4Tf1HlCK+YushulIPEVZO6BxaXzHYfgHPighQt+aTlAQ16tdQxTlTnE
 l5sKzmhRWzhK1Ntx6FjRxTt9ljP8/GhjY1bR2uknE8wp4BY2gFy1Q9XKrFUrsGuBNyDL
 B/XL7uPg/PIJHuDI4zerd8Vrz+gVmz2AKURABby0iS366w83eSZFCEq0IKSyrHii3ZCw
 o32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694288325; x=1694893125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PVDg2xAqYdL1qO9Pj5OML28yXvjot1xjk5EVQ6V643o=;
 b=I5Omr2Fe61q+RWIVhfzpJgxaQsBkcqb4Z1d2IaGLG49elLSiKj7Sx1/jSt2JQJwggE
 OGAJhaXRwqVLOmtJiCumeGcRT30ns6gzIymEaARZb4RXRWdC8GAfB8VjhSa1nP5tzxV3
 qP3wc59IFxi78kudmKzP5v+EW3p2TjlKNaMIs72xyvag+DcFpHl4YlSNh9XHxBULHytJ
 mrVAYXX09hR+IBsrlzmUGfXI877+kDH35D319RLHs1eWnSeo05GHjvmQptdDYQnCXTNo
 zHXCpAI+3RywJrN34/a+t5CWCMj/VOH3m6iXbgbtEmL6EuCvaq/Jxtbwjk+K9q6Y2oHi
 bkig==
X-Gm-Message-State: AOJu0YynZPvSjrMgAQdG+PVrXKaSyZieJ0WAu/rKlUmeM42Y08Lz2da9
 GOUBcXvHrAtJlSlPEpKhopvYfWh/p2Y=
X-Google-Smtp-Source: AGHT+IHDwBlQ+qXFeBtrKYapxcyrBHDiywBSs4K44Opfm9cOrwJIeIGusu6HndHGYyz2O9EOf0vUZA==
X-Received: by 2002:a05:600c:2301:b0:400:ce4f:f184 with SMTP id
 1-20020a05600c230100b00400ce4ff184mr5189636wmo.41.1694288325239; 
 Sat, 09 Sep 2023 12:38:45 -0700 (PDT)
Received: from karim.my.domain ([197.39.250.27])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c260d00b003fe4ca8decdsm8612812wma.31.2023.09.09.12.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 12:38:44 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 17/23] bsd-user: Implement mincore(2)
Date: Sat,  9 Sep 2023 22:36:58 +0300
Message-ID: <20230909193704.1827-18-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 bsd-user/bsd-mem.h            | 22 ++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 26 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 0e16051418..1dabbe36e6 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -189,4 +189,26 @@ static inline abi_long do_bsd_minherit(abi_long addr, abi_long len,
     return get_errno(minherit(g2h_untagged(addr), len, inherit));
 }
 
+/* mincore(2) */
+static inline abi_long do_bsd_mincore(abi_ulong target_addr, abi_ulong len,
+        abi_ulong target_vec)
+{
+    abi_long ret;
+    void *p;
+    abi_ulong vec_len = DIV_ROUND_UP(len,TARGET_PAGE_SIZE);
+
+    if (!guest_range_valid_untagged(target_addr,len) || !page_check_range(target_addr, len, PAGE_VALID)) {
+        return -TARGET_EFAULT;
+    }
+
+    p = lock_user(VERIFY_WRITE, target_vec, vec_len, 0);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(mincore(g2h_untagged(target_addr), len, p));
+    unlock_user(p, target_vec, 0);
+
+    return ret;
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index f5d60cf902..8d1cf3b35c 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -527,6 +527,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_minherit(arg1, arg2, arg3);
         break;
 
+    case TARGET_FREEBSD_NR_mincore: /* mincore(2) */
+        ret = do_bsd_mincore(arg1, arg2, arg3);
+        break;
+
 #if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
     case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
         ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
-- 
2.42.0


