Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 378777ADF17
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:37:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqKp-0001YV-4n; Mon, 25 Sep 2023 14:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqKK-0000QM-R9
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:29:00 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqKJ-0007qr-05
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:29:00 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4053d53a1bfso59037625e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666535; x=1696271335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Im10dMwtttdz40+pDpdw7Pjq0vbvB2AOAUIvjrDwia8=;
 b=T7z+xWJIdI2f9hIPn09oBNwsbvxhfevHL3HPvE4kDubzoNDHJcDnokCYa/sVLZMbSC
 LndbxBC3d9qzBSXMmUjfGI4CH637a/CWyrT6LxASVlndrk2JMG1EI4FVqsJHyKANlkAB
 NSIMNGmyDqiIzSF8ZRHglkEW1VCxkS2wcErMDtrMMQQa00WxaZTUfYREa0C29aDHVZNA
 T6gpGnhhBu5e8pTlbO4ZVjpCNbbey5YPC6fBMN18i/5rPkTbukOBx/iiaD8S7jU11Vgf
 NOYWazW2HLRz4uBGU+6UY5z6WAx5L8q4kLOqgoflYKs4rr90MfNVbufiEnOQ73EfrkEH
 7bJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666535; x=1696271335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Im10dMwtttdz40+pDpdw7Pjq0vbvB2AOAUIvjrDwia8=;
 b=koHFD5SH1FqNaB/cDXz9wptaqQ09hxvyosj1rImBm3krkqXcTodzK9U+cwII87BrXf
 TIUwMM9BEoI4GDYWx/NealUiQM9Axbt/65xQinbWzOSzL69A/uowXl4YV1WJrSoMVmbt
 NQq0yEFnU+1o5Dgm1H+O3lU2+mtr3QD/kGkNoODAROGYQb+IaSZFb9gYSlk42+ywzJEc
 y6ecByli0x8evEduWuCKdwlXuYNAtf41SDO/LNZWFpblPc02l2EkKQYW9bHyKtZIfmEC
 B5QAdqaUrJwlDsR1gJbdXGrYXOcffDSvPM/w2fhPRVe0pu46LPBzJkGdrbm9fvhr4mxb
 laNw==
X-Gm-Message-State: AOJu0Yyqi9azw9egILklr3AMqwcyrAhaMvXQ8AISAJc9wn971qzuEzmD
 j0kgFiCColeyoPf4FXTZUpv/ix/qjbE=
X-Google-Smtp-Source: AGHT+IF0OYcydPY5dh98yTLRqzN0PFy4QXamAH5yPaU0F4+NHoTixeRVCYfvxqnISat5jLLjTA4zKQ==
X-Received: by 2002:a05:6000:1c7:b0:320:261:b87f with SMTP id
 t7-20020a05600001c700b003200261b87fmr7498392wrx.62.1695666535166; 
 Mon, 25 Sep 2023 11:28:55 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 u21-20020adfa195000000b00323293bd023sm3412320wru.6.2023.09.25.11.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:28:54 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v6 18/23] bsd-user: Implement do_obreak function
Date: Mon, 25 Sep 2023 21:27:04 +0300
Message-ID: <20230925182709.4834-19-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
References: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32a.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/bsd-mem.h            | 45 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  7 ++++++
 2 files changed, 52 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 0c8d96d9a4..b296c5c6f0 100644
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
index 8ba5fcc6ca..5cd60fc272 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -651,6 +651,13 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
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


