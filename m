Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0847264E1
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 17:41:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6vHV-0001Xo-KY; Wed, 07 Jun 2023 11:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6vHT-0001XE-Al
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:41:03 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6vHR-0001zz-Mi
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:41:03 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2566ed9328eso6361706a91.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 08:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686152460; x=1688744460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jkV4dgiuSw7Bz1OcKScp/tlysTyCyTSWhxkylwg7EAE=;
 b=W1WPiae3dzEICmVdrbZpLmtmPK8BKLnhC0h2RuPjdLi5DX7dJk/TkJjfpAT7RjYTri
 dECNTI2zo/JnUQouuwPdnJ7J1HJaBP8t7M8fQlDWgDk4qf1GLJJa3sWy3/xRABwTeXvo
 Dfpwtwe/YhBIaLd6tUZV2bESfXKqU+MHpSRwav4S/K/Zi6Mj6uxxDVHdmqq0bZy99uPv
 qUznZaAePGtnGgZ3n9mqoqT9cYIBsh1asl0939wqdlVTWyqUFO5dk2SARfbpRhYjCldO
 qrIySY8FK43bAWDY3/f3Xao9cHWk+CUF49jUpAcopE+WM32A/VdCkPcwss9GJDQml8Kd
 46rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686152460; x=1688744460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jkV4dgiuSw7Bz1OcKScp/tlysTyCyTSWhxkylwg7EAE=;
 b=FxeAjjrFh2uIBD7jWtyLgYBFEcdE4xNSacUhFCOMcqC0shS1JLNLfNoPNGFj7p8sV3
 dZQ/s+Xjn/fYRHFb8Oip0LuiGNDH92evuiZkMhhGE2RGsIdirjIpZNZF8jdu+mNMSt6O
 4wTLKmtkkvOxj9KRWXHes8z9cEBD3+W0PRkzohVxgmk1jRxQOUATCSTy5HmUKoJyeD+E
 HPEm2S5i3WHv5ZdUqc+Mrk2QXrGALyxj/3Qomlm/mqUKI9pQ2zgRmxulPV6ObrkRPEev
 fxpnw/DldFrCtWOu7iSJ6e6YJVnnKOvn6yw7n3yFrTTEN3KzuLx1xuMfSpKkDdyiwHgv
 xz3w==
X-Gm-Message-State: AC+VfDw0Us8Nv0n/gdp+oZwAIiujXatEUxSng20tsW9q4yTD718UcZhy
 73/s/yHsOosjO5mLtQLhm1o4vbjnwK6l4K20lSk=
X-Google-Smtp-Source: ACHHUZ5bKahx7rVqqCOMqJL92N9QnwUzubiawLnWsR8tk2iafxoJInqCJ1krp4r1Jpj/WVf4gqdMGQ==
X-Received: by 2002:a17:90b:1916:b0:256:c3dc:dae6 with SMTP id
 mp22-20020a17090b191600b00256c3dcdae6mr5327724pjb.31.1686152460239; 
 Wed, 07 Jun 2023 08:41:00 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:f25d:ffb3:64e4:8ded])
 by smtp.gmail.com with ESMTPSA id
 o11-20020a17090a420b00b002591b957641sm1518066pjg.41.2023.06.07.08.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 08:40:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 5/5] iotests: fix 194: filter out racy postcopy-active event
Date: Wed,  7 Jun 2023 08:40:54 -0700
Message-Id: <20230607154054.625513-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607154054.625513-1-richard.henderson@linaro.org>
References: <20230607154054.625513-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

The event is racy: it will not appear in the output if bitmap is
migrated during downtime period of migration and postcopy phase is not
started.

Fixes: ae00aa239847 "iotests: 194: test also migration of dirty bitmap"
Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-Id: <20230607143606.1557395-1-vsementsov@yandex-team.ru>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/qemu-iotests/194     | 5 +++++
 tests/qemu-iotests/194.out | 1 -
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index 68894371f5..c0ce82dd25 100755
--- a/tests/qemu-iotests/194
+++ b/tests/qemu-iotests/194
@@ -74,6 +74,11 @@ with iotests.FilePath('source.img') as source_img_path, \
 
     while True:
         event1 = source_vm.event_wait('MIGRATION')
+        if event1['data']['status'] == 'postcopy-active':
+            # This event is racy, it depends do we really do postcopy or bitmap
+            # was migrated during downtime (and no data to migrate in postcopy
+            # phase). So, don't log it.
+            continue
         iotests.log(event1, filters=[iotests.filter_qmp_event])
         if event1['data']['status'] in ('completed', 'failed'):
             iotests.log('Gracefully ending the `drive-mirror` job on source...')
diff --git a/tests/qemu-iotests/194.out b/tests/qemu-iotests/194.out
index 4e6df1565a..376ed1d2e6 100644
--- a/tests/qemu-iotests/194.out
+++ b/tests/qemu-iotests/194.out
@@ -14,7 +14,6 @@ Starting migration...
 {"return": {}}
 {"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"status": "postcopy-active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 Gracefully ending the `drive-mirror` job on source...
 {"return": {}}
-- 
2.34.1


