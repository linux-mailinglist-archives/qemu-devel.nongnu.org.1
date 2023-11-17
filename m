Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D637EF0E9
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 11:47:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3wMV-0003r7-BP; Fri, 17 Nov 2023 05:46:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1r3wMS-0003qa-RB
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 05:46:09 -0500
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1r3wMO-0002Sh-Eg
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 05:46:08 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 32117B82036;
 Fri, 17 Nov 2023 10:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B34C433C9;
 Fri, 17 Nov 2023 10:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700217954;
 bh=GWgehUBzSM1mY7WyTs1WfeWvFv6rFZc7eNueCEaGB7k=;
 h=From:To:Cc:Subject:Date:From;
 b=N1cMvEKmrxPQnLOvA2ZKnPq2uIzOeC4WMCdB1+Wauq5hUHQPLoOM7aSoVn+KpZpt7
 CMM24RWn11nF03+/R/+LhDjhGuaKqlrUkenhCqyF4JyvBqupGZTgkLG1lc6FOIay+L
 aiSzRSeNr64yeah//XhnCh0VYFvrffzXTIb5uG9DeKmzmsfsAqFGWRP48QlEbDjop9
 wWW2kr2MvWXBPgvsCpF5UG/p3m+yWJ22sgY7qiQgqWsQzJNNdYBxscsod8Ywfvagdw
 aRHYOYFEDpJPYvy5Cg1O6neRpNQgaIkS75NiMv92gfHkfLHSs+x8rKoH7YBUl9d8CH
 yNvgz1Ql6lFng==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 0/2] HPPA64-PATCHES-for-8.2
Date: Fri, 17 Nov 2023 11:45:49 +0100
Message-ID: <20231117104551.148255-1-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4601:e00::1;
 envelope-from=deller@kernel.org; helo=ams.source.kernel.org
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

Two HPPA64 patches which I'd like to get included for 8.2.

The SHRPD patch fixes a real translation bug which then allows to boot
the 64-bit Linux kernels of the Debian-11 and Debian-12 installation CDs.

The second patch adds the instruction byte sequence to the
assembly log. This is not an actual bug fix, but it's important since
it helps a lot when trying to fix qemu translation bugs on hppa.

Helge

Helge Deller (2):
  target/hppa: Fix 64-bit SHRPD instruction
  disas/hppa: Show hexcode of instruction along with disassembly

 disas/hppa.c            | 3 +++
 target/hppa/translate.c | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.41.0


