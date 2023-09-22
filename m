Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EB77AB014
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 12:59:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjdrl-0000tc-Bh; Fri, 22 Sep 2023 06:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1qjdrh-0000t9-5s; Fri, 22 Sep 2023 06:58:30 -0400
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1qjdrf-0005zQ-3v; Fri, 22 Sep 2023 06:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TBFtYTWQF6HhILnJfbonAIbFAQ8zCaxquhaP2Tz4reU=; b=dPuVnB07yLf4Qx4Z53kyPUqSlO
 Uli6ETALqZ0XEFZDfAovj4QflFeRDmlgunbL2GbgbK0HijSd7vGC2WwKGuZqZqRdFbfpuY/zXJ//e
 EF5phcifFJGx3kt0Toii3kE55gBGI+raz48Y7oiCZeAiXDqXwAX0R6xUR+p6qdispvwxK5PqgX4Z5
 HpekLDuiZe0N5To+Kinf6j7WGWBFlVjwaq9f4mAPbSPb24/qjuu91ZUWtiHhrSiny9u/+uCfewBZH
 HbAmSCb/tziMjZPVDTRx0FVc7icakQ0ttq9Kjqn5KrN6LUgQ+G9fYnfBnYTKX8rcSRgz+CK1o0FjD
 ZspD9ymQ==;
Received: from 226.pool62-37-3.static.orange.es ([62.37.3.226] helo=zeus.local)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1qjdrR-007H9m-24; Fri, 22 Sep 2023 12:58:13 +0200
Received: from berto by zeus.local with local (Exim 4.96)
 (envelope-from <berto@igalia.com>) id 1qjdrQ-000LAE-0m;
 Fri, 22 Sep 2023 12:58:12 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH] test-throttle: don't shadow 'index' variable in
 do_test_accounting()
Date: Fri, 22 Sep 2023 12:57:42 +0200
Message-Id: <20230922105742.81317-1-berto@igalia.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Fixes build with -Wshadow=local

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 tests/unit/test-throttle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/unit/test-throttle.c b/tests/unit/test-throttle.c
index cb587e33e7..ac35d65d19 100644
--- a/tests/unit/test-throttle.c
+++ b/tests/unit/test-throttle.c
@@ -625,7 +625,7 @@ static bool do_test_accounting(bool is_ops, /* are we testing bps or ops */
     throttle_config_init(&cfg);
 
     for (i = 0; i < 3; i++) {
-        BucketType index = to_test[is_ops][i];
+        index = to_test[is_ops][i];
         cfg.buckets[index].avg = avg;
     }
 
-- 
2.39.2


