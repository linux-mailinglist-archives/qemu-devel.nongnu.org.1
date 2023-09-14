Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 213237A0EC6
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:09:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsa8-0003cS-Er; Thu, 14 Sep 2023 16:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsa2-0003NW-8U
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:50 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZo-0001aQ-ET
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:39 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-401b5516104so14639535e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694721867; x=1695326667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jCqdSZt4JHZhZf+YE8oxI5TH33W7XtN+wtVE9f1Vv5E=;
 b=BfAnnPTw5g7nCxIL0PYATur84DIZAfqcvFT/gYHF/rhfA0PevhCBWpkOlQvOTUnJ1m
 WixBYx4QEvMXReGSerCWrBaTNLSh0RQGRC9+0a1Q329vd4Z+lLMCRtGVZNTlJb4c8+3b
 cIvygUIbLD48iar94KtvV7nffEgjBO8vY3FClwMWxwHWFxDzVy3/EqVu+xdqQTM6EGrc
 hBDBFVXKrUG6vUd55Ho2rO15MwnJBUypYS11wNx8PCBuMkMGJFR1ysGlQyvkSb3TB4iW
 BUKee38gBqQUVdxD6XwkqMltuKT4EE9krPoeE8s/Xh2zENAz7ErToMB73oXWjHMojhho
 EFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694721867; x=1695326667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jCqdSZt4JHZhZf+YE8oxI5TH33W7XtN+wtVE9f1Vv5E=;
 b=icDmx7YdZWwKFs3t0S7N00iod+F/VEC80pCaI8bhEIprna72mRNXPhUZMm1tHqw2GF
 C3JmpINdxLOEwU6ciGEZPZHO91lIbt4Ay46oxEkpxbb8W2um9oiCFjlsKmn5br52q1PQ
 wSKkvGS3jdmM3gsqa386Sv0kAf2YaYjZVJa4dr/P2EDWqhsDSR8Yrr8Xx0adcExlF1WG
 JrhFUrC7kw71zbhLp9H9Yhzy9Np0wQUUNxrhyLN6tlojK2xReq2hh+KnRnIYHHWqoDCc
 j4m5jZm0Y41PRJK1rwmm4IR3kwEZIoXNj+5Hukk1W2fp8fiGk+cYfDaJpm0uwBz+5hzo
 cPlA==
X-Gm-Message-State: AOJu0Yxf1VY1HRM0Lc75TsmvxFMzr2uJYdyJkj2JzJLQE8vG98cyh7TY
 G/oWFRN1+6lOgqdGNIcoFReNJ29Q08g=
X-Google-Smtp-Source: AGHT+IFtJ4l0FZHeGVpOp+mLBaazUPGCANnOqIQL2lPS684/TpvEVRuvw4MpNfEJZ7iaP3ZwPioJpg==
X-Received: by 2002:a05:600c:5108:b0:404:746e:c601 with SMTP id
 o8-20020a05600c510800b00404746ec601mr1815733wms.9.1694721867025; 
 Thu, 14 Sep 2023 13:04:27 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a7bc7c7000000b00402bda974ddsm2851130wmk.6.2023.09.14.13.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:04:26 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 16/23] bsd-user: Implment madvise(2) to match the
 linux-user implementation.
Date: Thu, 14 Sep 2023 23:02:35 +0300
Message-ID: <20230914200242.20148-17-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
References: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x329.google.com
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

Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/bsd-mem.h            | 53 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 +++
 bsd-user/syscall_defs.h       |  2 ++
 3 files changed, 59 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 16c22593bf..b00ab3aed8 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -129,6 +129,59 @@ static inline abi_long do_bsd_munlockall(void)
     return get_errno(munlockall());
 }
 
+/* madvise(2) */
+static inline abi_long do_bsd_madvise(abi_long arg1, abi_long arg2,
+        abi_long arg3)
+{
+    abi_ulong len;
+    int ret = 0;
+    abi_long start = arg1;
+    abi_long len_in = arg2;
+    abi_long advice = arg3;
+
+    if (start & ~TARGET_PAGE_MASK) {
+        return -TARGET_EINVAL;
+    }
+    if (len_in == 0) {
+        return 0;
+    }
+    len = TARGET_PAGE_ALIGN(len_in);
+    if (len == 0 || !guest_range_valid_untagged(start, len)) {
+        return -TARGET_EINVAL;
+    }
+
+    /*
+     * Most advice values are hints, so ignoring and returning success is ok.
+     *
+     * However, some advice values such as MADV_DONTNEED, are not hints and
+     * need to be emulated.
+     *
+     * A straight passthrough for those may not be safe because qemu sometimes
+     * turns private file-backed mappings into anonymous mappings.
+     * If all guest pages have PAGE_PASSTHROUGH set, mappings have the
+     * same semantics for the host as for the guest.
+     *
+     * MADV_DONTNEED is passed through, if possible.
+     * If passthrough isn't possible, we nevertheless (wrongly!) return
+     * success, which is broken but some userspace programs fail to work
+     * otherwise. Completely implementing such emulation is quite complicated
+     * though.
+     */
+    mmap_lock();
+    switch (advice) {
+    case MADV_DONTNEED:
+        if (page_check_range(start, len, PAGE_PASSTHROUGH)) {
+            ret = get_errno(madvise(g2h_untagged(start), len, advice));
+            if (ret == 0) {
+                page_reset_target_data(start, start + len - 1);
+            }
+        }
+    }
+    mmap_unlock();
+
+    return ret;
+}
+
 /* minherit(2) */
 static inline abi_long do_bsd_minherit(abi_long addr, abi_long len,
         abi_long inherit)
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 6eaa705cd3..f5d60cf902 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -519,6 +519,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_munlockall();
         break;
 
+    case TARGET_FREEBSD_NR_madvise: /* madvise(2) */
+        ret = do_bsd_madvise(arg1, arg2, arg3);
+        break;
+
     case TARGET_FREEBSD_NR_minherit: /* minherit(2) */
         ret = do_bsd_minherit(arg1, arg2, arg3);
         break;
diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 074df7bdd6..76f4856009 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -95,6 +95,8 @@ struct bsd_shm_regions {
 /*
  *  sys/mman.h
  */
+#define TARGET_MADV_DONTNEED            4       /* dont need these pages */
+
 #define TARGET_FREEBSD_MAP_RESERVED0080 0x0080  /* previously misimplemented */
                                                 /* MAP_INHERIT */
 #define TARGET_FREEBSD_MAP_RESERVED0100 0x0100  /* previously unimplemented */
-- 
2.42.0


