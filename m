Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F52B7AD861
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 14:58:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkl8t-0008M6-68; Mon, 25 Sep 2023 08:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nbowler@draconx.ca>)
 id 1qkdjs-0001e6-5X
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 01:02:32 -0400
Received: from mta01.start.ca ([162.250.196.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nbowler@draconx.ca>)
 id 1qkdjq-0004mU-LM
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 01:02:31 -0400
Received: from mta01.start.ca (localhost [127.0.0.1])
 by mta01.start.ca (Postfix) with ESMTP id 18E7020760;
 Mon, 25 Sep 2023 01:02:29 -0400 (EDT)
Received: from localhost (dhcp-24-53-241-2.cable.user.start.ca [24.53.241.2])
 by mta01.start.ca (Postfix) with ESMTPS id E6AD520712;
 Mon, 25 Sep 2023 01:02:28 -0400 (EDT)
From: Nick Bowler <nbowler@draconx.ca>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 0/8] SPARC VIS fixes
Date: Mon, 25 Sep 2023 01:03:49 -0400
Message-ID: <20230925050545.30912-1-nbowler@draconx.ca>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: none client-ip=162.250.196.97; envelope-from=nbowler@draconx.ca;
 helo=mta01.start.ca
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 25 Sep 2023 08:56:43 -0400
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

I noticed that the fmul8x16 instruction did not appear to be emulated
correctly[1].  It would seem that emulation was not using a single-
precision input register like the real hardware does, but rather a
double-precision register, causing it to operate on the wrong data.

Every other VIS instruction which contains one or more single-precision
inputs and a double-precision output has the exact same problem.

A few computational problems are found and fixed by this series too.

All patches can be applied independently, except patch 2 adds some
helpers which are subsequently needed by patches 3, 4 and 5.

Emulation results are tested by manually comparing the output of a small
Linux test program on an UltraSparc II against the output of running the
same binary under qemu-sparc32plus on a ppc64le host system.

[1] https://gitlab.com/qemu-project/qemu/-/issues/1901

Nick Bowler (8):
  target/sparc: Fix VIS fmul8x16 input register.
  target/sparc: Fix VIS fmul8x16au instruction.
  target/sparc: Fix VIS fmul8x16al instruction.
  target/sparc: Fix VIS fmuld8sux16 instruction.
  target/sparc: Fix VIS fmuld8ulx16 instruction.
  target/sparc: Fix VIS fpmerge input registers.
  target/sparc: Fix VIS fexpand input register.
  target/sparc: Fix VIS subtraction instructions.

 target/sparc/helper.h     |  14 ++---
 target/sparc/translate.c  |  42 +++++++++++---
 target/sparc/vis_helper.c | 119 +++++++++++++++++++-------------------
 3 files changed, 101 insertions(+), 74 deletions(-)

-- 
2.41.0


