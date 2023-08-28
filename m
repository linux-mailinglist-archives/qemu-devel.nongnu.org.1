Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC3778B652
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 19:22:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qafw4-0005IQ-3v; Mon, 28 Aug 2023 13:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qafw1-0005Eq-Pi
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:21:53 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qafvz-0006fl-MH
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:21:53 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3a88c422e23so2007452b6e.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 10:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1693243190; x=1693847990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XppDKu9NZs7FVrVBX8oS7hGn8g76t1JDjeegSdQLlZc=;
 b=EhRe+RAdl841lg7KsM1NFt02GCjwnPwcFYyhvctRxvgwZq/pr80z8eVbAViS8OxIZv
 0FG1G2luXJ9r4HhvqtZmbd0eHVrjq3OZUeoYfolgv+fQUhD+38rI2b2nGYFRJunDVXBv
 Cm2XASZ3aozZQB0o9xw9ceAUYSjfUbWyymHJcdyEsLSkDi9mrx+mSMPLy4VGqkwYlEc2
 2fyy4H8/whKSe+8sWGDv8uy+GFMqpkmLCSIOFS90uUxm/O4ZlKmsZTmxpKEU4SIyb0M0
 qwQM4yqnPa7VVnYihrwVX2kJ4FBcJZ4L4repUkXJHTZT6Ak6xqU5QdohCU1cJ8hnHDea
 H+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693243190; x=1693847990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XppDKu9NZs7FVrVBX8oS7hGn8g76t1JDjeegSdQLlZc=;
 b=WyEacYh77XrJwTyJxtpEhnRTqZAevmYIbwygghaT6pTGBNk6U9XC2b9DnJQ6FJ37EM
 AioeJ3lNrMJQFTUxK8i7hgGvGzUOrF/Z3SI4nPFINoWt8FTv0fR119tk1rx5vhgEvBm+
 5ctmJlOlHKvu6YUKxOYDnf8vN45fYQYQwFR3/VkfoOt0BXlMEuxNMvgs50tsMyJXTxzg
 lngsTxbqeegZZmtv4eMasPFX7QejFqfebjahSY0yUtcEdxQMxCbSf7iH109ZsgjAOc21
 fAYjnfuCyDCkHpcubYrPM/zi/LUNWbDO42p/m2KSPxOh/4aO3B6A0zIpyPODuQVmwoeZ
 HRQQ==
X-Gm-Message-State: AOJu0YxblbnoLKltC661iT/hbdnQenf4Y0UrVFhpIeZpknnGgYCe0ZRZ
 Y2VDOFVuw7+lanuKRxUcjuYNavePlJ3FTtpp3TSQ8aRx
X-Google-Smtp-Source: AGHT+IF3YawrKouDEsK0XGHqDgdZ7Tt9G0Ci43u7ZxjxQ0yEdSiE4rJnTdqaJyK7akIEN0u9Cc4TTw==
X-Received: by 2002:a05:6808:1785:b0:3a9:6400:62cb with SMTP id
 bg5-20020a056808178500b003a9640062cbmr11474341oib.57.1693243190182; 
 Mon, 28 Aug 2023 10:19:50 -0700 (PDT)
Received: from localhost.localdomain ([118.114.61.244])
 by smtp.gmail.com with ESMTPSA id
 d23-20020a637357000000b0055c558ac4edsm7697985pgn.46.2023.08.28.10.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 10:19:49 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: "alloc.young" <alloc.young@outlook.com>,
 Hyman Huang <yong.huang@smartx.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/3] softmmu/dirtylimit: Convert free to g_free
Date: Tue, 29 Aug 2023 01:19:21 +0800
Message-Id: <1b4e2e0a33674ccfd43e1b86fc3f882e4219c1c7.1693241678.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1693241678.git.yong.huang@smartx.com>
References: <cover.1693241678.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::231;
 envelope-from=yong.huang@smartx.com; helo=mail-oi1-x231.google.com
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


