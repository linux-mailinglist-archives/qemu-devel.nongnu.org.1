Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0164719C37
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:34:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hUv-000639-82; Thu, 01 Jun 2023 08:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1q4hUr-000629-Ui; Thu, 01 Jun 2023 08:33:41 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1q4hUq-0002aK-9h; Thu, 01 Jun 2023 08:33:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D583B64405;
 Thu,  1 Jun 2023 12:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9E1C433D2;
 Thu,  1 Jun 2023 12:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685622817;
 bh=rLxj2oUWIU5RgAo0EkYZR3VP3cndRSAtSYfcni3t3Kc=;
 h=From:To:Cc:Subject:Date:From;
 b=nYF5Z1V21by5bPs50EtqopAEpDg1gywM3ihhw9V9wnckO1GZS7cCdi+cocSlYNhZk
 QeIvjhmcfTnuhGCdq3luIW05XpOK82LNXVDo56Frx1yafFx+YrdrLWqJOhW108A6kc
 CYDCO9NUsn9BnkbUzTzWRHD9bnrhhDu6NhfKM6uvyTDrnIjVumWtO0hl76xSbiBPkj
 Ul15/yFaDoVtToGn/+tCYyO+ripEH5SN+JPNGI42o2qC678kog4aUGzC/qs9DQIvTo
 OUNRm/Di6AVXudMd0d3VtOW4JsjRbVMXpQmzDuNxrLtIargm7hCzIF/ADfHEQ1fKjC
 Kc7sQBNnZHocA==
From: Ard Biesheuvel <ardb@kernel.org>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Ard Biesheuvel <ardb@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH 0/2] Implement PMULL using host intrinsics
Date: Thu,  1 Jun 2023 14:33:30 +0200
Message-Id: <20230601123332.3297404-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1613; i=ardb@kernel.org;
 h=from:subject; bh=rLxj2oUWIU5RgAo0EkYZR3VP3cndRSAtSYfcni3t3Kc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIaVigkhwtbxr169I+/0mpbotosFPEk+phHLvsHLcpbldR
 XnK9EsdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCKBqxj+Bzdt1D15h0e6RvT5
 fF+mVy/sdrALTlFjEbi3Nenf/a7Kt4wMp7hLHfOPxGzKLmuNjGYtO5nGsPu9g6mXTWh6/vF9BYn
 MAA==
X-Developer-Key: i=ardb@kernel.org; a=openpgp;
 fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=ardb@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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

Another set of RFC patches - this time for 64x64->128 polynomial
multiplication. Playing round with this on top of the AES changes I sent
out earlier this week, I noticed that the speedup is rather substantial.

PMULL is relevant for GCM encryption, which combines AES in counter mode
with GHASH, which is based on multiplication in GF(2^128). The
significance of PMULL to this encryption mode is basically why PMULL is
part of the AES crypto extension on AArch64.

Note that user emulation on a AArch64 host of x86 binaries that perform
any kind of HTTPS communication under the hood would likely benefit from
this.

Again, this approach is likely too ad-hoc, but it helps span the space
of what we might want to cover in terms of host acceleration API. (I'm
not a TCG expert, but I guess this raises the question what to cover in
helpers and what to cover using native TCG ops?)

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>

Ard Biesheuvel (2):
  target/arm: Use x86 intrinsics to implement PMULL.P64
  target/i386: Implement PCLMULQDQ using AArch64 PMULL instructions

 host/include/aarch64/host/cpuinfo.h |  1 +
 host/include/i386/host/cpuinfo.h    |  1 +
 target/arm/tcg/vec_helper.c         | 26 +++++++++++++++++++-
 target/i386/ops_sse.h               | 24 ++++++++++++++++++
 util/cpuinfo-aarch64.c              |  1 +
 util/cpuinfo-i386.c                 |  1 +
 6 files changed, 53 insertions(+), 1 deletion(-)

-- 
2.39.2


