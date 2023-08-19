Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDE17818AF
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 11:51:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXIaM-0000PU-Ou; Sat, 19 Aug 2023 05:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIaK-0000C5-02
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:49:32 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIaH-0004S2-Ll
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:49:31 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31963263938so1488242f8f.2
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 02:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692438567; x=1693043367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nv7yMt8dX1c1ZS9qclIo4WY6Lz8Ylr5dRKgu2Ds1pu8=;
 b=RXNpFGkdU9qWzoY8/9jj53exHwUS4vtoTlrKOBs3BdoGavinQiYZwc0SKAJViM9w5x
 sEwK12+Q7I3Lh3pfhf0zc6ncb+s7Vnm3aFlZIgU4Q8yriAgZDfoA+RSKzGx8BtH7mum6
 E3hLZNZpK0DcLKJN1XbinOn74sEEl4z9U+fnDQ9EZtReBS4s/1nmdKFXj8Xs4EcuFBOy
 0+xk7cwbm7O2qBWqhN3nPEGdSE7lTDFmvrFR+4irnFxc/ADKLb70Iq7DI1YDjnrjQxes
 HXTPbAE14DXiBpWO42+w/4Vv2zkXIssltIYlOkc2Rwar73ELkhoz1iyJCE8+mEvQ6EOG
 Dabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692438567; x=1693043367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nv7yMt8dX1c1ZS9qclIo4WY6Lz8Ylr5dRKgu2Ds1pu8=;
 b=D+3dHSj+y6DWXedtmWtATh1mEuP889rS3twWzN7wIkeM8O+kjYFDIlgnzYmQScZWOx
 7UXY+kN+PJJ8zNxpJq2xH3aWKtRmasWa/MZHMY0c3I92UEH8Z/7gUna54kfyHk3TtOM0
 ZB8qPxCZmqoaSGb6ulE9gefH4qONa1ke8fK/4po9IUJw5BscEWqj60PRQUEDbqOT5fXH
 A05ckZrkwFojKkkJSex/orBko4apOBcJ1s63QFxXOIr5J86b08WEHqUxXeMRKL7e+eIx
 VYPSTVGlmjZG+2iJAotTv1qP5JZDLw4GS7nUu6xDxOV/7kjecfcmTixeJKfk4RNJJvso
 3LZA==
X-Gm-Message-State: AOJu0YzoStZBF8sBxYwZ3SiRnz0lavmqRkIw/FB++EWVRus6F82kTbrH
 IluzVzhV355ZOQGMaQL3ZMrX9rJIICI=
X-Google-Smtp-Source: AGHT+IFCjtGoobcG8JDQrnRyAT/o2IdYM9Py8K+B01t6SVPT7WcCu66ZgbzAJy043fr7aKKIwgIURw==
X-Received: by 2002:adf:f184:0:b0:314:1fd7:188b with SMTP id
 h4-20020adff184000000b003141fd7188bmr1152979wro.17.1692438567283; 
 Sat, 19 Aug 2023 02:49:27 -0700 (PDT)
Received: from karim.my.domain ([197.39.34.171])
 by smtp.gmail.com with ESMTPSA id
 o18-20020adfead2000000b003143b14848dsm5617216wrn.102.2023.08.19.02.49.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 02:49:27 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 =?UTF-8?q?Mika=C3=ABl=20Urankar?= <mikael.urankar@gmail.com>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 17/22] Implement do_obreak function
Date: Sat, 19 Aug 2023 11:48:01 +0200
Message-Id: <20230819094806.14965-18-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42a.google.com
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

Co-authored-by: Mikaël Urankar <mikael.urankar@gmail.com>

Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.h            | 85 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  7 +++
 2 files changed, 92 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index edbccd3111..6f33148eb7 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -167,4 +167,89 @@ static inline abi_long do_bsd_mincore(abi_ulong target_addr, abi_ulong len,
     return ret;
 }
 
+#ifdef DO_DEBUG
+#define DEBUGF_BRK(message, args...) \
+    do { fprintf(stderr, (message), ## args); } while (0)
+#else
+#define DEBUGF_BRK(message, args...)
+#endif
+
+/* do_brk() must return target values and target errnos. */
+static inline abi_long do_obreak(abi_ulong new_brk)
+{
+    abi_long mapped_addr;
+    int new_alloc_size;
+
+    DEBUGF_BRK("do_brk(" TARGET_ABI_FMT_lx ") -> ", new_brk);
+
+    if (!new_brk) {
+        DEBUGF_BRK(TARGET_ABI_FMT_lx " (!new_brk)\n", bsd_target_brk);
+        return bsd_target_brk;
+    }
+    if (new_brk < bsd_target_original_brk) {
+        DEBUGF_BRK(TARGET_ABI_FMT_lx " (new_brk < bsd_target_original_brk)\n",
+                   bsd_target_brk);
+        return bsd_target_brk;
+    }
+
+    /*
+     * If the new brk is less than the highest page reserved to the target heap
+     * allocation, set it and we're almost done...
+     */
+    if (new_brk <= brk_page) {
+        /*
+         * Heap contents are initialized to zero, as for anonymous mapped pages.
+         */
+        if (new_brk > bsd_target_brk) {
+            memset(g2h_untagged(bsd_target_brk), 0, new_brk - bsd_target_brk);
+        }
+        bsd_target_brk = new_brk;
+        DEBUGF_BRK(TARGET_ABI_FMT_lx " (new_brk <= brk_page)\n",
+                   bsd_target_brk);
+        return bsd_target_brk;
+    }
+
+    /*
+     * We need to allocate more memory after the brk... Note that we don't use
+     * MAP_FIXED because that will map over the top of any existing mapping
+     * (like the one with the host libc or qemu itself); instead we treat
+     * "mapped but at wrong address" as a failure and unmap again.
+     */
+    new_alloc_size = HOST_PAGE_ALIGN(new_brk - brk_page);
+    mapped_addr = get_errno(target_mmap(brk_page, new_alloc_size,
+                                        PROT_READ | PROT_WRITE,
+                                        MAP_ANON | MAP_PRIVATE, -1, 0));
+
+    if (mapped_addr == brk_page) {
+        /*
+         * Heap contents are initialized to zero, as for anonymous mapped pages.
+         * Technically the new pages are already initialized to zero since they
+         * *are* anonymous mapped pages, however we have to take care with the
+         * contents that come from the remaining part of the previous page: it
+         * may contains garbage data due to a previous heap usage (grown then
+         * shrunken).
+         */
+        memset(g2h_untagged(bsd_target_brk), 0, brk_page - bsd_target_brk);
+
+        bsd_target_brk = new_brk;
+        brk_page = HOST_PAGE_ALIGN(bsd_target_brk);
+        DEBUGF_BRK(TARGET_ABI_FMT_lx " (mapped_addr == brk_page)\n",
+            bsd_target_brk);
+        return bsd_target_brk;
+    } else if (mapped_addr != -1) {
+        /*
+         * Mapped but at wrong address, meaning there wasn't actually enough
+         * space for this brk.
+         */
+        target_munmap(mapped_addr, new_alloc_size);
+        mapped_addr = -1;
+        DEBUGF_BRK(TARGET_ABI_FMT_lx " (mapped_addr != -1)\n", bsd_target_brk);
+    } else {
+        DEBUGF_BRK(TARGET_ABI_FMT_lx " (otherwise)\n", bsd_target_brk);
+    }
+
+    /* For everything else, return the previous break. */
+    return bsd_target_brk;
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 1db0907504..1b9dca9164 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -543,6 +543,13 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 #endif
 
+        /*
+         * Misc
+         */
+    case TARGET_FREEBSD_NR_break:
+        ret = do_obreak(arg1);
+        break;
+
         /*
          * sys{ctl, arch, call}
          */
-- 
2.40.0


