Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC746745670
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 09:53:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGEMV-0008Qb-VB; Mon, 03 Jul 2023 03:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>)
 id 1qGEMT-0008QN-Du; Mon, 03 Jul 2023 03:52:41 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>)
 id 1qGEMR-0000GN-Pl; Mon, 03 Jul 2023 03:52:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id F3CB2218EC;
 Mon,  3 Jul 2023 07:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1688370752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=sw5FC1Dpxo+IiL7mbUi0X6dy4I2O5iA3I4wl6RbGaTM=;
 b=LO0VZe/aKhm3Vnqs30huaHVCwDDtmjKghapV5V0PZALl4YXqjlenJCI85U3oIvRjQlzsjr
 beo+cdpSbM0tlSg1aiITV4k8ITEz0M7mjGFVu87L2S4nptBc+5KouWrfuMyAEva39TJJzl
 sQsZH8OxWj0fPT4bGfDW+Fo1KGk/fyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1688370752;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=sw5FC1Dpxo+IiL7mbUi0X6dy4I2O5iA3I4wl6RbGaTM=;
 b=RYvhmaLqXnE5YUr9eAB4IdOo7lOhLfWWJqj7bvFVEC+IgVwBH509/g0eviRhQ+lLNjw+46
 ey2RBxUPbStmQMBQ==
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by relay2.suse.de (Postfix) with ESMTP id 924F22C141;
 Mon,  3 Jul 2023 07:52:31 +0000 (UTC)
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 7D8AE4A04CB; Mon,  3 Jul 2023 09:52:31 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis
 <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>
Subject: [RISC-V] ERROR:../accel/tcg/cpu-exec.c:1028:cpu_exec_setjmp:
 assertion failed: (cpu == current_cpu)
CC: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
X-Yow: How do you explain Wayne Newton's POWER over millions?
 It's th' MOUSTACHE...  Have you ever noticed th' way it radiates
 SINCERITY, HONESTY & WARMTH?  It's a MOUSTACHE you want to take
 HOME and introduce to NANCY SINATRA!
Date: Mon, 03 Jul 2023 09:52:31 +0200
Message-ID: <mvmmt0dtosg.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=schwab@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This is a regression in 8.0.  It causes the testsuite of mold to fail:

https://build.opensuse.org/package/live_build_log/openSUSE:Factory:RISCV/mold/standard/riscv64

+ out/test/elf/riscv64/section-start/exe2
**
ERROR:../accel/tcg/cpu-exec.c:1028:cpu_exec_setjmp: assertion failed: (cpu == current_cpu)
**
ERROR:../accel/tcg/cpu-exec.c:1028:cpu_exec_setjmp: assertion failed: (cpu == current_cpu)


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

