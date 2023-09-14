Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8F67A0F28
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:44:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgtB4-0003eC-8H; Thu, 14 Sep 2023 16:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAs-0003OS-Kh
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:54 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAr-0006PR-35
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:54 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40476ce8b2fso5234485e9.3
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694724171; x=1695328971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/iih9dJ+hepR7tg2MJ1JLAU9zFKmgRDnfWByt62B4ZM=;
 b=fnb3fwnewEHbAP0taik0zwXYXyCLFcFZmhCktbPDUpHQGhhVT0or5IVjHywGT/JNFa
 XJreUt7NX5hVAAH9tnNZfPIvKNyW52kW5+JroSIdfyfOg5bcHDChKZKMlMLXupZMve+0
 qsueZBtg9XyuJMVArW+rMneIGCyu8N57qk3tnjuWHpSKlHqALDGd73KWvOihrGwuQbYR
 ytWADBHbNZ5afR0tp5y0Dig0AWHwerQT+0/n7CqzD9L1yBldThd4fkQ9IbbxQ10zQTqj
 sxbCifS8CtdLfwhQ/qq5nmVJGy8+dtmxiztIeQ1E0jFRkgNWo8fQkf7Q0PlXEddKFTHX
 JJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694724171; x=1695328971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/iih9dJ+hepR7tg2MJ1JLAU9zFKmgRDnfWByt62B4ZM=;
 b=wM5YRhUQVTErUU6agUYhr09lPCCuvYIakB+KAGOsiC5KR4wspMyl7NdTOflzbsT8do
 o+J7rgWDn4+NOZjvtU+l6JdeqMO9XZy2sFDcAIY7vNbgGd/QQ12VHKZa3shlFDJNVO/A
 i2tQm6PGSx6ObCW7zo3720RGvqIeaXqr55D9v5f6+YIOBd44hasXxPbXCmulm3UEMTs7
 3hw3dE+aZFagyACmUMUVdSGRMWiYWiLgTDnVW1jtNI7CWQqM8qYO2wjlg4tU3dXL6Cln
 ZOzgu0D8S1IhB/2fbjopSiv2WHYGP98PWJqAf4EALULURdxGU+8NK6JnyuwlE6m5RHwf
 hTLQ==
X-Gm-Message-State: AOJu0YwNHh17xjeTkbaU4Wjlku4kBFsS48TiYGuzwyIp9y2EsJ+7k2VC
 AdsQQvp1tWNYKik+kffO6ZIBbK5anS8=
X-Google-Smtp-Source: AGHT+IGcuxNGZmwdz3CmrQelEc2gX1Nj1Bq/UqSyAm3aYqa223Ov2g+pfJPA62z4W63DTlec8XDpGA==
X-Received: by 2002:a5d:4941:0:b0:31a:d650:4b72 with SMTP id
 r1-20020a5d4941000000b0031ad6504b72mr5969875wrs.7.1694724171313; 
 Thu, 14 Sep 2023 13:42:51 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056000124300b0031f34a395e7sm2661880wrx.45.2023.09.14.13.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:42:50 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 17/23] bsd-user: Implement mincore(2)
Date: Thu, 14 Sep 2023 23:41:01 +0300
Message-ID: <20230914204107.23778-18-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
References: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/bsd-mem.h            | 23 +++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 27 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index b00ab3aed8..0c8d96d9a4 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -189,4 +189,27 @@ static inline abi_long do_bsd_minherit(abi_long addr, abi_long len,
     return get_errno(minherit(g2h_untagged(addr), len, inherit));
 }
 
+/* mincore(2) */
+static inline abi_long do_bsd_mincore(abi_ulong target_addr, abi_ulong len,
+        abi_ulong target_vec)
+{
+    abi_long ret;
+    void *p;
+    abi_ulong vec_len = DIV_ROUND_UP(len, TARGET_PAGE_SIZE);
+
+    if (!guest_range_valid_untagged(target_addr, len)
+        || !page_check_range(target_addr, len, PAGE_VALID)) {
+        return -TARGET_EFAULT;
+    }
+
+    p = lock_user(VERIFY_WRITE, target_vec, vec_len, 0);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(mincore(g2h_untagged(target_addr), len, p));
+    unlock_user(p, target_vec, vec_len);
+
+    return ret;
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 600d048120..8ba5fcc6ca 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -635,6 +635,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
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


