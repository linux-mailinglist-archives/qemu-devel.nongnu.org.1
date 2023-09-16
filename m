Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 706767A3222
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 21:33:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhb2O-00026T-Ay; Sat, 16 Sep 2023 15:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qhb2L-00025g-Tq
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 15:33:01 -0400
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qhb2A-0001vn-21
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 15:33:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 96046B830D9;
 Sat, 16 Sep 2023 19:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2F8C433C7;
 Sat, 16 Sep 2023 19:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1694892767;
 bh=18uabApz9zh2XIYQQmYt7FuxZYg+zF4yLEzyfDCWxcM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IIuvP/ybZ/RGbYNmhEpKddsZ57GCHhOyShFmKND5iiZEt+I9VOqZl4GBhZgkpTlz9
 t+RGDO1LWDOiT3YMOLOS8Gn5PQNxTlWK9N+ABSko6n8DN0fs9uAy708Z+FTT+/tohj
 DLBQLLQnqojArVBxhVOVL7AfhvMZIhCZAQhGfpcelT3ts//S+0fhxul57GK/cuRcbX
 kwHfjasKXz7p1RrR4pXWjglrxjs8U2svdb16M2F2NRr2FXxcNdoJmckF4cm+T/jlWz
 DD8zLIO+p4q3EgXmaeQofeb/9tlE4CgdXqq4z2V0+dLi270gDqW5EFMjbN6lBIbck7
 XgkW7n3ugomfQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 5/8] target/hppa: Extract diagnose immediate value
Date: Sat, 16 Sep 2023 21:32:31 +0200
Message-ID: <20230916193235.169988-6-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230916193235.169988-1-deller@kernel.org>
References: <20230916193235.169988-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4601:e00::1;
 envelope-from=deller@kernel.org; helo=ams.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


