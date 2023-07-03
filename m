Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBAC745C6A
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 14:43:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGIsr-0003Z2-QE; Mon, 03 Jul 2023 08:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>)
 id 1qGIsh-0003YU-UR; Mon, 03 Jul 2023 08:42:17 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>)
 id 1qGIsg-00062g-7M; Mon, 03 Jul 2023 08:42:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 8850F1FE15;
 Mon,  3 Jul 2023 12:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1688388132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DB+LpbSBhOQXoOnxD1apCRG2sZYIV8qKUcIRz2Y16ZQ=;
 b=JYqEd3bb2OETemuZU0iq0gInLynziPZcat5BIlDQ/tamXhC7geV9LY/lI5YobHwOVKCqBJ
 Lxc8t1NJ5b4SYY2Luq+XtqM+M5L1Xc4Gs0iqS1IMkMrpQsOO/7+msr9OAcOPYWhew4CWQI
 x0/e+FjJCEjvlSsX2oWKU5VNUhTp0gI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1688388132;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DB+LpbSBhOQXoOnxD1apCRG2sZYIV8qKUcIRz2Y16ZQ=;
 b=M8OP4guAJLSzkLuaCoHrk9koS77Dt9zN+t9JxN0MlH58xD6NOIkBCj6yX5X8lGW2cPBlBp
 yo22CzYt+ZLitwAw==
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by relay2.suse.de (Postfix) with ESMTP id 100712C141;
 Mon,  3 Jul 2023 12:42:12 +0000 (UTC)
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id ECE8D4A03BD; Mon,  3 Jul 2023 14:42:11 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Helge Deller <deller@gmx.de>,  Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,  Bin Meng
 <bin.meng@windriver.com>,  qemu-riscv@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [RISC-V] ERROR:../accel/tcg/cpu-exec.c:1028:cpu_exec_setjmp:
 assertion failed: (cpu == current_cpu)
In-Reply-To: <87h6qli4au.fsf@linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Mon, 03 Jul 2023 13:08:02 +0100")
References: <mvmmt0dtosg.fsf@suse.de> <mvma5wdtdiw.fsf@suse.de>
 <87h6qli4au.fsf@linaro.org>
X-Yow: Here we are in America...  when do we collect unemployment?
Date: Mon, 03 Jul 2023 14:42:11 +0200
Message-ID: <mvm5y71tbdo.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=schwab@suse.de;
 helo=smtp-out2.suse.de
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

On Jul 03 2023, Alex Bennée wrote:

> Andreas Schwab <schwab@suse.de> writes:
>
>> On Jul 03 2023, Andreas Schwab wrote:
>>
>>> This is a regression in 8.0.  It causes the testsuite of mold to fail:
>>>
>>> https://build.opensuse.org/package/live_build_log/openSUSE:Factory:RISCV/mold/standard/riscv64
>>>
>>> + out/test/elf/riscv64/section-start/exe2
>>> **
>>> ERROR:../accel/tcg/cpu-exec.c:1028:cpu_exec_setjmp: assertion failed: (cpu == current_cpu)
>>> **
>>> ERROR:../accel/tcg/cpu-exec.c:1028:cpu_exec_setjmp: assertion failed: (cpu == current_cpu)
>>
>> This bisects down to commit 86f04735ac ("linux-user: Fix brk() to
>> release pages").  See the attached test case.
>>
>> $ ./qemu-riscv64 ../exe1
>> **
>> ERROR:../qemu/accel/tcg/cpu-exec.c:1027:cpu_exec_setjmp: assertion failed: (cpu == current_cpu)
>> Bail out! ERROR:../qemu/accel/tcg/cpu-exec.c:1027:cpu_exec_setjmp: assertion failed: (cpu == current_cpu)
>> **
>> ERROR:../qemu/accel/tcg/cpu-exec.c:1027:cpu_exec_setjmp: assertion failed: (cpu == current_cpu)
>> Bail out! ERROR:../qemu/accel/tcg/cpu-exec.c:1027:cpu_exec_setjmp: assertion failed: (cpu == current_cpu)
>
> I wonder if applying c5ffd16ba4c8fd fixes this?

No, the error still happens with current master, and reverting
86f04735ac on top of it fixes it.

> I tried to double check with the test case but I can't run it as it's a
> dynamic binary so needs an ld.so.

You can download the glibc package from
<https://download.opensuse.org/ports/riscv/tumbleweed/repo/oss/>.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

