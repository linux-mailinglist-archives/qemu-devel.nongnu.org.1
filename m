Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AC077181B
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 03:53:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSpOy-0000R0-P9; Sun, 06 Aug 2023 21:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qSpOw-0000QS-Bk; Sun, 06 Aug 2023 21:51:18 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qSpOu-0002c2-EF; Sun, 06 Aug 2023 21:51:18 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-686e29b058cso2722722b3a.1; 
 Sun, 06 Aug 2023 18:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691373073; x=1691977873;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dpX761bxAHS5YvaG1QFHBpe6udIi7JELci9dD1Co/3g=;
 b=f1tmC7YYEYVJbvvfOmG57pvL1jJoShT4yxAGXb9bDEC19RBmp4LjFNcRlrtyNSj27y
 k4I01qiT6hpBHi8n9Q42IZAiWdtnlemmzFLet8w5/5UldMUHtUuGdcKoNj6heZwyJDCl
 U5VHXZ1lU6NYbtXugi5lPMlQysY6lBfS85/ttLcknmwnjS3kTAIBLDp2GDijBCVPILFo
 Is7KK6N84C+/UJ6XDH/OQhzSLONIxmirHU2meiUvoo/QTjsN5XOJIxPwlVYtXd6B4D/u
 lfFpk4tDZMy+lZ+klf7I9Zu/qioxeSZEnig5/3ta2jgqFDIpN/AkIxuWx2ft5FECDP33
 iGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691373073; x=1691977873;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dpX761bxAHS5YvaG1QFHBpe6udIi7JELci9dD1Co/3g=;
 b=gH3BOOeBvIblyiKt8UFXMnIAhLr89S4JSE4pduxoGjx115PhDfIfBKAbMS9yPVTlLh
 pNGagfDsibswf8ddZ4YM/HCXIjLm+9PxVEamjJO3rqpeo11aSHCNze+i/FU9LC8ed70E
 3FTeAaKCXkznkBJGtqBHtAoymdMfcJHjXfyW/9gyDekPjrhRkRfO6tk9LHO2/Yq8Q3UF
 SxqDjlKIWSc9/ir1TEqbuhHmIqFOnqGgxohWQmJblgb1c/Tbh82UGywCJoO3OH6S+iZO
 z24s47tTskHbKXsRtqaKtQFLqrXfVHdk8yGrrLNWiBFQKHRePDRmZZK/8is58YqeICZn
 eW8w==
X-Gm-Message-State: AOJu0YxVvblBd2519qxYhrVYEo9S1dE2nyMzXe+KGK3wktJMcOPKqEIa
 ajZzNYHqQK07zmp/iGrr7DezaKcCcEc=
X-Google-Smtp-Source: AGHT+IHCWZz64Oqq3zYMoCC//ppnF2OBsbZ9KjfsijbnfHqhzTB+lGasQG/KcTXwt9vbeDu0bEo82w==
X-Received: by 2002:a05:6a20:1443:b0:135:38b5:7e4e with SMTP id
 a3-20020a056a20144300b0013538b57e4emr9069336pzi.59.1691373073179; 
 Sun, 06 Aug 2023 18:51:13 -0700 (PDT)
Received: from localhost (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 je7-20020a170903264700b001b6a27dff99sm5485336plb.159.2023.08.06.18.51.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Aug 2023 18:51:12 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Aug 2023 11:51:07 +1000
Message-Id: <CULXPONUEGVE.3DID5NEWOIIPO@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
Cc: <jniethe5@gmail.com>, <qemu-ppc@nongnu.org>, <bgray@linux.ibm.com>
Subject: Re: [PATCH 7/7] tcg/ppc: Use prefixed instructions for tcg_out_goto_tb
X-Mailer: aerc 0.15.2
References: <20230804213355.294443-1-richard.henderson@linaro.org>
 <20230804213355.294443-8-richard.henderson@linaro.org>
 <CULH7KALGQKY.2AVIQQUXLTX5U@wheely>
 <a0db9ba1-31df-87ab-949e-518c72e3639a@linaro.org>
In-Reply-To: <a0db9ba1-31df-87ab-949e-518c72e3639a@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon Aug 7, 2023 at 12:13 AM AEST, Richard Henderson wrote:
> On 8/6/23 05:55, Nicholas Piggin wrote:
> > On Sat Aug 5, 2023 at 7:33 AM AEST, Richard Henderson wrote:
> >> When a direct branch is out of range, we can load the destination for
> >> the indirect branch using PLA (for 16GB worth of buffer) and PLD from
> >> the TranslationBlock for everything larger.
> >>
> >> This means the patch affects exactly one instruction: B (plus filler),
> >> PLA or PLD.  Which means we can update and execute the patch atomicall=
y.
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >>   tcg/ppc/tcg-target.c.inc | 76 ++++++++++++++++++++++++++++++--------=
--
> >>   1 file changed, 58 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> >> index 5b243b2353..47c71bb5f2 100644
> >> --- a/tcg/ppc/tcg-target.c.inc
> >> +++ b/tcg/ppc/tcg-target.c.inc
> >> @@ -2642,31 +2642,41 @@ static void tcg_out_goto_tb(TCGContext *s, int=
 which)
> >>       uintptr_t ptr =3D get_jmp_target_addr(s, which);
> >>  =20
> >>       if (USE_REG_TB) {
> >> +        /*
> >> +         * With REG_TB, we must always use indirect branching,
> >> +         * so that the branch destination and TCG_REG_TB match.
> >> +         */
> >>           ptrdiff_t offset =3D tcg_tbrel_diff(s, (void *)ptr);
> >>           tcg_out_mem_long(s, LD, LDX, TCG_REG_TB, TCG_REG_TB, offset)=
;
> >> -
> >> -        /* TODO: Use direct branches when possible. */
> >> -        set_jmp_insn_offset(s, which);
> >>           tcg_out32(s, MTSPR | RS(TCG_REG_TB) | CTR);
> >> -
> >>           tcg_out32(s, BCCTR | BO_ALWAYS);
> >>  =20
> >>           /* For the unlinked case, need to reset TCG_REG_TB.  */
> >>           set_jmp_reset_offset(s, which);
> >>           tcg_out_mem_long(s, ADDI, ADD, TCG_REG_TB, TCG_REG_TB,
> >>                            -tcg_current_code_size(s));
> >> +        return;
> >> +    }
> >> +
> >> +    if (have_isa_3_10) {
> >> +        /* Align, so that we can patch 8 bytes atomically. */
> >> +        if ((uintptr_t)s->code_ptr & 7) {
> >> +            tcg_out32(s, NOP);
> >> +        }
> >> +        set_jmp_insn_offset(s, which);
> >> +        /* Direct branch will be patched by tb_target_set_jmp_target.=
 */
> >> +        tcg_out_mls_d(s, ADDI, TCG_REG_TMP1, 0, 0, 1);
> >>       } else {
> >>           /* Direct branch will be patched by tb_target_set_jmp_target=
. */
> >> -        set_jmp_insn_offset(s, which);
> >> -        tcg_out32(s, NOP);
> >> -
> >> +        tcg_out32(s, B);
> >>           /* When branch is out of range, fall through to indirect. */
> >>           tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP1, ptr - (int16_t)p=
tr);
> >>           tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1, (int=
16_t)ptr);
> >> -        tcg_out32(s, MTSPR | RS(TCG_REG_TMP1) | CTR);
> >> -        tcg_out32(s, BCCTR | BO_ALWAYS);
> >> -        set_jmp_reset_offset(s, which);
> >>       }
> >> +
> >> +    tcg_out32(s, MTSPR | RS(TCG_REG_TMP1) | CTR);
> >> +    tcg_out32(s, BCCTR | BO_ALWAYS);
> >> +    set_jmp_reset_offset(s, which);
> >>   }
> >>  =20
> >>   void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
> >> @@ -2674,20 +2684,50 @@ void tb_target_set_jmp_target(const Translatio=
nBlock *tb, int n,
> >>   {
> >>       uintptr_t addr =3D tb->jmp_target_addr[n];
> >>       intptr_t diff =3D addr - jmp_rx;
> >> -    tcg_insn_unit insn;
> >>  =20
> >>       if (USE_REG_TB) {
> >>           return;
> >>       }
> >>  =20
> >> -    if (in_range_b(diff)) {
> >> -        insn =3D B | (diff & 0x3fffffc);
> >> -    } else {
> >> -        insn =3D NOP;
> >> -    }
> >> +    if (have_isa_3_10) {
> >> +        tcg_insn_unit insn1, insn2;
> >> +        uint64_t pair;
> >>  =20
> >> -    qatomic_set((uint32_t *)jmp_rw, insn);
> >> -    flush_idcache_range(jmp_rx, jmp_rw, 4);
> >> +        if (in_range_b(diff)) {
> >> +            insn1 =3D B | (diff & 0x3fffffc);
> >> +            insn2 =3D NOP;
> >> +        } else if (diff =3D=3D sextract64(diff, 0, 34)) {
> >> +            /* PLA tmp1, diff */
> >> +            insn1 =3D OPCD(1) | (2 << 24) | (1 << 20) | ((diff >> 16)=
 & 0x3ffff);
> >> +            insn2 =3D ADDI | TAI(TCG_REG_TMP1, 0, diff);
> >> +        } else {
> >> +            addr =3D (uintptr_t)&tb->jmp_target_addr[n];
> >> +            diff =3D addr - jmp_rx;
> >> +            tcg_debug_assert(diff =3D=3D sextract64(diff, 0, 34));
> >> +            /* PLD tmp1, diff */
> >> +            insn1 =3D OPCD(1) | (1 << 20) | ((diff >> 16) & 0x3ffff);
> >> +            insn2 =3D PLD | TAI(TCG_REG_TMP1, 0, diff);
> >> +        }
> >=20
> > B is a "patch class" word instruction as per CMODX in the ISA, which ma=
y
> > be patched to/from other instructions without a flush+isync sequence
> > betwen. So that part is okay, at least if you were just patching the B
> > word. But patching between the PLA and PLD I don't think is kosher per
> > ISA.
> >=20
> > I struggle a bit with this part of the ISA, particularly with prefix
> > instructions (it only talks about patching 4 bytes at a time).
> >=20
> > If we patch something it has to go through a patch instruction, which
> > is a direct branch, trap, or nop. I think that makes this non-trivial.
> >=20
> > It could work if you only patched between B and PLD. B->PLD would have
> > to patch the suffix word first, possibly with an interleaving sync, and
> > then the prefix. PLD->B could just patch the B word.
> >=20
> > How much would losing the PLA hurt?
>
> Really?  I can't imagine how some icache would see a torn prefixed insn g=
iven an atomic=20
> store (CMODX talks about prefixed instructions which "may be unaligned" -=
- but what if=20
> they are not?).

Good question, that might just be a case of not wanting to define and
verify it. Right now I think the way to CMODX a suffix is to patch the
prefix such that the suffix word can no longer be concurrently executed,
(e.g., with a branch or trap), then patch the suffix word, then patch a
the desired prefix word back in. I'd be almost certain it would work
correctly to patch an aligned dword insn at once, but better to go by
the book.

But there is an additional issue which is not just about torn write,
implementations that fetch an instruction more than once. The same
restriction exists for 4 byte instructions, you aren't meant to patch
an ld to an add, for example.

I don't know how much of that is historical, or whether it's just to
reduce verification space. ISTR there are some real concerns around
pipeline recovery corner cases.

> But if patching an aligned prefixed insn isn't allowed, I would patch bet=
ween B and NOP,=20
> leave the PLD alone on the fall-through path, and drop the PLA.

For now if you do that, maybe just leaving a comment that we can't
patch PLA due to CMODX restrictions, I would be less nervous about it.

I might ask about this internally, I did a few months ago have some
similar questions about problems with patching prefixes but didn't
have a good example.

Thanks,
Nick

