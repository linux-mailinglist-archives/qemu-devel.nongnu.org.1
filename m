Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A16667C5073
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 12:44:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqWgk-0008BR-Iq; Wed, 11 Oct 2023 06:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWgi-00089f-61
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:43:36 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWgf-0007ep-JM
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:43:35 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-406619b53caso62326275e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 03:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697021011; x=1697625811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yf1R+Vby24DYe8++3MpeTUjuX+WlwLu5umzTar0tTFw=;
 b=YeVqIpef26BKWs8iXB1Jcni/siKmHcFUidjZE0hzSJtuYE8dwfVW+ZJeaSnO75aSi+
 Y96PeHDi0ZhrcZXs0vfVeQvhyA+rIlpRv5g6n2wdY/uqHPYV+BbpJyuJtAcpZndB5b4c
 /YGCCxA066Zsl4QG8fhQetxUwuzWRm5V54a4nQoIDBphEsi5wKKTKpjZv1qevuEEF2BN
 FxOYBM3s8yJTsB30kTlHCHBT3kO4PBG4s2qm8YRFZsqQW8FMgeKuO0ApmsFKRDFkMt/s
 ik+vMARNMB5wgkyVL8V+cnyOLZncYTOPscjt7IUf5qZxNczoTyx46T8QusEGh0zYTBkv
 IuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697021011; x=1697625811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yf1R+Vby24DYe8++3MpeTUjuX+WlwLu5umzTar0tTFw=;
 b=jmZGiA2mkXjxciOfGWbA/EjPTOLSzlSo6NljNN5XHw0CffxUhR4sk4siNaw1Q7ZJBL
 P6VU2W+G2rl+t9aKWTs8gf2Jtp9/B5VuOVFBTilKUpMKDzIpKAcdBAyejh728sn83Pgj
 vwtmxNyJx8zP2XuRER3k5jaPg50rHETCFwCgc6PmmErcciAiO60+x2LJX5WYMO++4exw
 64sZqvrZojkWuUzdNs9dNv8SSa97IRrUj9Y7HiLfJKpqAb01cX4TnOjlnR6gZOIKVTGi
 iI+pzgfspcSfLLeKJKjE1x/KlOsniLwyt7g/mexzbmmOXJgwMvfFtk5k2EGdadoJOJRh
 LSiw==
X-Gm-Message-State: AOJu0Yyn6dfO9rqhJoHtx1RMoN6Unjf2H6XqGl+RXH6MjN5y1SA8vniY
 TA2nHJdnN9vVhrUwzlGjlbw/OLzvHv7Y8P/J16Y=
X-Google-Smtp-Source: AGHT+IHB6xb2zZOxenA1oewmdAetLT1kMibYNqSlWv479VH+SIRzNsjzZPY1UcG+xGA4wNAIUuLpCw==
X-Received: by 2002:a05:600c:3546:b0:406:8496:bd8b with SMTP id
 i6-20020a05600c354600b004068496bd8bmr16283352wmq.9.1697021011485; 
 Wed, 11 Oct 2023 03:43:31 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s4-20020a5d6a84000000b00327bf4f2f14sm15126848wru.88.2023.10.11.03.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:43:31 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A2A8A1FFBE;
 Wed, 11 Oct 2023 11:33:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 23/25] contrib/plugins: fix coverity warning in cache
Date: Wed, 11 Oct 2023 11:33:27 +0100
Message-Id: <20231011103329.670525-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011103329.670525-1-alex.bennee@linaro.org>
References: <20231011103329.670525-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Coverity complains that appends_stats_line can be fed a 0 leading
to the undefined behaviour of a divide by 0.

Fixes: CID 1519044
Fixes: CID 1519047
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231009164104.369749-24-alex.bennee@linaro.org>

diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
index 4fca3edd07..9e7ade3b37 100644
--- a/contrib/plugins/cache.c
+++ b/contrib/plugins/cache.c
@@ -535,15 +535,13 @@ static void caches_free(Cache **caches)
     }
 }
 
-static void append_stats_line(GString *line, uint64_t l1_daccess,
-                              uint64_t l1_dmisses, uint64_t l1_iaccess,
-                              uint64_t l1_imisses,  uint64_t l2_access,
-                              uint64_t l2_misses)
+static void append_stats_line(GString *line,
+                              uint64_t l1_daccess, uint64_t l1_dmisses,
+                              uint64_t l1_iaccess, uint64_t l1_imisses,
+                              uint64_t l2_access, uint64_t l2_misses)
 {
-    double l1_dmiss_rate, l1_imiss_rate, l2_miss_rate;
-
-    l1_dmiss_rate = ((double) l1_dmisses) / (l1_daccess) * 100.0;
-    l1_imiss_rate = ((double) l1_imisses) / (l1_iaccess) * 100.0;
+    double l1_dmiss_rate = ((double) l1_dmisses) / (l1_daccess) * 100.0;
+    double l1_imiss_rate = ((double) l1_imisses) / (l1_iaccess) * 100.0;
 
     g_string_append_printf(line, "%-14" PRIu64 " %-12" PRIu64 " %9.4lf%%"
                            "  %-14" PRIu64 " %-12" PRIu64 " %9.4lf%%",
@@ -554,8 +552,8 @@ static void append_stats_line(GString *line, uint64_t l1_daccess,
                            l1_imisses,
                            l1_iaccess ? l1_imiss_rate : 0.0);
 
-    if (use_l2) {
-        l2_miss_rate =  ((double) l2_misses) / (l2_access) * 100.0;
+    if (l2_access && l2_misses) {
+        double l2_miss_rate =  ((double) l2_misses) / (l2_access) * 100.0;
         g_string_append_printf(line,
                                "  %-12" PRIu64 " %-11" PRIu64 " %10.4lf%%",
                                l2_access,
-- 
2.39.2


