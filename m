Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA0F731C4A
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 17:17:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9ohT-0004pv-UW; Thu, 15 Jun 2023 11:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q9ohH-0004l1-00
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 11:15:40 -0400
Received: from zuban.uni-paderborn.de ([2001:638:502:c003::17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q9ohE-0006tY-LY
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 11:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jVSr3HvaLalf5qY0mX387BhH1wZUlcm5kyKf6WIY+hA=; b=kflLrqaEo2/jMd+nu9u8cLzdvP
 7MZvILxo1uBweEqkaB7wSbwPg8pL6I+kkmihXmsLc6U8Sha9Pc7esm+FceHKsETIbCeme7XchYaf4
 Ls8j8Y1gE2ramQAMEKwolCjkrBN8vG8rlRT9ES5onl0bqCd78ThXpC4I9rrsAl8jgJCE=;
Date: Thu, 15 Jun 2023 17:15:22 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 3/4] target/tricore: Honour privilege changes on PSW write
Message-ID: <o5jdl2ahtebqt55njmugofamov7lmmizmnj2hcjcpex4nxamzz@jjqrjuq4lprs>
References: <20230614165934.1370440-1-kbastian@mail.uni-paderborn.de>
 <20230614165934.1370440-4-kbastian@mail.uni-paderborn.de>
 <293ea058-8380-0610-80f3-a0bf089245dc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <293ea058-8380-0610-80f3-a0bf089245dc@linaro.org>
X-IMT-Source: Extern
X-IMT-Spam-Score: 0.0 ()
X-IMT-rspamd-score: 4
X-IMT-rspamd-bar: /
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.6.15.150617, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.6.15.600001
X-Sophos-SenderHistory: ip=79.202.219.6, fs=687017, da=174451190, mc=82, sc=0,
 hc=82, sp=0, fso=687017, re=0, sd=0, hd=0
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
Received-SPF: pass client-ip=2001:638:502:c003::17;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=zuban.uni-paderborn.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jun 15, 2023 at 09:37:23AM +0200, Richard Henderson wrote:
> On 6/14/23 18:59, Bastian Koppelmann wrote:
> >   void helper_psw_write(CPUTriCoreState *env, uint32_t arg)
> >   {
> > +    uint32_t old_priv, new_priv;
> > +    CPUState *cs;
> > +
> > +    old_priv = extract32(env->PSW, 10, 2);
> >       psw_write(env, arg);
> > +    new_priv = extract32(env->PSW, 10, 2);
> > +
> > +    if (old_priv != new_priv) {
> > +        cs = env_cpu(env);
> > +        env->PC = env->PC + 4;
> > +        cpu_loop_exit(cs);
> > +    }
> >   }
> 
> I think you should unconditionally end the TB after write to PSW. I think
> that you should not manipulate the PC here, nor use cpu_loop_exit.
> 
> You should add
> 
> #define DISAS_EXIT         DISAS_TARGET_0
> #define DISAS_EXIT_UPDATE  DISAS_TARGET_1

ok.

> 
> > @@ -378,6 +379,7 @@ static inline void gen_mtcr(DisasContext *ctx, TCGv r1,
> >      if (ctx->priv == TRICORE_PRIV_SM) {
> >          /* since we're caching PSW make this a special case */
> >          if (offset == 0xfe04) {
> > +            gen_save_pc(ctx->base.pc_next);
> >              gen_helper_psw_write(cpu_env, r1);
> 
> Instead set ctx->base.is_jmp = DISAS_EXIT,
> 
> and in tricore_tr_tb_stop add
> 
>     case DISAS_EXIT_UPDATE:
>         gen_save_pc(ctx->base.pc_next);
>         /* fall through */
>     case DISAS_EXIT:
>         tcg_gen_exit_tb(NULL, 0);
>         break;
> 
> There are a number of places (e.g. rfe), which can then use DISAS_EXIT
> instead of issuing the exit directly.

ok.

> 
> I'll also say that there are a number of other places using tcg_gen_exit_tb
> which should instead be using tcg_gen_lookup_and_goto_ptr -- all of the
> indirect branches for instance.  I would suggest adding
> 
> #define DISAS_JUMP    DISAS_TARGET_2
> 
> to handle those, again with the code within tricore_tr_tb_stop.

I'll look into that. However, this is out of scope for this patch series.

> 
> Finally, does JLI really clobber A[11] before branching to A[a]?
> If so, this could use a comment, because it looks like a bug.

Yes, it does. A[11] is the link register (not only by convention), so it is hard
coded to save the return address to A[11]. See [1] page 29. Why does it look like a bug to you?

Thanks,
Bastian

[1] https://www.infineon.com/dgdl/Infineon-AURIX_TC3xx_Architecture_vol1-UserManual-v01_00-EN.pdf?fileId=5546d46276fb756a01771bc4c2e33bdd

