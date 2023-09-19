Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AC67A6B64
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 21:19:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qigEt-000660-QJ; Tue, 19 Sep 2023 15:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qigEm-000619-S8
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 15:18:20 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qigEc-000860-P3
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 15:18:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5246161691;
 Tue, 19 Sep 2023 19:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A69C433C9;
 Tue, 19 Sep 2023 19:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695151089;
 bh=18uabApz9zh2XIYQQmYt7FuxZYg+zF4yLEzyfDCWxcM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RJasu5LZsLkOOhO4v7BeTKmt6Elxgdm7+sBPZCRO34W+bT7R/abcNcLvIi2StlzVX
 s0nLj7aF0csyH2ynw1ZxZJfVeEMXguEfqEOer/AJgylGvIuKllHOJd2SpcVcnDnngC
 bSAMotCIiHKDw9AyMRmJhKvcj8tuZMGY5audjdY2buxeG3q3F8YkT/k4Or8rkd08oC
 QRoGvcCuRo2DPgANP/oIg43eLUNStlgdsytLJ0t3lhJhd2z5gFJErZBdNyrz9pzK23
 tqomXCVTrn7nPAC1MYrHfumIbLrvatLTyc6rNeIm7nVhAZFeoXswrTomegCKEDJ4U4
 pe4iGv5SPHZyg==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL v2 5/8] target/hppa: Extract diagnose immediate value
Date: Tue, 19 Sep 2023 21:17:53 +0200
Message-ID: <20230919191757.98889-6-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230919191757.98889-1-deller@kernel.org>
References: <20230919191757.98889-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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


