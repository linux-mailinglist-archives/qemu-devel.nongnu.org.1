Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 376377E28C8
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 16:34:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r01bC-00009G-7D; Mon, 06 Nov 2023 10:33:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r01aw-00082P-PW
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:32:57 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r01am-0004O4-Of
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:32:52 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32d834ec222so2395881f8f.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 07:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699284763; x=1699889563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nlNPCN/IoODLnyMcuMdcFvSi7ZKXsxk62aEPG2/TY9M=;
 b=ObA0z+6v0qdVJvh9S15f0K34nasikDNEw/JTvjtfFsz/xnCdQwrE29B4D+UcYERInC
 S2eqflDceoT5I6vN86JQkBSwZNnKipXjKGqPfFOcuG9XLhyez1Bz7X/0VSw6H8w9qLcj
 LmWSyphX2FmSqX608Bl2OLmtc0z1f70hmYCki7t61tphsmkMHCrouLswYuSOh87t4Hs2
 bzgQfKl2LV92I2mXGBGrSbK7eODpFQRVimM3MOlca7QjXB7s4yuYhFPBQwlzIczYRG5x
 f9NozbuqYF0onFx/oGq/oClDUnAGHvNe7KtIv1yMbekGjj56DpOKYt9vOXQ/6fDWc6t3
 0s0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699284763; x=1699889563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nlNPCN/IoODLnyMcuMdcFvSi7ZKXsxk62aEPG2/TY9M=;
 b=KYl+7/2djtXFJ4nzhEzlTPu9u4EB7kAU4fZiO1Wet/TDDbkhh8gS/a0K2AzWjXGjJv
 rW2cXXufjhBFLhZZ3p5dcrcYcAK9C8KX+Mf7quXOrnWcJiJWEOP3SiKbmDCuVwUd9PJB
 EO9MlQQb5Wtmp/lkcG22uS6yMO6oDZJgAuxOxf09FhwSZRf3V7rRNA/GQUlDKERsg0IE
 GEGPJ14erfyOEpzD4kHqSW+y7eTYyXJhGq19cp0gpDJX+ecUHXx04YSpgNr8EtlpWBoe
 B6nuiCvhHEUIWpDKe4Bb7p9NicD6LRAjPnFlev9Hane/weE7cH3kPAACN5/KJB4Jifqh
 h1wA==
X-Gm-Message-State: AOJu0YxlYqad2k5ZSIEiakcA+lsAu21e2OYUzmKkcbKM4UNI+OWHjgvh
 EWj18mWDClpENrUySRZV5ZBo13cB/nbH6+9N0qY=
X-Google-Smtp-Source: AGHT+IHddsHSh75iVtEg9kq2V7YTnM1C4B7AwdgHfSCrKfaAxxcWT6oZ7a3sZPdVH98aSY2JuFsweA==
X-Received: by 2002:a05:6000:178e:b0:32f:8d4a:efa8 with SMTP id
 e14-20020a056000178e00b0032f8d4aefa8mr18920746wrg.23.1699284763144; 
 Mon, 06 Nov 2023 07:32:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d5-20020adff2c5000000b0032da6f17ffdsm9752176wrp.38.2023.11.06.07.32.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 07:32:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/12] block/nvme: nvme_process_completion() fix bound for cid
Date: Mon,  6 Nov 2023 15:32:34 +0000
Message-Id: <20231106153238.1426649-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106153238.1426649-1-peter.maydell@linaro.org>
References: <20231106153238.1426649-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

NVMeQueuePair::reqs has length NVME_NUM_REQS, which less than
NVME_QUEUE_SIZE by 1.

Fixes: 1086e95da17050 ("block/nvme: switch to a NVMeRequest freelist")
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
Message-id: 20231017125941.810461-5-vsementsov@yandex-team.ru
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 block/nvme.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 96b3f8f2fa1..0a0a0a6b36c 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -417,9 +417,10 @@ static bool nvme_process_completion(NVMeQueuePair *q)
             q->cq_phase = !q->cq_phase;
         }
         cid = le16_to_cpu(c->cid);
-        if (cid == 0 || cid > NVME_QUEUE_SIZE) {
-            warn_report("NVMe: Unexpected CID in completion queue: %"PRIu32", "
-                        "queue size: %u", cid, NVME_QUEUE_SIZE);
+        if (cid == 0 || cid > NVME_NUM_REQS) {
+            warn_report("NVMe: Unexpected CID in completion queue: %" PRIu32
+                        ", should be within: 1..%u inclusively", cid,
+                        NVME_NUM_REQS);
             continue;
         }
         trace_nvme_complete_command(s, q->index, cid);
-- 
2.34.1


