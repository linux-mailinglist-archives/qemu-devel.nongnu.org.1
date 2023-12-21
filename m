Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B6B81B872
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 14:46:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGJN9-000765-KZ; Thu, 21 Dec 2023 08:45:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vadim.shakirov@syntacore.com>)
 id 1rGHMp-0001Hh-SH; Thu, 21 Dec 2023 06:37:31 -0500
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vadim.shakirov@syntacore.com>)
 id 1rGHMn-0001fs-4N; Thu, 21 Dec 2023 06:37:31 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com ECB3FC000F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1703158642;
 bh=UWsSM5g80aCWSESrm+bE8Ctasyo73uEzdgr6Cnt2FjI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=TU9O//hMO4KCjxDpP1NVfVjZGf3ibLiULtMwo16eR3RNIR+4L3DROHn4swdldlujc
 ChKwayedngeiqU+UP0iPxylVnrDdp0LkFlHO8GO8M7grZmFUoZFI4g+3niS4pCHEl7
 RFEQgLdJojcgP6us1743x3ztCYbgrVUdLZGC+WezdNn7VIStIPfPp9zndzVjjhKMWS
 7ywWTVQSVRTyq+6pM/SoAPRYf3qKkVxP3gFljVMirx9kqeJrVUJDtoq3nKznrwdVWz
 DFDbsmKpnuGSt3MSrehcAIZEdYPWQ1/3qehgek9nXzYRrbUD7Xiw1VH559+VsiSNxa
 x/PmSZGzTgHFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1703158642;
 bh=UWsSM5g80aCWSESrm+bE8Ctasyo73uEzdgr6Cnt2FjI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=YkSHJLWLZWDoimzvQzPjG5fX27lewLdVYFmQyM1P77qm5IF91CzaCGU2hCx/ztgET
 olZcNwphGAq6PfP4LErqvEdB9d9erYzAvM6R8Aquxzab+5uutOzGTeec3OtkxTBQwk
 VWcOMa7yK5P4vkijAaBTYaEZDpHdI0slqAZ1fxs04Q+xywJpP6z4yPDFGMwfiSO0TD
 F70BbGoK8hGGzxPVRTp+8bH3cyEQVimNXCt6oQMaRD0yVQaO3xHYtVlmbgXGn7w6pU
 zlqd8GSNVIoUH6Ph8DaOWYe1Jrwr5sagXaytQgtpat1rtcvhMqSBDTeXLe5nT0q8jx
 hrrQlcU5YrwcA==
From: Vadim Shakirov <vadim.shakirov@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: Vadim Shakirov <vadim.shakirov@syntacore.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, Bin Meng
 <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>, "Daniel Henrique
 Barboza" <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, <qemu-riscv@nongnu.org>
Subject: [PATCH 0/2] Added the ability to delegate LCOFI to VS
Date: Thu, 21 Dec 2023 14:36:26 +0300
Message-ID: <20231221113628.41038-1-vadim.shakirov@syntacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-07.corp.yadro.com (172.17.11.57) To
 S-Exch-01.corp.yadro.com (10.78.5.241)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=vadim.shakirov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 21 Dec 2023 08:45:53 -0500
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

This series of patches adds LCOFI delegation from HS-mode to VS-mode.

This possibility must be implemented, as in the AIA spec in section 6.3.2
it is indicated in table 6.1 that in the case when the hideleg bit is set,
the corresponding vsip bit is an alias to the corresponding sip bit, also
for enable registers.

Vadim Shakirov (2):
  target/riscv/csr: Rename groups of interrupts
  target/riscv/csr: Added the ability to delegate LCOFI to VS

 target/riscv/csr.c | 50 ++++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 17 deletions(-)

-- 
2.34.1


