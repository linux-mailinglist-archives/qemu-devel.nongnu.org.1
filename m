Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A6379CE46
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 12:28:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg0cF-0008Ar-L8; Tue, 12 Sep 2023 06:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qg0c5-00088Y-0Q
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:27:21 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qg0bz-0001jE-MK
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:27:18 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 58D43210E2;
 Tue, 12 Sep 2023 13:27:03 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7334A27783;
 Tue, 12 Sep 2023 13:26:59 +0300 (MSK)
Message-ID: <a4e6217f-8d83-944d-6852-b85c276b05f4@tls.msk.ru>
Date: Tue, 12 Sep 2023 13:26:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PULL v2 00/45] riscv-to-apply queue
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230911064320.939791-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

11.09.2023 09:42, Alistair Francis:>    target/riscv: don't read CSR in riscv_csrrw_do64 (2023-09-11 11:45:55 +1000)
2 more questions about this pull-req and -stable.


commit 50f9464962fb41f04fd5f42e7ee2cb60942aba89
Author: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Date:   Thu Jul 20 10:24:23 2023 -0300

     target/riscv/cpu.c: add zmmul isa string

     zmmul was promoted from experimental to ratified in commit 6d00ffad4e95.
     Add a riscv,isa string for it.

     Fixes: 6d00ffad4e95 ("target/riscv: move zmmul out of the experimental properties")

Does this need to be picked for -stable (based on the "Fixes" tag)?
I don't know the full impact of this change (or lack thereof).


commit 4cc9f284d5971ecd8055d26ef74c23ef0be8b8f5
Author: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Date:   Sat Jul 29 11:16:18 2023 +0800

     target/riscv: Fix page_check_range use in fault-only-first

     Commit bef6f008b98(accel/tcg: Return bool from page_check_range) converts
     integer return value to bool type. However, it wrongly converted the use
     of the API in riscv fault-only-first, where page_check_range < = 0, should
     be converted to !page_check_range.

This one also catches an eye, the commit in question is in 8.1, and it is
a clear bugfix (from the patch anyway).


I probably should stop making such questions and rely more on Cc: qemu-stable@
instead. It just so happened that I had a closer look at this patchset/pullreq
while trying to cherry-pick already agreed-upon changes from there.

So far, I picked the following changes for -stable from this pullreq:

c255946e3d hw/char/riscv_htif: Fix printing of console characters on big endian hosts
058096f1c5 hw/char/riscv_htif: Fix the console syscall on big endian hosts
50f9464962 target/riscv/cpu.c: add zmmul isa string
4cc9f284d5 target/riscv: Fix page_check_range use in fault-only-first
eda633a534 target/riscv: Fix zfa fleq.d and fltq.d
e0922b73ba hw/intc: Fix upper/lower mtime write calculation
9382a9eafc hw/intc: Make rtc variable names consistent
ae7d4d625c linux-user/riscv: Use abi type for target_ucontext
9ff3140631 hw/riscv: virt: Fix riscv,pmu DT node path
3a2fc23563 target/riscv: fix satp_mode_finalize() when satp_mode.supported = 0
4e3adce124 target/riscv/pmp.c: respect mseccfg.RLB for pmpaddrX changes
a7c272df82 target/riscv: Allocate itrigger timers only once

Thanks,

/mjt

