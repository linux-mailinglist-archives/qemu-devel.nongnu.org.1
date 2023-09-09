Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D428B799A98
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 21:39:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf3n9-00060M-PV; Sat, 09 Sep 2023 15:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3n8-000609-5Y
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:50 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3n5-0003FS-U3
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:49 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4018af1038cso34427605e9.0
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 12:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694288326; x=1694893126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Y5YktBwcbxAJZtPbTx4kfRpV78Ai/r3dWCAljOp3c8=;
 b=J1qNRuQvji/flvmwcqi+093mTQO7qOsJNKTCKWTiHk68OB2dx3TStglY84YH7RiDxZ
 RGdQuBbsTz43YDGupYf1KBCHJP0+MRDWznllzInvpdW//PL0M6nFUo11byo+7LX+LrQ9
 GGz7Qx1yH559lAiFgs1p5+YNvzwhQFLH6Nyxqg9SxqZfm8aunfVHpnCTPem6dP+7NOW6
 qy+OYY17rJB65h1Xy/I3us0nTD+ETPlWDNmpyMsoPwSlOqfjolSr/h+7m11zdl75zFko
 6QTP87bKZFFUimHcs5w0L5tzkhEXVsh1PV7vc5AhKuxPZpon6yCsba3jzjqhEpl5+PtV
 FBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694288326; x=1694893126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Y5YktBwcbxAJZtPbTx4kfRpV78Ai/r3dWCAljOp3c8=;
 b=iGLFp1ioolxx0Ew4/Kjlr8BjI7YHAIT/CjVAtTl2LeaEWBGquZHEy5sEzgs3nld/Zb
 ecixFUOuKLNwDZfga77XkVDIWuWyhO7L9h4fE037SyjTRcnFVieLN55YG8vyObXiwReD
 28dFjCE+ZPCZorXp4ERx9rWyAGo/PewfgkVhjjVdD8uWJXA5tlhaDjVrSglplGVth3pv
 VSvGmkmjstq4dSK6wopUvmzTZwgMUKE3i9AvBA6qI2CiIH17i2wXWmc2c5A6t8uqgV8Y
 mz45/CeVNBn4o+47ZgW9yapAkfOdbnVavBSTIkKnQ5oPj6PiuHblM3L2TJpe+143fSjV
 LiZA==
X-Gm-Message-State: AOJu0YzC/TshVfebcM+QlCXNX1/pjHNS2ZKcCgdxVULOyvlUwWBDijMl
 Gg9WlSJE8Q1z342XGY6OwTiB37Yz+t8=
X-Google-Smtp-Source: AGHT+IHJUEh6zhxJQJ3mgeW6OG7v68EYSOZi/DOZOyOuhaAkCZ25KSnNwxvbH2eD2lih5W5u/vtmfA==
X-Received: by 2002:a1c:4c0d:0:b0:402:906:1e87 with SMTP id
 z13-20020a1c4c0d000000b0040209061e87mr5287579wmf.31.1694288326280; 
 Sat, 09 Sep 2023 12:38:46 -0700 (PDT)
Received: from karim.my.domain ([197.39.250.27])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c260d00b003fe4ca8decdsm8612812wma.31.2023.09.09.12.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 12:38:46 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 18/23] bsd-user: Implement do_obreak function
Date: Sat,  9 Sep 2023 22:36:59 +0300
Message-ID: <20230909193704.1827-19-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x330.google.com
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


