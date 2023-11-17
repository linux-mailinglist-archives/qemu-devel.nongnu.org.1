Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF0F7EF0EA
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 11:47:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3wMT-0003qe-OV; Fri, 17 Nov 2023 05:46:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1r3wMR-0003qN-DP
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 05:46:07 -0500
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1r3wMO-0002TE-Ek
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 05:46:07 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id B3A17CE2307;
 Fri, 17 Nov 2023 10:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4B5C433CB;
 Fri, 17 Nov 2023 10:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700217957;
 bh=eMNDac8ymUVYhp0HcDOxjGXT2sMkHtpPUx0j/kuVikw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pywdx5h3+XEK7Zirdw47vJuPz/7BMM5aXNUccw9zPP4QBNZwijL1esgcHd+kTMMuV
 SkADcvbN/4JsM91g2W2bw4jck24D5pRM6B+wgy7w+c651+GfMCd96KdYgSAduyzZIH
 5dxq65iXLd93HGi4y5Bzaxu8R0uSAryqE6eh9xliQ3FGjOfwlb5XkiHMI7DCiwZIap
 cgz64hgGnRlbk015G0Li0c3blN2p0sbiCIjR9bL30q0EhhE26D/tnX5mp2euCh+ReX
 u9Hl0hoOfezz/9TrBgya4JeWXqy+vtmU2Vf+LRTHIRTwGx5LPY+IcPUZ9/1yn+xjog
 jiRHcHfNQK34A==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 2/2] disas/hppa: Show hexcode of instruction along with
 disassembly
Date: Fri, 17 Nov 2023 11:45:51 +0100
Message-ID: <20231117104551.148255-3-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231117104551.148255-1-deller@kernel.org>
References: <20231117104551.148255-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55; envelope-from=deller@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Helge Deller <deller@gmx.de>

On hppa many instructions can be expressed by different bytecodes.
To be able to debug qemu translation bugs it's therefore necessary to see the
currently executed byte codes without the need to lookup the sequence without
the full executable.
With this patch the instruction byte code is shown beside the disassembly.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 disas/hppa.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/disas/hppa.c b/disas/hppa.c
index dcf9a47f34..38fc05acc4 100644
--- a/disas/hppa.c
+++ b/disas/hppa.c
@@ -1979,6 +1979,9 @@ print_insn_hppa (bfd_vma memaddr, disassemble_info *info)
 	  if (opcode->arch == pa20w)
 	    continue;
 #endif
+	  (*info->fprintf_func) (info->stream, " %02x %02x %02x %02x   ",
+                (insn >> 24) & 0xff, (insn >> 16) & 0xff,
+                (insn >>  8) & 0xff, insn & 0xff);
 	  (*info->fprintf_func) (info->stream, "%s", opcode->name);
 
 	  if (!strchr ("cfCY?-+nHNZFIuv{", opcode->args[0]))
-- 
2.41.0


