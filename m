Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D496F72B4A0
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 00:44:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8Tlj-0000FV-8c; Sun, 11 Jun 2023 18:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q8Tlf-0000DK-GK; Sun, 11 Jun 2023 18:42:39 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q8Tld-0004g0-L4; Sun, 11 Jun 2023 18:42:39 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 47B33748A65;
 Mon, 12 Jun 2023 00:42:30 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1945B748A64; Mon, 12 Jun 2023 00:42:30 +0200 (CEST)
Message-Id: <cover.1686522199.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 00/10] Misc clean ups to target/ppc exception handling
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 12 Jun 2023 00:42:30 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

These are some small clean ups for target/ppc/excp_helper.c trying to
make this code a bit simpler. No functional change is intended.

Regards,
BALATON Zoltan

BALATON Zoltan (10):
  target/ppc: Remove some superfluous parentheses
  target/ppc: Remove unneeded parameter from powerpc_reset_wakeup()
  target/ppc: Move common check in exception handlers to a function
  target/ppc: Use env_cpu for cpu_abort in excp_helper
  target/ppc: Change parameter of cpu_interrupt_exittb() to an env
    pointer
  target/ppc: Readability improvements in exception handlers
  target/ppd: Remove unused define
  target/ppc: Fix gen_sc to use correct nip
  target/ppc: Simplify syscall exception handlers
  target/ppc: Get CPUState in one step

 target/ppc/cpu.h         |   1 +
 target/ppc/excp_helper.c | 510 +++++++++++----------------------------
 target/ppc/helper_regs.c |  15 +-
 target/ppc/helper_regs.h |   2 +-
 target/ppc/translate.c   |   9 +-
 5 files changed, 156 insertions(+), 381 deletions(-)

-- 
2.30.9


