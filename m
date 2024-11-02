Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 553599B9FEF
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Nov 2024 13:19:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7D5o-0001eF-C4; Sat, 02 Nov 2024 08:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1t7D5X-0001dl-0N
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 08:18:43 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1t7D5U-0007au-RL
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 08:18:42 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 215164E6039;
 Sat, 02 Nov 2024 13:17:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id YRg0hbojmUJH; Sat,  2 Nov 2024 13:17:34 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2C2F04E6031; Sat, 02 Nov 2024 13:17:34 +0100 (CET)
Message-Id: <cover.1730549443.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 0/2] Separate memory access logs from guest_errors
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
    philmd@linaro.org
Date: Sat, 02 Nov 2024 13:17:34 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Originally memory access logs were a debug define that then were
converted to log messages but were classified as guest_errors which
already logs misc errors. As invalid memory access logs can come from
accessing not emulated peripherals or memory areas, these often
generate a lot of messages that are better be controlled separately
from other errors to avoid obscuring those. As an example try
'qemu-system-ppc -d guest_errors' to see the problem. After this
series the actual guest error logs are easier to spot. I've tried to
submit this before but there were some people who liked the current
behaviour so now this series has another patch that preserves the old
option printing a warning to allow time to get used to the new
behaviour (which actually brings back the old behaviour when mem
access logs were a debug define). This second patch is optional if
changing the behaviour without notice is acceptable. As these are
debug switches no deprecation period is needed so the second patch
could be omitted. I leave that decision to the maintainers.

v2: Rename the option from memaccess to invalid_mem as suggested by
Peter Maydell

Regards,
BALATON Zoltan

BALATON Zoltan (2):
  log: Add separate debug option for logging invalid memory accesses
  log: Suggest using -d guest_error,invalid_mem instead of guest_errors

 docs/devel/secure-coding-practices.rst | 2 +-
 include/qemu/log.h                     | 1 +
 system/memory.c                        | 6 +++---
 system/physmem.c                       | 2 +-
 tests/avocado/smmu.py                  | 2 +-
 tests/qtest/pnv-host-i2c-test.c        | 2 +-
 util/log.c                             | 8 +++++++-
 7 files changed, 15 insertions(+), 8 deletions(-)

-- 
2.30.9


