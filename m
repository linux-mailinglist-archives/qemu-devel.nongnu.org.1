Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 912BC7B5D8A
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 01:07:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnRzr-0007jB-8B; Mon, 02 Oct 2023 19:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qnRzp-0007is-7p
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 19:06:37 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qnRzn-0005KR-Hi
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 19:06:36 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DA51626E2B;
 Tue,  3 Oct 2023 02:07:15 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5EDD92C463;
 Tue,  3 Oct 2023 02:06:31 +0300 (MSK)
Message-ID: <40d5dcc0-7a60-1b00-5bb4-8378a6f3a3ae@tls.msk.ru>
Date: Tue, 3 Oct 2023 02:06:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PULL v3 00/16] tricore queue
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20230929064000.536923-1-kbastian@mail.uni-paderborn.de>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230929064000.536923-1-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -91
X-Spam_score: -9.2
X-Spam_bar: ---------
X-Spam_report: (-9.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.321,
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

29.09.2023 09:39, Bastian Koppelmann:

> ----------------------------------------------------------------
> - Add FTOU, CRCN, FTOHP, and HPTOF insns
> 
> ----------------------------------------------------------------
> Changes from v2:
> - Replaced %ld with PRIu64 for patch 13
> - Dropped patches 15 - 19, as they require an updated patch series
> ----------------------------------------------------------------
> 
> Bastian Koppelmann (16):
>        tests/tcg/tricore: Bump cpu to tc37x
>        target/tricore: Implement CRCN insn
>        target/tricore: Correctly handle FPU RM from PSW
>        target/tricore: Implement FTOU insn
>        target/tricore: Clarify special case for FTOUZ insn
>        target/tricore: Implement ftohp insn
>        target/tricore: Implement hptof insn
>        target/tricore: Fix RCPW/RRPW_INSERT insns for width = 0
>        target/tricore: Swap src and dst reg for RCRR_INSERT
>        target/tricore: Replace cpu_*_code with translator_*
>        target/tricore: Fix FTOUZ being ISA v1.3.1 up
>        tests/tcg/tricore: Extended and non-extened regs now match
>        hw/tricore: Log failing test in testdevice
>        tests/tcg: Reset result register after each test
>        target/tricore: Remove CSFRs from cpu.h
>        target/tricore: Change effective address (ea) to target_ulong

Is there anything here to apply to -stable, or there's no reason to bother?
"Fix RCPW/RRPW_INSERT insns for width = 0" might be a candidate, maybe others..

Thanks,

/mjt

