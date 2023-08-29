Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B59678C8A8
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 17:33:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb0iK-00084w-N6; Tue, 29 Aug 2023 11:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qb0iI-00084h-7e
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 11:33:06 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qb0iF-0006oc-Jr
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 11:33:05 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bdc19b782aso28542705ad.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 08:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1693323062; x=1693927862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SDbikvrJURYSUdco/ZqIPH9U7npc2uzsUXfdoZeozoM=;
 b=hIcDyreBdh5KalomlxsGiS39drF7uTs5H/ThoL66/swHuLCTEyekXoquGaoZ+peerq
 JPihrwHqsrasDGFTjmnVZUxktgkIPJNYP3waM1mluj23owI6hPQKKK08U+BZXuEztiV8
 HhGtumdt7ko/wou62jbnNO1svCJrC1oEind3DJdQdNocZH+n+cLmDFea/iaYMYfLV3oF
 tbex60UMENcpQ6JsEgPiJMVZWMlV47t3G8C8YZu/Gagn7SZBbN9wFrQD7uyJZ/kleqsL
 X7o3pX91DmXnb6CPxzCtNuMffAqLX59QEXgkk2sbJGUDu/NpOa1vyWTDKSWOroSsQSEr
 KncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693323062; x=1693927862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SDbikvrJURYSUdco/ZqIPH9U7npc2uzsUXfdoZeozoM=;
 b=J2hYBTxdiIqo4SdKnOPYrIte/+Dsio2QU7zArEV5Axr/MfgPTlyto+aH4e1TAP+Eys
 zdmmQ/AuIa84MXwCCfSqncDJmDPLLvHdw7TuMlAjg5rhO8/dD65x/AeTIAiQDslvSvdN
 vdAbZ6JOiFNhENPgroy59oBt1wQicPB9ps7ZFcXAC+y6cjOiWVjZ3nDaYWJOqXfBCwF6
 mCulJrS3LKUqLKc8+MC6y0roZf9X9O3w18KhTEa2oz1e1d0kgp8ptxRYZ+mB0YP0L47f
 rDGZ8Sm7Wjvz+YDAL44KqbK54XWjZo4OHezMHtcC7ujVYJcP7mJihPA0D/mvN80yFEvm
 sBUg==
X-Gm-Message-State: AOJu0Yx5B4MXM+BhdZynT7+lLOFlt2ttJ+IDJS5Mx/nXDZM+eXS4o4bd
 wsbD/9o5jDuJLQjccnLkZCnoL08W/vz3qVU0OQu/QTXN
X-Google-Smtp-Source: AGHT+IFCKB4y9SxFeV10FWPTH5kksVmONjZYzoHhoIEWKWdmN5QupRAObIgmodGuNflk5adm0jitkw==
X-Received: by 2002:a17:902:ce90:b0:1bf:3378:6808 with SMTP id
 f16-20020a170902ce9000b001bf33786808mr28169075plg.56.1693323061827; 
 Tue, 29 Aug 2023 08:31:01 -0700 (PDT)
Received: from localhost.localdomain ([118.114.61.244])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a170902d48f00b001bdc8a5e96csm9510282plg.169.2023.08.29.08.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 08:31:01 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Andrei Gudkov <gudkov.andrei@huawei.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: [PULL 3/3] migration/dirtyrate: Fix precision losses and g_usleep
 overshoot
Date: Tue, 29 Aug 2023 23:29:50 +0800
Message-Id: <e2ae6ed88de97b5594e64aaf2400ebabf48064ec.1693322363.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1693322363.git.yong.huang@smartx.com>
References: <cover.1693322363.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x634.google.com
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


