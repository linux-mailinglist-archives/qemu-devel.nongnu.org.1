Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B4E78189C
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 11:50:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXIa9-0008Fv-H4; Sat, 19 Aug 2023 05:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIa6-0008Fg-S0
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:49:18 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIa4-0004QS-Mj
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:49:18 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31aeef88a55so90367f8f.2
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 02:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692438555; x=1693043355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n7/IWLVzM+rb7qpxr0YHxCfxEsJwwJSGTfo1cqhcDsM=;
 b=NFF1l15ELhy7qN+0NWO5MVAtCagxv4byAAf7Xf6kMA28qDX/IMAbNchFriZKTLF1UB
 66fawg1NV09aSdsEQfLoBTrfV9wtIrWVJfAsfatk71JRPssHMRvgxd8T72fLAa+clN/x
 1K/fGpJViDf7M3x+dVjBvxGR7yNV0SYF+CW6spr6w1UvtKFEaPQCU6bdNlp51TXtiy9a
 YTDQVzHCVsFBnHiY2FaD5L8MR1DsUZDmEPpSA1x35Pfu0eEhCwLta2ZKFGYlvaTV48Ky
 AmLEdPwK7cJzRKph6hog4sN2e/vI8oQmEz5/+k0tnKbbk7k5OANNCqW41BE0DAfxXz8z
 jGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692438555; x=1693043355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n7/IWLVzM+rb7qpxr0YHxCfxEsJwwJSGTfo1cqhcDsM=;
 b=OgzYyos42eqztkAfvdLBx7f4gxekZsEl0EX2+Fa5g5EsQmwYUeBP9Z1J1WH1khn91m
 nQ9OswFh1L67GwB9bR8s0urm1XROU1gXV7DuSdY5IgSW8XT35RiMwgVgsUI7InRMb6nu
 g+TR2pfW1CEo8QA6zZC3xHDf6rhMh7GC5rxgdqJhudaTdviQV9j5HUNqalMtrX2tOskV
 I11pOzlen/w0Y7nU04CdM01TEFKPsGm107YYfElyDtxKu9II546E2+hXW5FopQcUfzGE
 8tBRREOWF5dhGTn8Nn1Eaba4+j2MI0RnsCwo35+CmCNsUN8W6AVYnsyT9lCsa+Rwcle4
 W7tQ==
X-Gm-Message-State: AOJu0YxlsbWR9ZE/xClxySjz3mRkNiZUSFw2aDja3ZYa+cyC8d3HjIyj
 urEw1Cq94vK6iljR6DxbIurHXB18tfg=
X-Google-Smtp-Source: AGHT+IE1YccK+3w1O6U+NvsELMZrvL8TsyIz/kBFvRpwwoy5GisA5er6jCynBoL/EGIkE3gNw3wvSA==
X-Received: by 2002:a5d:4911:0:b0:314:1f6:2c24 with SMTP id
 x17-20020a5d4911000000b0031401f62c24mr1128215wrq.36.1692438555072; 
 Sat, 19 Aug 2023 02:49:15 -0700 (PDT)
Received: from karim.my.domain ([197.39.34.171])
 by smtp.gmail.com with ESMTPSA id
 o18-20020adfead2000000b003143b14848dsm5617216wrn.102.2023.08.19.02.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 02:49:14 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Kyle Evans <kevans@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 14/22] Implement msync(2)
Date: Sat, 19 Aug 2023 11:47:58 +0200
Message-Id: <20230819094806.14965-15-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x433.google.com
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

Co-authored-by: Kyle Evans <kevans@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.h            | 11 +++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index a6446a454c..68d79ac080 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -89,4 +89,15 @@ static inline abi_long do_bsd_mprotect(abi_long arg1, abi_long arg2,
     return get_errno(target_mprotect(arg1, arg2, arg3));
 }
 
+/* msync(2) */
+static inline abi_long do_bsd_msync(abi_long addr, abi_long len, abi_long flags)
+{
+    if (!access_ok(VERIFY_WRITE, addr, len)) {
+        /* XXX Should be EFAULT, but FreeBSD seems to get this wrong. */
+        return -TARGET_ENOMEM;
+    }
+
+    return get_errno(msync(g2h_untagged(addr), len, flags));
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index aea4e337ff..3871b15309 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -499,6 +499,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_mprotect(arg1, arg2, arg3);
         break;
 
+    case TARGET_FREEBSD_NR_msync: /* msync(2) */
+        ret = do_bsd_msync(arg1, arg2, arg3);
+        break;
+
 #if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
     case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
         ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
-- 
2.40.0


