Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA9B78B651
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 19:22:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qafw9-0005mY-Dx; Mon, 28 Aug 2023 13:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qafw6-0005X7-1d
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:21:58 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qafw3-0006gC-Rx
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:21:57 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3a7781225b4so2461787b6e.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 10:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1693243194; x=1693847994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SDbikvrJURYSUdco/ZqIPH9U7npc2uzsUXfdoZeozoM=;
 b=tOH4pBedfmXEJT5OyigJ+EHs5qTn5ziTuzRApkATx+0RGvJEsX22glkJs3v5ybaLWr
 4fUpa1dg9D1OUujKoT/3O5qURHSgyGsapMigosABSDNLyPZ2AX61gmnhuRQpgttQV2kj
 7DeGUBGJwmhn8yqwp3eccTmoUwIVBl9w49urDHNmkPDb8rEglBFvv0IGDEmtxzhRy1Jn
 rlpTIV1oZt0b9BlA0qU917L10qJPJlw47DTzg9HMNQYTQCKObuaPWOuhbydBQ3u2tP4o
 39LEgTXbqFDUxdYUltSeZrQWaPmMqOTdIZ5w1zOh8ZF8n8co0WKo9NCPSFgQLKJGCFEo
 AqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693243194; x=1693847994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SDbikvrJURYSUdco/ZqIPH9U7npc2uzsUXfdoZeozoM=;
 b=Ns+fCAc+aDsnXeMpm0NMQ7nLvOL8VcR6KthHLloFPK7S4mzTosKNLr+kEPoePHb6dg
 Q91W/7zWPvpjq5OlltkUJcCR9T2a2SKOdfHgXdlFO2hut4f8xXQ0zjbuFaB5lTSVVYzB
 0pq+3zmcHpZ8jjN3GRadqtT1nVutrdfJlScEO/Cs7LIFVNBqhV6wESKdgqzjQzuvgAtA
 UMit3WYBFnuhLLM/dgGp60MSMGGqzYhr4DvkfqhUjEhMaLEjDugd+LnY0XC6UwUfP+ZA
 N4WnAAU2EUNUtwcdcPz/FbkPo6i5bH4q972NXe+odpmIXYkLCpOEXJJe2UmodyWNzXUE
 BKdQ==
X-Gm-Message-State: AOJu0YwSIB59mKScdqcrUnNbklZxfjhBjBMik1NubWCNm9IXOmMqo8wx
 s8yBjaM6IqogB7O/1qHO4ShFUAJPIbHu0vV3o7pP90n8
X-Google-Smtp-Source: AGHT+IG3Vou5fcQ3Zy0QHLCi5UPhiZhmb4gCvGA81YteOoKVO/CzQhEHcO7grfXCel0dIYsZiWlnlw==
X-Received: by 2002:a05:6808:138c:b0:3a7:1cca:f99f with SMTP id
 c12-20020a056808138c00b003a71ccaf99fmr14948630oiw.34.1693243194692; 
 Mon, 28 Aug 2023 10:19:54 -0700 (PDT)
Received: from localhost.localdomain ([118.114.61.244])
 by smtp.gmail.com with ESMTPSA id
 d23-20020a637357000000b0055c558ac4edsm7697985pgn.46.2023.08.28.10.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 10:19:54 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Andrei Gudkov <gudkov.andrei@huawei.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: [PULL 3/3] migration/dirtyrate: Fix precision losses and g_usleep
 overshoot
Date: Tue, 29 Aug 2023 01:19:22 +0800
Message-Id: <e424d9f7e749c84de4a6ce532981271db1c14b23.1693241678.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1693241678.git.yong.huang@smartx.com>
References: <cover.1693241678.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::22c;
 envelope-from=yong.huang@smartx.com; helo=mail-oi1-x22c.google.com
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

From: Andrei Gudkov <gudkov.andrei@huawei.com>

Signed-off-by: Andrei Gudkov <gudkov.andrei@huawei.com>
Reviewed-by: Hyman Huang <yong.huang@smartx.com>
Message-Id: <8ddb0d40d143f77aab8f602bd494e01e5fa01614.1691161009.git.gudkov.andrei@huawei.com>
Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 migration/dirtyrate.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 84f1b0fb20..bccb3515e3 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -57,6 +57,8 @@ static int64_t dirty_stat_wait(int64_t msec, int64_t initial_time)
         msec = current_time - initial_time;
     } else {
         g_usleep((msec + initial_time - current_time) * 1000);
+        /* g_usleep may overshoot */
+        msec = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - initial_time;
     }
 
     return msec;
@@ -77,9 +79,13 @@ static int64_t do_calculate_dirtyrate(DirtyPageRecord dirty_pages,
 {
     uint64_t increased_dirty_pages =
         dirty_pages.end_pages - dirty_pages.start_pages;
-    uint64_t memory_size_MiB = qemu_target_pages_to_MiB(increased_dirty_pages);
 
-    return memory_size_MiB * 1000 / calc_time_ms;
+    /*
+     * multiply by 1000ms/s _before_ converting down to megabytes
+     * to avoid losing precision
+     */
+    return qemu_target_pages_to_MiB(increased_dirty_pages * 1000) /
+        calc_time_ms;
 }
 
 void global_dirty_log_change(unsigned int flag, bool start)
-- 
2.39.1


