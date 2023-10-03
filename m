Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 088A67B7569
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:44:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovs-0004X1-OF; Tue, 03 Oct 2023 19:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovk-0004M7-ML
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:57 -0400
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnove-0007TE-AV
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:55 -0400
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-79f9acc857cso54765439f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376149; x=1696980949;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ghXvw1CEOFvx+EvpSHrnuN4yclzjxnuEasAI7tTRTeg=;
 b=dRe8swVltzr+HHlLGyuEfxzrHxNxOTb6hIj1KDSitQoFM2ZxeWd/vV1a0CHPHhnjSZ
 xo+CQ+nwj8gvYM5/DQpEW+WUTr5yGr8HjoiroFlq9SMSpoM43jpjszBaiuiL8CQxxipu
 Kee5pHAY0Uq8gFtY0314H8Ba+mSePAqvij/HFV/HY+cqkHhUUsexpeQqcz+rjnHx6lzD
 6Z/EQ9/XkqXf2derIglgEoNjcifclV85uYAEg7XbsF8BmgxkevVyG/DA4RKqelfwvmyt
 0lBrbsBH70uRoTCtIv6R1oHzFW4BLWGuPg08JgYxx+okMmqvbl71bpOZc3m7PBJZGQC9
 P/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376149; x=1696980949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ghXvw1CEOFvx+EvpSHrnuN4yclzjxnuEasAI7tTRTeg=;
 b=EUTQWjmnSyYiPgAEVt+yLdN3w/xs0qSoVP3D7tVnpg12CjuVy68e5+umeRz1lE7GlL
 J9gc8fAVZYBTNwXJDdmxeUgxrlMFcePobMgO+7S88I2RAfUP4n5HdzeyLTgI7iZaYkZl
 LCq4SNOdENTIINDoHAxYTLdsq7EHIE3RBfwNp6r+eKjBoNXAJuZCpbQmEUYogYh/izoO
 HoNX8DS+RzPrBRUfc4oBicIyLYqPFArAB0a6mRoStzTCNgRarb4z03pWtKoEksVAHonO
 3rvOvY7gdLjqAwADRSXY9UYlr1yBZOULGG04wViw3vFTK9LcJjA9NRjFT4xqSQ/y3N03
 poew==
X-Gm-Message-State: AOJu0Yx2sqDeLFVlAr1Sb2TJ4yclSnLeKT4zQcR793SdrDWjsdKtr9iB
 Dh3Jpn7wtPioxbPGK/Shv/CMHxbGcDHnk+f52/STVg==
X-Google-Smtp-Source: AGHT+IF+6wKP+V3wIDGh99xCOo70Dp3HH0MoioiFo/BjpX83WufD5quPu81pZ855r0Y+KzcH7kGOTQ==
X-Received: by 2002:a6b:c413:0:b0:79f:99f5:fadd with SMTP id
 y19-20020a6bc413000000b0079f99f5faddmr868530ioa.6.1696376149011; 
 Tue, 03 Oct 2023 16:35:49 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:48 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 46/51] bsd-user: Implement do_obreak function
Date: Tue,  3 Oct 2023 17:32:10 -0600
Message-ID: <20231003233215.95557-47-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2a;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230925182709.4834-19-kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.h            | 45 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  7 ++++++
 2 files changed, 52 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 0c8d96d9a43..b296c5c6f0a 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -212,4 +212,49 @@ static inline abi_long do_bsd_mincore(abi_ulong target_addr, abi_ulong len,
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
+        return target_brk;
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
index f054241cd62..92793ab1fb3 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -855,6 +855,13 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
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
2.41.0


