Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 253DF7B0B3B
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 19:41:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlYWO-00057D-EY; Wed, 27 Sep 2023 13:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qlYWL-00056s-2Y
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 13:40:21 -0400
Received: from zuban.uni-paderborn.de ([2001:638:502:c003::17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qlYWG-0004g9-4u
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 13:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gTbmPtrRDuPefKAZt1TuCVngQrJ3ImAy8yEGUH+rXO0=; b=RIQwdsKklmjBg4pUTo1WtknS7r
 pBPWWQNjR2qG41lDLbz6CSr3wLziwd68POEjpVPzrZT5TQRPk9ZzBZyHIWTIpIiqRTwuV8bPkh7s3
 KWik1p5XxxgeNZG0UhuLTC2j/phr+OpJ8NlE2rkty2P5tel37dQPlRDSOEJ4WpcnVD5M=;
Date: Wed, 27 Sep 2023 19:40:04 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: Re: [PULL 00/21] tricore queue
Message-ID: <kr4ybjo6jydhx2dlfonqp5qdropwjrgjcrynaiwggpazptyfhd@xfmfnktywj46>
References: <20230927093552.493279-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927093552.493279-1-kbastian@mail.uni-paderborn.de>
X-IMT-Source: Extern
X-IMT-rspamd-score: 44
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.9.27.172717, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.9.27.602001
X-Sophos-SenderHistory: ip=79.202.213.239, fs=29046, da=183445475, mc=20, sc=0,
 hc=20, sp=0, fso=29046, re=0, sd=0, hd=0
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
Received-SPF: pass client-ip=2001:638:502:c003::17;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=zuban.uni-paderborn.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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

On Wed, Sep 27, 2023 at 11:35:31AM +0200, Bastian Koppelmann wrote:
> The following changes since commit 11a629d246e4e7785a6f0efb99bd15a32c04feda:
> 
>   Merge tag 'pull-nbd-2023-09-25' of https://repo.or.cz/qemu/ericb into staging (2023-09-26 09:04:23 -0400)
> 
> are available in the Git repository at:
> 
>   https://github.com/bkoppelmann/qemu.git tags/pull-tricore-20230927
> 
> for you to fetch changes up to 32dd1f0b4bf5f38f37434b0c8fe6c8d86e093b2b:
> 
>   target/tricore: Change effective address (ea) to target_ulong (2023-09-27 11:22:42 +0200)
> 
> ----------------------------------------------------------------
> - Add FTOU, CRCN, FTOHP, and HPTOF insns
> - Add test for arithmetic TriCore insns
> 
> ----------------------------------------------------------------
> Bastian Koppelmann (21):
>       tests/tcg/tricore: Bump cpu to tc37x
>       target/tricore: Implement CRCN insn
>       target/tricore: Correctly handle FPU RM from PSW
>       target/tricore: Implement FTOU insn
>       target/tricore: Clarify special case for FTOUZ insn
>       target/tricore: Implement ftohp insn
>       target/tricore: Implement hptof insn
>       target/tricore: Fix RCPW/RRPW_INSERT insns for width = 0
>       target/tricore: Swap src and dst reg for RCRR_INSERT
>       target/tricore: Replace cpu_*_code with translator_*
>       target/tricore: Fix FTOUZ being ISA v1.3.1 up
>       tests/tcg/tricore: Extended and non-extened regs now match
>       hw/tricore: Log failing test in testdevice
>       tests/tcg: Reset result register after each test
>       tests/tcg/tricore: Add test for all arith insns up to addx
>       tests/tcg/tricore: Add test from 'and' to 'csub'
>       tests/tcg/tricore: Add test from 'dextr' to 'lt'
>       tests/tcg/tricore: Add test from 'max' to 'shas'
>       tests/tcg/tricore: Add test from 'shuffle' to 'xor.t'
>       target/tricore: Remove CSFRs from cpu.h
>       target/tricore: Change effective address (ea) to target_ulong
> 
>  hw/tricore/tricore_testdevice.c           |   4 +
>  target/tricore/cpu.h                      | 143 +--------------
>  target/tricore/fpu_helper.c               | 111 ++++++++++++
>  target/tricore/helper.c                   |  19 +-
>  target/tricore/helper.h                   |   4 +
>  target/tricore/op_helper.c                |  79 ++++++++-
>  target/tricore/translate.c                |  56 ++++--
>  target/tricore/tricore-opcodes.h          |   3 +
>  tests/tcg/tricore/Makefile.softmmu-target |   7 +-
>  tests/tcg/tricore/asm/macros.h            | 190 +++++++++++++++++---
>  tests/tcg/tricore/asm/sas.py              |  21 +++

Don't merge this one. Somehow a file slipped in, that should not have been in
the merge. Sorry for the inconvenience. I'll respin.

Cheers,
Bastian

