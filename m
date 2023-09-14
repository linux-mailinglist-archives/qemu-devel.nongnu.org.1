Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 774A87A0EB6
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:05:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsa9-0003ds-Gx; Thu, 14 Sep 2023 16:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsa6-0003Y2-CH
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:54 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZo-0001b3-FJ
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:54 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-404571cbb8dso11883165e9.3
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694721870; x=1695326670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AKVBP+OG1Owyy2sbH7+ilAAxCrqYViuNbwrbBHphySc=;
 b=Q8IKBR9fdIjpHNr/xbyjadjJG+GReuyZayEqgVFfG8/kqRUownZxzUfFKaosZUoLnb
 HMyVEMSJp9N5VCn1liEItn55tha+9ERV52RSExXcettJw+O/Jl+VMf0ZLjEYPhFhEVvp
 MBeqJi8xFfUT6wnvCilkFPpAOwdETFlawpDuFlgX2+SiYQ8EwWHw6f9oRVs9WDRGnycj
 FxMcciMpHNRVWBOZyDCcemXrqUC54V56oonehxIcFWr2pRlHv9H5oe8rDyves4Xk+g36
 ouhaFI9EiMxKiIQIJJXFHE0klGfwt1aG22//rbdSGnrJoxqVZ/gPds4Q9793gO18zNur
 oESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694721870; x=1695326670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AKVBP+OG1Owyy2sbH7+ilAAxCrqYViuNbwrbBHphySc=;
 b=bWjjyQxGqM6VTeq3hPSwHyV8EK0xRoYcWAnOgPA2HOSPTopNUzpvWO+x2JsJANBHJB
 TOlOLBk6gRrrGngs4irVb3JxmLNRtduBovM5vNKQNFJlx5E3SWEX7caDLAWPjU6LQxCo
 i4zNmlOf3uDIgPLnGSv1Omli48ETm2aiNBlPE1nNtwyLBKgUuMjDQZbns08a0LFkN//k
 uo9GWzNsm1O01+DQWKCgI/hWNKcvMw1TUODwUd1t6otM2V0XXCFFUwHgqMXMUVCuxhV1
 Lth2pq2UCgli4lgIHPyfRMDL0kVWmrpCsXuXmecnvwa5tAH9n/FE5npqOstzu37tolOh
 GrXg==
X-Gm-Message-State: AOJu0YyzfwAMlO20xGlbnhKbgZSJ0BixsK1L4++Kvy3wNqC5ySjJI1p7
 zOzbTe6peSzFfyXprxuVKU5MnsOBZ9U=
X-Google-Smtp-Source: AGHT+IEnQhSLjAUCwgrFJC9lsQc5nX5CtDbySG8kEk8ZNuN6CCRsVTzK0K/AXhbp/SZzg6gnvnhvuA==
X-Received: by 2002:a05:600c:209:b0:401:bd2e:49f7 with SMTP id
 9-20020a05600c020900b00401bd2e49f7mr5879050wmi.21.1694721869970; 
 Thu, 14 Sep 2023 13:04:29 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a7bc7c7000000b00402bda974ddsm2851130wmk.6.2023.09.14.13.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:04:29 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 18/23] bsd-user: Implement do_obreak function
Date: Thu, 14 Sep 2023 23:02:37 +0300
Message-ID: <20230914200242.20148-19-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
References: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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


