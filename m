Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D8678B68F
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 19:36:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qag9A-0003QW-KG; Mon, 28 Aug 2023 13:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qag98-0003QM-Cg
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:35:26 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qag96-0001ST-5Z
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:35:26 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bf3a2f4528so27243975ad.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 10:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1693244003; x=1693848803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SDbikvrJURYSUdco/ZqIPH9U7npc2uzsUXfdoZeozoM=;
 b=koIGeV20tEs7Y9Vc08lbJ705ATfotFH5KtkUMj4eoQRe4hdkgwoKqbRuxN9dzGa1RG
 A79n7cceWDbYuwHoeGO/dxxJgFAw3zWeqwXEjEbBBiOfvCs8LcDqOa2xm0GBDF1BbcnD
 nO8eBB5WnhCUB/C4I3NwBTxcaE39s4qZQPujr9uZlLnnFNPKdTAO3adnpe7eNrdBr/VT
 0WNq3bP5YvEgRX16bQYt+78SfQnxqaHJuWdIo9HeE0/eGqF/C8GOU0/uiHXoji22OpLo
 lScwqmgV2Ifmq4PI+mOascjpnVCa9t7ck+mQYX/E3GHExF80TLuFhbzel80xwxWzTqJD
 iJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693244003; x=1693848803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SDbikvrJURYSUdco/ZqIPH9U7npc2uzsUXfdoZeozoM=;
 b=HigglD7GMsrnrsGPr3ZXQpRZk1w6h7fpYVzIe5qaAZbykZ9uOOzu6+keuaXgNLi5Q7
 VWmplAvMV7ci2MbFSA3GIx3oQt+nlxCuK0hmwNPtY88qHeZT/ejURdWsNTH48JdIsw7d
 ztSWknC7UA9Fo86oVWla/zg+sBG6bbPhwaT+lcnAk6FHRkHCAIjWeJLuJCnIOF29KqwG
 7FO2IZDL9AkfP0esfWd4lvFb6n7GhZKyD5W0ZsZM4XlDs5k/1nR4pwwONp72ItAZkMUp
 pg2949dp+hRjhzMwizIgrqRbaKL4Ere7PwgcBxW8xTrpQcq4JTZii5mD+X7x0suXE4tO
 EDJA==
X-Gm-Message-State: AOJu0Yz6sRGQ1O2iw67p96kSapgX+cCYuIxIQMYFXXJ5Cx7AJ9HFCiu4
 SmB3tgfKA9T3JgBegihkXttPZ+WZ/RZCPfGRm5YOyyn9
X-Google-Smtp-Source: AGHT+IGbtYj5W+rOtKyAd44fCEH8CQmRjbAe8EvvCh2BCaT0A6wnmnpPf2RYOMZkkBdAbKtiqDY9UQ==
X-Received: by 2002:a17:902:9b94:b0:1bc:16cf:fc30 with SMTP id
 y20-20020a1709029b9400b001bc16cffc30mr25256345plp.63.1693244002676; 
 Mon, 28 Aug 2023 10:33:22 -0700 (PDT)
Received: from localhost.localdomain ([118.114.61.244])
 by smtp.gmail.com with ESMTPSA id
 je1-20020a170903264100b001b80d411e5bsm7669103plb.253.2023.08.28.10.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 10:33:22 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Andrei Gudkov <gudkov.andrei@huawei.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: [PULL 3/3] migration/dirtyrate: Fix precision losses and g_usleep
 overshoot
Date: Tue, 29 Aug 2023 01:32:52 +0800
Message-Id: <e424d9f7e749c84de4a6ce532981271db1c14b23.1693241678.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1693241678.git.yong.huang@smartx.com>
References: <cover.1693241678.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62f.google.com
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


