Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C07773ADB
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 17:08:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTOIS-00058Y-Ee; Tue, 08 Aug 2023 11:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qTOIQ-00058L-Db
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:06:54 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qTOIO-0006HB-GH
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:06:54 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bc411e9d17so35701695ad.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 08:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691507211; x=1692112011;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tAO2I5yRvxwmrHlAsuu79qu0O+yqKkrTGO5KoB4M1sM=;
 b=ktBBzL1nEVN6F+1m/9CweQmBMtNvvE2qtOyU7qHQLJa7nNDx0bMwbE+UdP5wEWF1lw
 QzHl+h8bhb3Cz8C6EyztZSQbFuhWU0lO1vxvUwzh0RH7uJRmVMMBcmlZ9Gkwjr9V1xEd
 rdyKcKyMYTUe/FQtGFE3EuWMAwQL2qkkneHKW8QGgj9qjX4FjbVd+w7HSA/6M6fhwApr
 Uyc7isIp3iXfqm3+GfLsX7IEQUDYUfceYNyWi2udUVYgxwj+BXYmD74sh6xgL0j26g4O
 xwJ40nzDHwiab0jyWj8SOQ1wcYovNg0U7YtAPfvxJQuT1JychY2ZXbPhY6WEns/d1Pyp
 p0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691507211; x=1692112011;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tAO2I5yRvxwmrHlAsuu79qu0O+yqKkrTGO5KoB4M1sM=;
 b=AQTSDlOcRJg2WAp7cYMtrCmARlKzeYPX/QNdadIqt9y26OG+U7COFH+eU1X8aZFiCx
 6Z5/e+TErwmlJC1ohi++dvIgc1byKY7jKfmfHBbb+UjYdQPzlJK+h9eDaDxys60aWWG2
 JfM972OyZBhNS8aQawaHGoZOYFj1s8PXGjZ1sK1DU5woog3mr+RtstCt1Z2ifl9dKnGm
 UMohDqLUYS4sCNmD023CInLLnbjjENCwnw84PLS1xeD8RIwg00zKAyhhLi9EkriJg/Wi
 t1SUgH0i0rSCaYtDgnpuPzzX+Xstlcfa5J2ea9V3kG4dQGbZOF1w7mjHxr2/Ns3nEngx
 Bt8w==
X-Gm-Message-State: AOJu0YxWmOm/YT5hYN2G0+7jdw2H1aZl+OobOjJmJqjBxcmDA/m7tFdB
 7PAKNDuqDGEYEC8P5QTkzG3fwA==
X-Google-Smtp-Source: AGHT+IE+R4hgYc06jVlXta4gVMjzE4NajZJ1LPmrf3Bf1MbYHRs9e3Jh/9mEKID87kXCpwlhzDDkJA==
X-Received: by 2002:a17:902:ead1:b0:1a6:74f6:fa92 with SMTP id
 p17-20020a170902ead100b001a674f6fa92mr13649445pld.19.1691507210940; 
 Tue, 08 Aug 2023 08:06:50 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 s22-20020a170902a51600b001a80ad9c599sm9075317plq.294.2023.08.08.08.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 08:06:50 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, pbonzini@redhat.com,
 philmd@linaro.org, laurent@vivier.eu, deller@gmx.de, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH for-8.1 v2] linux-user: Define real MAP_FIXED_NOREPLACE value
Date: Wed,  9 Aug 2023 00:06:35 +0900
Message-ID: <20230808150636.91154-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
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

do_brk() assumes target_mmap() emulates MAP_FIXED_NOREPLACE even when
the host does not support it. However, such emulation is not possible
if MAP_FIXED_NOREPLACE is defined as zero.

Define MAP_FIXED_NOREPLACE with the real value instead of zero if it is
not defined.

Fixes: e69e032d1a ("linux-user: Use MAP_FIXED_NOREPLACE for do_brk()")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/qemu/osdep.h | 8 ++++++--
 linux-user/elfload.c | 1 -
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index cc61b00ba9..6c1050afcd 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -289,8 +289,12 @@ void QEMU_ERROR("code path is reachable")
 #ifndef MAP_ANONYMOUS
 #define MAP_ANONYMOUS MAP_ANON
 #endif
-#ifndef MAP_FIXED_NOREPLACE
-#define MAP_FIXED_NOREPLACE 0
+#if defined(__linux__) && !defined(MAP_FIXED_NOREPLACE)
+#if MAP_HUGETLB == 0x100000
+#define MAP_FIXED_NOREPLACE 0x200000
+#else
+#define MAP_FIXED_NOREPLACE 0x100000
+#endif
 #endif
 #ifndef MAP_NORESERVE
 #define MAP_NORESERVE 0
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
2.41.0


