Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C91B57A0EC2
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:09:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsa6-0003XB-PF; Thu, 14 Sep 2023 16:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsa2-0003NT-68
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:50 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZo-0001ai-Fx
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:41 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3ff1c397405so15051125e9.3
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694721869; x=1695326669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ojwrDVKC7PwdcQ9eMVgezK92ZGwh+WReTfLF0rL9te8=;
 b=B3Dw5ymWgw6zvdj91zUbPfUCzMZfmE0ygnJJN2RciStB08W5mmyVHMOoLQHI6F7dsR
 FO53mk1qwloM9FC3jTU+w9rQS7NAG4IKbOQGAE7Jkx/7bOvc7jmgw+dyqqScIxqqyT5l
 359gVtSH+feBVGTj68JUug8BwS206Y8Zj4RXvKTWgfzGYHzkQ5+ljpfNheghYZymds/g
 IKzVSI9eNXtzH6VFqOA0FMuxPLDlmx7FEiq5jK3oEscWRew77HmHYfT9O8EjuKH7/06B
 aHA4mqbhdhPzPG0+BSjhzpK6FXB7afIcnble82Ms6CHZd4NsPnH/7Wmn0+A7qEtaEffb
 Ksbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694721869; x=1695326669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ojwrDVKC7PwdcQ9eMVgezK92ZGwh+WReTfLF0rL9te8=;
 b=BBscdNCyT4TY6yIbFIzJHkiixiCBCJ6CUdsiXiDZuKZYyEYc+K8SSEQLhRwg9BfRhU
 yz2DBfo20GBhrhvcQvgVm/KRz6j/07Ry1jbbWHRbLeN+iGFKwfTBAycPbONC1UVYJ2D9
 bOWyyV5Wlu3T8jRe+N1NRDnT5kj+tp2Ku/RqtBoa8MsbH+CQfLnT27LtWbHh6Vx2LigF
 zZ8mJeWNIECwJJ+cJ09c+AkSC23opNoYhM9sbdPZNvNwZ9M8d7IoRDiR5E3VkVZVhw0O
 ZBhNzywdn6w4T5U+6Yih7oBwj6giCTR12yMVlqLRfBu57zrhsLsCUaWZ+/LYfG8Uj+7E
 zJHA==
X-Gm-Message-State: AOJu0YxO2MkOv7UR75TKCOVym4PGsTRoQc+508mbJtNK4lBG87ZiG/XX
 t5zXYcFXmRp7o96PtHUfxEAJ7vA1tng=
X-Google-Smtp-Source: AGHT+IEzvjU/Uf2xyp4+TuNHqfKIdBYsVZv6NlJswxE/p8Pho53hdbVYh+PNjhrmP8AMtLHGaQpCWQ==
X-Received: by 2002:a05:600c:1d1f:b0:404:6ed9:98d1 with SMTP id
 l31-20020a05600c1d1f00b004046ed998d1mr2415831wms.41.1694721868740; 
 Thu, 14 Sep 2023 13:04:28 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a7bc7c7000000b00402bda974ddsm2851130wmk.6.2023.09.14.13.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:04:28 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 17/23] bsd-user: Implement mincore(2)
Date: Thu, 14 Sep 2023 23:02:36 +0300
Message-ID: <20230914200242.20148-18-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
References: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x331.google.com
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


