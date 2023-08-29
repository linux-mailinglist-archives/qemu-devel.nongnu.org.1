Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 186AB78C8A7
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 17:33:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb0iE-00084C-8F; Tue, 29 Aug 2023 11:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qb0iB-00083p-Um
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 11:33:00 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qb0i9-0006mr-6T
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 11:32:59 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c1ff5b741cso6679845ad.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 08:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1693323056; x=1693927856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XppDKu9NZs7FVrVBX8oS7hGn8g76t1JDjeegSdQLlZc=;
 b=Q3QDoA/jfnA+6kHtZvZaePahJwNJQaXxbo2c6Y6hfkRVdo3fOGfL/vls6TyU0soort
 WdIwqx0Kc1VM05AuEIYoftB9EnBpqNDVIrRCaqy5DNxisiOasXatLeqiuPSt0FRJchlt
 EmvoCDftW2a6B5tGe/5zsy4+gPCVWdBN0QyCKwi+VAIYUg2HZGmXhhF6PDMXiqgFzy34
 oMKM0N4+wFVUVhqLlxAasE5HMwJ+GJI0FbMrfatpnjGGKHJ6laMcGGqQWSPjtNgCVrSe
 0vpZZXyApAkWlVDN0ujGa88Vaxp9h9z+cmOjB/ECFIfxQ0wi1p0BBgOpMmCWLwk1CDuC
 zrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693323056; x=1693927856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XppDKu9NZs7FVrVBX8oS7hGn8g76t1JDjeegSdQLlZc=;
 b=H/vw7xJd6k2y8iu5Fij/mVMJ/L/9z357rbXunkAuP90QcU/Reifr6jjxMV+aij+6s2
 lNQpnN1sS7ZyDncE4+YFMp226xiLT8rks7FRO0nc1LasMj0GphKMFscFyZxs+iASlQHB
 8QbUQiEgjeSQBjp0BGHZ+6Isdr8PavFKatWFMgyHEHxb6+U87HOa5xkY+NLNK+b3hMuH
 zeGanQcL30eTxuEM2vInPox+Iljo3vSVNVgkbPDPGqcr8F1VvmaxXcz/GpmKZdX8qSZd
 KNH1wVTcsaSsJAOn3RMiBBjG0EGC5IRtaENsxyEgCnj5W3apgD9s+r1ziz4wuiVPYQqT
 HnFg==
X-Gm-Message-State: AOJu0YzHfonZ47pfysxCe6sCRxnQGe2HBggHdXu7hiDuvc46D0nRlvE9
 3zfM8d3FLBLwm2GNGWVolwB4zxZHnTyQjZPS+ykpE9eJ
X-Google-Smtp-Source: AGHT+IEkhVgG0VABxKJQ+C1kpaa4afLdmcXC0lacb/kbT/qsoqWSXx3+bdyM8K2IhApfABrMlhuVmA==
X-Received: by 2002:a17:902:e54f:b0:1bc:61d6:5fcc with SMTP id
 n15-20020a170902e54f00b001bc61d65fccmr37389267plf.51.1693323055810; 
 Tue, 29 Aug 2023 08:30:55 -0700 (PDT)
Received: from localhost.localdomain ([118.114.61.244])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a170902d48f00b001bdc8a5e96csm9510282plg.169.2023.08.29.08.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 08:30:55 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: "alloc.young" <alloc.young@outlook.com>,
 Hyman Huang <yong.huang@smartx.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/3] softmmu/dirtylimit: Convert free to g_free
Date: Tue, 29 Aug 2023 23:29:49 +0800
Message-Id: <e8a4f343e307ac382ab1921bb9d6d55e35d13e86.1693322363.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1693322363.git.yong.huang@smartx.com>
References: <cover.1693322363.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62b.google.com
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

From: "alloc.young" <alloc.young@outlook.com>

Convert free to g_free to match g_new and g_malloc functions.

Fixes: cc2b33eab0 ("softmmu/dirtylimit: Implement vCPU dirtyrate calculation periodically")
Fixes: baa609832e ("softmmu/dirtylimit: Implement virtual CPU throttle")
Signed-off-by: alloc.young <alloc.young@outlook.com>
Reviewed-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <SA1PR11MB67604ECD85AFF34BEB3072F7F5E3A@SA1PR11MB6760.namprd11.prod.outlook.com>
Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 softmmu/dirtylimit.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/softmmu/dirtylimit.c b/softmmu/dirtylimit.c
index e3ff53b8fc..fa959d7743 100644
--- a/softmmu/dirtylimit.c
+++ b/softmmu/dirtylimit.c
@@ -100,7 +100,7 @@ static void vcpu_dirty_rate_stat_collect(void)
             stat.rates[i].dirty_rate;
     }
 
-    free(stat.rates);
+    g_free(stat.rates);
 }
 
 static void *vcpu_dirty_rate_stat_thread(void *opaque)
@@ -171,10 +171,10 @@ void vcpu_dirty_rate_stat_initialize(void)
 
 void vcpu_dirty_rate_stat_finalize(void)
 {
-    free(vcpu_dirty_rate_stat->stat.rates);
+    g_free(vcpu_dirty_rate_stat->stat.rates);
     vcpu_dirty_rate_stat->stat.rates = NULL;
 
-    free(vcpu_dirty_rate_stat);
+    g_free(vcpu_dirty_rate_stat);
     vcpu_dirty_rate_stat = NULL;
 }
 
@@ -220,10 +220,10 @@ void dirtylimit_state_initialize(void)
 
 void dirtylimit_state_finalize(void)
 {
-    free(dirtylimit_state->states);
+    g_free(dirtylimit_state->states);
     dirtylimit_state->states = NULL;
 
-    free(dirtylimit_state);
+    g_free(dirtylimit_state);
     dirtylimit_state = NULL;
 
     trace_dirtylimit_state_finalize();
-- 
2.39.1


