Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2451E773F54
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 18:45:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTPow-0006au-Iv; Tue, 08 Aug 2023 12:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTPok-0006aM-Lq
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 12:44:23 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTPoj-0005rA-2m
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 12:44:22 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-267fabc8465so3303219a91.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 09:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691513059; x=1692117859;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n2shxOoO7xBKvOU4xI5tsr5G7Dr0zAUeRsEDScyxYdU=;
 b=jwW9U57h+MjuEV6aVWGCdMUP74ivN+cSBqCnX6Gy/dMmgLrurUmmFq89z1dMRfW9x0
 A3t1nIfH/AGyELKOZWfhOX6edlImg9xf1PW+zdZkdtMJDFZMWV7rxaTJ1FbHogKhjQaC
 KTGi4LntKt/4YAb7H28u1E5ggu7WAj15Le9DRqR2Tk9KIwc4AoWz1vZWkkjMvs4+VlqU
 JRCQsuKZf+fptA6eMAY18K+5MYZtqBkRliRtN9HlvXplcpH3sXdjXs4CVsKk25EkzWFT
 AqdxI++SvRwh/f/kVPFSZrPsQwk3cJBRoBHv8Y4PHZDB9MAUXxSwux0ykbYiVbmy1zLp
 3Lbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691513059; x=1692117859;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n2shxOoO7xBKvOU4xI5tsr5G7Dr0zAUeRsEDScyxYdU=;
 b=X21gxJUfZAp7STSom7wZd3CBs6Un22ZX7U7wZux5GAHJmTzLGqnCr+MP6ZbgVXGimD
 on9tVKyUymp8lVfCFyK8IGZM5XwOcnIYftpx9itSaRGhQAn2GOnFJq7J+gznuq5nmW+s
 LudEL98EHkxXZjMxNV6103S2Gxr2CKRxFkb24iyGeRJG90ein+iHrFZkz1QlnSt9pv/b
 e99qdF9z/NUMtGR0muRzokt71nt1eanacBBiTg9vquBl/ClnrHXcD5ysPlsNQR88Cm3v
 AiboRT7oVCKgBOpT9WvUFjs5bFfvmfdVexiKMrv1RhajqhYBkKxODhOKpJ0tdhEhA+0C
 56Ow==
X-Gm-Message-State: AOJu0YwmVEMIu8IfUnl1/Fe03OXd751IF2OKjMGXpOeIwZkhX1Rr62qI
 Mz+9/dbiSrEqulY2JPpDRomZRztYnRR+2XPRLOM=
X-Google-Smtp-Source: AGHT+IExkmucMEAxWkDs4ulyQ7XD4nPk1GwZvF6W8Ne9bai7k+uc6rH0wROVHerwFAg1tCcUaaPXnA==
X-Received: by 2002:a17:90a:970b:b0:268:10a3:ceaa with SMTP id
 x11-20020a17090a970b00b0026810a3ceaamr98807pjo.21.1691513059385; 
 Tue, 08 Aug 2023 09:44:19 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 i5-20020a17090ac40500b00265c742a262sm8052899pjt.4.2023.08.08.09.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 09:44:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH] qemu/osdep: Remove fallback for MAP_FIXED_NOREPLACE
Date: Tue,  8 Aug 2023 09:44:18 -0700
Message-Id: <20230808164418.69989-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

In order for our emulation of MAP_FIXED_NOREPLACE to succeed within
linux-user target_mmap, we require a non-zero value.  This does not
require host kernel support, merely the bit being defined.

MAP_FIXED_NOREPLACE was added with glibc 2.28.  From repology.org:

                  Fedora 36: 2.35
          CentOS 8 (RHEL-8): 2.28
                  Debian 11: 2.31
         OpenSUSE Leap 15.4: 2.31
           Ubuntu LTS 20.04: 2.31

Reported-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/osdep.h | 3 ---
 linux-user/elfload.c | 1 -
 2 files changed, 4 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index cc61b00ba9..21ef8f1699 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -289,9 +289,6 @@ void QEMU_ERROR("code path is reachable")
 #ifndef MAP_ANONYMOUS
 #define MAP_ANONYMOUS MAP_ANON
 #endif
-#ifndef MAP_FIXED_NOREPLACE
-#define MAP_FIXED_NOREPLACE 0
-#endif
 #ifndef MAP_NORESERVE
 #define MAP_NORESERVE 0
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 36e4026f05..9d9c79a653 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2807,7 +2807,6 @@ static void pgb_reserved_va(const char *image_name, abi_ulong guest_loaddr,
     /* Widen the "image" to the entire reserved address space. */
     pgb_static(image_name, 0, reserved_va, align);
 
-    /* osdep.h defines this as 0 if it's missing */
     flags |= MAP_FIXED_NOREPLACE;
 
     /* Reserve the memory on the host. */
-- 
2.34.1


