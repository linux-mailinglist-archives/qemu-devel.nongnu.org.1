Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA726762F7B
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 10:18:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOZiC-0003qB-OL; Wed, 26 Jul 2023 04:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qOZi9-0003pi-Im
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 04:17:34 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qOZi7-0001e5-TH
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 04:17:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7C2626182F;
 Wed, 26 Jul 2023 08:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF351C433C8;
 Wed, 26 Jul 2023 08:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1690359441;
 bh=y8XDVLlLUG9TcUvhyT8tlZ6bs1bvY7y2wzACPFZTjCA=;
 h=From:To:Cc:Subject:Date:From;
 b=FYubeef0yufLZmV4Aun+6MC00fq/P1oBr8U5DWMoDUDMUpVlcWV88Za+RaUiSyvRg
 M4yzzprraY3M9tSyt+FA6gXxte9WKN5SoJFfTPPTII+lL40L5SeE+CYlN96jW99Fh5
 aqRFA8eNJ2miaBWdRAEB0lM2g2HaEs/memfBZQdRPPoE8nCaRMa3Y/4Cg/ZjMFPpaR
 h17it3xnBEa4B2IY6BtAzW9syKv6dVxDPpYU7UV3D8NYc/VSf5ljGUboVsDtf+YXp7
 fD7eEdhM4mN27JiMw0xqW2tHyQS3wpFUudbLjx9eA9cZw1eBQ/QQQ5OFicJ03AjGll
 jDuRbGrtSs5kw==
From: Ard Biesheuvel <ardb@kernel.org>
To: qemu-devel@nongnu.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [RFC PATCH] target/i386: Truncate ESP when exiting from long mode
Date: Wed, 26 Jul 2023 10:17:10 +0200
Message-Id: <20230726081710.1051126-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1847; i=ardb@kernel.org;
 h=from:subject; bh=y8XDVLlLUG9TcUvhyT8tlZ6bs1bvY7y2wzACPFZTjCA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeXAtTYX3es3wkRPhMcEruy8fnN31uzQplL/FUfT3y696
 JG0Ql22o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEwk5Dwjw6PvaydabbgzZRrT
 o/wd59zFWcX3tsqJZ9wxdxJcdK9yhhXDP6vZDArzeL6mKWbYK1kfuFma27VBbVF9cPPNPf8mrdJ
 h4gQA
X-Developer-Key: i=ardb@kernel.org; a=openpgp;
 fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=ardb@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

While working on some EFI boot changes for Linux/x86, I noticed that TCG
deviates from bare metal when it comes to how it handles the value of
the stack pointer register RSP when dropping out of long mode.

On bare metal, RSP is truncated to 32 bits, even if the code that runs
in 32-bit protected mode never uses the stack at all (and uses a long
jump rather than long return to switch back to long mode). This means
64-bit code cannot rely on RSP surviving any excursions into 32-bit
protected mode (with paging disabled).

Let's align TCG with this behavior, so that code that relies on RSP
retaining its value does not inadvertently work while bare metal does
not.

Observed on Intel Ice Lake cores.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>
Link: https://lore.kernel.org/all/20230711091453.2543622-11-ardb@kernel.org/
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
I used this patch locally to reproduce an issue that was reported on Ice
Lake but didn't trigger in my QEMU testing.

Hints welcome on where the architectural behavior is specified, and in
particular, whether or not other 64-bit GPRs can be relied upon to
preserve their full 64-bit length values.

 target/i386/helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index 89aa696c6d53d68c..a338da23a87746ed 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -149,6 +149,7 @@ void cpu_x86_update_cr0(CPUX86State *env, uint32_t new_cr0)
         env->efer &= ~MSR_EFER_LMA;
         env->hflags &= ~(HF_LMA_MASK | HF_CS64_MASK);
         env->eip &= 0xffffffff;
+        env->regs[R_ESP] &= 0xffffffff;
     }
 #endif
     env->cr[0] = new_cr0 | CR0_ET_MASK;
-- 
2.39.2


