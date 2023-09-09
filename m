Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B40EC799A9E
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 21:40:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf3nD-00062J-5A; Sat, 09 Sep 2023 15:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3nA-00061W-Gj
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:52 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3n8-0003G9-B4
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:52 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40078c4855fso33588685e9.3
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 12:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694288329; x=1694893129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7gLIXJm83In4ehfDWmTTDmbWjCCrqaLS41dVOxq/Wi8=;
 b=bOffLRA2AcuQRX7+uyYVBL214IosooTYQKu0Ak1+Gv7WJvKj2PDvsdfa6DdOHZGUXc
 bVBlkGisRigBLHMwSpT35cZqmpaok0GXkPgE80qnUxN75z+ZBRMR5SBQEWJ/N6j6Tu+Y
 cA36vgZ5Rp0CVUBxw6fSaPVw7I6xJWNtzLRZiZlgd/nopoTqTSTnrcAInWSAmcYjkJqR
 0WzyCqu2/7mNi8V/kT1g6WPA6ZAQXExD1gKLmntyJxPn1AWPexHNpAO2TQT4RzNb4yeN
 7Z/c/gVgsKV53vUJwYm7f0Zr2b688pjMFu5OIob74Xebias/AnP9FzgbKcnlArbPCsyu
 oXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694288329; x=1694893129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7gLIXJm83In4ehfDWmTTDmbWjCCrqaLS41dVOxq/Wi8=;
 b=soSoWuAK5SwFP6lluffGNaib5Y3XMrTEgWtOnPCuJcQ1FT9KOK1MCRviQaUCOWHvxm
 mJ9reGNfwb6Im5WNTRetq430qpGYFDPeSUKR/AbcZsuIbKji8Q8l1vv1NT4caGUtqrJ9
 0pz1YZ5FsnolvjUIZRAKC5QLQWlv7w0mYgtM3yvH8dVnzTZ6QBAsvzcYXsKUZVU7WUHQ
 I9+O+0cT38umBhqIOvd9/zPvAAlW0H0uRCsPaJADFyIYfGn2jdNk3hebn/VYwUCTP48z
 onTar5W3c7eWWvurGw81lKWRJzQQ7pQn359kDemKTA3bEGnhC9TINvNgSwStIwjXbI31
 JFzQ==
X-Gm-Message-State: AOJu0Ywv4su8UPcNZmq2oTrZhu7Hhg1EZHT9PwVJxvgbJrg9f5xpuyfZ
 IPVHFb2nEzOoC4QvZaUatnLsUp80o4g=
X-Google-Smtp-Source: AGHT+IHI0dHEOkX5RZbBd8kZ3Wvp2KyvtDwUtSANUYIGGb8fDZ8ddZaCVj5bZKjev7+IJswhLTi3RQ==
X-Received: by 2002:a05:600c:5102:b0:402:f536:2d3e with SMTP id
 o2-20020a05600c510200b00402f5362d3emr5069595wms.14.1694288328665; 
 Sat, 09 Sep 2023 12:38:48 -0700 (PDT)
Received: from karim.my.domain ([197.39.250.27])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c260d00b003fe4ca8decdsm8612812wma.31.2023.09.09.12.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 12:38:48 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 20/23] bsd-user: Implement shm_unlink(2) and shmget(2)
Date: Sat,  9 Sep 2023 22:37:01 +0300
Message-ID: <20230909193704.1827-21-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x334.google.com
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

Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/bsd-mem.h            | 23 +++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++++++
 2 files changed, 31 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index a48f919ff2..27d4e7f079 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -281,4 +281,27 @@ static inline abi_long do_bsd_shm_open(abi_ulong arg1, abi_long arg2,
     return ret;
 }
 
+/* shm_unlink(2) */
+static inline abi_long do_bsd_shm_unlink(abi_ulong arg1)
+{
+    int ret;
+    void *p;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(shm_unlink(p)); /* XXX path(p)? */
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* shmget(2) */
+static inline abi_long do_bsd_shmget(abi_long arg1, abi_ulong arg2,
+        abi_long arg3)
+{
+    return get_errno(shmget(arg1, arg2, arg3));
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 7404b0aa72..52cca2300f 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -547,6 +547,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 #endif
 
+    case TARGET_FREEBSD_NR_shm_unlink: /* shm_unlink(2) */
+        ret = do_bsd_shm_unlink(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_shmget: /* shmget(2) */
+        ret = do_bsd_shmget(arg1, arg2, arg3);
+        break;
+
         /*
          * Misc
          */
-- 
2.42.0


