Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6659678BE55
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 08:19:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qas39-0002mR-Jo; Tue, 29 Aug 2023 02:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qas2s-0002f0-Fc
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 02:17:48 -0400
Received: from nylar.uni-paderborn.de ([2001:638:502:c003::18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qas2o-0003V4-Fw
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 02:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NkHgSBPLheLrhxo7NLZyJfd/kS0rzwmVyjzuLLJeVho=; b=HFWON2FNCGhAVMqv9VDPtyoAGL
 GHwSG6T65Fq567p1qlcayYPKXwvBwyWMLsPWdyOQ6WBj9DtITK/AnT2QDrZYCBh4a85orNh/nQpfM
 lO3ywmqwzkJYVsi7msO1VEuurbmO/nSgJuR8Z1I2+H9Mh9Zzl2Eae816KGfy9nhM26dE=;
Date: Tue, 29 Aug 2023 08:17:30 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
	qemu-devel@nongnu.org
Subject: Re: [PATCH v2 00/48] tcg patch queue
Message-ID: <zk2esxk4l3okthx5hg3egzvgsfp5e5jugsfstmenia5vcygym4@m4ui2pj7h4pv>
References: <20230824182854.1572951-1-richard.henderson@linaro.org>
 <CAJSP0QVY=bC3i+-20ek5q5KnQPgRVavFq0DK1+4m+fhpAO5fQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QVY=bC3i+-20ek5q5KnQPgRVavFq0DK1+4m+fhpAO5fQw@mail.gmail.com>
X-IMT-Source: Extern
X-IMT-rspamd-score: 54
X-IMT-Spam-Score: 0.0 ()
X-Sophos-SenderHistory: ip=84.184.52.128, fs=17333065, da=180898917, mc=34,
 sc=0, hc=34, sp=0, fso=17333065, re=0, sd=0, hd=0
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.8.29.60617, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.8.20.602000
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
Received-SPF: pass client-ip=2001:638:502:c003::18;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=nylar.uni-paderborn.de
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

On Mon, Aug 28, 2023 at 06:52:42PM -0400, Stefan Hajnoczi wrote:
> On Thu, 24 Aug 2023 at 14:29, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > The following changes since commit 50e7a40af372ee5931c99ef7390f5d3d6fbf6ec4:
> >
> >   Merge tag 'pull-target-arm-20230824' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-08-24 10:08:33 -0400)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230823-2
> >
> > for you to fetch changes up to 4daad8d9d6b9d426beb8ce505d2164ba36ea3168:
> >
> >   tcg: spelling fixes (2023-08-24 11:22:42 -0700)
> >
> > ----------------------------------------------------------------
> > accel/*: Widen pc/saved_insn for *_sw_breakpoint
> > accel/tcg: Replace remaining target_ulong in system-mode accel
> > tcg: spelling fixes
> > tcg: Document bswap, hswap, wswap byte patterns
> > tcg: Introduce negsetcond opcodes
> > tcg: Fold deposit with zero to and
> > tcg: Unify TCG_TARGET_HAS_extr[lh]_i64_i32
> > tcg/i386: Drop BYTEH deposits for 64-bit
> > tcg/i386: Allow immediate as input to deposit
> > target/*: Use tcg_gen_negsetcond_*
>
> Hi Richard,
> I'm seeing a segfault in "make docker-test-tcg@debian-tricore-cross"
> after this pull request.

git bisect points to:

commit fc15bfb6a6bda8d4d01f1383579d385acae17c0f
Author: Anton Johansson <anjo@rev.ng>
Date:   Mon Aug 7 17:57:03 2023 +0200

    include/exec: typedef abi_ptr to vaddr in softmmu

    In system mode, abi_ptr is primarily used for representing addresses
    when accessing guest memory with cpu_[st|ld]*(). Widening it from
    target_ulong to vaddr reduces the target dependence of these functions
    and is step towards building accel/ once for system mode.

    Signed-off-by: Anton Johansson <anjo@rev.ng>
    Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
    Message-Id: <20230807155706.9580-7-anjo@rev.ng>
    Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index da10ba1433..f3ce4eb1d0 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -121,8 +121,8 @@ static inline bool guest_range_valid_untagged(abi_ulong start, abi_ulong len)
     h2g_nocheck(x); \
 })
 #else
-typedef target_ulong abi_ptr;
-#define TARGET_ABI_FMT_ptr TARGET_FMT_lx
+typedef vaddr abi_ptr;
+#define TARGET_ABI_FMT_ptr "%016" VADDR_PRIx
 #endif


Changeing typedef vaddr abi_ptr back to target_ulong fixes it.

The faulting TriCore insn is OPC1_32_BOL_ST_W_LONGOFF, that tries to write to
guest addr 0xd0000124, which is in a valid memory region.

Cheers,
Bastian

