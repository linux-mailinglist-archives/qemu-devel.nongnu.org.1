Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AC67A2299
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 17:40:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhAuI-0003Fa-15; Fri, 15 Sep 2023 11:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qhAuD-0003FK-A9
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:38:53 -0400
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qhAuB-0007Kq-RZ
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:38:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id ACA4BB82CCA;
 Fri, 15 Sep 2023 15:38:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6E2C433C8;
 Fri, 15 Sep 2023 15:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1694792328;
 bh=2DIxnKAjYl9IN9C+NelvsaIGXF9IdMY+PnzUk012rH4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mGvaMu5LCgqB8tP7LN68JFMmDQNhei96hRjxqLdPmIpCdfjzZsqSMc6SWRLqK9gfr
 f9tW2lfwSSo8Kl5GcmbQwnqsf/l4wQFi//fTOprgT5WojJFpYbLHeRk2RixiEa3oj+
 1tgNt7xP+I6jHLwQZYa6JVEPWyIoT9jyEcCWmLcwzDjOqSvOtRHymbKbvODi4eFvyI
 GWtoq0tFii5IjY5qRvThqjfqxpmogNOjkmucTSVT3eylfem5wCtAooKubWNNQZvrVI
 Wh7/OiyBsXh9QcLCQq38c+CpHrgUJtTz2SZ5CfrLYICMKH8RZLoUKJCrySn4q5zeRq
 WcRFc3sakAHZw==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 2/6] target/hppa: Allow up to 16 BTLB entries
Date: Fri, 15 Sep 2023 17:38:37 +0200
Message-ID: <20230915153841.57564-3-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915153841.57564-1-deller@kernel.org>
References: <20230915153841.57564-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4601:e00::1;
 envelope-from=deller@kernel.org; helo=ams.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Helge Deller <deller@gmx.de>

Reserve 16 out of the 256 TLB entries for Block-TLBs.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/cpu.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index fa13694dab..23852d89b2 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -211,8 +211,14 @@ typedef struct CPUArchState {
     target_ureg shadow[7];   /* shadow registers */
 
     /* ??? The number of entries isn't specified by the architecture.  */
+#ifdef TARGET_HPPA64
+#define HPPA_BTLB_FIXED         0       /* BTLBs are not supported in 64-bit machines */
+#else
+#define HPPA_BTLB_FIXED         16
+#endif
+#define HPPA_BTLB_VARIABLE      0
 #define HPPA_TLB_ENTRIES        256
-#define HPPA_BTLB_ENTRIES       0
+#define HPPA_BTLB_ENTRIES       (HPPA_BTLB_FIXED + HPPA_BTLB_VARIABLE)
 
     /* ??? Implement a unified itlb/dtlb for the moment.  */
     /* ??? We should use a more intelligent data structure.  */
-- 
2.41.0


