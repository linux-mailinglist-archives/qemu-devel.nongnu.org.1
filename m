Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5847DE1E0
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 15:07:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyBrg-0006TW-VB; Wed, 01 Nov 2023 10:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qyBre-0006Sp-BD
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 10:06:34 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qyBrc-0004n0-E5
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 10:06:33 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1cbf47fa563so55054585ad.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 07:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1698847470; x=1699452270;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gZP4vNAsT35dRdMludcCQFY3Ho41hZp6SlZrV2FLesw=;
 b=1B0lnbDf5/7NzMgDK1Rq+wgQLI8FZUOJsrBdz2QMx/OqcM3+a6ySK9FoV8y2iC887X
 LXmggUJGx8LelUTXKjU4+Y1Kgc/TwFRfJsqFi+obWQWT7HhmNrsqi+L40uZ/s7MMR5AK
 dokWuu5micqy5h5cOlhqoU3ZTPBKekAGA2ZuZokk6KRQTF0hnY3bnrfT5QMO6zhJI2LC
 9pIMZL7BsHu9am04M2Hu6Bp6bXbHC3CVilzHX6hWM/SE2UVsKVo84/elGnRNO50PLz59
 KrzMKdyCv7U0P/lzFIIoVC5LOlYABxfj3veR48EHZYQVNSdAtbSHo9Bos34hNMd+b7EF
 ydMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698847470; x=1699452270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gZP4vNAsT35dRdMludcCQFY3Ho41hZp6SlZrV2FLesw=;
 b=pmAzgLwF2mlVfUlj3ztVDuXCupQgEV9viI8l/UVFXGgeS/zqIPnR1jdMeqty0hkUfj
 tmdl54U0SiMX3oHulrYgwCnOJaQAoFJ7O5v8EKBQLjEDznvX25o7DO9Hv+8UuoKIBvYc
 iUNuY0DYYSljX1iyfZe3k+ZP/n+y06o4RmYIca9XF4Cd60KJCJjA8VOlhU4Xp+Q0Tz/R
 kvdniHBwQx9JyYTo81VE7jLzRi515A6t3XCjanLdo7psJgHjZUTR25bUXE7NAuOPksHD
 WpIVQ0DQygsG+rAv+s+N8Heq00auCXJpYBhJnpfpQeHRb0a1vu+jqFufO0efPYD2bGbu
 7tZg==
X-Gm-Message-State: AOJu0YxkpmUhw6eHpbb9wzkxySiVjgWEtQZUdZU3SWkR6vZouJaRrTcm
 5dpGHt22g0l9jJBVt+UFKjnKGBUCj0iQ7EQdRJa/4XLE
X-Google-Smtp-Source: AGHT+IGC4NfBtgr1miJPH20oVyTzbwZ3fRdAgvbISGSh1CvniaVqvecWKv9trOUoD1LjWaIBv47NsA==
X-Received: by 2002:a17:902:6803:b0:1cc:b71:c96f with SMTP id
 h3-20020a170902680300b001cc0b71c96fmr10806633plk.41.1698847469994; 
 Wed, 01 Nov 2023 07:04:29 -0700 (PDT)
Received: from localhost.localdomain ([125.71.94.114])
 by smtp.gmail.com with ESMTPSA id
 jn7-20020a170903050700b001cc32261bdcsm1396118plb.248.2023.11.01.07.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 07:04:29 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [v3 1/6] system/dirtylimit: Fix a race situation
Date: Wed,  1 Nov 2023 22:04:04 +0800
Message-Id: <27c86239e21eda03d11ce5a3d07da3c229f562e3.1698847223.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1698847223.git.yong.huang@smartx.com>
References: <cover.1698847223.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Fix a race situation for global variable dirtylimit_state.

Also, replace usleep by g_usleep to increase platform
accessibility to the sleep function.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-Id: <f25558b3d94083ce6909da5b5cfb922ae5935626.1697815117.git.yong.huang@smartx.com>
---
 system/dirtylimit.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index fa959d7743..3666c4cb7c 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -411,12 +411,20 @@ void dirtylimit_set_all(uint64_t quota,
 
 void dirtylimit_vcpu_execute(CPUState *cpu)
 {
-    if (dirtylimit_in_service() &&
-        dirtylimit_vcpu_get_state(cpu->cpu_index)->enabled &&
-        cpu->throttle_us_per_full) {
-        trace_dirtylimit_vcpu_execute(cpu->cpu_index,
-                cpu->throttle_us_per_full);
-        usleep(cpu->throttle_us_per_full);
+    if (cpu->throttle_us_per_full) {
+        dirtylimit_state_lock();
+
+        if (dirtylimit_in_service() &&
+            dirtylimit_vcpu_get_state(cpu->cpu_index)->enabled) {
+            dirtylimit_state_unlock();
+            trace_dirtylimit_vcpu_execute(cpu->cpu_index,
+                    cpu->throttle_us_per_full);
+
+            g_usleep(cpu->throttle_us_per_full);
+            return;
+        }
+
+        dirtylimit_state_unlock();
     }
 }
 
-- 
2.39.1


