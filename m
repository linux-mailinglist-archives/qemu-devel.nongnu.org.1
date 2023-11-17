Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7A17EF823
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 21:06:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r455p-0004Ab-NK; Fri, 17 Nov 2023 15:05:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1r455n-00049a-AS
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 15:05:31 -0500
Received: from ams.source.kernel.org ([145.40.68.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1r455l-0003im-HP
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 15:05:31 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 1DF11B81F9E;
 Fri, 17 Nov 2023 20:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99537C433C7;
 Fri, 17 Nov 2023 20:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700251527;
 bh=eAy/LFLzmaW02da1AUF0gjqMNYPnqZX0DIgT7YiUwkE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LD7GL91gGil2oXfDZC+Mg2zmtiI9zXAXwx48R6iJEkXXkeRd4juCIoLwRFQ28r70z
 Xg6l5EhwK7zJ9QMaSL+4TAffrYNG0X9iGFcx1ymSCGxZGCY5tDDV5Z4Up4jjqPJ+GX
 01TvNR7QapPchKt3zYzKeW6jpbGmXdBuLBt06FlMYdhq8WcjQ3VIxLo54fAglIakfG
 qD6sqTdl5ctHm5tU2BIEcI3GrwWq6+mW+TUaFXN4hjpJmfDODby+ofleZwGYRERdDU
 kh0BS8ZQNHruNAE3pDdAj9EtXFLBs2meaxoS92/oOX2SKGYl2jdm58Ga03kjRBW/lF
 ZGBbOlltVHQNQ==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 2/2] disas/hppa: Show hexcode of instruction along with
 disassembly
Date: Fri, 17 Nov 2023 21:05:21 +0100
Message-ID: <20231117200521.417330-3-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231117200521.417330-1-deller@kernel.org>
References: <20231117200521.417330-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.68.75; envelope-from=deller@kernel.org;
 helo=ams.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/hppa.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/disas/hppa.c b/disas/hppa.c
index dcf9a47f34..cce4f4aa37 100644
--- a/disas/hppa.c
+++ b/disas/hppa.c
@@ -1968,6 +1968,10 @@ print_insn_hppa (bfd_vma memaddr, disassemble_info *info)
 
   insn = bfd_getb32 (buffer);
 
+  info->fprintf_func(info->stream, " %02x %02x %02x %02x   ",
+                (insn >> 24) & 0xff, (insn >> 16) & 0xff,
+                (insn >>  8) & 0xff, insn & 0xff);
+
   for (i = 0; i < NUMOPCODES; ++i)
     {
       const struct pa_opcode *opcode = &pa_opcodes[i];
@@ -2826,6 +2830,6 @@ print_insn_hppa (bfd_vma memaddr, disassemble_info *info)
 	  return sizeof (insn);
 	}
     }
-  (*info->fprintf_func) (info->stream, "#%8x", insn);
+  info->fprintf_func(info->stream, "<unknown>");
   return sizeof (insn);
 }
-- 
2.41.0


