Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5E978B692
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 19:36:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qag97-0003Q5-TP; Mon, 28 Aug 2023 13:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qag94-0003Pe-PK
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:35:22 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qag92-0001Rr-Ji
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:35:22 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c0d0bf18d6so27684855ad.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 10:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1693243999; x=1693848799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XppDKu9NZs7FVrVBX8oS7hGn8g76t1JDjeegSdQLlZc=;
 b=xO5ci3WXrE20ntN//6FySZThquSz4IXemucOvV0cnhraj6i5KltP09apDW71bDBSCQ
 /zqrlaYS2OPOIb4L5gICv1S0y88XQKytxSHEPksyv+46/V9Zv1y4KjQOb9bVFI3kS8lR
 oFcocdRh/gOVb8hdTeuxRQX3iAv3perWUGmsT1PTGmLUuXqpbiVdUkl6CCynSpBCZuIh
 2etfq/+BtKLZvc4fT4XJl47gs6hD8ZgDxQQqCcj9q2UcuX/mGI9QFcu+KDAERpoH60lB
 MmlpJOSl4QClo00wTd0P7CkUBN+xuVbnHJ0jbz6qIzis4oAV0KpFnv87BaVe2VCwgoVj
 GubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693243999; x=1693848799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XppDKu9NZs7FVrVBX8oS7hGn8g76t1JDjeegSdQLlZc=;
 b=Vf8uUEigfCsIfkqEEf5wVX04fdfu1uzoOgCk3ml7JHGEvyXe8EUdpINFgrcxVYK3Oi
 ZvZQB+HQKSx/0bBgj4cMQjuo1+kdaUxTtGggGL8sFNoGdcxyUmdmucZjL5GJyKEGqL6q
 yRSnTwjSY4/tuUjvIdA46RYd/kF9WsXespYEzA9uzbxFMt098Hec6oJb2slCCPf7uJha
 A2M6gAtar8hC5Bg0jJTAwYads5hxEbh41JY6FPuv8JWS1W0lDgQ/Hzu81hTEEbknf7a4
 EVVePiR14dJA/1lmKlzz65cGsPitlKmFc385KaNe1xsFRBJKXW0eHjsoI3zde8+c84TW
 zD2g==
X-Gm-Message-State: AOJu0Yx6RcJG3NzU+v8YNoflRmqFJ2VSTjYnuPO4I/FTjbJx7v6NSlqV
 xiJffcWdZXGThfkkOjPkcwzkAGYckvPN6d3P1N8EdMr5
X-Google-Smtp-Source: AGHT+IG1gLogXRUPZuXQptOV2H9lLmAoGX6Qg50iPqeRFyZ0+z6Rin2EJwPQP0u1EIJbw+wPXJ2Jdg==
X-Received: by 2002:a17:902:e88d:b0:1c0:e630:5031 with SMTP id
 w13-20020a170902e88d00b001c0e6305031mr10302865plg.28.1693243998859; 
 Mon, 28 Aug 2023 10:33:18 -0700 (PDT)
Received: from localhost.localdomain ([118.114.61.244])
 by smtp.gmail.com with ESMTPSA id
 je1-20020a170903264100b001b80d411e5bsm7669103plb.253.2023.08.28.10.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 10:33:18 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: "alloc.young" <alloc.young@outlook.com>,
 Hyman Huang <yong.huang@smartx.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/3] softmmu/dirtylimit: Convert free to g_free
Date: Tue, 29 Aug 2023 01:32:51 +0800
Message-Id: <1b4e2e0a33674ccfd43e1b86fc3f882e4219c1c7.1693241678.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1693241678.git.yong.huang@smartx.com>
References: <cover.1693241678.git.yong.huang@smartx.com>
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


