Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C33D799651
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 06:38:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qepfd-00016F-Uq; Sat, 09 Sep 2023 00:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfW-00014y-1E
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:34:02 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfT-0002yD-2H
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:34:01 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31f737b8b69so2124492f8f.3
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 21:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694234036; x=1694838836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Y5YktBwcbxAJZtPbTx4kfRpV78Ai/r3dWCAljOp3c8=;
 b=D4ChmKh1Tn9+P/tWdkir9zzoJm27GQY+sO2BEFbx8kSAdrJ7XyJG1zv2jt/sl2E6uf
 s0+cFKyO20XXbFLPiqgXW5FWd4xNV3ayEyrGd+GrNLFxk2WZwcwhg5pU9/KTFhWi2ihs
 W6bfkYmn25jhx8RdxkhD2lx5G928ktpega3x0AKYmdLrbVlE+X2LhkZJyXWqX6wIeDWC
 pzwd/D0UOnWcKyrSIOdUwyDRemNxaG2BjPwoeoz4S/mlmL1WzdI9xRji944Q+uy4bXsL
 LOkTgafeo3WoYwMD5hU7eV8m0mS30FjDFFjYQPPJVBUvzz6oEhR4TlQ5/or8LXwoSgxg
 hbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694234036; x=1694838836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Y5YktBwcbxAJZtPbTx4kfRpV78Ai/r3dWCAljOp3c8=;
 b=py9RLsJpLJSeUS6M7Iv/LYXKhGApON+2BJaAYiDmOwY+CzofubHglhL150GBgOktMS
 5sdxMADrjGSQtYS9ZCjagwGBdxRdKnPk9hzy4Deb8p6r6p2q31cVquGmEEolqiK6J5cF
 +0wdSAe6cJiUjJHTwxYuNxKtLU176Us7dNyrKKyNuDbPazxOTI/frRdX+zDKxn8moGUX
 6108z79l6tc6EKzfs+mBvAH1q3/C0PF+waSBtvbzqAgifGby3Le0WDtnATUvDInZFuZR
 Iw83BLGywVK4Qy/b0b72ByBTHAZQVjX2YKqggmDMrZvVZuVaU0pQm/izaWcSbZFWlb0c
 RzHQ==
X-Gm-Message-State: AOJu0YzP/UkTB5m3v1ggZeX6ZQP5dEWse8hPxRKpblgnr8y6WLiUJwjR
 nJ1/KBap4h7gpoc83PhRUVCyhG9DsNo=
X-Google-Smtp-Source: AGHT+IFtDA16hsJcE56Io4kzevCZYBNGr8CvgBbPDKw/VQ/2tLJAlDHcLIL33D/UTbDCh5aU6YMZTA==
X-Received: by 2002:a5d:6441:0:b0:317:597b:9f92 with SMTP id
 d1-20020a5d6441000000b00317597b9f92mr3459857wrw.57.1694234035905; 
 Fri, 08 Sep 2023 21:33:55 -0700 (PDT)
Received: from karim.my.domain ([197.39.120.250])
 by smtp.gmail.com with ESMTPSA id
 d16-20020adff2d0000000b0031981c500aasm3615102wrp.25.2023.09.08.21.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 21:33:55 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 18/23] bsd-user: Implement do_obreak function
Date: Thu,  7 Sep 2023 09:42:57 +0200
Message-ID: <20230907074302.79234-19-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
References: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
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

Match linux-user, by manually applying the following commits, in order:

d28b3c90cfad1a7e211ae2bce36ecb9071086129   linux-user: Make sure initial brk(0) is page-aligned
15ad98536ad9410fb32ddf1ff09389b677643faa   linux-user: Fix qemu brk() to not zero bytes on current page
dfe49864afb06e7e452a4366051697bc4fcfc1a5   linux-user: Prohibit brk() to to shrink below initial heap address
eac78a4b0b7da4de2c0a297f4d528ca9cc6256a3   linux-user: Fix signed math overflow in brk() syscall
c6cc059eca18d9f6e4e26bb8b6d1135ddb35d81a   linux-user: Do not call get_errno() in do_brk()
e69e032d1a8ee8d754ca119009a3c2c997f8bb30   linux-user: Use MAP_FIXED_NOREPLACE for do_brk()
cb9d5d1fda0bc2312fc0c779b4ea1d7bf826f31f   linux-user: Do nothing if too small brk is specified
2aea137a425a87b930a33590177b04368fd7cc12   linux-user: Do not align brk with host page size

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.h            | 45 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  7 ++++++
 2 files changed, 52 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 1dabbe36e6..563f82996b 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -211,4 +211,49 @@ static inline abi_long do_bsd_mincore(abi_ulong target_addr, abi_ulong len,
     return ret;
 }
 
+/* do_brk() must return target values and target errnos. */
+static inline abi_long do_obreak(abi_ulong brk_val)
+{
+    abi_long mapped_addr;
+    abi_ulong new_brk;
+    abi_ulong old_brk;
+
+    /* brk pointers are always untagged */
+
+    /* do not allow to shrink below initial brk value */
+    if (brk_val < initial_target_brk) {
+         return target_brk;
+    }
+
+    new_brk = TARGET_PAGE_ALIGN(brk_val);
+    old_brk = TARGET_PAGE_ALIGN(target_brk);
+
+    /* new and old target_brk might be on the same page */
+    if (new_brk == old_brk) {
+        target_brk = brk_val;
+        return target_brk;
+    }
+
+    /* Release heap if necesary */
+    if (new_brk < old_brk) {
+        target_munmap(new_brk, old_brk - new_brk);
+
+        target_brk = brk_val;
+        return target_brk;
+    }
+
+    mapped_addr = target_mmap(old_brk, new_brk - old_brk,
+                              PROT_READ | PROT_WRITE,
+                              MAP_FIXED | MAP_EXCL | MAP_ANON | MAP_PRIVATE,
+                              -1, 0);
+
+    if (mapped_addr == old_brk) {
+        target_brk = brk_val;
+        return target_brk;
+    }
+
+    /* For everything else, return the previous break. */
+    return target_brk;
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 8d1cf3b35c..8dd29fddde 100644
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
2.42.0


