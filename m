Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D426679E45A
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 11:55:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgMZY-00059Y-9r; Wed, 13 Sep 2023 05:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qgMZQ-00058Q-S4
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:54:06 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qgMZO-0001R7-6o
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:54:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 898F9617BA;
 Wed, 13 Sep 2023 09:53:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AEEC433C7;
 Wed, 13 Sep 2023 09:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1694598832;
 bh=6/lpOrfirEUfVTXKSHQHxiWTpri/y60+1LYS8jES0tU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JziEVOFcNArg8OgUFGJ6q0z2h+bhsPEIa+7ER7+vKHzgmPQRXvNCJq09DoEuLgRs8
 fJVDZ5djPU4ONZXMITX0vBp8hV6tZYmSxZ+uPUYC4UxtTLiL5WV6xA+BpFKRWACJq+
 2qggKMMu2ikCBVra9dHjwQa3qqYNjPDBWPsvGCTSq+S4smmb1mpwxueTy+A6kbedf5
 4zJ+/DlViYqAD5TebDY0/fBqsRBUj+/HYqBNxWIN9rjWrpLtXcOD1OUfCIdPy4kJYh
 ANWYr1g21itZxES4lgZicDW7Cfts1mhlhC3bh/dzm+mNZiJID+yHllEbvSVeMcTG7m
 CWXIP6L2s+bHg==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 5/6] target/hppa: Extract diagnose immediate value
Date: Wed, 13 Sep 2023 11:53:39 +0200
Message-ID: <20230913095340.32951-6-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913095340.32951-1-deller@kernel.org>
References: <20230913095340.32951-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
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

Extract the immediate value given by the diagnose CPU instruction.
This will be needed to distinguish the various diagnose calls.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/insns.decode | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 27341d27b2..aebe03ccfd 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -528,4 +528,4 @@ fdiv_d          001110 ..... ..... 011 ..... ... .....  @f0e_d_3
 xmpyu           001110 ..... ..... 010 .0111 .00 t:5    r1=%ra64 r2=%rb64
 
 # diag
-diag            000101 ----- ----- ---- ---- ---- ----
+diag            000101 i:26
-- 
2.41.0


