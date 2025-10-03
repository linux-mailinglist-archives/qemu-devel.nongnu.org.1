Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBAFBB6487
	for <lists+qemu-devel@lfdr.de>; Fri, 03 Oct 2025 11:02:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4bcJ-0006vD-JE; Fri, 03 Oct 2025 04:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v4bcD-0006uS-7H
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 04:58:13 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v4bbz-0003ig-1c
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 04:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=k9SPrNZoiEkWFN4a8bx4hpPf4wqSMOW0k1fFvoIyAxk=; b=P5a+4egAfRwERGB
 AFFc9rFfdLS38GuW5eKo22VCmqVViJ3iyrU70flWhd/7G4rO5soS63OrxfZZFm27xtY6AHtRCPGgW
 CNMipgu3rE43l10s6ETL91OlISkRQObotL5FrYqhj0o9RHhZQfD0g2wl6LggIpl+l0ZKsNeF6E82L
 WM=;
Date: Fri, 3 Oct 2025 11:00:22 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, 
 richard.henderson@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
Subject: Re: [PATCH v2 09/33] target/riscv: Fix size of gpr and gprh
Message-ID: <e7aai6e3vxpapknpivx6tq4akj2g244vojlwsdettvocvke7ec@ww3fr75vf3su>
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-10-anjo@rev.ng>
 <ce7616cd-54cb-4c8b-8c34-8ef795d34eef@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce7616cd-54cb-4c8b-8c34-8ef795d34eef@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 01/10/25, Philippe Mathieu-Daudé wrote:
> On 1/10/25 09:32, Anton Johansson wrote:
> > gprh is only needed for TARGET_RISCV64 when modeling 128-bit registers,
> > fixing their size to 64 bits makes sense.
> > 
> > gpr is also fixed to 64 bits since all direct uses of env->gpr
> > correctly zero extend/truncate to/from target_ulong, meaning
> > !TARGET_RISCV64 will behave as expected.
> > 
> > We do however need to be a bit careful when mapping 64-bit fields to
> > 32-bit TCGv globals on big endian hosts.
> > 
> > Note, the cpu/rv128 VMSTATE version is bumped, breaking migration from
> > older versions.
> > 
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> >   target/riscv/cpu.h       |  4 ++--
> >   target/riscv/cpu.c       |  2 +-
> >   target/riscv/machine.c   |  8 ++++----
> >   target/riscv/translate.c | 17 +++++++++++++++--
> >   4 files changed, 22 insertions(+), 9 deletions(-)
> 
> 
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index d055ddf462..3c910e44cd 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -584,7 +584,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
> >       for (i = 0; i < 32; i++) {
> >           qemu_fprintf(f, " %-8s " TARGET_FMT_lx,
> > -                     riscv_int_regnames[i], env->gpr[i]);
> > +                     riscv_int_regnames[i], (target_ulong) env->gpr[i]);
> 
> Rebase mistake?

Yup, I'll print as u64 instead! Thanks:)

