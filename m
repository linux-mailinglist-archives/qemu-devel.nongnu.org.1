Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B16FE7A229B
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 17:40:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhAuK-0003HA-R2; Fri, 15 Sep 2023 11:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qhAuH-0003G6-60
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:38:57 -0400
Received: from ams.source.kernel.org ([145.40.68.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qhAuF-0007Lf-9M
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:38:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id C94E6B82CBF;
 Fri, 15 Sep 2023 15:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C21DC433C8;
 Fri, 15 Sep 2023 15:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1694792332;
 bh=18uabApz9zh2XIYQQmYt7FuxZYg+zF4yLEzyfDCWxcM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CxkuhsH5aliyWiZcc1OffMiEWiz6alO6UeEXXzaDAIMw8sArBCrxw5QgIBd5U6sOz
 Etp8PCngqLhcx38AHxTF0lizcmTJ0oRZqUHHqxkxH1wDuCmpvB0kf/hXn7XsnpSRJC
 9P3x7Dm6zz1Q/BkOanHwkstjUB6cAtS3dhvtwJEZSW1rJy3U5E2+jRTUTWysxrY4Te
 JnnYZJCIdaA5yuQ0n0tJgKfa8dFxsADQAu84wISrAbgpdfGfCv5eVFrhUl9ihrHr8N
 7ZuHfVfeBKMUQzHqc/B+/Ngx6azJnWGQtLWnH83LP8PW0MGNwiF5uz4cOLK3ljCjz9
 dzDQVCuSoDXEw==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 5/6] target/hppa: Extract diagnose immediate value
Date: Fri, 15 Sep 2023 17:38:40 +0200
Message-ID: <20230915153841.57564-6-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915153841.57564-1-deller@kernel.org>
References: <20230915153841.57564-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.68.75; envelope-from=deller@kernel.org;
 helo=ams.source.kernel.org
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
This is needed to distinguish the various diagnose calls.

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


